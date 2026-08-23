# Track 2 Baseline (Eq.7 Naive Interpolation) — Cube Stacking Results

N = 500 trials (5 magnitudes x 5 scenarios x 2 redundancy modes x 10 seeds, full matrix).

`success` = every action in the trial completed (IK converged, landed near target) AND no collision violation anywhere in the trajectory.
`collision_violation` = the arm or the carried object made unintended contact with something else at any point (not just the final state).

This supersedes the first run (see "vs. previous run" below) - the orientation fix (place logic
was resetting the HAND to canonical yaw instead of the OBJECT, so rectangular blocks landed 90°
off) and the `parse_and_inject` permutation-rename fix (see project notes) were both applied
after the first run's data was collected.

## Overall
- success rate: 17/500 = 3.4%
- collision rate: 447/500 = 89.4%
- penetration depth among collided trials (mm): min=-30.9, max=-0.0, mean=-15.0
- action-level: 1353/3000 actions IK-completed (45.1%), 1296/3000 had a collision (43.2%)

## By magnitude (task_size_n)

| mag | N | success | collision |
|---|---|---|---|
| 4cubes | 100 | 12.0% | 81.0% |
| 5cubes | 100 | 3.0% | 82.0% |
| 6cubes | 100 | 0.0% | 100.0% |
| 7cubes | 100 | 0.0% | 97.0% |
| 8cubes | 100 | 2.0% | 87.0% |

## By magnitude x redundancy mode

| mag | mode | N | success | collision |
|---|---|---|---|---|
| 4cubes | nr | 50 | 16.0% | 78.0% |
| 4cubes | r | 50 | 8.0% | 84.0% |
| 5cubes | nr | 50 | 2.0% | 78.0% |
| 5cubes | r | 50 | 4.0% | 86.0% |
| 6cubes | nr | 50 | 0.0% | 100.0% |
| 6cubes | r | 50 | 0.0% | 100.0% |
| 7cubes | nr | 50 | 0.0% | 96.0% |
| 7cubes | r | 50 | 0.0% | 98.0% |
| 8cubes | nr | 50 | 4.0% | 92.0% |
| 8cubes | r | 50 | 0.0% | 82.0% |

## Failure reason breakdown (non-success trials, n=483)
- collision: 447
- ik_failure_or_incomplete (no collision, IK never converged): 36

## vs. previous run

| metric | previous | current | delta |
|---|---|---|---|
| overall success | 2.8% (14/500) | 3.4% (17/500) | +0.6pp |
| overall collision rate | 95.2% (476/500) | 89.4% (447/500) | -5.8pp |
| action-level IK-completed | 35.5% | 45.1% | +9.6pp |
| action-level collision | 58.6% | 43.2% | -15.4pp |
| mean penetration depth (collided trials) | -16.9mm | -15.0mm | -1.9mm |
| 8cubes success | 0.0% | 2.0% | +2.0pp |
| 8cubes collision | 94.0% | 87.0% | -7.0pp |

The orientation fix meaningfully improved per-action correctness (fewer individual pick/place
actions fail or collide - the ~10pp action-level swing is the real signal here), but overall
trial success stays low because a trial only counts as successful if EVERY action in its
sequence completes cleanly - one bad placement anywhere in an 8-action sequence still fails the
whole trial. The core finding is unchanged and, if anything, more cleanly demonstrated now that
the orientation-caused failures are gone: naive straight-line interpolation with no collision
avoidance degrades sharply with task complexity (12% -> 3% -> 0% -> 0% -> 2% success as
magnitude goes 4 -> 5 -> 6 -> 7 -> 8 cubes), with collision violation as the dominant failure
mode at every magnitude beyond the smallest.

## Notes
- FMB benchmark: in progress (Track 2 §"Next" in project notes) - Cube Stacking is Phase 5's
  fully-validated matrix; FMB extension is the remaining work.
- Wall time: ~time for 500 trials (video recording off; screenshot only), run in two resumed
  segments due to the background process being killed between sessions (see project notes) -
  `--skip-existing` correctly resumed both times.
