# Layer 4: Project Roadmap & Task Tracker

## 1. Current Active Tasks (Timeline Log)


1. ### [TASK-024] Layer-Based Graph Clustering Refinement

* **Status**: `[In Progress]`
* **Created**: 2026-04-14 16:25
* **Completed**: N/A
* **Timeline**:
  * *2026-04-14 16:25*: Task created to refine graph clustering into layer-based execution groups with branch-priority semantics and deterministic split/execution order.
  * *2026-04-14 16:25*: Scope locked: same-layer objects are merged as jointly executable set; branch assignment prioritizes shared source ancestor over destination convergence.
  * *2026-04-14 16:25*: Efficiency/stability constraints locked: if one branch has more than two objects, split by left-to-right order in chunks of two; execution inside one branch also follows left-to-right order.
  * *2026-04-16 17:05*: Added test-only batch-level codegen harness under `test/layer_based_clustering/` and verified one `.fol/.lgp` pair per planned batch.
  * *2026-04-16 17:05*: Next step: connect the test harness to mainline Phase0 reachability, static manipulability, and Phase2 solver execution without touching production code yet.
  * *2026-04-16 17:20*: Mainline-connected smoke test was attempted in the mac runtime, but the solver/LGP execution path requires Linux-only runtime support (`bin/x.exe` and related LGP behavior). The test is now parked in `test/layer_based_clustering/test_mainline_reachability_manipulability_lgp.py` and will be resumed later for final fusion validation on Linux.
  * *2026-04-16 17:40*: Corrected layer-based grouping logic so same-layer siblings under the same direct supporter are merged naturally; verified batch-level output now produces `[[1, 2], [3, 4], [5, 6], [7], [8], [9]]` with one `.fol/.lgp` pair per batch.

## 2. Completed Tasks Rolling Archive (Max 50)

> **Rule**: When adding the 51st item, delete the oldest item to prevent context poisoning. Summarize tasks in 1-2 lines. All timestamps MUST use `YYYY-MM-DD HH:MM` format.

1. **[TASK-023] FMB VLM Recognition and Cognition Integration (2026-04-14 16:10)**: Closed after FMB prompt/image-batch validation; established single-image protocol and accuracy evaluation workflow.

2. **[TASK-022] Reachability 1D Self-Motion Adaptation Study for Franka (2026-04-03 18:02)**: Closed per advisor decision: the Franka self-motion reachability adaptation line will not be included in the current paper, because over-emphasizing this direction may attract unnecessary reviewer attention and distract from the main manuscript contribution.
3. **[TASK-017] RA-L Method Section Refinement Governance Setup (2026-04-03 17:47)**: Closed the RA-L method-section refinement cycle by locking final terminology to the flowchart, restructuring Method into Task Decomposition + Scene Grounding + Execution-Order Embedding, adding standalone reachability/manipulability paragraphs, and aligning governance docs with the finalized manuscript story.
4. **[TASK-006] MuJoCo Simulation Debug Loop Integration (2026-04-02 15:50)**: Closed with root-cause confirmation that TCP residual error mainly comes from steady-state PD servo bias under gravity in MuJoCo general actuators, plus delivered gain scan automation in `Mujoco_Simulation/auto_gainprm_tune.py`. Keywords: steady-state error, `gainprm/biasprm` coupling, `kp-kd` sweep, Jacobian-level TCP error attribution, gravity feedforward recommendation.
5. **[TASK-021] Native LGP Waypoint Reachability + Manipulability Coupling (2026-03-30 21:30)**: Completed pipeline integration of LGP kinematic waypoint hard gate with Jacobian manipulability screening, isolated explicit collision reduction (~15x solver speedup), and fully verified script execution logic up to LGP TAMP solver.
6. **[TASK-018] Manipulability-First Execution Ordering (2026-03-26 12:43)**: Completed URDF-only static manipulability implementation, reporting, and visualization verification on `dev/manipulability`. Follow-up note kept: future priority policy may fuse TASK-019 reachability parameters with TASK-018 manipulability parameters.
7. **[TASK-019] Differentiable Reachability Heatmap (GMM + ESDF) (2026-03-29 20:49)**: close the req, turn to solve IK using the original LGP first layer(FCL+libccb)
8. **[TASK-020] Academic Graph Clustering Upgrade (2026-03-26 16:05)**: Finalized provenance-driven clustering and unified scheduling by removing no-merge fallback splitting; validated consistent behavior across three-branch, pyramid, and 3x5 benchmarks with solver-facing `step_*.fol/.lgp` generation.
9. **[TASK-014] Planar Assembly Experiment (2026-03-21 13:10)**: Successfully designed and executed planar assembly tasks using FMB assets. Implemented mesh-aware Z-height calculation and eccentric grasping with handle markers. Verified end-to-end chained planning.
10. **[TASK-016] Validate layer-aware cutting on the Phase1 support graph (2026-03-25 12:05)**: Closed without further execution; this validation track is superseded by the upcoming k-means clustering direction.
11. **[TASK-015] Update Document & flowchart (2026-03-21 13:23)**: Completed update of documentation and flowchart to align with current pipeline, including mesh-aware height and active constraint strategy descriptions.
12. **[TASK-013] Replace VLM Euclidean distance judgment with backend `.g` scene parser (2026-03-20 15:30)**: Goal: compute object Euclidean distances directly from `.g` geometry in backend to remove VLM geometric estimation noise and improve consistency of proximity decisions. Acceptance: backend distance API returns deterministic pair distances and the current strategy layer consumes parser output as source of truth.
13. **[TASK-014] Planar Assembly Experiment (2026-03-21 13:10)**: Successfully designed and executed planar assembly tasks using FMB assets. Implemented mesh-aware Z-height calculation and eccentric grasping with handle markers. Verified end-to-end chained planning.
14. **[TASK-016] Validate layer-aware cutting on the Phase1 support graph (2026-03-25 12:05)**: Closed without further execution; this validation track is superseded by the upcoming k-means clustering direction.
15. **[TASK-013] Replace VLM Euclidean distance judgment with backend `.g` scene parser (2026-03-20 15:30)**: Goal: compute object Euclidean distances directly from `.g` geometry in backend to remove VLM geometric estimation noise and improve consistency of proximity decisions. Acceptance: backend distance API returns deterministic pair distances and the current strategy layer consumes parser output as source of truth.
16. **[TASK-012] Multi-Support Hovering Fix (2026-03-20 15:30)**: Updated `action_place_on_multi_support` to use `virtualAnchorName` for hover and placement constraints. Verified through compilation and static checks. Pending runtime validation.
17. **[TASK-011] Introduce graph clustering to replace VLM strategy generation/decision (2026-03-20 14:05)**: Implemented `BranchAwareClustering` in `core/graph_clustering.py`, integrated into `pipeline/run_phase2.py` for deterministic strategy generation, and added `docs/clustering_algorithm_report.md`. Also fixed inventory binding to eliminate object-naming hallucinations.
18. **[TASK-010] Active Constraint Set Optimization for TAMP Solver Acceleration (2026-03-19 21:10)**: Closed after stabilizing `action_pick` / `action_place_straightOn` staging, fixing motif same-slice conflicts via `stepsPerPhase>=10` gating, and finalizing place orientation target (`+90deg`, b-face forward). End-to-end `active_coll_test/node_1_run` now runs successfully after final user-side code adjustments.
19. **[TASK-007] Reachability Detection for Pick Waypoints (2026-03-17 14:48)**: Completed waypoint reachability runner + trajectory-log pipeline, added minimal recovery/near-far/obstacle scenes, validated replay workflow, and closed reachability branch as an independent milestone.
20. **[TASK-009] Refine Paper — Synchronize Latest Workflow and Innovation Points (2026-03-14 17:15)**: Synced the latest system pipeline state, Active Constraint Strategy, Waypoint-Gated Reachability, and parameterized Shape-Aware Grasping into the academic manuscript `paper/VLM_LGP_Assembly_260314.tex`.
21. **[TASK-008] Document `paper/` directory and add to DDE Protocol (2026-03-14 12:38)**: Registered the `paper/` academic manuscript directory as a formal module within Layer 0-3 DDE documentation. Added `paper_documentation.md` spec and updated `project_charter.md` and `architecture.md`.
22. **[TASK-004] Planar Arrangement Prompt Refinement (2026-03-12 22:24)**: Completed Phase0 -> Phase2 runtime debugging and VLM stabilization, including Phase1 DAG prompt hardening, end-to-end validation closure, and documented Phase0 VLM I/O contracts.
23. **[TASK-005] Phase0 Patch Naming Injection Completion (2026-03-12 22:42)**: Completed Phase0 automatic patch naming injection for `Rect_N_Left/Right` and verified naming consistency/preservation across `generated/scene_named.g`, `generated/scene/unnamed.g`, and `generated/scene/scene_named.g`.
24. **[TASK-003] Constraint Cleanup in manipTools.cpp (2026-03-09 13:35)**: Removed overlapping soft `OT_sos` constraints in pick and place sequences to prevent solver stalling.
25. **[TASK-002] Multi-Support Hovering Fix (2026-03-08 14:30)**: Replaced absolute Z `getSize()(0)` with relative `FS_positionDiff` and fixed XY alignment in `action_place_on_multi_support`.
26. **[TASK-001] DDE-Bootstrap Setup (2026-03-08 15:22)**: Generated Layer 0-4 Documentation-Driven Engineering protocol to prevent hallucination.

## 3. Pending Backlog

Pending backlog entries are currently tracked in issue discussions and will be re-listed here when reprioritized into executable task IDs.
