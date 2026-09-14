#!/usr/bin/env python3
"""Time the paper's geometric accessibility score, stage 1 of reachability filtering.

The pipeline still carries a legacy score whose formula differs from the paper's in
three respects (see compute_paper_accessibility_scores for the list), so its cost is not
what the paper's stage 1 would cost. This measures the paper's formula directly.

The score is sub-millisecond, so each scene is timed over many repetitions and the
per-call mean is reported; a single call is dominated by timer noise.

Writes experiments/outputs/stage_timing/paper_score_timing.{json,md}
"""
import argparse
import json
import statistics
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))

from core.phase0_parser import build_phase0_layout_from_unnamed_g        # noqa: E402
from core.reachability_field import compute_paper_accessibility_scores   # noqa: E402
from measure_stage_timing import CUBE_MAGS, FMB_MAGS, cube_scenes, fmb_scenes  # noqa: E402

OUT = ROOT / "experiments/outputs/stage_timing"


def time_scene(scene, repeats):
    layout = build_phase0_layout_from_unnamed_g(str(scene))
    compute_paper_accessibility_scores(str(scene), layout)   # warm up numpy paths
    t0 = time.perf_counter()
    for _ in range(repeats):
        rep = compute_paper_accessibility_scores(str(scene), layout)
    total = time.perf_counter() - t0
    return total / repeats, len(rep.get("objects", []))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--per-cell", type=int, default=10)
    ap.add_argument("--repeats", type=int, default=200)
    args = ap.parse_args()

    OUT.mkdir(parents=True, exist_ok=True)
    plan = [("Cube Stacking", m, md, cube_scenes(m, md, args.per_cell))
            for m in CUBE_MAGS for md in ("nr", "r")]
    plan += [("FMB", m, md, fmb_scenes(m, md, args.per_cell))
             for m in FMB_MAGS for md in ("nr", "r")]

    rows = []
    for bench, mag, mode, scenes in plan:
        ts, ns = [], []
        for p in scenes:
            try:
                t, n = time_scene(p, args.repeats)
            except Exception as exc:                       # noqa: BLE001
                print(f"[skip] {p.name}: {exc}", flush=True)
                continue
            ts.append(t)
            ns.append(n)
        if not ts:
            continue
        row = dict(benchmark=bench, magnitude=mag, condition=mode.upper(),
                   n_scenes=len(ts), n_objects=int(statistics.mean(ns)),
                   mean_s=statistics.mean(ts),
                   std_s=statistics.pstdev(ts) if len(ts) > 1 else 0.0)
        rows.append(row)
        print(f"{bench:<14}{mag:<8}{mode.upper():<4}N={row['n_objects']:<3}"
              f"paper score = {row['mean_s']*1000:7.4f} ms", flush=True)

    (OUT / "paper_score_timing.json").write_text(
        json.dumps({"repeats_per_scene": args.repeats, "rows": rows}, indent=2), encoding="utf-8")

    L = ["# Stage 1 timing: the paper's geometric accessibility score", "",
         "`rho = rho_spa + alpha * rho_clear`, with `rho_spa` and `rho_clear` exactly as",
         "written in the paper. The score the pipeline currently computes is a different",
         "formula (no leading `1 -`, self-kernel included, and a second term measuring",
         "distance to obstacle frames rather than to the nearest object), so its cost is",
         "not what this stage would cost as published; hence this separate measurement.", "",
         f"Each scene timed over {args.repeats} repetitions; the value is the per-call mean.",
         "Scene parsing and layout construction are excluded -- they are shared with the",
         "rest of phase 0 and are not part of the score itself.", "",
         "| Benchmark | Magnitude | Cond | Objects | Paper score (ms) |",
         "|---|---|---|---|---|"]
    for r in rows:
        L.append(f"| {r['benchmark']} | {r['magnitude']} | {r['condition']} | {r['n_objects']} "
                 f"| {r['mean_s']*1000:.4f} ± {r['std_s']*1000:.4f} |")
    (OUT / "paper_score_timing.md").write_text("\n".join(L) + "\n", encoding="utf-8")
    print(f"\nwritten: {(OUT/'paper_score_timing.md').relative_to(ROOT)}")


if __name__ == "__main__":
    main()
