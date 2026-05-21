#!/usr/bin/env python3
"""Generate visualizations for image_reasoning accuracy reports."""

import re
from collections import defaultdict
from pathlib import Path

import matplotlib.pyplot as plt

# Premium-style appearance aligned with existing reports.
COLORS = [
    '#636EFA', '#EF553B', '#00CC96', '#AB63FA', '#FFA15A',
    '#19D3F3', '#FF6692', '#B6E880', '#FF97FF', '#FECB52'
]
plt.rcParams.update({
    'axes.facecolor': '#f8f9fa',
    'axes.edgecolor': '#ced4da',
    'axes.labelcolor': '#495057',
    'xtick.color': '#495057',
    'ytick.color': '#495057',
    'grid.color': '#e9ecef',
    'figure.facecolor': 'white',
    'font.size': 10,
    'legend.fontsize': 9,
    'axes.titlesize': 14,
    'axes.labelsize': 11,
})

ROOT = Path(__file__).resolve().parents[2]
ACC_ROOT = ROOT / "experiments/outputs/image_reasoning/accuracy_analysis/cubeStacking"
OUTPUT_DIR = ACC_ROOT / "visualizations"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)


def parse_report(md_path: Path):
    """Parse one per-magnitude accuracy report into case-level records."""
    text = md_path.read_text(encoding="utf-8")
    records = []
    for line in text.splitlines():
        m = re.match(r"^\|\s*(cube_n\d{2}_s\d{2})\s*\|.*?\|\s*(\d+)%\s*\|\s*(T\d{2}|N/A)\s*\|\s*$", line)
        if not m:
            continue
        case, acc, gt = m.groups()
        records.append({
            "case": case,
            "magnitude": int(case.split('_')[1][1:]),
            "scenario": case.split('_')[2],
            "accuracy": float(acc),
            "gt": gt,
        })
    return records


def load_all_records():
    all_records = []
    for n in [4, 5, 6, 7, 8]:
        report = ACC_ROOT / f"{n}cubes/accuracy_report.md"
        if report.exists():
            all_records.extend(parse_report(report))
    return all_records


def save_summary_bar(all_records):
    mags = sorted({r["magnitude"] for r in all_records})
    avg_accs = []
    for m in mags:
        vals = [r["accuracy"] for r in all_records if r["magnitude"] == m]
        avg_accs.append(sum(vals) / len(vals))

    plt.figure(figsize=(9, 6))
    bars = plt.bar([str(m) for m in mags], avg_accs, color="#3b82f6", width=0.6, zorder=3)
    plt.grid(axis='y', linestyle='--', alpha=0.7, zorder=0)
    plt.ylim(0, 105)
    plt.title("Planning Success Rate by Complexity", pad=20, fontweight='bold')
    plt.xlabel("Number of Objects", labelpad=10)
    plt.ylabel("Avg Accuracy (%)", labelpad=10)

    for bar in bars:
        height = bar.get_height()
        plt.text(bar.get_x() + bar.get_width() / 2.0, height + 2, f"{height:.1f}%",
                 ha='center', va='bottom', fontweight='bold', color='#1e293b')

    plt.tight_layout()
    out_path = OUTPUT_DIR / "summary_accuracy.svg"
    plt.savefig(out_path, format='svg')
    plt.close()
    print(f"Saved: {out_path}")


def save_detailed_lines(all_records):
    mags = sorted({r["magnitude"] for r in all_records})
    scenarios = sorted({r["scenario"] for r in all_records})

    plt.figure(figsize=(10, 6))
    for i, scenario in enumerate(scenarios):
        s_data = sorted([r for r in all_records if r["scenario"] == scenario], key=lambda x: x["magnitude"])
        if not s_data:
            continue
        x = [r["magnitude"] for r in s_data]
        y = [r["accuracy"] for r in s_data]
        plt.plot(x, y, label=f"Scenario {scenario.upper()}", marker='o', markersize=7,
                 linewidth=2, color=COLORS[i % len(COLORS)], alpha=0.9, zorder=5)

    plt.grid(linestyle='--', alpha=0.5, zorder=0)
    plt.xticks(mags)
    plt.ylim(0, 105)
    plt.title("Detailed Stability across Scenes", pad=20, fontweight='bold')
    plt.xlabel("Number of Objects", labelpad=10)
    plt.ylabel("Accuracy (%)", labelpad=10)
    plt.legend(bbox_to_anchor=(1.05, 1), loc='upper left', frameon=True, shadow=False)
    plt.tight_layout()
    out_path = OUTPUT_DIR / "detailed_scenarios.svg"
    plt.savefig(out_path, format='svg')
    plt.close()
    print(f"Saved: {out_path}")


def main():
    all_records = load_all_records()
    if not all_records:
        print("Error: No accuracy report data found.")
        return

    save_summary_bar(all_records)
    save_detailed_lines(all_records)
    print(f"Saved visualizations to: {OUTPUT_DIR}")


if __name__ == "__main__":
    main()
