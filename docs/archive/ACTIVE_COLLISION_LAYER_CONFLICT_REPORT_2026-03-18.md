# Active Collision Layer Conflict Report (2026-03-18)

## 1. Scope and Method
This report answers three questions with source-backed facts only:
- Is lower-layer motion still adding broad collision constraints after upper-layer `explicitCollisions` is filtered?
- Which functions in `manipTools.cpp` conflict with upper explicit-pair semantics?
- Are there other conflict points outside `manipTools.cpp`?

Evidence is taken directly from current repository code paths used by runtime integration.

## 2. Executive Conclusion
Yes. Current runtime can have a semantic mismatch:
- Upper layer (`LGP_TAMP_Abstraction`) injects collision constraints only for `explicitCollisions`.
- Lower layer (`manipTools.cpp`) still adds additional collision constraints from dynamically built obstacle lists and accumulated-collision terms that are not bounded by explicit pairs.

Therefore, your judgment is correct: with current `bin/main.cpp` behavior, the next primary optimization/fix target is `manipTools.cpp`.

## 3. Verified Upper-Layer Behavior (Facts)
### 3.1 Runtime injection is explicit-pair + broad OFF
- `bin/main.cpp` sets:
  - `tamp->explicitCollisions = toStringAFlatPairs(active_pairs);`
  - `tamp->useBroadCollisions = false;`
- Evidence: `bin/main.cpp:389`, `bin/main.cpp:390`, `bin/main.cpp:403`, `bin/main.cpp:404`.

### 3.2 Explicit pairs are added in both waypoint and full-motion problems
- Waypoint stage:
  - `ways->addObjective({}, FS_distance, {pair...}, OT_ineq, {1e1});`
- Full-motion stage:
  - `path->addObjective({}, FS_distance, {pair...}, OT_ineq, {1e1});`
- Evidence: `rai/src/LGP/LGP_TAMP_Abstraction.cpp:23`, `rai/src/LGP/LGP_TAMP_Abstraction.cpp:56`.

### 3.3 Broad collision source flag comes from `genericCollisions`
- `useBroadCollisions = lgpConfig.get<bool>("genericCollisions");`
- Evidence: `rai/src/LGP/LGP_TAMP_default.cpp:49`.

## 4. Conflict Points in `manipTools.cpp` (Function-Level)

### 4.1 Global obstacle enumeration independent of explicit pairs
Pattern:
- Build `obstacles` by scanning almost all non-marker frames.
- Then add `FS_negDistance` over `(handPart, obs)` loops.

Affected functions:
- `ManipulationHelper::action_pick_cylinder`
  - Obstacle build: `rai/src/KOMO/manipTools.cpp:424`
  - Pair loop addObjective: `rai/src/KOMO/manipTools.cpp:483`
- `ManipulationHelper::action_pick`
  - Obstacle build: `rai/src/KOMO/manipTools.cpp:571`
  - Pair loop addObjective: `rai/src/KOMO/manipTools.cpp:591`
- `ManipulationHelper::action_place_straightOn`
  - Obstacle build: `rai/src/KOMO/manipTools.cpp:734`
  - Pair loop addObjective: `rai/src/KOMO/manipTools.cpp:774`
- `ManipulationHelper::action_place_on_multi_support`
  - Obstacle build: `rai/src/KOMO/manipTools.cpp:902`
  - Pair loop addObjective: `rai/src/KOMO/manipTools.cpp:939`

Why this conflicts:
- These constraints are generated from local obstacle heuristics, not from upper `explicitCollisions`.
- This can reintroduce pairs that upper layer intentionally filtered out.

### 4.2 Additional accumulated-collision constraints not tied to explicit list
Affected points:
- `action_pick_cylinder`: `FS_accumulatedCollisions` windows at `rai/src/KOMO/manipTools.cpp:464`, `rai/src/KOMO/manipTools.cpp:495`.
- `action_pick`: `FS_accumulatedCollisions` window at `rai/src/KOMO/manipTools.cpp:597`.
- `action_place_straightOn`: `FS_accumulatedCollisions` window at `rai/src/KOMO/manipTools.cpp:783`.

Why this conflicts:
- `FS_accumulatedCollisions` operates on aggregate collision state and is not scoped to explicit pair list in these calls.
- Even with upper explicit pair filtering, this term can still penalize collisions from other contacts.

### 4.3 Setup-level broad collision coupling (guarded by parameter)
- `setup_sequence` / `setup_motion` call `k().setConfig(C, accumulated_collisions)` and may add `FS_accumulatedCollisions` if enabled.
- Evidence: `rai/src/KOMO/manipTools.cpp:53`, `rai/src/KOMO/manipTools.cpp:60`, `rai/src/KOMO/manipTools.cpp:74`, `rai/src/KOMO/manipTools.cpp:81`.

Interpretation:
- In your current runtime, `tamp->useBroadCollisions=false` before full-motion call, so this specific switch should be OFF for that run path.
- But this remains a potential conflict source if any path sets `genericCollisions=true` or if call order changes.

## 5. Other Places Outside `manipTools.cpp`

### 5.1 Non-conflict but important parallel path in `LGP_Tool.cpp`
- `LGP_Tool.cpp` also has explicit-pair injection (`FS_distance`) in waypoint/full-motion helper path.
- Evidence: `rai/src/LGP/LGP_Tool.cpp:52`, `rai/src/LGP/LGP_Tool.cpp:506`.

Assessment:
- Not inherently conflicting with explicit collisions.
- But if mixed with `LGP_TAMP_Abstraction` path in future refactors, duplicate constraint injection risk should be checked.

### 5.2 RRT path uses explicit pairs correctly
- `setExplicitCollisionPairs(...)` and `useBroadCollisions` toggles are wired in LGP->RRT pipeline.
- Evidence: `rai/src/LGP/LGP_computers.cpp:310`, `rai/src/LGP/LGP_computers.cpp:311`, `rai/src/PathAlgos/ConfigurationProblem.cpp:36`.

Assessment:
- This is aligned with explicit strategy and is not a direct conflict point for current KOMO action constraints.

## 6. Root Cause Taxonomy (Source-Backed)
The mismatch is primarily pair-scope and scheduling related:
- Pair-set mismatch:
  - Upper: explicit pair whitelist (`FS_distance` on selected pairs only).
  - Lower: auto-generated obstacle loops (`FS_negDistance`) over local obstacle sets.
- Metric alias fact (important correction):
  - In this codebase, `FS_negDistance` is an alias of `FS_distance` (`FS_negDistance = FS_distance`).
  - Both map to `F_PairCollision(_negScalar, false)` in symbol dispatch.
  - Evidence: `rai/src/Kin/featureSymbols.h:77`, `rai/src/Kin/featureSymbols.cpp:143`.
- Time-window mismatch:
  - Upper explicit constraints are added globally over timeline (empty time interval `{}` in these calls).
  - Lower action constraints are phase-windowed (`time-1.0..time-0.2`, etc.), which can dominate local behavior even when pair-set differs.

Secondary source of behavior mismatch:
- Different objective targets/scales/margins are used across upper and lower constraints, so effective clearance behavior can diverge even when feature symbol is the same.

All three are directly visible in code sections cited above.

## 7. Concrete, Low-Risk Next-Step Recommendations
### 7.1 Main refactor target (recommended now)
Refactor only `manipTools.cpp` action-level collision generation first:
- Replace local obstacle scanning loops with explicit-pair filtered checks.
- Apply in this order:
  1. `action_pick`
  2. `action_pick_cylinder`
  3. `action_place_straightOn`
  4. `action_place_on_multi_support`

### 7.2 Interface change needed (minimal)
Current `ManipulationHelper` action functions do not receive explicit pair list directly.
To make lower layer obey upper filter, add a minimal data path:
- pass `explicitCollisions` from LGP action-constraint entry into `ManipulationHelper` (or store once in helper state before action calls),
- build a pair-lookup set,
- gate every `FS_negDistance` insertion by that lookup.

### 7.3 Keep these constraints unchanged in first pass
To isolate pair-set effect first, do not adjust these in the first patch:
- existing stage time windows,
- existing weights/scales,
- existing geometric target constraints (position/orientation).

## 8. Decision for Next Iteration
For the next engineering step, treat this as the official target:
- "Unify lower-layer `manipTools` collision pair generation with upper-layer `explicitCollisions` policy, without changing stage timings/weights in the first patch."

This target is directly consistent with current runtime code and observed mismatch sources.
