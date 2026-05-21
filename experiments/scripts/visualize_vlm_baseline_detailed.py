#!/usr/bin/env python3
import re
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np

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
ACC_ROOT = ROOT / "experiments/outputs/pure_llm_baseline/accuracy_analysis"
OUTPUT_DIR = ACC_ROOT / "visualizations"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

def parse_report_detailed(md_path):
    if not md_path.exists():
        return None
    text = md_path.read_text(encoding='utf-8')
    # Matches: | s01 | ... | 100% | T01 |
    matches = re.findall(r"\|\s*(s\d{2})\s*\|.*?\|\s*(\d+)%\s*\|\s*T\d{2}\s*\|", text)
    data = {}
    for scenario, acc in matches:
        data[scenario] = int(acc)
    return data

def plot_detailed_matrix(mode_data, mode_name, full_name):
    magnitudes = [4, 5, 6, 7, 8]
    scenarios = ["s01", "s02", "s03", "s04", "s05"]
    
    # Prepare data matrix
    matrix = np.zeros((len(scenarios), len(magnitudes)))
    for j, m in enumerate(magnitudes):
        mag_data = mode_data.get(m, {})
        for i, s in enumerate(scenarios):
            matrix[i, j] = mag_data.get(s, 0)

    fig, ax = plt.subplots(figsize=(10, 7))
    
    # Use a bar chart for better clarity per case
    width = 0.15
    x = np.arange(len(magnitudes))
    
    colors = ['#636EFA', '#EF553B', '#00CC96', '#AB63FA', '#FFA15A']
    
    for i, s in enumerate(scenarios):
        ax.bar(x + (i - 2) * width, matrix[i, :], width, label=f"Scenario {s.upper()}", color=colors[i])

    ax.set_ylabel('Accuracy (%)')
    ax.set_xlabel('Complexity (Number of Cubes)')
    ax.set_title(f'Detailed Accuracy per Scenario - {full_name}', pad=20, fontweight='bold')
    ax.set_xticks(x)
    ax.set_xticklabels([f'{m} Cubes' for m in magnitudes])
    ax.set_ylim(0, 115)
    ax.legend(loc='upper right', frameon=True)
    ax.grid(axis='y', linestyle='--', alpha=0.7)

    # Add labels on top of bars
    for i in range(len(scenarios)):
        for j in range(len(magnitudes)):
            val = matrix[i, j]
            ax.text(x[j] + (i - 2) * width, val + 2, f'{int(val)}%', 
                    ha='center', va='bottom', fontsize=8, fontweight='bold', rotation=45)

    plt.tight_layout()
    plt.savefig(OUTPUT_DIR / f"detailed_scenarios_{mode_name}.svg", format='svg')
    print(f"Saved: {OUTPUT_DIR / f'detailed_scenarios_{mode_name}.svg'}")

def main():
    for mode, full_name in [('nr', 'No Redundant Objects (NR)'), ('r', 'With Redundant Objects (R)')]:
        mode_data = {}
        for n in [4, 5, 6, 7, 8]:
            report_path = ACC_ROOT / f"{n}cubes/accuracy_report_{mode}.md"
            data = parse_report_detailed(report_path)
            if data:
                mode_data[n] = data
        
        if mode_data:
            plot_detailed_matrix(mode_data, mode, full_name)

if __name__ == "__main__":
    main()
