# Planar Experiment 设计与 FMB 适配分析报告

- 日期: 2026-03-21
- 任务对应: `docs/roadmap.md` 中 `[TASK-014] Design Planar Experiments`
- 分析范围: FMB benchmark 任务适配、无摄像头真机必要性、部署与最小化资源下载策略

## 0. 执行结论（先看）

1. FMB 很适合作为你当前 planar 实验的外部 benchmark 参考，尤其适合评估 `pick -> reorient/fixture -> place/insert` 的阶段稳定性与跨形状泛化。
2. 对你当前 VLM-LGP 最有价值的不是整套大数据集复现，而是采用 FMB 的任务定义与成功判据，做一个轻量化的“协议对齐实验套件”。
3. FMB 官方公开的物体/夹具资产以 `.step` 为主，不是以 `.obj` 为主；你当前系统可继续使用 `.obj` 网格方式，但需要做一次 CAD 到 mesh 的离线转换与尺度校准。
4. 在“无摄像头”条件下，仍然有必要做真机实验: 可验证几何-动力学闭环、接触鲁棒性、执行器误差容忍度，这些是纯仿真无法充分覆盖的。
5. 若目标是最轻量化: 不需要下载 FMB 的 545GB/70-86GB 轨迹数据集；仅需下载少量 CAD（`*.step`）、参考文档与评测协议，外加你本地的场景配置与标定文件。

## 1. 你当前系统与 FMB 的结构匹配度

## 1.1 当前系统关键特征（与本任务直接相关）

- 你当前场景已经是显式几何建模 + 锚点化放置范式。
- `generated/scene/scene_named.g` 中:
  - 三棱柱 `tri_1` 使用 `shape:mesh` 且 `mesh:".../generated/triangular_prism.obj"`。
  - 已定义可复用的放置锚点集合（`Base_*`, `Table_Left/Right`, `Rect_N_Left/Right`）。
- Phase0 已支持不依赖 VLM 的直接几何管线（`pipeline/run_phase0.py` 中 `RULE_DIRECT_G`，`use_vlm=True` 也会被忽略并退化为直接几何模式）。

这意味着: 你的 pipeline 在“无视觉输入”前提下，已经具备执行结构化 planar task 的技术底座。

## 1.2 FMB 可借鉴的核心价值

FMB 官方评测流程给出了清晰的任务分解与成功判据，包括:

- `Grasp`
- `Rotate`
- `Place on fixture`
- `Regrasp`
- `Insert`
- `Single-Object Multi-Stage`
- `Multi-Object Multi-Stage`

这些任务天然对应你的 LGP+KOMO 多阶段动作链，且能覆盖:

- 形状差异（box/cylinder/prism 等）
- 姿态变化与重抓取
- 接触驱动任务（fixture/insert）
- 长时序多目标任务

## 1.3 适用性结论

- 适用: 作为“任务协议与评测标准”高度适用。
- 部分适用: 作为“数据驱动训练集”对你当前阶段不必要（体量过大、范式不匹配）。
- 不建议直接照搬: FMB 的完整相机栈与数据采集基础设施，不应成为当前首阶段阻塞项。

## 2. 如何选 FMB 任务并适配你的 topic（Planar + VLM-LGP）

建议采用“3层实验包”，优先保证能突出你系统已有创新点。

## 2.1 L1: Primitive 层（快速对齐）

1. `Grasp`（等价你当前 `action_pick` 稳定性评测）
2. `Place on fixture`（等价受约束放置）
3. `Rotate` 或 `Regrasp`（二选一，建议先 `Regrasp`）

目的:

- 快速建立 FMB 协议兼容的 success rate 指标
- 直接测出不同形状对 `pick` 质量的影响

## 2.2 L2: Single-Object Multi-Stage

流程建议:

- `pick -> reorient/fixture -> place/insert`

目的:

- 体现你的分阶段约束设计能力（阶段目标切换、碰撞约束激活策略）
- 体现在单对象长链任务上的鲁棒性

## 2.3 L3: Multi-Object Multi-Stage（核心对比）

流程建议:

- 2-4 对象的小规模装配开始，逐步升到 5+ 对象

目的:

- 突出你系统“多对象序列决策 + 运动可行性联动”的特点
- 检验 branch-aware 策略在复杂接触场景下的增益

## 2.4 映射到你项目亮点（必须在报告中强调）

FMB 任务可直接体现你系统以下特点:

1. 任务-运动一体化: 符号层动作链到 KOMO 连续优化的闭环。
2. 约束分层激活: waypoint 与 full-motion 两模式下约束激活策略差异。
3. 几何一致性: 以 `.g` 场景与显式 frame 锚点保证任务定义可复现实验。
4. 多物体接触鲁棒性: 在密集场景中处理抓取、放置、避障与稳定接触。

## 3. 无摄像头真机实验是否有必要

结论: 有必要，且应做“弱视觉/无视觉”对照组，而非完全跳过。

## 3.1 必要性

1. 验证仿真到真机落差:
- 接触摩擦、微小形变、夹爪回程误差、关节跟踪误差等在真机显著存在。

2. 验证约束设计真实有效:
- 你当前大量工作在约束设计与激活逻辑上，这些改动必须经真机闭环验证才有说服力。

3. 形成论文/报告中“工程可落地”证据:
- 即使不用相机，固定工装+已知初始位姿也可验证 planner 执行价值。

## 3.2 无摄像头条件下可行策略

- 采用固定工装 + 固定初始位姿 + 人工复位。
- 使用已知 frame（而非在线视觉）作为目标与对象初始估计。
- 每个 trial 结束后记录:
  - 成功/失败
  - 失败类型（抓取滑脱、碰撞、插入失败、姿态偏差）
  - 轨迹耗时与重试次数

## 3.3 何时可以暂不做真机

ASSUMPTION:
当前短期目标是先完成算法迭代闭环与可复现实验基线，而非对外发布硬件指标。

在此假设下，可先完成仿真基线 + 少量真机 spot-check（例如每任务 10-20 次），不必立刻大规模真机采样。

## 4. 部署问题回答: 资产格式、marker、tri-prism 复用性

## 4.1 FMB 是不是 `obj`?

不是主路径。FMB 材料页公开的是 CAD `*.step` 资产（board、peg、fixture、camera mount 等），数据集是 `*.npy` 轨迹包。

因此实际工程路径通常是:

- 下载 `step`
- 本地转换为仿真/渲染所需 mesh（`obj/stl/...`）
- 在场景文件中定义 frame、碰撞体与放置目标

## 4.2 “下载模型后按当前位置放几个 marker 就好”是否成立?

部分成立，但要补充两个关键点:

1. `marker` 只解决定位锚点，不自动解决尺度、惯量、接触参数。
2. 还必须补齐:
- 尺度一致性（mm/m）
- 质心/惯量近似
- 碰撞几何简化（必要时）
- 基座与工装 frame 的刚体关系

你当前 `.g` 中大量“ghost patch”本质是非接触锚点 frame（`contact:0`），可类比 marker 作用，但更偏运动规划语义锚点。

## 4.3 tri prism 的当前部署方式能否复用到 FMB?

可以复用，结论是“方法可迁移”。

你当前 `tri_1` 已是:

- `shape:mesh`
- 外部 mesh 路径绑定
- 配套放置锚点体系已存在

这正是将 FMB `step -> obj` 后接入同类对象的标准路径。

## 4.4 推荐部署范式（最小改造）

1. CAD 转换: `*.step -> *.obj`（保留统一单位）
2. 场景接入: 在 `.g` 新增对象 frame，指定 `shape:mesh` 与 `mesh` 路径
3. 语义锚点: 为 board/hole/fixture 建立 `is_place` 锚点 frame
4. 任务映射: 将 FMB primitive 映射到你现有 `pick/place/regrasp/insert` 动作模板
5. 校准: 首次只做单对象，验证尺度与接触参数后再扩任务

## 5. 文件包很大: 我们到底需要什么

## 5.1 不需要什么

- 不需要下载 FMB 全量轨迹数据集（545GB / 70-86GB）来做当前 planner benchmark 适配。

## 5.2 最小必需集

1. 任务协议文档（网页 procedure + usage）
2. 目标 CAD 资产（`*.step`）
3. 形状/颜色编号参考表（用于任务定义一致性）

可选:

- 官方 robot infra 代码（只在你要复现其控制栈时需要）

## 5.3 如果只要 obj，如何最轻量化下载

1. 只下载你计划第一阶段使用的 1-2 个 board + 少量 peg/fixture 的 `step` 文件。
2. 本地离线批量转 `obj`（不下载任何大体量 `npy` 数据）。
3. 将转换后的 `obj` 放到项目资产目录（建议 `assets/fmb/meshes/`）。
4. 仅保留:
- `obj` mesh
- 对应尺寸/单位说明
- 任务定义 JSON（对象ID、目标孔位、容差）

这样可以把外部依赖压到 MB~百MB 级别，而不是百GB级。

## 6. 详细任务拆解（可执行）

## 6.1 Phase A: 协议对齐（1-2 天）

1. 固化任务子集: `Grasp + Place on fixture + Single-Object Multi-Stage`。
2. 为每个任务写成功判据与失败标签。
3. 在 `docs/ops/` 新建评测记录模板（每 trial 一行）。

交付物:

- `planar_exp_task_spec.json`（任务定义）
- `planar_exp_eval_protocol.md`（判据）

## 6.2 Phase B: 资产接入（1-2 天）

1. 下载最小 `step` 资产。
2. 转 `obj` 并做单位校验。
3. 在 `.g` 中增加对象与 board/fixture frame。
4. 新增对应 `is_place` 锚点。

交付物:

- `assets/fmb/meshes/*.obj`
- 新 `generated/scene/*.g` 变体

## 6.3 Phase C: Planner 适配（2-4 天）

1. 建立 primitive 到动作模板映射。
2. 增加 insertion/fixture 对应动作脚本。
3. 打通小规模端到端任务。

交付物:

- 可复现脚本
- 任务运行日志与失败分类

## 6.4 Phase D: 实验执行（2-5 天）

1. 仿真批测（先跑满）。
2. 无摄像头真机 spot-check。
3. 汇总成功率、耗时、失败分布。

交付物:

- 对比表（仿真 vs 真机）
- 核心失败案例复盘

## 7. 风险与控制

1. 资产尺度错配风险:
- 控制: 第一个对象先做单体抓取+放置烟测。

2. 插入任务接触不稳定风险:
- 控制: 优先调接近阶段和最终对齐阶段的分段约束，不一次性硬锁全部约束。

3. 无视觉初始误差累积风险:
- 控制: 采用工装限位 + 人工复位 SOP，并记录偏差范围。

4. 任务范围膨胀风险:
- 控制: 先完成 L1/L2，再扩 L3，不直接上全套多对象长时序。

## 8. 建议的第一批实验组合（立即可执行）

1. E1: `tri_1` + fixture 放置（20 trials）
2. E2: `cube_*` single-object multi-stage（20 trials）
3. E3: `rect + cube` 双对象短链任务（10-20 trials）

优先目标:

- 用最小实验成本验证你当前 `action_pick` 与分阶段 place 策略的鲁棒性。
- 在不引入相机依赖的前提下，先完成一轮真机可执行性证据。

## 9. 与本项目现状的一致性结论

- 本报告不要求修改 Layer 0-3 的系统定义，仅是对 `[TASK-014]` 的实验设计深化。
- 与当前“以仿真为主、逐步真机验证”的状态兼容。
- 下一步可直接进入资产最小集接入与实验脚本化。
