# Layer 4: Project Roadmap & Task Tracker

## 1. Current Active Tasks (Timeline Log)

1. ### [TASK-017] RA-L Method Section Refinement Governance Setup

* **Status**: `[In Progress]`
* **Created**: 2026-03-25 11:20
* **Completed**: N/A
* **Timeline**:
  * *2026-03-25 11:20*: Task created to support RA-L submission-oriented drafting. Scope includes: (i) per-paragraph bilingual rewrite workflow, (ii) strict terminology mapping between flowchart labels and Method headers, (iii) fixed conservative claim style profile, and (iv) mandatory logic-alignment checks against `docs/architecture.md`, `docs/dataflow.md`, and `docs/execution_protocol.md` before accepting each paragraph revision.
  * *2026-03-25 11:20*: Added process governance doc `docs/ops/PAPER_REFINEMENT_MANAGEMENT_SOP.md` to make style and logic checks reproducible across chat sessions/agents.
  * *2026-03-25 11:55*: Completed the first Method opening paragraph refinement in `paper/VLM-LGP-Assembly/bare_jrnl.tex` using Scheme A (conservative RA-L tone). Locked this paragraph as the style anchor for subsequent Method paragraph-by-paragraph updates.

1. ### [TASK-018] Manipulability-First Execution Ordering

* **Status**: `[In Progress]`
* **Created**: 2026-03-25 16:40
* **Completed**: N/A
* **Timeline**:
  * *2026-03-25 16:40*: Task activated to replace Euclidean ordering with manipulability-first ordering for execution priority.
  * *2026-03-25 16:40*: Scope freeze drafted: (i) ranking based on manipulability (not distance fallback), (ii) unknown manipulability candidates are pushed to queue tail, (iii) maintain downstream compatibility.
  * *2026-03-25 16:40*: Input/output contract drafting started in `docs/ops/METHOD_UPGRADE_TASKBOOK_2026-03-25.md`.
  * *2026-03-25 17:15*: Coupling decision locked with TASK-019: serial workflow (`reachability -> ordering`), feasibility decision remains completed in current Phase0 flow, and downstream interface stays in current feasible/infeasible format.
  * *2026-03-25 17:15*: Boundary decisions confirmed: same-type local ordering (1A), unknown manipulability to tail (2A), reachability decision + data produced in current flow but next node receives existing format only (3A), serial orchestration (4A).
  * *2026-03-25 17:35*: Additional boundary lock: unknown handling must use an explicit threshold, thresholded/continuous data remain available for internal audit and visualization only, and sidecar audit file is allowed.
  * *2026-03-25 17:35*: Existing tie-break behavior is frozen to current working code logic (no tie-break policy rewrite in this task).
  * *2026-03-25 17:35*: Literature check logged for method alignment: Murooka et al. (2025) main method is NN/SVM differentiable reachability with kinematic constraints; GMM appears as related work reference rather than core proposed model.

1. ### [TASK-019] Differentiable Reachability Heatmap (GMM + ESDF)

* **Status**: `[In Progress]`
* **Created**: 2026-03-25 16:40
* **Completed**: N/A
* **Timeline**:
  * *2026-03-25 16:40*: Task activated to replace object-by-object engineering reachability checks with a generalized differentiable field model.
  * *2026-03-25 16:40*: Baseline gap identified: current implementation loops over objects and calls waypoint checker one object at a time in `core/phase0_parser.py`, producing binary feasibility labels only.
  * *2026-03-25 16:40*: Planned target interface defined: continuous reachability score map + thresholded feasibility decision + report schema extension.
  * *2026-03-25 18:10*: Implementation boundary locked with TASK-018 separation: TASK-019 owns feasibility decision (continuous score + threshold), TASK-018 consumes feasible set for ranking only.
  * *2026-03-25 18:10*: Scope clarified: TASK-019 uses GMM + ESDF scoring/thresholding (clearance semantics carried by ESDF term).
  * *2026-03-25 18:10*: Runtime policy locked: offline/local computation is allowed (no mandatory real-time simulator loop), while legacy `generated/infeasible_objects.json` compatibility must remain intact.

1. ### [TASK-020] Academic Graph Clustering Upgrade (k-means Family)

* **Status**: `[In Progress]`
* **Created**: 2026-03-25 16:40
* **Completed**: N/A
* **Timeline**:
  * *2026-03-25 16:40*: Task activated to upgrade current controlled branch/layer heuristic into a mature clustering formulation aligned with academic graph-partition literature.
  * *2026-03-25 16:40*: Scope freeze drafted: (i) feature construction from support graph, (ii) k-means or k-means-on-embedding clustering policy, (iii) dependency-safe batch reconstruction preserving DAG constraints.
  * *2026-03-25 16:40*: Validation plan seeded: compare legacy branch-layer outputs vs upgraded clustering outputs on fixed benchmark graphs before runtime switch.
  * *2026-03-25 18:10*: Practical implementation blueprint locked: (i) graph-safe preprocessing, (ii) k-means-family clustering on explicit features, (iii) DAG-safe dependency repair and solver-facing batch cutting.
  * *2026-03-25 18:10*: Rollout policy locked: introduce switchable `KMeansBranchClustering` behind config while keeping `BranchAwareLayerCuttingClustering` as fallback.


## 2. Completed Tasks Rolling Archive (Max 50)

> **Rule**: When adding the 51st item, delete the oldest item to prevent context poisoning. Summarize tasks in 1-2 lines. All timestamps MUST use `YYYY-MM-DD HH:MM` format.

1. **[TASK-014] Planar Assembly Experiment (2026-03-21 13:10)**: Successfully designed and executed planar assembly tasks using FMB assets. Implemented mesh-aware Z-height calculation and eccentric grasping with handle markers. Verified end-to-end chained planning.
2. **[TASK-016] Validate layer-aware cutting on the Phase1 support graph (2026-03-25 12:05)**: Closed without further execution; this validation track is superseded by the upcoming k-means clustering direction.
3. **[TASK-015] Update Document & flowchart (2026-03-21 13:23)**: Completed update of documentation and flowchart to align with current pipeline, including mesh-aware height and active constraint strategy descriptions.
4. **[TASK-013] Replace VLM Euclidean distance judgment with backend `.g` scene parser (2026-03-20 15:30)**: Goal: compute object Euclidean distances directly from `.g` geometry in backend to remove VLM geometric estimation noise and improve consistency of proximity decisions. Acceptance: backend distance API returns deterministic pair distances and the current strategy layer consumes parser output as source of truth.
5. **[TASK-014] Planar Assembly Experiment (2026-03-21 13:10)**: Successfully designed and executed planar assembly tasks using FMB assets. Implemented mesh-aware Z-height calculation and eccentric grasping with handle markers. Verified end-to-end chained planning.
6. **[TASK-016] Validate layer-aware cutting on the Phase1 support graph (2026-03-25 12:05)**: Closed without further execution; this validation track is superseded by the upcoming k-means clustering direction.
7. **[TASK-013] Replace VLM Euclidean distance judgment with backend `.g` scene parser (2026-03-20 15:30)**: Goal: compute object Euclidean distances directly from `.g` geometry in backend to remove VLM geometric estimation noise and improve consistency of proximity decisions. Acceptance: backend distance API returns deterministic pair distances and the current strategy layer consumes parser output as source of truth.
8. **[TASK-012] Multi-Support Hovering Fix (2026-03-20 15:30)**: Updated `action_place_on_multi_support` to use `virtualAnchorName` for hover and placement constraints. Verified through compilation and static checks. Pending runtime validation.
9. **[TASK-011] Introduce graph clustering to replace VLM strategy generation/decision (2026-03-20 14:05)**: Implemented `BranchAwareClustering` in `core/graph_clustering.py`, integrated into `pipeline/run_phase2.py` for deterministic strategy generation, and added `docs/clustering_algorithm_report.md`. Also fixed inventory binding to eliminate object-naming hallucinations.
10. **[TASK-010] Active Constraint Set Optimization for TAMP Solver Acceleration (2026-03-19 21:10)**: Closed after stabilizing `action_pick` / `action_place_straightOn` staging, fixing motif same-slice conflicts via `stepsPerPhase>=10` gating, and finalizing place orientation target (`+90deg`, b-face forward). End-to-end `active_coll_test/node_1_run` now runs successfully after final user-side code adjustments.
11. **[TASK-007] Reachability Detection for Pick Waypoints (2026-03-17 14:48)**: Completed waypoint reachability runner + trajectory-log pipeline, added minimal recovery/near-far/obstacle scenes, validated replay workflow, and closed reachability branch as an independent milestone.
12. **[TASK-009] Refine Paper — Synchronize Latest Workflow and Innovation Points (2026-03-14 17:15)**: Synced the latest system pipeline state, Active Constraint Strategy, Waypoint-Gated Reachability, and parameterized Shape-Aware Grasping into the academic manuscript `paper/VLM_LGP_Assembly_260314.tex`.
13. **[TASK-008] Document `paper/` directory and add to DDE Protocol (2026-03-14 12:38)**: Registered the `paper/` academic manuscript directory as a formal module within Layer 0-3 DDE documentation. Added `paper_documentation.md` spec and updated `project_charter.md` and `architecture.md`.
14. **[TASK-004] Planar Arrangement Prompt Refinement (2026-03-12 22:24)**: Completed Phase0 -> Phase2 runtime debugging and VLM stabilization, including Phase1 DAG prompt hardening, end-to-end validation closure, and documented Phase0 VLM I/O contracts.
15. **[TASK-005] Phase0 Patch Naming Injection Completion (2026-03-12 22:42)**: Completed Phase0 automatic patch naming injection for `Rect_N_Left/Right` and verified naming consistency/preservation across `generated/scene_named.g`, `generated/scene/unnamed.g`, and `generated/scene/scene_named.g`.
16. **[TASK-003] Constraint Cleanup in manipTools.cpp (2026-03-09 13:35)**: Removed overlapping soft `OT_sos` constraints in pick and place sequences to prevent solver stalling.
17. **[TASK-002] Multi-Support Hovering Fix (2026-03-08 14:30)**: Replaced absolute Z `getSize()(0)` with relative `FS_positionDiff` and fixed XY alignment in `action_place_on_multi_support`.
18. **[TASK-001] DDE-Bootstrap Setup (2026-03-08 15:22)**: Generated Layer 0-4 Documentation-Driven Engineering protocol to prevent hallucination.

## 3. Pending Backlog

### [TASK-006] MuJoCo Simulation Debug Loop Integration

* **Status**: `[Pending]`
* **Created**: 2026-03-12 22:42
* **Completed**: N/A
* **Timeline**:
  * *2026-03-12 22:42*: Task moved from backlog to active execution. Goal is to align MuJoCo scene with `generated/scene_named.g`, validate key manipulation actions (pick/place), and finalize reproducible simulation-side debug scripts.
  * *2026-03-13 17:03*: Task moved from `In Progress` back to `Pending Backlog`.
  * *2026-03-21 13:10*: Briefly restored for planar validation but moved back to pending to prioritize documentation.
