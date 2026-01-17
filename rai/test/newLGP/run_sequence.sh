#!/bin/bash
set -e

# -- 配置 --
# 编译后的 C++ 工具名称
SOLVER="./x.exe"
# 初始场景文件
INITIAL_G="lgp_bimanual_pnp.g"
# 按顺序定义所有子目标
GOALS=(
  "(on trayG objG)"
  "(on trayB objB)"
  "(on trayR objR)"
)

# -- 执行 --
echo "=== STARTING SEQUENTIAL SOLVING ==="

# 初始化当前状态文件
CURRENT_STATE=$INITIAL_G
i=0

for GOAL in "${GOALS[@]}"; do
  i=$((i+1))
  echo -e "\n\n>>> EXECUTING STEP ${i}/${#GOALS[@]}: ${GOAL} <<<"
  
  # 调用 C++ 工具进行单步求解
  $SOLVER "$CURRENT_STATE" "$GOAL"
  
  # 检查求解器是否成功
  if [ $? -ne 0 ]; then
    echo "!!! SOLVER FAILED ON STEP ${i}. ABORTING. !!!"
    exit 1
  fi
  
  # 手动建立衔接关系
  NEXT_STATE="state_step_${i}.g"
  mv output_state.g "$NEXT_STATE"
  CURRENT_STATE="$NEXT_STATE"
  
  echo ">>> STEP ${i} COMPLETED. Next state is in ${CURRENT_STATE} <<<"
done

echo -e "\n\n=== SEQUENTIAL SOLVING FINISHED SUCCESSFULLY! ==="
echo "Final state is in: ${CURRENT_STATE}"
