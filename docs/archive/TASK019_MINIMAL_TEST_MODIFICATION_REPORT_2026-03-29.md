# TASK-019 最小化测试修改报告（2026-03-29）

## 1. 目标

在**不执行任何代码**的前提下，给出 TASK-019（GMM + ESDF 可微可达性热力图）的最小化测试方案与最小改动设计，复用主程序场景输入，保证对现有 Phase0/下游契约零破坏。

---

## 2. 现状文档清晰度审查

## 2.1 已经清晰且可直接落地的部分

1. 任务目标清晰：由逐对象二值 reachability 改为连续分数字段 + 阈值判定。出处：
   - [docs/roadmap.md](../roadmap.md#L21-L26)
   - [docs/ops/METHOD_UPGRADE_TASKBOOK_2026-03-25.md](METHOD_UPGRADE_TASKBOOK_2026-03-25.md#L133-L153)

2. 任务边界清晰：TASK-019 负责 feasible/infeasible 判定，TASK-018 仅消费 feasible 集排序。出处：
   - [docs/roadmap.md](../roadmap.md#L24)
   - [docs/ops/METHOD_UPGRADE_TASKBOOK_2026-03-25.md](METHOD_UPGRADE_TASKBOOK_2026-03-25.md#L205-L230)

3. 向后兼容要求清晰：必须继续产出并兼容 `generated/infeasible_objects.json`。出处：
   - [docs/roadmap.md](../roadmap.md#L26)
   - [docs/ops/METHOD_UPGRADE_TASKBOOK_2026-03-25.md](METHOD_UPGRADE_TASKBOOK_2026-03-25.md#L177-L194)

## 2.2 目前仍不够清晰（需要在本次最小化方案中补齐）的部分

1. **GMM 输入来源已锁定**：基于当前 scene 直接构建先验（不依赖历史数据集）。
2. **ESDF 源定义需补齐**：障碍物集合定义规则（命名/逻辑标签/接触属性）仍需明确。
3. **对象判定采样点已锁定**：采样点 = 抓取点；若对象有 marker 则用 marker，否则用对象中心。
4. **阈值术语需澄清**：
   - 固定全局阈值：所有对象统一一个 `tau_r`。
   - 分类型阈值：按 object_type 使用不同 `tau_r(type)`。
   - 本次最小化测试先采用固定全局阈值。
5. **输出 schema 暂不冻结**：先优先跑通最小测试，再固化最终 sidecar schema。

---

## 3. 与当前代码状态的差异定位（基线）

当前实现是“逐对象调用可执行程序 + 二值判定”：

1. 逐对象循环在 `split_infeasible_objects_from_reachability(...)` 内完成。出处：
   - [core/phase0_parser.py](../../core/phase0_parser.py#L196-L271)

2. 每个对象通过 `test/reachability/run_pick_waypoint_check.py` 调用 `bin/pick_waypoint_check.exe`。出处：
   - [core/phase0_parser.py](../../core/phase0_parser.py#L201-L203)
   - [test/reachability/run_pick_waypoint_check.py](../../test/reachability/run_pick_waypoint_check.py#L34-L62)

3. Phase0 编排点固定在 `execute_phase0()` 的 Step 3。出处：
   - [pipeline/run_phase0.py](../../pipeline/run_phase0.py#L163-L169)

4. 主场景原始输入可直接复用 `unnamed.g`。出处：
   - [unnamed.g](../../unnamed.g#L1-L120)

---

## 4. 最小化改动策略（仅设计，不执行）

## 4.1 改动原则

1. 默认路径不变：保持 legacy checker 仍可用。
2. 新能力增量式接入：通过 mode/config 切换到 TASK-019 MVP。
3. 输出契约不变：`generated/infeasible_objects.json` 保持现有结构可消费。
4. 新增 sidecar：增加连续分数与热力图报告，不影响现有调用方。

## 4.2 建议改动文件与函数

1. **新增** [core/reachability_field.py](../../core/reachability_field.py)
   - 新函数 `compute_reachability_heatmap_mvp(...)`
   - 职责：从场景对象与障碍构建简化 GMM+ESDF 分数，并输出对象级连续分数与网格统计。

2. **新增** [core/reachability_threshold.py](../../core/reachability_threshold.py)
   - 新函数 `threshold_reachability_scores(...)`
   - 职责：统一阈值判定，输出 `feasible/infeasible/unknown`（unknown 在 v1 可折叠为 infeasible 或单独 reason 标注）。

3. **修改** [core/phase0_parser.py](../../core/phase0_parser.py)
   - 保留现有 `split_infeasible_objects_from_reachability(...)`；
   - 新增 `split_infeasible_objects_from_reachability_field(...)`（或在原函数内加 mode 分支）。

4. **修改** [pipeline/run_phase0.py](../../pipeline/run_phase0.py)
   - 在 `execute_phase0()` 增加参数（建议）`reachability_mode="legacy_checker|gmm_esdf_mvp"`；
   - 在 Step 3 依据 mode 选择 legacy 或 field 路径；
   - 新增 heatmap sidecar 落盘路径（建议）`generated/reachability_heatmap.json`。

5. **新增测试脚本** [test/reachability/run_reachability_field_minimal_test.py](../../test/reachability/run_reachability_field_minimal_test.py)
   - 参考 manipulability 冒烟脚本结构。参考：
     - [test/manipulability/run_static_manipulability_test.py](../../test/manipulability/run_static_manipulability_test.py)

6. **新增测试计划文档** [docs/ops/TASK019_MINIMAL_TEST_PLAN_2026-03-29.md](TASK019_MINIMAL_TEST_PLAN_2026-03-29.md)
   - 结构沿用 manipulability 测试文档风格。参考：
     - [docs/ops/MANIPULABILITY_UNIT_TEST_PLAN_2026-03-26.md](MANIPULABILITY_UNIT_TEST_PLAN_2026-03-26.md)

---

## 5. 最小化测试 I/O 设计（详细）

## 5.1 输入（固定复用主场景）

1. 场景原始输入：
   - [unnamed.g](../../unnamed.g)

2. 约定：最小化执行方案对外只接受一个输入文件 `unnamed.g`。

3. 运行期派生数据（非用户输入）：
   - `phase0_layout` 可由 `unnamed.g` 解析得到；
   - `scene_named.g` 仅作为流程中间产物，不作为外部输入参数。

4. 配置参数（建议）
   - `alpha`：GMM 权重（默认 0.6）
   - `beta`：ESDF 权重（默认 0.4）
   - `tau_r`：reachability 阈值（默认 0.45）
   - `grid_resolution`：热力图网格分辨率（默认 0.02 m）
   - `seed`：确定性随机种子（默认 42）

5. 抓取点评估规则（本次锁定）
   - 若对象存在抓取 marker（命名包含 `handle`），采样点使用 marker；
   - 若不存在 marker，采样点退化为对象中心。
   - 参考：
     - [docs/ops/TESTING_SOP_2026-03-21.md](TESTING_SOP_2026-03-21.md#L41)

## 5.2 输出（新增 + 兼容）

1. **兼容输出（必须保留）**
   - [generated/infeasible_objects.json](../../generated/infeasible_objects.json)

2. **新增 sidecar（连续信息）**
   - [generated/reachability_heatmap.json](../../generated/reachability_heatmap.json)

建议 schema（v1）：

```json
{
  "version": "v1",
  "method": "gmm_esdf_mvp",
  "scene": "unnamed.g",
  "params": {
    "alpha": 0.6,
    "beta": 0.4,
    "tau_r": 0.45,
    "grid_resolution": 0.02,
    "seed": 42
  },
  "grid_meta": {
    "x_min": -0.6,
    "x_max": 0.6,
    "y_min": -0.4,
    "y_max": 0.4,
    "z_eval": 0.065,
    "nx": 61,
    "ny": 41
  },
  "stats": {
    "score_min": 0.0,
    "score_max": 1.0,
    "score_mean": 0.42
  },
  "objects": [
    {
      "logical_id": "rect_1",
      "sample_point_xyz": [0.30, -0.10, 0.065],
      "gmm_score": 0.51,
      "esdf_score": 0.62,
      "reachability_score": 0.554,
      "threshold": 0.45,
      "decision": "feasible",
      "reason": "score>=tau_r"
    }
  ]
}
```

1. **可选新增 sidecar（对象判定摘要）**
   - [generated/reachability_score_report.json](../../generated/reachability_score_report.json)

---

## 6. 最小化测试方案（不执行版）

## 6.1 测试范围

仅验证 TASK-019 最小闭环：

1. 能从主场景输入生成对象级连续分数；
2. 能由统一阈值生成二值可达判定；
3. 能保持 `infeasible_objects.json` 兼容；
4. 能产出可审计 sidecar。

不覆盖：

1. 实时 ESDF 更新；
2. 动态障碍；
3. 与 TASK-018 融合排序；
4. 大规模 benchmark 性能。

## 6.2 测试用例（最小集合）

### Case A: Schema 兼容性

- 输入：主场景与现有 Phase0 布局。
- 断言：`generated/infeasible_objects.json` 顶层字段保持 `status/scene_path/infeasible_objects/errors`。
- 参考现状：
  - [generated/infeasible_objects.json](../../generated/infeasible_objects.json)

### Case B: 连续分数存在性

- 断言：每个对象都有 `gmm_score`、`esdf_score`、`reachability_score`，且为有限数。

### Case C: 阈值判定一致性

- 断言：`decision == feasible` 当且仅当 `reachability_score >= tau_r`。

### Case D: 确定性

- 固定 seed 两次执行（计划层面），对象 `decision` 与 `reachability_score` 一致（允许严格相等或浮点容忍误差）。

### Case E: 审计性

- 断言：sidecar 包含 `params`、`grid_meta`、`stats`、对象级 `reason`。

---

## 7. 与 manipulability 测试方案的对齐点

1. 文档结构对齐：Scope / Targets / Required Files / Cases / Smoke Entry / DoD。
   - 参考：[docs/ops/MANIPULABILITY_UNIT_TEST_PLAN_2026-03-26.md](MANIPULABILITY_UNIT_TEST_PLAN_2026-03-26.md)

2. 脚本形态对齐：`run_*_test.py` 读取已有 `generated/*`，输出 sidecar 到 `generated/`。
   - 参考：[test/manipulability/run_static_manipulability_test.py](../../test/manipulability/run_static_manipulability_test.py)

3. 契约策略对齐：主流程输出不破坏，新增 sidecar 提升可审计性。
   - 参考：[docs/ops/MANIPULABILITY_MVP_REQUIREMENTS_2026-03-25.md](MANIPULABILITY_MVP_REQUIREMENTS_2026-03-25.md#L99-L157)

---

## 8. 风险与前置约束

1. 路径归一化风险：主场景内 `Include` 与 mesh 可能是历史绝对路径，需依赖 `_normalize_scene_include(...)` 逻辑。
   - 参考：[pipeline/run_phase0.py](../../pipeline/run_phase0.py#L32-L47)

2. 文档一致性风险：架构/数据流文档仍含 Phase0 VLM 叙述，与当前规则化 Phase0 实现有偏差，可能影响 TASK-019 实施理解。
   - [docs/architecture.md](../architecture.md#L20-L33)
   - [docs/dataflow.md](../dataflow.md#L1-L24)
   - [pipeline/run_phase0.py](../../pipeline/run_phase0.py#L147-L186)

3. 运行环境约束：后续真正执行测试前，必须遵守 `vlm_jazzy + source scripts/env.sh`。
   - [docs/execution_protocol.md](../execution_protocol.md#L29-L52)

4. ESDF 障碍集合歧义风险：当前 `.g` 中 `is_place` 同时用于可放置 patch 与部分障碍占位，不能仅靠该标签判定“不可夹取障碍”。
   - 例：障碍样例使用 `logical:{ is_place }`：
     - [test/scenes/scene_named_with_obstacle_infeasible.g](../../test/scenes/scene_named_with_obstacle_infeasible.g#L69)
   - 因此建议在 TASK-019 MVP 中增加显式障碍判定规则（见第 11 节）。

---

## 9. 建议的“最小改动清单”（供下一步实施）

1. 新增 `core/reachability_field.py`。
2. 新增 `core/reachability_threshold.py`。
3. 在 [core/phase0_parser.py](../../core/phase0_parser.py) 增加 field 路径函数（保留 legacy）。
4. 在 [pipeline/run_phase0.py](../../pipeline/run_phase0.py) 增加 `reachability_mode` 与 heatmap 输出路径。
5. 新增 [test/reachability/run_reachability_field_minimal_test.py](../../test/reachability/run_reachability_field_minimal_test.py)（仅冒烟）。
6. 新增 [docs/ops/TASK019_MINIMAL_TEST_PLAN_2026-03-29.md](TASK019_MINIMAL_TEST_PLAN_2026-03-29.md)。

---

## 10. Definition of Done（最小化测试方案文档版）

1. TASK-019 的 I/O、阈值判定、sidecar schema、兼容契约已文档化；
2. 改动点已缩到最小且可回滚（legacy path 保留）；
3. 测试用例覆盖“连续分数 + 二值判定 + 兼容输出 + 审计字段”；
4. 所有条目均有仓内出处链接，便于 RFC/代码实施前评审。

---

## 11. 用户补充问题的技术结论（用于实施前统一口径）

### 11.1 ESDF 源到底是什么（MVP 可执行定义）

ESDF 源 = “用于计算距离场的障碍集合 + 网格化参数 + 评分映射”。

建议 MVP 规则（先跑通）：

1. 障碍集合包含：
   - 静态环境实体（table、显式障碍块）；
   - 非当前目标对象的其它物体（可选，作为保守项）；
2. 默认不把机器人本体纳入 ESDF（先保持简单和稳定）；
3. `.g` 中若后续采用 `collision_*` 命名，直接并入障碍集合；
4. `is_place` 不作为障碍唯一判据，只作为辅助信息。

### 11.2 GMM+ESDF 判定是否需要 KOMO 约束、3D 碰撞、仿真

最小化测试阶段建议：

1. **不强依赖 KOMO 约束**：GMM+ESDF 先作为快速可达性先验评分器；
2. **不要求完整 3D 连续碰撞优化**：用简化几何距离场即可完成 MVP 判定；
3. **不需要仿真**：允许纯离线/本地计算，符合 TASK-019 既定边界。
   - [docs/roadmap.md](../roadmap.md#L26)
   - [docs/ops/METHOD_UPGRADE_TASKBOOK_2026-03-25.md](METHOD_UPGRADE_TASKBOOK_2026-03-25.md#L221-L229)

KOMO 可作为后续“校准层”而非 MVP 必需层：对边界样本做复检，不应阻塞最小化测试跑通。

### 11.3 GMM 与 ESDF 的基本原理（工程解释）

1. GMM 项（可达性先验）：
   - 对抓取点附近“可达样本分布”建模，给出平滑先验分数 `P_GMM(x)`。
2. ESDF 项（障碍清空间隔）：
   - 用点到最近障碍的签名距离构建 `S_ESDF(x)`，距离越大越安全。
3. 融合判定：

$$
R(x)=\alpha P_{\mathrm{GMM}}(x)+\beta S_{\mathrm{ESDF}}(x),\quad
   ext{reachable}(x)=\mathbb{1}[R(x)\ge\tau_r]
$$

其中 `x` 为抓取采样点（marker 或中心）。

### 11.4 为什么要“可导”，不用 0/1 行不行

0/1 判定能工作，但存在问题：

1. 无法表达“接近可达/接近不可达”的边界信息；
2. 对阈值和噪声敏感，排序与调参不稳定；
3. 难以与后续优化或学习模块做梯度友好耦合。

可导连续分数的收益：

1. 边界样本可比较（连续置信度）；
2. 可做阈值扫描/标定；
3. 可作为后续优化 cost 的平滑项。

---

## 12. 下一步执行优先级（先跑通，再细化）

1. 固定本轮 MVP 口径：scene-prior GMM + 简化 ESDF + 全局阈值；
2. 完成最小脚本与最小冒烟测试；
3. 验证兼容输出 `generated/infeasible_objects.json` 不破坏；
4. 测试跑通后再冻结最终 sidecar schema 和障碍标签规范。
