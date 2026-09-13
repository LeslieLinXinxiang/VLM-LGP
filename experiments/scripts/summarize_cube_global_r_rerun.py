#!/usr/bin/env python3
"""Summarize the cube-stacking Global-R runs at 6 and 7 cubes.

Reads the trial_meta.json files directly and reports success rate, mean solving time
over successful trials, failure breakdown and per-scenario outcomes.

Writes experiments/outputs/LGP_execution_stats/cube_global_r_no_timeout_rerun.md
"""
import collections
import glob
import json
import statistics
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "experiments/outputs/LGP_execution_stats/cube_global_r_no_timeout_rerun.md"
MAGS = ("6cubes", "7cubes")
RUN_ARGS = "--mags 6cubes 7cubes --mode r --lgp-modes lgp_split_global --timeout-s 3600 --max-mem-mb 16000"


def collect():
    st = collections.defaultdict(lambda: {
        "n": 0, "ok": 0, "timeout": 0, "mem": 0, "other": 0,
        "t": [], "ok_t": [], "peak": [], "scen": collections.defaultdict(lambda: [0, 0])})
    pat = str(ROOT / "experiments/evaluations/LGP_execution/cubeStacking/*/*/r/*/lgp_split_global/trial_meta.json")
    for f in glob.glob(pat):
        d = json.load(open(f))
        mag = d.get("mag")
        if mag not in MAGS:
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
        if d.get("memory_peak_mb") is not None:
            s["peak"].append(d["memory_peak_mb"])
        s["scen"][scen][0] += 1
        s["scen"][scen][1] += ok
    return st


def main():
    st = collect()
    L = []
    L.append("# Cube stacking, Global, redundant mode: 6 and 7 cubes")
    L.append("")
    L.append("`lgp_split_global` on the redundant (R) scenes, 5 target structures x 10 seeds = 50")
    L.append("trials per magnitude, 16GB memory cap.")
    L.append("")
    L.append(f"Command: `python3 experiments/scripts/run_lgp_batch_eval.py {RUN_ARGS}`")
    L.append("")
    L.append("## Results")
    L.append("")
    L.append("| Magnitude | Success | Success rate | Mean solving time, successful trials |")
    L.append("|---|---|---|---|")
    for mag in MAGS:
        s = st[mag]
        mean_t = statistics.mean(s["ok_t"]) if s["ok_t"] else 0.0
        L.append(f"| {mag} | {s['ok']}/{s['n']} | **{100.0 * s['ok'] / s['n']:.1f}%** | **{mean_t:.1f}s** |")
    L.append("")
    L.append("These are the values in the Global / R column of `tab:planning_sr` and")
    L.append("`tab:planning_time` (Cube Stacking block).")
    L.append("")
    L.append("## Failure breakdown")
    L.append("")
    L.append("| Magnitude | Failed | Hit 16GB | Timed out | Other | Mean peak memory | Longest trial |")
    L.append("|---|---|---|---|---|---|---|")
    for mag in MAGS:
        s = st[mag]
        peak = statistics.mean(s["peak"]) if s["peak"] else 0.0
        L.append(f"| {mag} | {s['n'] - s['ok']} | {s['mem']} | {s['timeout']} | {s['other']} "
                 f"| {peak / 1024:.1f}GB | {max(s['t']):.0f}s |")
    L.append("")
    L.append("## Per scenario (successes / trials)")
    L.append("")
    for mag in MAGS:
        cells = "  ".join(f"`{k}` {v[1]}/{v[0]}" for k, v in sorted(st[mag]["scen"].items()))
        L.append(f"- **{mag}**: {cells}")
    L.append("")
    L.append("Outcomes are close to all-or-nothing per scenario rather than spread across")
    L.append("seeds, so Global's failures track the structure of the target rather than the")
    L.append("random trial.")
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text("\n".join(L) + "\n", encoding="utf-8")
    print(f"written: {OUT.relative_to(ROOT)}")
    for mag in MAGS:
        s = st[mag]
        mean_t = statistics.mean(s["ok_t"]) if s["ok_t"] else 0.0
        print(f"  {mag}: {100.0 * s['ok'] / s['n']:.1f}%  mean {mean_t:.1f}s")


if __name__ == "__main__":
    main()
