#!/bin/bash
set -e

# -- 配置 --
SOLVER="./x.exe"
INITIAL_G="house.g" # <-- 修改点 1: 使用新的初始状态文件

# <-- 修改点 2: 定义适用于 house_stacking 的新目标序列
GOALS=(
  "(poseEq base_target base)"
  "(poseEq  cyl1_target cyl1)" 
  "(poseEq  cyl2_target cyl2)" 
  "(poseEq  cyl3_target cyl3)" 
  "(poseEq  cyl4_target cyl4)" 
  "(poseEq roof_target roof)"
)

# -- 执行 --
echo "=== STARTING SEQUENTIAL SOLVING ==="

CURRENT_STATE=$INITIAL_G
i=0

for GOAL in "${GOALS[@]}"; do
  i=$((i+1))
  echo -e "\n\n>>> EXECUTING STEP ${i}/${#GOALS[@]}: ${GOAL} <<<"
  
  # 这里的调用是正确的，它会将正确的 $GOAL 传递给 x.exe
  $SOLVER "$CURRENT_STATE" "$GOAL"
  
  if [ $? -ne 0 ]; then
    echo "!!! SOLVER FAILED ON STEP ${i}. ABORTING. !!!"
    exit 1
  fi
  
  NEXT_STATE="state_step_${i}.g"
  mv output_state.g "$NEXT_STATE"
  CURRENT_STATE="$NEXT_STATE"
  
  echo ">>> STEP ${i} COMPLETED. Next state is in ${CURRENT_STATE} <<<"
done

echo -e "\n\n=== SEQUENTIAL SOLVING FINISHED SUCCESSFULLY! ==="
echo "Final state is in: ${CURRENT_STATE}"
