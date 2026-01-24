# pipelines/run_phase0.py
print(">>> [DEBUG] Module pipelines.run_phase0 is loading...")

import sys
import os
import json
import time

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

try:
    from core.vision import SimCamera
    from core.vlm import VLMClient
    from core.utils import parse_and_inject, extract_mapping_from_layout
    print(">>> [DEBUG] Imports successful.")
except ImportError as e:
    print(f">>> [FATAL ERROR] Import failed: {e}")
    sys.exit(1)

def execute_phase0():
    print(">>> STARTING PHASE 0: WORLD BINDING")
    
    root_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    
    unnamed_g = os.path.join(root_dir, "unnamed.g")
    specs_json = os.path.join(root_dir, "generated/phase0_specs.json")
    prompt_file = os.path.join(root_dir, "prompts/phase0_binding_prompt.md")
    
    capture_png = os.path.join(root_dir, "generated/phase0_capture.png")
    layout_json = os.path.join(root_dir, "generated/phase0_layout.json")
    scene_named_g = os.path.join(root_dir, "generated/scene/scene_named.g")
    
    # 2. Capture Scene
    print(f"[Step 1] Capturing Scene...")
    try:
        sim = SimCamera(unnamed_g)
        img = sim.capture(save_path=capture_png)
        # REMOVED: sim.close() - logic is handled by destructors
    except Exception as e:
        print(f"[ERROR] Vision module failed: {e}")
        return
    
    # 3. VLM Processing
    print(f"[Step 2] VLM Semantic Matching...")
    try:
        vlm = VLMClient()
        # Ensure match_objects exists in VLMClient now
        vlm_results_list = vlm.match_objects(img, specs_json, prompt_file)
    except Exception as e:
        print(f"[ERROR] VLM module failed: {e}")
        import traceback
        traceback.print_exc()
        return
    
    os.makedirs(os.path.dirname(layout_json), exist_ok=True)
    with open(layout_json, 'w') as f:
        json.dump(vlm_results_list, f, indent=2)
    
    # 4. Data Cleaning
    print(f"[Step 3] Transforming Data...")
    try:
        mapping_dict = extract_mapping_from_layout(vlm_results_list)
        print(f"   -> Extracted {len(mapping_dict)} objects.")

        # 5. Injection
        print(f"[Step 4] Injecting Names...")
        parse_and_inject(unnamed_g, mapping_dict, scene_named_g)
        print(f">>> PHASE 0 COMPLETE. Scene Ready: {scene_named_g}")
    except Exception as e:
        print(f"[ERROR] Data injection failed: {e}")

if __name__ == "__main__":
    execute_phase0()