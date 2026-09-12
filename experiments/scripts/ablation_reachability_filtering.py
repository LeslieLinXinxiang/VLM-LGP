#!/usr/bin/env python3
"""Reachability-filtering ablation (main.tex subsec: Reachability-Manipulability-Aware
Object Ordering).

Ground truth for each object's pick feasibility comes from bin/pick_waypoint_check.exe
(single-step KOMO: grasp condition + joint limits + collision), run over
test/scenes/scene_reachability_ablation.g by
test/reachability/run_pick_waypoint_check.py. This script does not call the solver
itself; it consumes that report.

The scene deliberately includes three objects (far_1/2/3) placed well beyond the
Panda arm's ~0.85m reach, verified infeasible by the same KOMO check used elsewhere
in the pipeline (see report). All other 12 objects are the original scene_named.g
box layout, all verified feasible. Two cylinders present in scene_named.g were
dropped from this ablation scene: bin/pick_waypoint_check.cpp's pick_cylinder action
is infeasible for every cylinder regardless of position (confirmed by moving one to
the robot's feet and re-running), so it carries no reachability signal and would
inflate the infeasible count for an unrelated reason.

Metric: the percentage of objects in the scene that a naive nearest-to-farthest
selection rule (no reachability check) would eventually attempt and find
infeasible. This is reported instead of the with-filter rate, which is 0% by
construction (S_r excludes exactly these objects) and therefore not a meaningful
number on its own.
"""
import json
import math
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SCENE = ROOT / "test/scenes/scene_reachability_ablation.g"
REPORT = ROOT / "experiments/outputs/reachability_ablation/pick_waypoint_report.json"
OUT_JSON = ROOT / "experiments/outputs/reachability_ablation/naive_rule_analysis.json"
OUT_MD = ROOT / "experiments/outputs/reachability_ablation/naive_rule_analysis.md"

# Robot base world position, read off the scene file's `Edit l_panda_base` line:
# Q: "t(0 -.3 .05) d(90 0 0 1)" relative to the table -> world (x, y) = (0, -0.3).
BASE_XY = (0.0, -0.3)

_OBJ_LINE = re.compile(
    r"^(?P<name>\w+)\s*\(table\)\s*\{\s*Q:\"t\(\s*(?P<x>[-\d.]+)\s+(?P<y>[-\d.]+)"
)


def parse_object_xy(scene_path: Path) -> dict:
    positions = {}
    for line in scene_path.read_text().splitlines():
        m = _OBJ_LINE.match(line.strip())
        if not m:
            continue
        positions[m.group("name")] = (float(m.group("x")), float(m.group("y")))
    return positions


def main():
    report = json.loads(REPORT.read_text())
    results = report["results"]
    positions = parse_object_xy(SCENE)

    rows = []
    for name, r in results.items():
        if name not in positions:
            continue
        x, y = positions[name]
        dist = math.hypot(x - BASE_XY[0], y - BASE_XY[1])
        rows.append(
            {
                "object": name,
                "distance_from_base_m": round(dist, 3),
                "komo_status": r["status"],
            }
        )

    # Naive rule: process objects nearest-to-farthest, no reachability check.
    rows.sort(key=lambda r: r["distance_from_base_m"])
    for i, r in enumerate(rows, start=1):
        r["naive_order"] = i

    total = len(rows)
    infeasible = [r for r in rows if r["komo_status"] == "infeasible"]
    n_infeasible = len(infeasible)
    naive_infeasible_pct = 100.0 * n_infeasible / total

    summary = {
        "scene": str(SCENE.relative_to(ROOT)),
        "total_objects": total,
        "komo_feasible": total - n_infeasible,
        "komo_infeasible": n_infeasible,
        "naive_rule_would_select_unreachable_pct": round(naive_infeasible_pct, 1),
        "with_filter_would_select_unreachable_pct": 0.0,
        "note": (
            "with-filter is 0% by construction (S_r excludes exactly the KOMO-infeasible "
            "set); the naive-rule percentage is the only number that carries information."
        ),
        "objects": rows,
    }

    OUT_JSON.parent.mkdir(parents=True, exist_ok=True)
    OUT_JSON.write_text(json.dumps(summary, indent=2))

    lines = [
        "# Reachability-filtering ablation — naive-rule analysis",
        "",
        f"Scene: `{summary['scene']}` ({total} objects, ground truth from "
        "`bin/pick_waypoint_check.exe`).",
        "",
        "| Naive order | Object | Distance from base (m) | KOMO ground truth |",
        "|---|---|---|---|",
    ]
    for r in rows:
        lines.append(
            f"| {r['naive_order']} | {r['object']} | {r['distance_from_base_m']:.3f} "
            f"| {r['komo_status']} |"
        )
    lines += [
        "",
        f"**Naive rule (nearest-to-farthest, no reachability check) would select an "
        f"unreachable object {n_infeasible}/{total} = {naive_infeasible_pct:.1f}% of the "
        "time.** With reachability filtering, this is 0% by construction (S_r excludes "
        "exactly this set) — not reported as the headline number since it is trivially true.",
    ]
    OUT_MD.write_text("\n".join(lines) + "\n")

    print(json.dumps(summary, indent=2))
    print(f"\nwritten: {OUT_JSON}")
    print(f"written: {OUT_MD}")


if __name__ == "__main__":
    main()
