# Cube stacking, Global, redundant mode: 6 and 7 cubes

`lgp_split_global` on the redundant (R) scenes, 5 target structures x 10 seeds = 50
trials per magnitude, 16GB memory cap.

Command: `python3 experiments/scripts/run_lgp_batch_eval.py --mags 6cubes 7cubes --mode r --lgp-modes lgp_split_global --timeout-s 3600 --max-mem-mb 16000`

## Results

| Magnitude | Success | Success rate | Mean solving time, successful trials |
|---|---|---|---|
| 6cubes | 29/50 | **58.0%** | **174.8s** |
| 7cubes | 19/50 | **38.0%** | **399.2s** |

These are the values in the Global / R column of `tab:planning_sr` and
`tab:planning_time` (Cube Stacking block).

## Failure breakdown

| Magnitude | Failed | Hit 16GB | Timed out | Other | Mean peak memory | Longest trial |
|---|---|---|---|---|---|---|
| 6cubes | 21 | 1 | 0 | 20 | 7.2GB | 753s |
| 7cubes | 31 | 31 | 0 | 0 | 15.3GB | 626s |

## Per scenario (successes / trials)

- **6cubes**: `s01` 0/10  `s02` 10/10  `s03` 10/10  `s04` 0/10  `s05` 9/10
- **7cubes**: `s01` 0/10  `s02` 9/10  `s03` 0/10  `s04` 0/10  `s05` 10/10

Outcomes are close to all-or-nothing per scenario rather than spread across
seeds, so Global's failures track the structure of the target rather than the
random trial.
