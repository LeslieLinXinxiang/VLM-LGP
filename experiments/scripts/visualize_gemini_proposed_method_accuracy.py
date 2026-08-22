#!/usr/bin/env python3
"""
Visualization script for Gemini proposed method accuracy analysis (cube stacking).

Prints the text reports, then produces a bar chart of per-magnitude average accuracy
(4-8 cubes), with the 5 underlying per-case accuracies overlaid as points and a
min-max whisker, saved as PNG + SVG next to the accuracy reports. Mirrors
visualize_gemini_proposed_method_fmb_accuracy.py.
"""
import json
import sys
from pathlib import Path
from collections import defaultdict
import re

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parents[2]
ANALYSIS_ROOT = ROOT / "experiments/outputs/gemini_proposed_method/accuracy_analysis/cubeStacking"

sys.path.insert(0, str(Path(__file__).resolve().parent))
from analyse_gemini_proposed_method_accuracy import EVAL_ROOT, build_magnitude_table  # noqa: E402

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


def make_chart():
    mag_to_accs = collect_magnitude_summaries()
    if not mag_to_accs:
        print(f"No data found under {EVAL_ROOT}")
        return

    # Sort by cube count (e.g. "7cubes" -> 7) rather than lexicographically.
    mags = sorted(mag_to_accs.keys(), key=lambda m: int(re.match(r"(\d+)", m).group(1)))
    labels = [m.replace("cubes", " cubes") for m in mags]
    means = [sum(mag_to_accs[m]) / len(mag_to_accs[m]) for m in mags]
    mins = [min(mag_to_accs[m]) for m in mags]
    maxs = [max(mag_to_accs[m]) for m in mags]

    fig, ax = plt.subplots(figsize=(7.5, 4.4), dpi=200)
    fig.patch.set_facecolor(SURFACE)
    ax.set_facecolor(SURFACE)

    x = range(len(mags))
    bar_width = 0.5

    ax.bar(
        x, means, width=bar_width,
        color=COLOR_BAR, edgecolor=COLOR_BAR_EDGE, linewidth=1.0, zorder=3,
    )

    lower_err = [m - lo for m, lo in zip(means, mins)]
    upper_err = [hi - m for m, hi in zip(means, maxs)]
    ax.errorbar(
        x, means, yerr=[lower_err, upper_err],
        fmt="none", ecolor=COLOR_WHISKER, elinewidth=1.2, capsize=4, capthick=1.2, zorder=4,
    )

    rng_offsets = [-0.08, -0.04, 0.0, 0.04, 0.08]
    for xi, mag in zip(x, mags):
        accs = sorted(mag_to_accs[mag])
        for acc, dx in zip(accs, rng_offsets[: len(accs)]):
            ax.scatter(xi + dx, acc, s=14, color=COLOR_POINT, alpha=0.55, zorder=5)

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
        "Cube Stacking — VLM Graph Accuracy by Assembly Size\n(bar = mean of 5 scenarios, dots = per-scenario, whisker = min–max)",
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

    out_png = ANALYSIS_ROOT / "accuracy_chart.png"
    out_svg = ANALYSIS_ROOT / "accuracy_chart.svg"
    fig.savefig(out_png, facecolor=SURFACE)
    fig.savefig(out_svg, facecolor=SURFACE)
    plt.close(fig)

    print(f"→ {out_png}")
    print(f"→ {out_svg}")


def extract_table_from_md(report_md: Path):
    """Extract accuracy table from markdown report."""
    text = report_md.read_text(encoding="utf-8")
    
    # Find the table
    lines = text.split('\n')
    table_lines = []
    in_table = False
    
    for line in lines:
        if '|' in line and '---' not in line:
            if in_table or 'Case' in line:
                in_table = True
                table_lines.append(line)
        elif in_table:
            break
    
    return table_lines


def parse_accuracy_from_table(table_lines):
    """Parse accuracy values from table rows."""
    accuracies = []
    for i, line in enumerate(table_lines):
        if i <= 1:  # Skip header and separator
            continue
        parts = [p.strip() for p in line.split('|')]
        if len(parts) > 2:
            case_name = parts[1]
            acc_str = parts[-2]  # Accuracy is second-to-last column
            acc_val = float(acc_str.rstrip('%'))
            accuracies.append({"case": case_name, "accuracy": acc_val})
    return accuracies


def main():
    print("Gemini Proposed Method — Accuracy Visualization\n")
    
    if not ANALYSIS_ROOT.exists():
        print(f"Error: {ANALYSIS_ROOT} does not exist. Run analyse script first.")
        return
    
    # Read cross-magnitude comparison
    cross_mag_path = ANALYSIS_ROOT / "cross_magnitude_comparison.md"
    if cross_mag_path.exists():
        text = cross_mag_path.read_text(encoding="utf-8")
        print(text)
        print("\n" + "="*70 + "\n")
    
    # Read each magnitude report
    for mag_dir in sorted(ANALYSIS_ROOT.iterdir()):
        if not mag_dir.is_dir():
            continue
        
        acc_report = mag_dir / "accuracy_report.md"
        if acc_report.exists():
            print(f"\n### {mag_dir.name.upper()}\n")
            
            report_text = acc_report.read_text(encoding="utf-8")
            # Extract just the table and average
            lines = report_text.split('\n')
            for i, line in enumerate(lines):
                if 'Accuracy Report' in line or '|' in line or 'Average' in line:
                    print(line)
    
    print("\n" + "="*70)
    print("✅ Analysis visualization complete")

    make_chart()


if __name__ == "__main__":
    main()
