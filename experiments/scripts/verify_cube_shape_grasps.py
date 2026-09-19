#!/usr/bin/env python3
"""One-off visual verification: run a real cube-stacking scenario (8cubes/s01, which
happens to contain all four shape families -- Cube, RectPrism, Long RectPrism, TriPrism --
in one scene) through the actual lgp_split_smart pipeline, then render the solved grasp
(pick) configuration for one instance of each shape plus the final placed (output_state.g)
scene, so a human can visually check for grasp-pose correctness and interference.

Not a batch/statistical tool -- a single real trial, rendered for inspection.
"""
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))

import core.phase2_codegen as p2_codegen
from core.phase2_codegen import generate_step_files
from pipeline.run_phase0 import execute_phase0

import importlib.util
def _load_layer_based_clustering_class():
    module_path = ROOT / "test" / "layer_based_clustering" / "run_layer_based_codegen.py"
    spec = importlib.util.spec_from_file_location("layer_based_codegen", str(module_path))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module.LayerBasedClustering
LayerBasedClustering = _load_layer_based_clustering_class()

SCENE = ROOT / "experiments" / "scenes" / "8cubes" / "s01" / "random_trials" / "trial_01_nr.g"
REF_MD = ROOT / "experiments" / "evaluations" / "VLM" / "gemini_proposed_method" / "cubeStacking" / "8cubes" / "cube_n08_s01" / "trial_03.md"
OUT_DIR = ROOT / "experiments" / "outputs" / "cube_shape_grasp_check"
EXEC_DIR = OUT_DIR / "exec"
RENDER_DIR = OUT_DIR / "renders"


def extract_final_json(md_path: Path):
    content = md_path.read_text(encoding="utf-8")
    m = re.search(r"## FINAL_JSON_START\s*(.*?)\s*## FINAL_JSON_END", content, re.DOTALL)
    return json.loads(m.group(1))


def main():
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    EXEC_DIR.mkdir(parents=True, exist_ok=True)
    RENDER_DIR.mkdir(parents=True, exist_ok=True)

    phase1_json = extract_final_json(REF_MD)

    print("[1/4] execute_phase0 (preprocess, reachability + manipulability ordering)...")
    res = execute_phase0(use_vlm=False, unnamed_g_path=str(SCENE),
                          auto_prepare_from_named_scene=False,
                          reachability_mode="gmm_esdf_mvp")
    if not res or not res.get("success"):
        print("[ERROR] preprocess failed:", res)
        return
    scene_ready = Path(res["scene_named_path"])
    inventory = res["layout"]

    print("\n[named inventory]")
    for item in inventory:
        print(f"  {item.get('logical_id')}: {item.get('object_type')}")

    print("\n[2/4] building layer-based decomposition + codegen (lgp_split_smart)...")
    cluster = LayerBasedClustering(phase1_json=phase1_json, max_batch_size=2)
    cluster_res = cluster.build_execution_plan()
    for f in EXEC_DIR.glob("*"):
        if f.suffix in (".fol", ".lgp"):
            f.unlink()
    generate_step_files(phase1_json=phase1_json, prompt1_output=cluster_res["prompt1"],
                         prompt2_output=cluster_res["prompt2"], out_dir=str(EXEC_DIR),
                         inventory_data=[{"logical_id": x["logical_id"]} for x in inventory],
                         collision_mode="smart", combine_terminals=False)

    print("\n[3/4] running bin/x.exe (lgp_split_smart, active_runtime collision policy)...")
    solver = ROOT / "bin" / "x.exe"
    cmd = [str(solver), str(EXEC_DIR.resolve()), str(scene_ready.resolve()), "--collision-policy=active_runtime"]
    proc = subprocess.run(cmd, cwd=str(ROOT / "bin"), capture_output=True, text=True, timeout=180)
    output_state = EXEC_DIR / "output_state.g"
    print(f"  exit={proc.returncode} output_state_exists={output_state.exists()}")
    if proc.returncode != 0:
        print(proc.stdout[-3000:])

    # Pick one representative object per shape family from the *named* inventory.
    wanted = {"cube": None, "longrect": None, "rectprism": None, "triprism": None}
    for item in inventory:
        ot = (item.get("object_type") or "").lower().replace(" ", "_")
        for key in wanted:
            if wanted[key] is None and key in ot:
                wanted[key] = item["logical_id"]
    print("\n[shape -> representative object]")
    for k, v in wanted.items():
        print(f"  {k}: {v}")

    print("\n[4/4] rendering pick (grasp) config per shape + final placed state...")
    cam_state = [0.9, -0.6, 1.6, 0.0, 0.15, 0.70]

    # Objects sit directly under the table frame (table itself has no xy offset, only
    # z=0.6), so an object's world (x, y) is just its own Q translation's (x, y), and the
    # table surface is at world z ~= 0.665. Frame each grasp shot around that object's own
    # position -- a single fixed camera badly misses objects scattered ~0.5m apart, as the
    # first attempt at this (fixed cam_grasp) showed (zoomed into the elbow, no gripper).
    obj_xy = {}
    for item in inventory:
        m = re.search(rf'^{re.escape(item["logical_id"])}\s*\(table\)\s*\{{\s*Q:"t\(([-\d.]+)\s+([-\d.]+)',
                       scene_ready.read_text(), re.MULTILINE)
        if m:
            obj_xy[item["logical_id"]] = (float(m.group(1)), float(m.group(2)))

    for shape, name in wanted.items():
        if not name:
            print(f"  [skip] no object found for shape={shape}")
            continue
        x, y = obj_xy.get(name, (0.0, 0.0))
        cam_grasp = [x + 0.35, y - 0.35, 1.05, x, y, 0.68]
        out_png = RENDER_DIR / f"pick_{shape}_{name}.png"
        exe = ROOT / "bin" / "render_grasp.exe"
        out_sub = RENDER_DIR / (out_png.stem + "_raw")
        out_sub.mkdir(parents=True, exist_ok=True)
        cmd = [str(exe), str(scene_ready), name, str(out_sub) + "/", *[str(c) for c in cam_grasp]]
        r = subprocess.run(cmd, cwd=str(ROOT / "bin"), capture_output=True, text=True, timeout=60)
        png = out_sub / "0000.png"
        if png.exists():
            import shutil
            shutil.copy(png, out_png)
            print(f"  [pick] {shape} ({name}) -> {out_png.relative_to(ROOT)}")
        else:
            print(f"  [FAIL] pick render for {shape} ({name}): {r.stdout[-500:]}")

    if output_state.exists():
        exe = ROOT / "bin" / "render_scene.exe"
        out_png = RENDER_DIR / "place_final_state.png"
        out_sub = RENDER_DIR / (out_png.stem + "_raw")
        out_sub.mkdir(parents=True, exist_ok=True)
        cmd = [str(exe), str(output_state), str(out_sub) + "/", *[str(c) for c in cam_state], "1.0"]
        r = subprocess.run(cmd, cwd=str(ROOT / "bin"), capture_output=True, text=True, timeout=60)
        png = out_sub / "0000.png"
        if png.exists():
            import shutil
            shutil.copy(png, out_png)
            print(f"  [place] final state -> {out_png.relative_to(ROOT)}")
        else:
            print(f"  [FAIL] place render: {r.stdout[-500:]}")
    else:
        print("  [skip place] no output_state.g (solve did not complete)")


if __name__ == "__main__":
    main()
