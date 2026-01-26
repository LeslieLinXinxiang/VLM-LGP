# pipelines/run_phase0.py
print(">>> [DEBUG] Module pipelines.run_phase0 is loading...")

import sys
import os
import json
import shutil  # [Core] 用于在 Docker 模式下“伪造”截图

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

try:
    # 尝试导入 SimCamera，但在 Docker 模式下我们不会调用它，所以即使它依赖缺失也没关系
    from core.vision import SimCamera
    from core.vlm import VLMClient
    from core.utils import parse_and_inject, extract_mapping_from_layout
    print(">>> [DEBUG] Imports successful.")
except ImportError as e:
    print(f">>> [FATAL ERROR] Import failed: {e}")
    sys.exit(1)

# [INTERFACE FIX] 增加 image_path 参数，默认为 None (兼容旧代码)
def execute_phase0(image_path=None):
    print(">>> STARTING PHASE 0: WORLD BINDING")
    
    root_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    
    # 定义物理路径锚点
    unnamed_g = os.path.join(root_dir, "unnamed.g")
    specs_json = os.path.join(root_dir, "generated/phase0_specs.json")
    prompt_file = os.path.join(root_dir, "prompts/phase0_binding_prompt.md")
    
    # [关键路径] 无论图片从哪来，最终都要存在这里
    capture_png = os.path.join(root_dir, "generated/phase0_capture.png")
    
    layout_json = os.path.join(root_dir, "generated/phase0_layout.json")
    scene_named_g = os.path.join(root_dir, "generated/scene/scene_named.g")
    
    # ========================================================
    # [Step 1] Image Acquisition Logic (The Branch)
    # ========================================================
    if image_path:
        # --- 路径 A: Docker/指定图片模式 ---
        # 逻辑：用户已选好图片，我们直接将其视为“当前截图”
        print(f"[Step 1] Headless Mode: Using provided image...")
        print(f"   -> Source: {image_path}")
        
        if not os.path.exists(image_path):
            print(f"[ERROR] Source image not found: {image_path}")
            return

        # 物理复制：将选中的图覆盖到 capture_png
        os.makedirs(os.path.dirname(capture_png), exist_ok=True)
        shutil.copy(image_path, capture_png)
        print(f"   -> Image copied to buffer: {capture_png}")
        
    else:
        # --- 路径 B: Native/GUI 模式 ---
        # 逻辑：调用仿真器摄像头实时截图
        print(f"[Step 1] Native Mode: Capturing Scene via SimCamera...")
        try:
            sim = SimCamera(unnamed_g)
            sim.capture(save_path=capture_png)
            # SimCamera 已将图片保存到 capture_png
        except Exception as e:
            print(f"[ERROR] SimCamera capture failed: {e}")
            return
    
    # ========================================================
    # [Step 2] VLM Processing (Unified Pipeline)
    # ========================================================
    # 此时，generated/phase0_capture.png 已经就位，VLM 对来源一无所知
    print(f"[Step 2] VLM Semantic Matching...")
    try:
        vlm = VLMClient()
        # VLM 读取标准路径
        vlm_results_list = vlm.match_objects(capture_png, specs_json, prompt_file)
    except Exception as e:
        print(f"[ERROR] VLM module failed: {e}")
        import traceback
        traceback.print_exc()
        return
    
    os.makedirs(os.path.dirname(layout_json), exist_ok=True)
    with open(layout_json, 'w') as f:
        json.dump(vlm_results_list, f, indent=2)
    
    # ========================================================
    # [Step 3] Data Injection (Unified Pipeline)
    # ========================================================
    print(f"[Step 3] Transforming Data...")
    try:
        mapping_dict = extract_mapping_from_layout(vlm_results_list)
        print(f"   -> Extracted {len(mapping_dict)} objects.")

        print(f"[Step 4] Injecting Names...")
        parse_and_inject(unnamed_g, mapping_dict, scene_named_g)
        print(f">>> PHASE 0 COMPLETE. Scene Ready: {scene_named_g}")
    except Exception as e:
        print(f"[ERROR] Data injection failed: {e}")

if __name__ == "__main__":
    execute_phase0()