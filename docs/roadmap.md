# Layer 4: Project Roadmap & Task Tracker

## 1. Current Active Tasks (Timeline Log)
### [TASK-010] Active Constraint Set Optimization for TAMP Solver Acceleration
* **Status**: `[In Progress]`
* **Created**: 2026-03-17 14:48
* **Completed**: N/A
* **Timeline**:
	* *2026-03-17 14:48*: Split legacy mixed task into two tracks: (1) active-constraint optimization and (2) reachability module closure.
	* *2026-03-17 14:48*: Continue constraint-pair selection and objective-pruning strategy for solver speedup, decoupled from reachability reporting workflow.
	* *2026-03-18 12:38*: Rolled back to the first stable Option-B runtime strategy: 5cm active radius, runtime `explicitCollisions` injection only, no `.lgp` write-back, and `useBroadCollisions=false` before full-motion.
	* *2026-03-18 12:38*: Verified stable report generation for `node_1_run` and identified the next barrier: neighbor-object pair coverage is incomplete in some subtasks (example under `step_3_batch_2`: expected nearby relation such as `rect_2` and `cube_3` may not appear in active pairs).
	* *2026-03-18 12:38*: Added documentation of the full active-collision chain and current blind spot for follow-up refinement planning.
	* *2026-03-18 17:16*: Completed Step-1 active-pair filter experiment: added robot-shape whitelist and patch exclusion (`Rect_*_Left/Right`, `Table_Left/Right`) in `bin/main.cpp`; pair count dropped sharply but solver time and motion distortion regressed in several subtasks.
	* *2026-03-18 17:16*: Applied table fallback activation plus tabletop patch shift (`+Y 0.05m`, away from robot) for `Base_*` and `Table_*`; rerun still shows conflict symptoms, indicating mismatch between upper explicit pairs and lower action-level phased collision constraints remains unresolved.
	* *2026-03-18 17:16*: Exported pre-active-strategy baseline backup for A/B timing: `backups/pre_active_strategy/main.cpp.pre_active_503cdba.cpp` (source commit `503cdba`) and confirmed active-strategy introduction commits touched more than `bin/main.cpp`.
	* *2026-03-18 17:28*: Locked next objective: refactor `rai/src/KOMO/manipTools.cpp` so action-level collision constraints are gated by upper `explicitCollisions` pair policy first (pair-set unification only), while keeping existing stage windows and weights unchanged for the first validation pass.
	* *2026-03-18 17:28*: Added source-backed conflict report `docs/ops/ACTIVE_COLLISION_LAYER_CONFLICT_REPORT_2026-03-18.md`, enumerating all verified mismatch points between `LGP_TAMP_Abstraction` explicit pairs and `manipTools` local obstacle loops / accumulated-collision terms.
	* *2026-03-19 15:27*: Requirement boundary updated: stop deep integrated grasp-approach tuning in KOMO; switch to motion-grasp decoupling strategy where solver focuses on transit motion and terminal contact is represented by fixed vertical micro-actions.
	* *2026-03-19 15:27*: Locked first implementation scope to `action_pick` and `action_place_straightOn`: enforce top-of-target arrival (`XY aligned, Z +5cm`) then fixed descend `5cm`; pick adds early `+5cm` lift in `time-1.0~time-0.7`.
	* *2026-03-19 15:27*: Collision policy simplification approved for next patch: keep only transit-window soft avoidance (`OT_sos`, distance target `5cm`) in `time-0.7~time-0.3`, remove fine-grained approach-phase barrier tuning.
	* *2026-03-19 15:27*: Added implementation report `docs/ops/PICK_PLACE_DECOUPLED_MOTION_CHANGE_REPORT_2026-03-19.md` with function-level touch points and risk guardrails.
	* *2026-03-19 15:27*: Tracked known observation for decoupled place: potential avoidance vacuum in `time-1.0~time-0.7`; keep current strategy unchanged and revisit only if trajectory quality regresses.
	* *2026-03-19 15:56*: Rolled back incorrect decoupled code patch in `rai/src/KOMO/manipTools.cpp` after runtime infeasibility (`place_straightOn` waypoint-stage constraints conflicted in same slice).
	* *2026-03-19 15:56*: Corrected decoupling specification: for `action_pick`, remove redundant `time-0.3` single-point top lock and remove midpoint height anchor; for `action_place_straightOn`, remove midpoint height anchor.
	* *2026-03-19 15:56*: Next implementation gate: keep only logically minimal staged constraints (`-1.0~-0.7` lift, `-0.7~-0.3` transit-to-top, `-0.3~time` vertical descend) plus transit-window `OT_sos` avoidance.
	* *2026-03-19 18:02*: Updated `action_place_straightOn` target-orientation objective for placement face selection: switched final non-cylinder alignment to `+90deg` convention (`x_obj` aligned to `y_table`, i.e. "b-face forward"), while keeping terminal XY/Z hard placement constraints.
	* *2026-03-19 18:02*: Added feasibility guard for motif/waypoint stage: gated `time-0.3` pre-place segment objectives behind `stepsPerPhase>=10` to prevent same-slice target conflicts between hover-height and terminal contact-height constraints.

## 2. Completed Tasks Rolling Archive (Max 50)
> **Rule**: When adding the 51st item, delete the oldest item to prevent context poisoning. Summarize tasks in 1-2 lines. All timestamps MUST use `YYYY-MM-DD HH:MM` format.

1. **[TASK-007] Reachability Detection for Pick Waypoints (2026-03-17 14:48)**: Completed waypoint reachability runner + trajectory-log pipeline, added minimal recovery/near-far/obstacle scenes, validated replay workflow, and closed reachability branch as an independent milestone.
2. **[TASK-009] Refine Paper — Synchronize Latest Workflow and Innovation Points (2026-03-14 17:15)**: Synced the latest system pipeline state, Active Constraint Strategy, Waypoint-Gated Reachability, and parameterized Shape-Aware Grasping into the academic manuscript `paper/VLM_LGP_Assembly_260314.tex`.
3. **[TASK-008] Document `paper/` directory and add to DDE Protocol (2026-03-14 12:38)**: Registered the `paper/` academic manuscript directory as a formal module within Layer 0-3 DDE documentation. Added `paper_documentation.md` spec and updated `project_charter.md` and `architecture.md`.
4. **[TASK-004] Planar Arrangement Prompt Refinement (2026-03-12 22:24)**: Completed Phase0 -> Phase2 runtime debugging and VLM stabilization, including Phase1 DAG prompt hardening, end-to-end validation closure, and documented Phase0 VLM I/O contracts.
5. **[TASK-005] Phase0 Patch Naming Injection Completion (2026-03-12 22:42)**: Completed Phase0 automatic patch naming injection for `Rect_N_Left/Right` and verified naming consistency/preservation across `generated/scene_named.g`, `generated/scene/unnamed.g`, and `generated/scene/scene_named.g`.
6. **[TASK-003] Constraint Cleanup in manipTools.cpp (2026-03-09 13:35)**: Removed overlapping soft `OT_sos` constraints in pick and place sequences to prevent solver stalling.
7. **[TASK-002] Multi-Support Hovering Fix (2026-03-08 14:30)**: Replaced absolute Z `getSize()(0)` with relative `FS_positionDiff` and fixed XY alignment in `action_place_on_multi_support`.
8. **[TASK-001] DDE-Bootstrap Setup (2026-03-08 15:22)**: Generated Layer 0-4 Documentation-Driven Engineering protocol to prevent hallucination.

## 3. Pending Backlog
- Replace/optimize soft `OT_sos` objectives that conflict with hard `OT_eq` requirements in the manipulation logics.
- Implement and validate motion-grasp decoupled `action_pick` and `action_place_straightOn` in `rai/src/KOMO/manipTools.cpp`, including the `+90deg` place orientation target (`b-face forward`) and waypoint-stage feasibility gating.
- Add A/B validation focused on trajectory smoothness for windows `time-1.0~time-0.6` and `time-0.3~time` after decoupling patch.
- Optional fallback (conditional): if place quality degrades, add lightweight soft avoidance coverage for `time-1.0~time-0.7` without re-introducing hard barrier stacks.

### [TASK-006] MuJoCo Simulation Debug Loop Integration
* **Status**: `[Pending]`
* **Created**: 2026-03-12 22:42
* **Completed**: N/A
* **Timeline**:
	* *2026-03-12 22:42*: Task moved from backlog to active execution. Goal is to align MuJoCo scene with `generated/scene_named.g`, validate key manipulation actions (pick/place), and finalize reproducible simulation-side debug scripts.
	* *2026-03-13 17:03*: Task moved from `In Progress` back to `Pending Backlog`; preserved original execution timeline for future resumption.
