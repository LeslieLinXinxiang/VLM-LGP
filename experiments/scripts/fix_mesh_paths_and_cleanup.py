import os
import json
import shutil
from pathlib import Path

project_root = "/home/leslie/Projects/VLM_LGP"
scenes_dir = os.path.join(project_root, "experiments/scenes")
eval_dir = os.path.join(project_root, "experiments/evaluations/LGP_execution/cubeStacking")

# 1. Fix .g files
print("Fixing mesh paths in .g files...")
fixed_count = 0
for root, dirs, files in os.walk(scenes_dir):
    for file in files:
        if file.endswith(".g"):
            path = os.path.join(root, file)
            with open(path, 'r') as f:
                content = f.read()
            
            if 'mesh:"generated/' in content:
                new_content = content.replace('mesh:"generated/', f'mesh:"{project_root}/generated/')
                with open(path, 'w') as f:
                    f.write(new_content)
                fixed_count += 1

print(f"Fixed {fixed_count} .g files.")

# 2. Identify and delete trials with Path Error
print("Cleaning up failed trials with Path Errors...")
deleted_count = 0
for root, dirs, files in os.walk(eval_dir):
    if "trial_meta.json" in files:
        meta_path = os.path.join(root, "trial_meta.json")
        log_path = os.path.join(root, "solver_stdout.log")
        
        should_delete = False
        try:
            with open(meta_path, 'r') as f:
                meta = json.load(f)
            
            if not meta.get("success", False):
                if os.path.exists(log_path):
                    with open(log_path, 'r', errors='ignore') as log_f:
                        log_content = log_f.read()
                        if "ERROR:util.cpp:cd_file" in log_content:
                            should_delete = True
        except Exception as e:
            print(f"Error reading {meta_path}: {e}")
            # If meta is corrupted, maybe delete too?
            should_delete = True

        if should_delete:
            print(f"  Deleting {root} due to Path Error")
            shutil.rmtree(root)
            deleted_count += 1

print(f"Deleted {deleted_count} failed trial folders.")
