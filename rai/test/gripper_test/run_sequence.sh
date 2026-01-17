#!/bin/bash
set -e

# -- 配置 --
SOLVER="./x.exe" # 假设编译后的可执行文件叫 x.exe
INITIAL_G="house.g"

# ** 任务序列 (新版指令格式) **
GOALS=(
  "(grasp base)"
  "(place base on table)"
  "(grasp cyl1)"
  "(place cyl1 on base)"
  "(grasp cyl2)"
  "(place cyl2 on base)"
  "(grasp cyl3)"
  "(place cyl3 on base)"
  "(grasp cyl4)"
  "(place cyl4 on base)"
  "(grasp roof)"
  "(place roof on base)"
)

# -- 执行 --
echo "=== STARTING SEQUENTIAL SOLVING (Hybrid Gripper Test) ==="

CURRENT_STATE=$INITIAL_G
i=0

for GOAL in "${GOALS[@]}"; do
  i=$((i+1))
  echo -e "\n\n>>> EXECUTING STEP ${i}/${#GOALS[@]}: ${GOAL} <<<"
  
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
