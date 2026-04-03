# Layer 4: Project Roadmap & Task Tracker

## 1. Current Active Tasks (Timeline Log)

1. ### [TASK-022] Reachability 1D Self-Motion Adaptation Study for Franka

* **Status**: `[In Progress]`
* **Created**: 2026-04-02 15:50
* **Completed**: N/A
* **Timeline**:
  * *2026-04-02 15:50*: Task created to investigate whether the 7-DOF analytical arm-angle/self-motion manifold method (Shimizu et al., 2008) can be adapted to Franka for fast obstacle-induced pick infeasibility screening.
  * *2026-04-02 15:50*: Defined core objective: reduce LGP/libccd+FCL dependency in reachability prefilter by introducing a geometry-aware 1D proxy search space with collision-aware feasibility intervals.

1. ### [TASK-017] RA-L Method Section Refinement Governance Setup

* **Status**: `[In Progress]`
* **Created**: 2026-03-25 11:20
* **Completed**: N/A
* **Timeline**:
  * *2026-03-25 11:20*: Task created to support RA-L submission-oriented drafting. Scope includes: (i) per-paragraph bilingual rewrite workflow, (ii) strict terminology mapping between flowchart labels and Method headers, (iii) fixed conservative claim style profile, and (iv) mandatory logic-alignment checks against `docs/architecture.md`, `docs/dataflow.md`, and `docs/execution_protocol.md` before accepting each paragraph revision.
  * *2026-03-25 11:20*: Added process governance doc `docs/ops/PAPER_REFINEMENT_MANAGEMENT_SOP.md` to make style and logic checks reproducible across chat sessions/agents.
  * *2026-03-25 11:55*: Completed the first Method opening paragraph refinement in `paper/VLM-LGP-Assembly/bare_jrnl.tex` using Scheme A (conservative RA-L tone). Locked this paragraph as the style anchor for subsequent Method paragraph-by-paragraph updates.
  * *2026-04-03 11:34*: Added `docs/governance/PAPER_REFINEMENT_CONTENT_LOCK.md` to lock the paper-level story backbone, terminology, figure-to-text alignment, and first-paragraph global-awareness rule for the current RA-L drafting cycle.
  * *2026-04-03 11:34*: Updated `docs/ops/PAPER_REFINEMENT_MANAGEMENT_SOP.md` to reference the new content lock, expanded scope to `Preliminaries and Problem Statement`, and synchronized phase naming to `VLM-Based Support Graph Generation` -> `Two-Level Graph Decomposition` -> `Branch Clustering` / `Layer-Based Cutting`.

## 2. Completed Tasks Rolling Archive (Max 50)

> **Rule**: When adding the 51st item, delete the oldest item to prevent context poisoning. Summarize tasks in 1-2 lines. All timestamps MUST use `YYYY-MM-DD HH:MM` format.

1. **[TASK-006] MuJoCo Simulation Debug Loop Integration (2026-04-02 15:50)**: Closed with root-cause confirmation that TCP residual error mainly comes from steady-state PD servo bias under gravity in MuJoCo general actuators, plus delivered gain scan automation in `Mujoco_Simulation/auto_gainprm_tune.py`. Keywords: steady-state error, `gainprm/biasprm` coupling, `kp-kd` sweep, Jacobian-level TCP error attribution, gravity feedforward recommendation.
1. **[TASK-021] Native LGP Waypoint Reachability + Manipulability Coupling (2026-03-30 21:30)**: Completed pipeline integration of LGP kinematic waypoint hard gate with Jacobian manipulability screening, isolated explicit collision reduction (~15x solver speedup), and fully verified script execution logic up to LGP TAMP solver.
2. **[TASK-018] Manipulability-First Execution Ordering (2026-03-26 12:43)**: Completed URDF-only static manipulability implementation, reporting, and visualization verification on `dev/manipulability`. Follow-up note kept: future priority policy may fuse TASK-019 reachability parameters with TASK-018 manipulability parameters.
2. **[TASK-019] Differentiable Reachability Heatmap (GMM + ESDF) (2026-03-29 20:49)**: close the req, turn to solve IK using the original LGP first layer(FCL+libccb)
3. **[TASK-020] Academic Graph Clustering Upgrade (2026-03-26 16:05)**: Finalized provenance-driven clustering and unified scheduling by removing no-merge fallback splitting; validated consistent behavior across three-branch, pyramid, and 3x5 benchmarks with solver-facing `step_*.fol/.lgp` generation.
4. **[TASK-014] Planar Assembly Experiment (2026-03-21 13:10)**: Successfully designed and executed planar assembly tasks using FMB assets. Implemented mesh-aware Z-height calculation and eccentric grasping with handle markers. Verified end-to-end chained planning.
5. **[TASK-016] Validate layer-aware cutting on the Phase1 support graph (2026-03-25 12:05)**: Closed without further execution; this validation track is superseded by the upcoming k-means clustering direction.
6. **[TASK-015] Update Document & flowchart (2026-03-21 13:23)**: Completed update of documentation and flowchart to align with current pipeline, including mesh-aware height and active constraint strategy descriptions.
7. **[TASK-013] Replace VLM Euclidean distance judgment with backend `.g` scene parser (2026-03-20 15:30)**: Goal: compute object Euclidean distances directly from `.g` geometry in backend to remove VLM geometric estimation noise and improve consistency of proximity decisions. Acceptance: backend distance API returns deterministic pair distances and the current strategy layer consumes parser output as source of truth.
8. **[TASK-014] Planar Assembly Experiment (2026-03-21 13:10)**: Successfully designed and executed planar assembly tasks using FMB assets. Implemented mesh-aware Z-height calculation and eccentric grasping with handle markers. Verified end-to-end chained planning.
9. **[TASK-016] Validate layer-aware cutting on the Phase1 support graph (2026-03-25 12:05)**: Closed without further execution; this validation track is superseded by the upcoming k-means clustering direction.
10. **[TASK-013] Replace VLM Euclidean distance judgment with backend `.g` scene parser (2026-03-20 15:30)**: Goal: compute object Euclidean distances directly from `.g` geometry in backend to remove VLM geometric estimation noise and improve consistency of proximity decisions. Acceptance: backend distance API returns deterministic pair distances and the current strategy layer consumes parser output as source of truth.
11. **[TASK-012] Multi-Support Hovering Fix (2026-03-20 15:30)**: Updated `action_place_on_multi_support` to use `virtualAnchorName` for hover and placement constraints. Verified through compilation and static checks. Pending runtime validation.
12. **[TASK-011] Introduce graph clustering to replace VLM strategy generation/decision (2026-03-20 14:05)**: Implemented `BranchAwareClustering` in `core/graph_clustering.py`, integrated into `pipeline/run_phase2.py` for deterministic strategy generation, and added `docs/clustering_algorithm_report.md`. Also fixed inventory binding to eliminate object-naming hallucinations.
13. **[TASK-010] Active Constraint Set Optimization for TAMP Solver Acceleration (2026-03-19 21:10)**: Closed after stabilizing `action_pick` / `action_place_straightOn` staging, fixing motif same-slice conflicts via `stepsPerPhase>=10` gating, and finalizing place orientation target (`+90deg`, b-face forward). End-to-end `active_coll_test/node_1_run` now runs successfully after final user-side code adjustments.
14. **[TASK-007] Reachability Detection for Pick Waypoints (2026-03-17 14:48)**: Completed waypoint reachability runner + trajectory-log pipeline, added minimal recovery/near-far/obstacle scenes, validated replay workflow, and closed reachability branch as an independent milestone.
15. **[TASK-009] Refine Paper — Synchronize Latest Workflow and Innovation Points (2026-03-14 17:15)**: Synced the latest system pipeline state, Active Constraint Strategy, Waypoint-Gated Reachability, and parameterized Shape-Aware Grasping into the academic manuscript `paper/VLM_LGP_Assembly_260314.tex`.
16. **[TASK-008] Document `paper/` directory and add to DDE Protocol (2026-03-14 12:38)**: Registered the `paper/` academic manuscript directory as a formal module within Layer 0-3 DDE documentation. Added `paper_documentation.md` spec and updated `project_charter.md` and `architecture.md`.
17. **[TASK-004] Planar Arrangement Prompt Refinement (2026-03-12 22:24)**: Completed Phase0 -> Phase2 runtime debugging and VLM stabilization, including Phase1 DAG prompt hardening, end-to-end validation closure, and documented Phase0 VLM I/O contracts.
18. **[TASK-005] Phase0 Patch Naming Injection Completion (2026-03-12 22:42)**: Completed Phase0 automatic patch naming injection for `Rect_N_Left/Right` and verified naming consistency/preservation across `generated/scene_named.g`, `generated/scene/unnamed.g`, and `generated/scene/scene_named.g`.
19. **[TASK-003] Constraint Cleanup in manipTools.cpp (2026-03-09 13:35)**: Removed overlapping soft `OT_sos` constraints in pick and place sequences to prevent solver stalling.
20. **[TASK-002] Multi-Support Hovering Fix (2026-03-08 14:30)**: Replaced absolute Z `getSize()(0)` with relative `FS_positionDiff` and fixed XY alignment in `action_place_on_multi_support`.
21. **[TASK-001] DDE-Bootstrap Setup (2026-03-08 15:22)**: Generated Layer 0-4 Documentation-Driven Engineering protocol to prevent hallucination.

## 3. Pending Backlog

Pending backlog entries are currently tracked in issue discussions and will be re-listed here when reprioritized into executable task IDs.
