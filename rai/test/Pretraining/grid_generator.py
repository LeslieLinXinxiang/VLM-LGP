import os
import cv2
import numpy as np
import tkinter as tk
from tkinter import filedialog, messagebox

# --- CONFIGURATION ---
BASE_DIR = "/home/leslie/Projects/VLM_LGP/rai/test/Pretraining"
OUTPUT_DIR = os.path.join(BASE_DIR, "generated_dictionaries")

class GridGeneratorApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Visual Dictionary Generator")
        self.root.geometry("500x250")
        
        # Ensure output directory exists
        os.makedirs(OUTPUT_DIR, exist_ok=True)

        # UI Elements
        self.label = tk.Label(root, text="Step 1: Select a base image to create a 9-grid dictionary.", 
                              font=("Arial", 12))
        self.label.pack(pady=20)
        
        self.btn_select = tk.Button(root, text="Select Image & Generate Grid", 
                                    command=self.process_image, 
                                    bg="#006400", fg="white", font=("Arial", 11, "bold"), 
                                    height=2, width=30)
        self.btn_select.pack(pady=10)
        
        self.status_label = tk.Label(root, text=f"Output will be saved in:\n{OUTPUT_DIR}", 
                                     fg="gray", font=("Courier", 10))
        self.status_label.pack(pady=20, side=tk.BOTTOM)

    def process_image(self):
        file_path = filedialog.askopenfilename(
            initialdir=BASE_DIR,
            title="Select Image with a White/Light Base",
            filetypes=[("Image Files", "*.png *.jpg *.jpeg")]
        )
        
        if not file_path:
            return

        try:
            filename = os.path.basename(file_path)
            img = cv2.imread(file_path)
            
            if img is None:
                raise ValueError("Failed to load image.")

            # --- CV LOGIC STARTS HERE ---
            
            # 1. Detect the white/light base
            hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
            # This range captures bright grays and whites, robust to lighting
            lower_white = np.array([0, 0, 180])
            upper_white = np.array([180, 40, 255])
            mask = cv2.inRange(hsv, lower_white, upper_white)
            
            contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
            
            if not contours:
                raise ValueError("No light-colored base detected. Check image contrast.")

            # Find the largest contour by area
            largest_contour = max(contours, key=cv2.contourArea)
            x, y, w, h = cv2.boundingRect(largest_contour)
            
            print(f"Base detected at: x={x}, y={y}, w={w}, h={h}")

            # 2. Calculate grid coordinates
            x1, x2 = x + w // 3, x + 2 * w // 3
            y1, y2 = y + h // 3, y + 2 * h // 3
            
            # 3. Draw grid lines
            line_color = (0, 0, 0) # Black
            line_thickness = 2
            cv2.line(img, (x1, y), (x1, y + h), line_color, line_thickness)
            cv2.line(img, (x2, y), (x2, y + h), line_color, line_thickness)
            cv2.line(img, (x, y1), (x + w, y1), line_color, line_thickness)
            cv2.line(img, (x, y2), (x + w, y2), line_color, line_thickness)

            # 4. Add text labels
            labels = {
                "Top-Left": (x + w // 6, y + h // 6),
                "Top-Center": (x + w // 2, y + h // 6),
                "Top-Right": (x + 5 * w // 6, y + h // 6),
                "Mid-Left": (x + w // 6, y + h // 2),
                "Mid-Right": (x + 5 * w // 6, y + h // 2),
                "Bottom-Left": (x + w // 6, y + 3 * h // 4),
                "Bottom-Center": (x + w // 2, y + 5 * h // 6),
                "Bottom-Right": (x + 5 * w // 6, y + 5 * h // 6),
            }
            
            font = cv2.FONT_HERSHEY_SIMPLEX
            font_scale = 0.6
            font_color = (0, 0, 255) # Red
            font_thickness = 2

            for text, (tx, ty) in labels.items():
                text_size, _ = cv2.getTextSize(text, font, font_scale, font_thickness)
                # Center the text in the grid cell
                text_x = tx - text_size[0] // 2
                text_y = ty + text_size[1] // 2
                cv2.putText(img, text, (text_x, text_y), font, font_scale, font_color, font_thickness)
            
            # --- CV LOGIC ENDS HERE ---

            # 5. Save the output
            output_name = f"dictionary_{filename}"
            output_path = os.path.join(OUTPUT_DIR, output_name)
            
            cv2.imwrite(output_path, img)
            
            print(f"[Success] Dictionary generated: {output_path}")
            messagebox.showinfo("Success", f"Grid dictionary generated!\n\nSaved to:\n{output_path}")

        except Exception as e:
            print(f"[Error] {e}")
            messagebox.showerror("Error", str(e))

if __name__ == "__main__":
    root = tk.Tk()
    app = GridGeneratorApp(root)
    root.mainloop()