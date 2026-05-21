#!/usr/bin/env python3
"""
Batch scene generator for cube5 ~ cube8 experiments.
Reuses the existing generate_anonymous_cube_scenes.py logic.
"""
import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../..')))

from pathlib import Path
from experiments.scripts.generate_anonymous_cube_scenes import (
    load_target_spec, load_region_config, build_scene, write_execution_report
)

ROOT = Path(__file__).resolve().parents[2]
REGION_CFG_PATH = ROOT / "experiments/configs/cube4_region_config.json"

def main():
    cfg = load_region_config(str(REGION_CFG_PATH))

    for n_cubes in range(5, 9):
        out_root = ROOT / f"experiments/scenes/cube{n_cubes}"
        out_root.mkdir(parents=True, exist_ok=True)

        # Clear old registry if present
        registry = out_root / "meta" / f"cube{n_cubes}_registry.jsonl"
        if registry.exists():
            registry.unlink()

        all_metas = []
        for s_idx in range(1, 6):
            scene_id = f"cube{n_cubes}_s{s_idx:02d}"
            spec_path = ROOT / f"experiments/configs/cube{n_cubes}_s{s_idx:02d}_target_spec.json"
            if not spec_path.exists():
                print(f"[SKIP] missing spec: {spec_path}")
                continue

            spec = load_target_spec(str(spec_path))
            base_seed = 400 + n_cubes * 37 + s_idx * 37

            for mode in ("nr", "r"):
                mode_seed = base_seed + (100 if mode == "r" else 0)
                meta = build_scene(spec, cfg, scene_id, mode, mode_seed, out_root)
                all_metas.append(meta)
                status = "✓" if meta["constraints"]["pass"] else "✗"
                print(f"  [{status}] {scene_id} mode={mode} objs={meta['object_total']} seed={mode_seed}")

        write_execution_report(out_root, all_metas)
        print(f"[DONE] cube{n_cubes}: {len(all_metas)} scenes generated → {out_root}\n")


if __name__ == "__main__":
    main()
