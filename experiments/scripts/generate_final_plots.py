import os
import json
from pathlib import Path
import numpy as np
import matplotlib.pyplot as plt

eval_dir = Path("/home/leslie/Projects/VLM_LGP/experiments/evaluations/LGP_execution/cubeStacking")
output_dir = Path("/home/leslie/Projects/VLM_LGP/experiments/outputs/LGP_execution_stats")

mags = ["4cubes", "5cubes", "6cubes", "7cubes", "8cubes"]
policies = ["lgp_split_smart", "lgp_split_global"]
modes = ["nr", "r"]

data = {mag: {pol: {mode: [] for mode in modes} for pol in policies} for mag in mags}
for mag in mags:
    for scenario in os.listdir(eval_dir / mag):
        for mode in modes:
            p = eval_dir / mag / scenario / mode
            if not p.exists(): continue
            for trial in os.listdir(p):
                for pol in policies:
                    meta = p / trial / pol / "trial_meta.json"
                    if meta.exists():
                        with open(meta, 'r') as f:
                            data[mag][pol][mode].append(json.load(f))

# Rewrite cross_magnitude_comparison.md
md_content = "# LGP Execution Data Statistical Analysis (FINAL - 1000 Tasks)\n\n"
md_content += "## 1. Overall Performance (NR Mode)\n"
md_content += "| Magnitude | Policy | Trials | Success Rate | Median Time (s) | Avg Peak Mem (MB) |\n"
md_content += "| :--- | :--- | :--- | :--- | :--- | :--- |\n"
for mag in mags:
    for pol in policies:
        res = data[mag][pol]["nr"]
        if not res: continue
        sr = sum(1 for r in res if r.get("success")) / len(res) * 100
        times = [r.get("runtime_s", 0) for r in res if r.get("success")]
        med_t = np.median(times) if times else 0
        mems = [r.get("memory_peak_mb", 0) for r in res]
        avg_mem = np.mean(mems) if mems else 0
        md_content += f"| {mag} | `{pol}` | {len(res)} | **{sr:.1f}%** | {med_t:.1f} | {avg_mem:.1f} |\n"

md_content += "\n## 2. Overall Performance (R Mode)\n"
md_content += "| Magnitude | Policy | Trials | Success Rate | Median Time (s) | Avg Peak Mem (MB) |\n"
md_content += "| :--- | :--- | :--- | :--- | :--- | :--- |\n"
for mag in mags:
    for pol in policies:
        res = data[mag][pol]["r"]
        if not res: continue
        sr = sum(1 for r in res if r.get("success")) / len(res) * 100
        times = [r.get("runtime_s", 0) for r in res if r.get("success")]
        med_t = np.median(times) if times else 0
        mems = [r.get("memory_peak_mb", 0) for r in res]
        avg_mem = np.mean(mems) if mems else 0
        md_content += f"| {mag} | `{pol}` | {len(res)} | **{sr:.1f}%** | {med_t:.1f} | {avg_mem:.1f} |\n"

(output_dir / "cross_magnitude_comparison.md").write_text(md_content)

# Plotting
plt.style.use('seaborn-v0_8-muted')
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(12, 12))
x = np.arange(len(mags))
width = 0.2

for i, (pol, mode, color, label) in enumerate([
    ("lgp_split_smart", "nr", "#2ecc71", "Smart-NR"),
    ("lgp_split_smart", "r", "#27ae60", "Smart-R"),
    ("lgp_split_global", "nr", "#e74c3c", "Global-NR"),
    ("lgp_split_global", "r", "#c0392b", "Global-R")
]):
    srs = []
    times = []
    for mag in mags:
        res = data[mag][pol][mode]
        srs.append(sum(1 for r in res if r.get("success")) / len(res) * 100 if res else 0)
        t_list = [r.get("runtime_s", 0) for r in res if r.get("success")]
        times.append(np.mean(t_list) if t_list else 0)
    
    ax1.bar(x + (i-1.5)*width, srs, width, label=label, color=color)
    ax2.bar(x + (i-1.5)*width, times, width, label=label, color=color.replace("2e", "34").replace("e7", "f1")) # Adjust color slightly for time plot

ax1.set_ylabel('Success Rate (%)')
ax1.set_title('Success Rate Comparison (N=1000)')
ax1.set_xticks(x)
ax1.set_xticklabels(mags)
ax1.legend()

ax2.set_ylabel('Avg Solving Time (s)')
ax2.set_title('Solving Time Comparison (Successful Only)')
ax2.set_xticks(x)
ax2.set_xticklabels(mags)
ax2.legend()

plt.tight_layout()
plt.savefig(output_dir / "performance_final_1000tasks.svg")
print(f"Files updated.")
