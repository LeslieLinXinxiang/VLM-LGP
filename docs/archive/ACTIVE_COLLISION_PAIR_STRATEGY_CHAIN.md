# Active Collision Pair Strategy Chain (Option B Baseline)

## 1. Purpose
This document records the current stable active-collision strategy chain and the identified coverage blind spot, so the next refinement step can be implemented against a frozen baseline.

## 2. Scope
- Runtime path only (`bin/main.cpp`) for subtask-level full-motion injection.
- LGP/KOMO wiring for broad-collision switch propagation.
- Reporting path for pair visibility and solver-time tracking.

## 3. End-to-End Chain (Code-Level)

### 3.1 Pair Candidate Extraction (Waypoint-driven)
File: `bin/main.cpp`

1. `extractActivePairsFromWaypoints(ways, radius_m)`
- Build per-time-slice snapshots from solved waypoint KOMO.
- Detect moving centers via frame displacement across consecutive snapshots.
- For each moving center, collect nearby frames within `radius_m` and generate pair candidates.

2. `keepPairsPresentInConfig(active_pairs, C_initial_step)`
- Remove pair entries whose frame names are not valid in the current configuration.

3. `toStringAFlatPairs(active_pairs)`
- Flatten pair list into `StringA` accepted by TAMP abstraction.

### 3.2 Runtime Injection and Solver Control
File: `bin/main.cpp`

Before full-motion solve in each `.lgp` subtask:
- `tamp->explicitCollisions = toStringAFlatPairs(active_pairs)`
- `tamp->useBroadCollisions = false`

Then execute:
- `PTR<KOMO> solved_komo = lgp.get_fullMotionProblem(true)`
- `rai::NLP_Solver(solved_komo->nlp(), 0).solve()`

Result: full-motion uses explicit active pairs only (baseline mode), without broad global collision objective injection.

### 3.3 LGP -> KOMO Broad-Collision Wiring
File: `rai/src/LGP/LGP_TAMP_default.cpp`

- `useBroadCollisions` is read from `.lgp` key `genericCollisions`.
- `setup_sequence(...)` receives `useBroadCollisions`.
- `setup_motion(...)` receives `useBroadCollisions`.

Runtime override in `bin/main.cpp` sets `useBroadCollisions=false` specifically for per-subtask full-motion execution.

### 3.4 Reporting and Observability
File: `bin/main.cpp`

- Terminal: per-subtask line with radius and pair count.
- Terminal: final table `ACTIVE COLLISION PAIRS (PER SUBTASK)`.
- File: `<task_dir>/active_collision_report.json` with:
  - `radius_m`
  - per-subtask `pair_count`
  - `full_motion_solver_ms`
  - full `pairs` list

## 4. Current Stable Parameters
- `active_radius_m = 0.05`
- Runtime explicit collision injection enabled.
- Runtime broad collisions disabled for full-motion.

## 5. Known Barrier (Current)
Observed issue:
- Pair coverage appears center-biased in some subtasks.
- Neighbor context objects that are physically near the task object are not always reflected as expected in `pairs`.

User-provided example:
- In `step_3_batch_2`, around `cube_4` placement neighborhood, expected nearby context awareness (for example around `rect_2` / `cube_3` neighborhood) is considered incomplete by task expectation.

## 6. Why This Can Happen
With center-driven expansion, recall depends on:
1. Which frames are detected as moving centers.
2. Whether nearby objects enter the radius neighborhood for those centers at sampled times.
3. Whether pair generation is dominated by task-object-centric motion windows.

This means local context pair recall can be unstable when neighboring objects are mostly static and only indirectly relevant.

## 7. Next Refinement Direction (For Follow-up)
1. Add secondary neighborhood sweep around task-object final region, not only moving centers.
2. Add optional contextual expansion for top-k nearest static neighbors of task object/gripper per subtask.
3. Keep runtime-only injection and reportability unchanged for A/B comparability.
