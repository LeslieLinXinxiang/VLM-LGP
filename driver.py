import os
import sys
import json
import cv2
import time

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from pipelines.run_phase0 import execute_phase0
from pipelines.run_phase1 import execute_phase1
from pipelines.run_phase2 import run_phase2_pipeline
from pipelines.run_phase3 import Phase3Manager
# from core.vision import ImageSlicer # [REMOVED] No longer needed for Phase 3 logic
from core.solver_bridge import SolverBridge
from core.utils import load_json, extract_and_save_files_from_xml

def print_banner(text):
    print("\n" + "#" * 60)
    print(f"  {text}")
    print("#" * 60 + "\n")

class SystemDriver:
    def __init__(self):
        self.root_dir = os.path.abspath(os.path.dirname(__file__))
        self.generated_dir = os.path.join(self.root_dir, "generated")
        self.current_g_file = os.path.join(self.generated_dir, "scene_named.g")
        self.target_graph = None
        self.inventory_data = [] 
        self.solver_bridge = SolverBridge(os.path.join(self.root_dir, "bin/x.exe"))

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
        print(f"[Driver] Nodes to execute: {len(self.target_graph.get('assembly_nodes', []))}")
        return True

    def init_inventory_status(self):
        layout_path = os.path.join(self.generated_dir, "phase0_layout.json")
        self.inventory_data = load_json(layout_path)
        if not self.inventory_data: return False
        for item in self.inventory_data: item['status'] = 'available'
        return True
    
    def update_inventory_status(self, used_ids):
        if not used_ids: return
        for item in self.inventory_data:
            if item['logical_id'] in used_ids: item['status'] = 'used'

    def run_execution_loop(self):
        print_banner("ENTERING EXECUTION LOOP")
        if not self.init_inventory_status(): return False
        
        self.history_chain = []
        
        # [CHANGE] No longer slicing images. We compare logic against logic.
        
        # Initialize Phase 3 Manager (No args needed now)
        p3_manager = Phase3Manager()
        
        nodes = self.target_graph.get('assembly_nodes', [])
        
        for i, node in enumerate(nodes):
            node_id = node.get('node_id', i+1)
            print(f"\n>>> PROCESSING NODE {node_id}")
            
            # --- PHASE 2: EXECUTION ---
            p2_success, new_g_path, result_img_path, node_summary, used_ids = run_phase2_pipeline(
                node, 
                self.current_g_file, 
                self.target_graph, 
                self.inventory_data, 
                self.history_chain
            )
            
            if not p2_success: 
                print(f"[Driver] Phase 2 Execution Failed at Node {node_id}")
                return False
            
            # Update State
            if node_summary: self.history_chain.append(node_summary)
            self.update_inventory_status(used_ids)
            self.current_g_file = new_g_path

            # --- PHASE 3: ADJUDICATION (AAJ Architecture) ---
            print(f"[Driver] Phase 3: Validating execution against Target Node {node_id}...")
            
            if result_img_path and os.path.exists(result_img_path):
                # [CORE LOGIC CHANGE] 
                # Call validate_node with (Image, Target_JSON_Node)
                is_match, report = p3_manager.validate_node(result_img_path, node)
                
                if is_match:
                    print(f"[Driver] Node {node_id} VERIFIED. Proceeding.")
                else:
                    print(f"[Driver] Node {node_id} FAILED VALIDATION.")
                    print(f"[Driver] Verification Report:\n{report}")
                    
                    # [TODO] Future: Inject Debug/Correction Logic here.
                    # For now, we print the error and stop (or continue based on your preference).
                    print("[Driver] Stopping due to verification failure.")
                    return False 
            else:
                print("[Driver] Error: No result image found for Phase 3.")
                return False

        print("\n>>> ALL NODES EXECUTED SUCCESSFULLY.")
        return True

if __name__ == "__main__":
    driver = SystemDriver()
    if driver.run_phase0_init():
        if driver.run_phase1_plan():
            driver.run_execution_loop()