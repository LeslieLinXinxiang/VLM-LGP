# Module: manipTools (Layer 2 - Module Spec)

## 1. Module Name
`KOMO/manipTools.cpp`

## 2. Responsibility
Translates high-level logical symbols (pick, place, place_straightOn, place_on_multi_support) into rigorous optimization objectives (Objectives/Features) for the KOMO non-linear solver. It ensures physical plausibility (no collisions) and goal achievement (target contacts).

## 3. Inputs
- `rai::Configuration` (the world state)
- `time` (phase timestamp)
- Object strings (e.g., `rect_1`, `Base_Left`) — naming must exactly match frame names in `generated/scene_named.g`

## 4. Outputs
- Internally appends constraints (`addObjective`, `addRigidSwitch`) to the `KOMO` objective list.

## 5. Public Functions

### `action_pick(str action, double time, str gripper, str obj)`
- **Actions**: `"pick_touch"` or `"pick_box"`.
- **Kinematic switch**: Creates `pickPose_<gripper>_<obj>_<time>` as a free-DOF anchor parented to gripper; `addRigidSwitch` at `time` to bind `obj`.
- **Pre-grasp funnel** (only when `stepsPerPhase >= 10`): Z-guidance at `time-0.3` (5cm), XY corridor `{time-0.3, time}`, orientation lock `FS_vectorZDiff` + `FS_scalarProductXY` through descent.
- **Final grasp constraints at `time`**: XY equality (`FS_positionRel` masked X and Y separately, weight 1e2); Z ±5mm window (`OT_ineq`, weight 1e2, limit 0.005m each side).
- **Collision avoidance** (only `stepsPerPhase >= 10`): `FS_negDistance` per pair for gripper parts against all obstacles from `time-1.0` to `time-0.3`; `FS_accumulatedCollisions` for descent segment `{time-0.3, time}`.
- **Known issue**: Carried object (`obj`) is NOT itself included in collision checking during the pre-grasp approach. The `isTable` string filter excludes only frames whose name contains `"table"`.

### `action_pick_cylinder(double time, str gripper, str obj)`
- Dedicated to cylindrical objects.
- Constrains XY at `time` via 2-row matrix mask; Z position via `ineq` within `0.5*size(0) - margin`.
- Three-stage collision: exit segment (t-1~t-0.9), cruise (t-0.9~t-0.2), grasp (t-0.2~t).

### `action_place_straightOn(str action, double time, str obj, str table)`
- **Kinematic switch**: Creates `placePose_<table>_<obj>_<time>` as a free-DOF anchor parented to world; initialized at `targetF.pos + rel_z`; `addRigidSwitch` at `time`.
- **`rel_z` computation**: `0.5 * (get_Z_dim(targetF) + get_Z_dim(objF))` — correct for `ST_ssBox` (size(2) = full height) and `ST_cylinder` (size(0) = full height).
- **Three-stage skeleton** (only when `stepsPerPhase >= 10`):
  - `time-0.2`: hard lock XYZ to `{0, 0, rel_z+6cm}` above target (`OT_eq`).
  - `{time-0.2, time}`: hard lock `FS_vectorZDiff` + `FS_scalarProductXX` (orientation corridor).
  - `{time-0.2, time}`: hard lock XY=0 descent channel.
- **Final constraints at `time`**: Z height `FS_positionDiff OT_eq` (weight 1e2); XY centering (weight 1e2); `FS_vectorZDiff` upright; `FS_scalarProductXX {1.}` b-face forward (non-cylinder only).
- **Collision avoidance** (only `stepsPerPhase >= 10`): `FS_negDistance` per explicit pair (cruise `time-0.7~time-0.3`); `FS_accumulatedCollisions` for descent `{time-0.3, time}`.
- **Known issues**:
  1. `isTable` string filter excludes only frames whose name contains `"table"`, not `Base_Left`/`Base_Right`/`Base_Center`. **Partially mitigated** by `isPairAllowedByExplicitFilter` gate — only explicit pairs now trigger `addObjective`.
  2. Z height constraint weight (1e2) equals global collision weight (1e2) → optimizer can slightly embed object into table surface.

### `action_place_on_multi_support(double time, str obj, StringA supports)`
- Places `obj` centered over multiple support frames (calculates centroid).
- Uses a **virtual anchor** (`virtualAnchor_for_<obj>_<time>`) parented to world as the position reference target only (orientation is NOT derived from anchor).
- **Orientation at `time`**: `FS_vectorZDiff {obj, supports(0)}` upright + `FS_scalarProductXX {obj, supports(0)} {1.}` b-face forward (non-cylinder only).
- **Three-stage skeleton** (only `stepsPerPhase >= 10`):
  - `time-0.2`: hard lock XYZ to `{0, 0, rel_z+6cm}` above `supports(0)` (`OT_eq`).
  - `{time-0.2, time}`: hard lock `FS_vectorZDiff` + `FS_scalarProductXX` (orientation corridor) against `supports(0)`.
  - `{time-0.2, time}`: hard lock XY=0 descent channel against `supports(0)`.
- **Collision avoidance**: only exit segment `time-0.95~time-0.8`; final placement segment unconstrained (commented out).

## 6. Internal Functions
- `get_Z_dim()` lambda: Extracts the true vertical dimension of objects regardless of `shape->type`. Returns `size(0)` for cylinders, `size(2)` for boxes. Returns 0 for frames without shape.

## 7. Key Design Invariants
- All placement heights use **relative coordinates** (`FS_positionDiff` or `FS_positionRel`) — never absolute world Z. This is mandatory to avoid dependence on the global scene origin.
- The `stepsPerPhase >= 10` guard separates **waypoint mode** (fast, minimal constraints) from **full motion planning** (precise, multi-stage collision avoidance). Waypoint mode is the default for LGP tree search.
- Kinematic switch (`addRigidSwitch`) fires at the exact `time` boundary to transfer object ownership from one kinematic chain to another.

## 8. Dependencies
- Core `rai` physical data structures (`Frame`, `Shape`).
- `KOMO` objective definitions (`FS_positionDiff`, `FS_positionRel`, `FS_vectorZ`, `FS_quaternionDiff`, `FS_negDistance`, `FS_accumulatedCollisions`, `OT_eq`, `OT_ineq`, `OT_sos`).

## 9. Forbidden Dependencies
- Hardcoded absolute World Z coordinates (prohibited to prevent hovering bugs).
- Overlapping/fighting soft constraints for exact tasks (e.g., adding both `OT_sos` and `OT_eq` to the same position feature at the same time).

## 10. Failure Modes
- Over-constraining (leads to unsolvable graphs, `Fail` in LGP output).
- Incorrect dimension extraction (e.g., using `size(0)` instead of `size(2)` leads to hovering or clipping).
- Weight collisions: equal-weight equality (Z height) vs inequality (collision) → optimizer compromises → object embeds in surface.
- `isTable` string filter bug: placement onto named bases (`Base_Left` etc.) incorrectly adds those frames to obstacles.

## 11. Scene File Naming Convention
Object frame names in `.lgp`/`.fol` files **must exactly match** names in `generated/scene_named.g`:
- Movable objects: `rect_1` … `rect_8`, `cube_1` … `cube_4`, `cyl_1`, `cyl_2`, `tri_1`
- Placement bases: `Base_Left`, `Base_Right`, `Base_Center`, `Base_Top`, `Base_Bottom`
- Table slots: `Table_Left`, `Table_Right`
- Rect top patches: `Rect_1_Left`, `Rect_1_Right`, … `Rect_8_Left`, `Rect_8_Right`
- Main table: `table`

## 12. Motion-Grasp Decoupling (Implemented 2026-03-19)

### 12.1 Implemented Boundary
- `manipTools` contribution focuses on motion planning quality via deterministic vertical micro-actions around the terminal segment, not integrated grasp-contact shaping.

### 12.2 Implemented Behavior for `action_pick`
- `time-1.0 ~ time-0.7`: velocity guidance to lift `+6cm` over current gripper frame.
- At `time-0.3`: hard XYZ lock to object-top waypoint (`{0, 0, kLift}` relative to target).
- `{time-0.3, time}`: orientation corridor (`FS_vectorZDiff + FS_scalarProductXY`) + XY=0 channel + downward velocity guidance.
- Collision policy: `FS_negDistance` per explicit pair in `time-0.7~time-0.3` (cruise); `FS_accumulatedCollisions` in `{time-0.3, time}` (descent).

### 12.3 Implemented Behavior for `action_place_straightOn` and `action_place_on_multi_support`
- `time-0.2`: hard XYZ lock to destination top waypoint (`{0, 0, rel_z+6cm}`).
- `{time-0.2, time}`: hard orientation corridor (`FS_vectorZDiff + FS_scalarProductXX`) + XY=0 descent channel.
- Collision policy: cruise `FS_negDistance` per explicit pair in `time-0.7~time-0.3`; `FS_accumulatedCollisions` in `{time-0.3, time}`.

### 12.4 Improvement
- Reduced objective interference in problematic windows `time-1.0~time-0.6` and `time-0.2~time`.
- Improved smoothness by replacing mixed near-contact optimization with deterministic terminal motion.
