import os
from pathlib import Path

BASE_BOARD_DEF = """
base_board (table) {
  Q:"t(0.45 0.00 0.075) d(90 1 0 0 )",
  joint:rigid,
  shape:mesh,
  mesh:\"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj\",
  color:[0.75 0.75 0.75 1],
  contact:1,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
  mass:0.5,
  logical:{ is_object, is_place }
}
"""

def repair_file(p):
    content = p.read_text()
    if "base_board (table)" in content:
        return False
    
    import re
    # Match any number of whitespaces around the stray brace between finger_joint2 and Fixed placement
    # Using a very loose match for the whole block
    if "Table_Left (base_board)" in content:
        # 1. Remove the stray brace line
        content = re.sub(r"\n\s+\}\s+\n", "\n", content)
        # 2. Insert base_board definition before Table_Left
        new_content = content.replace("Table_Left (base_board)", BASE_BOARD_DEF + "\nTable_Left (base_board)")
        p.write_text(new_content)
        return True
        
    return False

def main():
    root = Path("/home/leslie/Projects/VLM_LGP/experiments/scenes/fmb")
    count = 0
    files = list(root.glob("**/*.g"))
    print(f"Found {len(files)} .g files.")
    for p in files:
        if repair_file(p):
            count += 1
    print(f"Repaired {count} files.")

if __name__ == "__main__":
    main()
