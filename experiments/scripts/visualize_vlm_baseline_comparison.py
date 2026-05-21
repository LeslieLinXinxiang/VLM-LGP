#!/usr/bin/env python3
import matplotlib.pyplot as plt
import numpy as np
from pathlib import Path

# Premium Aesthetics
plt.rcParams.update({
    'axes.facecolor': '#f8f9fa',
    'axes.edgecolor': '#ced4da',
    'axes.labelcolor': '#495057',
    'xtick.color': '#495057',
    'ytick.color': '#495057',
    'grid.color': '#e9ecef',
    'figure.facecolor': 'white',
    'font.size': 10,
    'axes.titlesize': 14,
    'axes.labelsize': 11
})

ROOT = Path("/home/leslie/Projects/VLM_LGP")
OUTPUT_DIR = ROOT / "experiments/outputs/pure_llm_baseline/accuracy_analysis/visualizations"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

def main():
    magnitudes = [4, 5, 6, 7, 8]
    nr_accs = [74.0, 76.0, 88.0, 68.0, 80.0]
    r_accs = [72.0, 64.0, 82.0, 58.0, 76.0]

    x = np.arange(len(magnitudes))
    width = 0.35

    fig, ax = plt.subplots(figsize=(10, 6))
    rects1 = ax.bar(x - width/2, nr_accs, width, label='NR (No Redundant)', color='#3b82f6', zorder=3)
    rects2 = ax.bar(x + width/2, r_accs, width, label='R (Redundant)', color='#ef4444', zorder=3)

    ax.set_ylabel('Avg Accuracy (%)')
    ax.set_xlabel('Number of Cubes')
    ax.set_title('Baseline Performance Comparison: NR vs. R', pad=20, fontweight='bold')
    ax.set_xticks(x)
    ax.set_xticklabels([f'{m} Cubes' for m in magnitudes])
    ax.set_ylim(0, 105)
    ax.legend(loc='upper left', frameon=True)
    ax.grid(axis='y', linestyle='--', alpha=0.7, zorder=0)

    def autolabel(rects):
        for rect in rects:
            height = rect.get_height()
            ax.annotate(f'{height:.1f}%',
                        xy=(rect.get_x() + rect.get_width() / 2, height),
                        xytext=(0, 3),  # 3 points vertical offset
                        textcoords="offset points",
                        ha='center', va='bottom', fontweight='bold')

    autolabel(rects1)
    autolabel(rects2)

    plt.tight_layout()
    plt.savefig(OUTPUT_DIR / "baseline_nr_vs_r_comparison.svg", format='svg')
    print(f"Saved: {OUTPUT_DIR / 'baseline_nr_vs_r_comparison.svg'}")

if __name__ == "__main__":
    main()
