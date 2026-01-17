import os
import cv2
import tkinter as tk
from tkinter import filedialog, messagebox

# --- CONFIGURATION ---
BASE_DIR = "/home/leslie/Projects/VLM_LGP/rai/test/Pretraining/denoising"
INPUT_DIR = os.path.join(BASE_DIR, "test")
OUTPUT_DIR = os.path.join(BASE_DIR, "output_gray")

class ImageConverterApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Grayscale Converter (V-LGP Debugging Tool)")
        self.root.geometry("400x200")
        
        # Ensure directories exist
        if not os.path.exists(INPUT_DIR):
            os.makedirs(INPUT_DIR)
            print(f"[System] Created Input Directory: {INPUT_DIR}")
        
        if not os.path.exists(OUTPUT_DIR):
            os.makedirs(OUTPUT_DIR)
            print(f"[System] Created Output Directory: {OUTPUT_DIR}")

        # UI Elements
        self.label = tk.Label(root, text="Ablation Test: Remove Color Distraction", font=("Arial", 12, "bold"))
        self.label.pack(pady=20)
        
        self.btn_select = tk.Button(root, text="Select Image & Convert", command=self.process_image, 
                                    bg="#003366", fg="white", font=("Arial", 11), height=2, width=20)
        self.btn_select.pack(pady=10)
        
        self.status_label = tk.Label(root, text=f"Input Dir: {os.path.basename(INPUT_DIR)}\nOutput Dir: {os.path.basename(OUTPUT_DIR)}", 
                                     fg="gray", font=("Courier", 9))
        self.status_label.pack(pady=20, side=tk.BOTTOM)

    def process_image(self):
        # 1. Open File Dialog
        file_path = filedialog.askopenfilename(
            initialdir=INPUT_DIR,
            title="Select RGB Image",
            filetypes=[("Image Files", "*.png *.jpg *.jpeg *.bmp")]
        )
        
        if not file_path:
            return # User cancelled

        try:
            # 2. Load Image
            filename = os.path.basename(file_path)
            img_bgr = cv2.imread(file_path)
            
            if img_bgr is None:
                messagebox.showerror("Error", f"Failed to load image: {filename}")
                return

            # 3. Convert to Grayscale
            # Option A: Strict Grayscale (1 Channel)
            # img_gray = cv2.cvtColor(img_bgr, cv2.COLOR_BGR2GRAY)
            
            # Option B: 3-Channel Grayscale (Visual B&W, but compatible with VLM inputs expecting 3 channels)
            # 很多VLM预训练时是RGB输入，如果给单通道可能会报错，这里保险起见转回BGR格式的黑白图
            img_gray_1c = cv2.cvtColor(img_bgr, cv2.COLOR_BGR2GRAY)
            img_gray_3c = cv2.cvtColor(img_gray_1c, cv2.COLOR_GRAY2BGR)

            # 4. Save
            output_name = f"gray_{filename}"
            output_path = os.path.join(OUTPUT_DIR, output_name)
            
            cv2.imwrite(output_path, img_gray_3c)
            
            print(f"[Success] Converted: {filename} -> {output_name}")
            
            # 5. Visual Confirmation
            messagebox.showinfo("Success", f"Image converted successfully!\n\nSaved to:\n{output_path}")

        except Exception as e:
            print(f"[Error] {e}")
            messagebox.showerror("Exception", str(e))

if __name__ == "__main__":
    root = tk.Tk()
    app = ImageConverterApp(root)
    root.mainloop()