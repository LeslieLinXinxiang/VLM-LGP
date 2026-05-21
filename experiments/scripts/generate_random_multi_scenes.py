import argparse
import json
import math
import random
from datetime import datetime, timezone
from pathlib import Path

# --- CORE LOGIC FROM ORIGINAL SCRIPT (MODIFIED FOR MULTI-SHAPE) ---

def load_target_spec(spec_path: str) -> dict:
    with open(spec_path, "r", encoding="utf-8") as f:
        return json.load(f)

def load_region_config(config_path: str) -> dict:
    with open(config_path, "r", encoding="utf-8") as f:
        cfg = json.load(f)
    # Ensure catalog has all shapes
    cfg["object_catalog"].update({
        "rectprism": {
            "shape": "ssBox",
            "size": [0.03, 0.065, 0.03, 0.001],
            "logical_tags": "is_object, is_box, is_place",
            "mass": 0.4
        },
        "long_rectprism": {
            "shape": "ssBox",
            "size": [0.03, 0.095, 0.03, 0.001],
            "logical_tags": "is_object, is_box, is_place",
            "mass": 0.6
        },
        "triangular": {
            "shape": "mesh",
            "mesh": "generated/triangular_prism.obj",
            "size": [0.03, 0.03, 0.03, 0.001], # Approximate bounding box size
            "logical_tags": "is_object, is_box",
            "mass": 0.2
        }
    })
    return cfg

def expand_counts_for_redundancy(target_counts: dict, mode: str) -> dict:
    factor = 2 if mode == "r" else 1
    return {k: int(v) * factor for k, v in target_counts.items()}

def sample_init_positions(count: int, init_regions: list, min_distance: float, max_trials: int, seed: int):
    rng = random.Random(seed)
    sampled = []
    trials = 0
    while len(sampled) < count and trials < max_trials:
        trials += 1
        region = rng.choice(init_regions)
        x = rng.uniform(region["x"][0], region["x"][1])
        y = rng.uniform(region["y"][0], region["y"][1])

        if all(math.hypot(x-p["x"], y-p["y"]) >= min_distance for p in sampled):
            yaw = rng.uniform(-180.0, 180.0)
            sampled.append({"x": x, "y": y, "yaw_deg": yaw})
    
    if len(sampled) < count:
        raise RuntimeError(f"Sampling failed: {len(sampled)}/{count}")
    return sampled

def validate_sampled_positions(objects: list, min_distance: float):
    issues = []
    for i in range(len(objects)):
        for j in range(i + 1, len(objects)):
            dx = objects[i]["x"] - objects[j]["x"]
            dy = objects[i]["y"] - objects[j]["y"]
            if math.hypot(dx, dy) < min_distance:
                issues.append(
                    f"distance violation: {i + 1} vs {j + 1} "
                    f"d={math.hypot(dx, dy):.4f} < {min_distance:.4f}"
                )
    return {
        "pass": len(issues) == 0,
        "issues": issues,
    }

def validate_scene_constraints(sampled: list, cfg: dict):
    """
    Ensure objects are within legal init regions and strictly outside the work (assembly) region.
    """
    init_regions = cfg["regions"]["init_regions"]
    work_region = cfg["regions"]["work_region"]
    
    issues = []
    for i, p in enumerate(sampled):
        x, y = p["x"], p["y"]
        
        # 1. Check if inside ANY legal init region
        in_legal = False
        for region in init_regions:
            if (region["x"][0] <= x <= region["x"][1]) and (region["y"][0] <= y <= region["y"][1]):
                in_legal = True
                break
        if not in_legal:
            issues.append(f"Obj {i+1} at ({x:.3f}, {y:.3f}) is outside all legal spawn regions.")
            
        # 2. Check if inside work region (forbidden for spawn)
        if (work_region["x"][0] <= x <= work_region["x"][1]) and (work_region["y"][0] <= y <= work_region["y"][1]):
            issues.append(f"Obj {i+1} at ({x:.3f}, {y:.3f}) is inside the forbidden work_region.")
            
    return {"pass": len(issues) == 0, "issues": issues}

def render_scene(cfg: dict, objects: list, out_path: Path, scene_id: str, mode: str):
    panda_include = Path("/home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/panda.g")

    table_slots = [
        '# Fixed placement slots on table',
        'Table_Left  (table) { Q:"t(-0.08  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }',
        'Table_Center  (table) { Q:"t(0.00  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }',
        'Table_Right (table) { Q:"t( 0.08  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }',
        'Table_Back (table) { Q:"t( 0.00  0.02 .051)", shape:ssBox, size:[.025 .025 .002 .001], color:[1 1 0 0], contact:0, logical:{ is_place } }',
        'Base_Front (table) { Q:"t( 0.00  0.18 .051)", shape:ssBox, size:[.025 .025 .002 .001], color:[1 1 0 0], contact:0, logical:{ is_place } }',
    ]
    
    lines = [
        f"# Auto-generated | {scene_id} | mode={mode}",
        "world {}",
        f"table (world) {{ shape:ssBox, size:{cfg['table']['size']}, Q:\"{cfg['table']['q']}\", color:[.3 .3 .3], contact:1, logical:{{ is_place }} }}",
        "",
        'Prefix: "l_"',
        f"Include: <{panda_include}>",
        "Prefix: False",
        f"Edit l_panda_base (table): {{ Q: \"{cfg['robot']['base_edit_q']}\" }}",
    ]
    
    for name, q in cfg["robot"]["joint_defaults"].items():
        lines.append(f"Edit {name} {{ q: {q} }}")
    
    lines.append("")
    lines.extend(table_slots)
    lines.append("")
    lines.append("")

    for i, obj in enumerate(objects):
        spec = cfg["object_catalog"][obj["type"]]
        q_expr = f"t({obj['x']:.4f} {obj['y']:.4f} {cfg['spawn']['z_center_rel_table']}) d({obj['yaw_deg']:.2f} 0 0 1)"
        
        if spec["shape"] == "mesh":
            shape_str = f"shape:mesh, mesh:\"{spec['mesh']}\""
        else:
            shape_str = f"shape:{spec['shape']}"
            
        lines.append(f"obj_{i+1:02d} (table) {{ Q:\"{q_expr}\", joint:rigid, {shape_str}, size:{spec['size']}, color:[.9 .6 .1], contact:1, mass:{spec['mass']}, logical:{{ {spec['logical_tags']} }} }}")

    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text("\n".join(lines) + "\n")

# --- MAIN EXECUTION ---

def main():
    root = Path("/home/leslie/Projects/VLM_LGP")
    cfg = load_region_config(root / "experiments/configs/cube4_region_config.json")
    
    for mag in ["4cubes", "5cubes", "6cubes", "7cubes", "8cubes"]:
        for s_idx in range(1, 6):
            s_name = f"s{s_idx:02d}"
            spec_path = root / f"experiments/configs/{mag}_{s_name}_target_spec.json"
            spec = load_target_spec(spec_path)
            
            for mode in ["nr", "r"]:
                # Generate 10 randomized trials per scenario per mode
                for trial_idx in range(1, 11):
                    counts = expand_counts_for_redundancy(spec["counts"], mode)
                    obj_list = []
                    for obj_type, n in counts.items():
                        obj_list.extend([obj_type] * n)
                    
                    seed = 1000 * int(mag[0]) + 100 * s_idx + 10 * (1 if mode=="r" else 0) + trial_idx
                    try:
                        sampled = sample_init_positions(len(obj_list), cfg["regions"]["init_regions"], 0.085, 5000, seed)
                        
                        # Apply strict region validation
                        region_checks = validate_scene_constraints(sampled, cfg)
                        if not region_checks["pass"]:
                            raise RuntimeError("; ".join(region_checks["issues"]))
                            
                        checks = validate_sampled_positions(sampled, 0.085)
                        if not checks["pass"]:
                            raise RuntimeError("; ".join(checks["issues"]))
                        final_objs = []
                        for i, p in enumerate(sampled):
                            final_objs.append({**p, "type": obj_list[i]})
                        
                        suffix = f"trial_{trial_idx:02d}_{'r' if mode=='r' else 'nr'}"
                        out_path = root / f"experiments/scenes/{mag}/{s_name}/random_trials/{suffix}.g"
                        render_scene(cfg, final_objs, out_path, f"{mag}_{s_name}", mode)
                        print(f"Generated: {out_path.relative_to(root)}")
                    except Exception as e:
                        print(f"Failed {mag}_{s_name} {mode} T{trial_idx}: {e}")

if __name__ == "__main__":
    main()
