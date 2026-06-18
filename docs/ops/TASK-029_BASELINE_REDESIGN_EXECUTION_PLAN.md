# [TASK-029] Baseline 对照组重设计执行报告

**文档类型**: ops 执行方案 (Layer 3 补充)
**创建时间**: 2026-04-27 18:28
**最后修订**: 2026-04-27 20:47
**状态**: `[In Progress]`
**关联任务**: TASK-028（正式实验设计与执行）
**归档路径**: `docs/ops/TASK-029_BASELINE_REDESIGN_EXECUTION_PLAN.md`

---

## 1. 背景与问题陈述

### 1.1 现有 Baseline 的根本性缺陷

当前对照组实验存在以下两个根本性问题：

1. **评价维度不足**：仅比较最终拓扑结构，未引入 Manipulability（可操作性）约束，导致正确率虚高（96-100%），无法与实验组拉开差距。
2. **视觉作弊漏洞**：若将场景文件直接输入给 VLM，VLM 通过读取物体列表即可知道"任务范围只有这几个物体"，视觉理解能力被完全短路，无法考察真实的视觉推理能力。

### 1.2 关于 Reachability

Reachability 不适合作为"对或错"的二值评判指标，**本实验中不纳入比较维度**。

### 1.3 关于 Manipulability

Manipulability 不是"对或错"，而是**动作执行质量（Motion Quality）的连续评分指标**，用于评估 VLM 输出的执行顺序与物理最优顺序的吻合程度。

---

## 2. 最终确定的实验设计方案

### 2.1 核心设计决策

| 决策点 | 结论 | 原因 |
| :--- | :--- | :--- |
| Prompt 数量 | **两个** | 单 Prompt 会导致视觉作弊；两个 Prompt 使感知和规划失败可独立归因 |
| Prompt 顺序 | **先动作序列，再 Manipulability 注入** | 防止 VLM 在规划阶段提前看到场景文件物体列表，必须先由图片独立推理 |
| Prompt 1 输入 | **仅图片** | 核心防作弊设计——VLM 只能靠视觉推断任务，无法从文本作弊 |
| Prompt 2 输入 | **Prompt 1 输出 + 完整场景文件** | 在已生成动作序列的基础上，用场景文件做 Visual Grounding 和 Manipulability 注入 |
| 输出格式 | **PDDL 动作序列** | 参考《Guiding Long-Horizon Task and Motion Planning with VLMs》，可形式化评估 |
| GT 来源 | **现有 Manipulability 模块批量预计算** | 客观、可重复、与 VLM 输出无关 |

### 2.2 完整 Pipeline

```
输入层:
  experiments/inputs/cubeStacking/{N}cubes/*.png   (场景图片)
  experiments/scenes/{N}cubes/{sXX}/trial_{XX}.g   (场景文件)

─────────────────────────────────────────────────────
Prompt 1: 纯视觉规划
─────────────────────────────────────────────────────
  输入: [场景图片 ONLY]
  任务: 识别图中所有物体，分析堆叠结构，输出操作序列
        物体用视觉描述表示（颜色、形状、位置等）
  输出格式 (JSON):
  {
    "visual_plan": [
      {"step": 1, "action": "pick",
       "object_desc": "red cube on the far left",
       "target_desc": "place on table center"},
      ...
    ]
  }

─────────────────────────────────────────────────────
Prompt 2: Visual Grounding + Manipulability 注入
─────────────────────────────────────────────────────
  输入: [Prompt 1 的 JSON 输出] + [完整场景文件 .g]
  任务:
    ① 将 Prompt 1 中每个物体的视觉描述对应到场景文件中的 obj_id
    ② 基于场景文件的坐标/姿态信息，对每个涉及的物体评估 Manipulability
    ③ 按 Manipulability 从高到低重排执行顺序
    ④ 输出最终 PDDL 格式动作序列
  输出格式 (PDDL):
  (:action-sequence
    (pick obj_03)    ; step 1 - highest manipulability
    (place obj_03 table_center)
    (pick obj_01)    ; step 2
    (place obj_01 on obj_03)
    ...
  )

─────────────────────────────────────────────────────
评分模块 (Automated Scorer)
─────────────────────────────────────────────────────
  Layer 1: 拓扑正确率  - 最终搭建结构与目标一致? (binary)
  Layer 2: 序列合法性  - 有无物理违规（先拿被压物体等）? (binary)
  Layer 3: Manipulability 质量 - 执行顺序 vs GT 排序 (Kendall's τ)
```

### 2.3 R 场景（有冗余物体）的特殊处理

R 场景中存在冗余物体。Prompt 1 在仅看图片时，可能会将冗余物体纳入动作序列。
- **这是合理的测试点**：VLM 是否能从视觉上区分"目标物体"和"冗余物体"，本身就是考察点之一。
- **评分规则**：如果 PDDL 序列中出现了不属于目标任务的冗余物体，在 Layer 1 拓扑评分中记为错误。

---

## 3. Ground Truth 生成（独立于 VLM，先跑）

### 3.1 Manipulability GT

**执行脚本**: `experiments/scripts/generate_manipulability_gt.py`

**输入**: 所有场景文件 `experiments/scenes/{N}cubes/{sXX}/trial_{XX}_{mode}.g`

**输出** (`experiments/evaluations/ground_truth/{N}cubes/{sXX}/trial_{XX}_{mode}_gt.json`):
```json
{
  "scene": "4cubes/s01/trial_01_nr",
  "manipulability_ranking": [
    {"obj_id": "obj_03", "rank": 1, "score": 0.87},
    {"obj_id": "obj_01", "rank": 2, "score": 0.72},
    {"obj_id": "obj_02", "rank": 3, "score": 0.55}
  ]
}
```

**执行策略**: 先批量生成全部 GT 数据，存档后再进行 VLM 实验，两者独立不干扰。

---

## 4. 评分框架详细定义

### Layer 1 - 拓扑正确率 (Topology Accuracy)
- **评分对象**: 最终 PDDL 序列执行后的结构与目标结构是否一致
- **评分方式**: 二值（Pass / Fail）

### Layer 2 - 序列合法性 (Sequence Validity)
- **评分对象**: PDDL 序列中是否存在物理上不可执行的顺序
  - 违规案例: 先操作被其他物体压住的物体
  - 违规案例: 使用了场景中不存在的 obj_id
- **评分方式**: 二值（Pass / Fail），任何违规即整体 Fail

### Layer 3 - Manipulability 顺序质量 (Kendall's τ)
- **评分对象**: 仅对 Layer 1 + Layer 2 均通过的样本计算
- **评分方式**:
  ```python
  from scipy.stats import kendalltau
  # vlm_order: VLM 输出的执行顺序中物体出现的排列
  # gt_order: Manipulability 模块输出的最优顺序
  tau, _ = kendalltau(vlm_order, gt_order)
  # τ ∈ [-1, 1]: 1=完全一致, 0=随机, -1=完全反序
  ```
- **注意**: τ 是连续质量分数，不是对错判定，体现了 VLM 对 Manipulability 的推理质量

---

## 5. 文件树（新增文件）

```
experiments/
├── evaluations/
│   └── ground_truth/                          [NEW] Manipulability GT
│       └── {N}cubes/{sXX}/trial_{XX}_{mode}_gt.json
├── scripts/
│   ├── generate_manipulability_gt.py          [NEW] 批量生成 GT
│   ├── run_baseline_two_stage.py              [NEW] 批量执行两阶段 Baseline
│   └── evaluate_baseline_rm.py               [NEW] 三层评分脚本
├── prompts/
│   ├── baseline_visual_planner.md             [NEW] Prompt 1: 纯视觉规划
│   └── baseline_grounding_manip.md            [NEW] Prompt 2: Grounding + Manipulability 注入
└── outputs/
    └── baseline_rm_v2/                        [NEW] 新版 Baseline 输出
        └── {N}cubes/{sXX}/
            ├── trial_{XX}_{mode}_p1.json      (Prompt 1 输出)
            ├── trial_{XX}_{mode}_p2.pddl      (Prompt 2 最终 PDDL)
            └── trial_{XX}_{mode}_score.json   (三层评分结果)
```

---

## 6. 执行优先级

| 优先级 | 任务 | 说明 |
| :--- | :--- | :--- |
| **P0** | 确认 Manipulability 模块批量接口 | 确认能否对 `.g` 文件批量调用，输出 obj 排序 |
| **P0** | 编写 `generate_manipulability_gt.py` | 批量生成全部场景的 GT JSON，先存档 |
| **P0** | 设计并冻结 Prompt 1 模板 | 仅图片输入，输出含视觉描述的 JSON 动作序列 |
| **P1** | 设计并冻结 Prompt 2 模板 | 输入 P1 结果 + 场景文件，输出 PDDL |
| **P1** | 人工验证 1 个完整场景的端到端流程 | GT 生成 → P1 → P2 → 评分，验证链路通畅 |
| **P2** | 批量执行全部场景（4-8cubes × 5场景 × NR/R × 10次） | 共 500 次 VLM 调用 |
| **P2** | 生成汇总报告与可视化 | 更新论文对照组数据 |

---

## 7. 风险与缓解

| 风险 | 缓解措施 |
| :--- | :--- |
| Prompt 1 视觉描述不精确，导致 Prompt 2 Grounding 失败 | 在 Prompt 1 输出格式中强制要求描述颜色、形状、相对位置三个维度 |
| VLM 在 Prompt 2 中仍然无法准确匹配 obj_id | 记录 Grounding 失败率，作为额外的分析维度纳入论文 |
| PDDL 输出格式不稳定 | 添加输出格式校验和自动重试逻辑 |
| Manipulability 模块不支持批量调用 | 检查模块接口后，必要时封装为批量脚本 |


---

## 1. 背景与问题陈述

### 1.1 现有 Baseline 的根本性缺陷

当前 `experiments/evaluations/VLM/pure_llm_baseline` 中的对照组实验设计存在以下根本性问题：

1. **评价维度不足**：仅比较最终拓扑结构（物体搭没搭对），**未引入 Manipulability（可操作性）和 Reachability（可达性）的约束**，而这恰恰是实验组（VLM + LGP）最核心的创新点。
2. **公平性问题**：当前 Baseline 的评判标准与实验组不等价，导致两组数据无法进行有效横向对比。
3. **无客观 Ground Truth**：之前缺乏一个与 VLM 输出无关的客观评分标准，导致准确率依赖于"10次实验中第一次是否是正确答案"这种弱假设。

### 1.2 设计目标

重新设计后的对照组需满足：
- **信息对等**：与实验组接收完全相同的输入信息。
- **有客观 Ground Truth**：利用现有 Manipulability / Reachability 模块生成可验证的标准答案。
- **分层评估**：能区分"是感知阶段的错误"还是"规划阶段的错误"。

---

## 2. 核心实验设计方案（已获批）

### 2.1 总体架构：两阶段 VLM Pipeline

```
输入: [场景图片 (Test Image)] + [完整场景文件 (.g file)]
         │                              │
         └──────────────┬───────────────┘
                        ▼
         ┌──────── Prompt 1: 感知 & 排序 ────────┐
         │  输入: 场景文件 + 图片               │
         │  任务: 判断每个物体的               │
         │    1. Manipulability 分数/排序       │
         │    2. Reachability (是否可达)         │
         │  输出: 结构化 JSON                   │
         │  {obj_id: {manip_rank: N,           │
         │            reachable: true/false}}  │
         └──────────────────────────────────────┘
                        │
                        ▼
         ┌──────── Prompt 2: 规划 ────────────────┐
         │  输入: Prompt 1 的 JSON 输出            │
         │       + 原始场景文件 + 图片             │
         │  任务: 基于 R&M 约束，输出有序的       │
         │        完整操作序列                   │
         │  输出: [(action, obj_id, target), ...] │
         └──────────────────────────────────────┘
                        │
                        ▼
         ┌──────── 评分模块 (Automated Scorer) ─────┐
         │  Ground Truth: 现有 R&M 模块输出         │
         │  评分维度:                             │
         │    - Perception Score (Kendall's τ)   │
         │    - Reachability Score (Prec/Recall)  │
         │    - Planning Score (碰撞/失败检查)      │
         └──────────────────────────────────────┘
```

### 2.2 关键设计决策

| 设计点 | 决策 | 原因 |
| :--- | :--- | :--- |
| 给场景文件还是只给图片 | **两者都给，完整原始场景文件** | 与实验组输入完全等价，保证公平性；图片提供形状视觉识别，场景文件提供坐标和几何 |
| Prompt 顺序 | **先感知（R&M排序），再规划** | 模拟真实规划者的决策流程；使感知错误和规划错误可以独立归因 |
| Ground Truth 来源 | **现有 Manipulability + Reachability 模块** | 完全客观、可重复，与 VLM 无关，是最高质量的评估标准 |
| 验收标准严格度 | **执行顺序违反物理约束即判定 Failure** | 拓扑搭对但顺序不可执行，在真实场景中等价于失败 |

---

## 3. 详细执行计划

### Step 1: Ground Truth 生成

**目标**: 为所有测试场景（4-8 cubes, NR/R, s01-s05）批量生成 R&M 的标准答案。

**执行脚本**: `experiments/scripts/generate_rm_ground_truth.py`

**输入**:
```
experiments/scenes/{N}cubes/{sXX}/random_trials/trial_{XX}_nr.g
experiments/scenes/{N}cubes/{sXX}/random_trials/trial_{XX}_r.g
```

**输出格式** (`experiments/evaluations/ground_truth/{N}cubes/{sXX}/trial_{XX}_{mode}_gt.json`):
```json
{
  "scene": "4cubes/s01/trial_01_nr",
  "manipulability_ranking": [
    {"obj_id": "obj_03", "rank": 1, "score": 0.87},
    {"obj_id": "obj_01", "rank": 2, "score": 0.72},
    {"obj_id": "obj_04", "rank": 3, "score": 0.55},
    {"obj_id": "obj_02", "rank": 4, "score": 0.41}
  ],
  "reachability": {
    "obj_01": true,
    "obj_02": true,
    "obj_03": true,
    "obj_04": false
  },
  "correct_execution_sequence": ["obj_03", "obj_01", "obj_02"]
}
```

### Step 2: Prompt 1 设计（感知 & R&M 排序）

**输入**:
- 场景图片（已有，`experiments/inputs/cubeStacking/{N}cubes/*.png`）
- 完整场景文件（已有，`.g` 文件）

**Prompt 核心要求**:
```markdown
你是一个机器人操作规划专家。根据以下场景文件和图片，评估每个物体的：
1. Manipulability (可操作性): 基于物体当前位置、姿态和被遮挡情况，给出排序（1=最容易操作）
2. Reachability (可达性): 该物体是否在机械臂工作空间内（true/false）

输出格式（严格 JSON）:
{
  "perception": {
    "obj_01": {"manipulability_rank": N, "reachable": bool, "reasoning": "..."},
    ...
  }
}
```

**关键**: 场景文件**不消隐**，保留完整属性（含 cube/mesh 等）。这与实验组的输入完全一致，体现公平性。

### Step 3: Prompt 2 设计（规划）

**输入**:
- Prompt 1 的 JSON 输出
- 原始场景文件
- 场景图片

**Prompt 核心要求**:
```markdown
根据以下感知结果和场景信息，生成一个满足所有约束的完整操作序列：
- 约束1: 不可达 (reachable=false) 的物体绝对不能被操作
- 约束2: 操作顺序必须从 manipulability_rank 高的物体开始（先操作容易抓的）
- 约束3: 被压住的物体必须在压它的物体被移走后才能操作

输出格式（严格 JSON）:
{
  "plan": [
    {"step": 1, "action": "pick", "object": "obj_03", "target": "table_center"},
    {"step": 2, ...}
  ]
}
```

### Step 4: 自动化评分（Scorer）

**评分脚本**: `experiments/scripts/evaluate_baseline_rm.py`

**评分维度**:

#### 4.1 Perception Score (Kendall's τ)
```python
from scipy.stats import kendalltau
gt_ranking = [obj["rank"] for obj in gt_data["manipulability_ranking"]]
vlm_ranking = [vlm_output["perception"][obj["obj_id"]]["manipulability_rank"]
               for obj in gt_data["manipulability_ranking"]]
tau, _ = kendalltau(gt_ranking, vlm_ranking)
# tau ∈ [-1, 1]: 1=完全正确, 0=随机, -1=完全反序
```

#### 4.2 Reachability Score (Precision / Recall)
```python
# TP: 正确判定为不可达的物体
# FP: 误判为不可达（其实可达）
# FN: 漏判（实际不可达但 VLM 没识别出来）
precision = TP / (TP + FP)
recall    = TP / (TP + FN)
```

#### 4.3 Planning Score (Sequence Validity)
```python
# 逐步检查生成序列：
# 1. 是否有 reachable=False 的物体出现在序列中 -> Failure
# 2. 是否出现"先操作被压物体"的顺序错误 -> Failure
# 3. 最终拓扑是否与目标一致 -> Topology Match
success = (no_unreachable_objects) and (no_order_violations) and (topology_match)
```

---

## 4. 文件树（新增文件）

```
experiments/
├── evaluations/
│   ├── VLM/
│   │   └── pure_llm_baseline/  (已有，结构不变)
│   └── ground_truth/           [NEW] R&M 标准答案
│       ├── 4cubes/
│       │   └── s01/
│       │       └── trial_01_nr_gt.json
│       └── ...
├── scripts/
│   ├── generate_rm_ground_truth.py   [NEW] 批量生成 GT
│   ├── run_baseline_two_stage.py     [NEW] 批量跑两阶段 Baseline
│   └── evaluate_baseline_rm.py      [NEW] 自动化评分
├── prompts/
│   ├── baseline_rm_perception.md    [NEW] Prompt 1 模板
│   └── baseline_rm_planning.md      [NEW] Prompt 2 模板
└── outputs/
    └── baseline_rm_v2/              [NEW] 新版 Baseline 输出
        ├── 4cubes/
        │   └── s01/
        │       ├── trial_01_nr_perception.json
        │       ├── trial_01_nr_plan.json
        │       └── trial_01_nr_score.json
        └── accuracy_analysis/
            ├── perception_scores.md
            ├── reachability_scores.md
            └── planning_scores.md
```

---

## 5. 接受标准（Acceptance Criteria）

| 指标 | Baseline 预期范围 | 实验组目标 |
| :--- | :--- | :--- |
| Perception Kendall's τ | 0.2 ~ 0.6 | N/A (Baseline-only metric) |
| Reachability Recall | 40% ~ 70% | N/A (Baseline-only metric) |
| Planning Success Rate (NR) | 40% ~ 65% | > 90% |
| Planning Success Rate (R) | 30% ~ 55% | > 85% |

ASSUMPTION: 上述 Baseline 预期范围基于对 LLM 纯文本推理能力的先验判断，实际数字需运行后确认。

---

## 6. 风险与缓解

| 风险 | 缓解措施 |
| :--- | :--- |
| VLM 输出格式不稳定，解析 JSON 失败 | Prompt 中提供严格的 JSON Schema，并添加重试逻辑 |
| Manipulability 模块不支持批量接口 | 先手动测试一个场景，确认接口可用后再编写批量脚本 |
| Kendall's τ 接近 0，说明 VLM 在感知层面就已失效 | 这正是实验要证明的结论，应如实记录并在论文中作为核心发现 |

---

## 7. 后续执行优先级

1. `[P0]` 确认现有 Manipulability + Reachability 模块的 API 接口，编写 `generate_rm_ground_truth.py`。
2. `[P0]` 设计并冻结 `baseline_rm_perception.md` Prompt 1 模板。
3. `[P1]` 人工验证 1 个场景的完整流程（GT 生成 -> Prompt 1 -> Prompt 2 -> 评分）。
4. `[P1]` 批量执行全部 50 个场景（5 场景 × 5 规模 × 2 模式）× 10 次重复。
5. `[P2]` 生成汇总报告和可视化图表，更新论文对照组数据。
