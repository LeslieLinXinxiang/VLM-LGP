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

ROOT = Path("/home/leslie/Projects/VLM_LGP")
ACC_ROOT = ROOT / "experiments/outputs/pure_llm_baseline/accuracy_analysis"
OUTPUT_DIR = ACC_ROOT / "visualizations"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

def parse_report(md_path, n_cubes):
    text = md_path.read_text(encoding='utf-8')
    # Matches: | s01 | ... | 100% | T01 |
    matches = re.findall(r"\|\s*(s\d{2})\s*\|.*?\|\s*(\d+)%\s*\|\s*T\d{2}\s*\|", text)
    data = []
    for scenario, acc in matches:
        data.append({
            "cubes": n_cubes,
            "scenario": scenario,
            "accuracy": int(acc)
        })
    return data

def plot_summary(all_data, mode):
    mags = sorted(list(set(d['cubes'] for d in all_data)))
    avg_accs = [sum(d['accuracy'] for d in all_data if d['cubes'] == m) / 
                len([d for d in all_data if d['cubes'] == m]) for m in mags]

    plt.figure(figsize=(9, 6))
    bars = plt.bar([str(m) for m in mags], avg_accs, color='#3b82f6' if mode == 'nr' else '#ef4444', width=0.6, zorder=3)
    plt.grid(axis='y', linestyle='--', alpha=0.7, zorder=0)
    plt.ylim(0, 105)
    plt.title(f"Baseline Planning Success Rate ({mode.upper()})", pad=20, fontweight='bold')
    plt.xlabel("Number of Objects", labelpad=10)
    plt.ylabel("Avg Accuracy (%)", labelpad=10)
    
    for bar in bars:
        height = bar.get_height()
        plt.text(bar.get_x() + bar.get_width()/2., height + 2, f'{height:.1f}%', 
                 ha='center', va='bottom', fontweight='bold', color='#1e293b')

    plt.tight_layout()
    plt.savefig(OUTPUT_DIR / f"summary_accuracy_{mode}.svg", format='svg')
    print(f"Saved: {OUTPUT_DIR / f'summary_accuracy_{mode}.svg'}")

def main():
    for mode in ['nr', 'r']:
        all_data = []
        for n in [4, 5, 6, 7, 8]:
            report = ACC_ROOT / f"{n}cubes/accuracy_report_{mode}.md"
            if report.exists():
                all_data.extend(parse_report(report, n))
        
        if all_data:
            plot_summary(all_data, mode)
        else:
            print(f"No data for mode {mode}")

if __name__ == "__main__":
    main()
