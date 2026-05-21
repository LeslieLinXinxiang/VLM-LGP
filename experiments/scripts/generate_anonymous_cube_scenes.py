#!/usr/bin/env python3
import argparse
import json
import math
import random
from datetime import datetime, timezone
from pathlib import Path


def load_target_spec(spec_path: str) -> dict:
    with open(spec_path, "r", encoding="utf-8") as f:
        return json.load(f)


def load_region_config(config_path: str) -> dict:
    with open(config_path, "r", encoding="utf-8") as f:
        return json.load(f)


def expand_counts_for_redundancy(target_counts: dict, mode: str) -> dict:
    factor = 2 if mode == "r" else 1
    return {k: int(v) * factor for k, v in target_counts.items()}


def _area_of_region(region: dict) -> float:
    return max(0.0, float(region["x"][1] - region["x"][0])) * max(0.0, float(region["y"][1] - region["y"][0]))


def _pick_region_weighted(rng: random.Random, regions: list) -> dict:
    areas = [_area_of_region(r) for r in regions]
    total = sum(areas)
    if total <= 0.0:
        return rng.choice(regions)

    ticket = rng.uniform(0.0, total)
    accum = 0.0
    for region, area in zip(regions, areas):
        accum += area
        if ticket <= accum:
            return region
    return regions[-1]


def sample_init_positions(
    count: int,
    init_regions: list,
    min_distance: float,
    max_trials: int,
    seed: int,
    yaw_min_deg: float,
    yaw_max_deg: float,
):
    rng = random.Random(seed)
    sampled = []
    if not init_regions:
        raise ValueError("init_regions must not be empty")

    trials = 0
    while len(sampled) < count and trials < max_trials:
        trials += 1
        region = _pick_region_weighted(rng, init_regions)
        x_min, x_max = region["x"]
        y_min, y_max = region["y"]
        x = rng.uniform(x_min, x_max)
        y = rng.uniform(y_min, y_max)

        ok = True
        for prev in sampled:
            dx = x - prev["x"]
            dy = y - prev["y"]
            if math.hypot(dx, dy) < min_distance:
                ok = False
                break

        if ok:
            yaw_deg = rng.uniform(yaw_min_deg, yaw_max_deg)
            sampled.append({"x": x, "y": y, "yaw_deg": yaw_deg, "spawn_region": region.get("name", "unnamed")})

    if len(sampled) != count:
        raise RuntimeError(
            f"Sampling failed: requested={count}, sampled={len(sampled)}, trials={trials}. "
            "Increase init_region or decrease min_center_distance."
        )

    return sampled


def assign_anonymous_ids(objects: list) -> list:
    out = []
    for idx, item in enumerate(objects, start=1):
        copied = dict(item)
        copied["anon_id"] = f"obj_{idx:02d}"
        out.append(copied)
    return out


def _fmt_float(v: float) -> str:
    return f"{v:.4f}".rstrip("0").rstrip(".")


def render_scene_from_config(region_cfg: dict, objects: list, output_g_path: str, scenario_id: str, mode: str):
    repo_root = Path(__file__).resolve().parents[2]
    panda_include = repo_root / "rai" / "test" / "newLGP" / "rai-robotModels" / "panda" / "panda.g"

    table_q = region_cfg["table"]["q"]
    table_size = region_cfg["table"]["size"]
    base_q = region_cfg["robot"]["base_edit_q"]
    joints = region_cfg["robot"]["joint_defaults"]
    catalog = region_cfg["object_catalog"]
    z_rel = float(region_cfg["spawn"]["z_center_rel_table"])

    work_x = region_cfg["regions"]["work_region"]["x"]
    work_y = region_cfg["regions"]["work_region"]["y"]
    init_regions = region_cfg["regions"].get("init_regions") or [region_cfg["regions"]["init_region"]]

    lines = []
    lines.append(f"# Auto-generated anonymous scene | {scenario_id} | mode={mode}")
    lines.append("world {}")
    lines.append("")
    lines.append(
        "table (world) { shape:ssBox, size:[" +
        f"{table_size[0]} {table_size[1]} {table_size[2]} {table_size[3]}" +
        f"], Q:\"{table_q}\", color:[.3 .3 .3], contact:1, logical:{{ is_place }} }}"
    )
    lines.append("")
    lines.append('Prefix: "l_"')
    lines.append(f"Include: <{panda_include}>")
    lines.append("Prefix: False")
    lines.append(f"Edit l_panda_base (table): {{ Q: \"{base_q}\" }}")
    for joint_name, joint_q in joints.items():
        lines.append(f"Edit {joint_name} {{ q: {joint_q} }}")

    lines.append("")
    lines.append(f"# work_region x={work_x}, y={work_y}")
    for idx, r in enumerate(init_regions, start=1):
        rname = r.get("name", f"init_region_{idx}")
        lines.append(f"# {rname} x={r['x']}, y={r['y']}")
    lines.extend(table_slots)
    lines.append("")

    for obj in objects:
        obj_type = obj["object_type"]
        spec = catalog[obj_type]
        size = spec["size"]
        yaw_deg = float(obj.get("yaw_deg", 0.0))
        q_expr = (
            f"t({_fmt_float(obj['x'])} {_fmt_float(obj['y'])} {_fmt_float(z_rel)}) "
            f"d({_fmt_float(yaw_deg)} 0 0 1)"
        )
        line = (
            f"{obj['anon_id']} (table) {{ Q:\"{q_expr}\", joint:rigid, shape:{spec['shape']}, "
            f"size:[{size[0]} {size[1]} {size[2]} {size[3]}], color:[.9 .6 .1], "
            f"contact:1, mass:{spec['mass']}, logical:{{ {spec['logical_tags']} }} }}"
        )
        lines.append(line)

    out_path = Path(output_g_path)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def validate_scene_constraints(objects: list, region_cfg: dict) -> dict:
    init_regions = region_cfg["regions"].get("init_regions") or [region_cfg["regions"]["init_region"]]
    work_region = region_cfg["regions"]["work_region"]
    min_dist = float(region_cfg["spawn"]["min_center_distance"])

    issues = []
    for obj in objects:
        x, y = obj["x"], obj["y"]
        in_any_init = False
        for region in init_regions:
            if (region["x"][0] <= x <= region["x"][1]) and (region["y"][0] <= y <= region["y"][1]):
                in_any_init = True
                break
        if not in_any_init:
            issues.append(f"{obj['anon_id']} outside all init_regions")
        in_work_x = work_region["x"][0] <= x <= work_region["x"][1]
        in_work_y = work_region["y"][0] <= y <= work_region["y"][1]
        if in_work_x and in_work_y:
            issues.append(f"{obj['anon_id']} unexpectedly inside work_region")

    for i in range(len(objects)):
        for j in range(i + 1, len(objects)):
            dx = objects[i]["x"] - objects[j]["x"]
            dy = objects[i]["y"] - objects[j]["y"]
            d = math.hypot(dx, dy)
            if d < min_dist:
                issues.append(f"distance violation: {objects[i]['anon_id']} vs {objects[j]['anon_id']} d={d:.4f}")

    return {
        "pass": len(issues) == 0,
        "issues": issues,
    }


def write_scene_meta(meta_path: str, payload: dict) -> None:
    path = Path(meta_path)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(payload, indent=2, ensure_ascii=True) + "\n", encoding="utf-8")


def append_registry(registry_path: str, row: dict) -> None:
    path = Path(registry_path)
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("a", encoding="utf-8") as f:
        f.write(json.dumps(row, ensure_ascii=True) + "\n")


def build_scene(spec: dict, cfg: dict, scene_id: str, mode: str, seed: int, out_root: Path):
    counts = expand_counts_for_redundancy(spec["counts"], mode)
    cube_count = int(counts.get("cube", 0))
    init_regions = cfg["regions"].get("init_regions")
    if not init_regions:
        init_regions = [cfg["regions"]["init_region"]]

    sampled = sample_init_positions(
        count=cube_count,
        init_regions=init_regions,
        min_distance=float(cfg["spawn"]["min_center_distance"]),
        max_trials=int(cfg["spawn"].get("max_sampling_trials", 5000)),
        seed=seed,
        yaw_min_deg=float(cfg["spawn"].get("yaw_min_deg", -180.0)),
        yaw_max_deg=float(cfg["spawn"].get("yaw_max_deg", 180.0)),
    )

    objects = [
        {
            "object_type": "cube",
            "x": p["x"],
            "y": p["y"],
            "yaw_deg": p["yaw_deg"],
            "spawn_region": p.get("spawn_region", "unknown"),
        }
        for p in sampled
    ]
    objects = assign_anonymous_ids(objects)

    suffix = "nr" if mode == "nr" else "r"
    subdir = "without_redundancy" if mode == "nr" else "with_redundancy"
    scene_path = out_root / subdir / f"{scene_id}_{suffix}.g"

    render_scene_from_config(cfg, objects, str(scene_path), scenario_id=scene_id, mode=mode)
    checks = validate_scene_constraints(objects, cfg)

    meta = {
        "scenario_id": scene_id,
        "mode": mode,
        "seed": seed,
        "image_path": spec.get("image_path", ""),
        "counts": counts,
        "object_total": len(objects),
        "scene_path": str(scene_path),
        "constraints": checks,
        "objects": objects,
        "timestamp_utc": datetime.now(timezone.utc).isoformat(),
    }

    meta_path = out_root / "meta" / f"{scene_id}_{suffix}_meta.json"
    write_scene_meta(str(meta_path), meta)

    registry_row = {
        "scenario_id": scene_id,
        "mode": mode,
        "seed": seed,
        "image_path": spec.get("image_path", ""),
        "counts": counts,
        "object_total": len(objects),
        "scene_path": str(scene_path),
        "meta_path": str(meta_path),
        "constraint_pass": checks["pass"],
    }
    append_registry(str(out_root / "meta" / "cube4_registry.jsonl"), registry_row)

    return meta


def write_execution_report(out_root: Path, metas: list):
    lines = []
    lines.append("# Cube4 Anonymous Scene Generation Report")
    lines.append("")
    lines.append("- Goal: Generate paired anonymous scenes for no-redundancy and redundancy modes.")
    lines.append("- Constraint: Keep all spawned objects in init_region and outside work_region.")
    lines.append("")
    lines.append("## Outputs")
    lines.append("")
    for m in metas:
        lines.append(f"- {m['mode']}: {m['scene_path']}")
        lines.append(f"  - object_total: {m['object_total']}")
        lines.append(f"  - constraint_pass: {m['constraints']['pass']}")

    report_path = out_root / "meta" / "cube4_execution_report.md"
    report_path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def parse_args():
    parser = argparse.ArgumentParser(description="Generate anonymous cube scenes for cube4 experiment.")
    parser.add_argument("--spec", default="experiments/configs/cube4_s01_target_spec.json")
    parser.add_argument("--region-config", default="experiments/configs/cube4_region_config.json")
    parser.add_argument("--scene-id", default="cube4_s01")
    parser.add_argument("--seed", type=int, default=401)
    parser.add_argument("--out-root", default="experiments/scenes/cube4")
    parser.add_argument("--mode", choices=["nr", "r", "both"], default="both")
    return parser.parse_args()


def main():
    args = parse_args()
    spec = load_target_spec(args.spec)
    cfg = load_region_config(args.region_config)
    out_root = Path(args.out_root)

    modes = ["nr", "r"] if args.mode == "both" else [args.mode]
    metas = []
    for i, mode in enumerate(modes):
        # Keep deterministic but different draws per mode.
        mode_seed = args.seed + i * 100
        meta = build_scene(spec, cfg, args.scene_id, mode, mode_seed, out_root)
        metas.append(meta)
        print(f"[GEN] mode={mode} scene={meta['scene_path']} pass={meta['constraints']['pass']}")

    write_execution_report(out_root, metas)
    print(f"[GEN] report={out_root / 'meta' / 'cube4_execution_report.md'}")


if __name__ == "__main__":
    main()
