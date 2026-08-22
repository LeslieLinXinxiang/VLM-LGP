#!/usr/bin/env python3
"""
Visualization for the FMB GT-comparison accuracy analysis (see
analyse_gemini_proposed_method_fmb_accuracy.py). Produces a bar chart of
per-magnitude average accuracy (3objs/4objs/5objs), with the 5 underlying
per-case accuracies overlaid as points and a min-max whisker, and saves it
as PNG + SVG next to the accuracy reports.
"""
import sys
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(Path(__file__).resolve().parent))
from analyse_gemini_proposed_method_fmb_accuracy import EVAL_ROOT, OUTPUT_ROOT, build_magnitude_table  # noqa: E402

# dataviz reference palette (references/palette.md): sequential base = blue (categorical slot 1)
COLOR_BAR = "#2a78d6"
COLOR_BAR_EDGE = "#184f95"
COLOR_POINT = "#0b0b0b"
COLOR_WHISKER = "#52514e"
COLOR_GRID = "#e1e0d9"
COLOR_AXIS = "#c3c2b7"
COLOR_TEXT_PRIMARY = "#0b0b0b"
COLOR_TEXT_MUTED = "#898781"
SURFACE = "#fcfcfb"


def collect_magnitude_summaries():
    magnitudes = sorted([d for d in EVAL_ROOT.iterdir() if d.is_dir()])
    mag_to_accs = {}
    for mag_dir in magnitudes:
        _, summary_list = build_magnitude_table(mag_dir)
        if summary_list:
            mag_to_accs[mag_dir.name] = [s["acc"] for s in summary_list]
    return mag_to_accs


def main():
    mag_to_accs = collect_magnitude_summaries()
    if not mag_to_accs:
        print(f"No data found under {EVAL_ROOT}")
        return

    mags = sorted(mag_to_accs.keys())  # 3objs, 4objs, 5objs
    labels = [m.replace("objs", " objects") for m in mags]
    means = [sum(mag_to_accs[m]) / len(mag_to_accs[m]) for m in mags]
    mins = [min(mag_to_accs[m]) for m in mags]
    maxs = [max(mag_to_accs[m]) for m in mags]

    fig, ax = plt.subplots(figsize=(6.5, 4.4), dpi=200)
    fig.patch.set_facecolor(SURFACE)
    ax.set_facecolor(SURFACE)

    x = range(len(mags))
    bar_width = 0.5

    ax.bar(
        x, means, width=bar_width,
        color=COLOR_BAR, edgecolor=COLOR_BAR_EDGE, linewidth=1.0, zorder=3,
    )

    # Min-max whiskers (asymmetric error bars around the mean).
    lower_err = [m - lo for m, lo in zip(means, mins)]
    upper_err = [hi - m for m, hi in zip(means, maxs)]
    ax.errorbar(
        x, means, yerr=[lower_err, upper_err],
        fmt="none", ecolor=COLOR_WHISKER, elinewidth=1.2, capsize=4, capthick=1.2, zorder=4,
    )

    # Individual per-case (N=5) points, jittered slightly for visibility.
    rng_offsets = [-0.08, -0.04, 0.0, 0.04, 0.08]
    for xi, mag in zip(x, mags):
        accs = sorted(mag_to_accs[mag])
        for acc, dx in zip(accs, rng_offsets[: len(accs)]):
            ax.scatter(xi + dx, acc, s=14, color=COLOR_POINT, alpha=0.55, zorder=5)

    # Direct labels on the mean bars.
    for xi, m in zip(x, means):
        ax.text(
            xi, m + 3, f"{m:.1f}%", ha="center", va="bottom",
            fontsize=10, color=COLOR_TEXT_PRIMARY, fontweight="bold", zorder=6,
        )

    ax.set_xticks(list(x))
    ax.set_xticklabels(labels, color=COLOR_TEXT_PRIMARY, fontsize=10)
    ax.set_ylim(0, 108)
    ax.set_ylabel("Graph-topology accuracy vs. GT (%)", color=COLOR_TEXT_PRIMARY, fontsize=10)
    ax.set_title(
        "FMB — VLM Graph Accuracy by Assembly Size\n(bar = mean of 5 scenarios, dots = per-scenario, whisker = min–max)",
        color=COLOR_TEXT_PRIMARY, fontsize=9.5, pad=12,
    )

    ax.grid(axis="y", color=COLOR_GRID, linewidth=0.8, zorder=0)
    ax.set_axisbelow(True)
    for spine in ("top", "right"):
        ax.spines[spine].set_visible(False)
    for spine in ("left", "bottom"):
        ax.spines[spine].set_color(COLOR_AXIS)
    ax.tick_params(colors=COLOR_TEXT_MUTED)

    fig.tight_layout()

    out_png = OUTPUT_ROOT / "accuracy_chart.png"
    out_svg = OUTPUT_ROOT / "accuracy_chart.svg"
    fig.savefig(out_png, facecolor=SURFACE)
    fig.savefig(out_svg, facecolor=SURFACE)
    plt.close(fig)

    print(f"→ {out_png}")
    print(f"→ {out_svg}")


if __name__ == "__main__":
    main()
