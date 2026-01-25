import os
from launch import LaunchDescription
from launch_ros.actions import Node
from launch.actions import RegisterEventHandler
from launch.event_handlers import OnProcessStart, OnProcessExit
from ament_index_python.packages import get_package_share_directory
from moveit_configs_utils import MoveItConfigsBuilder

def generate_launch_description():
    moveit_config = (
        MoveItConfigsBuilder("moveit_resources_panda")
        .robot_description(
            file_path="config/panda.urdf.xacro",
            mappings={"ros2_control_hardware_type": "mujoco"},
        )
        .robot_description_semantic(file_path="config/panda.srdf")
        .trajectory_execution(file_path="config/gripper_moveit_controllers.yaml")
        .planning_pipelines(pipelines=["ompl", "pilz_industrial_motion_planner"])
        .to_moveit_configs()
    )

    # 1. MoveIt (保留，作为后台规划服务)
    move_group_node = Node(
        package="moveit_ros_move_group",
        executable="move_group",
        output="screen",
        parameters=[moveit_config.to_dict(), {"use_sim_time": True}]
    )

    # 2. RViz [已移除] - 节省资源
    # rviz_config_file = os.path.join(
    #     get_package_share_directory("interactive_marker"),
    #     "config",
    #     "interactive_marker.rviz",
    # )
    # rviz_node = Node(
    #     package="rviz2", executable="rviz2", name="rviz2", output="log",
    #     arguments=["-d", rviz_config_file],
    #     parameters=[
    #         moveit_config.robot_description,
    #         moveit_config.robot_description_semantic,
    #         moveit_config.robot_description_kinematics,
    #         moveit_config.planning_pipelines,
    #         moveit_config.joint_limits,
    #         {"use_sim_time": True}
    #     ],
    # )

    # 3. TF & State Publisher (必须保留，用于广播坐标系)
    world2robot_tf_node = Node(
        package="tf2_ros", executable="static_transform_publisher", name="static_transform_publisher",
        output="log", arguments=["--frame-id", "world", "--child-frame-id", "panda_link0"],
        parameters=[{"use_sim_time": True}]
    )
    robot_state_publisher = Node(
        package="robot_state_publisher", executable="robot_state_publisher", name="robot_state_publisher",
        output="both", parameters=[moveit_config.robot_description, {"use_sim_time": True}],
    )

    # 4. 核心物理引擎节点
    ros2_controllers_path = os.path.join(
        get_package_share_directory("interactive_marker"),
        "config",
        "panda_clean_controllers.yaml",
    )

    node_mujoco_ros2_control = Node(
        package='mujoco_ros2_control',
        executable='mujoco_ros2_control',
        output='screen',
        parameters=[
            moveit_config.robot_description,
            ros2_controllers_path,
            {'mujoco_model_path':os.path.join(get_package_share_directory('panda_mujoco'), 'franka_emika_panda', 'scene.xml')},
            {"use_sim_time": True}
        ]
    )

    # 5. Spawners
    joint_state_broadcaster_spawner = Node(
        package="controller_manager", executable="spawner",
        arguments=["joint_state_broadcaster", "--controller-manager", "/controller_manager"],
    )

    panda_arm_controller_spawner = Node(
        package="controller_manager", executable="spawner",
        arguments=["panda_arm_controller", "-c", "/controller_manager"],
    )

    panda_hand_controller_spawner = Node(
        package="controller_manager", executable="spawner",
        arguments=["panda_hand_controller", "-c", "/controller_manager"],
    )

    return LaunchDescription([
        RegisterEventHandler(
            event_handler=OnProcessStart(
                target_action=node_mujoco_ros2_control,
                on_start=[joint_state_broadcaster_spawner],
            )
        ),
        RegisterEventHandler(
            event_handler=OnProcessExit(
                target_action=joint_state_broadcaster_spawner,
                on_exit=[panda_arm_controller_spawner],
            )
        ),
        RegisterEventHandler(
            event_handler=OnProcessExit(
                target_action=panda_arm_controller_spawner,
                on_exit=[panda_hand_controller_spawner],
            )
        ),
        
        # 移除了 rviz_node
        world2robot_tf_node, 
        robot_state_publisher, 
        move_group_node, 
        node_mujoco_ros2_control
    ])