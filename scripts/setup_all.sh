#!/bin/bash
set -e

echo "🚀 [V-LGP] Initializing Clean Build Environment..."

# 1. 锁定 RAI 配置 (Config Lock) - 更新版
# 增加 ROS=0 以防止链接 ROS 1 库导致的失败
mkdir -p rai/_make
echo "🔧 Generating config.mk..."
cat <<EOF > rai/_make/config.mk
# 显式禁用物理引擎
PHYSX = 0
BULLET = 0
FCL = 0

# 显式禁用 ROS (避免 ROS1/ROS2 库冲突)
ROS = 0

# 启用核心功能
ASSIMP = 1
RAI_PYBIND = 1

# 禁用重型优化器
CERES = 0
NLOPT = 0
IPOPT = 0
EOF

# 2. 清理环境
echo "🧹 Cleaning previous builds..."
cd rai
make clean > /dev/null 2>&1 || true
cd src/ry
make clean > /dev/null 2>&1 || true
cd ../../..

# 3. 核心编译
echo "🔨 Compiling RAI Core..."
cd rai
make -j$(nproc)

# 4. 编译 Python 绑定
echo "🔗 Compiling Python Bindings..."
cd src/ry
make -j$(nproc)
cd ../../..

# 5. 链接与代理
echo "🔌 Linking Libraries..."
mkdir -p rai/lib
find rai/src -name "*.so" -exec ln -sf $(pwd)/{} $(pwd)/rai/lib/ \;
echo "from _robotic import *" > rai/lib/ry.py
echo "from _robotic import *" > rai/lib/robotic.py

# 6. 编译仿真环境 (Simulation)
if [ -d "/root/ros2_ws/src" ]; then
    echo "🤖 Compiling Simulation (MuJoCo)..."
    cd /root/ros2_ws
    # 这一步使用 rosdep 可能会因为网络失败，既然我们 Dockerfile 装全了，可以跳过它
    # rosdep install ... 
    colcon build --symlink-install
    source install/setup.bash
    cd /root/VLM_LGP
fi

echo "✅ ALL SYSTEMS GO! Environment is ready."