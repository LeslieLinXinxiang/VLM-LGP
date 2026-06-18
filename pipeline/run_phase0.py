# pipelines/run_phase0.py
print(">>> [DEBUG] Module pipelines.run_phase0 is loading...")

import sys
import os
import json
import shutil # [NEW] 用于文件复制

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

try:
    # 延迟加载 SimCamera，防止在 Docker 环境下因为导入 GUI 库而崩溃
    # from core.vision import SimCamera 
    from core.utils import parse_and_inject, extract_mapping_from_layout
    from core.scene_spec_builder import build_phase0_assets_from_named_scene
    from core.phase0_parser import (
        build_phase0_layout_from_unnamed_g,
        split_infeasible_objects_from_reachability,
        split_infeasible_objects_from_reachability_field,
    )

    # [NEW] Import manipulability tool
    sys.path.append(os.path.join(os.path.abspath(os.path.dirname(__file__)), "..", "test", "manipulability"))
    from urdf_static_manipulability import compute_static_manipulability_report

    print(">>> [DEBUG] Imports successful.")
except ImportError as e:
    print(f">>> [FATAL ERROR] Import failed: {e}")
    sys.exit(1)


def _save_layout(layout_data, layout_path):
    os.makedirs(os.path.dirname(layout_path), exist_ok=True)
    with open(layout_path, "w") as f:
        json.dump(layout_data, f, indent=2)


def _normalize_scene_include(scene_path, root_dir):
    """Ensure generated scene uses a stable absolute panda include path."""
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


def _load_specs_index(specs_path):
    if not os.path.exists(specs_path):
        return {}
    with open(specs_path, "r") as f:
        data = json.load(f)
    index = {}
    for item in data:
        anon_id = item.get("anon_id")
        if anon_id:
            index[anon_id] = item
    return index


def _enrich_layout(layout_list, specs_index):
    enriched = []
    for item in layout_list:
        if not isinstance(item, dict):
            continue
        merged = dict(item)
        spec = specs_index.get(item.get("anon_id"), {})

        # Keep compatibility: preserve `shape`, add discriminative fields.
        if "shape" not in merged and "shape" in spec:
            merged["shape"] = spec["shape"]
        if "object_type" not in merged and "object_type" in spec:
            merged["object_type"] = spec["object_type"]
        if "size_signature" not in merged and "size_signature" in spec:
            merged["size_signature"] = spec["size_signature"]
        if "color_rgb" not in merged and "color_rgb" in spec:
            merged["color_rgb"] = spec["color_rgb"]

        enriched.append(merged)
    return enriched


def execute_phase0(
    image_path=None,
    scene_named_g_path=None,
    use_vlm=False,
    auto_prepare_from_named_scene=False,
    layout_output_path=None,
    unnamed_g_path=None,
    infeasible_output_path=None,
    reachability_mode="legacy_checker",
    reachability_score_output_path=None,
    reachability_alpha=0.6,
    reachability_beta=0.4,
    reachability_tau_r=0.45,
    reachability_seed=42,
    use_komo_policy_gate=True,
    disable_physics_reordering=False,
):
    """
    Phase0 deterministic entry.

    Args:
        image_path: Deprecated in Phase0 (kept only for compatibility).
        scene_named_g_path: Named scene file used for reverse-building unnamed/specs.
        use_vlm: Deprecated in Phase0 and ignored.
        auto_prepare_from_named_scene: Whether to generate unnamed.g/specs.json from named scene.
        layout_output_path: Optional layout json output path.
    """
    print(">>> STARTING PHASE 0: WORLD BINDING")

    # Phase0 no longer relies on VLM. Keep the flag for backward-compatible callers.
    if use_vlm:
        print("[Phase0] use_vlm=True is deprecated and ignored; forcing RULE_DIRECT_G.")
        use_vlm = False
    
    root_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))

    unnamed_g_default = os.path.join(root_dir, "unnamed.g")
    unnamed_g_generated = os.path.join(root_dir, "generated/scene/unnamed.g")
    unnamed_g = unnamed_g_path or unnamed_g_default

    if scene_named_g_path is None:
        scene_named_g_path = os.path.join(root_dir, "generated/scene_named.g")

    specs_json = os.path.join(root_dir, "generated/phase0_specs.json")
    prompt_file = os.path.join(root_dir, "prompts/phase0_binding_prompt.md")
    
    capture_png = os.path.join(root_dir, "generated/phase0_capture.png")
    layout_json = layout_output_path or os.path.join(root_dir, "generated/phase0_layout.json")
    infeasible_json = infeasible_output_path or os.path.join(root_dir, "generated/infeasible_objects.json")
    reachability_score_json = reachability_score_output_path or os.path.join(root_dir, "generated/reachability_score_report.json")
    scene_named_g = os.path.join(root_dir, "generated/scene/scene_named.g")

    reverse_mapping = None

    # 0. Reverse preparation: named scene -> unnamed scene + specs (optional, legacy flow)
    if auto_prepare_from_named_scene:
        print("[Step 0] Reverse-Build: scene_named.g -> unnamed.g + specs.json")
        result = build_phase0_assets_from_named_scene(
            scene_named_path=scene_named_g_path,
            specs_output_path=specs_json,
            unnamed_scene_output_path=unnamed_g_generated,
        )
        reverse_mapping = result.get("mapping", [])
        unnamed_g = unnamed_g_generated
        print(f"   -> Built specs: {specs_json}")
        print(f"   -> Built unnamed scene: {unnamed_g}")
        print(f"   -> Objects mapped: {len(reverse_mapping)}")

    # 1. Preferred mode: parse unnamed.g directly (Task-012)
    if not use_vlm:
        print("[Step 1] Mode=RULE_DIRECT_G (No VLM)")
        if not os.path.exists(unnamed_g):
            print(f"[ERROR] unnamed.g not found: {unnamed_g}")
            return None

        try:
            layout_list = build_phase0_layout_from_unnamed_g(unnamed_g)
            _save_layout(layout_list, layout_json)

            mapping_dict = extract_mapping_from_layout(layout_list)
            print(f"[Step 2] Injecting Names: {len(mapping_dict)} objects")
            parse_and_inject(unnamed_g, mapping_dict, scene_named_g)
            _normalize_scene_include(scene_named_g, root_dir)

            print(f"[Step 3] Reachability split mode={reachability_mode}")
            if reachability_mode == "gmm_esdf_mvp":
                infeasible_report, score_report = split_infeasible_objects_from_reachability_field(
                    root_dir=root_dir,
                    unnamed_g_path=unnamed_g,
                    scene_named_g_path=scene_named_g,
                    layout_list=layout_list,
                    alpha=reachability_alpha,
                    beta=reachability_beta,
                    tau_r=reachability_tau_r,
                    seed=reachability_seed,
                    use_komo_policy_gate=use_komo_policy_gate,
                )
                _save_layout(score_report, reachability_score_json)
                print(f">>> PHASE 0 COMPLETE. Reachability Score: {reachability_score_json}")
            else:
                infeasible_report = split_infeasible_objects_from_reachability(
                    root_dir=root_dir,
                    scene_named_g_path=scene_named_g,
                    layout_list=layout_list,
                )
            _save_layout(infeasible_report, infeasible_json)

            # [NEW] Physics-Aware Re-ordering (Manipulability + Reachability)
            if not disable_physics_reordering:
                print("[Step 4] Re-ordering inventory based on physical scores...")
                urdf_path = os.path.join(root_dir, "simulation/mujoco_ros2_control_examples/panda_resources/panda_description/urdf/panda.urdf")
                
                try:
                    # 1. Compute manipulability
                    manip_report = compute_static_manipulability_report(
                        layout_path=layout_json,
                        infeasible_path=infeasible_json,
                        g_path=unnamed_g,
                        urdf_path=urdf_path
                    )
                    
                    # 2. Merge scores and re-sort layout_list
                    # We want to sort primarily by (is_feasible, combined_score DESC)
                    # First, create a lookup for reachability scores from the report
                    reach_map = {row["logical_id"]: row.get("reachability_score", 0.0) for row in score_report.get("objects", [])}
                    manip_map = {row["logical_id"]: row.get("manipulability_score", 0.0) for row in manip_report.get("objects", [])}
                    
                    # Re-sort layout_list
                    def physics_score_key(item):
                        lid = item["logical_id"]
                        r_score = reach_map.get(lid, 0.0) or 0.0
                        m_score = manip_map.get(lid, 0.0) or 0.0
                        # Combined score (geometric mean or simple product)
                        combined = r_score * m_score
                        # We want high scores first. 
                        # Also group by object type to keep cube_N, rect_N grouping
                        return (item["object_type"], -combined, lid)

                    layout_list.sort(key=physics_score_key)
                    
                    # 3. Re-assign logical_ids based on new order
                    type_counters = {}
                    prefix_map = {"cylinder": "cyl", "cube": "cube", "rectprism": "rectprism", "longrect": "longrect", "triprism": "triprism", "mesh": "mesh"}
                    
                    new_mapping = {}
                    for item in layout_list:
                        ot = item["object_type"]
                        prefix = prefix_map.get(ot, ot)
                        type_counters[prefix] = type_counters.get(prefix, 0) + 1
                        new_id = f"{prefix}_{type_counters[prefix]}"
                        
                        # Update mapping from anon_id to this new physical-aware name
                        new_mapping[item["anon_id"]] = new_id
                        item["logical_id"] = new_id
                    
                    # 4. Final Injection with the new physics-aware mapping
                    print(f"[Step 5] Final Injection with physics-aware names: {len(new_mapping)} objects")
                    parse_and_inject(unnamed_g, new_mapping, scene_named_g)
                    _save_layout(layout_list, layout_json)
                    
                except Exception as e:
                    print(f"[WARNING] Physics-aware re-ordering failed, falling back to distance order: {e}")
            else:
                print("[Step 4] Skipping physics-aware re-ordering (disabled)")

            print(f">>> PHASE 0 COMPLETE. Layout: {layout_json}")
            print(f">>> PHASE 0 COMPLETE. Infeasible: {infeasible_json}")
            print(f">>> PHASE 0 COMPLETE. Scene Ready: {scene_named_g}")
            return {
                "success": True,
                "layout": layout_list,
                "layout_path": layout_json,
                "infeasible_path": infeasible_json,
                "scene_named_path": scene_named_g,
                "specs_path": specs_json,
                "unnamed_scene_path": unnamed_g,
                "reachability_mode": reachability_mode,
                "reachability_score_path": reachability_score_json if reachability_mode == "gmm_esdf_mvp" else None,
            }
        except Exception as e:
            print(f"[ERROR] Direct unnamed.g pipeline failed: {e}")
            return None
    
    # Legacy VLM path intentionally removed in Phase0.
    return None

if __name__ == "__main__":
    execute_phase0()