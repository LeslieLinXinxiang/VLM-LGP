print(">>> [DEBUG] Module pipelines.run_phase1 is loading...")

import sys
import os
import json
import shutil
import tkinter as tk
from tkinter import filedialog

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

try:
    from core.vlm import VLMClient
    from core.utils import load_json
    from core.utils import load_json, load_incontext_examples 
except ImportError as e:
    print(f">>> [FATAL ERROR] Import failed: {e}")
    sys.exit(1)

def select_file_gui(initial_dir):
    root = tk.Tk()
    root.withdraw()
    print(">>> [UI] Waiting for file selection...")
    file_path = filedialog.askopenfilename(
        initialdir=initial_dir,
        title="Select Test Image (Target Graph)",
        filetypes=[("Images", "*.png *.jpg *.jpeg"), ("All Files", "*.*")]
    )
    root.destroy()
    return file_path

def validate_plan(plan_json, valid_inventory_list):
    """
    Validates the VLM output.
    [V60.0 UPDATE]: Now uses the 2D-Native coordinate system.
    """
    errors = []
    
    # Get specific IDs from inventory
    valid_ids = set(item['logical_id'] for item in valid_inventory_list if 'logical_id' in item)
    
    # Define Allowed Generic Types
    VALID_GENERICS = {"base", "cylinder", "table"} 
    
    # [CRITICAL FIX] Update the whitelist to the new 2D terms
    VALID_SLOTS = {
        "top_left", "top_center", "top_right",
        "mid_left", "center", "mid_right",
        "bottom_left", "bottom_center", "bottom_right",
        "place_base1", None
    }

    if "assembly_nodes" not in plan_json:
        return False, "CRITICAL: JSON output must contain root key 'assembly_nodes'."

    for node in plan_json.get("assembly_nodes", []):
        node_id = node.get("node_id", "?")
        for action in node.get("actions", []):
            obj = action.get("object")
            supports = action.get("placed_on")
            slot = action.get("at_slot")

            # --- CHECK A: OBJECT ---
            if obj not in valid_ids and obj not in VALID_GENERICS:
                errors.append(f"- [Node {node_id}] Object '{obj}' is invalid. Must be in inventory or generic {VALID_GENERICS}.")
            
            # --- CHECK B: SUPPORTS ---
            if isinstance(supports, str): 
                supports = [supports]
            elif supports is None: 
                supports = []
                
            for s in supports:
                if s not in valid_ids and s not in VALID_GENERICS:
                    errors.append(f"- [Node {node_id}] Support '{s}' is invalid.")

            # --- CHECK C: SLOT ---
            if slot not in VALID_SLOTS:
                errors.append(f"- [Node {node_id}] Slot '{slot}' is invalid. Must be one of {VALID_SLOTS}.")

    if errors: return False, "\n".join(errors)
    return True, "Valid"

def execute_phase1():
    """
    Returns: (bool success, str output_path)
    """
    print(">>> STARTING PHASE 1: ASSEMBLY PLANNING (Closed-Loop)")
    
    root_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    layout_json = os.path.join(root_dir, "generated/phase0_layout.json")
    prompt_file = os.path.join(root_dir, "prompts/phase1_graph_planner.md")
    test_dir = os.path.join(root_dir, "test")
    output_graph_json = os.path.join(root_dir, "generated/phase1_target_graph.json")

    train_dir = os.path.join(root_dir, "incontext_training", "orientations")
    
    mapping_list = load_json(layout_json)
    if not mapping_list:
        print("[ERROR] Phase 0 data missing.")
        return False, None
        
    if not os.path.exists(test_dir): os.makedirs(test_dir)
    
    # 1. UI Selection
    target_img_path = select_file_gui(test_dir)
    if not target_img_path: 
        print("[Info] No file selected. Aborting.")
        return False, None
    
    # 2. [CRITICAL FIX] Save as "phase1_target.png" so Driver/Slicer can find it
    global_target_path = os.path.join(root_dir, "generated", "phase1_target.png")
    shutil.copy(target_img_path, global_target_path)
    print(f"[Phase1] Saved global target reference to: {global_target_path}")

    print(f"[Phase1] Loading In-Context Examples from: {train_dir}")
    example_data = load_incontext_examples(train_dir)
    
    vlm = VLMClient()
    max_attempts = 3
    feedback_buffer = None
    
    for i in range(max_attempts):
        print(f"\n[Step 3] Planning Iteration {i+1}/{max_attempts}")
        try:
            # Phase 1 VLM Call (Generic Mode)
            plan_json = vlm.generate_assembly_plan(
                target_img_path, 
                prompt_file, 
                example_content=example_data, 
                feedback_context=feedback_buffer
            )
            
            # Validate using the relaxed logic
            is_valid, report = validate_plan(plan_json, mapping_list)
            
            if is_valid:
                print(f"   >>> [PASS] Inspector approved.")
                with open(output_graph_json, 'w') as f:
                    json.dump(plan_json, f, indent=2)
                return True, output_graph_json
            else:
                print(f"   >>> [FAIL] Inspector rejected:\n{report}")
                feedback_buffer = f"[SYSTEM FEEDBACK]:\nFix these errors:\n{report}\nDo not hallucinate."
                
        except Exception as e:
            print(f"[Error] {e}")

    print("\n[FATAL] VLM failed to converge.")
    return False, None

if __name__ == "__main__":
    execute_phase1()