# LGP Waypoint Reachability + Manipulability Coupling Execution (Ubuntu)

- Date: 2026-03-30
- Scope: Restore native LGP waypoint reachability gate, couple with current manipulability ranking, run on Ubuntu runtime.
- Constraint: This document is execution-only; no source-code modification required.

## 1) Positioning and wording strategy (for paper/report)

## 1.1 FCL + libccd vs “native CCD”

Practical distinction:

- **FCL + libccd**: two-layer collision stack.
  - FCL: scene-level collision interface and pair management (broad phase + query orchestration).
  - libccd: convex narrow-phase CCD/GJK/EPA kernel used underneath.
- **Native CCD (single kernel directly exposed)**: directly calling one CCD kernel for pairwise collision/distance, usually without full scene broad-phase/pair orchestration.

So `FCL + libccd` is not contradictory; it is a common “engine + kernel” composition.

Repository evidence:

- dependency installation includes `libccd` and `fcl`: [README.md](../README.md#L88-L89), [rai/README.md](../rai/README.md#L82-L83)
- build config links `fcl ccd`: [rai/CMakeLists.txt](../rai/CMakeLists.txt#L144)
- runtime interfaces use `coll_fcl`/`coll_stepFcl`: [rai/src/Kin/kin.cpp](../rai/src/Kin/kin.cpp#L2224-L2306)

## 1.2 How to avoid over-emphasizing LGP dependency

Recommended expression principle:

- Emphasize **method function** first: waypoint-level kinematic feasibility gate + collision feasibility gate.
- Emphasize **native collision stack** second: FCL-based collision queries with CCD narrow-phase backend.
- Mention LGP as **solver carrier**, not novelty core.

Suggested Chinese phrasing:

> 我们采用了 waypoint 级的几何可行性门控，并直接使用底层原生碰撞功能完成可达性判定；工程上采用 FCL 场景碰撞查询与 CCD 窄相几何核的组合实现。

Suggested English phrasing:

> We use a waypoint-level geometric feasibility gate and directly leverage native collision functionality for reachability decisions, implemented with FCL-based scene collision queries and a CCD narrow-phase backend.

Short alternative (if reviewer asks “is this pure LGP?”):

> LGP is used as the optimization carrier, while the reachability gate is defined by native kinematic/collision feasibility checks at waypoint level.

---

## 2) Coupled execution target (current requirement)

Goal:

1. Use native LGP waypoint solver to classify object reachability (`feasible` / `infeasible`).
2. Synchronize infeasible IDs into manipulability pipeline as banned points.
3. Rank only the remaining feasible objects by manipulability.

Current data contract in repo:

- Reachability output contract: [generated/infeasible_objects.json](../generated/infeasible_objects.json)
- Manipulability input uses the above contract and derives feasible set by set subtraction.

Code anchors:

- waypoint reachability split: [core/phase0_parser.py](../core/phase0_parser.py#L194-L268)
- checker launcher: [test/reachability/run_pick_waypoint_check.py](../test/reachability/run_pick_waypoint_check.py#L10-L72)
- feasible derivation from infeasible map: [test/manipulability/urdf_static_manipulability.py](../test/manipulability/urdf_static_manipulability.py#L515-L555)
- manipulability ranking report: [test/manipulability/urdf_static_manipulability.py](../test/manipulability/urdf_static_manipulability.py#L606-L748)

---

## 3) Ubuntu runtime execution SOP

## 3.1 Runtime shell (mandatory)

```bash
source /home/leslie/anaconda3/etc/profile.d/conda.sh
conda activate vlm_jazzy
source scripts/env.sh
```

## 3.2 Build native binaries

```bash
cd bin
make -j$(nproc)
```

If waypoint checker is missing, build its target explicitly:

```bash
make pick-waypoint
```

## 3.3 Run Phase0 with legacy waypoint reachability gate

Option A (direct script default):

```bash
python3 pipeline/run_phase0.py
```

Option B (explicit mode lock):

```bash
python3 - <<'PY'
from pipeline.run_phase0 import execute_phase0
ret = execute_phase0(reachability_mode="legacy_checker")
print(ret)
PY
```

Expected artifact:

- [generated/infeasible_objects.json](../generated/infeasible_objects.json)

## 3.4 Run manipulability ranking on feasible remainder

```bash
python3 test/manipulability/run_static_manipulability_test.py \
  --layout generated/phase0_layout.json \
  --infeasible generated/infeasible_objects.json \
  --g-file unnamed.g \
  --urdf rai/test/newLGP/rai-robotModels/panda/panda_arm_hand.urdf
```

Expected artifacts:

- [generated/feasible_objects_static_test.json](../generated/feasible_objects_static_test.json)
- [generated/ordering_score_report_static_test.json](../generated/ordering_score_report_static_test.json)

---

## 4) Acceptance checklist

A run is accepted if all conditions hold:

1. `generated/infeasible_objects.json` exists and schema contains `status/scene_path/infeasible_objects/errors`.
2. `generated/feasible_objects_static_test.json` excludes all IDs in `infeasible_objects`.
3. `generated/ordering_score_report_static_test.json` contains only feasible candidates for ranking.
4. In report narrative, method wording follows Section 1.2 (native feasibility gate + collision backend first, LGP as carrier).

---

## 5) Suggested report paragraph (ready to paste)

> We execute a waypoint-level feasibility gate before ranking. Reachability is decided by native kinematic/collision feasibility checks, implemented through FCL-based collision queries with a CCD narrow-phase backend. Objects marked infeasible are removed from the candidate set, and manipulability ranking is computed only over the remaining feasible objects.
