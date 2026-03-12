import os
import sys
import time
import json

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from pipelines.run_phase0 import execute_phase0
from pipelines.run_phase1 import execute_phase1
from pipelines.run_phase2 import run_phase2_pipeline

# [NEW] 引入重构后的 ExecutionManager
from core.ros2_bridge import ExecutionManager
from core.solver_bridge import SolverBridge
from core.utils import load_json
from core.graph_adapter import build_graph_from_phase1

def print_banner(text):
    print("\n" + "#" * 60)
    print(f"  {text}")
    print("#" * 60 + "\n")

class SystemDriver:
    def __init__(self):
        self.root_dir = os.path.abspath(os.path.dirname(__file__))
        self.generated_dir = os.path.join(self.root_dir, "generated")
        
        # 初始场景文件 (State Chain 的起点)
        self.current_g_file = os.path.join(self.generated_dir, "scene", "scene_named.g")
        
        self.target_graph = None
        self.target_graph_math = None
        self.inventory_data = [] 
        
        # 物理执行管理器
        self.exec_manager = ExecutionManager()
        
        # Master Log 路径
        self.master_log_path = os.path.join(self.generated_dir, "node_1_run", "raw_trajectory.log")

    def init_master_log(self):
        """初始化全局日志文件"""
        log_dir = os.path.dirname(self.master_log_path)
        if not os.path.exists(log_dir): os.makedirs(log_dir)
        
        with open(self.master_log_path, "w") as f:
            f.write(f"--- V-LGP MASTER EXPERIMENT LOG ---\n")
            f.write(f"Timestamp: {time.ctime()}\n")
            f.write(f"Mode: Sync Plan-Execute Loop\n")
        print(f"[Driver] Master Log initialized at: {self.master_log_path}")

    def append_to_log(self, node_id, content):
        """追加轨迹到全局日志"""
        with open(self.master_log_path, "a") as f:
            f.write(f"\n\n>>> NODE {node_id} DATA START <<<\n")
            f.write(content)
            f.write(f"\n>>> NODE {node_id} DATA END <<<\n")
        print(f"[Driver] Trajectory for Node {node_id} saved to Master Log.")

    def run_phase0_init(self):
        print_banner("PHASE 0: INITIALIZATION & BINDING")
        execute_phase0()
        layout_path = os.path.join(self.generated_dir, "phase0_layout.json")
        if not os.path.exists(layout_path) or not os.path.exists(self.current_g_file):
            print("[Driver] FATAL: Phase 0 failed.")
            return False
        return True

    def run_phase1_plan(self):
        print_banner("PHASE 1: TARGET PLANNING")
        success, graph_path = execute_phase1()
        if not success: return False
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
        print_banner("ENTERING PLAN-EXECUTE LOOP")
        if not self.init_inventory_status(): return False
        
        # 1. 初始化 Log 和 机器人
        self.init_master_log()
        self.exec_manager.home_robot()
        
        self.history_chain = []
        nodes = self.target_graph.get('assembly_nodes', [])
        
        # =========================================================
        # MAIN LOOP: Plan -> Execute -> Update State -> Next
        # =========================================================
        for i, node in enumerate(nodes):
            node_id = node.get('node_id', i+1)
            print_banner(f"PROCESSING NODE {node_id}")

            expected_task_dir = os.path.join(self.generated_dir, f"node_{node_id}_run")
            if not os.path.exists(expected_task_dir): os.makedirs(expected_task_dir)
            
            # --- STEP 1: PLAN (LGP Solver) ---
            print(f"[Driver] Input Scene: {os.path.basename(self.current_g_file)}")
            print(f"[Driver] History Context: {len(self.history_chain)} previous nodes")
            
            # Debug: 打印当前传入的库存状态，确认是否更新
            available_items = [item['logical_id'] for item in self.inventory_data if item['status'] == 'available']
            print(f"[Driver] Current Available Inventory: {available_items}")

            # [FIX 1] 捕获 used_ids (第5个返回值)
            p2_success, output_g_file, _, node_summary, used_ids, stdout = run_phase2_pipeline(
                node, 
                self.current_g_file, 
                self.target_graph, 
                self.inventory_data, # 这里传入的是对象引用，但在循环外修改它会生效
                self.history_chain
            )
            
            if not p2_success or not stdout: 
                print(f"[Driver] ❌ Phase 2 Planning Failed at Node {node_id}. Stopping.")
                return False

            # [FIX 2] 立即更新 Live Inventory
            # 这一步是打通链路的关键：把 Node 1 用掉的东西标记为 'used'
            if used_ids:
                print(f"[Driver] 📦 Updating Inventory Status for: {used_ids}")
                update_count = 0
                for item in self.inventory_data:
                    if item['logical_id'] in used_ids:
                        if item['status'] != 'used':
                            item['status'] = 'used'
                            update_count += 1
                            print(f"   -> Marked '{item['logical_id']}' as USED.")
                if update_count == 0:
                    print(f"[Driver] ⚠️ Warning: used_ids {used_ids} returned but no matching items found in inventory.")
            
            # [FIX 3] 更新历史记忆
            if node_summary:
                print(f"[Driver] 🧠 Memory Updated: Captured summary for Node {node_id}")
                self.history_chain.append(node_summary)
            else:
                print(f"[Driver] ⚠️ Warning: No semantic summary returned for Node {node_id}")

            # --- STEP 2: LOGGING ---
            self.append_to_log(node_id, stdout)

            # --- STEP 3: EXECUTE (Physical Action) ---
            exec_success = self.exec_manager.execute_trajectory_string(stdout, node_id)
            if not exec_success:
                print(f"[Driver] ⚠️ Warning: Physical execution flagged issues.")

            # --- STEP 4: STATE CHAIN UPDATE ---
            if output_g_file and os.path.exists(output_g_file):
                print(f"[Driver] 🔗 State Chain Updated: {os.path.basename(output_g_file)}")
                self.current_g_file = output_g_file
            else:
                print(f"[Driver] ❌ CRITICAL: State file lost. Expected: {output_g_file}")
                fallback = os.path.join(expected_task_dir, "output_state.g")
                if os.path.exists(fallback):
                     print(f"[Driver] ℹ️ Found via fallback search: {fallback}")
                     self.current_g_file = fallback
                else:
                     print(f"[Driver] ⚠️ Stopping chain due to broken physics state.")
                     return False

        print_banner("ALL NODES COMPLETED")
        return True

if __name__ == "__main__":
    driver = SystemDriver()
    if driver.run_phase0_init():
        if driver.run_phase1_plan():
            driver.run_main_loop()