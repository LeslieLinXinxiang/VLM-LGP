import sys
import os
import cv2

# Add root project path explicitly
root_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
sys.path.append(root_path)

try:
    from core.vision import SimCamera
    print("Found core.vision!")
except Exception as e:
    print(f"Cannot import core.vision: {e}")
    sys.exit(1)

def text_camera():
    g_file = os.path.join(root_path, "unnamed.g")
    
    print(f"Loading scene: {g_file}")
    cam = SimCamera(g_file)
    
    out_img = os.path.join(root_path, "generated", "scene_test.png")
    cam.capture(out_img)
    print(f"Saved capture to {out_img}")

if __name__ == "__main__":
    text_camera()
