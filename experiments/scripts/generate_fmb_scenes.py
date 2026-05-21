#!/usr/bin/env python3
import json
import math
import random
import os
import re
import select
import shutil
import subprocess
import sys
import time
from datetime import datetime, timezone
from pathlib import Path

import psutil

ROOT_DIR = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT_DIR))

from core.phase2_codegen import generate_step_files

def _load_layer_based_clustering():
    module_path = ROOT_DIR / "test/layer_based_clustering/run_layer_based_codegen.py"
    spec = importlib.util.spec_from_file_location("layer_based_codegen", str(module_path))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module.LayerBasedClustering

import importlib.util
LayerBasedClustering = _load_layer_based_clustering()

FMB_ASSETS_DIR = ROOT_DIR / "assets/fmb/new_fmb"
SCENES_OUT_DIR = ROOT_DIR / "experiments/scenes/fmb"
CONFIGS_DIR = ROOT_DIR / "experiments/configs"
LGP_OUT_DIR = ROOT_DIR / "experiments/evaluations/LGP/FMB"
VLM_BASE_DIR = ROOT_DIR / "experiments/evaluations/VLM/gemini_proposed_method/FMB"

def load_json(path):
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)

def _extract_json_from_md(md_path: Path) -> dict:
    content = md_path.read_text(encoding="utf-8")
    m = re.search(r"## FINAL_JSON_START\s*```(?:json)?\n(.*?)\n```\s*## FINAL_JSON_END", content, re.DOTALL)
    if m: return json.loads(m.group(1))
    m = re.search(r"## FINAL_JSON_START\s*(\{.*?\})\s*## FINAL_JSON_END", content, re.DOTALL)
    if m: return json.loads(m.group(1))
    return None

def get_consensus_vlm_json(vlm_scenario_dir: Path) -> dict:
    if not vlm_scenario_dir.exists(): return None
    
    trials = []
    for i in range(1, 11):
        md = vlm_scenario_dir / f"trial_{i:02d}.md"
        if md.exists():
            js = _extract_json_from_md(md)
            if js: trials.append(js)
    
    if not trials: return None
    
    # Group by identical JSON string
    counts = {}
    for t in trials:
        s = json.dumps(t, sort_keys=True)
        counts[s] = counts.get(s, 0) + 1
        
    first_s = json.dumps(trials[0], sort_keys=True)
    if counts[first_s] / len(trials) < 0.2:
        pass # The first one is bad, but we still look for a >50% consensus
        
    for s, count in counts.items():
        if count / len(trials) > 0.5:
            return json.loads(s)
            
    return None

def _run_solver(exec_dir: Path, scene_g: Path, timeout_s: int, max_mem_mb: int, collision_policy: str = "active_runtime") -> dict:
    solver = ROOT_DIR / "bin/x.exe"
    cmd = [str(solver), str(exec_dir.resolve()), str(scene_g.resolve()), f"--collision-policy={collision_policy}"]
    start = time.time()
    stdout_lines = []
    peak_mb = 0.0
    memory_exceeded = False
    timeout_hit = False

    proc = subprocess.Popen(cmd, cwd=str(ROOT_DIR / "bin"),
                            stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                            text=True, bufsize=1)
    try:
        ps_proc = psutil.Process(proc.pid)
        while True:
            if proc.poll() is not None: break
            elapsed = time.time() - start
            if elapsed > timeout_s:
                timeout_hit = True
                proc.kill()
                break
            try:
                rss = ps_proc.memory_info().rss
                for c in ps_proc.children(recursive=True):
                    try: rss += c.memory_info().rss
                    except psutil.Error: pass
                peak_mb = max(peak_mb, rss / 1024.0 / 1024.0)
                if peak_mb >= max_mem_mb:
                    memory_exceeded = True
                    proc.kill()
                    break
            except psutil.Error: pass
            
            if proc.stdout:
                ready, _, _ = select.select([proc.stdout], [], [], 0.3)
                if ready:
                    line = proc.stdout.readline()
                    if line: stdout_lines.append(line)
            else:
                time.sleep(0.3)
                
        if proc.stdout:
            rest = proc.stdout.read()
            if rest: stdout_lines.append(rest)
            
        rc = proc.returncode if proc.returncode is not None else -9
        runtime = time.time() - start
        output_state = exec_dir / "output_state.g"
        success = (rc == 0) and output_state.exists() and not memory_exceeded and not timeout_hit
        return {
            "success": success,
            "runtime_s": round(runtime, 2),
            "exit_code": rc,
            "timeout": timeout_hit,
            "memory_exceeded": memory_exceeded,
            "memory_peak_mb": round(peak_mb, 2),
            "stdout": "".join(stdout_lines),
        }
    finally:
        try: proc.kill()
        except: pass

def ensure_obj_files(shape_type: str, required_count: int) -> list:
    """Ensure there are enough sequential .obj files for the given shape_type."""
    available = []
    # Collect existing _N.obj files for the shape
    for f in os.listdir(FMB_ASSETS_DIR):
        if f.startswith(f"{shape_type}_") and f.endswith(".obj"):
            # Ensure it's just a number before .obj
            parts = f.replace(".obj", "").split("_")
            if parts[-1].isdigit():
                available.append(f)
    
    available.sort(key=lambda x: int(x.replace(".obj", "").split("_")[-1]))
    
    if not available:
        raise RuntimeError(f"No base .obj files found for {shape_type} in {FMB_ASSETS_DIR}")

    # If we have enough, return the first `required_count`
    if len(available) >= required_count:
        return [str(FMB_ASSETS_DIR / f) for f in available[:required_count]]
        
    # Otherwise, we need to duplicate
    base_obj_name = available[0]
    base_obj_path = FMB_ASSETS_DIR / base_obj_name
    base_mtl_name = base_obj_name.replace(".obj", ".mtl")
    base_mtl_path = FMB_ASSETS_DIR / base_mtl_name
    
    current_count = len(available)
    next_idx = int(available[-1].replace(".obj", "").split("_")[-1]) + 1
    
    while current_count < required_count:
        new_obj_name = f"{shape_type}_{next_idx}.obj"
        new_mtl_name = f"{shape_type}_{next_idx}.mtl"
        new_obj_path = FMB_ASSETS_DIR / new_obj_name
        new_mtl_path = FMB_ASSETS_DIR / new_mtl_name
        
        # Copy MTL if it exists
        if base_mtl_path.exists():
            shutil.copy2(base_mtl_path, new_mtl_path)
            
        # Copy OBJ and replace mtllib reference
        with open(base_obj_path, "r") as f_in, open(new_obj_path, "w") as f_out:
            for line in f_in:
                if line.startswith("mtllib "):
                    f_out.write(f"mtllib {new_mtl_name}\n")
                else:
                    f_out.write(line)
        
        print(f"    [Auto-Duplicate] Created {new_obj_name} from {base_obj_name}")
        available.append(new_obj_name)
        current_count += 1
        next_idx += 1
        
    return [str(FMB_ASSETS_DIR / f) for f in available[:required_count]]

def expand_counts_for_redundancy(target_counts: dict, mode: str) -> dict:
    factor = 2 if mode == "r" else 1
    return {k: int(v) * factor for k, v in target_counts.items()}

def sample_init_positions(count: int, init_regions: list, min_dist: float, max_trials: int, seed: int, cfg: dict):
    rng = random.Random(seed)
    sampled = []
    if not init_regions: return sampled
    
    trials = 0
    while len(sampled) < count and trials < max_trials:
        trials += 1
        region = rng.choice(init_regions)
        x = rng.uniform(region["x"][0], region["x"][1])
        y = rng.uniform(region["y"][0], region["y"][1])
        
        ok = True
        for prev in sampled:
            if math.hypot(x - prev["x"], y - prev["y"]) < min_dist:
                ok = False
                break
        
        if ok:
            yaw_deg = rng.uniform(cfg["spawn"]["yaw_min_deg"], cfg["spawn"]["yaw_max_deg"])
            sampled.append({"x": x, "y": y, "yaw_deg": yaw_deg})
            
    if len(sampled) < count:
        raise RuntimeError(f"Failed to sample {count} positions after {max_trials} trials.")
    return sampled

def generate_scene(spec: dict, cfg: dict, scene_id: str, mode: str, seed: int, out_root: Path):
    counts = expand_counts_for_redundancy(spec["counts"], mode)
    
    # Pre-allocate specific .obj files for each shape type
    shape_allocations = {}
    total_objects = 0
    for shape_type, count in counts.items():
        if count > 0:
            shape_allocations[shape_type] = ensure_obj_files(shape_type, count)
            total_objects += count
            
    # Sample positions
    sampled = sample_init_positions(
        count=total_objects,
        init_regions=cfg["regions"]["init_regions"],
        min_dist=cfg["spawn"]["min_center_distance"],
        max_trials=cfg["spawn"]["max_sampling_trials"],
        seed=seed,
        cfg=cfg
    )
    
    # Create objects list
    objects = []
    p_idx = 0
    for shape_type, paths in shape_allocations.items():
        obj_idx = 1
        for path in paths:
            pos = sampled[p_idx]
            objects.append({
                "anon_id": f"{shape_type}_{obj_idx}",
                "object_type": shape_type,
                "mesh_path": path,
                "x": pos["x"],
                "y": pos["y"],
                "yaw_deg": pos["yaw_deg"]
            })
            p_idx += 1
            obj_idx += 1
            
    # Build .g file content
    table_size = " ".join(map(str, cfg['table']['size']))
    lines = [
        f"# FMB Random Scene | {scene_id} | mode={mode}",
        "world {}",
        "",
        f"table (world) {{ shape:ssBox, size:[{table_size}], Q:\"{cfg['table']['q']}\", color:[.3 .3 .3], contact:1, logical:{{ is_place }} }}",
        "",
        "Prefix: \"l_\"",
        f"Include: <{ROOT_DIR / 'rai/test/newLGP/rai-robotModels/panda/panda.g'}>",
        "Prefix: False",
        f"Edit l_panda_base (table): {{ Q: \"{cfg['robot']['base_edit_q']}\" }}"
    ]
    
    for joint, q in cfg["robot"]["joint_defaults"].items():
        lines.append(f"Edit {joint} {{ q: {q} }}")
        
    lines.append("")
    # Base board — exact params from finalized preview scene
    base_board_q = cfg["base_board"]["q"]
    lines.append(f"base_board (table) {{ Q:\"{base_board_q}\", joint:rigid, shape:mesh, mesh:\"{FMB_ASSETS_DIR / 'base_board.obj'}\", color:[0.75 0.75 0.75 1], contact:0, mass:0.5, logical:{{ is_object, is_place }} }}")
    
    # Slots — local coords from config, relative to base_board
    slots = cfg["slots"]
    for slot_name, slot_q in slots.items():
        lines.append(f"{slot_name} (base_board) {{ Q:\"{slot_q}\", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{{ is_place }} }}")
    lines.append("")
    
    # Spawn objects
    for obj in objects:
        cat = cfg["object_catalog"][obj["object_type"]]
        z_rel = cat.get("spawn_z", 0.0625)
        yaw = obj["yaw_deg"]
        intrinsic_d = cat.get("intrinsic_d", "")
        if intrinsic_d:
            q_expr = f"t({obj['x']:.4f} {obj['y']:.4f} {z_rel}) {intrinsic_d} d({yaw:.2f} 0 0 1)"
        else:
            q_expr = f"t({obj['x']:.4f} {obj['y']:.4f} {z_rel}) d({yaw:.2f} 0 0 1)"
        if cat.get("type") == "complex":
            # Proxy
            proxy_size = " ".join(map(str, cat["proxy_size"]))
            lines.append(f"{obj['anon_id']} (table) {{ Q:\"{q_expr}\", joint:rigid, shape:{cat['proxy_shape']}, size:[{proxy_size}], color:{cat['proxy_color']}, contact:{cat['proxy_contact']}, logical:{{ {cat['proxy_logical']} }} }}")
            
            # Mesh
            lines.append(f"{obj['anon_id']}_mesh ({obj['anon_id']}) {{ Q:\"{cat['mesh_q']}\", joint:rigid, shape:mesh, mesh:\"{obj['mesh_path']}\", color:{cat['mesh_color']}, contact:{cat['mesh_contact']}, mass:{cat['mesh_mass']}, logical:{{ {cat['mesh_logical']} }} }}")
            
            # Handle
            if "handle_q" in cat:
                h_size = " ".join(map(str, cat["handle_size"]))
                lines.append(f"{obj['anon_id']}_handle ({obj['anon_id']}) {{ Q:\"{cat['handle_q']}\", shape:marker, size:[{h_size}], color:{cat['handle_color']} }}")
        else:
            # shape_2: direct mesh, no proxy
            lines.append(f"{obj['anon_id']} (table) {{ Q:\"{q_expr}\", joint:rigid, shape:mesh, mesh:\"{obj['mesh_path']}\", color:{cat['color']}, contact:1, mass:{cat['mass']}, logical:{{ {cat['logical_tags']} }} }}")
        
    # Write files
    suffix = mode
    out_dir = out_root / "random_trials"
    out_dir.mkdir(parents=True, exist_ok=True)
    
    scene_path = out_dir / f"{scene_id}_{suffix}.g"
    scene_path.write_text("\n".join(lines) + "\n", encoding="utf-8")
    
    meta = {
        "scenario_id": scene_id,
        "mode": mode,
        "seed": seed,
        "counts": counts,
        "object_total": total_objects,
        "scene_path": str(scene_path),
        "objects": objects
    }
    
    meta_path = out_dir / f"{scene_id}_{suffix}_meta.json"
    meta_path.write_text(json.dumps(meta, indent=2), encoding="utf-8")
    
    return meta

def main():
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("--timeout-s", type=int, default=300)
    parser.add_argument("--max-mem-mb", type=int, default=16000)
    parser.add_argument("--skip-existing", action="store_true")
    args = parser.parse_args()

    cfg_path = CONFIGS_DIR / "fmb_region_config.json"
    if not cfg_path.exists():
        print(f"Missing config: {cfg_path}")
        return
    cfg = load_json(cfg_path)
    
    specs = list(CONFIGS_DIR.glob("fmb_*_target_spec.json"))
    specs.sort()

    total = 0
    success = 0
    fail = 0
    skip = 0
    results_log = []
    
    for spec_file in specs:
        spec = load_json(spec_file)
        parts = spec_file.name.replace("_target_spec.json", "").split("_")
        mag = parts[1]
        scenario = parts[2]
        
        print(f"\nProcessing {mag}/{scenario}...")
        vlm_scenario_dir = VLM_BASE_DIR / mag / scenario[-3:]
        gt_json = get_consensus_vlm_json(vlm_scenario_dir)
        if not gt_json:
            print(f"  [SKIP] No VLM consensus (>50%) found in {vlm_scenario_dir}")
            continue

        clustering = LayerBasedClustering(phase1_json=gt_json, max_batch_size=2)
        try:
            plan = clustering.build_execution_plan()
        except Exception as e:
            print(f"  [ERROR] Clustering failed: {e}")
            continue
            
        out_root = SCENES_OUT_DIR / mag / scenario
        lgp_root = LGP_OUT_DIR / mag / scenario
        base_seed = 5000 + hash(scenario) % 10000
        
        for trial_idx in range(1, 11):
            scene_id = f"trial_{trial_idx:02d}"
            for mode in ["nr", "r"]:
                tag = f"{mag}/{scenario}/{scene_id}_{mode}"
                trial_work_dir = lgp_root / f"{scene_id}_{mode}"
                
                if args.skip_existing and (trial_work_dir / "lgp_split_smart" / "output_state.g").exists():
                    print(f"  [CACHED] {tag}")
                    skip += 1
                    continue
                
                mode_seed = base_seed + trial_idx * 100 + (10 if mode == "r" else 0)
                meta = generate_scene(spec, cfg, scene_id, mode, mode_seed, out_root)
                
                # Build inventory directly from generated objects!
                inventory_data = [{"logical_id": obj["anon_id"]} for obj in meta["objects"]]
                
                for lgp_mode in ["lgp_split_smart", "lgp_split_global"]:
                    mode_dir = trial_work_dir / lgp_mode
                    if mode_dir.exists(): shutil.rmtree(mode_dir)
                    mode_dir.mkdir(parents=True, exist_ok=True)
                    
                    policy = "active_runtime" if lgp_mode == "lgp_split_smart" else "follow_lgp"
                    coll_mode = "smart" if lgp_mode == "lgp_split_smart" else "global"
                    
                    try:
                        generate_step_files(
                            phase1_json=gt_json,
                            prompt1_output=plan["prompt1"],
                            prompt2_output=plan["prompt2"],
                            out_dir=str(mode_dir),
                            inventory_data=inventory_data,
                            collision_mode=coll_mode
                        )
                        
                        scene_g = Path(meta["scene_path"])
                        res = _run_solver(exec_dir=mode_dir, scene_g=scene_g, timeout_s=args.timeout_s, max_mem_mb=args.max_mem_mb, collision_policy=policy)
                        (mode_dir / "solver_stdout.log").write_text(res.pop("stdout"), encoding="utf-8")
                        
                        ok = res.get("success", False)
                        if ok: success += 1
                        else: fail += 1
                        total += 1
                        
                        status = "✓" if ok else "✗"
                        print(f"  {status} [{lgp_mode}] {tag} success={ok} runtime={res.get('runtime_s', 0):.1f}s")
                        
                        res_meta = {"tag": tag, "vlm_gt": gt_json, "scene_g": str(scene_g), "mode": lgp_mode, **res}
                        (mode_dir / "trial_meta.json").write_text(json.dumps(res_meta, indent=2), encoding="utf-8")
                        results_log.append(res_meta)
                        
                    except Exception as e:
                        print(f"  [ERROR] LGP pipeline failed for {tag}: {e}")
                        fail += 1
                        total += 1

    print(f"\n{'='*60}")
    print(f"DONE. Total={total}  Success={success}  Fail={fail}  Skipped={skip}")
    
    agg_path = LGP_OUT_DIR / "batch_results.json"
    agg_path.parent.mkdir(parents=True, exist_ok=True)
    agg_path.write_text(json.dumps({"total": total, "success": success, "fail": fail, "skip": skip, "results": results_log}, indent=2), encoding="utf-8")
    print(f"Aggregate saved: {agg_path}")

if __name__ == "__main__":
    main()
