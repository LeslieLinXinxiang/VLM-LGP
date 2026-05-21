#!/usr/bin/env python3
"""Visualize manual score analysis for pure LLM baseline."""
from __future__ import annotations

import json
from pathlib import Path

import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parents[2]
OUT_ROOT = ROOT / "experiments/outputs/pure_llm_baseline/accuracy_analysis/cubeStacking"
METRICS_PATH = OUT_ROOT / "metrics_summary.json"
VIZ_DIR = OUT_ROOT / "visualizations"


def main() -> None:
    if not METRICS_PATH.exists():
        raise FileNotFoundError(f"Missing metrics summary: {METRICS_PATH}")

    metrics = json.loads(METRICS_PATH.read_text(encoding="utf-8"))
    mags = sorted(metrics.get("magnitudes", {}).keys())
    if not mags:
        raise RuntimeError("No magnitude data found in metrics_summary.json")

    VIZ_DIR.mkdir(parents=True, exist_ok=True)

    nr_vals = [metrics["magnitudes"][m]["nr"]["accuracy"] for m in mags]
    r_vals = [metrics["magnitudes"][m]["r"]["accuracy"] for m in mags]
    c_vals = [metrics["magnitudes"][m]["combined"]["accuracy"] for m in mags]

    # Plot 1: combined bar
    plt.figure(figsize=(9, 6))
    bars = plt.bar(mags, c_vals, color="#2563eb", width=0.65)
    plt.title("Pure LLM Baseline - Manual Combined Accuracy by Magnitude")
    plt.xlabel("Magnitude")
    plt.ylabel("Accuracy (%)")
    plt.ylim(0, 100)
    plt.grid(axis="y", linestyle="--", alpha=0.4)
    for b in bars:
        h = b.get_height()
        plt.text(b.get_x() + b.get_width() / 2.0, h + 1.2, f"{h:.1f}%", ha="center", fontsize=9)
    plt.tight_layout()
    plt.savefig(VIZ_DIR / "combined_accuracy_by_magnitude.svg", format="svg")
    plt.close()

    # Plot 2: split lines NR/R/Combined
    plt.figure(figsize=(10, 6))
    plt.plot(mags, nr_vals, marker="o", linewidth=2, label="NR", color="#dc2626")
    plt.plot(mags, r_vals, marker="o", linewidth=2, label="R", color="#16a34a")
    plt.plot(mags, c_vals, marker="o", linewidth=2.5, label="Combined", color="#1d4ed8")
    plt.title("Pure LLM Baseline - Manual Accuracy Trends")
    plt.xlabel("Magnitude")
    plt.ylabel("Accuracy (%)")
    plt.ylim(0, 100)
    plt.grid(linestyle="--", alpha=0.4)
    plt.legend()
    plt.tight_layout()
    plt.savefig(VIZ_DIR / "nr_r_combined_trends.svg", format="svg")
    plt.close()

    # Plot 3: overall NR vs R vs Combined
    overall = metrics.get("overall", {})
    labels = ["NR", "R", "Combined"]
    values = [
        overall.get("nr", {}).get("accuracy", 0.0),
        overall.get("r", {}).get("accuracy", 0.0),
        overall.get("combined", {}).get("accuracy", 0.0),
    ]
    colors = ["#dc2626", "#16a34a", "#1d4ed8"]

    plt.figure(figsize=(8, 5))
    bars = plt.bar(labels, values, color=colors, width=0.6)
    plt.title("Pure LLM Baseline - Overall Manual Accuracy")
    plt.ylabel("Accuracy (%)")
    plt.ylim(0, 100)
    plt.grid(axis="y", linestyle="--", alpha=0.4)
    for b in bars:
        h = b.get_height()
        plt.text(b.get_x() + b.get_width() / 2.0, h + 1.2, f"{h:.1f}%", ha="center", fontsize=10)
    plt.tight_layout()
    plt.savefig(VIZ_DIR / "overall_nr_r_combined.svg", format="svg")
    plt.close()

    print(f"Saved visualizations to: {VIZ_DIR}")


if __name__ == "__main__":
    main()
