import os
import re
from pathlib import Path
import shutil
import json

ROOT_DIR = Path("/home/leslie/Projects/VLM_LGP")
SCENES_DIR = ROOT_DIR / "experiments" / "scenes"
EVALS_DIR = ROOT_DIR / "experiments" / "evaluations" / "LGP_execution" / "cubeStacking"

def fix_stray_braces(file_path):
    with open(file_path, 'r') as f:
        lines = f.readlines()
    
    new_lines = []
    changed = False
    for line in lines:
        if line.strip() == "}":
            changed = True
            continue
        new_lines.append(line)
    
    if changed:
        with open(file_path, 'w') as f:
            f.writelines(new_lines)
        return True
    return False

def cleanup_failed_evals():
    count = 0
    # The trial folder is two levels up from trial_meta.json
    # lgp_split_smart/trial_meta.json
    # trial_06/lgp_split_smart/trial_meta.json
    for meta_file in EVALS_DIR.rglob("trial_meta.json"):
        try:
            with open(meta_file, 'r') as f:
                data = json.load(f)
            # Use runtime_s or total_time_seconds, and check for very short failures
            runtime = data.get("runtime_s", data.get("total_time_seconds", 10.0))
            if not data.get("success", True) and runtime < 1.0:
                trial_dir = meta_file.parent.parent # trial_06
                if trial_dir.exists():
                    print(f"  Deleting failed trial folder: {trial_dir}")
                    shutil.rmtree(trial_dir)
                    count += 1
        except Exception as e:
            pass
    return count

def main():
    count_scenes = 0
    for g_file in SCENES_DIR.rglob("*.g"):
        if fix_stray_braces(g_file):
            count_scenes += 1
    
    count_evals = cleanup_failed_evals()
    print(f"Finished. Fixed {count_scenes} scenes and cleaned up {count_evals} failed trials.")

if __name__ == "__main__":
    main()
