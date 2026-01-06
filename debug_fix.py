import os
import sys
from core.solver_bridge import SolverBridge
from pipelines.run_phase3 import Phase3Manager
from core.utils import extract_and_save_files_from_xml

def run_debug_correction(node_id, anomaly_color):
    print(f"\n>>> DEBUG: TRIGGERING CORRECTION FOR NODE {node_id}")
    
    root_dir = os.path.abspath(os.path.dirname(__file__))
    generated_dir = os.path.join(root_dir, "generated")
    
    # 1. 模拟上下文 (Mock Context)
    # Phase 2 跑完后的物理状态 (残局)
    # 注意：根据你的日志，Phase 2 的结果保存在 node_1_run/output_state.g
    current_g_file = os.path.join(generated_dir, f"node_{node_id}_run", "output_state.g")
    
    # 目标切片
    target_slice = os.path.join(generated_dir, f"node_{node_id}_target.png")
    
    # 模拟 Adjudicator 的发现 (直接硬编码你日志里的错误)
    mock_anomaly = {
        'observed_object_color': anomaly_color, 
        'anomaly_location': 'front-left' # 仅仅为了日志展示
    }

    if not os.path.exists(current_g_file):
        print(f"[Error] State file not found: {current_g_file}")
        print("Did Phase 2 finish?")
        return

    # 2. 初始化模块
    p3_manager = Phase3Manager(id_map_path="generated/phase0_layout.json")
    solver_bridge = SolverBridge(os.path.join(root_dir, "bin/x.exe"))

    # 3. 生成修复代码 (Call VLM)
    print(f"[Debug] Asking VLM to fix '{anomaly_color}' object...")
    fix_xml_output = p3_manager.generate_fix(
        mock_anomaly, 
        target_slice,
        node_id
    )

    if fix_xml_output:
        # 4. 准备修复目录
        fix_dir = os.path.join(generated_dir, f"node_{node_id}_fix")
        print(f"[Debug] Fix Directory: {fix_dir}")
        
        saved_files = extract_and_save_files_from_xml(fix_xml_output, fix_dir)
        
        if saved_files:
            print(f"[Debug] Generated {len(saved_files)} LGP files.")
            
            # 5. 执行修复 (Call Solver)
            # 关键：基于 current_g_file (残局) 执行修复
            print("[Debug] Executing Fix in Solver...")
            success, fixed_g_path = solver_bridge.run(fix_dir, current_g_file)
            
            if success:
                print("\n>>> [SUCCESS] Fix Executed!")
                print(f"New State: {fixed_g_path}")
            else:
                print("\n>>> [FAIL] Solver Execution Failed.")
        else:
            print("[Error] No LGP files extracted from XML.")
    else:
        print("[Error] VLM returned no XML.")

if __name__ == "__main__":
    # 在这里填入你刚才报错的那个节点信息
    # Node 1, 黄色物体放错了
    run_debug_correction(node_id=1, anomaly_color="yellow")