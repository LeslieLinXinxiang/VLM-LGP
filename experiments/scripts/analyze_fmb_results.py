#!/usr/bin/env python3
"""
Analyze FMB LGP test results: aggregate success rates by scenario, shape type, and mode.
"""
import json
from pathlib import Path
from collections import defaultdict

ROOT = Path("/home/leslie/Projects/VLM_LGP")
LGP_OUT_DIR = ROOT / "experiments/evaluations/LGP/FMB/3objs"

def extract_shape_types(vlm_json: dict) -> set:
    """Extract shape types (e.g., 'Shape 2', 'Shape 3', 'Shape 4') from VLM JSON."""
    shapes = set()
    for obj in vlm_json.get("objects", []):
        if obj.get("id") != 0:  # Skip base (id=0)
            shapes.add(obj.get("object", ""))
    return shapes

def main():
    # Aggregate results
    results = defaultdict(lambda: {"success": 0, "total": 0, "trials": []})
    
    # Walk all trial_meta.json files in 3objs
    for meta_file in sorted(LGP_OUT_DIR.glob("*/trial_*/*/trial_meta.json")):
        try:
            with open(meta_file, "r") as f:
                meta = json.load(f)
        except Exception as e:
            print(f"[WARN] Failed to read {meta_file}: {e}")
            continue
        
        tag = meta.get("tag", "")
        if not tag:
            continue
        
        # Parse tag: e.g., "3objs/s001/trial_01_nr"
        parts = tag.split("/")
        if len(parts) != 3:
            continue
        
        _, scenario, trial_info = parts
        success = meta.get("success", False)
        runtime = meta.get("runtime_s", 0)
        vlm_json = meta.get("vlm_gt", {})
        shapes = extract_shape_types(vlm_json)
        
        # Parse trial_info: "trial_XX_nr" or "trial_XX_r"
        trial_parts = trial_info.rsplit("_", 1)
        if len(trial_parts) != 2:
            continue
        trial_id, mode = trial_parts
        
        # Split by shape type and collect stats
        shapes_str = ",".join(sorted(shapes))
        
        key_scenario = scenario
        key_scenario_mode = f"{scenario}_{mode}"
        key_scenario_shapes_mode = f"{scenario}_{shapes_str}_{mode}"
        key_shapes_mode = f"{shapes_str}_{mode}"
        
        for key in [key_scenario, key_scenario_mode, key_scenario_shapes_mode, key_shapes_mode]:
            results[key]["total"] += 1
            if success:
                results[key]["success"] += 1
            results[key]["trials"].append({
                "tag": tag,
                "success": success,
                "runtime": runtime,
                "shapes": shapes_str
            })
    
    # Build report
    print("=" * 100)
    print("FMB LGP TEST RESULTS SUMMARY")
    print("=" * 100)
    
    print("\n### SCENARIO-LEVEL SUCCESS RATES (all shapes combined)")
    print("-" * 100)
    scenario_results = {k: v for k, v in results.items() if "_" not in k}
    for key in sorted(scenario_results.keys()):
        data = scenario_results[key]
        rate = 100.0 * data["success"] / data["total"] if data["total"] > 0 else 0
        print(f"{key:15s} | Success: {data['success']:3d}/{data['total']:3d} | Rate: {rate:6.2f}%")
    
    print("\n### MODE COMPARISON (nr vs r, by scenario)")
    print("-" * 100)
    scenario_mode_results = {k: v for k, v in results.items() if "_" in k and k.count("_") == 1}
    
    scenarios = sorted(set(k.split("_")[0] for k in scenario_mode_results.keys()))
    for scenario in scenarios:
        nr_key = f"{scenario}_nr"
        r_key = f"{scenario}_r"
        nr_data = scenario_mode_results.get(nr_key, {"success": 0, "total": 0})
        r_data = scenario_mode_results.get(r_key, {"success": 0, "total": 0})
        
        nr_rate = 100.0 * nr_data["success"] / nr_data["total"] if nr_data["total"] > 0 else 0
        r_rate = 100.0 * r_data["success"] / r_data["total"] if r_data["total"] > 0 else 0
        
        print(f"{scenario}")
        print(f"  nr (non-redundant): {nr_data['success']:3d}/{nr_data['total']:3d} ({nr_rate:6.2f}%)")
        print(f"  r  (redundant):     {r_data['success']:3d}/{r_data['total']:3d} ({r_rate:6.2f}%)")
        print(f"  Δ (r - nr):         {r_rate - nr_rate:+7.2f}%")
        print()
    
    print("\n### SHAPE-TYPE ANALYSIS (by shape composition, nr vs r)")
    print("-" * 100)
    shapes_mode_results = {k: v for k, v in results.items() if k.count("_") >= 2}
    
    shape_configs = sorted(set(k.rsplit("_", 1)[0] for k in shapes_mode_results.keys()))
    for shape_config in shape_configs:
        nr_key = f"{shape_config}_nr"
        r_key = f"{shape_config}_r"
        nr_data = shapes_mode_results.get(nr_key, {"success": 0, "total": 0})
        r_data = shapes_mode_results.get(r_key, {"success": 0, "total": 0})
        
        nr_rate = 100.0 * nr_data["success"] / nr_data["total"] if nr_data["total"] > 0 else 0
        r_rate = 100.0 * r_data["success"] / r_data["total"] if r_data["total"] > 0 else 0
        
        print(f"{shape_config}")
        print(f"  nr: {nr_data['success']:3d}/{nr_data['total']:3d} ({nr_rate:6.2f}%)")
        print(f"  r:  {r_data['success']:3d}/{r_data['total']:3d} ({r_rate:6.2f}%)")
        
        if nr_data["total"] > 0 and r_data["total"] > 0:
            print(f"  Δ (r - nr): {r_rate - nr_rate:+7.2f}%")
        print()
    
    print("\n### OVERALL STATISTICS")
    print("-" * 100)
    all_success = sum(v["success"] for v in scenario_results.values())
    all_total = sum(v["total"] for v in scenario_results.values())
    all_rate = 100.0 * all_success / all_total if all_total > 0 else 0
    print(f"Total across all scenarios: {all_success}/{all_total} ({all_rate:.2f}%)")
    
    # NR vs R overall
    nr_overall = sum(v["success"] for k, v in scenario_mode_results.items() if k.endswith("_nr"))
    nr_total = sum(v["total"] for k, v in scenario_mode_results.items() if k.endswith("_nr"))
    r_overall = sum(v["success"] for k, v in scenario_mode_results.items() if k.endswith("_r"))
    r_total = sum(v["total"] for k, v in scenario_mode_results.items() if k.endswith("_r"))
    
    nr_rate_overall = 100.0 * nr_overall / nr_total if nr_total > 0 else 0
    r_rate_overall = 100.0 * r_overall / r_total if r_total > 0 else 0
    
    print(f"Non-redundant (nr):  {nr_overall}/{nr_total} ({nr_rate_overall:.2f}%)")
    print(f"Redundant (r):       {r_overall}/{r_total} ({r_rate_overall:.2f}%)")
    print(f"Redundant advantage: {r_rate_overall - nr_rate_overall:+.2f}%")
    
    print("\n" + "=" * 100)
    print("CONCLUSIONS")
    print("=" * 100)
    
    # Determine best/worst scenario
    scenario_rates = {}
    for scenario in scenarios:
        key = scenario
        data = scenario_results.get(key, {"success": 0, "total": 0})
        if data["total"] > 0:
            scenario_rates[scenario] = (100.0 * data["success"] / data["total"], data["total"])
    
    if scenario_rates:
        best_scenario = max(scenario_rates.items(), key=lambda x: x[1][0])
        worst_scenario = min(scenario_rates.items(), key=lambda x: x[1][0])
        print(f"\n✓ Best-performing scenario:  {best_scenario[0]} ({best_scenario[1][0]:.2f}%)")
        print(f"✗ Worst-performing scenario: {worst_scenario[0]} ({worst_scenario[1][0]:.2f}%)")
    
    if r_rate_overall > nr_rate_overall:
        print(f"\n✓ Redundant mode (r) shows {r_rate_overall - nr_rate_overall:.2f}% improvement over non-redundant (nr)")
    elif r_rate_overall < nr_rate_overall:
        print(f"\n✗ Redundant mode (r) shows {nr_rate_overall - r_rate_overall:.2f}% *worse* performance than non-redundant (nr)")
    else:
        print(f"\n= Redundant (r) and non-redundant (nr) modes perform equally")
    
    print("\n" + "=" * 100)

if __name__ == "__main__":
    main()
