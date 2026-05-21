#!/usr/bin/env python3
"""
VLM Evaluation Accuracy Analysis
----------------------------------
Extracts FINAL_PDDL blocks from trial markdown files, selects a reference
answer by scanning trials in order, and outputs per-case accuracy tables plus
a cross-magnitude summary table.

Reference selection rule:
    - Scan trial_01.md -> trial_10.md in order.
    - Use the first valid FINAL_PDDL candidate as the reference answer.
    - If the candidate's support rate is exactly 10% (only self-match), treat it
        as an invalid reference and continue to the next candidate.
    - Keep advancing until a candidate has a support rate != 10%.
"""
import os
import re
import textwrap
from pathlib import Path
from collections import defaultdict

ROOT         = Path(__file__).resolve().parents[2]
EVAL_ROOT    = ROOT / "experiments/evaluations/VLM/image_reasoning/cubeStacking"
OUTPUT_ROOT  = ROOT / "experiments/outputs/image_reasoning/accuracy_analysis/cubeStacking"
TRIALS       = 10


# ── Helpers ──────────────────────────────────────────────────────────────────

def extract_final_pddl_from_md(md_path: Path):
    """Pull the FINAL_PDDL block out of a trial markdown file."""
    try:
        text = md_path.read_text(encoding="utf-8")
        m = re.search(r"## FINAL_PDDL_START\s*(.*?)\s*## FINAL_PDDL_END", text, re.DOTALL)
        if not m:
            return None
        block = m.group(1).strip()
        return block if block else None
    except Exception:
        return None


def normalize_pddl_block(block: str):
    """Normalize a PDDL block for stable equality comparison."""
    if not isinstance(block, str):
        return None
    lines = []
    for line in block.splitlines():
        cleaned = " ".join(line.strip().split())
        if cleaned:
            lines.append(cleaned)
    if not lines:
        return None
    return tuple(lines)



# ── Analysis ─────────────────────────────────────────────────────────────────

def load_case_trials(case_dir: Path):
    """Return ordered trials with extracted and normalized FINAL_PDDL blocks."""
    trials = []
    for t in range(1, TRIALS + 1):
        md = case_dir / f"trial_{t:02d}.md"
        if not md.exists():
            trials.append((t, None, None))
            continue
        raw_block = extract_final_pddl_from_md(md)
        norm_block = normalize_pddl_block(raw_block) if raw_block else None
        trials.append((t, raw_block, norm_block))
    return trials


def choose_reference_trial(trials):
    """Choose the first valid trial whose support rate is not 10%."""
    valid_trials = [(t, raw, norm) for t, raw, norm in trials if norm is not None]
    if not valid_trials:
        return None, None, {}

    freq = defaultdict(int)
    for _, _, norm in valid_trials:
        freq[norm] += 1

    total_valid = len(valid_trials)
    seen = set()
    for t, raw, norm in valid_trials:
        if norm in seen:
            continue
        seen.add(norm)
        acc = freq[norm] / total_valid * 100
        if acc != 10.0:
            return t, norm, freq

    # Fallback: if every unique candidate is 10%, use the first valid trial.
    t, raw, norm = valid_trials[0]
    return t, norm, freq


def analyse_case(case_dir: Path, case_name: str):
    trials = load_case_trials(case_dir)
    gt_trial, gt_norm, freq = choose_reference_trial(trials)

    results = {}
    for t, raw_block, norm_block in trials:
        if norm_block is None:
            results[t] = None
            continue
        if gt_trial is not None and t == gt_trial:
            results[t] = True
            continue
        results[t] = (gt_norm is not None and norm_block == gt_norm)

    n_valid = sum(1 for v in results.values() if v is not None)
    n_correct = sum(1 for v in results.values() if v is True)
    acc = (n_correct / n_valid * 100) if n_valid else 0.0
    return results, acc, gt_trial, n_valid, freq


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


# ── Output ────────────────────────────────────────────────────────────────────

def build_magnitude_table(mag_dir: Path):
    """Return (case_rows, summary_list) for one magnitude folder."""
    mag_name = mag_dir.name
    cases = sorted([d for d in mag_dir.iterdir() if d.is_dir()])
    if not cases:
        return None, []

    header = ["Case"] + [f"T{t:02d}" for t in range(1, TRIALS + 1)] + ["Accuracy", "GT"]
    rows = [header]
    summary_list = []

    for case_dir in cases:
        name = case_dir.name
        trial_results, acc, gt_trial, n_valid, _ = analyse_case(case_dir, name)
        cells = fmt_trial_row(trial_results, gt_trial)
        gt_label = f"T{gt_trial:02d}" if gt_trial is not None else "N/A"
        rows.append([name] + cells + [f"{acc:.0f}%", gt_label])
        summary_list.append({"case": name, "acc": acc, "magnitude": mag_name, "gt_trial": gt_trial, "n_valid": n_valid})

    return rows, summary_list


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

        rows, summary_list = build_magnitude_table(mag_dir)
        if not rows:
            continue

        all_summaries.extend(summary_list)

        # Write per-magnitude report
        out_dir = OUTPUT_ROOT / mag_name
        out_dir.mkdir(parents=True, exist_ok=True)
        table_md = rows_to_md_table(rows)

        avg_acc = sum(s["acc"] for s in summary_list) / len(summary_list) if summary_list else 0
        md_content = textwrap.dedent(f"""\
            # Accuracy Report — {mag_name}

            > Ground truth: selected by scanning trial outputs in order and choosing the first valid reference whose support rate is not 10%.
            > ✓ = matches GT graph topology | ✗ = different | GT = ground truth trial | — = missing

            {table_md}

            **Average Accuracy: {avg_acc:.1f}%**
        """)
        (out_dir / "accuracy_report.md").write_text(md_content, encoding="utf-8")
        print(f"  → {out_dir}/accuracy_report.md  (avg {avg_acc:.1f}%)")

    # Write cross-magnitude comparison table
    mag_groups = defaultdict(list)
    for s in all_summaries:
        mag_groups[s["magnitude"]].append(s["acc"])

    comp_rows = [["Magnitude", "Cases", "Avg Accuracy", "Min", "Max"]]
    for mag in sorted(mag_groups.keys()):
        accs = mag_groups[mag]
        comp_rows.append([
            mag,
            str(len(accs)),
            f"{sum(accs)/len(accs):.1f}%",
            f"{min(accs):.0f}%",
            f"{max(accs):.0f}%",
        ])

    comp_table = rows_to_md_table(comp_rows)
    overall_avg = sum(s["acc"] for s in all_summaries) / len(all_summaries) if all_summaries else 0
    comp_md = textwrap.dedent(f"""\
        # Cross-Magnitude Accuracy Comparison — Image Reasoning (VLM)

        > Each case's accuracy = % of valid trials whose FINAL_PDDL block matches the selected reference trial.

        {comp_table}

        **Overall Average Accuracy: {overall_avg:.1f}%**

        ---

        ## Notes
        - Reference answer selection:
          - Scan `trial_01.md` → `trial_10.md` in order.
          - Use the first valid `FINAL_PDDL` block whose support rate is not 10%.
          - If every unique candidate is 10%, fall back to the first valid trial.
    """)
    (OUTPUT_ROOT / "cross_magnitude_comparison.md").write_text(comp_md, encoding="utf-8")
    print(f"\n→ Cross-magnitude table: {OUTPUT_ROOT}/cross_magnitude_comparison.md")
    print(f"→ Overall avg accuracy: {overall_avg:.1f}%")


if __name__ == "__main__":
    main()
