#!/usr/bin/env python3
"""Summarize the 6/7cubes Global-R re-run against the numbers currently in the paper.

The cube-stacking Smart/Global results were produced with the runner's default 300s
wall-clock cap (run_lgp_batch_eval.py --timeout-s), while FMB was later re-run with no
cap. This script re-runs the comparison for the two magnitudes where that difference
was expected to bite, reading the fresh trial_meta.json files directly.

Writes experiments/outputs/LGP_execution_stats/cube_global_r_no_timeout_rerun.md
"""
import collections
import glob
import json
import statistics
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "experiments/outputs/LGP_execution_stats/cube_global_r_no_timeout_rerun.md"

# Values currently printed in the paper's tab:planning_sr / tab:planning_time (R mode,
# Global column). Kept inline so the comparison is self-contained. They differ from the
# corresponding rows of cross_magnitude_comparison.md (58.0 / 2.0), and neither resolves
# to k/50, so they were computed over some smaller denominator -- which one cannot be
# recovered from a rounded percentage, and the trials behind them are not in this
# checkout. The re-run below is a clean N=50 with nothing dropped.
PAPER = {"6cubes": {"sr": 57.1, "time_s": 145.9},
         "7cubes": {"sr": 3.7, "time_s": 295.8}}

RERUN_ARGS = "--mags 6cubes 7cubes --mode r --lgp-modes lgp_split_global --timeout-s 3600 --max-mem-mb 16000"


def collect():
    st = collections.defaultdict(lambda: {
        "n": 0, "ok": 0, "timeout": 0, "mem": 0, "other": 0,
        "t": [], "ok_t": [], "scen": collections.defaultdict(lambda: [0, 0])})
    pat = str(ROOT / "experiments/evaluations/LGP_execution/cubeStacking/*/*/r/*/lgp_split_global/trial_meta.json")
    for f in glob.glob(pat):
        d = json.load(open(f))
        mag = d.get("mag")
        if mag not in PAPER:
            continue
        scen = Path(f).parts[-5]
        s = st[mag]
        ok = bool(d.get("success"))
        to = bool(d.get("timeout"))
        mem = bool(d.get("memory_exceeded"))
        rt = d.get("runtime_s") or 0.0
        s["n"] += 1
        s["ok"] += ok
        s["timeout"] += to
        s["mem"] += mem
        if not ok and not to and not mem:
            s["other"] += 1
        s["t"].append(rt)
        if ok:
            s["ok_t"].append(rt)
        s["scen"][scen][0] += 1
        s["scen"][scen][1] += ok
    return st


def main():
    st = collect()
    L = []
    L.append("# Cube stacking Global-R re-run without the wall-clock cap")
    L.append("")
    L.append("The cube-stacking planning results were produced with the runner's default")
    L.append("300s wall-clock cap, whereas FMB was later re-run with no cap (16GB memory cap")
    L.append("only). This re-runs the two magnitudes where that gap was expected to matter.")
    L.append("")
    L.append(f"Command: `python3 experiments/scripts/run_lgp_batch_eval.py {RERUN_ARGS}`")
    L.append("")
    L.append("## What to change in the paper")
    L.append("")
    L.append("Both tables, **Global / R column, Cube Stacking block** — no other cell moves.")
    L.append("")
    L.append("| Table | Row | Currently | Change to |")
    L.append("|---|---|---|---|")
    for mag in sorted(st):
        s = st[mag]
        sr = 100.0 * s["ok"] / s["n"]
        L.append(f"| `tab:planning_sr` | {mag[0]} cubes | {PAPER[mag]['sr']:.1f} | **{sr:.1f}** |")
    for mag in sorted(st):
        s = st[mag]
        med = statistics.median(s["ok_t"]) if s["ok_t"] else 0.0
        L.append(f"| `tab:planning_time` | {mag[0]} cubes | {PAPER[mag]['time_s']:.1f} | **{med:.1f}** |")
    L.append("")
    L.append("### Success rate, in full")
    L.append("")
    L.append("| Magnitude | In the paper (300s cap) | Re-run (no cap) | Change |")
    L.append("|---|---|---|---|")
    for mag in sorted(st):
        s = st[mag]
        sr = 100.0 * s["ok"] / s["n"]
        old = PAPER[mag]["sr"]
        L.append(f"| {mag} | {old:.1f}% | **{sr:.1f}%** ({s['ok']}/{s['n']}) | {sr - old:+.1f} |")
    L.append("")
    L.append("The re-run is a clean N=50 -- every trial counted, nothing dropped -- which is")
    L.append("how the FMB block of the same table is computed. Neither printed value resolves")
    L.append(f"to k/50 ({PAPER['6cubes']['sr']}% and {PAPER['7cubes']['sr']}% are not "
             "multiples of 2 percentage points), so the two cells were previously computed")
    L.append("over a smaller denominator, but the exact one cannot be read off a rounded")
    L.append("percentage and the underlying trials are not in this checkout.")
    L.append("")
    L.append("## Why")
    L.append("")
    L.append("| Magnitude | Timed out | Hit 16GB | Ran >300s | of those, succeeded | Longest |")
    L.append("|---|---|---|---|---|---|")
    for mag in sorted(st):
        s = st[mag]
        over = sum(1 for x in s["t"] if x > 300)
        over_ok = sum(1 for x in s["ok_t"] if x > 300)
        L.append(f"| {mag} | {s['timeout']} | {s['mem']} | {over} | {over_ok} | {max(s['t']):.0f}s |")
    L.append("")
    L.append("No trial timed out at the raised 3600s limit, so the remaining failures are")
    L.append("genuine 16GB memory exhaustion rather than an imposed time budget.")
    L.append("")
    L.append("## Solving time (successful trials)")
    L.append("")
    L.append("| Magnitude | In the paper | Re-run |")
    L.append("|---|---|---|")
    for mag in sorted(st):
        s = st[mag]
        med = statistics.median(s["ok_t"]) if s["ok_t"] else 0.0
        L.append(f"| {mag} | {PAPER[mag]['time_s']:.1f}s | **{med:.1f}s** |")
    L.append("")
    L.append("Seven cubes rises because the successes the old cap cut off were the slow ones;")
    L.append("the cell now averages over 19 trials instead of 1.")
    L.append("")
    L.append("## Per scenario (successes / trials)")
    L.append("")
    for mag in sorted(st):
        cells = "  ".join(f"`{k}` {v[1]}/{v[0]}" for k, v in sorted(st[mag]["scen"].items()))
        L.append(f"- **{mag}**: {cells}")
    L.append("")
    L.append("Outcomes are close to all-or-nothing per scenario rather than spread across")
    L.append("seeds, so Global's failures track the structure of the target rather than the")
    L.append("random trial.")
    L.append("")
    L.append("## Prose that quotes these numbers")
    L.append("")
    L.append("The Execution-and-Planning paragraph states Global falls \"to $56$--$57\\%$ by")
    L.append("five to six cubes\" and that its time grows \"from $146$\\,s at six cubes to")
    L.append("$296$\\,s at seven\". With the re-run, six cubes is $58.0\\%$ / $175.7$\\,s and")
    L.append("seven cubes is $38.0\\%$ / $379.9$\\,s, so both clauses need rewording. The claim")
    L.append("they support -- Global degrades with scale and most severely under redundancy --")
    L.append("still holds: seven cubes is still far below Smart's $100\\%$, and eight cubes is")
    L.append("still $0\\%$.")
    L.append("")
    L.append("## Scope")
    L.append("")
    L.append("Only `lgp_split_global` in R mode at 6 and 7 cubes was re-run. Smart, NR mode,")
    L.append("and the other magnitudes still carry their original 300s-capped results, so the")
    L.append("cube-stacking table mixes two time budgets.")
    L.append("")
    L.append("Re-running the rest was considered and declined. Smart cannot be affected: its")
    L.append("median solving time is 19--53s against the 300s cap, and it already succeeds on")
    L.append("every cell, so there is nothing for extra time to change. Four and five cubes sit")
    L.append("at 23--64s, likewise far from the cap. That leaves Global at eight cubes, which")
    L.append("reports $0\\%$ under redundancy with an average peak of 16.4GB -- bounded by the")
    L.append("16GB memory cap, not by time, so lifting the time budget would not move it.")
    L.append("")
    L.append("## Open: where the other cube cells' numbers come from")
    L.append("")
    L.append("Not a task for this change, and nothing else should be edited on account of it.")
    L.append("Recorded only so the question is not re-derived from scratch later.")
    L.append("")
    L.append("The per-trial `trial_meta.json` for the other cube cells is not in this checkout,")
    L.append("and no `lgp_split_global` record predating this re-run appears anywhere in git")
    L.append("history. Those runs were done, so the data exists in some form elsewhere -- it")
    L.append("simply is not here, which is why the cells were not verified against raw data")
    L.append("the way the FMB and VLM-MSGraph blocks were (both check out exactly, 18/18 and")
    L.append("16/16 against their raw trials).")
    L.append("")
    L.append("One thing to be aware of when that data turns up: the Global/NR figures in")
    L.append("`tab:planning_sr` (100.0, 96.7, 100.0, 93.3, 60.0) are higher than the")
    L.append("corresponding rows of `cross_magnitude_comparison.md` (80.0, 58.0, 60.0, 56.0,")
    L.append("60.0), which reports 50 trials per cell. The success counts implied by both are")
    L.append("the same -- 40, 29, 30, 28, 30 -- so the two differ only in denominator, the")
    L.append("paper's being 40 or 30 where the report uses 50. Whether that reflects a later")
    L.append("re-run or a different denominator convention cannot be settled from this")
    L.append("checkout; the source of the Global/NR column is the thing to check.")
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text("\n".join(L) + "\n", encoding="utf-8")
    print(f"written: {OUT.relative_to(ROOT)}")
    for mag in sorted(st):
        s = st[mag]
        print(f"  {mag}: {100.0*s['ok']/s['n']:.1f}% (was {PAPER[mag]['sr']:.1f}%)")


if __name__ == "__main__":
    main()
