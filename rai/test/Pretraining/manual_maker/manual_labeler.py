import tkinter as tk
from tkinter import ttk, messagebox, filedialog
import robotic as ry
import numpy as np
import cv2
import os
import sys
import json
import time

# ==========================================
# CONFIGURATION
# ==========================================
OUTPUT_DIR = "/home/leslie/Projects/VLM_LGP/incontext_training"

# [CAMERA SETTINGS] - LOCKED FIXED VIEW (God's Eye)
TARGET_POS  = [0.000, 0.300, 2.000]
TARGET_QUAT = [0.000, 0.000, 1.000, 0.000]
CAM_INTRINSICS = "focalLength:1.732, width:640, height:640, zRange:[0.1, 100]"

class LabelerGUI:
    def __init__(self, master):
        self.master = master
        self.master.title("V-LGP: Context Labeler (Fixed View)")
        self.master.geometry("500x700")
        
        # Ensure Output Directory
        if not os.path.exists(OUTPUT_DIR):
            os.makedirs(OUTPUT_DIR)
            print(f">>> Created Dir: {OUTPUT_DIR}")
        
        # State
        self.C = None
        self.offscreen_cam = None
        self.sim_loop_id = None
        self.scene_basename = "scene"
        self.objects = []
        self.initial_poses = {}
        self.check_vars = {}

        self.setup_ui()
        
        # Auto-trigger load
        self.master.after(100, self.ask_and_load_scene)

    def setup_ui(self):
        # Styles
        style = ttk.Style()
        style.configure("Big.TButton", font=("Arial", 12, "bold"), padding=10)

        # --- Top Control Frame ---
        ctrl_frame = ttk.LabelFrame(self.master, text="System Control", padding=10)
        ctrl_frame.pack(side=tk.TOP, fill=tk.X, padx=5, pady=5)

        ttk.Button(ctrl_frame, text="📂 Load Scene", command=self.ask_and_load_scene).pack(fill=tk.X, pady=2)
        
        self.btn_capture = ttk.Button(ctrl_frame, text="[SPACE] Capture & Label", style="Big.TButton", 
                                      command=self.capture_dialog, state=tk.DISABLED)
        self.btn_capture.pack(fill=tk.X, pady=5)
        
        self.lbl_status = ttk.Label(ctrl_frame, text="Status: Waiting...", foreground="blue")
        self.lbl_status.pack(pady=2)

        # --- Object List Frame (Scrollable) ---
        list_container = ttk.LabelFrame(self.master, text="Object Visibility (Toggle to Hide/Show)", padding=10)
        list_container.pack(side=tk.TOP, fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        canvas = tk.Canvas(list_container)
        scrollbar = ttk.Scrollbar(list_container, orient="vertical", command=canvas.yview)
        self.scrollable_content = ttk.Frame(canvas)
        
        self.scrollable_content.bind("<Configure>", lambda e: canvas.configure(scrollregion=canvas.bbox("all")))
        canvas.create_window((0,0), window=self.scrollable_content, anchor="nw")
        canvas.configure(yscrollcommand=scrollbar.set)
        
        canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")

        # --- Bottom Actions ---
        btn_row = ttk.Frame(list_container)
        btn_row.pack(side=tk.BOTTOM, fill=tk.X, pady=2)
        ttk.Button(btn_row, text="Show All", command=self.show_all).pack(side=tk.LEFT, expand=True)
        ttk.Button(btn_row, text="Hide All", command=self.hide_all).pack(side=tk.LEFT, expand=True)

        # Bind Spacebar
        self.master.bind('<space>', lambda e: self.capture_dialog())

    def reset_system(self):
        """Clear previous scene data"""
        if self.C: del self.C
        self.C = None
        self.objects = []
        self.initial_poses = {}
        self.check_vars = {}
        # Clear UI list
        for widget in self.scrollable_content.winfo_children():
            widget.destroy()

    def ask_and_load_scene(self):
        scene_file = filedialog.askopenfilename(
            title="Select Scene File (.g)",
            initialdir=".",
            filetypes=[("RAI Scene", "*.g")]
        )
        if not scene_file: return

        self.reset_system()
        
        # Load RAI
        self.C = ry.Config()
        self.C.addFile(scene_file)
        self.scene_basename = os.path.splitext(os.path.basename(scene_file))[0]
        
        # Setup Fixed Camera
        self.cam_name = "manual_camera_frame"
        self.cam = self.C.getFrame(self.cam_name)
        if not self.cam:
            self.cam = self.C.addFrame(self.cam_name, "world", CAM_INTRINSICS)
        self.cam.setPosition(TARGET_POS)
        self.cam.setQuaternion(TARGET_QUAT)
        
        # Offscreen
        self.offscreen_cam = ry.CameraView(self.C)
        self.offscreen_cam.setCamera(self.cam)

        # Scan Objects & Build Checkboxes
        for f in self.C.getFrameNames():
            frame = self.C.getFrame(f)
            try:
                st = frame.getShapeType() 
                # Filter out system frames
                if st != ry.ST.none and st != ry.ST.marker and \
                   "world" not in f and f != self.cam_name:
                    self.objects.append(f)
                    self.initial_poses[f] = frame.getRelativePose()
            except: pass
        self.objects.sort()

        # Build UI List
        for obj in self.objects:
            var = tk.BooleanVar(value=True)
            chk = ttk.Checkbutton(self.scrollable_content, text=obj, variable=var, 
                            command=lambda n=obj: self.toggle_object(n))
            chk.pack(anchor="w", pady=1)
            self.check_vars[obj] = var

        # UI Update
        self.btn_capture.config(state=tk.NORMAL)
        self.lbl_status.config(text=f"Loaded: {self.scene_basename}")
        self.master.title(f"Labeler: {self.scene_basename}")
        
        # Start Loop
        self.update_sim()

    def update_sim(self):
        if self.C:
            try: self.C.view(False, f"Adjust Objects Here")
            except: pass
        self.master.after(50, self.update_sim)

    # --- Toggle Logic ---
    def toggle_object(self, n):
        if not self.C: return
        f = self.C.getFrame(n)
        if self.check_vars[n].get(): f.setRelativePose(self.initial_poses[n])
        else: f.setPosition([0,0,-100]) # Hide under table

    def show_all(self):
        for n in self.objects: self.check_vars[n].set(True); self.toggle_object(n)
    
    def hide_all(self):
        for n in self.objects: self.check_vars[n].set(False); self.toggle_object(n)

    # --- Capture & Label Logic ---
    def capture_dialog(self, event=None):
        if not self.C or not self.offscreen_cam: return
        
        # 1. Capture Image
        rgb, _ = self.offscreen_cam.computeImageAndDepth(self.C)
        img_bgr = cv2.cvtColor(rgb, cv2.COLOR_RGB2BGR)
        
        # 2. Open Popup
        self.open_label_popup(img_bgr)

    def open_label_popup(self, img_data):
        popup = tk.Toplevel(self.master)
        popup.title("Select Position")
        popup.geometry("500x500")
        popup.grab_set() 
        
        ttk.Label(popup, text="Select Object Position:", font=("Arial", 14, "bold")).pack(pady=15)
        
        grid_frame = ttk.Frame(popup)
        grid_frame.pack(expand=True, padx=20, pady=20)
        
        # [NEW] The 8-Direction Layout + Center
        # Mapped to Image View (Top=Back, Bottom=Front)
        labels = [
            ["top_left",    "top_center",    "top_right"],
            ["mid_left",    "center",        "mid_right"],
            ["bottom_left", "bottom_center", "bottom_right"]
        ]
        
        for r, row in enumerate(labels):
            for c, label_text in enumerate(row):
                # Button Styling
                btn = tk.Button(grid_frame, text=label_text, width=12, height=4, bg="#f0f0f0",
                                font=("Arial", 10, "bold"),
                                command=lambda l=label_text: self.save_and_close(popup, img_data, l))
                btn.grid(row=r, column=c, padx=5, pady=5)
        
        ttk.Button(popup, text="Cancel", command=popup.destroy).pack(pady=10)

    def save_and_close(self, popup, img_data, label_text):
        timestamp = time.strftime("%Y%m%d_%H%M%S")
        base_name = f"{label_text}"
        
        png_path = os.path.join(OUTPUT_DIR, f"{base_name}.png")
        json_path = os.path.join(OUTPUT_DIR, f"{base_name}.json")
        
        # 1. Save Image
        cv2.imwrite(png_path, img_data)
        
        # 2. Save JSON (Target Graph Format with YOUR Labels)
        data = [
            {
                "object": "base",
                "placed_on": "table",
                "at_slot": None
            },
            {
                "object": "cylinder",
                "placed_on": "base",
                "at_slot": label_text  # Uses backleft, front, etc.
            }
        ]
        
        with open(json_path, 'w') as f:
            json.dump(data, f, indent=2)
            
        print(f">>> Saved: {label_text} -> {base_name}")
        self.lbl_status.config(text=f"Last Saved: {label_text}")
        
        popup.destroy()

if __name__ == "__main__":
    root = tk.Tk()
    LabelerGUI(root)
    root.mainloop()