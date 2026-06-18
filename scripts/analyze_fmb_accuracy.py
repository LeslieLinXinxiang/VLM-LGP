import os
import json
from collections import defaultdict

def main():
    base_dir = "experiments/evaluations/VLM/gemini_proposed_method/FMB"
    for mag in ["3objs", "4objs", "5objs"]:
        mag_dir = os.path.join(base_dir, mag)
        if not os.path.exists(mag_dir):
            continue
        
        scenario_stats = defaultdict(lambda: {"total": 0, "pass": 0, "obj_data": None})
        
        for sc in sorted(os.listdir(mag_dir)):
            sc_dir = os.path.join(mag_dir, sc)
            if not os.path.isdir(sc_dir):
                continue
                
            for fname in os.listdir(sc_dir):
                if not fname.endswith(".md"):
                    continue
                file_path = os.path.join(sc_dir, fname)
                with open(file_path, "r", encoding="utf-8") as f:
                    content = f.read()
                    
                    # Check pass/fail
                    is_pass = "✅ PASS" in content
                    scenario_stats[sc]["total"] += 1
                    if is_pass:
                        scenario_stats[sc]["pass"] += 1
                        
                    # Extract JSON if not already extracted
                    if scenario_stats[sc]["obj_data"] is None and is_pass:
                        if "## FINAL_JSON_START" in content and "## FINAL_JSON_END" in content:
                            json_str = content.split("## FINAL_JSON_START")[1].split("## FINAL_JSON_END")[0].strip()
                            try:
                                obj_data = json.loads(json_str)
                                scenario_stats[sc]["obj_data"] = obj_data
                            except:
                                pass

        print(f"\n[{mag}] stats:")
        best_sc = None
        best_rate = -1.0
        for sc, stats in scenario_stats.items():
            if stats["total"] > 0:
                rate = stats["pass"] / stats["total"]
                print(f"  - {sc}: {stats['pass']}/{stats['total']} ({rate*100:.1f}%)")
                if rate > best_rate and stats["obj_data"] is not None:
                    best_rate = rate
                    best_sc = sc
        
        if best_sc:
            print(f"  => Best: {best_sc} with {best_rate*100:.1f}%")
            best_json = scenario_stats[best_sc]["obj_data"]
            out_file = f"experiments/scenes/fmb/best_{mag}.json"
            os.makedirs(os.path.dirname(out_file), exist_ok=True)
            with open(out_file, "w") as f:
                json.dump(best_json, f, indent=2)
            print(f"  => Saved to {out_file}")

if __name__ == "__main__":
    main()
