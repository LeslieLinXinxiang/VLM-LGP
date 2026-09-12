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

# Per-benchmark vocabulary. Cube stacking and FMB name their base object differently,
# draw from different shape vocabularies, and use different position words (FMB has no
# "center" and adds front/back). Validating FMB against the cube vocabulary rejects every
# FMB graph, correct ones included.
BENCHMARK_VOCAB = {
    "cube": {
        "base_name": "table",
        "type_keywords": ("cube", "prism", "cylinder", "table"),
        "positions": {"left", "center", "right"},
    },
    "fmb": {
        "base_name": "base",
        "type_keywords": ("shape", "base"),
        # The FMB prompt asks for the position key to be omitted rather than set to
        # "center", but ~13% of outputs write it anyway. It carries the same meaning and
        # phase2_codegen already maps it to Table_Center, so rejecting it would be
        # stricter than the rest of the pipeline.
        "positions": {"left", "right", "front", "back", "center"},
    },
}

# Position words ordered along the axis the labels describe, so that a bridging object's
# supporters can be checked for contiguity. Cube stacking spans left-center-right; FMB
# spans front-(unlabelled centre)-back and left-(unlabelled centre)-right.
_POSITION_ORDER = {"left": 0, "front": 0, "center": 1, "right": 2, "back": 2}


def _support_layers(supporters_by_id):
    """Layer index per object: 0 for the base, else one above its highest supporter."""
    layers = {i: 0 for i, sup in supporters_by_id.items() if not sup}
    for _ in range(len(supporters_by_id)):
        for i, sup in supporters_by_id.items():
            if i in layers or not sup:
                continue
            if all(s in layers for s in sup):
                layers[i] = max(layers[s] for s in sup) + 1
    return layers


def _position_slot(obj_id, supporters_by_id, positions_by_id):
    """Where an object sits on the labelled axis, following single-supporter chains
    upward until a position label is found. Returns None if the object's placement is
    not pinned down by any label."""
    seen = set()
    node = obj_id
    while node is not None and node not in seen:
        seen.add(node)
        sup = supporters_by_id.get(node, [])
        if len(sup) != 1:
            return None
        label = positions_by_id.get(node, {}).get(sup[0], "")
        if label in _POSITION_ORDER:
            return _POSITION_ORDER[label]
        node = sup[0]
    return None


def _check_support_geometry(obj_by_id):
    """Two physical-plausibility checks on a bridging object's supporters. Both read
    only the predicted graph — no ground truth about the target is used.

    1. A rigid object cannot rest on supporters at different heights.
    2. A rigid object spanning two supports also touches anything of the same height
       standing between them, so its supporter set must be contiguous along the axis
       the position labels describe.
    """
    supporters, positions = {}, {}
    for obj_id, obj in obj_by_id.items():
        edges = [e for e in obj.get("edges", []) if isinstance(e, dict)]
        supporters[obj_id] = [e.get("supporter") for e in edges if isinstance(e.get("supporter"), int)]
        positions[obj_id] = {
            e.get("supporter"): str(e.get("position") or "").lower() for e in edges
        }

    layers = _support_layers(supporters)
    errors = []

    for obj_id, sup in supporters.items():
        if len(sup) < 2:
            continue

        sup_layers = {layers.get(s) for s in sup}
        if None not in sup_layers and len(sup_layers) > 1:
            errors.append(
                f"- [Object {obj_id}] supporters {sorted(sup)} are at different heights "
                f"(layers {sorted(l for l in sup_layers)}); an object cannot rest on supports "
                f"at different levels."
            )
            continue

        slots = {s: _position_slot(s, supporters, positions) for s in sup}
        if any(v is None for v in slots.values()):
            continue
        low, high = min(slots.values()), max(slots.values())
        own_layer = layers.get(sup[0])
        for other in supporters:
            if other == obj_id or other in sup or layers.get(other) != own_layer:
                continue
            other_slot = _position_slot(other, supporters, positions)
            if other_slot is not None and low < other_slot < high:
                errors.append(
                    f"- [Object {obj_id}] spans supporters {sorted(sup)} but omits object "
                    f"{other}, which stands between them at the same height and must also "
                    f"be a supporter."
                )

    return errors


def validate_plan(plan_json, valid_inventory_list, benchmark="cube"):
    """
    Validates VLM output with dual-schema compatibility:
    - New schema: {"objects": [{"id", "object", "on"}, ...]}
    - Legacy schema: {"assembly_nodes": [...]} (kept for compatibility)

    `benchmark` selects the vocabulary ("cube" or "fmb"). All checks are internal
    consistency checks on the predicted graph alone; nothing here uses ground truth
    about the target structure.
    """
    errors = []
    vocab = BENCHMARK_VOCAB.get(str(benchmark).lower(), BENCHMARK_VOCAB["cube"])

    # Prefer object-list schema if present.
    if isinstance(plan_json, dict) and "objects" in plan_json:
        objects = plan_json.get("objects")
        if not isinstance(objects, list) or not objects:
            return False, "CRITICAL: 'objects' must be a non-empty array."

        # Flexible object-type check: accept any name containing a known shape keyword.
        # This is intentionally permissive to avoid wasting tokens on name retries.
        def _is_valid_obj_type(name):
            if not isinstance(name, str): return False
            n = name.lower().replace(" ", "").replace("-", "")
            return any(kw in n for kw in vocab["type_keywords"])

        allowed_positions = vocab["positions"]

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
                if str(table_obj.get("object", "")).lower() != vocab["base_name"]:
                    errors.append(f"- id 0 object must be '{vocab['base_name']}' in edges schema.")
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

                if not _is_valid_obj_type(obj_name):
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
                errors.append(
                    f"- at least one object must be supported by the {vocab['base_name']} (supporter=0)."
                )

            errors.extend(_check_support_geometry(obj_by_id))

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

            n = str(obj_name).lower().replace(" ", "").replace("-", "")
            if not any(kw in n for kw in ("cube", "prism", "cylinder", "table")):
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

def execute_phase1(target_img_path=None, output_json_path=None, prompt_path=None):
    """
    Returns: (bool success, str output_path)
    """
    print(">>> STARTING PHASE 1: ASSEMBLY PLANNING (Closed-Loop)")
    
    root_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    layout_json = os.path.join(root_dir, "generated/phase0_layout.json")
    prompt_file = prompt_path if prompt_path else os.path.join(root_dir, "prompts/phase1_graph_planner.md")
    # The prompt file identifies the benchmark, which fixes the validator's vocabulary.
    benchmark = "fmb" if "fmb" in os.path.basename(prompt_file).lower() else "cube"
    test_dir = os.path.join(root_dir, "test")
    if output_json_path:
        output_graph_json = output_json_path
    else:
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
    if os.path.abspath(target_img_path) != os.path.abspath(global_target_path):
        shutil.copy(target_img_path, global_target_path)
        print(f"[Phase1] Saved global target reference to: {global_target_path}")
    else:
        print(f"[Phase1] Global target reference already at: {global_target_path}")

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
            is_valid, report = validate_plan(plan_json, mapping_list, benchmark)
            
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