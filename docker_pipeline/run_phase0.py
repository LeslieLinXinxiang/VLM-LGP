# pipelines/run_phase0.py
print(">>> [DEBUG] Module pipelines.run_phase0 is loading...")

import sys
import os
import json

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

try:
    # from core.vlm import VLMClient  # Phase0 no longer uses VLM
    from core.utils import parse_and_inject, extract_mapping_from_layout
    from core.phase0_parser import (
        build_phase0_layout_from_unnamed_g,
        split_infeasible_objects_from_reachability,
    )
    print(">>> [DEBUG] Imports successful.")
except ImportError as e:
    print(f">>> [FATAL ERROR] Import failed: {e}")
    sys.exit(1)


def _normalize_scene_include(scene_path, root_dir):
    if not os.path.exists(scene_path):
        return
    with open(scene_path, "r") as f:
        content = f.read()

    abs_panda = os.path.join(root_dir, "rai", "test", "newLGP", "rai-robotModels", "panda", "panda.g")
    content = content.replace(
        "Include: <../../../rai/test/newLGP/rai-robotModels/panda/panda.g>",
        f"Include: <{abs_panda}>",
    )
    content = content.replace(
        'mesh:"../generated/triangular_prism.obj"',
        f'mesh:"{os.path.join(root_dir, "generated", "triangular_prism.obj")}"',
    )

    with open(scene_path, "w") as f:
        f.write(content)

# [INTERFACE FIX] 默认改为 direct unnamed.g parser (Task-012)
def execute_phase0(image_path=None, use_vlm=False, unnamed_g_path=None, infeasible_output_path=None):
    print(">>> STARTING PHASE 0: WORLD BINDING")

    # Phase0 no longer relies on VLM. Keep flag for compatibility only.
    if use_vlm:
        print("[Phase0] use_vlm=True is deprecated and ignored; forcing RULE_DIRECT_G.")
        use_vlm = False
    
    root_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    
    # 定义物理路径锚点
    unnamed_g = unnamed_g_path or os.path.join(root_dir, "unnamed.g")
    layout_json = os.path.join(root_dir, "generated/phase0_layout.json")
    scene_named_g = os.path.join(root_dir, "generated/scene/scene_named.g")
    infeasible_json = infeasible_output_path or os.path.join(root_dir, "generated/infeasible_objects.json")

    if not use_vlm:
        print("[Step 1] RULE_DIRECT_G mode (no VLM)")
        if not os.path.exists(unnamed_g):
            print(f"[ERROR] unnamed.g not found: {unnamed_g}")
            return

        layout_list = build_phase0_layout_from_unnamed_g(unnamed_g)
        os.makedirs(os.path.dirname(layout_json), exist_ok=True)
        with open(layout_json, 'w') as f:
            json.dump(layout_list, f, indent=2)

        mapping_dict = extract_mapping_from_layout(layout_list)
        print(f"[Step 2] Injecting Names... ({len(mapping_dict)} objects)")
        parse_and_inject(unnamed_g, mapping_dict, scene_named_g)
        _normalize_scene_include(scene_named_g, root_dir)

        print("[Step 3] Reachability split")
        infeasible_report = split_infeasible_objects_from_reachability(
            root_dir=root_dir,
            scene_named_g_path=scene_named_g,
            layout_list=layout_list,
        )
        with open(infeasible_json, 'w') as f:
            json.dump(infeasible_report, f, indent=2)

        print(f">>> PHASE 0 COMPLETE. Layout: {layout_json}")
        print(f">>> PHASE 0 COMPLETE. Infeasible: {infeasible_json}")
        print(f">>> PHASE 0 COMPLETE. Scene Ready: {scene_named_g}")
        return
    
    # Legacy Phase0 VLM branch intentionally removed.
    return

if __name__ == "__main__":
    execute_phase0()