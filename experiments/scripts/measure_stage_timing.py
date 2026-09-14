#!/usr/bin/env python3
"""Measure per-stage wall-clock cost of reachability filtering and manipulability ordering.

Both stages are per-object, and the redundancy condition doubles the object count, so
NR and R are measured separately: the pair is what shows how each stage scales with
scene size. Timings come from instrumentation inside execute_phase0, i.e. the real
pipeline path, not a re-creation of it.

VLM/graph generation is excluded by agreement (network-bound, no stable measurement).

Writes experiments/outputs/stage_timing/stage_timing.{json,md}
"""
import argparse
import json
import statistics
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))

from pipeline.run_phase0 import execute_phase0            # noqa: E402

OUT = ROOT / "experiments/outputs/stage_timing"

CUBE_MAGS = ["4cubes", "5cubes", "6cubes", "7cubes", "8cubes"]
FMB_MAGS = ["3objs", "4objs", "5objs"]


def cube_scenes(mag, mode, per_cell):
    """Spread the sample across scenarios rather than taking them all from one."""
    out = []
    base = ROOT / "experiments/scenes" / mag
    scen = sorted(d.name for d in base.iterdir() if d.is_dir() and d.name.startswith("s"))
    t = 1
    while len(out) < per_cell and t <= 10:
        for s in scen:
            p = base / s / "random_trials" / f"trial_{t:02d}_{mode}.g"
            if p.exists():
                out.append(p)
            if len(out) >= per_cell:
                break
        t += 1
    return out


def fmb_scenes(mag, mode, per_cell):
    out = []
    base = ROOT / "experiments/scenes/fmb" / mag
    if not base.exists():
        return out
    scen = sorted(d.name for d in base.iterdir() if d.is_dir() and d.name.startswith("s"))
    t = 1
    while len(out) < per_cell and t <= 10:
        for s in scen:
            p = base / s / "random_trials" / f"trial_{t:02d}_{mode}.g"
            if p.exists():
                out.append(p)
            if len(out) >= per_cell:
                break
        t += 1
    return out


def measure(scene_path):
    t0 = time.perf_counter()
    res = execute_phase0(use_vlm=False, unnamed_g_path=str(scene_path),
                         auto_prepare_from_named_scene=False,
                         reachability_mode="gmm_esdf_mvp")
    total = time.perf_counter() - t0
    if not res or not res.get("success"):
        return None
    t = res.get("timing_s") or {}
    return {"reachability": t.get("reachability"), "manipulability": t.get("manipulability"),
            "stage1": t.get("reach_stage1_score"), "stage2": t.get("reach_stage2_komo"),
            "n_objects": t.get("n_objects"), "phase0_total": total,
            "manip_scored": t.get("manip_objects_scored")}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--per-cell", type=int, default=10)
    ap.add_argument("--benchmarks", nargs="+", default=["cube", "fmb"])
    args = ap.parse_args()

    OUT.mkdir(parents=True, exist_ok=True)
    rows = []
    plan = []
    # One discarded warm-up solve. The manipulability stage parses and caches the URDF
    # on first use, which otherwise lands entirely in whichever cell happens to run
    # first and makes it look an order of magnitude slower than the rest.
    _warm = cube_scenes("4cubes", "nr", 1) or fmb_scenes("3objs", "nr", 1)
    if _warm:
        print("[warmup] discarding one solve", flush=True)
        measure(_warm[0])
    if "cube" in args.benchmarks:
        plan += [("Cube Stacking", m, md, cube_scenes(m, md, args.per_cell))
                 for m in CUBE_MAGS for md in ("nr", "r")]
    if "fmb" in args.benchmarks:
        plan += [("FMB", m, md, fmb_scenes(m, md, args.per_cell))
                 for m in FMB_MAGS for md in ("nr", "r")]

    for bench, mag, mode, scenes in plan:
        if not scenes:
            print(f"[skip] {bench} {mag} {mode}: no scenes", flush=True)
            continue
        reach, manip, nobj, scored, s1, s2 = [], [], [], [], [], []
        for p in scenes:
            m = measure(p)
            if not m:
                continue
            reach.append(m["reachability"])
            manip.append(m["manipulability"])
            if m.get("stage1") is not None: s1.append(m["stage1"])
            if m.get("stage2") is not None: s2.append(m["stage2"])
            nobj.append(m["n_objects"])
            if m.get("manip_scored") is not None:
                scored.append(m["manip_scored"])
        if not reach:
            continue
        row = dict(benchmark=bench, magnitude=mag, condition=mode.upper(), n_runs=len(reach),
                   n_objects=int(statistics.mean(nobj)),
                   reach_mean_s=statistics.mean(reach),
                   reach_std_s=statistics.pstdev(reach) if len(reach) > 1 else 0.0,
                   manip_mean_s=statistics.mean(manip),
                   manip_std_s=statistics.pstdev(manip) if len(manip) > 1 else 0.0,
                   manip_objects_scored=(int(statistics.mean(scored)) if scored else None),
                   stage1_mean_s=(statistics.mean(s1) if s1 else None),
                   stage1_std_s=(statistics.pstdev(s1) if len(s1) > 1 else 0.0),
                   stage2_mean_s=(statistics.mean(s2) if s2 else None),
                   stage2_std_s=(statistics.pstdev(s2) if len(s2) > 1 else 0.0))
        rows.append(row)
        print(f"{bench:<14}{mag:<8}{mode.upper():<4}N={row['n_objects']:<3} "
              f"S1={row['stage1_mean_s']*1000:6.3f}ms  S2={row['stage2_mean_s']*1000:8.1f}ms  "
              f"manip={row['manip_mean_s']*1000:6.2f}ms(scored {row['manip_objects_scored']})", flush=True)

    (OUT / "stage_timing.json").write_text(json.dumps({"per_cell": args.per_cell, "rows": rows},
                                                      indent=2), encoding="utf-8")

    L = ["# Per-stage timing: reachability filtering and manipulability ordering", "",
         "Measured inside `execute_phase0` on the real pipeline path. Both stages are",
         "per-object and the redundancy condition doubles the object count, so NR and R are",
         "reported separately — the pair is what shows the scaling. VLM graph generation is",
         "excluded by agreement (network-bound).", "",
         f"Runs per cell: {args.per_cell}. Times are mean ± population SD.", "",
         "| Benchmark | Magnitude | Cond | Objects | Stage 1 score (ms) | Stage 2 KOMO (ms) | Reachability total (ms) | Manipulability (ms) | Obj scored |",
         "|---|---|---|---|---|---|---|---|---|"]
    for r in rows:
        sc = r.get("manip_objects_scored")
        manip_cell = (f"{r['manip_mean_s']*1000:.2f} ± {r['manip_std_s']*1000:.2f}"
                      if sc else "not computed")
        L.append(f"| {r['benchmark']} | {r['magnitude']} | {r['condition']} | {r['n_objects']} "
                 f"| {r['stage1_mean_s']*1000:.3f} ± {r['stage1_std_s']*1000:.3f} "
                 f"| {r['stage2_mean_s']*1000:.1f} ± {r['stage2_std_s']*1000:.1f} "
                 f"| {r['reach_mean_s']*1000:.1f} ± {r['reach_std_s']*1000:.1f} "
                 f"| {manip_cell} | {sc if sc is not None else 0} |")
    scored_rows = [r for r in rows if r.get("manip_objects_scored")]
    if len(scored_rows) < len(rows):
        L += ["", "Cells marked *not computed* are benchmarks whose object frames the",
              "manipulability pose parser does not recognise (it matches only `obj_<digits>`),",
              "so nothing is scored there and the elapsed time reflects an early-out.",
              "The stage is therefore inert on those scenes, not merely fast."]
    if scored_rows:
        ratio = statistics.mean(r["reach_mean_s"] / r["manip_mean_s"] for r in scored_rows if r["manip_mean_s"])
        st = statistics.mean(r["stage2_mean_s"] / r["stage1_mean_s"] for r in rows
                             if r.get("stage1_mean_s") and r.get("stage2_mean_s"))
        L += ["", f"Within reachability the KOMO gate costs about **{st:.0f}x** the geometric",
              "score: the score is closed-form over object positions, the gate runs one KOMO",
              "solve per object. The gate is currently run over every object rather than over",
              "the score's survivors, so the pre-filter does not yet reduce KOMO solves."]
        L += ["", f"Reachability costs roughly **{ratio:.0f}x** what manipulability ordering costs:",
              "the manipulability score is a Jacobian determinant at an IK solution, whereas",
              "reachability runs a KOMO solve per object."]
    (OUT / "stage_timing.md").write_text("\n".join(L) + "\n", encoding="utf-8")
    print(f"\nwritten: {(OUT/'stage_timing.md').relative_to(ROOT)}")


if __name__ == "__main__":
    main()
