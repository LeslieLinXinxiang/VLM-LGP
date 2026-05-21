# Layer 4: Project Roadmap & Task Tracker

## 1. Current Active Tasks (Timeline Log)

1. ### [TASK-030] Baseline MoveIt MVP Implementation & Cube Evaluation

* **Status**: `[In Progress]`
* **Created**: 2026-05-06 12:00
* **Completed**: N/A
* **Timeline**:
  * *2026-05-06 12:00*: 基于 TASK-029 概念，具体实现单阶段零样本 MoveIt Baseline（VLM 输出高层语义目标 → MoveIt 负责 IK/碰撞/轨迹生成）。决策理由：遵循 Ioan Sucan 语义/几何解耦哲学，避免 baseline 虚弱指控。
  * *2026-05-06 12:00*: 交付物 1: Prompt `baseline_visual_planner_moveit_action10_v1.md`，明确坐标系（原点=机械臂底座，无表面高度偏移），每个动作固定 10 个路点（笛卡尔锚点）。
  * *2026-05-06 12:00*: 交付物 2: 评测脚本 `experiments/scripts/run_baseline_moveit_eval.py`，支持批量运行 4 个场景类型，输出格式兼容既有 `evaluations/VLM/` 结构。
  * *2026-05-06 12:00*: 启动 Cube cubeStacking 全量评测（`--trials 1` 模式；支持断点续传）。
  * *2026-05-06 12:00*: 生成对标文档 `docs/ops/BASELINE_REDESIGN_ALIGNMENT_REPORT_20260506.md`，明确与 TASK-029 的对齐与偏差。
  * *2026-05-06 12:00*: 下一步 P0：完成 Cube 批量收集，编写 `parse_baseline_output.py` 自动提取合规率/Z轴误差/路点计数，生成汇总表。

2. ### [TASK-029] Baseline 对照组重设计 — 两阶段 VLM + R&M 评估框架

* **Status**: `[Dependent: TASK-030 MVP in progress]`
* **Created**: 2026-04-27 18:28
* **Completed**: N/A
* **Timeline**:
  * *2026-04-27 18:28*: 识别现有 Pure LLM Baseline 的根本性缺陷：仅评估拓扑正确率，未引入 Manipulability 和 Reachability 约束，导致 Baseline 正确率虚高（96%-100%），无法与实验组拉开有效差距。
  * *2026-04-27 18:28*: 完成实验重设计方案：采用两阶段 VLM Pipeline（Prompt 1 = 感知 & R&M 排序，Prompt 2 = 基于约束的规划），并以现有 R&M 模块输出作为客观 Ground Truth。
  * *2026-04-27 18:28*: 锁定三维评分体系：Perception Score (Kendall's τ)、Reachability Score (Precision/Recall)、Planning Score (物理合法性检查)。
  * *2026-04-27 18:28*: 完整执行方案已写入 `docs/ops/TASK-029_BASELINE_REDESIGN_EXECUTION_PLAN.md`。
  * *2026-05-06 12:00*: TASK-030 作为 TASK-029 概念的具体工程实现已启动；TASK-029 高层评分逻辑（Kendall's τ/Precision-Recall）可在 TASK-030 MVP 完成后融合引入。

2. ### [TASK-028] Formal Experiment Design and Execution Kickoff

* **Status**: `[In Progress]`
* **Created**: 2026-04-22 20:59
* **Completed**: N/A
* **Timeline**:
  * *2026-04-22 20:59*: Task created to start formal FMB + Cube comparative experiment design and execution after input freeze closure.
  * *2026-04-22 20:59*: Entry criteria confirmed: Cube input design completed, FMB input design completed, and input freeze gate marked ready.
  * *2026-04-22 20:59*: Next-day execution plan locked: finalize matrix manifest, run batch execution, validate logs, and aggregate first formal summary tables.
  * *2026-04-23 16:54*: Completed Phase1 prompt stabilization loop for cube-stacking support-graph parsing; converged from pixel/absolute-size variants to relative-comparison classification (`Cube`/`Rectangular Prism`/`Long Rectangular Prism`/`Triangular Prism`) with improved robustness across Gemini/Qwen manual checks.
  * *2026-04-23 16:54*: Added strict anti-hallucination edge policy in test prompt: direct supporter must satisfy both x-overlap and y-near-contact, and multi-candidate cases keep only nearest touching lower layer to avoid cross-layer false supporters.
  * *2026-04-23 16:54*: Refactored test prompt to original stable skeleton (observation-first, strict output sections, position policy, final sanity checks) while preserving relative long-rectangle labeling needed by current experiments.
  * *2026-04-27 18:28*: 确认当前 Pure LLM Baseline 正确率评测存在根本性设计缺陷（见 TASK-029），决定将 Baseline 重设计列为本任务的前置阻塞项，TASK-028 正式实验汇总将在 TASK-029 完成后继续。


## 2. Completed Tasks Rolling Archive (Max 50)

> **Rule**: When adding the 51st item, delete the oldest item to prevent context poisoning. Summarize tasks in 1-2 lines. All timestamps MUST use `YYYY-MM-DD HH:MM` format.

1. **[TASK-027] Slot Canonicalization and Placement Validation (2026-04-22 20:59)**: Closed for this freeze cycle after aligning Cube/FMB slot naming and placement references sufficiently for formal experiment kickoff; remaining fine-grained mismatches will be tracked as execution-time issues.

2. **[TASK-026] FMB Input Image Freeze Pack (2026-04-22 20:59)**: Closed after finishing FMB input image design/freeze packaging for single-image-per-scenario protocol and locking mapping readiness for manifest-driven runs.

3. **[TASK-025] Experiment Input Freeze and Dataset Lock (2026-04-22 20:59)**: Closed after completing both Cube and FMB input freeze milestones and confirming transition readiness to formal experiment design/execution.

4. **[TASK-024] Layer-Based Graph Clustering Refinement (2026-04-20 14:27)**: Closed after completing source-priority branch assignment, layer-aware pair-chunk execution policy, and deterministic integration into Phase2 default path. Path mapping: implementation `core/graph_clustering.py` (`BranchAwareLayerCuttingClustering`), integration `pipeline/run_phase2.py`, test harness `test/layer_based_clustering/run_layer_based_codegen.py`, regression tests `test/layer_based_clustering/test_batch_distribution.py` + `test/layer_based_clustering/test_batch_level_codegen.py` + `test/layer_based_clustering/test_mainline_reachability_manipulability_lgp.py`, generated artifacts `generated/layer_based_policy_run/` + `generated/layer_based_policy_run_batch/` + `generated/layer_based_batch_distribution_test/`, execution report `docs/ops/TASK-024_LAYER_BASED_GRAPH_CLUSTERING_EXECUTION_REPORT_2026-04-14.md`.

5. **[TASK-023] FMB VLM Recognition and Cognition Integration (2026-04-14 16:10)**: Closed after FMB prompt/image-batch validation; established single-image protocol and accuracy evaluation workflow.

6. **[TASK-022] Reachability 1D Self-Motion Adaptation Study for Franka (2026-04-03 18:02)**: Closed per advisor decision: the Franka self-motion reachability adaptation line will not be included in the current paper, because over-emphasizing this direction may attract unnecessary reviewer attention and distract from the main manuscript contribution.
7. **[TASK-017] RA-L Method Section Refinement Governance Setup (2026-04-03 17:47)**: Closed the RA-L method-section refinement cycle by locking final terminology to the flowchart, restructuring Method into Task Decomposition + Scene Grounding + Execution-Order Embedding, adding standalone reachability/manipulability paragraphs, and aligning governance docs with the finalized manuscript story.
8. **[TASK-006] MuJoCo Simulation Debug Loop Integration (2026-04-02 15:50)**: Closed with root-cause confirmation that TCP residual error mainly comes from steady-state PD servo bias under gravity in MuJoCo general actuators, plus delivered gain scan automation in `Mujoco_Simulation/auto_gainprm_tune.py`. Keywords: steady-state error, `gainprm/biasprm` coupling, `kp-kd` sweep, Jacobian-level TCP error attribution, gravity feedforward recommendation.
9. **[TASK-021] Native LGP Waypoint Reachability + Manipulability Coupling (2026-03-30 21:30)**: Completed pipeline integration of LGP kinematic waypoint hard gate with Jacobian manipulability screening, isolated explicit collision reduction (~15x solver speedup), and fully verified script execution logic up to LGP TAMP solver.
10. **[TASK-018] Manipulability-First Execution Ordering (2026-03-26 12:43)**: Completed URDF-only static manipulability implementation, reporting, and visualization verification on `dev/manipulability`. Follow-up note kept: future priority policy may fuse TASK-019 reachability parameters with TASK-018 manipulability parameters.
11. **[TASK-019] Differentiable Reachability Heatmap (GMM + ESDF) (2026-03-29 20:49)**: close the req, turn to solve IK using the original LGP first layer(FCL+libccb)
12. **[TASK-020] Academic Graph Clustering Upgrade (2026-03-26 16:05)**: Finalized provenance-driven clustering and unified scheduling by removing no-merge fallback splitting; validated consistent behavior across three-branch, pyramid, and 3x5 benchmarks with solver-facing `step_*.fol/.lgp` generation.
13. **[TASK-014] Planar Assembly Experiment (2026-03-21 13:10)**: Successfully designed and executed planar assembly tasks using FMB assets. Implemented mesh-aware Z-height calculation and eccentric grasping with handle markers. Verified end-to-end chained planning.
14. **[TASK-016] Validate layer-aware cutting on the Phase1 support graph (2026-03-25 12:05)**: Closed without further execution; this validation track is superseded by the upcoming k-means clustering direction.
15. **[TASK-015] Update Document & flowchart (2026-03-21 13:23)**: Completed update of documentation and flowchart to align with current pipeline, including mesh-aware height and active constraint strategy descriptions.
16. **[TASK-013] Replace VLM Euclidean distance judgment with backend `.g` scene parser (2026-03-20 15:30)**: Goal: compute object Euclidean distances directly from `.g` geometry in backend to remove VLM geometric estimation noise and improve consistency of proximity decisions. Acceptance: backend distance API returns deterministic pair distances and the current strategy layer consumes parser output as source of truth.
17. **[TASK-014] Planar Assembly Experiment (2026-03-21 13:10)**: Successfully designed and executed planar assembly tasks using FMB assets. Implemented mesh-aware Z-height calculation and eccentric grasping with handle markers. Verified end-to-end chained planning.
18. **[TASK-016] Validate layer-aware cutting on the Phase1 support graph (2026-03-25 12:05)**: Closed without further execution; this validation track is superseded by the upcoming k-means clustering direction.
19. **[TASK-013] Replace VLM Euclidean distance judgment with backend `.g` scene parser (2026-03-20 15:30)**: Goal: compute object Euclidean distances directly from `.g` geometry in backend to remove VLM geometric estimation noise and improve consistency of proximity decisions. Acceptance: backend distance API returns deterministic pair distances and the current strategy layer consumes parser output as source of truth.
20. **[TASK-012] Multi-Support Hovering Fix (2026-03-20 15:30)**: Updated `action_place_on_multi_support` to use `virtualAnchorName` for hover and placement constraints. Verified through compilation and static checks. Pending runtime validation.
21. **[TASK-011] Introduce graph clustering to replace VLM strategy generation/decision (2026-03-20 14:05)**: Implemented `BranchAwareClustering` in `core/graph_clustering.py`, integrated into `pipeline/run_phase2.py` for deterministic strategy generation, and added `docs/clustering_algorithm_report.md`. Also fixed inventory binding to eliminate object-naming hallucinations.
22. **[TASK-010] Active Constraint Set Optimization for TAMP Solver Acceleration (2026-03-19 21:10)**: Closed after stabilizing `action_pick` / `action_place_straightOn` staging, fixing motif same-slice conflicts via `stepsPerPhase>=10` gating, and finalizing place orientation target (`+90deg`, b-face forward). End-to-end `active_coll_test/node_1_run` now runs successfully after final user-side code adjustments.
23. **[TASK-007] Reachability Detection for Pick Waypoints (2026-03-17 14:48)**: Completed waypoint reachability runner + trajectory-log pipeline, added minimal recovery/near-far/obstacle scenes, validated replay workflow, and closed reachability branch as an independent milestone.
24. **[TASK-009] Refine Paper — Synchronize Latest Workflow and Innovation Points (2026-03-14 17:15)**: Synced the latest system pipeline state, Active Constraint Strategy, Waypoint-Gated Reachability, and parameterized Shape-Aware Grasping into the academic manuscript `paper/VLM_LGP_Assembly_260314.tex`.
25. **[TASK-008] Document `paper/` directory and add to DDE Protocol (2026-03-14 12:38)**: Registered the `paper/` academic manuscript directory as a formal module within Layer 0-3 DDE documentation. Added `paper_documentation.md` spec and updated `project_charter.md` and `architecture.md`.
26. **[TASK-004] Planar Arrangement Prompt Refinement (2026-03-12 22:24)**: Completed Phase0 -> Phase2 runtime debugging and VLM stabilization, including Phase1 DAG prompt hardening, end-to-end validation closure, and documented Phase0 VLM I/O contracts.
27. **[TASK-005] Phase0 Patch Naming Injection Completion (2026-03-12 22:42)**: Completed Phase0 automatic patch naming injection for `Rect_N_Left/Right` and verified naming consistency/preservation across `generated/scene_named.g`, `generated/scene/unnamed.g`, and `generated/scene/scene_named.g`.
28. **[TASK-003] Constraint Cleanup in manipTools.cpp (2026-03-09 13:35)**: Removed overlapping soft `OT_sos` constraints in pick and place sequences to prevent solver stalling.
29. **[TASK-002] Multi-Support Hovering Fix (2026-03-08 14:30)**: Replaced absolute Z `getSize()(0)` with relative `FS_positionDiff` and fixed XY alignment in `action_place_on_multi_support`.
30. **[TASK-001] DDE-Bootstrap Setup (2026-03-08 15:22)**: Generated Layer 0-4 Documentation-Driven Engineering protocol to prevent hallucination.

## 3. Pending Backlog

Pending backlog entries are currently tracked in issue discussions and will be re-listed here when reprioritized into executable task IDs.
