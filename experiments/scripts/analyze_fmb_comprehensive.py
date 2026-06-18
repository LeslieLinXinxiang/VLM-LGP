#!/usr/bin/env python3
"""
Comprehensive FMB LGP analysis across all object magnitudes (3objs, 4objs, 5objs).
"""
import json
from pathlib import Path
from collections import defaultdict
import sys

ROOT = Path("/home/leslie/Projects/VLM_LGP")
LGP_OUT_DIR = ROOT / "experiments/evaluations/LGP/FMB"

def extract_shape_types(vlm_json: dict) -> set:
    """Extract shape types from VLM JSON."""
    shapes = set()
    for obj in vlm_json.get("objects", []):
        if obj.get("id") != 0:  # Skip base
            shapes.add(obj.get("object", ""))
    return shapes

def analyze_magnitude(mag_dir: Path, mag_name: str) -> dict:
    """Analyze results for a single magnitude (3objs, 4objs, 5objs)."""
    if not mag_dir.exists():
        return None
    
    results = defaultdict(lambda: {"success": 0, "total": 0, "trials": []})
    
    for meta_file in sorted(mag_dir.glob("*/trial_*/*/trial_meta.json")):
        try:
            with open(meta_file, "r") as f:
                meta = json.load(f)
        except Exception as e:
            continue
        
        tag = meta.get("tag", "")
        if not tag:
            continue
        
        parts = tag.split("/")
        if len(parts) != 3:
            continue
        
        _, scenario, trial_info = parts
        success = meta.get("success", False)
        runtime = meta.get("runtime_s", 0)
        vlm_json = meta.get("vlm_gt", {})
        shapes = extract_shape_types(vlm_json)
        
        trial_parts = trial_info.rsplit("_", 1)
        if len(trial_parts) != 2:
            continue
        trial_id, mode = trial_parts
        
        shapes_str = ",".join(sorted(shapes))
        
        # Multi-level grouping
        for key in [scenario, f"{scenario}_{mode}", f"{scenario}_{shapes_str}_{mode}"]:
            results[key]["total"] += 1
            if success:
                results[key]["success"] += 1
            results[key]["trials"].append({
                "tag": tag,
                "success": success,
                "runtime": runtime,
                "shapes": shapes_str
            })
    
    return dict(results) if results else None

def main():
    # Detect all available magnitudes
    magnitudes = []
    for mag_dir in sorted(LGP_OUT_DIR.iterdir()):
        if mag_dir.is_dir() and mag_dir.name in ["3objs", "4objs", "5objs"]:
            magnitudes.append((mag_dir.name, mag_dir))
    
    if not magnitudes:
        print("No test results found in LGP/FMB")
        return
    
    all_mag_data = {}
    
    print("=" * 120)
    print("COMPREHENSIVE FMB LGP TEST ANALYSIS ACROSS ALL OBJECT MAGNITUDES")
    print("=" * 120)
    
    # Analyze each magnitude
    for mag_name, mag_dir in magnitudes:
        print(f"\n{'#' * 120}")
        print(f"# {mag_name.upper()} TEST RESULTS")
        print(f"{'#' * 120}")
        
        results = analyze_magnitude(mag_dir, mag_name)
        if not results:
            print(f"[No results for {mag_name}]")
            continue
        
        all_mag_data[mag_name] = results
        
        # Scenario-level summary
        print(f"\n### SCENARIO-LEVEL SUMMARY ({mag_name})")
        print("-" * 120)
        scenario_results = {k: v for k, v in results.items() if "_" not in k}
        
        total_success = 0
        total_count = 0
        for key in sorted(scenario_results.keys()):
            data = scenario_results[key]
            rate = 100.0 * data["success"] / data["total"] if data["total"] > 0 else 0
            print(f"  {key:10s} | Success: {data['success']:3d}/{data['total']:3d} | Rate: {rate:6.2f}%")
            total_success += data["success"]
            total_count += data["total"]
        
        if total_count > 0:
            overall_rate = 100.0 * total_success / total_count
            print(f"  {'TOTAL':10s} | Success: {total_success:3d}/{total_count:3d} | Rate: {overall_rate:6.2f}%")
        
        # Mode comparison
        print(f"\n### MODE COMPARISON (nr vs r) - {mag_name}")
        print("-" * 120)
        mode_results = {k: v for k, v in results.items() if "_" in k and k.count("_") == 1}
        
        scenarios = sorted(set(k.split("_")[0] for k in mode_results.keys()))
        for scenario in scenarios:
            nr_key = f"{scenario}_nr"
            r_key = f"{scenario}_r"
            nr_data = mode_results.get(nr_key, {"success": 0, "total": 0})
            r_data = mode_results.get(r_key, {"success": 0, "total": 0})
            
            nr_rate = 100.0 * nr_data["success"] / nr_data["total"] if nr_data["total"] > 0 else 0
            r_rate = 100.0 * r_data["success"] / r_data["total"] if r_data["total"] > 0 else 0
            
            print(f"  {scenario}")
            print(f"    nr: {nr_data['success']:3d}/{nr_data['total']:3d} ({nr_rate:6.2f}%)")
            print(f"    r:  {r_data['success']:3d}/{r_data['total']:3d} ({r_rate:6.2f}%)")
            if nr_data["total"] > 0 and r_data["total"] > 0:
                delta = r_rate - nr_rate
                arrow = "↑" if delta > 0 else "↓" if delta < 0 else "="
                print(f"    Δ {arrow} {delta:+7.2f}%")
            print()
    
    # Cross-magnitude comparison
    print(f"\n{'=' * 120}")
    print("CROSS-MAGNITUDE COMPARISON (3objs vs 4objs vs 5objs)")
    print(f"{'=' * 120}")
    
    print(f"\n### OVERALL SUCCESS RATES BY MAGNITUDE")
    print("-" * 120)
    
    mag_summaries = {}
    for mag_name, results in all_mag_data.items():
        scenario_results = {k: v for k, v in results.items() if "_" not in k}
        total_succ = sum(v["success"] for v in scenario_results.values())
        total_cnt = sum(v["total"] for v in scenario_results.values())
        rate = 100.0 * total_succ / total_cnt if total_cnt > 0 else 0
        mag_summaries[mag_name] = (total_succ, total_cnt, rate)
        print(f"  {mag_name:10s} | {total_succ:3d}/{total_cnt:3d} ({rate:6.2f}%)")
    
    # Redundancy effect across magnitudes
    print(f"\n### REDUNDANCY (r) ADVANTAGE ACROSS MAGNITUDES")
    print("-" * 120)
    
    for mag_name, results in all_mag_data.items():
        mode_results = {k: v for k, v in results.items() if "_" in k and k.count("_") == 1}
        
        nr_overall = sum(v["success"] for k, v in mode_results.items() if k.endswith("_nr"))
        nr_total = sum(v["total"] for k, v in mode_results.items() if k.endswith("_nr"))
        r_overall = sum(v["success"] for k, v in mode_results.items() if k.endswith("_r"))
        r_total = sum(v["total"] for k, v in mode_results.items() if k.endswith("_r"))
        
        nr_rate = 100.0 * nr_overall / nr_total if nr_total > 0 else 0
        r_rate = 100.0 * r_overall / r_total if r_total > 0 else 0
        delta = r_rate - nr_rate
        
        print(f"  {mag_name}")
        print(f"    nr (non-redundant):  {nr_overall:3d}/{nr_total:3d} ({nr_rate:6.2f}%)")
        print(f"    r  (redundant):      {r_overall:3d}/{r_total:3d} ({r_rate:6.2f}%)")
        print(f"    advantage:           {delta:+7.2f}%")
        print()
    
    # Scenario performance across magnitudes
    print(f"\n### SCENARIO PERFORMANCE ACROSS MAGNITUDES")
    print("-" * 120)
    
    all_scenarios = set()
    for results in all_mag_data.values():
        all_scenarios.update(k for k in results.keys() if "_" not in k)
    
    for scenario in sorted(all_scenarios):
        print(f"\n  {scenario}")
        for mag_name in sorted(all_mag_data.keys()):
            results = all_mag_data[mag_name]
            data = results.get(scenario, {"success": 0, "total": 0})
            if data["total"] > 0:
                rate = 100.0 * data["success"] / data["total"]
                print(f"    {mag_name}: {data['success']:3d}/{data['total']:3d} ({rate:6.2f}%)")
    
    # Final conclusions
    print(f"\n{'=' * 120}")
    print("CONCLUSIONS & RECOMMENDATIONS")
    print(f"{'=' * 120}")
    
    # Complexity trend
    print(f"\n✓ COMPLEXITY TREND")
    print(f"-" * 120)
    if "3objs" in mag_summaries and "4objs" in mag_summaries and "5objs" in mag_summaries:
        rates_3 = mag_summaries["3objs"][2]
        rates_4 = mag_summaries["4objs"][2]
        rates_5 = mag_summaries["5objs"][2]
        
        print(f"  3 objects: {rates_3:6.2f}%")
        print(f"  4 objects: {rates_4:6.2f}% (Δ {rates_4 - rates_3:+.2f}%)")
        print(f"  5 objects: {rates_5:6.2f}% (Δ {rates_5 - rates_4:+.2f}%)")
        
        if rates_4 < rates_3 or rates_5 < rates_4:
            print(f"\n  ⚠️  SUCCESS RATE DEGRADES with more objects - solver scaling issues detected")
        else:
            print(f"\n  ✓ SUCCESS RATE STABLE or IMPROVES with more objects")
    
    # Redundancy insight
    print(f"\n✓ REDUNDANCY INSIGHT")
    print(f"-" * 120)
    
    avg_redundancy_benefit = sum(
        (100.0 * results.get(f"{s}_r", {}).get("success", 0) / results.get(f"{s}_r", {}).get("total", 1)
         if results.get(f"{s}_r", {}).get("total", 0) > 0 else 0)
        - (100.0 * results.get(f"{s}_nr", {}).get("success", 0) / results.get(f"{s}_nr", {}).get("total", 1)
           if results.get(f"{s}_nr", {}).get("total", 0) > 0 else 0)
        for results in all_mag_data.values()
        for s in [k.split("_")[0] for k in results.keys() if "_" in k and k.count("_") == 1]
    ) / (sum(1 for _ in all_mag_data.values()) * 3)  # Rough estimate
    
    if avg_redundancy_benefit > 2:
        print(f"  ✓ Redundancy mode (r) provides {avg_redundancy_benefit:.2f}% improvement overall")
    elif avg_redundancy_benefit > 0:
        print(f"  ~ Redundancy mode (r) provides marginal {avg_redundancy_benefit:.2f}% improvement")
    else:
        print(f"  ✗ Redundancy mode (r) provides no significant benefit or is worse")
    
    print(f"\n{'=' * 120}\n")

if __name__ == "__main__":
    main()
