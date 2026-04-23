#!/bin/bash
# Sync specific scenes to Docker for different tasks

CONTAINER="vlm_sim"
# Source directory for long-term development
SRC_DIR="/root/ros2_ws/src/mujoco_ros2_control_examples/panda_resources/panda_mujoco/franka_emika_panda"
# Install directory for live execution
INSTALL_DIR="/root/ros2_ws/install/panda_mujoco/share/panda_mujoco/franka_emika_panda"

echo ">>> Syncing scenes to Docker: $CONTAINER"

# 1. Sync to Source and Install Spaces (XML)
XML_FILES=("scene.xml" "scene_block.xml" "scene_planar.xml" "panda.xml")

for xml in "${XML_FILES[@]}"; do
    docker cp simulation/mujoco_ros2_control_examples/panda_resources/panda_mujoco/franka_emika_panda/$xml $CONTAINER:$SRC_DIR/
    docker cp simulation/mujoco_ros2_control_examples/panda_resources/panda_mujoco/franka_emika_panda/$xml $CONTAINER:$INSTALL_DIR/
done

# 2. Sync Controller Config
CONTROLLER_SRC="/root/ros2_ws/src/mujoco_ros2_control_examples/interactive_marker/config"
CONTROLLER_INSTALL="/root/ros2_ws/install/interactive_marker/share/interactive_marker/config"

docker cp simulation/mujoco_ros2_control_examples/interactive_marker/config/panda_clean_controllers.yaml $CONTAINER:$CONTROLLER_SRC/
docker cp simulation/mujoco_ros2_control_examples/interactive_marker/config/panda_clean_controllers.yaml $CONTAINER:$CONTROLLER_INSTALL/

# 3. Sync modified launch file
LAUNCH_SRC="/root/ros2_ws/src/mujoco_ros2_control_examples/interactive_marker/launch"
LAUNCH_INSTALL="/root/ros2_ws/install/interactive_marker/share/interactive_marker/launch"

docker cp simulation/mujoco_ros2_control_examples/interactive_marker/launch/interactive_marker.launch.py $CONTAINER:$LAUNCH_SRC/
docker cp simulation/mujoco_ros2_control_examples/interactive_marker/launch/interactive_marker.launch.py $CONTAINER:$LAUNCH_INSTALL/

echo "✅ Sync Complete."
echo ""
echo "Step 1: Open Docker terminal and launch MuJoCo simulation:"
echo "--------------------------------------------------------"
echo "To run BLOCK task (积木):"
echo "  ros2 launch interactive_marker interactive_marker.launch.py mu_xml:=scene_block.xml"
echo ""
echo "To run PLANAR task (FMB):"
echo "  ros2 launch interactive_marker interactive_marker.launch.py mu_xml:=scene_planar.xml"
echo "--------------------------------------------------------"
echo ""
echo "Step 2: On Host machine, run the trajectory picker:"
echo "  ./.venv/bin/python3 test/run_mujoco_trajectory.py"
