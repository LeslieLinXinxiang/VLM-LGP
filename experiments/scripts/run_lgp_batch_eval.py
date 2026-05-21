#!/usr/bin/env python3
import argparse
import importlib.util
import json
import os
import re
import select
import shutil
import subprocess
import sys
import time
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Tuple

import psutil

ROOT_DIR = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT_DIR))

import core.phase2_codegen as p2_codegen
from core.phase2_codegen import build_id_to_name, generate_step_files
from pipeline.run_phase0 import execute_phase0

MANIP_DIR = ROOT_DIR / "test" / "manipulability"
sys.path.insert(0, str(MANIP_DIR))
from urdf_static_manipulability import compute_static_manipulability_report

def _load_layer_based_clustering_class():
    module_path = ROOT_DIR / "test" / "layer_based_clustering" / "run_layer_based_codegen.py"
    spec = importlib.util.spec_from_file_location("layer_based_codegen", str(module_path))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module.LayerBasedClustering

LayerBasedClustering = _load_layer_based_clustering_class()

def _extract_final_json_from_md(md_path: Path) -> Dict:
    content = md_path.read_text(encoding="utf-8")
    fenced = re.search(r"## FINAL_JSON_START\s*```(?:json)?\n(.*?)\n```\s*## FINAL_JSON_END", content, re.DOTALL)
    if fenced: return json.loads(fenced.group(1))
    raw = re.search(r"## FINAL_JSON_START\s*(\{.*?\})\s*## FINAL_JSON_END", content, re.DOTALL)
    if raw: return json.loads(raw.group(1))
    raise ValueError(f"No FINAL_JSON block found: {md_path}")

def _extract_gt_trial(accuracy_md: Path, case_name: str) -> str:
    text = accuracy_md.read_text(encoding="utf-8")
    for line in text.splitlines():
        if f"| {case_name} |" in line:
            cells = [c.strip() for c in line.split("|") if c.strip()]
            if len(cells) < 2: continue
            gt_cell = cells[-1]
            m = re.match(r"T(\d{2})", gt_cell)
            if m: return m.group(1)
    raise ValueError(f"GT trial not found for {case_name} in {accuracy_md}")

def _run_solver(exec_dir: Path, scene_g: Path, max_mem_mb: int, timeout_s: int, kill_at_system_mem_pct: int, collision_policy: str) -> Dict:
    solver = ROOT_DIR / "bin" / "x.exe"
    cmd = [str(solver), str(exec_dir.resolve()), str(scene_g.resolve()), f"--collision-policy={collision_policy}"]
    
    start = time.time()
    stdout_lines = []
    peak_mb = 0.0
    memory_exceeded = False
    timeout_hit = False
    
    proc = subprocess.Popen(cmd, cwd=str(ROOT_DIR / "bin"), stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, bufsize=1)
    
    try:
        ps_proc = psutil.Process(proc.pid)
        last_mem_check = 0.0
        while True:
            if proc.poll() is not None: break
            now = time.time()
            elapsed = now - start
            if elapsed > timeout_s:
                timeout_hit = True
                proc.kill()
                break

            # Only check memory every 1.5 seconds to save CPU
            if now - last_mem_check > 1.5:
                last_mem_check = now
                vm = psutil.virtual_memory()
                if vm.percent >= kill_at_system_mem_pct:
                    memory_exceeded = True
                    proc.kill()
                    break
                try:
                    rss = ps_proc.memory_info().rss
                    # Minimal recursive check
                    for c in ps_proc.children(recursive=True):
                        try: rss += c.memory_info().rss
                        except psutil.Error: pass
                    peak_mb = max(peak_mb, rss / (1024.0 * 1024.0))
                    if peak_mb >= max_mem_mb:
                        memory_exceeded = True
                        proc.kill()
                        break
                except psutil.Error: pass
            
            if proc.stdout is not None:
                # Use a slightly longer timeout for select
                ready, _, _ = select.select([proc.stdout], [], [], 0.5)
                if ready:
                    line = proc.stdout.readline()
                    if line: stdout_lines.append(line)
            else: time.sleep(0.5)
            
        if proc.stdout:
            rest = proc.stdout.read()
            if rest: stdout_lines.append(rest)
            
        rc = proc.returncode if proc.returncode is not None else -9
        runtime = time.time() - start
        output_state = exec_dir / "output_state.g"
        success = (rc == 0) and output_state.exists() and (not memory_exceeded) and (not timeout_hit)
        
        return {
            "success": success,
            "runtime_s": runtime,
            "exit_code": rc,
            "timeout": timeout_hit,
            "memory_exceeded": memory_exceeded,
            "memory_peak_mb": round(peak_mb, 2),
            "stdout": "".join(stdout_lines),
            "output_state_exists": output_state.exists(),
        }
    finally:
        try: proc.kill()
        except: pass

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--mags", nargs="+", default=["4cubes"])
    parser.add_argument("--max-mem-mb", type=int, default=16000)
    parser.add_argument("--timeout-s", type=int, default=300)
    parser.add_argument("--mode", choices=["nr", "r", "both"], default="nr")
    parser.add_argument("--limit-scenarios", type=int, default=None)
    parser.add_argument("--limit-trials", type=int, default=10)
    parser.add_argument("--start-scenario", type=str, default="s01", help="Start from scenario ID (e.g. s02)")
    parser.add_argument("--skip-existing", action="store_true", help="Skip trials that already have completed outputs")
    args = parser.parse_args()

    for mag in args.mags:
        # mag is "4cubes", "5cubes" etc.
        # Extract number and zfill to 2
        mag_num = mag.replace("cubes", "").zfill(2)
        
        acc_report_path = ROOT_DIR / "experiments" / "outputs" / "gemini_proposed_method" / "accuracy_analysis" / "cubeStacking" / mag / "accuracy_report.md"
        if not acc_report_path.exists():
            print(f"Skipping {mag}: report not found at {acc_report_path}")
            continue
            
        scenes_mag_dir = ROOT_DIR / "experiments" / "scenes" / mag
        out_mag_root = ROOT_DIR / "experiments" / "evaluations" / "LGP_execution" / "cubeStacking" / mag
        
        scenarios = sorted([d.name for d in scenes_mag_dir.iterdir() if d.is_dir() and d.name.startswith("s")])
        for s_idx, scenario_name in enumerate(scenarios, 1):
            if scenario_name < args.start_scenario:
                print(f"Skipping {mag}/{scenario_name} (starts at {args.start_scenario})")
                continue
            
            if args.limit_scenarios and s_idx > args.limit_scenarios: break
            case_name = f"cube_n{mag_num}_s{s_idx:02d}"
            s_folder = f"s{s_idx:02d}"
            
            try:
                gt_trial_num = _extract_gt_trial(acc_report_path, case_name)
                vlm_md_path = ROOT_DIR / "experiments" / "evaluations" / "VLM" / "gemini_proposed_method" / "cubeStacking" / mag / case_name / f"trial_{gt_trial_num}.md"
                phase1_json = _extract_final_json_from_md(vlm_md_path)
                
                # [OPTIMIZATION] Generate decomposition plan ONCE per scenario
                clustering = LayerBasedClustering(phase1_json=phase1_json, max_batch_size=2)
                cluster_res = clustering.build_execution_plan()
                p1, p2 = cluster_res["prompt1"], cluster_res["prompt2"]
            except Exception as e:
                print(f"Failed to load GT/Plan for {case_name}: {e}")
                continue

            modes = ["nr", "r"] if args.mode == "both" else [args.mode]
            for mode in modes:
                for t_idx in range(1, args.limit_trials + 1):
                    trial_name = f"trial_{t_idx:02d}_{mode}"
                    scene_path = ROOT_DIR / "experiments" / "scenes" / mag / s_folder / "random_trials" / f"{trial_name}.g"
                    if not scene_path.exists():
                        print(f"Scene not found: {scene_path}")
                        continue
                    
                    trial_work_dir = out_mag_root / s_folder / mode / f"trial_{t_idx:02d}"
                    trial_work_dir.mkdir(parents=True, exist_ok=True)
                    
                    if args.skip_existing:
                        smart_done = (trial_work_dir / "lgp_split_smart" / "trial_meta.json").exists()
                        global_done = (trial_work_dir / "lgp_split_global" / "trial_meta.json").exists()
                        if smart_done and global_done:
                            print(f"[{mag}/{s_folder}/{trial_name}] Both modes already completed, skipping preprocessing.")
                            continue

                    # 1. Preprocess
                    print(f"[{mag}/{s_folder}/{trial_name}] Preprocessing...")
                    # [FIX] Ensure we get the fresh layout directly from return value, not the global file
                    res = execute_phase0(use_vlm=False, unnamed_g_path=str(scene_path), auto_prepare_from_named_scene=False, reachability_mode="gmm_esdf_mvp")
                    if not res or not res.get("success"):
                        print(f"  [ERROR] Preprocess failed for {trial_name}")
                        continue
                        
                    scene_ready = Path(res["scene_named_path"])
                    current_inventory = res["layout"] # <--- USE FRESH MEMORY DATA
                    
                    # 2. Run Modes (Smart then Global)
                    for lgp_mode in ["lgp_split_smart", "lgp_split_global"]:
                        mode_dir = trial_work_dir / lgp_mode
                        if (mode_dir / "trial_meta.json").exists():
                            print(f"  - {lgp_mode} already done, skipping.")
                            continue
                        
                        # [FIX] Force clear old LGP/FOL files to prevent repeating actions from previous magnitude runs
                        if mode_dir.exists():
                            shutil.rmtree(mode_dir)
                        mode_dir.mkdir(parents=True, exist_ok=True)
                        
                        policy = "active_runtime" if lgp_mode == "lgp_split_smart" else "follow_lgp"
                        # "smart" → active_runtime manages collisions at runtime, so genericCollisions must be false
                        # "global" → solver uses full global collision set from start, genericCollisions must be true
                        coll_mode = "smart" if lgp_mode == "lgp_split_smart" else "global"
                        
                        # [OPTIMIZATION] generate_step_files is now faster as cluster_res is pre-computed
                        generate_step_files(phase1_json=phase1_json, prompt1_output=p1, prompt2_output=p2, out_dir=str(mode_dir), inventory_data=current_inventory, collision_mode=coll_mode)
                        
                        print(f"  - Running {lgp_mode} (policy={policy})...")
                        solver_res = _run_solver(exec_dir=mode_dir, scene_g=scene_ready, max_mem_mb=args.max_mem_mb, timeout_s=args.timeout_s, kill_at_system_mem_pct=99, collision_policy=policy)
                        
                        (mode_dir / "solver_stdout.log").write_text(solver_res.pop("stdout"), encoding="utf-8")
                        meta = {
                            "mode": lgp_mode,
                            "policy": policy,
                            "mag": mag,
                            "case": case_name,
                            "scene": str(scene_path),
                            "gt_vlm_source": str(vlm_md_path),
                            **solver_res
                        }
                        with open(mode_dir / "trial_meta.json", "w") as f: json.dump(meta, f, indent=2)
                        print(f"    -> success={meta['success']} time={meta['runtime_s']:.1f}s peak={meta['memory_peak_mb']}MB")

if __name__ == "__main__":
    main()
