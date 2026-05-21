import os
import json
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np
import argparse

def categorize_failure(meta, log_content):
    if meta.get("memory_exceeded", False):
        return "OOM"
    if meta.get("timeout", False):
        return "Timeout"
    if "ERROR:util.cpp:cd_file" in log_content:
        return "Path Error (cd_file)"
    if "Infeasible" in log_content or "no solution found" in log_content:
        return "Kinematic Infeasible"
    if "terminate called" in log_content or "STACK" in log_content:
        return "Solver Crash"
    return "Unknown/Other"

def generate_plots_and_report(eval_dir, output_report, output_plots_dir):
    data = []
    failures = []
    
    print(f"Scanning {eval_dir}...")
    for root, dirs, files in os.walk(eval_dir):
        if "trial_meta.json" in files:
            meta_path = os.path.join(root, "trial_meta.json")
            try:
                with open(meta_path, 'r') as f:
                    meta = json.load(f)
                
                parts = Path(root).parts
                if 'cubeStacking' in parts:
                    idx = parts.index('cubeStacking')
                    # Expecting: .../cubeStacking/mag/scenario/mode/trial/policy
                    if len(parts) > idx + 5:
                        meta['mag'] = parts[idx+1]
                        meta['scenario'] = parts[idx+2]
                        meta['mode'] = parts[idx+3]
                        meta['trial'] = parts[idx+4]
                        meta['policy'] = parts[idx+5]
                    else:
                        continue
                else:
                    continue

                data.append(meta)
                
                if not meta.get('success', False):
                    log_path = os.path.join(root, "solver_stdout.log")
                    log_content = ""
                    log_snippet = "Log file missing"
                    if os.path.exists(log_path):
                        with open(log_path, 'r', errors='ignore') as log_f:
                            lines = log_f.readlines()
                            log_content = "".join(lines)
                            log_snippet = "".join(lines[-15:])
                    
                    reason = categorize_failure(meta, log_content)
                    
                    failures.append({
                        'mag': meta['mag'],
                        'scenario': meta['scenario'],
                        'mode': meta['mode'],
                        'trial': meta['trial'],
                        'policy': meta['policy'],
                        'reason': reason,
                        'snippet': log_snippet.strip()
                    })
            except Exception as e:
                print(f"Error processing {root}: {e}")

    if not data:
        print("No data found!")
        return

    # --- Plotting ---
    print("Generating plots...")
    os.makedirs(output_plots_dir, exist_ok=True)
    
    mags = sorted(list(set(d['mag'] for d in data)), key=lambda x: int(x.replace('cubes', '')))
    policies = ['lgp_split_smart', 'lgp_split_global']
    modes = ['nr', 'r']
    
    plt.rcParams.update({'font.size': 12})
    
    for mode in modes:
        # Success Rate Plot
        fig, ax = plt.subplots(figsize=(10, 6))
        x = np.arange(len(mags))
        width = 0.35
        
        for i, policy in enumerate(policies):
            sr = []
            for mag in mags:
                subset = [d for d in data if d['mag'] == mag and d['policy'] == policy and d['mode'] == mode]
                if not subset:
                    sr.append(0)
                    continue
                success_count = sum(1 for d in subset if d.get('success', False))
                sr.append(success_count / len(subset) * 100)
            
            ax.bar(x + (i - 0.5) * width, sr, width, label=policy.replace('lgp_split_', ''))
        
        ax.set_ylabel('Success Rate (%)')
        ax.set_ylim(0, 105)
        ax.set_title(f'Success Rate Comparison ({mode.upper()} Mode)')
        ax.set_xticks(x)
        ax.set_xticklabels(mags)
        ax.legend()
        ax.grid(axis='y', linestyle='--', alpha=0.7)
        plt.tight_layout()
        plt.savefig(os.path.join(output_plots_dir, f'sr_comparison_{mode}.svg'))
        plt.close()

        # Median Runtime Plot
        fig, ax = plt.subplots(figsize=(10, 6))
        for i, policy in enumerate(policies):
            times = []
            for mag in mags:
                subset = [d for d in data if d['mag'] == mag and d['policy'] == policy and d['mode'] == mode and d.get('success', False)]
                if not subset:
                    times.append(0)
                    continue
                median_time = np.median([d['runtime_s'] for d in subset])
                times.append(median_time)
            
            ax.bar(x + (i - 0.5) * width, times, width, label=policy.replace('lgp_split_', ''))
        
        ax.set_ylabel('Median Runtime (s)')
        ax.set_title(f'Median Runtime Comparison ({mode.upper()} Mode)')
        ax.set_xticks(x)
        ax.set_xticklabels(mags)
        ax.legend()
        ax.grid(axis='y', linestyle='--', alpha=0.7)
        plt.tight_layout()
        plt.savefig(os.path.join(output_plots_dir, f'time_comparison_{mode}.svg'))
        plt.close()

    # --- Markdown Report ---
    print(f"Writing report to {output_report}...")
    with open(output_report, 'w') as f:
        f.write("# LGP Detailed Failure Analysis & Performance Plots\n\n")
        f.write("## 1. Performance Visualization\n")
        f.write("### Non-Reachable (NR) Mode\n")
        f.write("Comparison of success rates and solving times for scenarios without reachability constraints.\n\n")
        f.write(f"![Success Rate (NR)](plots/sr_comparison_nr.svg)\n\n")
        f.write(f"![Runtime (NR)](plots/time_comparison_nr.svg)\n\n")
        
        f.write("### Reachable (R) Mode\n")
        f.write("Comparison of performance in complex scenarios with reachability/collision constraints.\n\n")
        f.write(f"![Success Rate (R)](plots/sr_comparison_r.svg)\n\n")
        f.write(f"![Runtime (R)](plots/time_comparison_r.svg)\n\n")
        
        f.write("## 2. Failure List (Detailed Summary)\n")
        f.write("This table lists all failed trials with their attributed failure reason and the last few lines of the solver log.\n\n")
        f.write("| Mag | Mode | Policy | Scenario | Trial | Reason | Log Snippet |\n")
        f.write("| :--- | :--- | :--- | :--- | :--- | :--- | :--- |\n")
        # Sort failures for readability
        failures.sort(key=lambda x: (x['mag'], x['mode'], x['policy'], x['scenario'], x['trial']))
        for fail in failures:
            snippet = fail['snippet'].replace('\n', '<br>').replace('|', '\|')
            f.write(f"| {fail['mag']} | {fail['mode']} | `{fail['policy'].replace('lgp_split_', '')}` | {fail['scenario']} | {fail['trial']} | **{fail['reason']}** | <pre style='font-size: 8px'>{snippet}</pre> |\n")

    print("Done.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--eval-dir", default="/home/leslie/Projects/VLM_LGP/experiments/evaluations/LGP_execution/cubeStacking")
    parser.add_argument("--output", default="/home/leslie/Projects/VLM_LGP/experiments/outputs/LGP_execution_stats/failure_analysis_report.md")
    args = parser.parse_args()
    
    plots_dir = os.path.join(os.path.dirname(args.output), "plots")
    generate_plots_and_report(args.eval_dir, args.output, plots_dir)
