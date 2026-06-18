#!/usr/bin/env python3
"""
FMB Comparison: Smart vs Global
Reference: experiments/scripts/run_fmb_batch_eval.py
"""
import argparse
import json
import os
import re
import shutil
import sys
import time
from pathlib import Path
from collections import defaultdict

import psutil
import subprocess
import select

ROOT_DIR = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT_DIR))

from core.phase2_codegen import generate_step_files
from pipeline.run_phase0 import execute_phase0

import importlib.util

def _load_layer_based_clustering():
    module_path = ROOT_DIR / "test/layer_based_clustering/run_layer_based_codegen.py"
    spec = importlib.util.spec_from_file_location("layer_based_codegen", str(module_path))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module.LayerBasedClustering

LayerBasedClustering = _load_layer_based_clustering()


def _extract_json_from_md(md_path: Path) -> dict:
    content = md_path.read_text(encoding="utf-8")
    # Try FINAL_JSON markers
    m = re.search(r"## FINAL_JSON_START\s*```(?:json)?\n(.*?)\n```\s*## FINAL_JSON_END", content, re.DOTALL)
    if m:
        return json.loads(m.group(1))
    m = re.search(r"## FINAL_JSON_START\s*(\{.*?\})\s*## FINAL_JSON_END", content, re.DOTALL)
    if m:
        return json.loads(m.group(1))
    raise ValueError(f"No FINAL_JSON block in {md_path}")


def acquire_runtime_lock(lock_path: Path):
    """Simple process lock via file existence."""
    lock_path.parent.mkdir(parents=True, exist_ok=True)
    if lock_path.exists():
        # Check if process actually exists
        try:
            pid = int(lock_path.read_text().strip())
            if psutil.pid_exists(pid):
                raise RuntimeError(f"Lock held by PID {pid}. Path: {lock_path}")
        except:
            pass
    lock_path.write_text(str(os.getpid()))
    return lock_path


def run_solver(out_dir: Path, scene_g: Path, collision_policy: str, timeout_s: int, max_mem_mb: int) -> dict:
    solver = ROOT_DIR / "bin/x.exe"
    cmd = [str(solver), str(out_dir.resolve()), str(scene_g.resolve()), f"--collision-policy={collision_policy}"]
    
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
            if proc.poll() is not None:
                break
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
            except psutil.Error:
                pass
            
            if proc.stdout:
                # Use non-blocking read
                ready, _, _ = select.select([proc.stdout], [], [], 0.1)
                if ready:
                    line = proc.stdout.readline()
                    if line: 
                        stdout_lines.append(line)
            else:
                time.sleep(0.1)
                
        if proc.stdout:
            rest = proc.stdout.read()
            if rest: stdout_lines.append(rest)
            
        rc = proc.returncode if proc.returncode is not None else -9
        runtime = time.time() - start
        output_state = out_dir / "output_state.g"
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


def run_one_trial(
    vlm_json: dict,
    scene_g: Path,
    strategy: str,  # "smart", "global"
    out_dir: Path,
    timeout_s: int,
    max_mem_mb: int,
    visualize: bool = False,
) -> dict:
    out_dir.mkdir(parents=True, exist_ok=True)
    
    # Phase 0
    phase0 = execute_phase0(
        use_vlm=False,
        unnamed_g_path=str(scene_g),
        auto_prepare_from_named_scene=False,
        reachability_mode="gmm_esdf_mvp",
    )
    if not phase0 or not phase0.get("success"):
        return {"success": False, "error": "phase0_failed", "runtime_s": 0}

    scene_ready = Path(phase0["scene_named_path"])
    layout = phase0["layout"]

    # Clustering
    max_batch_size = 2
    collision_mode_lgp = "smart" if strategy == "smart" else "global"
    collision_policy = "active_runtime" if strategy == "smart" else "follow_lgp"

    clustering = LayerBasedClustering(phase1_json=vlm_json, max_batch_size=max_batch_size)
    plan = clustering.build_execution_plan()

    # Codegen
    generate_step_files(
        phase1_json=vlm_json,
        prompt1_output=plan["prompt1"],
        prompt2_output=plan["prompt2"],
        out_dir=str(out_dir),
        inventory_data=layout,
        collision_mode=collision_mode_lgp,
        has_wait=visualize,
        combine_terminals=False,
    )

    # Solver
    result = run_solver(out_dir, scene_ready, collision_policy, timeout_s, max_mem_mb)
    (out_dir / "solver_stdout.log").write_text(result.pop("stdout"), encoding="utf-8")
    return result


def main():
    parser = argparse.ArgumentParser(description="FMB Strategies Comparison (Smart vs Global)")
    parser.add_argument("--mags", nargs="+", default=["3objs", "4objs", "5objs"])
    parser.add_argument("--scenarios", nargs="+", default=["001", "002", "003", "004", "005"])
    parser.add_argument("--trials", nargs="+", type=int, default=list(range(1, 11)))
    parser.add_argument("--modes", nargs="+", choices=["nr", "r"], default=["nr", "r"])
    parser.add_argument("--strategies", nargs="+", choices=["smart", "global", "combine"], default=["smart", "global", "combine"])
    parser.add_argument("--timeout-s", type=int, default=300)
    parser.add_argument("--memory-lock-gb", type=int, default=16)
    parser.add_argument("--skip-existing", action="store_true")
    parser.add_argument("--visualize", action="store_true")
    args = parser.parse_args()

    vlm_base = ROOT_DIR / "experiments/evaluations/VLM/gemini_proposed_method/FMB"
    scene_base = ROOT_DIR / "experiments/scenes/fmb"
    out_base = ROOT_DIR / "experiments/evaluations/LGP_execution/fmb"
    
    lock_path = ROOT_DIR / "generated/.locks/fmb_comparison.lock"
    acquire_runtime_lock(lock_path)

    results = defaultdict(lambda: {"success": 0, "fail": 0, "skip": 0, "trials": []})
    total_count = 0

    print(f"\n{'='*90}")
    print(f"FMB Strategies Comparison: Smart vs Global")
    print(f"Strategies: {args.strategies}")
    print(f"{'='*90}\n")

    try:
        for mag in args.mags:
            best_json_path = scene_base / f"best_{mag}.json"
            if not best_json_path.exists():
                print(f"[WARN] Missing best config: {best_json_path}")
                continue
            with open(best_json_path) as f:
                vlm_json = json.load(f)

            for scen_num in args.scenarios:
                scen_id = f"s{scen_num}"
                for trial_idx in args.trials:
                    for mode in args.modes:
                        scene_g = scene_base / mag / scen_id / "random_trials" / f"trial_{trial_idx:02d}_{mode}.g"
                        if not scene_g.exists():
                            continue

                        # Run strategies in requested order
                        for strategy in args.strategies:
                            out_dir = out_base / strategy / mag / scen_id / mode / f"trial_{trial_idx:02d}"
                            
                            if args.skip_existing and (out_dir / "output_state.g").exists():
                                results[f"{mag}/{strategy}"]["skip"] += 1
                                continue

                            total_count += 1
                            tag = f"{mag}/{scen_id}/trial_{trial_idx:02d}_{mode}/{strategy}"
                            print(f"[{total_count:3d}] Running {tag}...", end=" ", flush=True)
                            
                            start_time = time.time()
                            try:
                                res = run_one_trial(
                                    vlm_json=vlm_json,
                                    scene_g=scene_g,
                                    strategy=strategy,
                                    out_dir=out_dir,
                                    timeout_s=args.timeout_s,
                                    max_mem_mb=args.memory_lock_gb * 1024,
                                    visualize=args.visualize
                                )
                                ok = res.get("success", False)
                            except Exception as e:
                                res = {"success": False, "error": str(e), "runtime_s": 0}
                                ok = False

                            elapsed = time.time() - start_time
                            if ok:
                                results[f"{mag}/{strategy}"]["success"] += 1
                                status = "✓"
                            else:
                                results[f"{mag}/{strategy}"]["fail"] += 1
                                status = "✗"

                            print(f"{status} {elapsed:.1f}s", flush=True)
                            
                            # Save meta
                            meta = {"tag": tag, "scene_g": str(scene_g), **res}
                            (out_dir / "trial_meta.json").write_text(json.dumps(meta, indent=2), encoding="utf-8")

        # Summary
        print(f"\n\n{'='*90}")
        print(f"SUMMARY")
        print(f"{'='*90}")
        for key in sorted(results.keys()):
            r = results[key]
            success_rate = 100.0 * r["success"] / max(1, r["success"] + r["fail"])
            print(f"{key:30s}: {r['success']:3d}/{r['success']+r['fail']:3d} ({success_rate:5.1f}%)")
        print(f"{'='*90}\n")

    finally:
        if lock_path.exists():
            lock_path.unlink()

if __name__ == "__main__":
    main()
