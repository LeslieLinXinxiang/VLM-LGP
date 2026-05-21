import os
from pathlib import Path
import json

eval_dir = "/home/leslie/Projects/VLM_LGP/experiments/evaluations/LGP_execution/cubeStacking"
mags = ["4cubes", "5cubes", "6cubes", "7cubes", "8cubes"]

total_expected = 500 * 2 # 5 mags * 10 scenarios * 10 trials * 2 modes
# Wait, let's count exactly what's left.
# 5 mags, each has 10 scenarios (s01-s10), each has 10 trials. Total 500 tasks.
# Each task has 2 policies (smart, global). Total 1000 folders.

completed = 0
success = 0
failed = 0

for root, dirs, files in os.walk(eval_dir):
    if "trial_meta.json" in files:
        completed += 1
        with open(os.path.join(root, "trial_meta.json"), 'r') as f:
            meta = json.load(f)
            if meta.get("success", False):
                success += 1
            else:
                failed += 1

print(f"Total Completed: {completed} / 1000")
print(f"Success: {success}")
print(f"Failed: {failed}")
print(f"Success Rate: {success/completed*100:.1f}%" if completed > 0 else "N/A")
