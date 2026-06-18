#!/usr/bin/env python3
import os
import sys
import json
import re
import shutil
import subprocess
import time
from pathlib import Path
import importlib.util

ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "../.."))
if ROOT_DIR not in sys.path:
    sys.path.insert(0, ROOT_DIR)

from pipeline.run_phase0 import execute_phase0
from core.phase2_codegen import generate_step_files
import core.phase2_codegen as p2_codegen
from core.deployment_export import export_trajectory_and_gripper_bundle

def _load_layer_based_clustering_class():
    module_path = os.path.join(ROOT_DIR, "test", "layer_based_clustering", "run_layer_based_codegen.py")
    spec = importlib.util.spec_from_file_location("layer_based_codegen", module_path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module.LayerBasedClustering

LayerBasedClustering = _load_layer_based_clustering_class()

def _extract_final_json_from_md(md_path: str) -> dict:
    with open(md_path, "r", encoding="utf-8") as f:
        content = f.read()
    fenced = re.search(r"## FINAL_JSON_START\s*```(?:json)?\n(.*?)\n```\s*## FINAL_JSON_END", content, re.DOTALL)
    if fenced: return json.loads(fenced.group(1))
    raw = re.search(r"## FINAL_JSON_START\s*(\{.*?\})\s*## FINAL_JSON_END", content, re.DOTALL)
    if raw: return json.loads(raw.group(1))
    
    # Check for PDDL (since CubeStacking might have FINAL_PDDL_START and no FINAL_JSON)
    # Wait, the prompt said they have FINAL_JSON_START but let's check!
    from core.phase1_pddl_to_json import extract_pddl_from_md, convert_pddl_to_json
    
    pddl_match = re.search(r"## FINAL_PDDL_START\s*(.*?)\s*## FINAL_PDDL_END", content, re.DOTALL)
    if pddl_match:
        pddl_text = pddl_match.group(1)
        # Using heuristic to map PDDL names to logical_ids, we need layout.
        pass
    
    raise ValueError(f"No FINAL_JSON block found: {md_path}")

def modify_scene_for_real_exp(input_scene: Path, output_scene: Path):
    with open(input_scene, 'r') as f:
        content = f.read()
        
    content = re.sub(r'table\s*\(world\)[^\n]*\n?', '', content)
    
    replacement = """
base (world) { shape:ssBox, size:[1.3 1.0 .11 .02], Q:"t(0 0 .545)", color:[.45 .45 .45], contact:1 }
table (base) { shape:ssBox, size:[1.0 0.8 .1 .02], Q:"t(0 0.25 .11)", color:[.3 .3 .3], contact:1, logical:{ is_place } }
"""
    content = content.replace("world {}", "world {}" + replacement)
    content = re.sub(r'Edit l_panda_base\s*\([^)]+\):.*', 'Edit l_panda_base (base): { Q: "t(0 -.3 .05) d(90 0 0 1)" }', content)
    
    with open(output_scene, 'w') as f:
        f.write(content)

def _shared_fol_content() -> str:
    return (
        p2_codegen._fol_header()
        + p2_codegen._RULE_PICK_TOUCH + "\n"
        + p2_codegen._RULE_PICK_CYLINDER + "\n"
        + p2_codegen._RULE_PLACE_STRAIGHT + "\n"
        + p2_codegen._RULE_PLACE_2 + "\n"
        + p2_codegen._RULE_PLACE_3 + "\n"
        + p2_codegen._RULE_PLACE_4 + "\n"
    )

def run_solver(exec_dir: Path, scene_g: Path):
    solver = os.path.join(ROOT_DIR, "bin", "x.exe")
    cmd = [solver, str(exec_dir.resolve()), str(scene_g.resolve()), "--collision-policy=active_runtime"]
    
    start = time.time()
    proc = subprocess.Popen(
        cmd,
        cwd=os.path.join(ROOT_DIR, "bin"),
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
    )
    stdout, _ = proc.communicate(timeout=600)
    
    log_path = exec_dir.parent / "solver_run.log"
    with open(log_path, "w") as f:
        f.write(stdout)
        
    output_state = exec_dir / "output_state.g"
    if proc.returncode != 0 or not output_state.exists():
        print(f"Solver failed with code {proc.returncode}")
        return False, stdout
    
    return True, stdout

cases = [
    {
        "name": "4_cubes_nr",
        "vlm_md": "experiments/evaluations/VLM/gemini_proposed_method/cubeStacking/4cubes/cube_n04_s05/trial_02.md",
        "scene": "experiments/scenes/4cubes/s05/random_trials/trial_01_nr.g"
    },
    {
        "name": "5_cubes_nr",
        "vlm_md": "experiments/evaluations/VLM/gemini_proposed_method/cubeStacking/5cubes/cube_n05_s05/trial_02.md",
        "scene": "experiments/scenes/5cubes/s05/random_trials/trial_01_nr.g"
    },
    {
        "name": "7_cubes_nr",
        "vlm_md": "experiments/evaluations/VLM/gemini_proposed_method/cubeStacking/7cubes/cube_n07_s03/trial_02.md",
        "scene": "experiments/scenes/7cubes/s03/random_trials/trial_01_nr.g"
    },
    {
        "name": "8_cubes_nr",
        "vlm_md": "experiments/evaluations/VLM/gemini_proposed_method/cubeStacking/8cubes/cube_n08_s02/trial_02.md",
        "scene": "experiments/scenes/8cubes/s02/random_trials/trial_01_nr.g"
    },
    {
        "name": "fmb_3objs_nr",
        "vlm_md": "experiments/evaluations/VLM/gemini_proposed_method/FMB/3objs/001/trial_01.md",
        "scene": "experiments/scenes/fmb/3objs/s001/random_trials/trial_01_nr.g"
    },
    {
        "name": "fmb_4objs_nr",
        "vlm_md": "experiments/evaluations/VLM/gemini_proposed_method/FMB/4objs/001/trial_01.md",
        "scene": "experiments/scenes/fmb/4objs/s001/random_trials/trial_01_nr.g"
    },
    {
        "name": "fmb_5objs_nr",
        "vlm_md": "experiments/evaluations/VLM/gemini_proposed_method/FMB/5objs/002/trial_01.md",
        "scene": "experiments/scenes/fmb/5objs/s002/random_trials/trial_01_nr.g"
    }
]

def main():
    real_exp_dir = Path(ROOT_DIR) / "experiments" / "real_exp."
    real_exp_dir.mkdir(exist_ok=True)
    
    for case in cases:
        print(f"\\n{'='*50}")
        print(f"Processing {case['name']}...")
        out_dir = real_exp_dir / case["name"]
        out_dir.mkdir(exist_ok=True)
        
        orig_scene = Path(ROOT_DIR) / case["scene"]
        elevated_scene = out_dir / "scene_named.g"
        modify_scene_for_real_exp(orig_scene, elevated_scene)
        print(f" [1] Modified scene saved to {elevated_scene}")
        
        md_path = Path(ROOT_DIR) / case["vlm_md"]
        try:
            phase1_json = _extract_final_json_from_md(md_path)
            print(" [2] Extracted plan from VLM MD.")
        except ValueError as e:
            print(f" [X] Could not extract JSON from MD: {e}")
            continue
        
        phase0 = execute_phase0(
            use_vlm=False,
            scene_named_g_path=str(elevated_scene.resolve()),
            auto_prepare_from_named_scene=True,
            reachability_mode="gmm_esdf_mvp",
        )
        if not phase0 or not phase0.get("success"):
            print(" [X] Phase 0 failed.")
            continue
            
        shutil.copy(phase0["scene_named_path"], elevated_scene)
        print(f" [1.5] Copied renamed physical-aware scene to {elevated_scene}")
            
        layout_path = phase0["layout_path"]
        with open(layout_path, "r") as f:
            layout_data = json.load(f)
            if isinstance(layout_data, dict) and "inventory" in layout_data:
                layout_data = layout_data["inventory"]
            
        exec_dir = out_dir / "lgp_split_smart"
        if exec_dir.exists():
            shutil.rmtree(exec_dir)
        exec_dir.mkdir()
        
        clustering = LayerBasedClustering(phase1_json=phase1_json, max_batch_size=2)
        plan = clustering.build_execution_plan()
        
        generate_step_files(
            phase1_json=phase1_json,
            prompt1_output=plan["prompt1"],
            prompt2_output=plan["prompt2"],
            out_dir=str(exec_dir.resolve()),
            inventory_data=layout_data,
        )
        
        shared_fol = exec_dir / "shared_rules.fol"
        fol_content = _shared_fol_content()
        
        fol_objects = ["l_gripper", "table", "Table_Left", "Table_Center", "Table_Right", "Table_Back", "Table_Front"]
        for item in layout_data:
            fol_objects.append(item["logical_id"])
            if item.get("logical_id", "").startswith("rect") or item.get("logical_id", "").startswith("longrect"):
                fol_objects.append(f"{item['logical_id']}_Left")
                fol_objects.append(f"{item['logical_id']}_Right")
                fol_objects.append(f"{item['logical_id']}_Center")
        
        fol_objs_str = " ".join(set(fol_objects))
        fol_content = fol_content.replace("START_STATE {}", f"START_STATE {{ (is_gripper l_gripper) \n {fol_objs_str} \n}}")
        shared_fol.write_text(fol_content)
        
        for lgp_file in exec_dir.glob("*.lgp"):
            text = lgp_file.read_text()
            text = re.sub(r"fol:\s*<[^>]+>", "fol: <shared_rules.fol>", text)
            text = re.sub(r"genericCollisions:\s*(true|false)", "genericCollisions: false", text)
            text = re.sub(r"coll:\s*\[[^\]]*\]", "coll: []", text)
            lgp_file.write_text(text)
            
        for fol_file in list(exec_dir.glob("*.fol")):
            if fol_file.name != "shared_rules.fol":
                fol_file.unlink()
                
        print(f" [3] Generated step files in {exec_dir.name}/")
        
        print(" [4] Running solver (may take a few minutes)...")
        success, stdout = run_solver(exec_dir, elevated_scene)
        
        if success:
            print(" [5] Solver finished successfully. Extracting trajectories...")
            export_trajectory_and_gripper_bundle(
                stdout=stdout,
                output_dir=out_dir,
                traj_filename="traj.txt",
                gripper_filename="gripper.txt"
            )
            print(" [6] Saved traj.txt and gripper.txt!")
        else:
            print(" [X] Solver failed.")

if __name__ == "__main__":
    main()
