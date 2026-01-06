# debug_camera_robust.py
import os
import sys
import robotic as ry
import numpy as np
import cv2

# --- Setup Paths ---
sys.path.append(os.path.abspath("."))

# ==========================================================
#  EMBEDDED SimCamera CLASS FOR ISOLATED TESTING
# ==========================================================
TARGET_POS  = [0.000, 2.228, 2.500] 
TARGET_QUAT = [0.000, 0.000, 0.890, -0.456]
CAM_INTRINSICS = "focalLength:1.0, width:640, height:640"
CAM_NAME = "manual_camera_frame"

class SimCamera_Robust:
    def __init__(self, scene_file_path):
        self.load_scene(scene_file_path)

    def load_scene(self, scene_file_path):
        # ... (this part is correct) ...
        if not os.path.exists(scene_file_path):
            raise FileNotFoundError(f"[SimCamera] Scene file not found: {scene_file_path}")
        if hasattr(self, 'C'): del self.C
        if hasattr(self, 'view'): del self.view
        self.C = ry.Config()
        self.C.addFile(scene_file_path)
        self.cam = self.C.getFrame(CAM_NAME)
        if not self.cam:
            self.cam = self.C.addFrame(CAM_NAME, "world", CAM_INTRINSICS)
            self.cam.setPosition(TARGET_POS)
            self.cam.setQuaternion(TARGET_QUAT)
        self.view = ry.CameraView(self.C)
        self.view.setCamera(self.cam)
        print(f"[SimCamera] Scene '{os.path.basename(scene_file_path)}' loaded.")

    def capture(self, save_path=None):
        try:
            rgb, _ = self.view.computeImageAndDepth(self.C)
            
            if rgb is None or rgb.size == 0:
                print("\n[FATAL] Render failed.")
                return None

            # [CRITICAL FIX] Corrected the typo from _ to 2
            bgr = cv2.cvtColor(rgb, cv2.COLOR_RGB2BGR)
            
            if save_path:
                try:
                    os.makedirs(os.path.dirname(save_path), exist_ok=True)
                    success = cv2.imwrite(save_path, bgr)
                    if not success:
                        print(f"\n[FATAL] Write failed to {save_path}")
                        return None
                except Exception as e_write:
                    print(f"\n[FATAL] Exception during write: {e_write}")
                    return None
            return bgr

        except Exception as e_render:
            print(f"\n[FATAL] Exception during rendering: {e_render}")
            import traceback
            traceback.print_exc()
            return None
# ==========================================================
#  END OF EMBEDDED CLASS
# ==========================================================


# --- (The rest of the script remains the same) ---
GENERATED_DIR = "generated"
SCENE_FILE = os.path.join(GENERATED_DIR, "scene_named.g")
OUTPUT_IMAGE = os.path.join(GENERATED_DIR, "debug_camera_robust_snapshot.png")

print(">>> [1/3] Checking for scene file...")
if not os.path.exists(SCENE_FILE):
    print(f">>> [FAIL] Scene file not found: {SCENE_FILE}")
    sys.exit(1)

try:
    print(">>> [2/3] Initializing SimCamera_Robust...")
    sim = SimCamera_Robust(SCENE_FILE)
    print("    Initialization successful.")
except Exception as e:
    print(f">>> [FAIL] SimCamera_Robust failed to initialize: {e}")
    sys.exit(1)

try:
    print(f">>> [3/3] Attempting to capture...")
    image_data = sim.capture(save_path=OUTPUT_IMAGE)
    
    if image_data is not None and os.path.exists(OUTPUT_IMAGE):
        print("\n" + "="*50)
        print(">>> SUCCESS: Robust camera test passed!")
        print(f">>> Snapshot saved to: {OUTPUT_IMAGE}")
        print("="*50)
    else:
        print("\n" + "="*50)
        print(">>> FAILURE: sim.capture() returned None or file not found.")
        print("       Check the [FATAL] error message above for the root cause.")
        print("="*50)

except Exception as e:
    print(f">>> [FAIL] sim.capture() crashed unexpectedly: {e}")
    sys.exit(1)