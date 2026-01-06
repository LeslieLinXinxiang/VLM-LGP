# core/vision.py
import robotic as ry
import numpy as np
import cv2
import time
import os
import sys

TARGET_POS  = [0.000, 0.200, 2.000] 
TARGET_QUAT = [0.000, 0.000, 1.500, 0.000]
CAM_INTRINSICS = "focalLength:0.75, width:640, height:640, zRange:[0.1, 100]"
CAM_NAME = "manual_camera_frame"

class SimCamera:
    def __init__(self, scene_file_path):
        self.load_scene(scene_file_path)

    def load_scene(self, scene_file_path):
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

    def reload(self, new_scene_path):
        print(f"[Core.Vision] Reloading scene from: {new_scene_path}")
        self.load_scene(new_scene_path)

    def capture(self, save_path=None):
        try:
            rgb, _ = self.view.computeImageAndDepth(self.C)
            
            if rgb is None or rgb.size == 0:
                print("\n[FATAL] Render failed: computeImageAndDepth() returned an empty image.")
                return None

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
        

class ImageSlicer:
    """
    Utility to physically slice a composite grid image based on Magenta borders.
    """
    @staticmethod
    def slice_grid(image_path, output_dir, debug=True):
        """
        Args:
            image_path: Input image path.
            output_dir: Directory to save slices.
            debug: If True, saves 'debug_mask.png' and 'debug_contours.png'
        """
        if not os.path.exists(output_dir):
            os.makedirs(output_dir)

        print(f"[Slicer] Loading: {image_path}")
        img = cv2.imread(image_path)
        if img is None:
            print(f"[Slicer] Error: Image not found at {image_path}")
            return []

        # 1. Convert to HSV
        hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

        # 2. Define Magenta Range (The "Void" Color)
        # OpenCV HSV range: H(0-179), S(0-255), V(0-255)
        # Perfect Magenta is usually around H=150
        lower_m = np.array([135, 50, 50])  # slightly wider range
        upper_m = np.array([175, 255, 255])
        
        # Mask: White = Magenta (Void), Black = Content
        mask = cv2.inRange(hsv, lower_m, upper_m)

        # 3. Invert the Mask
        # Now: White = Content (Node 1,2,3), Black = Magenta (Borders & Node 4)
        mask_inv = cv2.bitwise_not(mask)

        # [DEBUG] Save the mask to see what the computer sees
        if debug:
            cv2.imwrite(os.path.join(output_dir, "debug_01_mask_inverted.png"), mask_inv)

        # 4. Find Contours on the Content
        contours, _ = cv2.findContours(mask_inv, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        valid_boxes = []
        min_area = 5000  # Filter out small pixel noise
        
        # Debug image to draw recognized boxes
        debug_img = img.copy()

        for cnt in contours:
            x, y, w, h = cv2.boundingRect(cnt)
            if w * h > min_area:
                valid_boxes.append((x, y, w, h))
                # Draw green rectangle for visualization
                cv2.rectangle(debug_img, (x, y), (x+w, y+h), (0, 255, 0), 3)
                # Put text
                cv2.putText(debug_img, f"{w}x{h}", (x, y-10), cv2.FONT_HERSHEY_SIMPLEX, 0.9, (0, 255, 0), 2)

        if debug:
            cv2.imwrite(os.path.join(output_dir, "debug_02_contours.png"), debug_img)

        # 5. Sort Logic (Row-Major Order)
        # Sort by Y first (with tolerance), then X
        # Tolerance: divide Y by 50 pixels to group rows
        valid_boxes.sort(key=lambda b: (b[1] // 50, b[0]))

        print(f"[Slicer] Found {len(valid_boxes)} valid content regions.")

        # 6. Crop and Save
        saved_paths = []
        for i, (x, y, w, h) in enumerate(valid_boxes):
            crop = img[y:y+h, x:x+w]
            
            # Optional: Add a small white border or just save raw
            filename = f"node_{i+1}_target.png"
            save_path = os.path.join(output_dir, filename)
            cv2.imwrite(save_path, crop)
            saved_paths.append(save_path)
            print(f"   -> Saved Node {i+1}: {save_path}")

        return saved_paths

# ==============================================================================
#  STANDALONE TEST EXECUTION
# ==============================================================================
if __name__ == "__main__":
    print("-" * 60)
    print("  RUNNING IMAGE SLICER UNIT TEST")
    print("-" * 60)

    # 1. 设置输入路径 (根据你的实际情况修改)
    # 假设你的那张洋红色网格图放在 generated/phase1_target.png
    # 或者你可以把测试图片命名为 test_grid.png 放在根目录
    
    # 自动检测当前目录下的 png
    input_image_path = "generated/phase1_target.png" 
    
    # 如果你还没有这个文件，创建一个 dummy 或者指定绝对路径
    # 这里我们假设你已经有了这张图
    if len(sys.argv) > 1:
        input_image_path = sys.argv[1] # 允许通过命令行传参

    output_directory = "generated/slices_test"

    if os.path.exists(input_image_path):
        paths = ImageSlicer.slice_grid(input_image_path, output_directory, debug=True)
        print("\n[Test Result]")
        print(f"Slicing complete. Check folder: {output_directory}")
        print(f"Generated {len(paths)} slices.")
    else:
        print(f"[Error] Test image not found at: {input_image_path}")
        print("Please place your test image there, or run: python core/vision.py <path_to_image>")