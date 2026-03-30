#!/usr/bin/env python3
"""Simple visualization for reachability score reports.

Usage:
  python3 test/reachability/visualize_reachability_report.py \
    --report generated/reachability_score_report_obstacle1.json \
    --out generated/reachability_obstacle1_viz.png
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path


def _load_report(path: Path) -> dict:
    with path.open("r", encoding="utf-8") as f:
        return json.load(f)


def _build_arrays(objects: list[dict]):
    labels = []
    xs, ys = [], []
    gmm, esdf, fused = [], [], []
    decision = []

    for obj in objects:
        labels.append(obj.get("logical_id", "?"))
        p = obj.get("sample_point_xyz", [0.0, 0.0, 0.0])
        xs.append(float(p[0]))
        ys.append(float(p[1]))
        gmm.append(float(obj.get("gmm_score", 0.0)))
        esdf.append(float(obj.get("esdf_score", 0.0)))
        fused.append(float(obj.get("reachability_score", 0.0)))
        decision.append(obj.get("decision", "unknown"))

    return labels, xs, ys, gmm, esdf, fused, decision


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--report", required=True)
    parser.add_argument("--out", default="generated/reachability_viz.png")
    args = parser.parse_args()

    report = _load_report(Path(args.report))
    objects = report.get("objects", [])
    tau = report.get("params", {}).get("tau_r", 0.45)

    labels, xs, ys, gmm, esdf, fused, decision = _build_arrays(objects)

    try:
        import matplotlib.pyplot as plt
    except Exception as e:
        raise SystemExit(f"matplotlib is required for plotting: {e}")

    fig, axes = plt.subplots(1, 3, figsize=(17, 5))

    # 1) XY map
    sc = axes[0].scatter(xs, ys, c=fused, s=120, cmap="viridis", vmin=0.0, vmax=1.0)
    for i, name in enumerate(labels):
        marker = "x" if decision[i] == "infeasible" else "o"
        if marker == "x":
            axes[0].scatter([xs[i]], [ys[i]], marker=marker, s=180, color="k")
        else:
            axes[0].scatter([xs[i]], [ys[i]], marker=marker, s=180, facecolors="none", edgecolors="k")
        axes[0].text(xs[i] + 0.005, ys[i] + 0.005, name, fontsize=8)
    axes[0].set_title("Object XY map (color = fused reachability)")
    axes[0].set_xlabel("x")
    axes[0].set_ylabel("y")
    fig.colorbar(sc, ax=axes[0], fraction=0.046, pad=0.04)

    # 2) Score bars
    order = sorted(range(len(labels)), key=lambda i: fused[i])
    ordered_labels = [labels[i] for i in order]
    ordered_scores = [fused[i] for i in order]
    ordered_dec = [decision[i] for i in order]
    bar_colors = ["#d62728" if d == "infeasible" else "#2ca02c" for d in ordered_dec]
    axes[1].barh(ordered_labels, ordered_scores, color=bar_colors)
    axes[1].axvline(float(tau), color="k", linestyle="--", linewidth=1, label=f"tau={tau}")
    axes[1].set_title("Fused reachability by object")
    axes[1].set_xlabel("reachability_score")
    axes[1].legend(loc="lower right")

    # 3) GMM vs ESDF scatter
    for i, name in enumerate(labels):
        c = "#d62728" if decision[i] == "infeasible" else "#2ca02c"
        axes[2].scatter(gmm[i], esdf[i], color=c, s=110)
        axes[2].text(gmm[i] + 0.003, esdf[i] + 0.01, name, fontsize=8)
    axes[2].set_title("Component space")
    axes[2].set_xlabel("gmm_score")
    axes[2].set_ylabel("esdf_score")
    axes[2].set_xlim(left=0.0)
    axes[2].set_ylim(-0.05, 1.05)

    fig.suptitle(
        f"Reachability report: {Path(args.report).name} | obstacles={report.get('obstacle_count', 0)}",
        fontsize=11,
    )
    fig.tight_layout()
    out = Path(args.out)
    out.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(out, dpi=180)
    print(f"[OK] saved: {out}")


if __name__ == "__main__":
    main()
