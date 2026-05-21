import os
import re
from pathlib import Path
import shutil

ROOT_DIR = Path("/home/leslie/Projects/VLM_LGP")
SCENES_DIR = ROOT_DIR / "experiments" / "scenes"
EVALS_DIR = ROOT_DIR / "experiments" / "evaluations" / "LGP_execution" / "cubeStacking"

STANDARD_SLOTS = """# Fixed placement slots on table
Table_Left  (table) { Q:"t(-0.08  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Center  (table) { Q:"t(0.00  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Right (table) { Q:"t( 0.08  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Back (table) { Q:"t( 0.00  0.02 .051)", shape:ssBox, size:[.025 .025 .002 .001], color:[1 1 0 0], contact:0, logical:{ is_place } }
Base_Front (table) { Q:"t( 0.00  0.18 .051)", shape:ssBox, size:[.025 .025 .002 .001], color:[1 1 0 0], contact:0, logical:{ is_place } }
"""

def sanitize_file(file_path):
    with open(file_path, 'r') as f:
        content = f.read()
    
    if 'base_board' not in content:
        return False
    
    print(f"Sanitizing {file_path}...")
    
    # 1. Remove base_board definition
    content = re.sub(r'base_board \(table\) \{.*?\}', '', content, flags=re.DOTALL)
    
    # 2. Replace FMB-style slots with standard ones
    # We look for the block starting with # Fixed placement slots... and ending before obj_01
    pattern = re.compile(r'# Fixed placement slots on base_board.*?Table_Center.*?\}', re.DOTALL)
    if pattern.search(content):
        content = pattern.sub(STANDARD_SLOTS, content)
    else:
        # If comment is different, try matching by slot names
        pattern2 = re.compile(r'Table_Left.*?Table_Center.*?\}', re.DOTALL)
        content = pattern2.sub(STANDARD_SLOTS, content)

    # 3. Ensure any other parent (base_board) is changed to (table) - just in case
    content = content.replace('(base_board)', '(table)')
    
    # Clean up double newlines
    content = re.sub(r'\n\s*\n\s*\n', '\n\n', content)
    
    with open(file_path, 'w') as f:
        f.write(content)
    
    return True

def cleanup_evals(mag, scenario, trial_id, mode):
    path = EVALS_DIR / mag / scenario / mode / trial_id
    if path.exists():
        print(f"  Deleting evaluation data: {path}")
        shutil.rmtree(path)

def main():
    count = 0
    for g_file in SCENES_DIR.rglob("*.g"):
        # Skip directories
        if not g_file.is_file(): continue
        
        if sanitize_file(g_file):
            count += 1
            # Parse mag, scenario, trial from path
            # example path: experiments/scenes/8cubes/s01/random_trials/trial_01_nr.g
            parts = g_file.parts
            # Index depends on deepness, better use relative_to
            rel_path = g_file.relative_to(SCENES_DIR)
            mag = rel_path.parts[0]
            scenario = rel_path.parts[1]
            filename = g_file.stem # trial_01_nr
            
            if "_nr" in filename:
                trial_id = filename.replace("_nr", "")
                mode = "nr"
            elif "_r" in filename:
                trial_id = filename.replace("_r", "")
                mode = "r"
            else:
                continue
            
            cleanup_evals(mag, scenario, trial_id, mode)
            
    print(f"Finished. Sanitized {count} files.")

if __name__ == "__main__":
    main()
