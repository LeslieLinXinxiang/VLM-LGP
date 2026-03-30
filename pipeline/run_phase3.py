import sys
import os
import json
import time

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from core.vlm import VLMClient
from core.utils import load_incontext_examples, load_json

class Phase3Manager:
    def __init__(self):
        self.vlm = VLMClient()
        self.root_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
        
        # [CRITICAL] Pre-load In-Context Examples (Reuse Phase 1 data)
        # 确保你的路径下有 labeled_output 文件夹和生成的图片
        train_dir = os.path.join(self.root_dir, "incontext_training", "labeled_output")
        if not os.path.exists(train_dir):
            # Fallback to orientations if labeled_output doesn't exist
            train_dir = os.path.join(self.root_dir, "incontext_training", "orientations")
            
        print(f"[Phase3] Loading Training Examples from: {train_dir}")
        self.example_data = load_incontext_examples(train_dir)

    def validate_node(self, reality_img_path, target_node_data):
        """
        Compares Reality (Image) vs Target (JSON Node).
        Returns: (bool is_match, str report)
        """
        print(f"\n>>> STARTING PHASE 3: EXECUTION VERIFICATION")
        
        prompt_analyst = os.path.join(self.root_dir, "prompts/phase3_analyst.md")
        prompt_architect = os.path.join(self.root_dir, "prompts/phase3_architect.md")

        # 1. Analyst: Image -> Text
        report = self.vlm.run_phase3_analyst(reality_img_path, prompt_analyst, self.example_data)
        print(f"[P3 Analyst Report]:\n{report}\n")

        # 2. Architect: Text -> JSON
        current_state_json = self.vlm.run_phase3_architect(report, prompt_architect)
        # print(f"[P3 Current State]: {json.dumps(current_state_json, indent=2)}")

        # 3. Judge: Python Logic Check
        is_pass, diff_log = self._compare_graphs(target_node_data, current_state_json)

        if is_pass:
            print(">>> [P3] VERIFICATION PASSED: Reality matches Target.")
            return True, "Match"
        else:
            print(f">>> [P3] VERIFICATION FAILED:\n{diff_log}")
            return False, diff_log

    def _compare_graphs(self, target_node, current_layout):
        """
        Pure Python Logic: Set Difference
        Target Node Format: { actions: [ {at_slot: ...}, ... ] }
        Current Layout Format: { layout: [ {at_slot: ...}, ... ] }
        """
        errors = []
        
        # A. Extract Target Slots (Expected)
        # Filter out 'base' actions (usually at_slot is None or place_base1)
        # We only care about cylinders for now
        target_slots = set()
        for action in target_node.get('actions', []):
            if action.get('object') == 'cylinder':
                slot = action.get('at_slot')
                if slot: target_slots.add(slot)

        # B. Extract Current Slots (Reality)
        current_slots = set()
        for item in current_layout.get('layout', []):
            if item.get('object') == 'cylinder':
                slot = item.get('at_slot')
                if slot: current_slots.add(slot)

        # C. Calculate Diff
        missing = target_slots - current_slots
        intruder = current_slots - target_slots

        # D. Generate Verdict
        if missing:
            errors.append(f"[MISSING]: Expected cylinders at {list(missing)}, but slots are empty.")
        
        if intruder:
            errors.append(f"[INTRUDER]: Found unexpected objects at {list(intruder)}.")

        if not errors:
            return True, "Perfect Match"
        else:
            return False, "\n".join(errors)

# 单独运行测试用的入口
if __name__ == "__main__":
    # Mock Data for testing
    p3 = Phase3Manager()
    
    # 假设这是 Phase 1 生成的目标
    mock_target = {
        "actions": [
            {"object": "base", "at_slot": "place_base1"},
            {"object": "cylinder", "at_slot": "top_left"},
            {"object": "cylinder", "at_slot": "bottom_right"}
        ]
    }
    
    # 请替换为你实际的测试图片路径
    test_img = "generated/node_1_result.png" 
    
    if os.path.exists(test_img):
        p3.validate_node(test_img, mock_target)
    else:
        print("Please provide a valid image path to test.")