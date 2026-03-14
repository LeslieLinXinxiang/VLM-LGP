# DDR-20260313-waypoint-gated-constraint-reachability

## Decision Question
For TAMP runtime optimization in this project, should we use waypoint-layer data as the shared gate for both:
1. active collision-constraint selection (`coll` explicit pairs), and
2. pick reachability pre-check?

## Options Considered
- A: Distance-only active set; no waypoint-based reachability gate.
- B: Use waypoint data as a shared gate for both active-set and reachability.
- C: Keep current behavior (no active-set gate, no explicit reachability pre-check).

## Selected Option
B

## Why Selected
- Waypoint is already the front stage of the current main pipeline and is available before full-motion optimization.
- One data source serves two filters: collision-pair activation and pick reachability screening.
- This preserves the existing `.lgp -> coll -> explicitCollisions` integration path with minimal architecture disruption.
- It directly targets current bottleneck (full-motion solve time) while retaining a fallback path.

## Method Definition (Scope-locked)
This DDR fixes only method direction and a lightweight implementation shape. Exact factory insertion points are intentionally deferred.

### 1) Shared Waypoint-Gated Workflow
1. Generate/solve waypoint-stage candidates for task actions.
2. For each pick action, perform reachability pre-check using waypoint solvability signal.
3. For actions that pass pre-check, derive a local obstacle neighborhood around relevant waypoint poses.
4. Convert selected object pairs to explicit collision pairs and write to `.lgp` `coll` field.
5. Keep `genericCollisions` as global safety net.

### 2) Reachability Gate Rule
- If pick waypoint for a candidate task/object is infeasible, mark candidate as rejected and continue to next candidate.
- This is a pre-filter, not a final feasibility proof for full-motion.

### 3) Active Constraint Set Rule
- Activated explicit pairs are generated from waypoint-local neighborhoods (robot links + payload neighborhood + destination neighborhood).
- Pair list is bounded (top-k / radius threshold) to reduce over-constraint volume.
- If downstream full-motion fails, fallback policy expands active set and retries.

## Non-Goals
- No friction-cone modeling in this phase.
- No decision yet on exact code insertion module/factory or deep nested LGP refactor.
- No guarantee that waypoint and full-motion constraints are equivalent.

## Clarification: Current Main Pipeline vs Alternative Framework
Current main pipeline in this repository:
- `bin/main.cpp` -> `default_LGP_TAMP_Abstraction(...)` -> `LGP_Tool::solve()` -> `get_fullMotionProblem(true)`.

Alternative framework (not current default runtime path):
- `LGP_computers.cpp` compute-node stack (`LGPComp_root` / `LGPcomp_Skeleton` / `LGPcomp_Waypoints` / `LGPcomp_RRTpath` / `LGPcomp_OptimizePath`) mainly used by `LGP_SkeletonTool` flows.
- It provides a richer tree-compute decomposition and RRT-bridged path initialization, but is not the default path used by current batch execution in `bin/main.cpp`.

## Lightweight Implementation Sketch (No factory lock-in)
- Step 1: Add a waypoint-evaluation utility that outputs per-pick feasibility + waypoint poses.
- Step 2: Add a pair-selector utility that maps waypoint-local neighborhoods to explicit collision pairs.
- Step 3: Inject selected pairs into generated `.lgp` `coll` field.
- Step 4: Add retry policy: on full-motion fail, enlarge radius/top-k and regenerate pairs.

## Impacted Files
- `docs/decisions/DDR-20260313-waypoint-gated-constraint-reachability.md`
- `docs/README.md`
- `docs/decisions/README.md`

## Notes
- This decision is compatible with current Layer 0-4 documents and does not require RFC at this stage.
- If later we decide to alter Layer architecture contracts or replace main solver entry flow, run RFC first.
