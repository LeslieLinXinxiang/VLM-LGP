#!/usr/bin/env python3
import os
import json
import argparse
from pathlib import Path
import numpy as np

def categorize_failure(meta):
    """
    Categorizes the reason for failure based on trial metadata.
    Returns one of: 'Success', 'OOM', 'Timeout', 'Kinematic_Infeasible', 'Solver_Crash'
    """
    if meta.get("success", False):
        return "Success"
    
    # 1. Memory OOM
    if meta.get("memory_exceeded", False) or meta.get("exit_code") in [-9, 137]:
        return "OOM"
    
    # 2. Timeout
    if meta.get("timeout", False):
        return "Timeout"
    
    # 3. Kinematic Failure (Infeasible)
    # The solver exited normally (0) but couldn't find a solution
    if meta.get("exit_code") == 0:
        return "Kinematic_Infeasible"
    
    # 4. Solver Crash (Segfault, Parsing error, etc.)
    return "Solver_Crash"

def format_percentage(num, total):
    if total == 0: return "0.0%"
    return f"{(num/total)*100:.1f}%"

def generate_markdown_report(stats, output_path):
    """
    Generates a Markdown report from the aggregated statistics.
    """
    mags = ["4cubes", "5cubes", "6cubes", "7cubes", "8cubes"]
    policies = ["lgp_split_smart", "lgp_split_global"]
    
    md = ["# LGP Execution Data Statistical Analysis\n"]
    md.append("> **Analysis Framework**: Data grouped by Task Complexity (Magnitude) and Strategy (Policy).")
    md.append("> **Metrics Used**: Success Rate (SR), Median Runtime (only for successful trials to resist outliers), and Failure Attribution.\n")
    
    md.append("## 1. Overall Performance (NR Mode - Non-Reachable)")
    md.append("| Magnitude | Policy | Trials | Success Rate | Median Time (s) | Avg Peak Mem (MB) |")
    md.append("| :--- | :--- | :--- | :--- | :--- | :--- |")
    
    for mag in mags:
        for pol in policies:
            data = stats.get(mag, {}).get("nr", {}).get(pol, {})
            if not data: continue
            
            trials = data.get("total", 0)
            success = data.get("success", 0)
            sr_str = format_percentage(success, trials)
            
            runtimes = data.get("success_runtimes", [])
            med_time = f"{np.median(runtimes):.1f}" if runtimes else "N/A"
            
            mems = data.get("success_mems", [])
            avg_mem = f"{np.mean(mems):.1f}" if mems else "N/A"
            
            md.append(f"| {mag} | `{pol}` | {trials} | **{sr_str}** | {med_time} | {avg_mem} |")
            
    md.append("\n## 2. Overall Performance (R Mode - Reachable/Obstructed)")
    md.append("| Magnitude | Policy | Trials | Success Rate | Median Time (s) | Avg Peak Mem (MB) |")
    md.append("| :--- | :--- | :--- | :--- | :--- | :--- |")
    
    for mag in mags:
        for pol in policies:
            data = stats.get(mag, {}).get("r", {}).get(pol, {})
            if not data: continue
            
            trials = data.get("total", 0)
            success = data.get("success", 0)
            sr_str = format_percentage(success, trials)
            
            runtimes = data.get("success_runtimes", [])
            med_time = f"{np.median(runtimes):.1f}" if runtimes else "N/A"
            
            mems = data.get("success_mems", [])
            avg_mem = f"{np.mean(mems):.1f}" if mems else "N/A"
            
            md.append(f"| {mag} | `{pol}` | {trials} | **{sr_str}** | {med_time} | {avg_mem} |")
            
    md.append("\n## 3. Failure Attribution Breakdown (Aggregated across modes)")
    md.append("This table illustrates *why* the solvers failed, categorizing failures into OOM (Memory Tree Explosion), Timeout, Kinematic Infeasible (No physically valid path found), and Solver Crash.")
    md.append("\n| Magnitude | Policy | Total Failures | OOM | Timeout | Kinematic Infeasible | Crash |")
    md.append("| :--- | :--- | :--- | :--- | :--- | :--- | :--- |")
    
    for mag in mags:
        for pol in policies:
            nr_data = stats.get(mag, {}).get("nr", {}).get(pol, {})
            r_data = stats.get(mag, {}).get("r", {}).get(pol, {})
            
            failures = nr_data.get("failures", {})
            for r_f in r_data.get("failures", {}):
                failures[r_f] = failures.get(r_f, 0) + r_data["failures"][r_f]
                
            total_fail = sum(failures.values())
            if total_fail == 0:
                # md.append(f"| {mag} | `{pol}` | 0 | - | - | - | - |")
                continue
                
            oom = f"{format_percentage(failures.get('OOM', 0), total_fail)} ({failures.get('OOM', 0)})"
            tout = f"{format_percentage(failures.get('Timeout', 0), total_fail)} ({failures.get('Timeout', 0)})"
            infeas = f"{format_percentage(failures.get('Kinematic_Infeasible', 0), total_fail)} ({failures.get('Kinematic_Infeasible', 0)})"
            crash = f"{format_percentage(failures.get('Solver_Crash', 0), total_fail)} ({failures.get('Solver_Crash', 0)})"
            
            md.append(f"| {mag} | `{pol}` | **{total_fail}** | {oom} | {tout} | {infeas} | {crash} |")
            
    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text("\n".join(md), encoding="utf-8")
    print(f"Report successfully saved to {output_path}")

def main():
    parser = argparse.ArgumentParser(description="Analyze LGP execution statistics from trial_meta.json files.")
    parser.add_argument("--eval-dir", type=str, default="/home/leslie/Projects/VLM_LGP/experiments/evaluations/LGP_execution/cubeStacking",
                        help="Root directory containing LGP execution results.")
    parser.add_argument("--output", type=str, default="/home/leslie/Projects/VLM_LGP/experiments/outputs/LGP_execution_stats/cross_magnitude_comparison.md",
                        help="Output path for the Markdown report.")
    args = parser.parse_args()

    eval_dir = Path(args.eval_dir)
    output_path = Path(args.output)
    
    if not eval_dir.exists():
        print(f"Evaluation directory not found: {eval_dir}")
        return

    # Structure: stats[mag][mode][policy]
    stats = {}

    for meta_file in eval_dir.rglob("trial_meta.json"):
        try:
            with open(meta_file, 'r', encoding='utf-8') as f:
                meta = json.load(f)
        except Exception as e:
            print(f"Error reading {meta_file}: {e}")
            continue

        mag = meta.get("mag", "unknown")
        # Extract mode from the file path because 'trial_meta.json' doesn't contain 'nr'/'r' explicitly
        # Path looks like: .../cubeStacking/5cubes/s04/nr/trial_09/lgp_split_smart/trial_meta.json
        parts = meta_file.parts
        mode = "unknown"
        if "nr" in parts: mode = "nr"
        elif "r" in parts: mode = "r"
        
        policy = meta.get("mode", "unknown") # 'lgp_split_smart' or 'lgp_split_global'
        
        if mag not in stats: stats[mag] = {}
        if mode not in stats[mag]: stats[mag][mode] = {}
        if policy not in stats[mag][mode]:
            stats[mag][mode][policy] = {
                "total": 0,
                "success": 0,
                "success_runtimes": [],
                "success_mems": [],
                "failures": {
                    "OOM": 0,
                    "Timeout": 0,
                    "Kinematic_Infeasible": 0,
                    "Solver_Crash": 0
                }
            }
            
        group = stats[mag][mode][policy]
        group["total"] += 1
        
        fail_reason = categorize_failure(meta)
        
        if fail_reason == "Success":
            group["success"] += 1
            if meta.get("runtime_s") is not None:
                group["success_runtimes"].append(meta["runtime_s"])
            if meta.get("memory_peak_mb") is not None:
                group["success_mems"].append(meta["memory_peak_mb"])
        else:
            group["failures"][fail_reason] += 1

    generate_markdown_report(stats, output_path)

if __name__ == "__main__":
    main()
