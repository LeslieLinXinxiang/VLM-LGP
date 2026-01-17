import rclpy
from rclpy.node import Node
from rclpy.action import ActionClient
from control_msgs.action import FollowJointTrajectory, GripperCommand
from trajectory_msgs.msg import JointTrajectoryPoint
import time
import sys
import os

# 引入轨迹解析器
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from core.trajectory_parser import TrajectoryParser

# [MIT-S2] PHYSICS PARAMETERS (From test_bridge.py)
SLOW_MOTION_FACTOR = 5.0    # 物理执行慢放倍率
GRIPPER_OPEN = 0.04
GRIPPER_CLOSE = 0.0

# ==============================================================================
# CLASS 1: LOW-LEVEL COMMUNICATION (原 RobotController)
# ==============================================================================
class RobotController(Node):
    def __init__(self):
        super().__init__('vlgp_robot_bridge')
        
        # 1. 手臂控制客户端
        self.arm_client = ActionClient(
            self, 
            FollowJointTrajectory, 
            '/panda_arm_controller/follow_joint_trajectory'
        )

        # 2. 夹爪控制客户端
        self.hand_client = ActionClient(
            self, 
            GripperCommand, 
            '/panda_hand_controller/gripper_cmd'
        )

    def move_arm(self, points):
        """发送 7 自由度手臂轨迹"""
        if not points: return
        print(f"   📡 [ROS2] Sending Trajectory ({len(points)} pts)...")
        
        if not self.arm_client.wait_for_server(timeout_sec=2.0):
            print("   ❌ [ROS2] Arm Action Server not available!")
            return

        goal = FollowJointTrajectory.Goal()
        goal.trajectory.joint_names = [
            'panda_joint1', 'panda_joint2', 'panda_joint3', 
            'panda_joint4', 'panda_joint5', 'panda_joint6', 'panda_joint7'
        ]

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
            rclpy.spin_until_future_complete(self, res_future)

    def set_gripper(self, position):
        """控制夹爪"""
        # print(f"   🗜️ [ROS2] Gripper -> {position}")
        if not self.hand_client.wait_for_server(timeout_sec=2.0):
            print("   ❌ [ROS2] Hand Action Server not available!")
            return

        goal = GripperCommand.Goal()
        goal.command.position = position
        goal.command.max_effort = 10.0
        
        future = self.hand_client.send_goal_async(goal)
        rclpy.spin_until_future_complete(self, future)
        time.sleep(0.5) # 物理稳定缓冲

# 单例模式获取 Robot
_global_robot = None
def get_robot():
    global _global_robot
    if not rclpy.ok(): rclpy.init()
    if _global_robot is None:
        _global_robot = RobotController()
    return _global_robot


# ==============================================================================
# CLASS 2: HIGH-LEVEL EXECUTION MANAGER (原 test_bridge.py 逻辑)
# ==============================================================================
class ExecutionManager:
    def __init__(self):
        self.robot = get_robot()
        self.slow_motion = SLOW_MOTION_FACTOR

    def home_robot(self):
        print(">>> [EXEC] Homing Robot...")
        self.robot.set_gripper(GRIPPER_OPEN)
        # Standard Home Pose
        home_pt = {'time': 3.0, 'q': [0.0, -1.5, 0.0, -2.5, 0.0, 1.5, 0.0]}
        self.robot.move_arm([home_pt])
        time.sleep(1.0)

    def execute_trajectory_string(self, stdout_data, node_id="Unknown"):
        """
        解析 Solver 的原始输出字符串，并立即在真机/仿真中执行。
        包含智能夹爪状态机逻辑。
        """
        print(f"\n⚡ [EXEC] Starting Physical Execution for Node {node_id}...")
        
        # 1. 解析
        all_tasks = TrajectoryParser.parse_all(stdout_data, time_scale=self.slow_motion)
        
        if not all_tasks:
            print(f"   ⚠️ [EXEC] No executable trajectory found in output.")
            return False

        # 2. 任务前安全重置 (Pre-Task Safety)
        print(f"   🛡️ [SAFETY] Pre-Task Reset: Opening Gripper")
        self.robot.set_gripper(GRIPPER_OPEN)
        time.sleep(0.5)

        # 3. 遍历执行
        for i, segments in enumerate(all_tasks):
            # print(f"   🎬 Sequence {i+1}/{len(all_tasks)} Running...")
            
            for p_idx, segment in enumerate(segments):
                if not segment: continue
                
                # A. 移动手臂
                duration = segment[-1]['time'] - segment[0]['time']
                print(f"      >> Phase {p_idx} (Arm Move {duration:.1f}s)...", end="", flush=True)
                self.robot.move_arm(segment)
                print(" Done.")
                
                # B. 智能夹爪逻辑 (Smart Gripper State Machine)
                is_last_segment = (p_idx == len(segments) - 1)
                is_complex_task = (len(segments) > 2)
                
                if is_last_segment and is_complex_task:
                    print(f"         🗜️ [GRIPPER] Homing/Retract -> FORCE OPEN")
                    self.robot.set_gripper(GRIPPER_OPEN)
                
                elif p_idx % 2 == 0:
                    print(f"         🗜️ [GRIPPER] Pick Phase -> CLOSE")
                    self.robot.set_gripper(GRIPPER_CLOSE)
                else:
                    print(f"         🗜️ [GRIPPER] Place Phase -> OPEN")
                    self.robot.set_gripper(GRIPPER_OPEN)
                
                # 物理稳定
                time.sleep(0.5)
            
            time.sleep(0.5)
        
        print(f"   ✅ [EXEC] Node {node_id} Physical Execution Complete.")
        return True

# ==============================================================================
# STANDALONE DEBUG INTERFACE
# ==============================================================================
if __name__ == "__main__":
    print(">>> ROS 2 Bridge Standalone Test Mode <<<")
    mgr = ExecutionManager()
    mgr.home_robot()
    print("Test Complete.")