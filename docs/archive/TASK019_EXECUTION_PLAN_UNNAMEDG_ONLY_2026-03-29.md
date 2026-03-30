# TASK-019 执行方案（unnamed.g 单输入版，2026-03-29）

## 1. 目标

在不改动主流程外部契约的前提下，实现一个最小可执行链路：

1. 输入只有 [unnamed.g](../../unnamed.g)；
2. 输出每个对象的融合可达性连续值 `reachability_score`（GMM+ESDF）；
3. 保持 [generated/infeasible_objects.json](../../generated/infeasible_objects.json) 兼容。

---

## 2. 核心定义（本轮锁定）

1. `GMM` 先验来源：基于当前 scene 直接构建。
2. 抓取采样点：
   - 有 `handle` marker -> 用 marker；
   - 无 marker -> 用对象中心。
3. 输出主值：

$$
R(x)=\alpha P_{\mathrm{GMM}}(x)+\beta S_{\mathrm{ESDF}}(x)
$$

其中 `x` 为对象抓取采样点。

---

## 3. 输入与输出

## 3.1 输入（唯一）

1. [unnamed.g](../../unnamed.g)

## 3.2 输出（最小集合）

1. 连续分数输出（新增）：
   - [generated/reachability_score_report.json](../../generated/reachability_score_report.json)
2. 兼容输出（保留）：
   - [generated/infeasible_objects.json](../../generated/infeasible_objects.json)

建议最小 schema（输出 1）：

```json
{
  "version": "v1",
  "scene_input": "unnamed.g",
  "params": {
    "alpha": 0.6,
    "beta": 0.4,
    "tau_r": 0.45,
    "seed": 42
  },
  "objects": [
    {
      "logical_id": "rect_1",
      "sample_point_source": "handle|center",
      "sample_point_xyz": [0.30, -0.10, 0.065],
      "gmm_score": 0.51,
      "esdf_score": 0.62,
      "reachability_score": 0.554,
      "decision": "feasible"
    }
  ]
}
```

---

## 4. 执行步骤（实现步骤，不是运行记录）

1. 从 [unnamed.g](../../unnamed.g) 解析对象、位姿、逻辑标签。
2. 构建抓取采样点（handle 优先，否则中心）。
3. 构建 GMM scene prior 并计算 `P_GMM(x)`。
4. 构建 ESDF 障碍距离并计算 `S_ESDF(x)`。
5. 按权重融合得到 `reachability_score`。
6. 用 `tau_r` 生成 `decision`，并写入 [generated/infeasible_objects.json](../../generated/infeasible_objects.json) 的兼容结构。
7. 写入 [generated/reachability_score_report.json](../../generated/reachability_score_report.json)。

---

## 5. 障碍集合（ESDF）最小规则

1. 支持命名约定：名字匹配 `collision_*` 直接纳入障碍。
2. 名字包含 `obstacle` 或 `obs_*` 直接纳入障碍。
3. `is_place` 不单独作为障碍判据（仅辅助）。
4. 机器人本体暂不纳入 MVP ESDF。
5. `table` 默认不纳入 ESDF 障碍（避免把支撑平面误判为夹取障碍）。

障碍样例参考：

- [test/scenes/scene_named_with_obstacle_infeasible.g](../../test/scenes/scene_named_with_obstacle_infeasible.g#L69)

---

## 6. 与 KOMO 的关系（本轮策略）

1. 本执行方案不是替代 KOMO，而是前置可达性评分。
2. 若策略要求“必须垂直抓取”，采样点和姿态候选应按该策略生成，得到“策略条件下可达性”。
3. 后续可加二阶段：`reachability_score` 预筛后，再由 KOMO 严格验证边界样本。

---

## 7. 可视化建议（用于调参）

1. 俯视 2D 热力图（table plane）；
2. 对象抓取点散点叠加（颜色=score）；
3. 每对象柱状图（`gmm/esdf/fused` 三列）。

---

## 8. 验收条件（最小）

1. 单输入约束满足：仅使用 [unnamed.g](../../unnamed.g)。
2. 每个对象都有 `reachability_score`。
3. `decision` 与阈值关系一致。
4. [generated/infeasible_objects.json](../../generated/infeasible_objects.json) 兼容不破坏。

