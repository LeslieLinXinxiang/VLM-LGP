#!/bin/bash
# 自动获取当前项目根目录
export VLM_LGP_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
export RAI_PATH="$VLM_LGP_ROOT/rai"

# 路径对齐
export PYTHONPATH="$RAI_PATH/lib:$RAI_PATH/src/ry:$PYTHONPATH"
export LD_LIBRARY_PATH="$RAI_PATH/lib:$LD_LIBRARY_PATH"

# 如果使用 Conda，强制预加载系统库防止 SegFault (针对 Ubuntu 22.04)
export LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libstdc++.so.6"

echo "🌟 V-LGP Environment Loaded."
echo "📍 Root: $VLM_LGP_ROOT"