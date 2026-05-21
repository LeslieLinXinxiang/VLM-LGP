#!/usr/bin/env python3
import re
from pathlib import Path
import matplotlib.pyplot as plt

# Premium Aesthetics: Custom color palette and fonts
COLORS = ['#636EFA', '#EF553B', '#00CC96', '#AB63FA', '#FFA15A', '#19D3F3', '#FF6692', '#B6E880', '#FF97FF', '#FECB52']
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
    'axes.labelsize': 11
})

ROOT = Path(__file__).resolve().parents[2]
ACC_ROOT = ROOT / "experiments/outputs/accuracy_analysis/cubeStacking"
OUTPUT_DIR = ACC_ROOT / "visualizations"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

def parse_report(md_path):
    text = md_path.read_text(encoding='utf-8')
    matches = re.findall(r"\|\s*(cube_n\d{2}_s\d{2})\s*\|.*?\|\s*(\d+)%\s*\|\s*T\d{2}\s*\|", text)
    data = []
    for case, acc in matches:
        data.append({
            "cubes": int(case.split('_')[1][1:]),
            "scenario": case.split('_')[2],
            "accuracy": int(acc)
        })
    return data

def main():
    all_data = []
    for n in [4, 5, 6, 7, 8]:
        report = ACC_ROOT / f"{n}cubes/accuracy_report.md"
        if report.exists():
            all_data.extend(parse_report(report))
    
    if not all_data:
        print("Error: No data found.")
        return

    # Process for Summary (Avg per magnitude)
    mags = sorted(list(set(d['cubes'] for d in all_data)))
    avg_accs = [sum(d['accuracy'] for d in all_data if d['cubes'] == m) / 
                len([d for d in all_data if d['cubes'] == m]) for m in mags]

    # Plot 1: Summary Bar Chart
    plt.figure(figsize=(9, 6))
    bars = plt.bar([str(m) for m in mags], avg_accs, color='#3b82f6', width=0.6, zorder=3)
    plt.grid(axis='y', linestyle='--', alpha=0.7, zorder=0)
    plt.ylim(0, 105)
    plt.title("Planning Success Rate by Complexity", pad=20, fontweight='bold')
    plt.xlabel("Number of Objects", labelpad=10)
    plt.ylabel("Avg Accuracy (%)", labelpad=10)
    
    # Value labels
    for bar in bars:
        height = bar.get_height()
        plt.text(bar.get_x() + bar.get_width()/2., height + 2, f'{height:.1f}%', 
                 ha='center', va='bottom', fontweight='bold', color='#1e293b')

    plt.tight_layout()
    plt.savefig(OUTPUT_DIR / "summary_accuracy.svg", format='svg')
    print(f"Saved: {OUTPUT_DIR / 'summary_accuracy.svg'}")

    # Plot 2: Detailed Line Plot (Scenarios)
    plt.figure(figsize=(10, 6))
    scenarios = sorted(list(set(d['scenario'] for d in all_data)))
    for i, s in enumerate(scenarios):
        s_data = sorted([d for d in all_data if d['scenario'] == s], key=lambda x: x['cubes'])
        x = [d['cubes'] for d in s_data]
        y = [d['accuracy'] for d in s_data]
        plt.plot(x, y, label=f"Scenario {s.upper()}", marker='o', markersize=7, 
                 linewidth=2, color=COLORS[i % len(COLORS)], alpha=0.9, zorder=5)

    plt.grid(linestyle='--', alpha=0.5, zorder=0)
    plt.xticks(mags)
    plt.ylim(0, 105)
    plt.title("Detailed Stability across Scenes", pad=20, fontweight='bold')
    plt.xlabel("Number of Objects", labelpad=10)
    plt.ylabel("Accuracy (%)", labelpad=10)
    plt.legend(bbox_to_anchor=(1.05, 1), loc='upper left', frameon=True, shadow=False)
    plt.tight_layout()
    plt.savefig(OUTPUT_DIR / "detailed_scenarios.svg", format='svg')
    print(f"Saved: {OUTPUT_DIR / 'detailed_scenarios.svg'}")

if __name__ == "__main__":
    main()
