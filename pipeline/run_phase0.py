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
    print(">>> [DEBUG] Imports successful.")
except ImportError as e:
    print(f">>> [FATAL ERROR] Import failed: {e}")
    sys.exit(1)


def _save_layout(layout_data, layout_path):
    os.makedirs(os.path.dirname(layout_path), exist_ok=True)
    with open(layout_path, "w") as f:
        json.dump(layout_data, f, indent=2)


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
    use_vlm=True,
    auto_prepare_from_named_scene=True,
    layout_output_path=None,
):
    """
    Phase0 dual-mode entry.

    Args:
        image_path: Optional scene image path.
        scene_named_g_path: Named scene file used for reverse-building unnamed/specs.
        use_vlm: True -> VLM semantic matching; False -> rule-based direct mapping.
        auto_prepare_from_named_scene: Whether to generate unnamed.g/specs.json from named scene.
        layout_output_path: Optional layout json output path.
    """
    print(">>> STARTING PHASE 0: WORLD BINDING")
    
    root_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))

    unnamed_g_default = os.path.join(root_dir, "test/scene/unnamed.g")
    unnamed_g_generated = os.path.join(root_dir, "generated/scene/unnamed.g")
    unnamed_g = unnamed_g_default

    if scene_named_g_path is None:
        scene_named_g_path = os.path.join(root_dir, "generated/scene_named.g")

    specs_json = os.path.join(root_dir, "generated/phase0_specs.json")
    prompt_file = os.path.join(root_dir, "prompts/phase0_binding_prompt.md")
    
    capture_png = os.path.join(root_dir, "generated/phase0_capture.png")
    layout_json = layout_output_path or os.path.join(root_dir, "generated/phase0_layout.json")
    scene_named_g = os.path.join(root_dir, "generated/scene/scene_named.g")

    reverse_mapping = None

    # 0. Reverse preparation: named scene -> unnamed scene + specs
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
    
    # 1. Build layout by mode
    if use_vlm:
        print("[Step 1] Mode=VLM")

        # 1A. Image acquisition
        if image_path:
            print("   -> Headless image injection")
            print(f"   -> Source: {image_path}")

            if not os.path.exists(image_path):
                print(f"[ERROR] Source image not found: {image_path}")
                return None

            os.makedirs(os.path.dirname(capture_png), exist_ok=True)
            shutil.copy(image_path, capture_png)
            import cv2
            img = cv2.imread(capture_png)
        else:
            print("   -> Native render via SimCamera")
            try:
                from core.vision import SimCamera
                sim = SimCamera(unnamed_g)
                img = sim.capture(save_path=capture_png)
            except Exception as e:
                print(f"[ERROR] Vision module failed: {e}")
                return None

        # 1B. VLM matching
        print("[Step 2] VLM Semantic Matching...")
        try:
            from core.vlm import VLMClient
            vlm = VLMClient()
            vlm_results_list = vlm.match_objects(img, specs_json, prompt_file)
        except Exception as e:
            print(f"[ERROR] VLM module failed: {e}")
            import traceback

            traceback.print_exc()
            return None
    else:
        print("[Step 1] Mode=RULE (No VLM)")
        if not reverse_mapping:
            if not os.path.exists(scene_named_g_path):
                print(f"[ERROR] Named scene not found: {scene_named_g_path}")
                return None

            result = build_phase0_assets_from_named_scene(
                scene_named_path=scene_named_g_path,
                specs_output_path=specs_json,
                unnamed_scene_output_path=unnamed_g_generated,
            )
            reverse_mapping = result.get("mapping", [])
            unnamed_g = unnamed_g_generated

        vlm_results_list = reverse_mapping

    _save_layout(vlm_results_list, layout_json)
    specs_index = _load_specs_index(specs_json)
    vlm_results_list = _enrich_layout(vlm_results_list, specs_index)
    _save_layout(vlm_results_list, layout_json)
    
    # 2. Data Cleaning
    print(f"[Step 3] Transforming Data...")
    try:
        mapping_dict = extract_mapping_from_layout(vlm_results_list)
        print(f"   -> Extracted {len(mapping_dict)} objects.")

        # 3. Injection
        print(f"[Step 4] Injecting Names...")
        parse_and_inject(unnamed_g, mapping_dict, scene_named_g)
        print(f">>> PHASE 0 COMPLETE. Scene Ready: {scene_named_g}")

        return {
            "success": True,
            "layout_path": layout_json,
            "scene_named_path": scene_named_g,
            "specs_path": specs_json,
            "unnamed_scene_path": unnamed_g,
        }
    except Exception as e:
        print(f"[ERROR] Data injection failed: {e}")
        return None

if __name__ == "__main__":
    execute_phase0()