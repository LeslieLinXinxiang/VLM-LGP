# Track 2 Baseline (Eq.7 Naive Interpolation) — FMB Results

N = 300 trials (3 magnitudes [3/4/5 objs] x 5 scenarios x 2 redundancy modes x 10 seeds, full
matrix). Same success/collision definitions as the Cube Stacking report. Run after fixing:
(a) the concave-mesh convex-hull-inflation collision bug (CoACD decomposition for shape_4_1/
shape_3_1/base_board), (b) the `parse_and_inject` permutation-rename bug in the shared
`execute_phase0()` reordering step (see project notes / core/utils.py).

## Overall
- success rate: 0/300 = 0.0%
- collision rate: 174/300 = 58.0%
- action-level: 169/1200 actions IK-completed (14.1%), 307/1200 had a collision (25.6%)

## By magnitude (task_size_n)

| mag | N | success | collision |
|---|---|---|---|
| 3objs | 100 | 0.0% | 48.0% |
| 4objs | 100 | 0.0% | 61.0% |
| 5objs | 100 | 0.0% | 65.0% |

## By magnitude x redundancy mode

| mag | mode | N | success | collision |
|---|---|---|---|---|
| 3objs | nr | 50 | 0.0% | 44.0% |
| 3objs | r | 50 | 0.0% | 52.0% |
| 4objs | nr | 50 | 0.0% | 62.0% |
| 4objs | r | 50 | 0.0% | 60.0% |
| 5objs | nr | 50 | 0.0% | 62.0% |
| 5objs | r | 50 | 0.0% | 68.0% |

## Comparison with Cube Stacking

| metric | Cube Stacking | FMB |
|---|---|---|
| overall success | 3.4% | 0.0% |
| overall collision rate | 89.4% | 58.0% |
| action-level completed | 45.1% | 14.1% |
| action-level collision | 43.2% | 25.6% |
| action-level "clean" failure (no collision, didn't complete) | 11.7% | 60.3% |

The two benchmarks fail for DIFFERENT dominant reasons. Cube Stacking's naive baseline mostly
fails from collision (no avoidance as stack height grows). FMB's naive baseline mostly fails
from unreachability (60.3% of actions neither complete nor collide - the straight-line IK
target is simply never reached, distinct from a collision-caused failure) - consistent with
what individual isolated-object testing already showed repeatedly (shape_2_2, shape_3_1,
shape_3_3, and shape_4_1 in several scenarios all failed this exact clean-`ik_failure` way, with
zero collision, apparently because FMB's assembly parts sit at more constrained
positions/orientations - closer to the arm's own reach limits and self-obstruction - than
Cube Stacking's more open tabletop layout). This is why FMB's overall success rate (0.0%) is
even lower than Cube Stacking's (3.4%) despite its LOWER collision rate: a trial only needs ONE
action to fail by either mechanism to fail the whole trial, and FMB's per-action failure
probability from unreachability alone is already high enough that no trial in the full 300
happened to get every single action through cleanly.

## Notes
- Reuses the same fully-validated Phase 1-3 pipeline as Cube Stacking; no separate execution
  engine for FMB, only benchmark-specific path/naming glue in
  `baseline_naive_interp_run_batch.py::main_fmb`.
- Grasp-height offset and mesh-collision-inflation issues (found via per-shape isolated
  testing before this batch run) are fixed and reflected in this run.
