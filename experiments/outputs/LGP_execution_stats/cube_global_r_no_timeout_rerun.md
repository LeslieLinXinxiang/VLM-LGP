# Cube stacking Global-R re-run without the wall-clock cap

The cube-stacking planning results were produced with the runner's default
300s wall-clock cap, whereas FMB was later re-run with no cap (16GB memory cap
only). This re-runs the two magnitudes where that gap was expected to matter.

Command: `python3 experiments/scripts/run_lgp_batch_eval.py --mags 6cubes 7cubes --mode r --lgp-modes lgp_split_global --timeout-s 3600 --max-mem-mb 16000`

## What to change in the paper

Both tables, **Global / R column, Cube Stacking block** — no other cell moves.

| Table | Row | Currently | Change to |
|---|---|---|---|
| `tab:planning_sr` | 6 cubes | 57.1 | **58.0** |
| `tab:planning_sr` | 7 cubes | 3.7 | **38.0** |
| `tab:planning_time` | 6 cubes | 145.9 | **175.7** |
| `tab:planning_time` | 7 cubes | 295.8 | **379.9** |

### Success rate, in full

| Magnitude | In the paper (300s cap) | Re-run (no cap) | Change |
|---|---|---|---|
| 6cubes | 57.1% (28/49) | **58.0%** (29/50) | +0.9 |
| 7cubes | 3.7% (1/27) | **38.0%** (19/50) | +34.3 |

The old denominators are not 50: the paper's cube cells drop errored trials
from the denominator, so 57.1% is 28/49 and 3.7% is 1/27. The re-run is a clean
N=50 with no exclusions, matching how the FMB block of the same table is already
computed, so these two cells stop being the odd ones out.

## Why

| Magnitude | Timed out | Hit 16GB | Ran >300s | of those, succeeded | Longest |
|---|---|---|---|---|---|
| 6cubes | 0 | 1 | 1 | 0 | 753s |
| 7cubes | 0 | 31 | 20 | 19 | 626s |

No trial timed out at the raised 3600s limit, so the remaining failures are
genuine 16GB memory exhaustion rather than an imposed time budget.

## Solving time (successful trials)

| Magnitude | In the paper | Re-run |
|---|---|---|
| 6cubes | 145.9s | **175.7s** |
| 7cubes | 295.8s | **379.9s** |

Seven cubes rises because the successes the old cap cut off were the slow ones;
the cell now averages over 19 trials instead of 1.

## Per scenario (successes / trials)

- **6cubes**: `s01` 0/10  `s02` 10/10  `s03` 10/10  `s04` 0/10  `s05` 9/10
- **7cubes**: `s01` 0/10  `s02` 9/10  `s03` 0/10  `s04` 0/10  `s05` 10/10

Outcomes are close to all-or-nothing per scenario rather than spread across
seeds, so Global's failures track the structure of the target rather than the
random trial.

## Prose that quotes these numbers

The Execution-and-Planning paragraph states Global falls "to $56$--$57\%$ by
five to six cubes" and that its time grows "from $146$\,s at six cubes to
$296$\,s at seven". With the re-run, six cubes is $58.0\%$ / $175.7$\,s and
seven cubes is $38.0\%$ / $379.9$\,s, so both clauses need rewording. The claim
they support -- Global degrades with scale and most severely under redundancy --
still holds: seven cubes is still far below Smart's $100\%$, and eight cubes is
still $0\%$.

## Scope

Only `lgp_split_global` in R mode at 6 and 7 cubes was re-run. Smart, NR mode,
and the other magnitudes still carry their original 300s-capped results, so the
cube-stacking table mixes two time budgets.

Re-running the rest was considered and declined. Smart cannot be affected: its
median solving time is 19--53s against the 300s cap, and it already succeeds on
every cell, so there is nothing for extra time to change. Four and five cubes sit
at 23--64s, likewise far from the cap. That leaves Global at eight cubes, which
reports $0\%$ under redundancy with an average peak of 16.4GB -- bounded by the
16GB memory cap, not by time, so lifting the time budget would not move it.

## The raw data for the other cells no longer exists

The per-trial `trial_meta.json` files behind the rest of the cube-stacking table
were never committed -- across all branches and all of history, git has only one
cube `lgp_split_smart` record and no `lgp_split_global` record predating this
re-run -- and they are no longer on disk. The derived statistics in
`cross_magnitude_comparison.md` survive and are what the paper reports, but they
cannot be re-derived, audited, or checked for the `timeout` flag. The two cells
re-run here are the only cube-stacking cells with recoverable raw data.
