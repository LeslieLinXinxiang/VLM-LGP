#!/bin/bash
set -e # 遇到错误立即停止

# 定义编译函数 (增加了 clean 步骤)
build_module() {
    echo -e "\n>>> [Building Module]: $1"
    cd ~/Projects/VLM_LGP/rai/src/$1
    # 强制清理旧的目标文件，确保重新编译并复制到 lib/
    make clean 
    make -j$(nproc)
}

# 1. 基础清理
echo ">>> Cleaning Central Library Directory..."
cd ~/Projects/VLM_LGP/rai
rm -rf lib/*

# 2. 按依赖顺序构建 (Topology Order)
# 基础数学与核心
build_module Core
build_module Algo
build_module Optim   
build_module Geo     

# 可视化与物理
build_module Gui     
build_module Kin     

# 高级规划算法
build_module Search
build_module PathAlgos
build_module KOMO    
build_module LGP     

# Python 绑定 (终点)
build_module ry      

echo -e "\n>>> ✅ BUILD SUCCESS: All modules compiled and linked."
