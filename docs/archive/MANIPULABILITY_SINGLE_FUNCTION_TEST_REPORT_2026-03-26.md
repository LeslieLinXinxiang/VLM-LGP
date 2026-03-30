# Manipulability 单一功能测试报告（2026-03-26）

## 1. 目标与范围

本报告仅覆盖 **单一功能测试**：

- 功能：对 Phase0 中「已判定 feasible 的对象集合」进行 manipulability 评分与排序；
- 不覆盖：下游 Phase1/Phase2 协议改动，不改 solver 约束，不改 reachability 判定逻辑。

对应任务边界来自：
- [docs/ops/MANIPULABILITY_MVP_REQUIREMENTS_2026-03-25.md](docs/ops/MANIPULABILITY_MVP_REQUIREMENTS_2026-03-25.md#L5)
- [docs/ops/METHOD_UPGRADE_TASKBOOK_2026-03-25.md](docs/ops/METHOD_UPGRADE_TASKBOOK_2026-03-25.md#L34)

---

## 2. 结论先行（给实施决策）

1. **最小测试路径可行**：直接复用当前 Phase0 输入（`unnamed.g` / `generated/scene/unnamed.g`）即可，不需要新造场景。  
2. **算法建议**：MVP 使用静态 Jacobian manipulability（Yoshikawa 指标）即可。  
3. **Franka 参数需求**：
   - 静态 manipulability：必须有 **运动学链 + 当前关节状态 + 关节限位**；
   - 动态 manipulability：额外需要 **动力学惯性矩阵**。  
4. **本地参数是否已有**：有，且在仓库内可直接定位（`panda.g` / `panda_clean.g` / `panda_arm_hand.urdf`）。

---

## 3. 单一功能测试对象定义

### 3.1 被测功能（Unit-under-test）

`rank_objects_by_manipulability(feasible_objects, scene_config, robot_model, tau_m)`

建议拆分：
- `compute_manipulability_score_for_object(...)`
- `rank_objects_by_manipulability(...)`

该拆分已在需求文档中给出：
- [docs/ops/MANIPULABILITY_MVP_REQUIREMENTS_2026-03-25.md](docs/ops/MANIPULABILITY_MVP_REQUIREMENTS_2026-03-25.md#L107-L111)

### 3.2 当前基线（待替换）

当前同类对象内排序按与基座平面距离：
- [core/phase0_parser.py](core/phase0_parser.py#L172-L176)

---

## 4. I/O 定义（单一功能测试）

### 4.1 输入

1. **对象候选集（feasible only）**
   - 来源：reachability split 之后。
   - 现有入口：`split_infeasible_objects_from_reachability(...)`
   - 证据：
     - [core/phase0_parser.py](core/phase0_parser.py#L196)
     - [pipeline/run_phase0.py](pipeline/run_phase0.py#L163-L166)

2. **场景配置**
   - `unnamed.g` 或 `generated/scene/unnamed.g`。
   - 需求文档允许直接复用现有输入：
     - [docs/ops/MANIPULABILITY_MVP_REQUIREMENTS_2026-03-25.md](docs/ops/MANIPULABILITY_MVP_REQUIREMENTS_2026-03-25.md#L207-L213)

3. **机器人模型（Franka/Panda）**
   - 由场景 `Include` 引入 `panda.g`。
   - 证据：
     - [unnamed.g](unnamed.g#L14)
     - [generated/scene/scene_named.g](generated/scene/scene_named.g#L14)

4. **配置参数**
   - `tau_m`（MVP 默认 0.08）；
   - 可选：`seed`（保证稳定排序）。
   - 证据：
     - [docs/ops/MANIPULABILITY_MVP_REQUIREMENTS_2026-03-25.md](docs/ops/MANIPULABILITY_MVP_REQUIREMENTS_2026-03-25.md#L37)

### 4.2 输出

1. 保持原有产物不变：
   - `generated/phase0_layout.json`
   - `generated/infeasible_objects.json`

2. 新增 sidecar：
   - `generated/ordering_score_report.json`
   - 推荐字段：`manipulability_score`, `status`, `rank`, `reason`
   - 证据：
     - [docs/ops/MANIPULABILITY_MVP_REQUIREMENTS_2026-03-25.md](docs/ops/MANIPULABILITY_MVP_REQUIREMENTS_2026-03-25.md#L139-L157)

---

## 5. 依赖项清单（按必须/可选）

### 5.1 必须依赖

1. **Phase0 解析与命名注入流程**
   - [pipeline/run_phase0.py](pipeline/run_phase0.py#L88)

2. **reachability 可用（用于 feasible 子集）**
   - 脚本：
     - [core/phase0_parser.py](core/phase0_parser.py#L201)
   - 可执行文件：
     - [core/phase0_parser.py](core/phase0_parser.py#L203)

3. **RAI/robotic 运行时可加载场景**
   - 例：
     - [scripts/view_scene.py](scripts/view_scene.py#L16-L17)

4. **Panda 运动学/限位参数**
   - 关节链与 `limits`（`panda_clean.g`）
   - 证据：
     - [rai/test/newLGP/rai-robotModels/panda/panda_clean.g](rai/test/newLGP/rai-robotModels/panda/panda_clean.g#L3-L20)

### 5.2 可选依赖

1. **URDF 交叉核对**
   - [rai/test/newLGP/rai-robotModels/panda/panda_arm_hand.urdf](rai/test/newLGP/rai-robotModels/panda/panda_arm_hand.urdf#L31-L222)

2. **动力学参数（仅 dynamic manipulability 用）**
   - `mass` / `inertia` 在 `panda_clean.g` 中已有：
   - [rai/test/newLGP/rai-robotModels/panda/panda_clean.g](rai/test/newLGP/rai-robotModels/panda/panda_clean.g#L3-L20)

---

## 6. 具体算法（MVP）

### 6.1 静态 manipulability（Yoshikawa）

对每个候选对象，取一个抓取评估姿态（可先用对象中心上方固定偏置做 MVP），求对应逆解或当前可达姿态 `q*`，计算末端雅可比 `J(q*)`。

令任务维度为 3（先做位置 dexterity），则

$$
m_{raw}(o)=\sqrt{\det(J_p(q^*)J_p(q^*)^\top)}
$$

其中 $J_p\in\mathbb{R}^{3\times n}$ 为位置雅可比。

归一化（同一场景内）：

$$
m(o)=\frac{m_{raw}(o)-m_{min}}{m_{max}-m_{min}+\epsilon}
$$

阈值与状态：

$$
\operatorname{status}(o)=
\begin{cases}
\text{ranked}, & m(o)\ge\tau_m\\
\text{unknown}, & m(o)<\tau_m\ \text{or invalid}
\end{cases}
$$

排序规则：
1. `ranked` 按 `m(o)` 降序；
2. `unknown` 统一放尾部；
3. 同分/unknown 内保持现有稳定 tie-break 风格。

与文档一致：
- [docs/ops/MANIPULABILITY_MVP_REQUIREMENTS_2026-03-25.md](docs/ops/MANIPULABILITY_MVP_REQUIREMENTS_2026-03-25.md#L174-L194)
- [docs/ops/METHOD_UPGRADE_TASKBOOK_2026-03-25.md](docs/ops/METHOD_UPGRADE_TASKBOOK_2026-03-25.md#L114-L127)

### 6.2 引用文献

- Yoshikawa, T. (1985). *Manipulability of robotic mechanisms.*
- 该引用已在仓库需求文档中锁定：
  - [docs/ops/MANIPULABILITY_MVP_REQUIREMENTS_2026-03-25.md](docs/ops/MANIPULABILITY_MVP_REQUIREMENTS_2026-03-25.md#L66)

---

## 7. 最小测试路径（单一功能）

### Step 0：环境准备

按仓库规则使用 `vlm_jazzy` + `scripts/env.sh`（防止 `robotic`/`cv2` 依赖问题）。
- 规则出处：
  - [docs/execution_protocol.md](docs/execution_protocol.md#L32-L56)

### Step 1：复用现有 Phase0 输入

- 输入文件：`unnamed.g`（或 `generated/scene/unnamed.g`）
- 证据：
  - [unnamed.g](unnamed.g#L14-L16)

### Step 2：先跑现有 Phase0 直到可行/不可行分流

- 不改协议，仅拿 feasible 列表。
- 证据：
  - [pipeline/run_phase0.py](pipeline/run_phase0.py#L163-L166)

### Step 3：对 feasible 逐个算 manipulability 分数

- 使用 Panda 模型 + EE frame（`gripper`，经前缀后是 `l_gripper`）。
- gripper 定义：
  - [rai/test/newLGP/rai-robotModels/panda/panda.g](rai/test/newLGP/rai-robotModels/panda/panda.g#L55)

### Step 4：阈值、排序、sidecar 输出

- 输出 `generated/ordering_score_report.json`。
- 维持下游输入不变。

### Step 5：验收（单功能）

1. `ordering_score_report.json` 存在且字段齐全；
2. `phase0_layout.json` / `infeasible_objects.json` schema 不变；
3. 固定 seed 重复执行排序一致；
4. 至少一个场景中顺序与距离基线不同（证明功能生效）。

---

## 8. 需要哪些 Franka 参数？本地是否有？去哪里找？

## 8.1 静态 manipulability 需要

1. 关节类型与连杆拓扑（用于 Jacobian）
2. 关节限位（用于无效姿态过滤、采样约束）
3. 末端执行器定义（EE frame）

本地现状：**有**。

- 场景已引用 Panda 模型：
  - [unnamed.g](unnamed.g#L14)
- Panda 关节限位：
  - [rai/test/newLGP/rai-robotModels/panda/panda_clean.g](rai/test/newLGP/rai-robotModels/panda/panda_clean.g#L3-L20)
- URDF 原始参数：
  - [rai/test/newLGP/rai-robotModels/panda/panda_arm_hand.urdf](rai/test/newLGP/rai-robotModels/panda/panda_arm_hand.urdf#L31-L222)
- EE frame：
  - [rai/test/newLGP/rai-robotModels/panda/panda.g](rai/test/newLGP/rai-robotModels/panda/panda.g#L55)

## 8.2 动态 manipulability 额外需要

1. 质量矩阵 $M(q)$（可由动力学参数计算）
2. 连杆质量/惯量参数

本地现状：**也有基础数据**（`mass`/`inertia`）。

- [rai/test/newLGP/rai-robotModels/panda/panda_clean.g](rai/test/newLGP/rai-robotModels/panda/panda_clean.g#L3-L20)

## 8.3 查找优先级建议

1. 先看当前运行实际使用的模型文件 `panda.g`（可能覆盖默认限位，如 joint6）。
   - [rai/test/newLGP/rai-robotModels/panda/panda.g](rai/test/newLGP/rai-robotModels/panda/panda.g#L40)
2. 再核对 `panda_clean.g` 的基础连杆和 limits。
   - [rai/test/newLGP/rai-robotModels/panda/panda_clean.g](rai/test/newLGP/rai-robotModels/panda/panda_clean.g#L3-L20)
3. 最后用 URDF 做来源一致性检查。
   - [rai/test/newLGP/rai-robotModels/panda/panda_arm_hand.urdf](rai/test/newLGP/rai-robotModels/panda/panda_arm_hand.urdf#L31-L222)

---

## 9. dynamic vs 静态 manipulability：应用与数学差异

## 9.1 概念差异

1. **静态 manipulability（kinematic）**
   - 问题：在给定关节速度范数约束下，末端速度能多“灵活”地分布到各方向。
   - 只看 Jacobian，不看质量与力矩上限。

2. **动态 manipulability（dynamic）**
   - 问题：在给定关节力矩约束下，末端加速度（或力）能多“灵活”地分布到各方向。
   - 需要动力学矩阵，考虑质量/惯量耦合。

## 9.2 数学差异（常见形式）

### 静态（速度域）

关节速度与末端速度：

$$
\dot{x}=J(q)\dot{q}
$$

若约束 $\|\dot{q}\|\le 1$，则末端速度椭球为：

$$
\dot{x}^\top (JJ^\top)^{-1} \dot{x} \le 1
$$

Yoshikawa 指标：

$$
w_s(q)=\sqrt{\det(JJ^\top)}
$$

### 动态（加速度域，常见推导）

机器人动力学：

$$
M(q)\ddot{q}+C(q,\dot{q})\dot{q}+g(q)=\tau
$$

忽略非线性项用于指标近似时，

$$
\ddot{x} \approx J M^{-1} \tau
$$

若 $\|\tau\|\le 1$，得到动态可操作性椭球；对应体积型指标常写为：

$$
w_d(q)=\sqrt{\det\big(J M^{-1} M^{-\top} J^\top\big)}
$$

（不同文献在范数约束与是否含阻尼/任务映射上会有等价变体。）

## 9.3 应用差异

1. **静态适用**
   - 任务优先级排序、抓取候选预筛、实时性要求高场景；
   - 优点：实现简单、计算快、对模型要求低。

2. **动态适用**
   - 高速操作、力控主导、强动态过程（加速度/力能力关键）；
   - 优点：更贴近真实动力学能力；
   - 代价：参数敏感、实现与计算复杂度高。

## 9.4 对当前任务（TASK-018）的建议

MVP 先用静态是正确路径：

- 文档已明确 Jacobian 路线和动态 out-of-scope：
  - [docs/ops/MANIPULABILITY_MVP_REQUIREMENTS_2026-03-25.md](docs/ops/MANIPULABILITY_MVP_REQUIREMENTS_2026-03-25.md#L72-L73)

---

## 10. 风险与预检查建议

1. **模型 include 路径风险**
   - 当前 `unnamed.g` 和 `generated/scene/scene_named.g` 里是历史绝对路径 `/home/leslie/...`：
     - [unnamed.g](unnamed.g#L14)
     - [generated/scene/scene_named.g](generated/scene/scene_named.g#L14)
   - 在 macOS 本地若该路径不存在，需确保运行前由流程正确归一化或改为本机有效路径。

2. **joint6 limits 覆盖风险**
   - `panda_clean.g` 与 `panda.g` 对 joint6 限位不完全一致（`panda.g`有覆盖编辑）。
   - 做排序测试时要明确“实际加载后生效的 limits”。

3. **unknown 尾部策略必须可审计**
   - `score invalid / score<threshold` 的原因必须写入 sidecar。

---

## 11. 最小测试 Definition of Done（单功能版本）

1. 仅在 feasible 集合上完成 manipulability 评分；
2. 生成 `generated/ordering_score_report.json`；
3. unknown 阈值策略生效且可追踪；
4. 不破坏现有 `phase0_layout.json` / `infeasible_objects.json` 对外契约；
5. 重复运行排序稳定。

---

## 12. 本报告对用户问题的直接回答

1. **需要哪些输入？**  
   `unnamed.g`（场景+机器人）、reachability 结果（feasible 集）、`tau_m`，以及机器人模型（Panda）。

2. **需要 Franka 参数吗？**  
   需要。静态至少要运动学和关节限位；动态还要质量/惯量。

3. **本地是否有？去哪里找？**  
   有。优先查 `panda.g`、`panda_clean.g`、`panda_arm_hand.urdf`：
   - [rai/test/newLGP/rai-robotModels/panda/panda.g](rai/test/newLGP/rai-robotModels/panda/panda.g)
   - [rai/test/newLGP/rai-robotModels/panda/panda_clean.g](rai/test/newLGP/rai-robotModels/panda/panda_clean.g)
   - [rai/test/newLGP/rai-robotModels/panda/panda_arm_hand.urdf](rai/test/newLGP/rai-robotModels/panda/panda_arm_hand.urdf)

4. **dynamic 与静态区别？**  
   静态看 $J$（速度能力），动态看 $J+M$（加速度/力能力）。当前 TASK-018 先做静态是正确且文档已锁定。
