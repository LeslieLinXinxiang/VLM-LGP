# Method 部分诊断报告与执行计划 (2026-07-05)

本报告不改动 `bare_jrnl.tex`，只做诊断和排期，供确认后再逐句改写。

## 1. 结论先行

`bare_jrnl.tex` 里其实有**两份 Method**：

- 第一份（175-218 行）：导师新定的骨架，三个 component，每个 component 下两个
  subsubsection，都标了 `Input:` / `Output:`，但正文是空的（只有红字提示）。
- 第二份（240-576 行，在 `\newpage` 之后）：旧内容，写得很完整，公式、机制都有，
  但组织方式是导师说的"看不懂"的那种（Preliminaries + 6个不对齐的 subsection）。

**核心任务不是重新发明方法，而是把第二份的内容按第一份的骨架重新切开、按
Input/Output 的方式重述。** 内容基本是够的，只有 2-3 处真正的缺口（见第4节）。

我对照了 `core/`、`test/manipulability/`、`docs/` 里的实现代码，第二份 Method
里的公式/机制描述和代码基本一致（细节见第2节），可以放心作为事实基础，不需要
猜测。

## 2. 代码库核对结果（写作的事实基础）

| 论文里的机制 | 对应代码 | 核对结果 |
|---|---|---|
| VLM 生成 support graph $\mathcal{G}=(\mathcal{V},\mathcal{E})$ | `core/vlm.py`, `prompts/phase1_*.md` | 一致 |
| Branch-based cutting + Layer-based cutting | `core/graph_clustering.py`: `BranchAwareClustering` (层号+branch) 和 `BranchAwareLayerCuttingClustering` (`max_batch_size=2`) | 一致，且证实**是两层**（branch 在先，layer 在后），但 `bare_jrnl.tex` 现在只写了"Layer-Based Clustering"一个标题，把 branch 分组塞进了 Step 2 里，没有单独成节 |
| Reachability: GMM 密度分数 + ESDF 间隙分数 | `core/reachability_field.py`：`_build_gmm_scores`(σ=0.12)，`_build_esdf_scores`(d_max=0.20)，`alpha=0.6, beta=0.4, tau_r=0.45` | 参数、公式与 tex 完全一致 |
| Pick-waypoint 可行性二次校验 (KOMO) | `bin/pick_waypoint_check.cpp` | 存在，一致 |
| Manipulability-Aware Ordering (Yoshikawa, DLS-IK) | `test/manipulability/urdf_static_manipulability.py`（`m = sqrt(det(J J^T))`），被 `pipeline/run_phase0.py`、`driver_gemini_mainline.py` 调用 | 一致，**是当前实际使用的排序方式** |
| Selective LGP + Active Constraint | `docs/architecture.md` 提到的 "Active Collision Whitelisting"（避免 EPA 瓶颈，~15x 提速） | 逻辑一致，tex 里的 active-constraint 公式与架构文档描述吻合 |
| Real Robot Execution | `core/ros2_bridge.py`：通过 ROS2 `FollowJointTrajectory` action 发送**关节位置轨迹**，夹爪是开合状态机 | **与导师骨架里写的 "Joint-Space Impedance Control" 不符**，见第4节问题1 |

另外 `docs/PAPER_CN_PRELIM_METHOD_20260323.md`（师兄或你之前写的中文逐字稿）里，
物体排序用的是"按到机器人基座的欧氏距离排序"，与 `bare_jrnl.tex` 里的 Yoshikawa
manipulability 排序是**两套不同方案**。代码证实 manipulability 是当前主线在用的
（`pipeline/run_phase0.py` 直接调用），欧氏距离那版看起来是更早的草稿，已被替代。
写作时应以 manipulability 版本为准，但这是我从代码推断的，建议跟师兄确认一下。

## 3. 新旧 Method 骨架对应表

导师骨架（第一份 Method，175-218行）→ 旧内容（第二份 Method，240-576行）：

| 新骨架 subsubsection | Input → Output（导师原文标注） | 对应旧内容 |
|---|---|---|
| 3.1.1 VLM for Assembly Graph Generation | Image → Graph | §"VLM Graph Generation" (263-299行) |
| 3.1.2 Graph Decomposition and Clustering | Graph → Short-horizon action plans | §"Task Decomposition via Layer-Based Clustering" (321-380行)，**但代码显示这里其实是两步**（Branch-Based Cutting 见第2节，再 Layer-Based Cutting），中文逐字稿里也是分两节写的 |
| 3.2.1 Reachability Filtering | Scene Info → 可达物体列表 | §"Stage 1a: Geometric Prior Scoring" + "Stage 1b: Pick-Waypoint Feasibility Check" (391-446行) |
| 3.2.2 Manipulability-Aware Object Ordering | 可达列表 → 按 manipulability 排序的列表 | §"Manipulability-Aware Ordering" (448-464行) |
| 3.3.1 LGP with Active Constraints | Action Plans + Object List → 带 active constraint 的 LGP 优化 | §"Selective LGP Solving with Active Constraints" (482-567行) |
| 3.3.2 Motion Execution with Joint-Space Impedance Control | Trajectories → 关节力矩的 impedance control | §"Real Robot Execution" (569-576行)，**内容对不上标题，见问题1** |

**没有明确归属的一块**：§"Execution-Order Embedding" (466-479行) ——这是把
Task Decomposition 产出的"结构槽位"（比如"在 cube_1 上放一个 box 类物体"）和
Scene Grounding 产出的"按类型排好序的可达物体列表"绑定起来的步骤。它是两条并行
流（VLM 流 + Scene 流）的合并点，逻辑上不属于 3.1 也不完全属于 3.2，在导师给的
六个 subsubsection 里找不到位置。这是一个需要你决定怎么放的结构性问题（见问题2）。

## 4. 需要你确认的问题（这些我没有替你决定）

1. **"Joint-Space Impedance Control" 这个标题和实际实现不符。**
   代码里机器人执行用的是 `FollowJointTrajectory`（关节位置轨迹跟踪），
   `core/ros2_bridge.py` 里没有任何 impedance/力控相关代码，仓库里也搜不到
   impedance 字样。三种可能：(a) 导师笔误或对方法有更高期待，实际按目前位置
   控制来写，把标题改成符合实际的说法；(b) Franka 机械臂的位置控制器底层默认
   走 joint impedance regulation（libfranka 的常见事实），如果这是导师的本意，
   可以在文中提一句作为物理层背景，但不能说是"本文方法"的一部分；(c) 这是未来
   要做但还没做的部分。**这个需要你确认导师的本意，不然我没法替你写。**

2. **Execution-Order Embedding 放哪里？** 三个选项：
   - 并入 3.2（Scene Understanding）作为第三个 subsubsection（但导师骨架明确
     写的是"两个 subsubsection"）；
   - 并入 3.3（LGP 部分）作为"grounding batch to solver input"的前置步骤；
   - 作为独立的过渡段落，写在 3.2 和 3.3 之间，不算进小节编号里，只用一段话
     说明两条流如何合并。
   我倾向最后一种（最贴合导师说的"讲清楚每部分输入输出"，因为这一步的
   输入输出本来就是"合并"而不是"生成"），但由你定。

3. **Branch-Based Cutting 要不要单独成段？** 代码和中文逐字稿都证实这是
   两层算法（先分 branch 再分 layer），但现在 `bare_jrnl.tex` 里揉在一起写成
   "Layer-Based Clustering"的 Step 2。按导师"Input→Output讲清楚"的要求，我倾向
   拆成两句话/两个小段落分别说清楚（branch: Graph → 粗粒度 branch 分组；layer:
   branch → 可执行 batch），但仍放在同一个 3.1.2 subsubsection 里，不新增编号。

4. **Related Work 是否也要我处理？** 你说主要负责 method，但导师的反馈里
   Related Work 和 Problem Formulation 也标了 TODO。我这次没有去查论文补全
   Related Work 的引用（那是大工程，需要专门检索每个 bullet 提到的具体论文），
   如果需要我也做，请明确告诉我，我会单独开一轮处理。

## 5. Problem Formulation 需要覆盖的内容（建议骨架，未写入正文）

导师原话："先有一张图 $\mathcal{I}$ 作为输入，需要从图里确定装配目标 $\mathcal{G}$，
再用 $\mathcal{G}$ 确定任务计划 $\mathcal{P}$，然后把 $\mathcal{G}$、$\mathcal{P}$
和当前场景关联起来，确定要操作哪些物体、如何确定运动"——这段其实已经把整个
formulation 的骨架写好了，只是没有数学化。对照现在 Method 里已经用到的符号，
建议的数学骨架是：

- 输入：目标图像 $\mathcal{I}$，当前场景 $\mathcal{S}=\{o_1,\dots,o_N\}$（每个
  $o_i$ 带类别、位姿、几何信息）。
- 目标推断：$\mathcal{G}=f_{\text{VLM}}(\mathcal{I})$，$\mathcal{G}=(\mathcal{V},\mathcal{E})$
  即 object-support graph（这与现有 Preliminaries 里的定义完全一致，可以直接搬）。
- 计划生成：$\mathcal{P}=(B_1,\dots,B_T)=f_{\text{decomp}}(\mathcal{G})$，
  满足 precedence-consistency 和 batch size 约束（现有 236 行那段已经有这个定义，
  可以直接搬）。
- 场景关联（grounding）：一个绑定函数 $\phi:\mathcal{V}\to\mathcal{S}$，把
  $\mathcal{G}$ 里的结构槽位映射到 $\mathcal{S}$ 里具体的可达、且按 manipulability
  排序靠前的物体实例。
- 运动求解：对每个 $B_t$，在 $\phi(B_t)$ 上求解 LGP/KOMO 得到轨迹 $x_t^*$。
- 输出：机器人可执行、无碰撞的轨迹序列 $\{x_1^*,\dots,x_T^*\}$，使最终场景满足
  $\mathcal{G}$ 定义的目标结构。

这个骨架的好处是：现有 Preliminaries（232-238行）里已经写好的两段数学定义
（graph 定义、batch 分解定义）几乎可以整段搬过去，不用重写，只是要在前面加上
"从图像到目标图"和后面加上"grounding + 求解"两段，让整个链条完整。

## 6. 参考文献行文逻辑（供 Method 改写时借鉴）

- **R-LGP**（2310.02791）：Related Work 分两个清晰小节 "Satisfactory TAMP"
  和 "Optimal TAMP"，按解耦→集成→采样→优化的脉络组织，不是简单堆引用。Method
  部分先给一个 Algorithm box（相当于 problem overview + control flow 合一），
  再按"IV. Reachability Graph"展开两个 subsection：A. Graph generation
  （两个 subsubsection: node sampling, edge connection，各自明确输入输出和公式）
  B. Path querying（同样两个 subsubsection）。这与导师给你的"每个 subsubsection
  标 Input/Output"的要求几乎是同一种写法，可以直接照着这个粒度写。
- **SeeDo**（2410.08792）：没有数学化的 problem formulation，Method 部分直接
  按模块展开（Keyframe Selection / Visual Prompting / VLM Interpreter / Plan
  Execution），每个模块一段，先说做什么、再说怎么做、最后说输出喂给下一模块。
  Related Work 分四段："VLMs for task planning" / "VLMs for robots" /
  "Robot learning from human videos" / "VLMs for video understanding"，
  每段末尾都点出"和本文的区别"。这个可以作为 Related Work 里
  "Foundation Models in Robotic Assembly" 一节的行文模板。

## 7. 建议的执行顺序

1. 先解决第4节的开放问题（尤其问题1和问题2），因为它们会决定骨架的最终形状。
2. 按第5节骨架把 Problem Formulation 写完（内容大部分是已有材料的重新组织，
   工作量较小，且不依赖问题1/2的答案）。
3. 按第3节的对应表，把 3.1、3.2 两块先改写（这两块没有争议，可以先动笔）。
4. 3.3 两块等问题1确认后再写（尤其 3.3.2）。
5. 每次改完一段，给你看一遍确认，再继续下一段。
