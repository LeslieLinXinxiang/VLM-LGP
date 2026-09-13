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
| 6cubes | 57.1% | **58.0%** (29/50) | +0.9 |
| 7cubes | 3.7% | **38.0%** (19/50) | +34.3 |

The re-run is a clean N=50 -- every trial counted, nothing dropped -- which is
how the FMB block of the same table is computed. Neither printed value resolves
to k/50 (57.1% and 3.7% are not multiples of 2 percentage points), so the two cells were previously computed
over a smaller denominator, but the exact one cannot be read off a rounded
percentage and the underlying trials are not in this checkout.

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

## Open: where the other cube cells' numbers come from

Not a task for this change, and nothing else should be edited on account of it.
Recorded only so the question is not re-derived from scratch later.

The per-trial `trial_meta.json` for the other cube cells is not in this checkout,
and no `lgp_split_global` record predating this re-run appears anywhere in git
history. Those runs were done, so the data exists in some form elsewhere -- it
simply is not here, which is why the cells were not verified against raw data
the way the FMB and VLM-MSGraph blocks were (both check out exactly, 18/18 and
16/16 against their raw trials).

One thing to be aware of when that data turns up: the Global/NR figures in
`tab:planning_sr` (100.0, 96.7, 100.0, 93.3, 60.0) are higher than the
corresponding rows of `cross_magnitude_comparison.md` (80.0, 58.0, 60.0, 56.0,
60.0), which reports 50 trials per cell. The success counts implied by both are
the same -- 40, 29, 30, 28, 30 -- so the two differ only in denominator, the
paper's being 40 or 30 where the report uses 50. Whether that reflects a later
re-run or a different denominator convention cannot be settled from this
checkout; the source of the Global/NR column is the thing to check.
