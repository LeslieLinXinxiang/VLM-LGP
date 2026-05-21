#!/usr/bin/env python3
import json
import os
import sys
import shutil
from pathlib import Path

ROOT_DIR = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT_DIR))

from experiments.scripts.run_lgp_batch_eval import _extract_final_json_from_md, _run_solver, generate_step_files, LayerBasedClustering
from pipeline.run_phase0 import execute_phase0

def main():
    mag = "3objs"
    scenario = "s003"
    trial = "trial_01"
    mode = "nr"
    
    # 1. Paths
    vlm_md = ROOT_DIR / f"experiments/evaluations/VLM/gemini_proposed_method/FMB/{mag}/003/trial_01.md"
    scene_g = ROOT_DIR / f"experiments/scenes/fmb/{mag}/{scenario}/random_trials/{trial}_{mode}.g"
    test_out_dir = ROOT_DIR / "experiments" / "evaluations" / "FMB_test_run" / mag / scenario / trial / f"lgp_split_smart"
    test_out_dir.mkdir(parents=True, exist_ok=True)
    
    print(f"--- FMB Test Run: {mag}/{scenario}/{trial}_{mode} ---")
    print(f"VLM MD: {vlm_md}")
    print(f"Scene G: {scene_g}")
    print(f"Output: {test_out_dir}")
    
    # 2. Extract VLM JSON
    print("\n[Step 1] Extracting VLM Plan...")
    vlm_json = _extract_final_json_from_md(vlm_md)
    
    # 3. Phase 0 (Preprocessing)
    print("\n[Step 2] Phase 0 (Preprocessing)...")
    res = execute_phase0(use_vlm=False, unnamed_g_path=str(scene_g), auto_prepare_from_named_scene=False, reachability_mode="gmm_esdf_mvp")
    if not res or not res.get("success"):
        print("  [ERROR] Preprocess failed")
        return
        
    scene_ready = Path(res["scene_named_path"])
    current_inventory = res["layout"]
    
    # 4. Phase 1 (Task Partitioning)
    print("\n[Step 3] Phase 1 (Task Partitioning)...")
    clusterer = LayerBasedClustering(vlm_json)
    cluster_res = clusterer.build_execution_plan()
    p1 = cluster_res["prompt1"]
    p2 = cluster_res["prompt2"]
    
    # 5. Codegen
    print("\n[Step 4] Codegen...")
    generate_step_files(phase1_json=vlm_json, prompt1_output=p1, prompt2_output=p2, out_dir=str(test_out_dir), inventory_data=current_inventory, collision_mode="smart")
    
    # 6. Run Solver
    print("\n[Step 5] Running Solver (active_runtime)...")
    solver_res = _run_solver(exec_dir=test_out_dir, scene_g=scene_ready, max_mem_mb=16000, timeout_s=300, kill_at_system_mem_pct=99, collision_policy="active_runtime")
    
    (test_out_dir / "solver_stdout.log").write_text(solver_res.pop("stdout"), encoding="utf-8")
    print(f"\n[DONE] Success: {solver_res['success']}")
    print(f"  Runtime: {solver_res['runtime_s']:.2f}s")
    print(f"  Memory Peak: {solver_res['memory_peak_mb']:.2f}MB")
    print(f"  Log saved to: {test_out_dir / 'solver_stdout.log'}")

if __name__ == "__main__":
    main()
