import tkinter as tk
from tkinter import ttk, messagebox, filedialog
import robotic as ry
import numpy as np
import cv2
import os
import sys
import time

# ==========================================
# CONFIGURATION
# ==========================================
OUTPUT_DIR = "manual_output"

# [TARGET POSE] - 你的完美视角
TARGET_POS  = [0.000, 0.300, 2.000]
TARGET_QUAT = [0.000, 0.000, 1.000, 0.000]

# [CAMERA SETTINGS]
# Square 640x640, Zoom 1.732 (High Detail)
CAM_INTRINSICS = "focalLength:1.732, width:640, height:640, zRange:[0.1, 100]"

class AssemblyManualGUI:
    def __init__(self, master):
        self.master = master
        self.master.title("Manual Maker: Waiting...")
        self.master.geometry("500x850")
        
        # 状态变量
        self.C = None
        self.offscreen_cam = None
        self.objects = []
        self.initial_poses = {}
        self.screenshots = []
        self.check_vars = {}
        self.scene_basename = ""
        self.sim_loop_id = None # 用于追踪 after 循环

        # 1. 构建基础 UI 框架 (一次性构建)
        self.setup_ui_framework()

        # 2. 首次启动直接触发文件选择
        self.master.after(100, self.ask_and_load_scene)

    def setup_ui_framework(self):
        """构建静态的 UI 框架"""
        style = ttk.Style()
        style.configure("Bold.TLabel", font=("Arial", 10, "bold"))
        style.configure("Green.TLabel", font=("Arial", 10, "bold"), foreground="green")
        style.configure("Blue.TButton", font=("Arial", 10, "bold"), foreground="blue")

        # --- Control Frame ---
        self.control_frame = ttk.LabelFrame(self.master, text="Control Panel", padding=10)
        self.control_frame.pack(side=tk.TOP, fill=tk.X, padx=5, pady=5)

        # 顶部功能按钮
        top_btn_frame = ttk.Frame(self.control_frame)
        top_btn_frame.pack(fill=tk.X, pady=5)
        
        # [NEW] 回退/重选按钮
        ttk.Button(top_btn_frame, text="📂 Load New Scene", style="Blue.TButton", 
                   command=self.ask_and_load_scene).pack(side=tk.LEFT, fill=tk.X, expand=True, padx=2)
        
        ttk.Button(top_btn_frame, text="❌ Quit", 
                   command=self.master.destroy).pack(side=tk.RIGHT, fill=tk.X, expand=True, padx=2)

        # 状态标签
        self.lbl_cam_status = ttk.Label(self.control_frame, text="Waiting...", foreground="gray")
        self.lbl_cam_status.pack()

        # 操作按钮
        ttk.Button(self.control_frame, text="[SPACE] Capture Step", command=self.capture_step).pack(fill=tk.X, pady=5)
        self.lbl_count = ttk.Label(self.control_frame, text="Buffer: 0 Images", style="Bold.TLabel")
        self.lbl_count.pack(pady=2)
        ttk.Button(self.control_frame, text="[ENTER] Generate Manual & Reset", command=self.save_manual).pack(fill=tk.X, pady=5)

        # --- List Frame ---
        self.list_frame_container = ttk.LabelFrame(self.master, text="Assembly Parts", padding=10)
        self.list_frame_container.pack(side=tk.TOP, fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # 滚动条结构
        canvas = tk.Canvas(self.list_frame_container)
        scrollbar = ttk.Scrollbar(self.list_frame_container, orient="vertical", command=canvas.yview)
        self.scrollable_content = ttk.Frame(canvas)
        
        self.scrollable_content.bind("<Configure>", lambda e: canvas.configure(scrollregion=canvas.bbox("all")))
        canvas.create_window((0,0), window=self.scrollable_content, anchor="nw")
        canvas.configure(yscrollcommand=scrollbar.set)
        
        canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")

        # 底部全选按钮区
        btn_row = ttk.Frame(self.scrollable_content)
        btn_row.pack(fill=tk.X, pady=2)
        ttk.Button(btn_row, text="Hide All", command=self.hide_all).pack(side=tk.LEFT, fill=tk.X, expand=True)
        ttk.Button(btn_row, text="Show All", command=self.show_all).pack(side=tk.LEFT, fill=tk.X, expand=True)
        
        # 这里的 checkbox 列表将在 load_scene 中动态生成
        self.checklist_frame = ttk.Frame(self.scrollable_content)
        self.checklist_frame.pack(fill=tk.BOTH, expand=True)

        # 绑定快捷键
        self.master.bind('<space>', lambda e: self.capture_step())
        self.master.bind('<Return>', lambda e: self.save_manual())
        self.master.bind('q', lambda e: self.master.destroy())

    def reset_system(self):
        """清理旧场景数据，防止内存泄漏或逻辑冲突"""
        # 停止旧的仿真循环
        if self.sim_loop_id:
            self.master.after_cancel(self.sim_loop_id)
            self.sim_loop_id = None
        
        # 清空数据
        if self.C: del self.C
        self.C = None
        self.offscreen_cam = None
        self.objects = []
        self.initial_poses = {}
        self.screenshots = []
        self.lbl_count.config(text="Buffer: 0 Images")
        
        # 清空 UI 列表
        for widget in self.checklist_frame.winfo_children():
            widget.destroy()
        self.check_vars = {}

    def ask_and_load_scene(self):
        """弹出文件选择并加载"""
        scene_file = filedialog.askopenfilename(
            title="Select Scene File (.g)",
            initialdir=".",
            filetypes=[("RAI Scene", "*.g"), ("All Files", "*.*")]
        )
        
        if not scene_file:
            # 如果是第一次启动且取消了，就退出；如果是中途取消，就保持原状
            if not self.C: 
                print(">>> Selection cancelled. Exiting.")
                sys.exit(0)
            return

        # 执行重置和加载
        self.reset_system()
        self.load_scene_logic(scene_file)

    def load_scene_logic(self, scene_file):
        """加载场景的核心逻辑"""
        self.scene_basename = os.path.splitext(os.path.basename(scene_file))[0]
        print(f">>> Loading Scene: {self.scene_basename}...")
        
        # Update UI Title
        self.master.title(f"Manual Maker: {self.scene_basename}")
        self.control_frame.config(text=f"Current Scene: {self.scene_basename}")

        # Init RAI
        self.C = ry.Config()
        try:
            self.C.addFile(scene_file)
        except Exception as e:
            messagebox.showerror("Load Error", str(e))
            return

        # Setup Camera
        self.cam_name = "manual_camera_frame"
        self.cam = self.C.getFrame(self.cam_name)
        if not self.cam:
            print(f">>> Injecting Camera Attributes...")
            self.cam = self.C.addFrame(self.cam_name, "world", CAM_INTRINSICS)
        
        self.cam.setPosition(TARGET_POS)
        self.cam.setQuaternion(TARGET_QUAT)
        
        # Off-screen Render
        try:
            self.offscreen_cam = ry.CameraView(self.C)
            self.offscreen_cam.setCamera(self.cam)
            self.lbl_cam_status.config(text="✅ Camera Ready (640x640)", style="Green.TLabel")
        except Exception as e:
            self.lbl_cam_status.config(text="❌ Camera Failed", foreground="red")
            messagebox.showerror("Fatal", f"CameraView Error:\n{e}")

        # Scan Objects
        for f in self.C.getFrameNames():
            frame = self.C.getFrame(f)
            try:
                st = frame.getShapeType() 
                if st != ry.ST.none and st != ry.ST.marker and \
                   "table" not in f and "world" not in f and f != self.cam_name:
                    self.objects.append(f)
                    self.initial_poses[f] = frame.getRelativePose()
            except: pass
        self.objects.sort()

        # Rebuild Checkboxes
        for obj in self.objects:
            var = tk.BooleanVar(value=True)
            chk = ttk.Checkbutton(self.checklist_frame, text=obj, variable=var, 
                            command=lambda n=obj: self.toggle_object(n))
            chk.pack(anchor="w", pady=1)
            self.check_vars[obj] = var

        # Start Simulation Loop
        self.update_simulation_view()

    def update_simulation_view(self):
        if self.C:
            try: self.C.view(False, f"Preview: {self.scene_basename}")
            except: pass
        self.sim_loop_id = self.master.after(50, self.update_simulation_view)

    # --- 以下逻辑保持不变 ---
    def toggle_object(self, n):
        if not self.C: return
        f = self.C.getFrame(n)
        if self.check_vars[n].get(): f.setRelativePose(self.initial_poses[n])
        else: f.setPosition([0,0,-100])
        self.C.view(False)

    def hide_all(self):
        for n in self.objects: self.check_vars[n].set(False); self.toggle_object(n)
    
    def show_all(self):
        for n in self.objects: self.check_vars[n].set(True); self.toggle_object(n)

    def capture_step(self):
        if not self.C: return
        self.C.view(False)
        if self.offscreen_cam:
            try:
                rgb, _ = self.offscreen_cam.computeImageAndDepth(self.C)
                self.screenshots.append(cv2.cvtColor(rgb, cv2.COLOR_RGB2BGR))
                self.lbl_count.config(text=f"Buffer: {len(self.screenshots)} Images")
                print(f">>> Snapshot {len(self.screenshots)} Captured")
            except Exception as e: print(e)

    def draw_number(self, img, number):
        h, w = img.shape[:2]
        text = str(number)
        font = cv2.FONT_HERSHEY_SIMPLEX
        scale = 2.0
        thickness = 4
        color_text = (0, 0, 255) 
        color_outline = (255, 255, 255)
        
        (text_w, text_h), _ = cv2.getTextSize(text, font, scale, thickness)
        margin = 20
        x = w - text_w - margin
        y = h - margin
        
        cv2.putText(img, text, (x, y), font, scale, color_outline, thickness+4, cv2.LINE_AA)
        cv2.putText(img, text, (x, y), font, scale, color_text, thickness, cv2.LINE_AA)
        return img

    def save_manual(self):
        if not self.screenshots: return
        print(">>> Processing...")
        
        # [NEW CONFIG] 分割线设置
        GRID_THICKNESS = 20           # 线条宽度 (像素)
        GRID_COLOR = (255, 0, 255)    # BGR颜色: 亮紫色 (Magenta) - 这种反差色VLM极易识别
        
        cols = 2
        n = len(self.screenshots)
        rows = (n+cols-1)//cols
        
        # 获取单张截图尺寸
        h, w, c = self.screenshots[0].shape
        
        # [NEW] 计算带间距的总画布尺寸
        # 宽度 = 列数*图宽 + (列数-1)*间距
        # 高度 = 行数*图高 + (行数-1)*间距
        # 我们这里为了美观，给最外圈也加上边框，这样VLM能看到明确的"格子"
        total_w = cols * w + (cols + 1) * GRID_THICKNESS
        total_h = rows * h + (rows + 1) * GRID_THICKNESS
        
        # 创建画布，并用分割线颜色填充背景
        canvas = np.full((total_h, total_w, 3), GRID_COLOR, dtype=np.uint8)
        
        for i, img in enumerate(self.screenshots):
            # Watermark Number
            numbered_img = img.copy()
            self.draw_number(numbered_img, i+1)
            
            # Resize if dimensions inconsistent (Safety check)
            if numbered_img.shape != (h, w, c): 
                numbered_img = cv2.resize(numbered_img, (w, h))
            
            # [NEW] Calculate Position with Padding
            r, c_idx = i // cols, i % cols
            
            # Y坐标: 第r行 * (图片高+间距) + 顶部边框
            y_start = r * (h + GRID_THICKNESS) + GRID_THICKNESS
            # X坐标: 第c列 * (图片宽+间距) + 左侧边框
            x_start = c_idx * (w + GRID_THICKNESS) + GRID_THICKNESS
            
            # Place image
            canvas[y_start:y_start+h, x_start:x_start+w, :] = numbered_img
        
        # Save Logic
        if not os.path.exists(OUTPUT_DIR): os.makedirs(OUTPUT_DIR)
        
        timestamp = time.strftime("%Y%m%d_%H%M%S")
        filename = f"{self.scene_basename}_{timestamp}.png"
        fn = os.path.join(OUTPUT_DIR, filename)
        
        cv2.imwrite(fn, canvas)
        
        # Auto Reset
        self.screenshots = []
        self.lbl_count.config(text="Buffer: 0 Images (Reset)")
        
        messagebox.showinfo("Success", f"Saved with Grid Lines:\n{fn}")
        print(f">>> SAVED: {fn}")

if __name__ == "__main__":
    root = tk.Tk()
    AssemblyManualGUI(root)
    root.mainloop()
