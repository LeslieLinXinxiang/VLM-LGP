#!/bin/bash
set -e  # 遇到错误立即停止

echo "========================================"
echo "🤖 V-LGP Docker Setup: Initializing..."
echo "========================================"

# 1. 确保加载 ROS 2 Humble 环境
if [ -f /opt/ros/humble/setup.bash ]; then
    source /opt/ros/humble/setup.bash
    echo "✅ ROS 2 Humble sourced."
else
    echo "❌ Error: ROS 2 Humble not found!"
    exit 1
fi

# 2. 进入工作空间
cd /root/ros2_ws
echo "📂 Workdir: $(pwd)"

# 3. 安装依赖 (rosdep)
echo "📦 Installing dependencies via rosdep..."
if [ ! -d "/etc/ros/rosdep/sources.list.d" ]; then
    rosdep init
fi
rosdep update
rosdep install --from-paths src --ignore-src -r -y

# 4. 编译 (colcon)
echo "🔨 Compiling simulation packages..."
colcon build --symlink-install

echo "========================================"
echo "✅ SETUP COMPLETE!"
echo "👉 Now run this command to start:"
echo "   source install/setup.bash"
echo "========================================"