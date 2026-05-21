import os
from pathlib import Path
import json
from collections import defaultdict
import numpy as np

eval_dir = Path("/home/leslie/Projects/VLM_LGP/experiments/evaluations/LGP_execution/cubeStacking")
mags = ["4cubes", "5cubes", "6cubes", "7cubes", "8cubes"]
policies = ["lgp_split_smart", "lgp_split_global"]

stats = defaultdict(lambda: defaultdict(lambda: {"times": [], "success": 0, "failed": 0}))

for mag in mags:
    mag_path = eval_dir / mag
    if not mag_path.exists(): continue
    for scenario in sorted(os.listdir(mag_path)):
        scenario_path = mag_path / scenario
        for mode in ["r", "nr"]:
            mode_path = scenario_path / mode
            if not mode_path.exists(): continue
            for trial in os.listdir(mode_path):
                trial_path = mode_path / trial
                for policy in policies:
                    meta_file = trial_path / policy / "trial_meta.json"
                    if meta_file.exists():
                        with open(meta_file, 'r') as f:
                            data = json.load(f)
                        if data.get("success", False):
                            stats[mag][policy]["success"] += 1
                            stats[mag][policy]["times"].append(data.get("runtime_s", data.get("total_time_seconds", 0)))
                        else:
                            stats[mag][policy]["failed"] += 1

print(f"{'Mag':<10} | {'Policy':<20} | {'SR':<8} | {'Avg Time':<10} | {'Max Time':<10}")
print("-" * 75)
for mag in mags:
    for policy in policies:
        s = stats[mag][policy]
        total = s["success"] + s["failed"]
        if total > 0:
            sr = (s["success"] / total) * 100
            avg_t = np.mean(s["times"]) if s["times"] else 0
            max_t = np.max(s["times"]) if s["times"] else 0
            print(f"{mag:<10} | {policy:<20} | {sr:>6.1f}% | {avg_t:>8.2f}s | {max_t:>8.2f}s")
    print("-" * 75)
