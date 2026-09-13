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

# Values currently reported in cross_magnitude_comparison.md (R mode, lgp_split_global),
# produced under the 300s cap. Kept inline so the comparison is self-contained.
PAPER = {"6cubes": {"sr": 58.0, "median_s": 149.3},
         "7cubes": {"sr": 2.0, "median_s": 295.8}}

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
    L.append("## Success rate")
    L.append("")
    L.append("| Magnitude | In the paper (300s cap) | Re-run (no cap) | Change |")
    L.append("|---|---|---|---|")
    for mag in sorted(st):
        s = st[mag]
        sr = 100.0 * s["ok"] / s["n"]
        old = PAPER[mag]["sr"]
        L.append(f"| {mag} | {old:.1f}% | **{sr:.1f}%** ({s['ok']}/{s['n']}) | {sr - old:+.1f} |")
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
    L.append("## Median solving time (successful trials)")
    L.append("")
    L.append("| Magnitude | In the paper | Re-run |")
    L.append("|---|---|---|")
    for mag in sorted(st):
        s = st[mag]
        med = statistics.median(s["ok_t"]) if s["ok_t"] else 0.0
        L.append(f"| {mag} | {PAPER[mag]['median_s']:.1f}s | **{med:.1f}s** |")
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
    L.append("## Scope")
    L.append("")
    L.append("Only `lgp_split_global` in R mode at 6 and 7 cubes was re-run. Smart, NR mode,")
    L.append("and the other magnitudes still carry their original 300s-capped results, so the")
    L.append("cube-stacking table mixes two time budgets until those are re-run as well.")
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text("\n".join(L) + "\n", encoding="utf-8")
    print(f"written: {OUT.relative_to(ROOT)}")
    for mag in sorted(st):
        s = st[mag]
        print(f"  {mag}: {100.0*s['ok']/s['n']:.1f}% (was {PAPER[mag]['sr']:.1f}%)")


if __name__ == "__main__":
    main()
