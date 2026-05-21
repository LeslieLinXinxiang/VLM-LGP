#!/usr/bin/env python3
import json
import os
from pathlib import Path
from collections import Counter
import re

ROOT_DIR = Path(__file__).resolve().parents[2]
VLM_FMB_DIR = ROOT_DIR / "experiments/evaluations/VLM/gemini_proposed_method/FMB"
CONFIGS_DIR = ROOT_DIR / "experiments/configs"

def extract_json(md_text):
    match = re.search(r"## FINAL_JSON_START\n(.*?)\n## FINAL_JSON_END", md_text, re.DOTALL)
    if match:
        try:
            return json.loads(match.group(1))
        except json.JSONDecodeError:
            return None
    return None

def normalize_shape_name(name):
    # e.g. "Shape 2" -> "shape_2"
    return name.lower().replace(" ", "_")

def main():
    if not VLM_FMB_DIR.exists():
        print(f"VLM FMB directory not found: {VLM_FMB_DIR}")
        return

    mags = [d for d in os.listdir(VLM_FMB_DIR) if (VLM_FMB_DIR / d).is_dir() and d.endswith("objs")]
    
    for mag in mags:
        mag_dir = VLM_FMB_DIR / mag
        scenarios = [d for d in os.listdir(mag_dir) if (mag_dir / d).is_dir()]
        
        for scenario in scenarios:
            scenario_dir = mag_dir / scenario
            trial_jsons = []
            
            for t_idx in range(1, 11):
                trial_file = scenario_dir / f"trial_{t_idx:02d}.md"
                if trial_file.exists():
                    text = trial_file.read_text()
                    data = extract_json(text)
                    if data:
                        # Convert to normalized string for hashing
                        # Sort objects by id just to be safe
                        data["objects"] = sorted(data["objects"], key=lambda x: x.get("id", 0))
                        trial_jsons.append((t_idx, json.dumps(data, sort_keys=True)))
            
            if not trial_jsons:
                print(f"[{mag}/{scenario}] No valid JSONs found.")
                continue
                
            # Majority vote
            json_strings = [j[1] for j in trial_jsons]
            counter = Counter(json_strings)
            most_common_json_str, count = counter.most_common(1)[0]
            gt_data = json.loads(most_common_json_str)
            
            # Find which trial was the GT
            gt_trial_idx = next(idx for idx, jstr in trial_jsons if jstr == most_common_json_str)
            print(f"[{mag}/{scenario}] GT determined from trial_{gt_trial_idx:02d} (Vote {count}/{len(trial_jsons)})")
            
            # Extract object counts
            shape_counts = Counter()
            for obj in gt_data.get("objects", []):
                name = obj.get("object", "")
                if name.lower().startswith("shape"):
                    shape_name = normalize_shape_name(name)
                    shape_counts[shape_name] += 1
                    
            # Generate Target Spec
            spec = {
                "counts": dict(shape_counts),
                "vlm_gt_trial": gt_trial_idx,
                "vlm_vote_count": count
            }
            
            out_file = CONFIGS_DIR / f"fmb_{mag}_s{scenario}_target_spec.json"
            out_file.parent.mkdir(parents=True, exist_ok=True)
            with open(out_file, "w") as f:
                json.dump(spec, f, indent=2)
            print(f"  -> Saved {out_file.name}: {dict(shape_counts)}")

if __name__ == "__main__":
    main()
