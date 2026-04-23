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

# [DOCKER ARCHITECTURE] 
# Docker (Brain) -> ZMQ -> Host (Body)
from core.zmq_bridge import ExecutionManager
from core.utils import load_json
from core.graph_adapter import build_graph_from_phase1

def print_banner(text):
    print("\n" + "#" * 60)
    print(f"  {text}")
    print("#" * 60 + "\n")

class SystemDriverDocker:
    def __init__(self):
        self.root_dir = ROOT_DIR
        self.generated_dir = os.path.join(self.root_dir, "generated")
        self.current_g_file = os.path.join(self.generated_dir, "scene", "scene_named.g")
        
        # 1. 物理连接：ZMQ Client
        print("[Driver] Initializing ZMQ connection to Host...")
        self.exec_manager = ExecutionManager()
        
        self.target_graph = None
        self.target_graph_math = None
        self.inventory_data = [] 
        self.history_chain = []

    def run_phase0_init(self):
        print_banner("PHASE 0: INITIALIZATION (HARDCODED)")
        
        # [MODIFICATION 1] 硬编码路径，不询问用户
        target_image_path = "/home/leslie/Projects/VLM_LGP/test/scene_image.png"
        
        print(f"[Driver] Using Hardcoded Image: {target_image_path}")
        
        if not os.path.exists(target_image_path):
            print(f"[FATAL] Image not found at hardcoded path: {target_image_path}")
            # 这里必须停止，因为没有图就没有世界，后续肯定全挂
            return False 

        # [MODIFICATION 2] 传入 image_path 绕过 SimCamera
        # 这利用了 pipelines/run_phase0.py 现有的多态逻辑
        try:
            execute_phase0(image_path=target_image_path)
        except Exception as e:
            print(f"[Driver] Phase 0 threw exception: {e}")
            # 用户要求不做 judgement，但 Phase 0 失败通常意味着没有 .g 文件
            # 这里的 return False 是物理底线
            return False
            
        return True

    def run_phase1_plan(self):
        print_banner("PHASE 1: TARGET PLANNING")
        success, graph_path = execute_phase1()
        
        # [MODIFICATION] 即使 Phase 1 报失败，如果文件生成了也继续
        if not os.path.exists(graph_path):
            print("[Driver] Critical: Phase 1 output missing.")
            return False
            
        self.target_graph = load_json(graph_path)

        if isinstance(self.target_graph, dict) and "objects" in self.target_graph:
            self.target_graph_math = build_graph_from_phase1(self.target_graph)
            print(
                "[Driver] Phase1 JSON received (objects+edges). "
                f"Built G=(V,E): |V|={self.target_graph_math['meta']['vertex_count']}, "
                f"|E|={self.target_graph_math['meta']['edge_count']}"
            )
        else:
            self.target_graph_math = None

        print(f"[Driver] Nodes to execute: {len(self.target_graph.get('assembly_nodes', []))}")
        return True

    def init_inventory_status(self):
        layout_path = os.path.join(self.generated_dir, "phase0_layout.json")
        self.inventory_data = load_json(layout_path)
        if not self.inventory_data: return False
        for item in self.inventory_data: item['status'] = 'available'
        return True

    def run_main_loop(self):
        print_banner("ENTERING FIRE-AND-FORGET LOOP")
        if not self.init_inventory_status(): return False
        
        nodes = self.target_graph.get('assembly_nodes', [])
        
        for i, node in enumerate(nodes):
            node_id = node.get('node_id', i+1)
            print_banner(f"PROCESSING NODE {node_id}")

            # --- STEP 1: SOLVE (Headless LGP) ---
            print(f"[Brain] Input Scene: {os.path.basename(self.current_g_file)}")
            
            # 调用求解器
            # 我们捕获所有返回值，但不根据 success 标志中断循环
            try:
                p2_success, output_g_file, _, node_summary, used_ids, stdout = run_phase2_pipeline(
                    node, 
                    self.current_g_file, 
                    self.target_graph, 
                    self.inventory_data, 
                    self.history_chain
                )
            except Exception as e:
                print(f"[Brain] ⚠️ Exception in Solver: {e}")
                p2_success = False
                stdout = ""
                used_ids = []
                node_summary = None
                output_g_file = None

            if not p2_success:
                print(f"[Brain] ⚠️ Planning flagged as FAILED, but proceeding per directive.")

            # --- STEP 2: INVENTORY UPDATE (尽力而为) ---
            if used_ids:
                for item in self.inventory_data:
                    if item['logical_id'] in used_ids:
                        item['status'] = 'used'

            # --- STEP 3: TRANSMIT (ZMQ Handoff) ---
            if stdout:
                print(f"[Brain] 📡 Transmitting Trajectory to Host (Node {node_id})...")
                # [MODIFICATION 3] 不关心返回值
                # 无论 Host 返回 True 还是 False，我们都假设它处理了
                self.exec_manager.execute_trajectory_string(stdout, node_id)
                print(f"[Brain] ⏩ Moving to next node regardless of Host acknowledgement.")
            else:
                print(f"[Brain] 📭 No trajectory generated to transmit.")

            # --- STEP 4: STATE UPDATE (尽力而为) ---
            if node_summary:
                self.history_chain.append(node_summary)

            # 如果生成了新的状态文件，就用新的；否则沿用旧的继续硬跑
            if output_g_file and os.path.exists(output_g_file):
                self.current_g_file = output_g_file
                print(f"[Brain] 🔗 Link update: {os.path.basename(output_g_file)}")
            else:
                print(f"[Brain] ⚠️ Link broken: output state missing. Reusing previous state.")

        print_banner("ALL NODES PROCESSED (BLIND MODE)")
        return True

if __name__ == "__main__":
    driver = SystemDriverDocker()
    
    # 只要 Phase 0 能跑通（有了世界模型），后续就闭眼跑
    if driver.run_phase0_init():
        if driver.run_phase1_plan():
            driver.run_main_loop()