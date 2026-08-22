#!/usr/bin/env python3
"""Visualize the VLM-MSGraph baseline Track 1 manual review.

Chart set is deliberately shaped by the Track 1 reporting rule: the pooled
per-benchmark bar (with Wilson 95% error bars) is the headline figure. The
per-magnitude view is drawn as *bars, not a trend line*, and each bar is labelled with
its own N (scales with how many trials have been scored per scenario) — a line chart
would visually assert a degradation trend the sample size cannot support.

Outputs (svg + png) to experiments/outputs/VLM-MSGraph_baseline/accuracy_analysis/visualizations/

Usage:
    python3 visualize_vlm_msgraph_manual_scores.py
"""
from __future__ import annotations

import json
import re
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parents[2]
OUT_ROOT = ROOT / "experiments/outputs/VLM-MSGraph_baseline/accuracy_analysis"
METRICS_PATH = OUT_ROOT / "metrics_summary.json"
VIZ_DIR = OUT_ROOT / "visualizations"

BENCH_COLOR = {"cubeStacking": "#2563eb", "FMB": "#c2410c"}
CORRECT_C, WRONG_C = "#16a34a", "#dc2626"


def _mag_key(m: str) -> int:
    x = re.search(r"\d+", m)
    return int(x.group()) if x else 0


def _save(fig, name: str) -> None:
    VIZ_DIR.mkdir(parents=True, exist_ok=True)
    fig.savefig(VIZ_DIR / f"{name}.svg", format="svg", bbox_inches="tight")
    fig.savefig(VIZ_DIR / f"{name}.png", dpi=200, bbox_inches="tight")
    plt.close(fig)
    print(f"  {VIZ_DIR / (name + '.svg')}")


def plot_pooled(metrics: dict) -> None:
    benches = [b for b in ("cubeStacking", "FMB") if b in metrics["benchmarks"]]
    vals, los, his, labels = [], [], [], []
    for b in benches:
        p = metrics["benchmarks"][b]["pooled"]
        vals.append(p["accuracy"])
        los.append(max(0.0, p["accuracy"] - p["wilson95_low"]))
        his.append(max(0.0, p["wilson95_high"] - p["accuracy"]))
        labels.append(f"{b}\n(N={p['total']})")

    ov = metrics["overall"]
    vals.append(ov["accuracy"])
    los.append(max(0.0, ov["accuracy"] - ov["wilson95_low"]))
    his.append(max(0.0, ov["wilson95_high"] - ov["accuracy"]))
    labels.append(f"Overall\n(N={ov['total']})")
    colors = [BENCH_COLOR.get(b, "#475569") for b in benches] + ["#475569"]

    fig, ax = plt.subplots(figsize=(8.5, 6))
    bars = ax.bar(labels, vals, color=colors, width=0.6,
                  yerr=[los, his], capsize=8, ecolor="#1e293b")
    ax.set_ylabel("Content accuracy (%)")
    ax.set_ylim(0, 105)
    ax.set_title("VLM-MSGraph Baseline — Track 1 Pooled Content Accuracy\n"
                 "(manual review vs. input image; error bars = Wilson 95%)",
                 fontsize=12, fontweight="bold")
    ax.grid(axis="y", linestyle="--", alpha=0.4)
    ax.set_axisbelow(True)
    for b, v, p in zip(bars, vals, metrics["benchmarks"].values()):
        ax.text(b.get_x() + b.get_width() / 2, 2, f"{v:.1f}%", ha="center",
                va="bottom", fontsize=12, fontweight="bold", color="white")
    _save(fig, "pooled_accuracy_by_benchmark")


def plot_per_magnitude(metrics: dict) -> None:
    benches = [b for b in ("cubeStacking", "FMB") if b in metrics["benchmarks"]]
    fig, axes = plt.subplots(1, len(benches), figsize=(6.2 * len(benches), 5.6), squeeze=False)
    for ax, bench in zip(axes[0], benches):
        mags = sorted(metrics["benchmarks"][bench]["magnitudes"], key=_mag_key)
        vals = [metrics["benchmarks"][bench]["magnitudes"][m]["accuracy"] for m in mags]
        ns = [metrics["benchmarks"][bench]["magnitudes"][m]["total"] for m in mags]
        pooled = metrics["benchmarks"][bench]["pooled"]["accuracy"]
        bars = ax.bar(mags, vals, color=BENCH_COLOR.get(bench, "#475569"), width=0.62)
        ax.axhline(pooled, color="#111827", linestyle="--", linewidth=1.6,
                   label=f"pooled {pooled:.1f}%")
        ax.set_title(f"{bench} — per magnitude\n(descriptive only, N={ns[0] if ns else 0} per cell)",
                     fontsize=11, fontweight="bold")
        ax.set_ylabel("Content accuracy (%)")
        ax.set_ylim(0, 105)
        ax.grid(axis="y", linestyle="--", alpha=0.4)
        ax.set_axisbelow(True)
        ax.legend(loc="lower right", fontsize=9)
        for b, v, n in zip(bars, vals, ns):
            ax.text(b.get_x() + b.get_width() / 2, v + 2, f"{v:.0f}%\nn={n}",
                    ha="center", fontsize=9)
    min_n = min((n for b in metrics["benchmarks"].values() for n in
                (m["total"] for m in b["magnitudes"].values())), default=0)
    fig.suptitle(f"Not a degradation curve — smallest cell has N={min_n}; "
                 f"a single flip still moves a low-N cell by a large margin",
                 fontsize=10, color="#6b7280", y=0.02)
    fig.tight_layout()
    _save(fig, "per_magnitude_descriptive")


def plot_content_vs_format(metrics: dict) -> None:
    fc = metrics.get("format_compliance", {})
    if not fc.get("available"):
        return
    benches = [b for b in ("cubeStacking", "FMB") if b in metrics["benchmarks"]]
    x = range(len(benches))
    content = [metrics["benchmarks"][b]["pooled"]["accuracy"] for b in benches]
    fmt = [fc["per_benchmark"].get(b, {}).get("rate", 0.0) for b in benches]

    fig, ax = plt.subplots(figsize=(8, 5.4))
    w = 0.36
    b1 = ax.bar([i - w / 2 for i in x], content, w, label="Content accuracy (vs. image)", color=CORRECT_C)
    b2 = ax.bar([i + w / 2 for i in x], fmt, w, label="Format compliance (schema, no GT)", color="#0ea5e9")
    ax.set_xticks(list(x))
    ax.set_xticklabels(benches)
    ax.set_ylabel("Percent")
    ax.set_ylim(0, 112)
    ax.set_title("Two separate measures — never merged into one number",
                 fontsize=12, fontweight="bold")
    ax.grid(axis="y", linestyle="--", alpha=0.4)
    ax.set_axisbelow(True)
    ax.legend(loc="lower center", fontsize=9)
    for group in (b1, b2):
        for b in group:
            ax.text(b.get_x() + b.get_width() / 2, b.get_height() + 1.5,
                    f"{b.get_height():.1f}%", ha="center", fontsize=9)
    _save(fig, "content_vs_format")


def plot_case_grid(metrics: dict) -> None:
    """Per-scenario pass/fail grid, one column per scenario slot, each column split into
    horizontal strips (one per trial) so trial_01 vs trial_02 stay directly comparable.

    Column position is scoped *within each magnitude row*, not shared globally across
    rows: cubeStacking's case_name bakes the magnitude into the string
    (cube_n04_s01 != cube_n05_s01 — 25 genuinely distinct scenarios), so pooling case
    identity across rows into one shared x-axis fans a single magnitude's 5 scenarios
    out into 25 duplicate-labelled columns (a real bug in an earlier version of this
    chart — FMB's case_name happens to be reused verbatim across magnitude tiers
    ("001".."005"), so the same mistake didn't visibly break FMB, but it was still
    wrong in principle there too). Column N always means 'the Nth scenario variant of
    THIS row's tier' — an ordinal position, not a cross-row identity — which matches
    how the case files are actually named (alphabetical order = scenario index) for
    both benchmarks."""
    benches = [b for b in ("cubeStacking", "FMB") if b in metrics["benchmarks"]]
    fig, axes = plt.subplots(1, len(benches), figsize=(7.2 * len(benches), 5.4), squeeze=False)
    for ax, bench in zip(axes[0], benches):
        mags = sorted(metrics["benchmarks"][bench]["magnitudes"], key=_mag_key)

        by_mag_row = {}  # mag -> ordered list of {trial: v} dicts, position = scenario index
        all_trials = set()
        max_cases = 0
        for mag in mags:
            cases = metrics["benchmarks"][bench]["magnitudes"][mag]["cases"]  # "case/trial_NN" -> v
            grouped = {}
            for key, v in cases.items():
                case, _, trial_part = key.rpartition("/")
                trial = int(re.search(r"\d+", trial_part).group())
                grouped.setdefault(case, {})[trial] = v
                all_trials.add(trial)
            row = [grouped[c] for c in sorted(grouped)]  # sorted by case_name = scenario order
            by_mag_row[mag] = row
            max_cases = max(max_cases, len(row))

        trial_order = sorted(all_trials)
        n_trials = max(1, len(trial_order))
        strip_h = 1.0 / n_trials

        for yi, mag in enumerate(mags):
            for xi, trials in enumerate(by_mag_row[mag]):
                for ti, trial in enumerate(trial_order):
                    if trial not in trials:
                        continue
                    v = trials[trial]
                    y0 = yi + ti * strip_h
                    ax.add_patch(plt.Rectangle((xi + 0.03, y0 + 0.02), 0.94, strip_h - 0.04,
                                               color=CORRECT_C if v else WRONG_C))
                    mark = "✓" if v else "✗"
                    ax.text(xi + 0.5, y0 + strip_h / 2, f"{mark} t{trial}", ha="center", va="center",
                            color="white", fontsize=9.5, fontweight="bold")

        ax.set_xlim(0, max_cases)
        ax.set_ylim(0, len(mags))
        ax.set_yticks([i + 0.5 for i in range(len(mags))])
        ax.set_yticklabels(mags)
        ax.set_xticks([i + 0.5 for i in range(max_cases)])
        ax.set_xticklabels([f"s{i + 1:02d}" for i in range(max_cases)])
        ax.set_title(f"{bench} — per-scenario outcome by trial\n"
                     f"(each column = 1 scenario, split into {n_trials} trial strip(s))",
                     fontsize=10.5, fontweight="bold")
        ax.set_aspect("auto")
    fig.tight_layout()
    _save(fig, "per_trial_grid")


def main() -> None:
    if not METRICS_PATH.exists():
        raise FileNotFoundError(
            f"Missing {METRICS_PATH}\nRun: python3 experiments/scripts/analyse_vlm_msgraph_manual_scores.py"
        )
    metrics = json.loads(METRICS_PATH.read_text(encoding="utf-8"))
    if not metrics.get("benchmarks"):
        raise RuntimeError("No scored benchmarks in metrics_summary.json — score some trials first.")

    print("Saved visualizations:")
    plot_pooled(metrics)
    plot_per_magnitude(metrics)
    plot_content_vs_format(metrics)
    plot_case_grid(metrics)


if __name__ == "__main__":
    main()
