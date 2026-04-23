import os
from launch import LaunchDescription
from launch_ros.actions import Node
from launch.actions import RegisterEventHandler, DeclareLaunchArgument, TimerAction
from launch.event_handlers import OnProcessStart, OnProcessExit
from launch.substitutions import LaunchConfiguration, PathJoinSubstitution
from ament_index_python.packages import get_package_share_directory
from moveit_configs_utils import MoveItConfigsBuilder

def generate_launch_description():
    # 0. Define Launch Arguments
    mu_xml_arg = DeclareLaunchArgument(
        'mu_xml',
        default_value='scene.xml',
        description='MuJoCo XML file to load (must be in panda_mujoco/franka_emika_panda/)'
    )
    mu_xml_config = LaunchConfiguration('mu_xml')

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

    # 1. MoveIt (后台规划服务)
    move_group_node = Node(
        package="moveit_ros_move_group",
        executable="move_group",
        output="screen",
        parameters=[moveit_config.to_dict(), {"use_sim_time": True}]
    )

    # 2. TF & State Publisher
    world2robot_tf_node = Node(
        package="tf2_ros", executable="static_transform_publisher", name="static_transform_publisher",
        output="log", arguments=["--frame-id", "world", "--child-frame-id", "panda_link0"],
        parameters=[{"use_sim_time": True}]
    )
    robot_state_publisher = Node(
        package="robot_state_publisher", executable="robot_state_publisher", name="robot_state_publisher",
        output="both", parameters=[moveit_config.robot_description, {"use_sim_time": True}],
    )

    # 3. Controllers Config
    ros2_controllers_path = os.path.join(
        get_package_share_directory("interactive_marker"),
        "config",
        "panda_clean_controllers.yaml",
    )

    # 4. MuJoCo Node (Using LaunchConfiguration for model path)
    model_path = PathJoinSubstitution([
        get_package_share_directory('panda_mujoco'),
        'franka_emika_panda',
        mu_xml_config
    ])

    # Important: Merge environment to avoid losing LD_LIBRARY_PATH
    node_env = os.environ.copy()
    # node_env['MUJOCO_GL'] = 'osmesa' # Reverted to let system use GPU
    node_env['ROS_DOMAIN_ID'] = '99'
    node_env['RMW_IMPLEMENTATION'] = 'rmw_cyclonedds_cpp'

    node_mujoco_ros2_control = Node(
        package='mujoco_ros2_control',
        executable='mujoco_ros2_control',
        output='screen',
        parameters=[
            moveit_config.robot_description,
            ros2_controllers_path,
            {'mujoco_model_path': model_path},
            {"use_sim_time": True}
        ],
        env=node_env
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

    # Delayed spawner to prevent race conditions during heavy scene init
    delayed_hand_spawner = TimerAction(
        period=5.0,
        actions=[panda_hand_controller_spawner]
    )

    return LaunchDescription([
        mu_xml_arg,
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
                on_exit=[delayed_hand_spawner],
            )
        ),
        
        world2robot_tf_node, 
        robot_state_publisher, 
        move_group_node, 
        node_mujoco_ros2_control
    ])