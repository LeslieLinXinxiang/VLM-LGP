import os
import sys
import time
import csv
import threading
import rclpy
from rclpy.node import Node
from rclpy.action import ActionClient
from control_msgs.action import FollowJointTrajectory, GripperCommand
from trajectory_msgs.msg import JointTrajectoryPoint
from sensor_msgs.msg import JointState # [NEW] 用于监听真实状态

# 确保能找到 core 文件夹
sys.path.append(os.path.abspath(os.path.dirname(__file__)))

from core.solver_bridge import SolverBridge
from core.trajectory_parser import TrajectoryParser

# --- 配置区 ---
SLOW_MOTION_FACTOR = 1.0  # 建议恢复为 1.0 以观察真实物理响应
GRIPPER_OPEN_POS = 0.04
GRIPPER_CLOSE_POS = 0.0
# -------------

class RobotController(Node):
    def __init__(self):
        super().__init__('vlgp_robot_bridge')
        self.arm_topic = '/panda_arm_controller/follow_joint_trajectory'
        self.hand_topic = '/panda_hand_controller/gripper_cmd'
        
        # Action Clients
        self.arm_client = ActionClient(self, FollowJointTrajectory, self.arm_topic)
        self.hand_client = ActionClient(self, GripperCommand, self.hand_topic)
        
        # [NEW] 数据记录器相关
        self.record_data = [] # 存储 (timestamp, q0, q1, ..., q6)
        self.is_recording = False
        self.start_time = 0.0
        
        # [NEW] 订阅真实关节状态 (来自 MuJoCo)
        self.joint_sub = self.create_subscription(
            JointState, 
            '/joint_states', 
            self.joint_state_callback, 
            10
        )
        
        print(f"[Init] Bridge Ready. Listening to /joint_states for logging.")

    def joint_state_callback(self, msg):
        """ 实时记录 MuJoCo 反馈的真实关节角度 """
        if not self.is_recording:
            return
            
        # 关节映射: ROS 消息里的顺序可能是乱的，必须按名字提取
        # Panda 关节名通常是 panda_joint1 ... panda_joint7
        joint_map = {name: i for i, name in enumerate(msg.name)}
        target_joints = [f'panda_joint{i+1}' for i in range(7)]
        
        try:
            current_q = []
            for name in target_joints:
                idx = joint_map[name]
                current_q.append(msg.position[idx])
            
            # 记录相对时间
            rel_time = time.time() - self.start_time
            self.record_data.append([rel_time] + current_q)
            
        except KeyError:
            # 刚启动时可能还没收到完整的关节列表
            pass

    def start_recording(self):
        self.is_recording = True
        self.start_time = time.time()
        self.record_data = []
        print(">>> [LOG] Recording Started...")

    def stop_recording(self, filename="trajectory_actual.csv"):
        self.is_recording = False
        print(f">>> [LOG] Recording Stopped. Saving {len(self.record_data)} points...")
        
        # 保存到 CSV
        with open(filename, 'w', newline='') as f:
            writer = csv.writer(f)
            writer.writerow(["time", "q1", "q2", "q3", "q4", "q5", "q6", "q7"])
            writer.writerows(self.record_data)
        print(f">>> [LOG] Saved to {filename}")

    def move_arm(self, points):
        if not points: return
        self.arm_client.wait_for_server()
        goal = FollowJointTrajectory.Goal()
        goal.trajectory.joint_names = [f'panda_joint{i+1}' for i in range(7)]
        
        for p in points:
            pt = JointTrajectoryPoint()
            pt.positions = p['q']
            pt.time_from_start.sec = int(p['time'])
            pt.time_from_start.nanosec = int((p['time'] % 1) * 1e9)
            goal.trajectory.points.append(pt)
            
        future = self.arm_client.send_goal_async(goal)
        rclpy.spin_until_future_complete(self, future)
        goal_handle = future.result()
        
        if goal_handle and goal_handle.accepted:
            res_future = goal_handle.get_result_async()
            # 在等待动作完成期间，spin 依然会处理 joint_state_callback
            rclpy.spin_until_future_complete(self, res_future)

    def set_gripper(self, position):
        if not self.hand_client.wait_for_server(timeout_sec=2.0):
            print(f"❌ Gripper Server missing!")
            return
        goal = GripperCommand.Goal()
        goal.command.position = position
        goal.command.max_effort = 100.0 
        future = self.hand_client.send_goal_async(goal)
        rclpy.spin_until_future_complete(self, future)
        time.sleep(0.5)

# --- 主逻辑 ---

_global_robot = None
def get_robot():
    global _global_robot
    if not rclpy.ok(): rclpy.init()
    if _global_robot is None:
        _global_robot = RobotController()
    return _global_robot

def save_planned_trajectory(all_tasks, filename="trajectory_planned.csv"):
    """ 保存 Solver 计算出的理想轨迹用于对比 """
    data = []
    # 展平所有任务的所有阶段
    # 注意：这里的时间是每个 Segment 重置的，为了对比，我们需要累加时间
    global_time = 0.0
    
    for task in all_tasks:
        for segment in task:
            for point in segment:
                # point['time'] 是相对该 segment 这一段的
                # 这里为了简单对比，我们直接存原始数据，或者你可以做累加
                # 建议：直接存 point['q']，后续在 Excel 里看波形形状
                data.append([point['time']] + point['q'])
            # 每个 segment 之间其实有停顿，这里简化处理
            
    with open(filename, 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(["time_ref", "q1_ref", "q2_ref", "q3_ref", "q4_ref", "q5_ref", "q6_ref", "q7_ref"])
        writer.writerows(data)
    print(f">>> [LOG] Planned trajectory saved to {filename}")

def standalone_test():
    # ... (路径设置保持不变) ...
    root_dir = os.path.abspath(os.path.dirname(__file__))
    task_dir = os.path.join(root_dir, "generated/node_1_run")
    input_g = os.path.join(root_dir, "generated/scene_named.g")
    solver_path = os.path.join(root_dir, "bin/x.exe")
    cache_file = os.path.join(task_dir, "raw_trajectory.log")

    # 1. 获取 Solver 输出
    stdout = ""
    if os.path.exists(cache_file):
        print(f"📦 [OFFLINE MODE] Loading cache...")
        with open(cache_file, "r") as f: stdout = f.read()
    else:
        print(f"📡 [ONLINE MODE] Calling Solver...")
        solver = SolverBridge(executable_path=solver_path)
        success, _, stdout = solver.run(task_dir, input_g)
        if success:
            with open(cache_file, "w") as f: f.write(stdout)

    # 2. 解析
    all_tasks = TrajectoryParser.parse_all(stdout, time_scale=SLOW_MOTION_FACTOR)
    if not all_tasks: return

    # 3. 保存理想轨迹 (基准线)
    save_planned_trajectory(all_tasks, os.path.join(task_dir, "planned.csv"))

    # 4. 执行并录制
    robot = get_robot()
    
    # 开启录制
    log_path = os.path.join(task_dir, "actual.csv")
    robot.start_recording()
    
    startup_sequence(robot)
    
    for task_idx, segments in enumerate(all_tasks):
        print(f"\n[Task {task_idx}] Executing...")
        for phase_idx, segment in enumerate(segments):
            robot.move_arm(segment)
            if phase_idx % 2 == 0:
                robot.set_gripper(GRIPPER_CLOSE_POS)
            else:
                robot.set_gripper(GRIPPER_OPEN_POS)
        time.sleep(1.0)

    # 停止录制
    robot.stop_recording(log_path)
    print("\n✅ Done. Check 'planned.csv' and 'actual.csv' in task dir.")

def startup_sequence(robot):
    q_home = [0.0, -1.5, 0.0, -2.5, 0.0, 1.5, 0.0]
    traj_point = {'time': 3.0, 'q': q_home}
    robot.move_arm([traj_point])
    robot.set_gripper(0.04)
    time.sleep(0.5)

if __name__ == "__main__":
    standalone_test()