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
NODES_TO_EXECUTE = [1, 2, 3] 
SLOW_MOTION_FACTOR = 5.0    
GRIPPER_OPEN = 0.04
GRIPPER_CLOSE = 0.0
SOLVER_BIN = os.path.join(PROJECT_ROOT, "bin", "x.exe")
MASTER_LOG_PATH = os.path.join(PROJECT_ROOT, "generated", "node_1_run", "raw_trajectory.log")

def print_banner(text):
    print("\n" + "=" * 60)
    print(f"  {text}")
    print("=" * 60 + "\n")

# ... (run_planning_phase 保持不变，省略以节省空间，请保留原有的 run_planning_phase) ...
def run_planning_phase():
    """
    Phase 1: 依次求解，建立状态链，生成统一 Log。
    """
    print_banner("PHASE 1: CHAINED PLANNING")
    
    log_dir = os.path.dirname(MASTER_LOG_PATH)
    if not os.path.exists(log_dir): os.makedirs(log_dir)
    
    # 清空并初始化 Log
    with open(MASTER_LOG_PATH, "w") as f:
        f.write(f"--- V-LGP MASTER EXPERIMENT LOG ---\n")
        f.write(f"Timestamp: {time.ctime()}\n")

    solver = SolverBridge(executable_path=SOLVER_BIN)
    current_input_g = os.path.join(PROJECT_ROOT, "generated", "scene_named.g")
    
    for node_id in NODES_TO_EXECUTE:
        print(f"\n>>> Planning Node {node_id}...")
        task_dir = os.path.join(PROJECT_ROOT, "generated", f"node_{node_id}_run")
        
        if not os.path.exists(task_dir):
            print(f"   [ERROR] Missing dir: {task_dir}")
            return

        # 调用 Solver
        success, _, stdout = solver.run(task_dir, current_input_g)
        
        if success and stdout and "V-LGP TRAJECTORY START" in stdout:
            print(f"   ✅ Node {node_id} Solved.")
            # 写入 Log
            with open(MASTER_LOG_PATH, "a") as f:
                f.write(f"\n\n>>> NODE {node_id} DATA START <<<\n")
                f.write(stdout)
                f.write(f"\n>>> NODE {node_id} DATA END <<<\n")
            
            # 更新状态链
            output_state_path = os.path.join(task_dir, "output_state.g")
            if os.path.exists(output_state_path):
                print(f"   [CHAIN] Linking output state -> next input.")
                current_input_g = output_state_path
            else:
                print(f"   ⚠️ [WARNING] No output_state.g found. Physics continuity at risk.")
        else:
            print(f"   ❌ Node {node_id} Failed.")
            # 可选择 return 中止，或继续尝试

    print(f"\n✅ Planning Phase Complete. Log: {MASTER_LOG_PATH}")

def run_execution_phase():
    """
    Phase 2: 物理执行，带详细状态日志。
    """
    print_banner("PHASE 2: PHYSICAL EXECUTION")
    
    if not os.path.exists(MASTER_LOG_PATH):
        print(f"❌ Log file missing.")
        return

    with open(MASTER_LOG_PATH, "r") as f:
        full_content = f.read()

    # 解析
    all_tasks = TrajectoryParser.parse_all(full_content, time_scale=SLOW_MOTION_FACTOR)
    
    if not all_tasks:
        print("❌ No trajectories parsed.")
        return
    
    print(f"📦 Loaded {len(all_tasks)} sequential tasks.")

    try:
        robot = get_robot()
    except Exception as e:
        print(f"❌ ROS Error: {e}")
        return

    # 全局初始化
    print(">>> [INIT] Homing Robot...")
    robot.set_gripper(GRIPPER_OPEN)
    robot.move_arm([{'time': 3.0, 'q': [0.0, -1.5, 0.0, -2.5, 0.0, 1.5, 0.0]}])
    time.sleep(1.0)

    # --- EXECUTION LOOP ---
    for i, segments in enumerate(all_tasks):
        print("\n" + "-"*40)
        print(f"🎬 SEQUENCE {i+1} START")
        print("-"*40)
        
        # [DEBUG: FORCE STATE] 
        # 强制打印并执行张开，且给予长时间等待
        print(f"   [STATUS: INIT] Checking Gripper State...")
        print(f"   [COMMAND] >> FORCE GRIPPER OPEN ({GRIPPER_OPEN})")
        
        # 双重保险：发两次，确保 ROS topic 收到
        robot.set_gripper(GRIPPER_OPEN) 
        time.sleep(0.1)
        robot.set_gripper(GRIPPER_OPEN)
        
        print(f"   [WAITING] Allowing 2.0s for physical actuation...")
        time.sleep(2.0) # 关键：给足够的时间让它物理张开
        print(f"   [STATUS: READY] Gripper should be OPEN now.")

        for p_idx, segment in enumerate(segments):
            if not segment: continue
            
            # 打印当前阶段意图
            print(f"   >> Phase {p_idx}: Executing Arm Trajectory...", end="")
            robot.move_arm(segment)
            print(" [DONE]")
            
            # 智能状态机逻辑
            is_last_segment = (p_idx == len(segments) - 1)
            is_complex_task = (len(segments) > 2)
            
            target_state = "UNKNOWN"
            
            if is_last_segment and is_complex_task:
                target_state = "OPEN (Reset)"
                robot.set_gripper(GRIPPER_OPEN)
            elif p_idx % 2 == 0:
                target_state = "CLOSE (Pick)"
                robot.set_gripper(GRIPPER_CLOSE)
            else:
                target_state = "OPEN (Place)"
                robot.set_gripper(GRIPPER_OPEN)
            
            print(f"      [GRIPPER STATUS] Phase {p_idx} End -> {target_state}")
            
            # 等待物理稳定
            time.sleep(0.5)
        
        print(f"✅ Sequence {i+1} Complete.")
        time.sleep(1.0)

    print_banner("FULL EXPERIMENT SUCCESS")

if __name__ == "__main__":
    run_planning_phase()
    run_execution_phase()