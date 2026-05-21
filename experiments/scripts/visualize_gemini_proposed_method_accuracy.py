#!/usr/bin/env python3
"""
Visualization script for Gemini proposed method accuracy analysis.
"""
import json
from pathlib import Path
from collections import defaultdict
import re

ROOT = Path(__file__).resolve().parents[2]
ANALYSIS_ROOT = ROOT / "experiments/outputs/gemini_proposed_method/accuracy_analysis/cubeStacking"


def extract_table_from_md(report_md: Path):
    """Extract accuracy table from markdown report."""
    text = report_md.read_text(encoding="utf-8")
    
    # Find the table
    lines = text.split('\n')
    table_lines = []
    in_table = False
    
    for line in lines:
        if '|' in line and '---' not in line:
            if in_table or 'Case' in line:
                in_table = True
                table_lines.append(line)
        elif in_table:
            break
    
    return table_lines


def parse_accuracy_from_table(table_lines):
    """Parse accuracy values from table rows."""
    accuracies = []
    for i, line in enumerate(table_lines):
        if i <= 1:  # Skip header and separator
            continue
        parts = [p.strip() for p in line.split('|')]
        if len(parts) > 2:
            case_name = parts[1]
            acc_str = parts[-2]  # Accuracy is second-to-last column
            acc_val = float(acc_str.rstrip('%'))
            accuracies.append({"case": case_name, "accuracy": acc_val})
    return accuracies


def main():
    print("Gemini Proposed Method — Accuracy Visualization\n")
    
    if not ANALYSIS_ROOT.exists():
        print(f"Error: {ANALYSIS_ROOT} does not exist. Run analyse script first.")
        return
    
    # Read cross-magnitude comparison
    cross_mag_path = ANALYSIS_ROOT / "cross_magnitude_comparison.md"
    if cross_mag_path.exists():
        text = cross_mag_path.read_text(encoding="utf-8")
        print(text)
        print("\n" + "="*70 + "\n")
    
    # Read each magnitude report
    for mag_dir in sorted(ANALYSIS_ROOT.iterdir()):
        if not mag_dir.is_dir():
            continue
        
        acc_report = mag_dir / "accuracy_report.md"
        if acc_report.exists():
            print(f"\n### {mag_dir.name.upper()}\n")
            
            report_text = acc_report.read_text(encoding="utf-8")
            # Extract just the table and average
            lines = report_text.split('\n')
            for i, line in enumerate(lines):
                if 'Accuracy Report' in line or '|' in line or 'Average' in line:
                    print(line)
    
    print("\n" + "="*70)
    print("✅ Analysis visualization complete")


if __name__ == "__main__":
    main()
