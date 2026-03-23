# VLM-LGP 深度分析报告 (2026-03-22)

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

