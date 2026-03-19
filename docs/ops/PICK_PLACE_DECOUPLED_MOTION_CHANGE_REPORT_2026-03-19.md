# Pick/Place Motion-Grasp Decoupling Change Report (2026-03-19, Corrected)

## 1. 状态说明
- 已将错误实现回退：`rai/src/KOMO/manipTools.cpp` 恢复到上一版。
- 本文档为修正版执行规范，后续代码必须严格按本规范推进。

## 2. 新边界 (不再争议)
- 不再在 KOMO 中细调 grasping 接近/脱离细节。
- `motion` 与 `grasping` 解耦：
  - 求解器只负责中段运动与中段避障。
  - 接触前后采用固定 5cm 竖直动作。

## 3. 修正版动作逻辑

### 3.1 `action_pick`
1. `time-1.0 ~ time-0.7`: 硬编码抬升 `+5cm`。
2. `time-0.7 ~ time-0.3`: 移动到目标正上方 `5cm`（`XY 对齐`，`Z=+0.05`）。
3. `time-0.3 ~ time`: 竖直下移 `5cm`。
4. 避障仅在 `time-0.7 ~ time-0.3` 开启 `OT_sos`（目标距离 `5cm`）。

修正要求:
- 不再额外添加“`time-0.3` 再锁一次正上方 5cm”的单点冗余约束。
- 不再添加中点高度锚点（例如 `time-0.15` 的高度等式）。

### 3.2 `action_place_straightOn`
1. 不做起始抬升。
2. `time-0.7 ~ time-0.3`: 运动到放置目标正上方 `5cm`（`XY 对齐`，`Z=rel_z+0.05`）。
3. `time-0.3 ~ time`: 竖直下移 `5cm` 到放置终点。
4. 避障仅在 `time-0.7 ~ time-0.3` 开启 `OT_sos`（目标距离 `5cm`）。

修正要求:
- 去掉中点高度锚点（例如 `time-0.15` 高度约束）。

## 4. 失败根因复盘 (本次错误版本)
- 失败原因不是“避障真空”本身，而是中间阶段硬约束在 waypoint 低分辨率时间片折叠后互相冲突。
- 典型冲突表现：多个不同高度目标（顶点/中点/终点）在同一 slice 上出现，导致 motif 不可行。

## 5. 代码修改清单 (下一次实现必须遵守)
- `rai/src/KOMO/manipTools.cpp`
  - `action_pick(...)`: 仅保留三段主逻辑，删除冗余 `time-0.3` 单点锁定与中点高度锚点。
  - `action_place_straightOn(...)`: 删除中点高度锚点；保留分段到顶点后下放逻辑。
  - 两函数的避障统一为中段 `time-0.7~time-0.3` 的 `OT_sos`。

## 6. 已知观察项
- place 阶段 `time-1.0~time-0.7` 目前存在潜在避障覆盖真空。
- 按当前决策先不处理该窗口；若轨迹质量不佳再补轻量软避障，不恢复硬边界栈。

## 7. 约束护栏
- 保持 `isPairAllowedByExplicitFilter` 过滤语义不变。
- 保持 waypoint/full-motion 两模式语义不变。
- 只使用相对坐标约束，不引入绝对世界坐标硬编码。
