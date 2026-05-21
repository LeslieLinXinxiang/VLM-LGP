# System Architecture (Layer 1)

## 1. System Overview

VLM-LGP is a hybrid TAMP (Task and Motion Planning) framework. It uses logical sequences (FOL - First Order Logic) to define high-level task sequences, and delegates the continuous manifold optimization (motion trajectories, contact forces, kinematics) to the KOMO solver.

## 2. Module List

- `Native LGP Reachability Gate`: Hard gate pre-filter for kinematic feasibility.
- `KOMO ManipTools`: Low-level physical manipulation constraints.
- `LGP TAMP Core`: Tree search and logical node expansion for Task and Motion Planning.
- `Python Scripting Layer`: Environment execution, batch running, and visual verification.
- `Main Executable`: Reads `.lgp` configurations and executes the solver loop.
- `Graph Clustering Engine`: Deterministic branch-aware task sequencer that replaces VLM-based strategy selection.
- `Simulation Consistency Toolkit`: Offline diagnostics and export utilities for RAI-vs-MuJoCo pose consistency checks.
- `MuJoCo Control Tuning Sandbox`: Pure-MuJoCo actuator steady-state error diagnosis and gain sweep utilities for position-servo accuracy tuning.
- `Design & Visualization (Figma MCP)`: Automated generation and synchronization of academic figures via VS Code MCP, Figma Desktop Bridge, and `figma-console` write tools.
- `Paper Documentation`: VLM-LGP framework manuscript, figures, and publication materials.

## 3. Module Responsibilities

- **KOMO ManipTools**: Define exact mathematical objectives (e.g., `FS_positionDiff`, `FS_vectorZ`) to guide the robotic arm for picking, placing, and navigating without collisions.
- **Python Scripting Layer**: Builds Phase0 assets, dispatches semantic matching, and implements the **Branch-Aware Topological Clustering** algorithm for deterministic task sequencing.
- **Main Executable**: Load trajectories, resample them (e.g., to 1000Hz for Pos/Vel/Acc), and interact with external interfaces.
- **Simulation Consistency Toolkit**: Provides non-intrusive scripts (`scripts/sample_tcp_error.py`, `scripts/export_lgp_scene_xyz.py`) to quantify TCP/link consistency and export object coordinates from `.g` scenes for cross-simulator comparison.
- **MuJoCo Control Tuning Sandbox**: Provides isolated MuJoCo validation scripts (for example, `Mujoco_Simulation/pure_mujoco_trajectory_point_test.py` and `Mujoco_Simulation/auto_gainprm_tune.py`) to quantify joint steady-state bias, map TCP error attribution, and batch-search `kp/kd` settings.
- `Design & Visualization`: Manages the programmatic creation/editing of system architecture diagrams (Fig 1) and workflow graphs through write-enabled Figma MCP workflows.
- **Paper Documentation**: Holds the academic documentation (`paper/`) that formalizes the Vision-Language Geometric Programming approach for publication.

## 4. Dependency Rules

- The C++ Core does not depend on Python.
- Python scripts depend strictly on the serialized outputs (trajectories, `.g` scene files) of the C++ Core and the `robotic` PIP package.

## 5. External Interfaces

- **Input**: `.fol` (Logic), `.lgp` (Parameters), `.g` (Scene geometry and initial states), plus Phase0 VLM inputs (`generated/phase0_capture.png`, `generated/phase0_specs.json`, selected prompt markdown).
- **Output**: Trajectory text files, gripper schedule files (`gripper.txt`), updated `.g` scenes (`output_state.g`), Phase0 semantic layout artifacts such as `generated/phase0_layout.json`, and optional diagnostics artifacts (scene xyz JSON/CSV exports) for simulator alignment analysis.

## 6. Architectural Constraints

- All hard placement constraints must use relative coordinates (`FS_positionDiff` or `FS_positionRel`) rather than absolute World Coordinates to avoid dependency on global geometrical origin offsets.
- Fast solver convergence requires purging redundant soft constraints (`OT_sos`) that clash with exact equality constraints (`OT_eq`).
- **Active Collision Whitelisting**: Internal fixed/constrained robot joint pairs MUST be excluded from active constraint injection to prevent redundant penetration depth evaluations (avoids EPA bottlenecks yielding ~15x speedup).

## 7. Two-Mode Solver Architecture

The KOMO solver is called in two distinct modes, distinguished by `stepsPerPhase`:

|Mode|`stepsPerPhase`|Used for|Collision Avoidance|
|---|---|---|---|
|**Waypoint**|1|LGP tree search (fast, per-node cost estimate)|Global `FS_accumulatedCollisions` only|
|**Full Motion**|≥ 10|Final trajectory refinement|Per-pair `FS_negDistance` in cruise segment + accumulated in approach/pickup|

**Critical implication**: Any `addObjective` call guarded by `if (stepsPerPhase >= 10)` is invisible to the waypoint solver. Pre-grasp approach funnels and per-pair collision constraints only activate during full motion planning. The waypoint solver relies solely on final-pose constraints and the global collision budget.

## 8. Kinematic Switch Pattern

Every pick and place action creates a **virtual anchor frame** (free-DOF, named `pickPose_*` or `placePose_*`) and calls `addRigidSwitch(time, ...)` to transfer object ownership at the action boundary. This encodes the topological change (gripper ↔ world) into the KOMO timeline without modifying the world configuration directly.

## 9. Scene File — Frame Naming Convention

The file `generated/scene_named.g` is the canonical scene description. Frame names in `.lgp`/`.fol` files must exactly match it:

- Movable objects: `rect_1`…`rect_8`, `cube_1`…`cube_4`, `cyl_1`, `cyl_2`, `tri_1`
- Placement bases (thin, non-contact, kinematic targets): `Base_Left`, `Base_Right`, `Base_Center`, `Base_Top`, `Base_Bottom`
- Table-level slots: `Table_Left`, `Table_Right`, `Table_Front`, `Table_Back`, `Table_Center`
- Rect top patches: `Rect_1_Left`, `Rect_1_Right`, …, `Rect_8_Left`, `Rect_8_Right`
- Main table surface: `table`

## 10. Place Pose Convention (Current)

- In `action_place_straightOn`, the terminal placement target is defined by hard relative constraints: XY center alignment and Z contact height (`rel_z`) against the support frame.
- For non-cylindrical objects, the final face orientation follows the `+90deg` convention (`x_obj` aligned to `x_table`, i.e., `b-face forward`).
- Stage objectives around `time-0.2` are only active in full-motion mode (`stepsPerPhase >= 10`) to avoid waypoint-stage same-slice infeasibility.

## 11. Frame Alignment Traceability (Table/Patch -> Pick/Place)

This section records where table/patch frame orientation enters solver constraints and why patch rotation can affect the observed pick posture in a full motif solve.

### 11.1 Source of place frame orientation
- Scene files define placement frames explicitly in `.g` as `is_place` frames (for example `Table_Left`, `Table_Center`).
- Example current FMB experiment scene: `test/fmb_new_experiment/scene_new_fmb_preview.g`.

### 11.2 Where this is consumed in solver code
- Rule gate: `.fol` uses `DecisionRule place_straightOn` with `(is_place To)` and `(on To Obj)` pre/post conditions.
- Geometric enforcement is implemented in `rai/src/KOMO/manipTools.cpp`:
	- `ManipulationHelper::action_place_straightOn(...)`
	- `rai::Frame* targetF = komo->world.getFrame(table)` selects the support frame by name.
	- `rai::Transformation targetPose = targetF->ensure_X()` imports support-frame pose/orientation.
	- Terminal/approach orientation constraints are enforced via `FS_vectorZDiff` and `FS_scalarProductXX` against `{obj, table}`.
- Multi-support variant uses the same convention in `ManipulationHelper::action_place_on_multi_support(...)` by inheriting the first support orientation (`targetWorldPose = first_support->ensure_X()`).

### 11.3 Why a patch yaw can influence pick appearance
- In a motif solve, pick and place are optimized on one continuous trajectory with shared smoothness/control objectives.
- If the target place frame carries an extra yaw, place orientation constraints can pull earlier trajectory segments, which may appear as pre-grasp/pick frame misalignment.
- Practical example observed in FMB experiment: removing extra `d(90 0 0 1)` from `Table_Center` in `test/fmb_new_experiment/scene_new_fmb_preview.g` restored expected pick alignment consistency.
