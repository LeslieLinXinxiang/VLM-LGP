#!/usr/bin/env python3
import importlib.util
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SCRIPT = ROOT / "experiments/scripts/generate_fmb_scenes.py"

spec = importlib.util.spec_from_file_location("genfmb", str(SCRIPT))
mod = importlib.util.module_from_spec(spec)
spec.loader.exec_module(mod)

CONFIGS_DIR = ROOT / "experiments/configs"
OUT_ROOT = ROOT / "experiments/scenes/fmb/3objs/s004"

cfg_path = CONFIGS_DIR / "fmb_region_config.json"
spec_path = CONFIGS_DIR / "fmb_3objs_s004_target_spec.json"

if not cfg_path.exists() or not spec_path.exists():
    print("Missing config or spec files. Aborting.")
    print(cfg_path, cfg_path.exists())
    print(spec_path, spec_path.exists())
    raise SystemExit(1)

with open(cfg_path, "r", encoding="utf-8") as f:
    cfg = json.load(f)

with open(spec_path, "r", encoding="utf-8") as f:
    spec_json = json.load(f)

scenario = "s004"
base_seed = 5000 + (hash(scenario) % 10000)

OUT_ROOT.mkdir(parents=True, exist_ok=True)

print(f"Quick-generating scenes for {scenario} into {OUT_ROOT}")
for trial_idx in range(1, 11):
    scene_id = f"trial_{trial_idx:02d}"
    for mode in ["nr", "r"]:
        mode_seed = base_seed + trial_idx * 100 + (10 if mode == "r" else 0)
        try:
            meta = mod.generate_scene(spec_json, cfg, scene_id, mode, mode_seed, OUT_ROOT)
            print(f"  Wrote {meta['scene_path']}")
        except Exception as e:
            print(f"  [ERROR] {scene_id}_{mode}: {e}")

print("Done.")
