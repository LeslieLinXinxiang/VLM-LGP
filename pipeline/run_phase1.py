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
    Validates VLM output with dual-schema compatibility:
    - New schema: {"objects": [{"id", "object", "on"}, ...]}
    - Legacy schema: {"assembly_nodes": [...]} (kept for compatibility)
    """
    errors = []

    # Prefer object-list schema if present.
    if isinstance(plan_json, dict) and "objects" in plan_json:
        objects = plan_json.get("objects")
        if not isinstance(objects, list) or not objects:
            return False, "CRITICAL: 'objects' must be a non-empty array."

        allowed_objects = {"Triangular Prism", "Cube", "Rectangular Prism", "Cylinder"}
        allowed_positions = {"left", "center", "right"}

        ids = []
        for obj in objects:
            if not isinstance(obj, dict):
                errors.append("- object entry must be JSON object.")
                continue
            ids.append(obj.get("id"))

        if any(not isinstance(i, int) for i in ids):
            errors.append("- all object ids must be integers.")
        if len(ids) != len(set(ids)):
            errors.append("- object ids must be unique.")

        valid_id_set = set(i for i in ids if isinstance(i, int))
        expected_id_set = set(range(len(objects)))
        if valid_id_set != expected_id_set:
            errors.append("- object ids must be consecutive and exactly 0..N-1.")

        # New format: objects + edges[{supporter, position?}]
        has_edges_schema = any(isinstance(obj, dict) and "edges" in obj for obj in objects)
        if has_edges_schema:
            obj_by_id = {obj.get("id"): obj for obj in objects if isinstance(obj, dict) and isinstance(obj.get("id"), int)}

            table_obj = obj_by_id.get(0)
            if not isinstance(table_obj, dict):
                errors.append("- id 0 table object is required in edges schema.")
            else:
                if str(table_obj.get("object", "")).lower() != "table":
                    errors.append("- id 0 object must be 'table' in edges schema.")
                table_edges = table_obj.get("edges")
                if not isinstance(table_edges, list) or table_edges:
                    errors.append("- id 0 table must have empty 'edges': [].")

            has_table_support = False
            for obj in objects:
                if not isinstance(obj, dict):
                    continue

                obj_id = obj.get("id")
                obj_name = obj.get("object")
                edges = obj.get("edges")

                if obj_id == 0:
                    continue

                if obj_name not in allowed_objects:
                    errors.append(f"- [Object {obj_id}] invalid object type: {obj_name!r}.")

                if not isinstance(edges, list) or not edges:
                    errors.append(f"- [Object {obj_id}] 'edges' must be a non-empty array.")
                    continue

                supporter_set = set()
                for edge in edges:
                    if not isinstance(edge, dict):
                        errors.append(f"- [Object {obj_id}] edge entry must be JSON object.")
                        continue

                    supporter = edge.get("supporter")
                    if not isinstance(supporter, int):
                        errors.append(f"- [Object {obj_id}] edge.supporter must be integer.")
                        continue

                    if supporter not in valid_id_set:
                        errors.append(f"- [Object {obj_id}] supporter id {supporter} not found.")
                    if isinstance(obj_id, int) and supporter >= obj_id:
                        errors.append(f"- [Object {obj_id}] supporter id {supporter} must satisfy supporter < id.")

                    if supporter in supporter_set:
                        errors.append(f"- [Object {obj_id}] duplicate supporter id {supporter} in edges.")
                    supporter_set.add(supporter)

                    if supporter == 0:
                        has_table_support = True

                    if "position" in edge:
                        pos = edge.get("position")
                        if not isinstance(pos, str) or pos.lower() not in allowed_positions:
                            errors.append(
                                f"- [Object {obj_id}] invalid position {pos!r}. Must be one of {sorted(allowed_positions)}."
                            )

            if not has_table_support:
                errors.append("- at least one object must be supported by table (supporter=0).")

            if errors:
                return False, "\n".join(errors)
            return True, "Valid (edges schema)"

        has_table_support = False
        for obj in objects:
            if not isinstance(obj, dict):
                continue

            obj_id = obj.get("id")
            obj_name = obj.get("object")
            on_list = obj.get("on")

            if obj_name not in allowed_objects:
                errors.append(f"- [Object {obj_id}] invalid object type: {obj_name!r}.")

            if not isinstance(on_list, list) or not on_list:
                errors.append(f"- [Object {obj_id}] 'on' must be a non-empty array.")
                continue

            for supporter in on_list:
                if supporter == "table":
                    has_table_support = True
                    continue

                if not isinstance(supporter, int):
                    errors.append(f"- [Object {obj_id}] supporter {supporter!r} must be int or 'table'.")
                    continue

                if supporter not in valid_id_set:
                    errors.append(f"- [Object {obj_id}] supporter id {supporter} not found.")
                    continue

                if isinstance(obj_id, int) and supporter >= obj_id:
                    errors.append(f"- [Object {obj_id}] supporter id {supporter} must satisfy supporter < id.")

        if not has_table_support:
            errors.append("- at least one object must be supported by 'table'.")

        if errors:
            return False, "\n".join(errors)
        return True, "Valid (on-list schema)"

    # Legacy schema fallback.
    valid_ids = set(item["logical_id"] for item in valid_inventory_list if "logical_id" in item)
    valid_generics = {"base", "cylinder", "table"}
    valid_slots = {
        "top_left", "top_center", "top_right",
        "mid_left", "center", "mid_right",
        "bottom_left", "bottom_center", "bottom_right",
        "place_base1", None,
    }

    if "assembly_nodes" not in plan_json:
        return False, "CRITICAL: JSON output must contain root key 'objects' (new) or 'assembly_nodes' (legacy)."

    for node in plan_json.get("assembly_nodes", []):
        node_id = node.get("node_id", "?")
        for action in node.get("actions", []):
            obj = action.get("object")
            supports = action.get("placed_on")
            slot = action.get("at_slot")

            if obj not in valid_ids and obj not in valid_generics:
                errors.append(
                    f"- [Node {node_id}] Object '{obj}' is invalid. Must be in inventory or generic {valid_generics}."
                )

            if isinstance(supports, str):
                supports = [supports]
            elif supports is None:
                supports = []

            for supporter in supports:
                if supporter not in valid_ids and supporter not in valid_generics:
                    errors.append(f"- [Node {node_id}] Support '{supporter}' is invalid.")

            if slot not in valid_slots:
                errors.append(f"- [Node {node_id}] Slot '{slot}' is invalid. Must be one of {valid_slots}.")

    if errors:
        return False, "\n".join(errors)
    return True, "Valid (legacy schema)"

def execute_phase1(target_img_path=None):
    """
    Returns: (bool success, str output_path)
    """
    print(">>> STARTING PHASE 1: ASSEMBLY PLANNING (Closed-Loop)")
    
    root_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    layout_json = os.path.join(root_dir, "generated/phase0_layout.json")
    prompt_file = os.path.join(root_dir, "prompts/phase1_graph_planner.md")
    test_dir = os.path.join(root_dir, "test")
    output_graph_json = os.path.join(root_dir, "generated/phase1_target_graph.json")

    mapping_list = load_json(layout_json)
    if not mapping_list:
        print("[ERROR] Phase 0 data missing.")
        return False, None
        
    if not os.path.exists(test_dir): os.makedirs(test_dir)
    
    # 1. UI Selection (Bypass if target_img_path is provided)
    if not target_img_path:
        target_img_path = select_file_gui(test_dir)
    else:
        print(f"[Phase1] Headless Mode: Using provided image: {target_img_path}")
        
    if not target_img_path or not os.path.exists(target_img_path): 
        print(f"[Error] Target image missing or not selected.")
        return False, None
    
    # 2. [CRITICAL FIX] Save as "phase1_target.png" so Driver/Slicer can find it
    global_target_path = os.path.join(root_dir, "generated", "phase1_target.png")
    shutil.copy(target_img_path, global_target_path)
    print(f"[Phase1] Saved global target reference to: {global_target_path}")

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
                example_content=None,  # [DISABLED] incontext examples removed
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