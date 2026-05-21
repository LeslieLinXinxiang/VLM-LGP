#!/usr/bin/env python3
import os
import sys
import json
import re
import shutil
import subprocess

ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "../.."))
sys.path.insert(0, ROOT_DIR)

from core.phase2_codegen import generate_step_files
import core.phase2_codegen as p2_codegen

def _extract_json(md_path):
    with open(md_path, 'r') as f:
        content = f.read()
    match = re.search(r"## FINAL_JSON_START\s*(\{.*?\})\s*## FINAL_JSON_END", content, re.DOTALL)
    return json.loads(match.group(1))

def run_task():
    # 1. Paths
    md_path = os.path.join(ROOT_DIR, "experiments/evaluations/VLM/gemini_proposed_method/cubeStacking/4cubes/cube_n04_s01/trial_02.md")
    scene_g = os.path.join(ROOT_DIR, "experiments/scenes/4cubes/s01/random_trials/trial_01_nr.g")
    out_dir = os.path.join(ROOT_DIR, "experiments/evaluations/LGP/cubeStacking/4cubes/cube_n04_s01/trial_01_nr/split_smart_final")
    
    if os.path.exists(out_dir):
        shutil.rmtree(out_dir)
    os.makedirs(out_dir, exist_ok=True)

    # 2. Get Phase1 JSON
    phase1_json = _extract_json(md_path)
    
    # 3. Load Layout (we need it for id->name mapping)
    layout_path = os.path.join(ROOT_DIR, "generated/phase0_layout.json")
    with open(layout_path, 'r') as f:
        inventory = json.load(f)

    # 4. Generate Split Files (Individual FOL/LGP per step)
    # We use KMeans or LayerBased to get strategy first
    sys.path.insert(0, os.path.join(ROOT_DIR, "test/layer_based_clustering"))
    from run_layer_based_codegen import LayerBasedClustering
    clustering = LayerBasedClustering(phase1_json=phase1_json, max_batch_size=1) # 1 obj per batch for "purest" split
    plan = clustering.build_execution_plan()
    
    # generate_step_files usually creates shared fol, we want to ensure independence if needed, 
    # but the tool default is one fol per lgp unless told otherwise.
    generated = generate_step_files(
        phase1_json=phase1_json,
        prompt1_output=plan["prompt1"],
        prompt2_output=plan["prompt2"],
        out_dir=out_dir,
        inventory_data=inventory
    )
    
    print(f"Generated {len(generated)} files in {out_dir}")

    # 5. Run Solver
    solver = os.path.join(ROOT_DIR, "bin", "x.exe")
    # policy=active_runtime for "smart"
    cmd = [solver, out_dir, scene_g, "--collision-policy=active_runtime"]
    
    print(f"Executing: {' '.join(cmd)}")
    result = subprocess.run(cmd, cwd=os.path.join(ROOT_DIR, "bin"), capture_output=True, text=True)
    
    with open(os.path.join(out_dir, "solver.log"), "w") as f:
        f.write(result.stdout)
        f.write(result.stderr)
        
    if result.returncode == 0:
        print("SUCCESS")
    else:
        print(f"FAILED (rc={result.returncode})")
        # Print last few lines of error
        print("\n".join(result.stdout.splitlines()[-10:]))

if __name__ == "__main__":
    run_task()
