#!/usr/bin/env python3
"""
Compare lgp_split_global vs lgp_split_smart modes across all magnitudes.
Excludes scenarios with 0% success rate (pathological failures).
"""
import json
from pathlib import Path
from collections import defaultdict

ROOT = Path("/home/leslie/Projects/VLM_LGP")
LGP_OUT_DIR = ROOT / "experiments/evaluations/LGP/FMB"

def analyze_modes(mag_dir: Path, mag_name: str) -> dict:
    """Extract global vs smart comparison for a magnitude."""
    if not mag_dir.exists():
        return None
    
    # First pass: collect all results by scenario to determine which to exclude
    scenario_totals = defaultdict(lambda: {"total": 0, "success": 0})
    mode_results = defaultdict(lambda: {"global": {"success": 0, "total": 0}, 
                                        "smart": {"success": 0, "total": 0}})
    
    for meta_file in sorted(mag_dir.glob("*/trial_*/*/trial_meta.json")):
        try:
            with open(meta_file, "r") as f:
                meta = json.load(f)
        except:
            continue
        
        tag = meta.get("tag", "")
        if not tag:
            continue
        
        parts = tag.split("/")
        if len(parts) != 3:
            continue
        
        _, scenario, trial_info = parts
        success = meta.get("success", False)
        
        trial_parts = trial_info.rsplit("_", 1)
        if len(trial_parts) != 2:
            continue
        trial_id, mode = trial_parts
        
        # Accumulate scenario totals
        scenario_totals[scenario]["total"] += 1
        if success:
            scenario_totals[scenario]["success"] += 1
    
    # Identify scenarios with 0% success (to exclude)
    excluded_scenarios = set()
    for scenario, data in scenario_totals.items():
        if data["total"] > 0 and data["success"] == 0:
            excluded_scenarios.add(scenario)
    
    # Second pass: collect global/smart stats, excluding bad scenarios
    for meta_file in sorted(mag_dir.glob("*/trial_*/*/trial_meta.json")):
        try:
            with open(meta_file, "r") as f:
                meta = json.load(f)
        except:
            continue
        
        tag = meta.get("tag", "")
        if not tag:
            continue
        
        parts = tag.split("/")
        if len(parts) != 3:
            continue
        
        _, scenario, trial_info = parts
        
        # SKIP excluded scenarios
        if scenario in excluded_scenarios:
            continue
        
        success = meta.get("success", False)
        lgp_mode = meta.get("mode", "")
        
        trial_parts = trial_info.rsplit("_", 1)
        if len(trial_parts) != 2:
            continue
        trial_id, trial_mode = trial_parts
        
        key = f"{scenario}_{trial_mode}"
        
        if "global" in lgp_mode:
            mode_results[key]["global"]["total"] += 1
            if success:
                mode_results[key]["global"]["success"] += 1
        elif "smart" in lgp_mode:
            mode_results[key]["smart"]["total"] += 1
            if success:
                mode_results[key]["smart"]["success"] += 1
    
    return {
        "mode_results": dict(mode_results),
        "excluded_scenarios": excluded_scenarios,
        "total_excluded": len(excluded_scenarios)
    }

def main():
    magnitudes = []
    for mag_dir in sorted(LGP_OUT_DIR.iterdir()):
        if mag_dir.is_dir() and mag_dir.name in ["3objs", "4objs", "5objs"]:
            magnitudes.append((mag_dir.name, mag_dir))
    
    print("=" * 140)
    print("GLOBAL vs SMART MODE COMPARISON (Excluding 0% Success Scenarios)")
    print("=" * 140)
    
    all_comparisons = {}
    
    for mag_name, mag_dir in magnitudes:
        print(f"\n{'#' * 140}")
        print(f"# {mag_name.upper()}")
        print(f"{'#' * 140}")
        
        result = analyze_modes(mag_dir, mag_name)
        if not result:
            print(f"No results for {mag_name}")
            continue
        
        all_comparisons[mag_name] = result
        
        excluded = result["excluded_scenarios"]
        if excluded:
            print(f"\n⚠️  EXCLUDED (0% success): {', '.join(sorted(excluded))}")
        
        mode_results = result["mode_results"]
        
        print(f"\n### DETAILED SCENARIO × MODE COMPARISON ({mag_name})")
        print("-" * 140)
        
        # Group by scenario
        scenarios = sorted(set(k.split("_")[0] for k in mode_results.keys()))
        
        summary_global_success = 0
        summary_global_total = 0
        summary_smart_success = 0
        summary_smart_total = 0
        
        for scenario in scenarios:
            print(f"\n{scenario}:")
            
            for trial_mode in ["nr", "r"]:
                key = f"{scenario}_{trial_mode}"
                if key not in mode_results:
                    continue
                
                global_data = mode_results[key]["global"]
                smart_data = mode_results[key]["smart"]
                
                global_rate = 100.0 * global_data["success"] / global_data["total"] if global_data["total"] > 0 else 0
                smart_rate = 100.0 * smart_data["success"] / smart_data["total"] if smart_data["total"] > 0 else 0
                delta = smart_rate - global_rate
                
                print(f"  {trial_mode} (non-redundant={trial_mode})")
                print(f"    global: {global_data['success']:3d}/{global_data['total']:3d} ({global_rate:6.2f}%)")
                print(f"    smart:  {smart_data['success']:3d}/{smart_data['total']:3d} ({smart_rate:6.2f}%)")
                
                if global_data["total"] > 0 and smart_data["total"] > 0:
                    arrow = "↑" if delta > 0 else "↓" if delta < 0 else "="
                    print(f"    Δ {arrow} {delta:+7.2f}% ")
                
                summary_global_success += global_data["success"]
                summary_global_total += global_data["total"]
                summary_smart_success += smart_data["success"]
                summary_smart_total += smart_data["total"]
        
        # Summary for magnitude
        print(f"\n{'-' * 140}")
        print(f"{mag_name.upper()} SUMMARY:")
        
        global_rate = 100.0 * summary_global_success / summary_global_total if summary_global_total > 0 else 0
        smart_rate = 100.0 * summary_smart_success / summary_smart_total if summary_smart_total > 0 else 0
        delta = smart_rate - global_rate
        
        print(f"  global: {summary_global_success:3d}/{summary_global_total:3d} ({global_rate:6.2f}%)")
        print(f"  smart:  {summary_smart_success:3d}/{summary_smart_total:3d} ({smart_rate:6.2f}%)")
        
        if delta > 0:
            print(f"  🔼 SMART better by {delta:+.2f}%")
        elif delta < 0:
            print(f"  🔽 GLOBAL better by {-delta:.2f}%")
        else:
            print(f"  ➡️  Both modes equal")
    
    # Cross-magnitude summary
    print(f"\n{'=' * 140}")
    print("CROSS-MAGNITUDE SUMMARY (Excluding 0% Scenarios)")
    print(f"{'=' * 140}")
    
    for mag_name in sorted(all_comparisons.keys()):
        result = all_comparisons[mag_name]
        mode_results = result["mode_results"]
        
        global_success = sum(v["global"]["success"] for v in mode_results.values())
        global_total = sum(v["global"]["total"] for v in mode_results.values())
        smart_success = sum(v["smart"]["success"] for v in mode_results.values())
        smart_total = sum(v["smart"]["total"] for v in mode_results.values())
        
        global_rate = 100.0 * global_success / global_total if global_total > 0 else 0
        smart_rate = 100.0 * smart_success / smart_total if smart_total > 0 else 0
        delta = smart_rate - global_rate
        
        print(f"\n{mag_name.upper()}:")
        print(f"  global: {global_success:4d}/{global_total:4d} ({global_rate:6.2f}%)")
        print(f"  smart:  {smart_success:4d}/{smart_total:4d} ({smart_rate:6.2f}%)")
        
        if delta > 0:
            print(f"  → SMART wins by {delta:+.2f}%")
        elif delta < 0:
            print(f"  → GLOBAL wins by {-delta:.2f}%")
        else:
            print(f"  → TIE")
    
    # Final analysis
    print(f"\n{'=' * 140}")
    print("CONCLUSIONS")
    print(f"{'=' * 140}")
    
    print("""
### Global vs Smart Mode Assessment

GLOBAL MODE (lgp_split_global):
  • Strategy: Conservative, global collision policy
  • Use case: Safer trajectories, wider working envelope
  • Trade-off: May be slower, more restrictive

SMART MODE (lgp_split_smart):
  • Strategy: Active runtime collision checking
  • Use case: Dynamic adaptation, faster planning
  • Trade-off: More aggressive, potential collisions

### Recommendation:
  Based on performance data, the mode showing higher success rate
  should be preferred for each magnitude. Consider:
  
  1. If SMART consistently better: Use smart for faster execution
  2. If GLOBAL consistently better: Use global for reliability
  3. If similar: Choose based on application requirements (speed vs safety)
""")
    
    print(f"{'=' * 140}\n")

if __name__ == "__main__":
    main()
