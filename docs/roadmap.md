# Layer 4: Project Roadmap & Task Tracker

## 1. Current Active Tasks (Timeline Log)
### [TASK-007] Active Constraint Set + Reachability Detection for TAMP Solver Acceleration
* **Status**: `[In Progress]`
* **Created**: 2026-03-13 17:01
* **Completed**: N/A
* **Timeline**:
	* *2026-03-13 17:01*: Roadmap update applied. Promoted solver-time optimization from pending backlog to active task and moved MuJoCo debug loop back to pending backlog.
	* *2026-03-13 17:01*: Define and integrate an active constraint set algorithm plus reachability detection to select collision pairs and pre-filter infeasible picks, reducing excessive TAMP constraints and improving solve time.

## 2. Completed Tasks Rolling Archive (Max 50)
> **Rule**: When adding the 51st item, delete the oldest item to prevent context poisoning. Summarize tasks in 1-2 lines. All timestamps MUST use `YYYY-MM-DD HH:MM` format.

1. **[TASK-009] Refine Paper — Synchronize Latest Workflow and Innovation Points (2026-03-14 17:15)**: Synced the latest system pipeline state, Active Constraint Strategy, Waypoint-Gated Reachability, and parameterized Shape-Aware Grasping into the academic manuscript `paper/VLM_LGP_Assembly_260314.tex`.
2. **[TASK-008] Document `paper/` directory and add to DDE Protocol (2026-03-14 12:38)**: Registered the `paper/` academic manuscript directory as a formal module within Layer 0-3 DDE documentation. Added `paper_documentation.md` spec and updated `project_charter.md` and `architecture.md`.
2. **[TASK-004] Planar Arrangement Prompt Refinement (2026-03-12 22:24)**: Completed Phase0 -> Phase2 runtime debugging and VLM stabilization, including Phase1 DAG prompt hardening, end-to-end validation closure, and documented Phase0 VLM I/O contracts.
2. **[TASK-005] Phase0 Patch Naming Injection Completion (2026-03-12 22:42)**: Completed Phase0 automatic patch naming injection for `Rect_N_Left/Right` and verified naming consistency/preservation across `generated/scene_named.g`, `generated/scene/unnamed.g`, and `generated/scene/scene_named.g`.
3. **[TASK-003] Constraint Cleanup in manipTools.cpp (2026-03-09 13:35)**: Removed overlapping soft `OT_sos` constraints in pick and place sequences to prevent solver stalling.
4. **[TASK-002] Multi-Support Hovering Fix (2026-03-08 14:30)**: Replaced absolute Z `getSize()(0)` with relative `FS_positionDiff` and fixed XY alignment in `action_place_on_multi_support`.
5. **[TASK-001] DDE-Bootstrap Setup (2026-03-08 15:22)**: Generated Layer 0-4 Documentation-Driven Engineering protocol to prevent hallucination.

## 3. Pending Backlog
- Replace/optimize soft `OT_sos` objectives that conflict with hard `OT_eq` requirements in the manipulation logics.

### [TASK-006] MuJoCo Simulation Debug Loop Integration
* **Status**: `[Pending]`
* **Created**: 2026-03-12 22:42
* **Completed**: N/A
* **Timeline**:
	* *2026-03-12 22:42*: Task moved from backlog to active execution. Goal is to align MuJoCo scene with `generated/scene_named.g`, validate key manipulation actions (pick/place), and finalize reproducible simulation-side debug scripts.
	* *2026-03-13 17:03*: Task moved from `In Progress` back to `Pending Backlog`; preserved original execution timeline for future resumption.
