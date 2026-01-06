# pipelines/run_phase2.py
import sys
import os
import json
import cv2
import shutil
import re

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from core.vision import SimCamera
from core.vlm import VLMClient
from core.utils import load_json, extract_and_save_files_from_xml, clean_vlm_json_output
from core.solver_bridge import SolverBridge

def parse_hybrid_output(text_output):
    """
    ROBUST PARSER: Separates JSON Summary from XML Code.
    Strategy: Split at the first occurrence of <FILE or <file.
    """
    summary_part = ""
    
    # 1. 切割：找到 XML 开始的地方
    # 查找 <FILE ...> 或 <file ...>
    xml_start = re.search(r'<FILE', text_output, re.IGNORECASE)
    
    if xml_start:
        # 取 XML 之前的所有内容作为 JSON 候选区
        summary_candidate = text_output[:xml_start.start()]
    else:
        # 如果没有 XML 标签，假设整个都是 JSON (或者出错了)
        summary_candidate = text_output

    # 2. 清洗与解析 JSON
    node_summary = None
    try:
        # 使用 core.utils 里的 clean 工具，它能处理 ```json ... ```
        cleaned_json_str = clean_vlm_json_output(summary_candidate)
        full_data = json.loads(cleaned_json_str)
        
        # 提取 node_summary
        if "node_summary" in full_data:
            node_summary = full_data["node_summary"]
        else:
            # 也许 VLM 忘了包一层，直接返回了 summary 对象？
            if "node_id" in full_data and "actions" in full_data:
                node_summary = full_data
                
        print(f"[Phase2] >>> PARSED SUMMARY SUCCESS: Node {node_summary.get('node_id', '?')}")
        
    except Exception as e:
        print(f"[Phase2] JSON Parse Warning: {e}")
        # print(f"[Debug] Failed Candidate String: \n{summary_candidate}")

    return node_summary

def run_phase2_pipeline(node_data, current_g_path, full_target_graph, inventory_data, history_chain):
    """
    history_chain: A list of dicts (Previous Node Summaries)
    """
    root_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    generated_dir = os.path.join(root_dir, "generated")
    node_id = node_data.get('node_id', 1)

    print(f"\n[Phase2] >>> Initiating Execution for Node {node_id} (Semantic-Chain Mode)...")

    # 1. VISUAL CONTEXT
    camera = SimCamera(current_g_path)
    current_img_bgr = camera.capture(save_path=os.path.join(generated_dir, "current_camera.png"))
    
    init_img_path = os.path.join(generated_dir, "phase0_capture.png")
    initial_img_bgr = cv2.imread(init_img_path)
    if initial_img_bgr is None: initial_img_bgr = current_img_bgr

    # 2. STRATEGY
    vlm = VLMClient()
    print("[Phase2] Generating Strategies...")
    strategist_prompt = os.path.join(root_dir, "prompts/phase2_strategist.md")
    
    strategy_data = vlm.propose_strategies(
        current_img_bgr, initial_img_bgr, node_data, 
        full_target_graph, inventory_data, strategist_prompt
    )
    
    # 3. DECIDER & CODER
    print("[Phase2] Compiling Action Code...")
    print(f"[Phase2] Injecting Semantic History: {json.dumps(history_chain, indent=1)}") 
    
    decider_prompt = os.path.join(root_dir, "prompts/phase2_decider&coder.md")
    
    code_xml_output = vlm.decide_and_compile(
        strategy_data,
        current_img_bgr, 
        initial_img_bgr, 
        node_data, 
        inventory_data, 
        history_chain, # Passing the LIST of summaries
        decider_prompt
    )

    # 4. ROBUST PARSING (NEW)
    node_summary = parse_hybrid_output(code_xml_output)
    
    if not node_summary:
        print(f"[Phase2] CRITICAL WARNING: No semantic summary captured for Node {node_id}!")
        print("[Phase2] History Chain will break. Proceeding with caution...")

    # 5. FILE GENERATION
    task_dir = os.path.join(generated_dir, f"node_{node_id}_run")
    print(f"[Phase2] Preparing Task Directory: {task_dir}")
    extract_and_save_files_from_xml(code_xml_output, task_dir)
    
    # Extract inventory IDs for driver tracking
    used_ids = []
    if node_summary:
        for action in node_summary.get("actions", []):
            if "logical_id" in action:
                used_ids.append(action["logical_id"])

    # 6. SOLVER EXECUTION
    solver_path = os.path.join(root_dir, "bin/x.exe")
    solver = SolverBridge(executable_path=solver_path)
    
    success, output_g_path = solver.run(task_dir, current_g_path)
    
    result_img_path = None
    if success and output_g_path:
        camera.reload(output_g_path)
        result_img_path = os.path.join(generated_dir, f"node_{node_id}_result.png")
        camera.capture(save_path=result_img_path)

    return success, output_g_path, result_img_path, node_summary, used_ids