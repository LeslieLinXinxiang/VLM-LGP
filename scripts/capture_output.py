import sys
import os

root_path = "/home/leslie/Projects/VLM_LGP"
sys.path.append(root_path)

try:
    from core.vision import SimCamera
    g_file = os.path.join(root_path, "generated", "pyramid_assembly_run", "output_state.g")
    cam = SimCamera(g_file)
    out_img = os.path.join(root_path, "generated", "final_view.png")
    cam.capture(out_img)
    print(f"Captured {out_img}")
except Exception as e:
    print(f"Error: {e}")
