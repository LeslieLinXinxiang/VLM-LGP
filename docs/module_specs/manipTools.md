# Module: manipTools (Layer 2 - Module Spec)

## 1. Module Name
`KOMO/manipTools.cpp`

## 2. Responsibility
Translates high-level logical symbols (pick, place, place_straightOn, place_on_multi_support) into rigorous optimization objectives (Objectives/Features) for the KOMO non-linear solver. It ensures physical plausibility (no collisions) and goal achievement (target contacts).

## 3. Inputs
- `rai::Configuration` (the world state)
- `time` (phase timestamp)
- Object strings (e.g., `rect1`, `Base_Left`)

## 4. Outputs
- Internally appends constraints (`addObjective`, `addRigidSwitch`) to the `KOMO` objective list.

## 5. Public Functions
- `action_place_straightOn`: Standard single-support relative vertical placement.
- `action_place_on_multi_support`: Advanced multi-array relative placement.
- `action_pick_touch`: Gripper pre-grasp and grasp constraints.

## 6. Internal Functions
- `get_Z_dim()` lambda: Extracts the true vertical dimension of objects regardless of internal `shape->type` idiosyncrasies.

## 7. Dependencies
- Core `rai` physical data structures (`Frame`, `Shape`).
- `KOMO` objective definitions (`FS_positionDiff`, `FS_vectorZ`, `OT_eq`, `OT_sos`).

## 8. Forbidden Dependencies
- Hardcoded absolute World Z coordinates (prohibited to prevent hovering bugs).
- Overlapping/fighting soft constraints for exact tasks.

## 9. Failure Modes
- Over-constraining (leads to unsolvable graphs, `Fail`).
- Incorrect dimension extraction (e.g., using `size(0)` instead of `size(2)` leads to hovering or clipping).
