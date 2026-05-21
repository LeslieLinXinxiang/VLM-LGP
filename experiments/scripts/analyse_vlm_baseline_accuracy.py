#!/usr/bin/env python3
import os
import re
import json
from pathlib import Path
from collections import defaultdict, Counter

ROOT         = Path("/home/leslie/Projects/VLM_LGP")
EVAL_ROOT    = ROOT / "experiments/evaluations/VLM/pure_llm_baseline"
OUTPUT_ROOT  = ROOT / "experiments/outputs/pure_llm_baseline/accuracy_analysis"
TRIALS       = 10

# ── Helpers ──────────────────────────────────────────────────────────────────

def extract_lgp_topology(md_path: Path):
    """
    Extract (supporter, object) pairs from (on supporter object) strings 
    inside <FILE> blocks in the MD file.
    """
    try:
        text = md_path.read_text(encoding="utf-8")
        # Extract all <FILE> blocks
        file_blocks = re.findall(r'<FILE.*?>\s*(.*?)\s*</FILE>', text, re.DOTALL)
        
        all_matches = []
        for block in file_blocks:
            # Find (on supporter object) inside the block
            matches = re.findall(r'\(on\s+([\w\.]+)\s+([\w\.]+)\)', block)
            all_matches.extend(matches)
        return all_matches
    except Exception:
        pass
    return None

def extract_type_from_name(name):
    name_lower = name.lower()
    if "long_rectprism" in name_lower:
        return "long_rectprism"
    if "rectprism" in name_lower: # must come after long_rectprism
        return "rectprism"
    if "triprism" in name_lower:
        return "triprism"
    if "cube" in name_lower:
        return "cube"
    if "table" in name_lower:
        return "table"
    return "unknown"

def normalize_topology(matches):
    """
    Convert LGP matches to a canonical Counter of (obj_type, sup_type, pos) tuples.
    """
    if matches is None:
        return None
    
    edges = []
    for sup, obj in matches:
        obj_type = extract_type_from_name(obj)
        sup_type = extract_type_from_name(sup)
        
        sup_lower = sup.lower()
        pos = ""
        if "table" in sup_lower:
            if "left" in sup_lower:
                pos = "left"
            elif "center" in sup_lower:
                pos = "center"
            elif "right" in sup_lower:
                pos = "right"
        else:
            # For cube/prism supporters, we don't track position as strictly in the original script
            pos = ""
            
        edges.append((obj_type, sup_type, pos))
    
    return Counter(edges)

def is_match(gt_topo, trial_topo) -> bool:
    if gt_topo is None or trial_topo is None:
        return False
    return normalize_topology(gt_topo) == normalize_topology(trial_topo)

# ── Analysis ─────────────────────────────────────────────────────────────────

def analyse_case_mode(case_dir: Path, mode: str):
    """mode is 'nr' or 'r'"""
    # Find the best GT trial
    best_gt = 1
    best_results = {}
    best_acc = -1
    
    for gt_trial in range(1, TRIALS + 1):
        gt_path = case_dir / f"trial_{gt_trial:02d}_{mode}.md"
        if not gt_path.exists():
            continue
            
        gt_topo = extract_lgp_topology(gt_path)
        if not gt_topo:
            continue
            
        current_results = {}
        for t in range(1, TRIALS + 1):
            md = case_dir / f"trial_{t:02d}_{mode}.md"
            if not md.exists():
                current_results[t] = None
                continue
            if t == gt_trial:
                current_results[t] = True
                continue
            trial_topo = extract_lgp_topology(md)
            current_results[t] = is_match(gt_topo, trial_topo)
            
        n_valid = sum(1 for v in current_results.values() if v is not None)
        n_correct = sum(1 for v in current_results.values() if v is True)
        acc = (n_correct / n_valid * 100) if n_valid else 0.0
        
        # If accuracy > 10% or this is the first one we've tried, set it as best
        if acc > 10 or best_acc == -1:
            best_gt = gt_trial
            best_results = current_results
            best_acc = acc
            if acc > 10:
                break # Found a good GT
                
    return best_results, best_acc, best_gt

def fmt_trial_row(results, gt_trial):
    cells = []
    for t in range(1, TRIALS + 1):
        v = results.get(t)
        if v is None:
            cells.append("—")
        elif t == gt_trial:
            cells.append("GT")
        elif v:
            cells.append("✓")
        else:
            cells.append("✗")
    return cells

def rows_to_md_table(rows):
    if not rows:
        return ""
    widths = [max(len(str(r[c])) for r in rows) for c in range(len(rows[0]))]
    lines = []
    for i, row in enumerate(rows):
        line = "| " + " | ".join(str(cell).ljust(widths[j]) for j, cell in enumerate(row)) + " |"
        lines.append(line)
        if i == 0:
            sep = "| " + " | ".join("-" * widths[j] for j in range(len(row))) + " |"
            lines.append(sep)
    return "\n".join(lines)

# ── Main ─────────────────────────────────────────────────────────────────────

def main():
    OUTPUT_ROOT.mkdir(parents=True, exist_ok=True)
    magnitudes = sorted([d for d in EVAL_ROOT.iterdir() if d.is_dir()])

    all_summaries = []

    for mag_dir in magnitudes:
        mag_name = mag_dir.name
        print(f"Processing {mag_name} ...")
        
        cases = sorted([d for d in mag_dir.iterdir() if d.is_dir()])
        if not cases:
            continue
            
        for mode in ['nr', 'r']:
            mag_mode_name = f"{mag_name}_{mode}"
            header = ["Case"] + [f"T{t:02d}" for t in range(1, TRIALS + 1)] + ["Accuracy", "GT"]
            rows = [header]
            summary_list = []
            
            for case_dir in cases:
                name = case_dir.name
                trial_results, acc, gt_trial = analyse_case_mode(case_dir, mode)
                cells = fmt_trial_row(trial_results, gt_trial)
                rows.append([name] + cells + [f"{acc:.0f}%", f"T{gt_trial:02d}"])
                summary_list.append({"case": name, "acc": acc, "magnitude": mag_name, "mode": mode})
            
            all_summaries.extend(summary_list)
            
            # Write per-magnitude/mode report
            out_dir = OUTPUT_ROOT / mag_name
            out_dir.mkdir(parents=True, exist_ok=True)
            table_md = rows_to_md_table(rows)
            
            avg_acc = sum(s["acc"] for s in summary_list) / len(summary_list) if summary_list else 0
            md_content = f"# Accuracy Report — {mag_name} ({mode})\n\n"
            md_content += f"> Ground truth: Automatically selected (first trial with >10% accuracy, else T01).\n"
            md_content += f"> ✓ = matches GT topology | ✗ = different | GT = ground truth trial | — = missing\n\n"
            md_content += f"{table_md}\n\n"
            md_content += f"**Average Accuracy: {avg_acc:.1f}%**\n"
            
            (out_dir / f"accuracy_report_{mode}.md").write_text(md_content, encoding="utf-8")
            print(f"  → {out_dir}/accuracy_report_{mode}.md  (avg {avg_acc:.1f}%)")

    # Write summary comparison
    # Group by (magnitude, mode)
    stats = defaultdict(list)
    for s in all_summaries:
        stats[(s["magnitude"], s["mode"])].append(s["acc"])
        
    comp_rows = [["Magnitude", "Mode", "Cases", "Avg Accuracy", "Min", "Max"]]
    for (mag, mode) in sorted(stats.keys()):
        accs = stats[(mag, mode)]
        comp_rows.append([
            mag,
            mode,
            str(len(accs)),
            f"{sum(accs)/len(accs):.1f}%",
            f"{min(accs):.0f}%",
            f"{max(accs):.0f}%",
        ])
        
    comp_table = rows_to_md_table(comp_rows)
    comp_md = f"# Cross-Magnitude Accuracy Comparison — Pure LLM Baseline\n\n"
    comp_md += f"{comp_table}\n"
    
    (OUTPUT_ROOT / "cross_magnitude_comparison.md").write_text(comp_md, encoding="utf-8")
    print(f"\n→ Comparison table: {OUTPUT_ROOT}/cross_magnitude_comparison.md")

if __name__ == "__main__":
    main()
