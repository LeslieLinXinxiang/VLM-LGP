#!/usr/bin/env python3
import os
import sys
import time
import json

# [MIT-S1] PATH CONFIGURATION
PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
sys.path.append(PROJECT_ROOT)

from core.solver_bridge import SolverBridge
from core.trajectory_parser import TrajectoryParser
# [MIT-FIX] 引入 ZMQ Bridge (确保 core/zmq_bridge.py 存在)
from core.zmq_bridge import ExecutionManager 

# [MIT-S2] CONFIGURATION
NODES_TO_EXECUTE = [1, 2, 3] 
SLOW_MOTION_FACTOR = 5.0    
GRIPPER_OPEN = 0.04
GRIPPER_CLOSE = 0.0
SOLVER_BIN = os.path.join(PROJECT_ROOT, "docker_bin", "x.exe")
MASTER_LOG_PATH = os.path.join(PROJECT_ROOT, "test", "raw_trajectory.log")

def print_banner(text):
    print("\n" + "=" * 60)
    print(f"  {text}")
    print("=" * 60 + "\n")

def ensure_planning_complete():
    """
    逻辑修复：如果日志不存在，必须调用 Solver 生成它！
    """
    if os.path.exists(MASTER_LOG_PATH):
        print(f"📦 [CACHE HIT] Found existing Master Log at: {MASTER_LOG_PATH}")
        return True

    print_banner("PHASE 1: PLANNING (Calculating Trajectories...)")
    
    # 1. 初始化目录
    log_dir = os.path.dirname(MASTER_LOG_PATH)
    if not os.path.exists(log_dir): os.makedirs(log_dir)
    
    # 2. 准备求解器
    solver = SolverBridge(executable_path=SOLVER_BIN)
    current_input_g = os.path.join(PROJECT_ROOT, "test", "scenes", "scene_named.g")
    
    # 3. 开始记录
    full_log_content = f"--- V-LGP MASTER EXPERIMENT LOG ---\nTimestamp: {time.ctime()}\n"

    for node_id in NODES_TO_EXECUTE:
        print(f"\n>>> Planning Node {node_id}...")
        task_dir = os.path.join(PROJECT_ROOT, "test", f"node_{node_id}_run")
        
        if not os.path.exists(task_dir):
            print(f"❌ [ERROR] Task directory missing: {task_dir}")
            return False

        # 调用 C++ 求解器
        success, _, stdout = solver.run(task_dir, current_input_g)
        
        if success and stdout and "V-LGP TRAJECTORY START" in stdout:
            print(f"   ✅ Node {node_id} Solved.")
            full_log_content += f"\n\n>>> NODE {node_id} DATA START <<<\n"
            full_log_content += stdout
            full_log_content += f"\n>>> NODE {node_id} DATA END <<<\n"
            
            # 链接下一个状态
            output_state_path = os.path.join(task_dir, "output_state.g")
            if os.path.exists(output_state_path):
                current_input_g = output_state_path
            else:
                print(f"   ⚠️ [WARNING] No output state found. Chain might break.")
        else:
            print(f"❌ Node {node_id} Failed.")
            return False

    # 4. 写入文件
    with open(MASTER_LOG_PATH, "w") as f:
        f.write(full_log_content)
    
    print(f"\n✅ Planning Complete. Log saved to: {MASTER_LOG_PATH}")
    return True

def run_execution_loop():
    print_banner("PHASE 2: ZMQ REMOTE EXECUTION")
    
    # 1. 读取 Log
    if not os.path.exists(MASTER_LOG_PATH):
        print("❌ Log file not found (Planning failed?).")
        return

    with open(MASTER_LOG_PATH, "r") as f:
        full_content = f.read()

    # 2. 解析
    all_tasks = TrajectoryParser.parse_all(full_content, time_scale=SLOW_MOTION_FACTOR)
    
    if not all_tasks:
        print("❌ No executable trajectories found in log.")
        return
    
    print(f"📦 Loaded {len(all_tasks)} sequential tasks.")

    # 3. [MIT-FIX] 初始化 ZMQ 连接
    print(">>> [INIT] Connecting to Host via ZMQ...")
    try:
        bridge = ExecutionManager()
        # 尝试复位机器人
        if bridge.home_robot():
            print("   ✅ Connection Established & Robot Homed.")
        else:
            print("   ⚠️ Connection made, but Homing failed (Mock server might be lazy).")
    except Exception as e:
        print(f"❌ ZMQ Connection Failed: {e}")
        print("   (Did you run 'python3 host_mock.py' on the Host?)")
        return

    # 4. 执行循环
    for i, segments in enumerate(all_tasks):
        print(f"\n🎬 Sequence {i+1}/{len(all_tasks)} Starting...")
        
        # [SAFETY] 任务开始前强制张开
        print(f"   [SAFETY] Pre-Task Reset: Opening Gripper")
        bridge.move_gripper(GRIPPER_OPEN)
        time.sleep(0.5)

        for p_idx, segment in enumerate(segments):
            if not segment: continue
            
            # 计算耗时
            duration = segment[-1]['time'] - segment[0]['time']
            print(f"   >> Phase {p_idx} (Sending Trajectory... {duration:.2f}s)")
            
            # 提取关节角度 [q1, q2, ...]
            waypoints = [pt['q'] for pt in segment]
            
            # 发送给 Host
            success = bridge.execute_trajectory(waypoints)
            if not success:
                print("❌ Host reported execution failure!")
                return
            
            # 智能夹爪逻辑
            is_last_segment = (p_idx == len(segments) - 1)
            is_complex_task = (len(segments) > 2)
            
            target_width = None
            if is_last_segment and is_complex_task:
                print(f"      [GRIPPER] End of Sequence -> OPEN")
                target_width = GRIPPER_OPEN
            elif p_idx % 2 == 0:
                print(f"      [GRIPPER] Phase {p_idx} (Pick) -> CLOSE")
                target_width = GRIPPER_CLOSE
            else:
                print(f"      [GRIPPER] Phase {p_idx} (Place) -> OPEN")
                target_width = GRIPPER_OPEN
            
            if target_width is not None:
                bridge.move_gripper(target_width)
            
            # 等待物理稳定
            time.sleep(0.1)
        
        print(f"✅ Sequence {i+1} Done.")
        time.sleep(0.5)

    print_banner("FULL EXPERIMENT COMPLETED")

if __name__ == "__main__":
    # 如果 raw_trajectory.log 不存在，ensure_planning_complete 会调用 C++ 求解器生成它
    # 如果存在，则直接读取
    if ensure_planning_complete():
        run_execution_loop()
