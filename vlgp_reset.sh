#!/bin/bash

# V-LGP Surgical Reset Protocol (Host-to-Container version)
echo "🔄 [HOST] Initiating V-LGP Surgical Reset inside Docker..."

# 1. 杀掉容器内的物理引擎和控制器进程
echo "   [1/3] Terminating Physics Engine & Spawners in vlm_sim..."
docker exec vlm_sim bash -c "pkill -9 -f mujoco_ros2_control; pkill -9 -f spawner"

# 等待 1 秒让端口彻底释放
sleep 1

# 2. 重新拉起物理引擎 (后台运行)
echo "   [2/3] Relaunching MuJoCo Physics node..."
# 注意：这里使用了之前验证过的路径配置
docker exec -d vlm_sim bash -c "source /opt/ros/humble/setup.bash; source /root/ros2_ws/install/setup.bash; export ROS_DOMAIN_ID=99; ros2 run mujoco_ros2_control mujoco_ros2_control --ros-args -p robot_description:=\"\$(ros2 run moveit_resources_panda_description echo_robot_description)\" -p mujoco_model_path:=/root/ros2_ws/install/panda_mujoco/share/panda_mujoco/franka_emika_panda/scene.xml -p use_sim_time:=True --params-file /root/ros2_ws/install/interactive_marker/share/interactive_marker/config/panda_clean_controllers.yaml"

# 等待 MuJoCo 核心初始化（根据机器性能可调整 2-3秒）
sleep 2

# 3. 重新刷出控制器 (同步执行)
echo "   [3/3] Re-spawning Controllers..."
docker exec vlm_sim bash -c "source /opt/ros/humble/setup.bash; source /root/ros2_ws/install/setup.bash; export ROS_DOMAIN_ID=99; ros2 run controller_manager spawner joint_state_broadcaster --controller-manager /controller_manager; ros2 run controller_manager spawner panda_arm_controller --controller-manager /controller_manager; ros2 run controller_manager spawner panda_hand_controller --controller-manager /controller_manager"

echo "🎉 [DONE] Reset Complete. Objects returned to initial positions. Robot ready."
