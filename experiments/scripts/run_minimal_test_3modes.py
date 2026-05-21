import argparse
import json
import os
import re
import resource
import subprocess
import time
from typing import Dict, List, Set, Tuple

import psutil

# Add ROOT to sys.path
import sys
ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "../.."))
sys.path.insert(0, ROOT_DIR)

from core.phase2_codegen import generate_step_files
from pipeline.run_phase2 import _phase2_graph_gated_loop

def extract_json_from_md(md_path: str) -> dict:
    with open(md_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    match = re.search(r'## FINAL_JSON_START\s*```(?:json)?\n(.*?)\n```\s*## FINAL_JSON_END', content, re.DOTALL)
    if match:
        return json.loads(match.group(1))
    
    # Try finding any markdown json block
    match = re.search(r'```(?:json)?\n(.*?)\n```', content, re.DOTALL)
    if match:
        return json.loads(match.group(1))
    raise ValueError(f"Could not extract JSON from {md_path}")

def load_inventory() -> list:
    inv_path = os.path.join(ROOT_DIR, "generated", "phase0_layout.json")
    if os.path.exists(inv_path):
        with open(inv_path, 'r', encoding='utf-8') as f:
            return json.load(f).get("inventory", [])
    return []

def extract_frames_from_scene(scene_path: str) -> List[str]:
    frames = []
    if not os.path.exists(scene_path):
        return frames
    pattern = re.compile(r"^\s*([A-Za-z_][\w]*)\s*\(")
    with open(scene_path, 'r', encoding='utf-8') as f:
        for line in f:
            m = pattern.match(line)
            if m:
                frames.add(m.group(1))
    return list(frames)

# Simplified explicit pair generation (Distance/AABB logic could go here; for now, we'll manually specify or fallback to table)
def generate_explicit_pairs(phase1_json: dict) -> List[str]:
    # Very naive logic for demonstration: object interacts with table and its supporter
    pairs = []
    objs = phase1_json.get("objects", [])
    id_map = {o["id"]: o["object"].replace(" ", "_").lower() for o in objs}
    # Naive mapping to expected inventory names (this is heavily simplified for the demo)
    for o in objs:
        oid = o["id"]
        if oid == 0: continue
        obj_name = id_map[oid] # Would normally resolve via inventory
        
        # We always want it to not collide with table
        pairs.append(f"table {obj_name}")
        
        for e in o.get("edges", []):
            sup_id = e.get("supporter")
            if sup_id and sup_id != 0 and sup_id in id_map:
                sup_name = id_map[sup_id]
                pairs.append(f"{sup_name} {obj_name}")
    return list(set(pairs))

def apply_collision_mode(out_dir: str, mode: str, explicit_pairs: List[str] = None):
    lgp_files = [f for f in os.listdir(out_dir) if f.endswith(".lgp")]
    for lgp_file in lgp_files:
        path = os.path.join(out_dir, lgp_file)
        with open(path, 'r') as f:
            text = f.read()
        
        # Monolithic mode is conceptually 1 big file. But for this demo we'll use step_*.lgp 
        # as generated and just change the collision flags.
        is_global = "true" if mode in ["monolithic", "split_manual"] else "false"
        text = re.sub(r'genericCollisions:\s*(true|false)', f'genericCollisions: {is_global}', text)
        
        if mode == "split_manual_smart_collision" and explicit_pairs:
             # Just a demo format: actual names need to match the resolved inventory names
             # We'll use a hardcoded pair list if nothing else works to prove the mechanism
             pairs_str = "\n".join([f'  - "{p}"' for p in explicit_pairs])
             coll_block = f"coll:\n{pairs_str}\n"
             text = re.sub(r'coll:\s*\[\]\n', coll_block, text)
             
        with open(path, 'w') as f:
            f.write(text)

def run_solver(run_dir: str, scene_file: str, max_mem_mb: int = 16000, timeout_s: int = 300) -> dict:
    solver_bin = os.path.join(ROOT_DIR, "bin", "x.exe")
    cmd = [solver_bin, run_dir, scene_file]
    
    start_t = time.time()
    
    def set_limits():
        # Set memory limit
        mem_bytes = max_mem_mb * 1024 * 1024
        resource.setrlimit(resource.RLIMIT_AS, (mem_bytes, mem_bytes))
    
    try:
        proc = subprocess.Popen(
            cmd, 
            stdout=subprocess.PIPE, 
            stderr=subprocess.STDOUT, 
            text=True,
            preexec_fn=set_limits
        )
        
        # Simple psutil monitor
        p = psutil.Process(proc.pid)
        peak_mem = 0
        memory_exceeded = False
        
        stdout_lines = []
        while True:
            # Check timeout
            if time.time() - start_t > timeout_s:
                proc.terminate()
                return {"success": False, "runtime": timeout_s, "error": "Timeout", "peak_mem_mb": peak_mem}
                
            ret = proc.poll()
            if ret is not None:
                # Finished
                break
                
            try:
                mem = p.memory_info().rss / (1024 * 1024)
                peak_mem = max(peak_mem, mem)
                if mem > max_mem_mb * 0.95: # 95% of limit
                    memory_exceeded = True
                    proc.terminate()
                    break
            except psutil.NoSuchProcess:
                pass
            
            # Read some output so buffer doesn't fill
            line = proc.stdout.readline()
            if line:
                 stdout_lines.append(line)
            else:
                 time.sleep(0.1)
                 
        for line in proc.stdout.readlines():
            stdout_lines.append(line)
            
        runtime = time.time() - start_t
        
        if memory_exceeded:
            return {"success": False, "runtime": runtime, "error": "Memory exceeded", "peak_mem_mb": peak_mem}
            
        success = (ret == 0) and any("LGP converged" in l or "success" in l.lower() for l in stdout_lines)
        return {"success": success, "runtime": runtime, "error": None if ret==0 else f"Exit code {ret}", "peak_mem_mb": peak_mem, "tail_log": "".join(stdout_lines[-10:])}

    except Exception as e:
        return {"success": False, "runtime": time.time() - start_t, "error": str(e), "peak_mem_mb": 0}

def generate_monolithic_lgp(phase1_json: dict, out_dir: str, id_to_name: dict):
    # For a true monolithic, we need all objects in ONE step.
    # We will simulate this by putting everything in a single batch.
    objects = phase1_json.get("objects", [])
    
    from core.phase2_codegen import _fol_content, _lgp_content, _pick_rule, _place_rule, _terminal, _norm
    
    all_fol = ""
    terminals = []
    
    # We'll just generate the standard step files but put ALL nodes in 1 batch
    # The true monolithic logic is slightly different, but this exercises the solver globally
    prompt1 = {"strategies": [{"id": "mono", "batches": [[o["id"] for o in objects if o["id"]!=0]], "order": [o["id"] for o in objects if o["id"]!=0]}]}
    prompt2 = {"selected": "mono"}
    
    generate_step_files(phase1_json, prompt1, prompt2, out_dir, [])

def main():
    # Setup
    target_md = os.path.join(ROOT_DIR, "experiments/evaluations/VLM/pure_llm_baseline/4cubes/s01/trial_01_nr.md")
    scene_file = os.path.join(ROOT_DIR, "experiments/scenes/4cubes/s01/random_trials/trial_01_nr.g")
    
    print(f"Reading phase1 JSON from {target_md}")
    phase1_json = extract_json_from_md(target_md)
    inventory = load_inventory()
    
    out_base = os.path.join(ROOT_DIR, "experiments/evaluations/LGP/strategy_comparison_demo/4cubes/s01")
    os.makedirs(out_base, exist_ok=True)
    
    results = {}
    
    modes = ["monolithic", "split_manual", "split_manual_smart_collision"]
    
    for mode in modes:
        print(f"\n--- Running mode: {mode} ---")
        run_dir = os.path.join(out_base, mode)
        os.makedirs(run_dir, exist_ok=True)
        
        # 1. Generate files
        if mode == "monolithic":
             # Force all into 1 batch to emulate monolithic
             objects = phase1_json.get("objects", [])
             p1 = {"strategies": [{"id": "mono", "batches": [[o["id"] for o in objects if o["id"]!=0]], "order": [o["id"] for o in objects if o["id"]!=0]}]}
             p2 = {"selected": "mono"}
             generate_step_files(phase1_json, p1, p2, run_dir, inventory)
             apply_collision_mode(run_dir, mode)
        else:
            # Use layer_based for split
            _phase2_graph_gated_loop(phase1_json, ROOT_DIR, run_dir, scene_file, clustering_algorithm="layer_based_test")
            
            # 2. Apply collision changes
            # Note: The true smart collision logic would compute exactly the pairs needed.
            # Here we provide a hardcoded stub just to see it pass to the solver.
            # We want to enable table collision for everyone, and inter-cube for adjacent.
            # In our FMB scenes, names are rect_X, cyl_X, etc.
            demo_pairs = ["rect_1 rect_2", "table rect_1", "table rect_2"] 
            apply_collision_mode(run_dir, mode, explicit_pairs=demo_pairs if mode=="split_manual_smart_collision" else None)
        
        # 3. Run solver
        print("Solving...")
        res = run_solver(run_dir, scene_file)
        print(f"Result: Success={res['success']}, Runtime={res['runtime']:.2f}s, Peak Mem={res['peak_mem_mb']:.1f}MB")
        if res['error']:
            print(f"Error: {res['error']}")
        
        results[mode] = res

    # Summary
    print("\n\n=== EXPERIMENT SUMMARY ===")
    for m, r in results.items():
        print(f"{m:35s} | Success: {r['success']!s:5s} | Time: {r['runtime']:6.2f}s | Mem: {r['peak_mem_mb']:6.1f}MB")

if __name__ == "__main__":
    main()
