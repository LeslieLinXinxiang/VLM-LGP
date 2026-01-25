#!/usr/bin/env python3
import os
import sys
import time
import json

# 设置路径以找到 core 和 pipelines
ROOT_DIR = os.path.abspath(os.path.dirname(__file__))
sys.path.append(ROOT_DIR)

from pipelines.run_phase0 import execute_phase0
from pipelines.run_phase1 import execute_phase1
from pipelines.run_phase2 import run_phase2_pipeline

# [DOCKER FIX] 使用 ZMQ Bridge 而不是直接调用本地 ROS
from core.zmq_bridge import ExecutionManager
from core.utils import load_json

class SystemDriverDocker:
    def __init__(self):
        self.root_dir = ROOT_DIR
        self.generated_dir = os.path.join(self.root_dir, "generated")
        self.current_g_file = os.path.join(self.generated_dir, "scene", "scene_named.g")
        
        # 物理连接：ZMQ
        print("[Driver] Initializing ZMQ connection to Host...")
        self.exec_manager = ExecutionManager()
        
        self.target_graph = None
        self.inventory_data = [] 

    def select_task_image(self):
        """[NEW] 代替 GUI 弹出框的终端交互菜单"""
        image_dir = os.path.join(self.root_dir, "test/test_images")
        if not os.path.exists(image_dir):
            print(f"❌ Error: Image directory not found at {image_dir}")
            sys.exit(1)
            
        images = sorted([f for f in os.listdir(image_dir) if f.endswith('.png')])
        
        print("\n" + "="*40)
        print("   PLEASE SELECT TASK IMAGE")
        print("="*40)
        for idx, img in enumerate(images):
            print(f"  [{idx}] {img}")
        print("="*40)
        
        try:
            choice = int(input("Enter index number: "))
            selected_path = os.path.join(image_dir, images[choice])
            print(f"✅ Selected: {images[choice]}")
            return selected_path
        except (ValueError, IndexError):
            print("❌ Invalid selection. Defaulting to index 0.")
            return os.path.join(image_dir, images[0])

    def run_phase0_init(self):
        print("\n# PHASE 0: INITIALIZATION #")
        # 1. 选择图像
        selected_img = self.select_task_image()
        # 2. 这里的 execute_phase0 需要支持传入 image_path 参数
        # 假设你原本的代码支持从环境或参数读取，此处直接调用
        # (如果 phase0 内部还有弹出窗口代码，需在 run_phase0.py 里将其改为读取参数)
        execute_phase0(image_path=selected_img) 
        return True

    def run_main_loop(self):
        # ... (此处逻辑与你原本的 SystemDriver 保持一致) ...
        # 确保使用 self.exec_manager.execute_trajectory_string(stdout, node_id)
        # 这样数据就会通过 ZMQ 发往 host_mock.py 或实机 host_agent.py
        pass

if __name__ == "__main__":
    driver = SystemDriverDocker()
    if driver.run_phase0_init():
        # 执行后续逻辑
        print("Phase 0 complete. Continuing with LGP logic...")
        # ... 这里的代码参考你原本的 SystemDriver 逻辑 ...
