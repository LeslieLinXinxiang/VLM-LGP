import os
import re
from pathlib import Path

ROOT_DIR = Path(__file__).resolve().parents[1]
SCENE_DIR = ROOT_DIR / "experiments/scenes/fmb"

# User's provided replacements (matching the TYPED block in the request)
NEW_SLOTS = [
    'Table_Left (base_board) { Q:"t( 0.000 0.000  0.080) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }',
    'Table_Right (base_board) { Q:"t(0.000 0.000 -0.080) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }',
    'Table_Front (base_board) { Q:"t(0.059 0.000 0.000) ", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }',
    'Table_Back (base_board) { Q:"t(-0.061 0.000 0.000) ", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }',
    'Table_Center (base_board) { Q:"t(00 0.000 0.000) ", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }'
]

NEW_SHAPE_4_1_MESH = 'shape_4_1_mesh (shape_4_1) { Q:"t(0 0 0.0275) d(90 1 0 0) d(0 0 1 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", color:[1.0 0.5 0.2 1], contact:1, logical:{ is_object, is_box } }'
NEW_SHAPE_4_1_HANDLE = 'shape_4_1_handle (shape_4_1) { Q:"t(0 0 0.06) d(0 0 0 1)", shape:marker, size:[0.03], color:[1 1 0] }'

def update_file(file_path):
    with open(file_path, 'r') as f:
        lines = f.readlines()

    new_lines = []
    updated = False
    
    for line in lines:
        stripped = line.strip()
        
        # 1. Update Slots
        if stripped.startswith('Table_Left'):
            new_lines.append(NEW_SLOTS[0] + '\n')
            updated = True
        elif stripped.startswith('Table_Right'):
            new_lines.append(NEW_SLOTS[1] + '\n')
            updated = True
        elif stripped.startswith('Table_Front'):
            new_lines.append(NEW_SLOTS[2] + '\n')
            updated = True
        elif stripped.startswith('Table_Back'):
            new_lines.append(NEW_SLOTS[3] + '\n')
            updated = True
        elif stripped.startswith('Table_Center'):
            new_lines.append(NEW_SLOTS[4] + '\n')
            updated = True
        
        # 2. Update shape_4_1 Parent (Keep random Q)
        elif stripped.startswith('shape_4_1 (table)'):
            # Extract the Q:"..." part
            m = re.search(r'Q:"([^"]+)"', line)
            if m:
                q_part = m.group(0)
                new_line = f'shape_4_1 (table) {{ {q_part}, joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.0], color:[1.0 0.5 0.2], contact:0, logical:{{ is_object }} }}\n'
                new_lines.append(new_line)
                updated = True
            else:
                new_lines.append(line)
        
        # 3. Update shape_4_1_mesh
        elif stripped.startswith('shape_4_1_mesh'):
            new_lines.append(NEW_SHAPE_4_1_MESH + '\n')
            updated = True
            
        # 4. Update shape_4_1_handle
        elif stripped.startswith('shape_4_1_handle'):
            new_lines.append(NEW_SHAPE_4_1_HANDLE + '\n')
            updated = True
            
        else:
            new_lines.append(line)

    if updated:
        with open(file_path, 'w') as f:
            f.writelines(new_lines)
        return True
    return False

def main():
    count = 0
    for root, dirs, files in os.walk(SCENE_DIR):
        for file in files:
            if file.endswith('.g'):
                path = os.path.join(root, file)
                if update_file(path):
                    count += 1
    print(f"Successfully updated {count} files.")

if __name__ == "__main__":
    main()
