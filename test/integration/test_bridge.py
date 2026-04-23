#!/usr/bin/env python3
import os
import sys
import time
import rclpy

# [MIT-S1] PATH CONFIGURATION
PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
sys.path.append(PROJECT_ROOT)

from core.solver_bridge import SolverBridge
from core.trajectory_parser import TrajectoryParser
from core.ros2_bridge import get_robot

# [MIT-S2] CONFIGURATION
# NODES_TO_EXECUTE = [1, 2, 3] 
SLOW_MOTION_FACTOR = 5.0    
GRIPPER_OPEN = 0.04
GRIPPER_CLOSE = 0.0
SOLVER_BIN = os.path.join(PROJECT_ROOT, "bin", "x.exe")

# [CRITICAL] MASTER LOG LOCATION
# 所有轨迹将汇总于此。如果此文件存在，直接读取，不重新计算。
MASTER_LOG_PATH = os.path.join(PROJECT_ROOT, "test", "raw_trajectory.log")

def print_banner(text):
    print("\n" + "=" * 60)
    print(f"  {text}")
    print("=" * 60 + "\n")

def ensure_planning_complete():
    """
    检查 Master Log 是否存在。
    - 如果存在: 返回 True (Offline Mode)
    - 如果不存在: 自动扫描 test 目录下的 node_X_run 文件夹，直到找不到为止。
    """
    if os.path.exists(MASTER_LOG_PATH):
        print(f"📦 [CACHE HIT] Found existing Master Log at: {MASTER_LOG_PATH}")
        print(f"   Skipping solver. Loading trajectories directly...")
        return True

    print_banner("PHASE 1: MULTI-NODE CHAINED PLANNING (Auto-Discovery Mode)")
    
    # 1. 初始化目录和文件
    log_dir = os.path.dirname(MASTER_LOG_PATH)
    if not os.path.exists(log_dir): os.makedirs(log_dir)
    
    with open(MASTER_LOG_PATH, "w") as f:
        f.write(f"--- V-LGP MASTER EXPERIMENT LOG ---\n")
        f.write(f"Timestamp: {time.ctime()}\n")

    solver = SolverBridge(executable_path=SOLVER_BIN)
    
    # 2. 状态链初始化
    # 初始输入必须是场景文件
    current_input_g = os.path.join(PROJECT_ROOT, "test", "scenes", "scene_named.g")
    
    # [关键修改] 使用计数器循环，而不是固定列表
    node_id = 1
    
    while True:
        task_dir = os.path.join(PROJECT_ROOT, "test", f"node_{node_id}_run")
        
        # [退出条件] 如果目录不存在，说明任务链结束
        if not os.path.exists(task_dir):
            if node_id == 1:
                print(f"❌ [ERROR] No task directories found! (Checked {task_dir})")
                return False
            else:
                print(f"\n🏁 [FINISH] No directory found for Node {node_id}. Sequence completed.")
                break

        print(f"\n>>> Planning Node {node_id}...")
        print(f"   [INPUT SCENE] {os.path.basename(current_input_g)}")
        
        # A. 调用求解器
        # 注意：这里需要确保 run_pipeline.py 里的 run_solver_live 逻辑被正确封装在 SolverBridge 中
        # 如果你的 SolverBridge 需要 master_home_g，请确保这里也传递了
        success, _, stdout = solver.run(task_dir, current_input_g)
        
        if success and stdout and "V-LGP TRAJECTORY START" in stdout:
            print(f"   ✅ Node {node_id} Solved.")
            
            # B. 追加写入 Log
            with open(MASTER_LOG_PATH, "a") as f:
                f.write(f"\n\n>>> NODE {node_id} DATA START <<<\n")
                f.write(stdout)
                f.write(f"\n>>> NODE {node_id} DATA END <<<\n")
            
            # C. 链接下一个状态
            output_state_path = os.path.join(task_dir, "output_state.g")
            if os.path.exists(output_state_path):
                print(f"   [CHAIN] Linked output state to next node.")
                current_input_g = output_state_path
            else:
                print(f"   ⚠️ [WARNING] No output_state.g found in Node {node_id}. Chain logic might fail next.")
        else:
            print(f"❌ Node {node_id} Failed. Chain Broken.")
            return False
            
        # [计数器递增]
        node_id += 1

    print(f"\n✅ All Detected Nodes Planned. Log saved to: {MASTER_LOG_PATH}")
    return True

def run_execution_loop():
    print_banner("PHASE 2: PHYSICAL EXECUTION")
    
    # 1. 读取 Log
    with open(MASTER_LOG_PATH, "r") as f:
        full_content = f.read()

    # 2. 解析
    all_tasks = TrajectoryParser.parse_all(full_content, time_scale=SLOW_MOTION_FACTOR)
    
    if not all_tasks:
        print("❌ No executable trajectories found in log.")
        return
    
    print(f"📦 Loaded {len(all_tasks)} sequential tasks from log.")

    # 3. 机器人连接与归位
    try:
        robot = get_robot()
    except Exception as e:
        print(f"❌ ROS Error: {e}")
        return

    print(">>> [INIT] Homing Robot...")
    robot.set_gripper(GRIPPER_OPEN)
    robot.move_arm([{'time': 3.0, 'q': [0.0, -1.5, 0.0, -2.5, 0.0, 1.5, 0.0]}])
    time.sleep(1.0)

    # 4. 执行循环 (带智能状态机)
    for i, segments in enumerate(all_tasks):
        print(f"\n🎬 Sequence {i+1}/{len(all_tasks)} Starting...")
        
        # [SAFETY] 任务开始前强制张开，防止撞击
        print(f"   [SAFETY] Pre-Task Reset: Opening Gripper")
        robot.set_gripper(GRIPPER_OPEN)
        time.sleep(0.5)

        for p_idx, segment in enumerate(segments):
            if not segment: continue
            
            # A. 手臂移动
            duration = segment[-1]['time'] - segment[0]['time']
            print(f"   >> Phase {p_idx} (Moving... {duration:.2f}s)")
            robot.move_arm(segment)
            
            # B. 智能夹爪逻辑
            # 判断是否是复杂任务的最后一段 (通常是 Homing/Retract)
            is_last_segment = (p_idx == len(segments) - 1)
            is_complex_task = (len(segments) > 2)
            
            if is_last_segment and is_complex_task:
                print(f"      [GRIPPER] End of Sequence (Homing) -> FORCE OPEN")
                robot.set_gripper(GRIPPER_OPEN)
            
            # 正常 Pick & Place 逻辑
            elif p_idx % 2 == 0:
                print(f"      [GRIPPER] Phase {p_idx} (Pick) -> CLOSE")
                robot.set_gripper(GRIPPER_CLOSE)
            else:
                print(f"      [GRIPPER] Phase {p_idx} (Place) -> OPEN")
                robot.set_gripper(GRIPPER_OPEN)
            
            # 物理稳定
            time.sleep(0.5)
        
        print(f"✅ Sequence {i+1} Done. Cooling down...")
        time.sleep(1.0)

    print_banner("FULL EXPERIMENT COMPLETED")

if __name__ == "__main__":
    # Step 1: 确保数据准备好 (有缓存用缓存，无缓存则计算)
    if ensure_planning_complete():
        # Step 2: 执行
        run_execution_loop()