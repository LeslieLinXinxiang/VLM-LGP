# VLM-LGP 深度分析报告 (2026-03-22)

---

## 0. 2026-03-23 最小化实验更新：Branch Grouping + Layer-Aware Cutting

### 0.0 当前受控算法的正式说明

这次最小化测试里，仓库中真正实现并执行的算法名称是：

- 代码类名：`BranchAwareLayerCuttingClustering`
- 文档工作名：`Controlled Branch Grouping + Layer-Aware Batch Cutting`

这里需要特别说明两点：

1. 这是一个**受控原型**，用于验证“两阶段分解”是否能在当前 Phase1 样例图上稳定得到
   `134 | 256 | 789 -> 1 | 34 | 2 | 56 | 7 | 8 | 9`；
2. 它**不是**一个已经完整实现的 multilevel graph partitioning 求解器，当前实现也没有
   执行标准的 coarsen-partition-refine 流程。

当前主线接入状态：

- `pipeline/run_phase2.py` 已默认切换为 `BranchAwareLayerCuttingClustering`；
- 旧的 `BranchAwareClustering` 调用被保留为注释形式的 fallback；
- 新旧两套实现当前输出相同 schema，可直接互换，不需要修改下游 codegen 格式。

换句话说，当前代码真正做的是：

- 基于 support graph 的 branch grouping；
- 基于 branch 内局部层级的 layer-aware cutting；
- 基于 branch precedence 的稳定全局排序。

它参考了成熟图划分方法中“先聚合结构、再进行执行切割”的思想，但当前仓库里的实现仍然是
一个面向当前任务的受控、可解释、可复现原型，而不是通用图划分器。

### 0.0.1 当前受控原型用了什么原理

当前原型的核心原理可以拆成 5 步：

1. **Support graph parsing**
   - 输入是 `generated/phase1_target_graph.json`；
   - 将对象与支撑关系解析成有向图 `G=(V,E)`。

2. **Global layer computation**
   - 先在全图上计算拓扑层级；
   - 根节点或直接落在 table 上的对象先作为较低层；
   - 其余对象按 supporter 的最大层级递推。

3. **Branch grouping**
   - 对 layer 1 节点，根据底层支撑位置信息 `left/right` 初始化 branch；
   - 对更高层节点沿 supporter 向上传播 branch；
   - 如果一个节点同时依赖多个 branch，则标记为 `bridge`；
   - 最终在当前样例上得到：
     - `left -> [1, 3, 4]`
     - `right -> [2, 5, 6]`
     - `bridge -> [7, 8, 9]`

4. **Local layer-aware cutting**
   - 在每个 branch 的诱导子图中重新计算局部 layer；
   - 同一局部层中，只有 immediate support role 相同的节点才尝试合并；
   - 同时满足 `max_batch_size = 2` 的当前 solver-facing 约束。

5. **Branch-level precedence ordering**
   - 先建立 branch 之间的依赖图；
   - 再按依赖可满足顺序稳定展开 branch 内部 batches；
   - 由此得到最终全局序列。

### 0.0.2 参考了哪篇 paper

当前文档叙事所参考的成熟算法路线是多层图划分（multilevel graph partitioning），其经典文献为：

- George Karypis and Vipin Kumar, *Multilevel k-way partitioning scheme for irregular graphs*, Journal of Parallel and Distributed Computing, 1998.

这篇论文提供的核心思想是：

- 先对图做 coarsening；
- 再在粗图上做 partitioning；
- 最后在细图上做 uncoarsening / refinement。

需要实话实说的是：**当前仓库中的受控原型并没有完整实现这篇论文里的标准图划分流程**。目前
只是借用了它“先做结构聚合、再做后续切割/优化”的方法学启发，用来组织我们当前的两阶段叙事。

### 0.1 本次更新目标

这次更新不直接替换主 pipeline 中现有的 `BranchAwareClustering`，而是先做一个独立、
可复现、低侵入的最小化测试，验证下面这条两阶段分解逻辑在当前 Phase1 示例图上是否
稳定成立：

1. 先识别 branch-level groups；
2. 再在每个 branch 内做 layer-aware cutting；
3. 最后输出全局执行序列。

测试脚本路径：

- `test/pipeline/test_phase2_layer_aware_cutting.py`

测试输入路径：

- `generated/phase1_target_graph.json`

### 0.2 当前示例图上的目标结果

对当前 Phase1 支撑图，本次最小测试希望得到下面两个层级的结果：

- branch grouping: `134 | 256 | 789`
- final execution batches: `1 | 34 | 2 | 56 | 7 | 8 | 9`

### 0.3 最小原型的算法逻辑

本次原型沿用当前 graph format 和 branch 语义，不直接引入完整的 multilevel graph
partitioning 求解器，而是先验证“branch aggregation + layer cutting”这个两阶段故事
是否在现有数据结构上讲得通。也就是说，当前验证对象是一个**受控原型**，不是通用图划分器。

第一阶段：branch grouping

- 使用当前 support graph 解析与 layer 计算逻辑；
- 保留底层 `left / right` 支撑位置信息；
- 将多支撑汇合节点及其后续链条归入 `bridge` branch；
- 在当前样例上得到：
  - `left -> [1, 3, 4]`
  - `right -> [2, 5, 6]`
  - `bridge -> [7, 8, 9]`

第二阶段：layer-aware cutting

- 在每个 branch 的诱导子图内重新计算局部 layer；
- 对同一局部 layer 的节点，按相同 immediate support role 做分组；
- 保持当前 `max_batch_size = 2` 的 solver-facing 约束；
- 在当前样例上得到：
  - `134 -> 1 | 34`
  - `256 -> 2 | 56`
  - `789 -> 7 | 8 | 9`

全局排序

- 先在 branch-level graph 上建立 precedence；
- 再按稳定顺序展开 branch 内部 batches；
- 当前样例的最终输出为：
  - `1 | 34 | 2 | 56 | 7 | 8 | 9`

### 0.4 与旧 BATC 输出的直接对照

旧 `BranchAwareClustering` 在当前样例上的输出为：

- `1 | 2 | 34 | 56 | 7 | 8 | 9`

本次两阶段最小原型的输出为：

- `1 | 34 | 2 | 56 | 7 | 8 | 9`

这次变化的重点不是“更换全部主算法”，而是把原先混在一起的两件事拆开：

- branch inference
- layer-aware execution cutting

这样做之后，中间结构 `134 | 256 | 789` 会先被显式保留下来，最终执行序列的来源也更
容易解释。

---

## 1. 论文 Pipeline 与逻辑提炼

### 1.1 完整的端到端流程

```
Scene (RGB-D + 6D poses)
         ↓
    ┌────────────────────────────────────┐
    │ PHASE 0: Scene Grounding & Feasibility Screening
    ├────────────────────────────────────┤
    │ - Object inventory grounding
    │ - Scene-order dictionary construction (Euclidean distance sorting)
    │ - Waypoint-level reachability test via KOMO_wp
    │ → Filter infeasible objects early
    └────────────────────────────────────┘
         ↓ (Grounded inventory + feasible set)
    ┌────────────────────────────────────┐
    │ PHASE 1: Object-Support Graph Planning
    ├────────────────────────────────────┤
    │ - VLM parses target assembly spec into graph G=(V,E)
    │ - Topological depth computation for each object
    │ - Branch-Aware Topological Clustering (BATC):
    │   * Decompose by support dependencies
    │   * Cap batch size to 2 placement tasks max
    │   * Partition into parallel spatial branches
    │ → Executable batches (preserving structural dependencies)
    └────────────────────────────────────┘
         ↓ (Batches + scene-order dictionary)
    ┌────────────────────────────────────┐
    │ PHASE 2: Selective Native LGP Instantiation
    ├────────────────────────────────────┤
    │ - For each batch:
    │   * Bind generic object categories → concrete scene instances
    │   * Compile only required symbolic relations
    │   * Instantiate "active constraint set"
    │ - Trajectory optimization with active collision constraints
    │ - Output: Feasible trajectory x*
    └────────────────────────────────────┘
         ↓ (Trajectory + gripper commands)
    ┌────────────────────────────────────┐
    │ PHASE 3: Robot Execution
    ├────────────────────────────────────┤
    │ - Parse & dispatch to real platform
    │ - Update scene state for next cycle
    └────────────────────────────────────┘
         ↓
    Final Assembly
```

### 1.2 核心创新点

**VLM-LGP 的关键差异 vs 原生 LGP：**

| 方面 | 原生 LGP | VLM-LGP |
|------|---------|---------|
| **Symbolic Domain** | 单体：覆盖所有可能的组合 | 选择性：每batch仅实例化相关关系 |
| **Search Space** | 全组合爆炸 (exponential) | 被BATC剪枝 (polynomial pruning) |
| **结构感知** | 无 | 通过支持图明确支持关系 |
| **可行性前检查** | 无 | Phase 0: KOMO_wp reachability test |
| **关键循环** | Geometric backtracking only | VLM parsing + BATC decomposition + LGP solving |

---

## 2. Figma Flowchart 用词审查与修改报告

### 2.1 扫描结果概览

**已读取的Flowchart文本节点总数:** 84

**关键问题识别:**

| 序号 | 当前用词 | 应改为 | 理由 | 位置 |
|------|---------|-------|------|------|
| 1 | "Phase 2: Dynamic Resource Allocation and Batch Compilation (Sec. 3.3)" | "Phase 2: Dynamic Resource Allocation and Batch Compilation (Sec. 3.2)" | 论文 subsection 对应 3.2 (Object-Support Graph Planning)，不是 3.3 | Framework区第2列顶部标题 |
| 2 | "Semantic Resource Allocator / Matches available physical instances to generic requests" | "Branch-Aware Topological Clustering (BATC) Algorithm / Partition support dependencies into spatial branches & layers; cap batch size ≤ 2" | 当前描述仍太接近资源分配，未体现"Branch-Aware"和"Topological"的核心 | Framework第2列中段 |
| 3 | "BATC Algorithm" (孤立显示) | "BATC: Branch-Aware Topological Clustering / Deterministic decomposition" | BATC需要描述其是"确定性"的、"分支感知"的聚类，不仅仅叫一个名字 | Framework第2列 |
| 4 | "Phase 3: Constrained Geometric Execution (Sec. 3.4)" | "Phase 3: Constrained Geometric Execution (Sec. 3.3 & 3.4)" | 论文的3.3是"Selective Native LGP Instantiation" (trajectory optimization)，3.4是"Robot Execution"，Phase 3应同时覆盖两者 | Framework区第3列顶部标题 |
| 5 | "Python Compliance Monitor (cross-phase gatekeeper)" | "Python Compliance Monitor (validates LPG consistency)" | 论文中该模块确认"Validate current LPG against current strategy"，不是"gatekeeper" | Framework第2列下部 |
| 6 | "Waypoint-Gated Active Constraint Strategy (Sec. 3.3.1)" | "Waypoint-Gated Active Constraint Strategy (Sec. 3.2)" | 论文此概念属于Object-Support Graph Planning subsection (3.2)，不是3.3.1 | Framework第2列底部 |
| 7 | 缺失：Scene-order Dictionary | 需要在 Phase 0 中明确显示 | 论文明确提到"scene-order dictionary generated during scene grounding"，是绑定场景实例的关键 | Phase 0 右侧 |
| 8 | "Layer-1 LGP Solver (Sparse Waypoints)" | "Layer-1 LGP Solver (KOMO_wp)" | 应用论文中的精确术语"KOMO_wp"而不是通用的"Sparse Waypoints" | Phase 0 底部输出 |

### 2.2 整体结构一致性检查

✅ **已正确对应:**
- Phase 0 → Sec. 3.1 (Scene Grounding)
- Phase 1 → Sec. 3.2 (Object-Support Graph Planning)
- Phase 3 → Sec. 3.4 (Robot Execution)
- VLM Parser 位置正确
- LPG DAG 在 Phase 1 中正确体现
- Collision constraints 清晰标注

⚠️ **需整合：**
- Phase 2 标题与 Phase 3 的关系：当前 Phase 2 标题是"Batch Compilation"，但这是 Phase 1 的输出，Phase 2 实际上是"LGP求解"。建议重新标注。

---

## 3. Graph Planning 中 Clustering 算法的核心与可视化建议

### 3.1 BATC (Branch-Aware Topological Clustering) 核心

**关键特性：**

```
Input: Object-Support Graph G = (V, E) 
       (nodes = objects, directed edges = support relations)

Output: Ordered execution batches B₁, B₂, ..., Bₖ
```

**BATC 的三大核心操作:**

1. **Topological Depth Computation**
   - 对支持图计算每个对象的"深度"
   - 深度 = 从图根到该节点的最长路径长度
   - 例：底层支撑物 depth=0, 放在其上的对象 depth=1

2. **Branch-Aware Decomposition**
   - 将支持关系按"分支"(branch) 分组
   - 同一分支内的对象可以并行执行
   - 不同分支需要分序列执行（避免依赖冲突）

3. **Batch Capping (≤ 2 tasks per batch)**
   - 每个batch最多包含2个placement任务
   - 保证LGP求解的规模可控
   - 但不牺牲并行性（同一深度的不同分支仍可并行）

### 3.2 BATC vs Layer-Based Approach 的本质差异

#### Layer-Based (传统)
```
Layer 2:   [C]
            ↑
Layer 1: [A] → [B]
            ↗
Layer 0: [Ground]

特点：
- 所有深度相同的对象放在一个"layer"
- 层级之间严格串行
- 无法利用"分支内部"的并行机会
```

#### BATC (分支感知)
```
支持图：
        [C]
        /
    [A]
        \
        [B]

分解结果：
Batch 1: {A}         (depth 1, 支撑物)
Batch 2: {B, C}      (depth 2, 但分属不同分支，仍可分别处理或并行)

特点：
- 不仅看深度，还看"分支结构"
- 同一深度的不同分支对象可以被单独打包到不同batch
- 开启了"支持关系感知的精细化并行"
```

### 3.3 用图体现 BATC 与 Layer-Based 的区别

#### 推荐的可视化方案

**上轨（语义逻辑）中展示两种对比：**

**LEFT: Layer-Based (传统方式)**
```
┌─────────────────────┐
│      Layer 2        │  ← All objects at depth 2
│  [C] [B] (并行)     │    (No branch awareness)
├─────────────────────┤
│      Layer 1        │
│     [A]             │  ← All objects at depth 1
├─────────────────────┤
│      Layer 0        │
│    [Ground]         │  ← Supports
└─────────────────────┘

缺点: B和C虽然独立，但都要等Layer 1完成
```

**RIGHT: BATC (分支感知)**
```
┌──────────────────────────────────┐
│  Branch 1 (Left)  │  Branch 2 (Right)
│  ┌──────────────┐ │ ┌──────────────┐
│  │ Batch 2a: C  │ │ │ Batch 2b: B  │  ← 同深度但不同分支
│  │              │ │ │              │     可独立/并行处理
│  └──────────────┘ │ └──────────────┘
│        ↑          │        ↑
│  ┌──────────────┐ │ ┌──────────────┐
│  │ Batch 1: A   │ │ │ (A支撑两分支)│
│  └──────────────┘ │ └──────────────┘
│        ↑          │        ↑
│        └──────────┴────────┘
│        [Ground/Support]
└──────────────────────────────────┘

优点: 通过分支感知，B和C可被拆分到两个独立batch
```

#### 具体Figma调整建议

**在上轨（Phase 1/2的交界处）：**

1. **左侧展示LPG DAG** (现有)
   - 保持当前的有向无环图表示

2. **中间新增一个"BATC分解过程"视图：**
   - 显示topological depth (用纵轴高度)
   - 用不同颜色框标注不同的"分支" (Branch)
   - 箭头指向每个branch对应的batch编号
   
3. **右侧展示执行顺序序列**
   - Batch 1: {对象A}
   - Batch 2a: {对象C}, Batch 2b: {对象B}
   - 用虚线/小箭头表示可并行执行的关系

#### 示例图示文字描述

```
VLM Parser 
  ↓
支持图 G = (V, E)
  ├─ 节点: 对象实例
  ├─ 边: 直接支持关系 (e.g., A←支撑B)
  └─ DAG性质: 无循环

     ↓

BATC 聚类
  ├─ Step 1: 计算拓扑深度 (depth by longest path)
  ├─ Step 2: 分支分解 (branch-aware partitioning)
  └─ Step 3: 批量封装 (batch cap ≤ 2 tasks)

     ↓

执行批序列 [Batch₁, Batch₂, ..., Batchₖ]
  ├─ 每个batch的大小 ≤ 2
  ├─ Batch之间满足支持依赖
  └─ 同一batch内可并行或串行
```

---

## 4. 建议的Figma修改清单

### 4.1 标题与标签修正 (高优先级)

```
修改项 1: Phase 2 标题
FROM: "Phase 2: Dynamic Resource Allocation and Batch Compilation (Sec. 3.3)"
TO:   "Phase 1-2: Graph Planning & BATC Clustering (Sec. 3.2)"

修改项 2: Semantic Resource Allocator 描述
FROM: "Semantic Resource Allocator / Matches available physical instances to generic requests"
TO:   "BATC: Topological Clustering / Branch-aware decomposition with batch capping (≤2)"

修改项 3: Phase 3 标题
FROM: "Phase 3: Constrained Geometric Execution (Sec. 3.4)"
TO:   "Phase 2-3: LGP Solving & Execution (Sec. 3.3-3.4)"

修改项 4: Python Compliance Monitor 描述
FROM: "Python Compliance Monitor (cross-phase gatekeeper)"
TO:   "Python Compliance Monitor (LPG consistency validator)"

修改项 5: KOMO_wp 术语
FROM: "Layer-1 LGP Solver (Sparse Waypoints)"
TO:   "KOMO_wp Solver (Waypoint-level LGP)"
```

### 4.2 新增内容 (中优先级)

- **Scene-order Dictionary** 箭头：从Phase 0 → Phase 2
- **BATC分解视图** (见3.3建议): 在上轨中间插入一个小图示
  - 展示topological depth与分支分解

### 4.3 可视化增强 (低优先级，但高价值)

- 用不同颜色为"分支"标注 (e.g., Branch A=蓝, Branch B=紫)
- 在BATC框内画出"深度线" (depth levels用水平虚线)

---

## 5. 总结

### 核心发现

1. **论文逻辑清晰：** Phase 0→1→2→3 对应明确，VLM + BATC + LGP的三层架构已在论文中完整定义

2. **Flowchart用词有待精化：** 
   - Section编号映射需调整
   - BATC的"分支感知"与"拓扑"特性需更显著地体现
   - 缺少Scene-order Dictionary的显式标注

3. **BATC vs Layer-Based 的本质：**
   - **Layer-Based**: 深度相同 = 一个layer, 层间串行
   - **BATC**: 考虑分支分解，同深度的不同分支可独立打包，开启精细并行
   - **可视化关键**: 展示"拓扑深度"与"分支标注"的双重维度

### 建议下一步

1. 按修改清单调整Figma (标题、术语)
2. 在上轨中间插入BATC分解的示意图 (展示depth vs branch)
3. 添加Scene-order Dictionary的数据流箭头
4. 验证所有Section编号与论文strict对应
