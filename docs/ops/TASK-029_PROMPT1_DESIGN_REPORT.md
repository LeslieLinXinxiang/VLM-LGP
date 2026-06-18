# Baseline Prompt 1 完整设计方案报告 (V2 - 稳定性优化版)

**版本**: v2.0 (基于 baseline_pure_llm.md 逻辑重构)
**创建时间**: 2026-04-27 21:20
**状态**: 待验证
**归档路径**: `docs/ops/TASK-029_PROMPT1_DESIGN_REPORT.md`

---

## 1. 设计哲学

参考原对照组中表现最稳定的 `prompts/baseline_pure_llm.md`，我们将“显式推理链”作为 Prompt 1 的核心。即使没有场景文件，也要让 VLM 按照**“视觉审计 -> 层级解析 -> 动作编译”**的严密逻辑执行。

### 1.1 核心改进点
- **拒绝抽象语法**：不再强制使用 PDDL 语法，改用 VLM 表现更稳定的“动作指令列表”。
- **强制视觉推理**：要求在 `<REASONING_DRAFT>` 中先进行底向上的层级分析。
- **锚点命名法**：物体名称必须包含其在图中的显著视觉特征（颜色、相对位置、形状）。

---

## 2. 格式规范

### 2.1 推理草稿 (Reasoning Draft)
必须包含以下三个步骤：
1. **Visual Stock Audit**: 数出图中所有的物体，并记录特征。
2. **Layer Analysis**: 确定底向上的搭建层级（Layer 1 到 Layer N）。
3. **Dependency Logic**: 明确支撑关系（谁在谁上面）。

### 2.2 动作列表 (Action Plan)
使用简洁的指令格式：
`STEP N: PICK [物体描述], PLACE ON [目标位置描述]`

---

## 3. Prompt 1 模板 (修订版)

```markdown
# MISSION: IMAGE-ONLY ROBOTIC ASSEMBLY PLANNER

You are a Robotic Assembly Compiler. Your goal is to generate a step-by-step assembly sequence based ONLY on the provided image.

## HARD PRINCIPLE
1. The provided image is the ONLY source of truth.
2. You do NOT have a scene file. You must detect objects and their counts visually.
3. You must plan from the BOTTOM of the structure up to the TOP.

---

## 1. REQUIRED REASONING ORDER (Inside <REASONING_DRAFT>)

Follow this sequence strictly:

### Step 1: Visual Stock Audit
List every object you see in the scene by color, shape, and initial position.
- Example: "1 red cube (left), 1 long blue rectangular prism (bottom), 1 green triangular prism (top)."

### Step 2: Layer Extraction (Bottom to Top)
Define which objects belong to which layer:
- Layer 1: Resting directly on the table.
- Layer 2: Resting on objects from Layer 1.
- ... and so on.

### Step 3: Support Logic (Plumb-line check)
For each object in Layer N, identify its supporter(s) in Layer N-1.
- If it spans across multiple blocks, it is a "bridge" and has multiple supporters.

---

## 2. OBJECT NAMING CONVENTION
Because you don't have object IDs, you must name objects by their visual identity:
`[color/length]-[type]-[relative-position]`
- Examples: `red-cube-left`, `long-blue-prism-bottom`, `green-triangle-top`.

---

## 3. OUTPUT CONTRACT

Output exactly in this XML structure:

<REASONING_DRAFT>
[Your concise reasoning following the 3-step order above]
</REASONING_DRAFT>

<ACTION_PLAN>
STEP 1: PICK [object-name], PLACE ON [table-center/table-left/table-right]
STEP 2: PICK [object-name], PLACE ON [target-object-name]
... (Add steps as needed)
</ACTION_PLAN>

---

## 4. FINAL SELF-CHECK
1. Did I list ALL objects in the audit?
2. Is the sequence strictly bottom-to-top?
3. Does every PICK have a matching PLACE?
4. For bridges, did I mention all supporters in the reasoning?
```

---

## 4. 验证与后续处理

### 4.1 预期效果
该 Prompt 能够强制 VLM 在“规划”之前先进行“观察”和“结构拆解”，有效减少跳步、漏步和零件混淆的情况。

### 4.2 对接 Prompt 2
Prompt 2 将接收上述 `<ACTION_PLAN>`，并结合真实的 `scene_named.g` 文件执行以下操作：
1. **Mapping**: 将 `red-cube-left` 映射到场景文件中的具体 `obj_id`。
2. **Quality Injection**: 评估该 `obj_id` 的实时可操作性分值。
3. **PDDL Compilation**: 输出带有最优 Manipulability 排序的最终 PDDL 文件。


---

## 1. 背景与目标

### 1.1 Prompt 1 的核心作用

Prompt 1 是两阶段 Baseline 的第一阶段。

**唯一输入：场景图片（无场景文件）**

这是防止 VLM 作弊的核心机制。如果 VLM 看到场景文件，它能立刻知道"场景里只有 obj_01~obj_04 这几个物体"，视觉理解能力被短路。通过仅输入图片，VLM 必须依赖真实的视觉识别能力去推断：
1. 场景中有哪些物体（形状、颜色、位置）
2. 目标堆叠结构是什么
3. 应该按什么顺序操作

**输出：结构化动作计划（Plan Skeleton，PDDL-style）**

---

## 2. 输出格式设计（PDDL Plan Skeleton）

参考 Yang et al. 2025 (ICRA) 《Guiding Long-Horizon Task and Motion Planning with Vision Language Models》，本实验采用轻量化的 **Plan Skeleton** 格式（而非完整 PDDL domain/problem/stream 文件）。

### 2.1 动作原语定义

本场景仅涉及两种动作原语：

| 动作 | 语法 | 语义 |
| :--- | :--- | :--- |
| `pick` | `(pick <object>)` | 从当前位置拾取物体 |
| `place` | `(place <object> <target>)` | 将物体放置到目标位置 |

### 2.2 命名规则

由于 Prompt 1 不接收场景文件，物体必须用**视觉描述名称**（而非 obj_id）命名。

**物体命名**（`<type>-<position_descriptor>`）：
```
cube-left            # 左边的正方体
cube-center          # 中间的正方体
cube-right           # 右边的正方体
long-rect-bottom     # 底部的长方体
rect-mid             # 中间层的长方体
triangle-top         # 顶部的三角柱
```

**目标位置命名**（`<surface>-<position>`）：
```
table-left           # 桌面左侧
table-center         # 桌面中央
table-right          # 桌面右侧
on-<object>          # 在某物体上方（单支撑）
on-<obj1>-<obj2>-<obj3>  # 由三个物体共同支撑（桥接结构）
```

### 2.3 完整输出格式示例

```pddl
;; VLM Cube Stacking Plan
;; Detected objects: 1 long-rectangular-prism, 2 rectangular-prisms, 3 cubes, 1 triangular-prism

(:plan
  (pick  long-rect-bottom)
  (place long-rect-bottom     table-center)
  (pick  cube-left)
  (place cube-left            on-long-rect-bottom-left)
  (pick  cube-center)
  (place cube-center          on-long-rect-bottom-center)
  (pick  cube-right)
  (place cube-right           on-long-rect-bottom-right)
  (pick  rect-bridge)
  (place rect-bridge          on-cube-left-cube-center-cube-right)
  (pick  rect-mid)
  (place rect-mid             on-rect-bridge)
  (pick  triangle-top)
  (place triangle-top         on-rect-mid)
)
```

### 2.4 格式约束（必须严格遵守）

1. 每个物体只能被 `pick` 一次
2. `place` 必须紧跟在对应物体的 `pick` 之后（不允许夹持多个物体）
3. 物体在 `pick` 之前必须已经被放置（不能 `pick` 一个悬空的物体）
4. `pick` 和 `place` 必须成对出现
5. 注释行（以 `;;` 开头）必须列出检测到的所有物体类型和数量

---

## 3. Prompt 1 完整模板

```markdown
## Task Description

You are a robot manipulation planner. Your task is to analyze the image of a physical scene and generate a step-by-step manipulation plan to construct the target structure you observe.

## What You See

Look at the image carefully. The image shows:
- A table with several objects placed on it
- Some objects that need to be re-arranged/stacked to form a specific structure
- The **target structure** is what you can infer from the visual layout

## Available Object Types

The scene may contain objects of these types:
- **Cube**: A small cubic block (all sides equal)
- **Rectangular Prism**: A medium-length rectangular block
- **Long Rectangular Prism**: A longer rectangular block (noticeably longer than Rectangular Prism)
- **Triangular Prism**: A wedge/triangle-shaped block

## Available Actions

You can only use two actions:
- `(pick <object>)` — Pick up an object from its current position
- `(place <object> <target>)` — Place the object at the target position

## Naming Convention

Name objects using their **visual appearance** (type + relative position):
- Examples: `cube-left`, `long-rect-bottom`, `rect-mid`, `triangle-top`
- For table positions: `table-left`, `table-center`, `table-right`
- For stacking on ONE object: `on-<object>` (e.g., `on-rect-mid`)
- For stacking bridging THREE objects: `on-<obj1>-<obj2>-<obj3>` (e.g., `on-cube-left-cube-center-cube-right`)

## Output Requirements

Output ONLY the plan in the following format. Do not add any other text outside the plan block.

```pddl
;; VLM Cube Stacking Plan
;; Detected objects: <list all detected objects and counts>

(:plan
  (pick  <object>)
  (place <object>  <target>)
  ...
)
```

## Rules

1. Every object you pick MUST be placed before you pick another object.
2. Only pick an object that is on a stable surface (table or another object), never pick from mid-air.
3. List ALL objects in the comment line at the top.
4. Analyze the image from bottom to top to determine the correct build order.
5. If the target structure requires a bridge (one object resting on THREE others), use the `on-obj1-obj2-obj3` naming format.
```

---

## 4. 验证方案

### 4.1 一次性试跑（P0 验证）

**使用的测试图片**：`experiments/inputs/cubeStacking/4cubes/cube_n04_s01.png`

**预期输出**（基于对 s01 场景的人工理解）：
```pddl
;; VLM Cube Stacking Plan
;; Detected objects: 3 cubes, 1 rectangular-prism

(:plan
  (pick  cube-left)
  (place cube-left    table-left)
  (pick  cube-center)
  (place cube-center  table-center)
  (pick  cube-right)
  (place cube-right   table-right)
  (pick  rect-top)
  (place rect-top     on-cube-center)
)
```

**验证维度**：
1. VLM 是否成功识别了正确数量的物体？（物体计数）
2. VLM 是否输出了合法的 PDDL Plan Skeleton 格式？（格式合规）
3. VLM 描述的堆叠结构是否与图片一致？（拓扑正确性）

### 4.2 格式解析器

需要配套编写一个 Python 解析器，将 VLM 输出的 PDDL Plan Skeleton 转换为可评估的结构：

```python
import re

def parse_plan_skeleton(pddl_text: str) -> list:
    """
    解析 VLM 输出的 Plan Skeleton，返回动作列表
    返回格式: [("pick", "cube-left"), ("place", "cube-left", "table-left"), ...]
    """
    actions = []
    # 提取 (:plan ...) 块内部的内容
    plan_match = re.search(r'\(:plan\s+(.*?)\)', pddl_text, re.DOTALL)
    if not plan_match:
        return None  # 格式错误

    plan_content = plan_match.group(1)
    action_matches = re.findall(r'\((\w+)\s+([^\)]+)\)', plan_content)

    for action_type, args in action_matches:
        args_list = args.strip().split()
        actions.append((action_type, *args_list))

    return actions


def extract_object_list(pddl_text: str) -> list:
    """
    从注释行提取检测到的物体列表
    """
    obj_line = re.search(r';;\s*Detected objects:\s*(.+)', pddl_text)
    if obj_line:
        return obj_line.group(1).strip()
    return ""
```

---

## 5. Prompt 2 的前置条件（等 Prompt 1 格式稳定后再设计）

Prompt 2 需要：
- **输入 A**: Prompt 1 输出的 PDDL Plan Skeleton（含视觉描述的物体名）
- **输入 B**: 场景文件（完整 `.g` 文件，含物体 ID 和坐标）
- **任务**: 将视觉描述名 → obj_id 映射，并基于坐标信息评估 Manipulability，重排执行顺序

**等 Prompt 1 跑出稳定结果后再锁定 Prompt 2 设计。**

---

## 6. 下一步执行计划

| 步骤 | 操作 | 预期时间 |
| :--- | :--- | :--- |
| **Step 1** | 用上述 Prompt 模板对 `4cubes/s01` 图片进行一次测试调用 | 30 分钟 |
| **Step 2** | 人工检查输出：格式是否合规，物体计数是否正确 | 15 分钟 |
| **Step 3** | 如有必要，调整 Prompt 的 naming convention 或 rules | 视情况 |
| **Step 4** | 在 4cubes + 8cubes 各跑 3 次，评估格式稳定性 | 1 小时 |
| **Step 5** | 格式稳定后，冻结 Prompt 1 并写入 `prompts/baseline_visual_planner.md` | 30 分钟 |
| **Step 6** | 启动 Prompt 2 设计 | 下一阶段 |
