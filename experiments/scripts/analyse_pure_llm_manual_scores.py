#!/usr/bin/env python3
"""Analyse manual scores for pure LLM baseline and generate markdown reports."""
from __future__ import annotations

import json
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT_ROOT = ROOT / "experiments/outputs/pure_llm_baseline/accuracy_analysis/cubeStacking"
INDEX_PATH = OUT_ROOT / "review_index.json"
LATEST_PATH = OUT_ROOT / "manual_review/latest_scores.json"
METRICS_PATH = OUT_ROOT / "metrics_summary.json"


def _rows_to_md_table(rows):
    widths = [max(len(str(r[c])) for r in rows) for c in range(len(rows[0]))]
    lines = []
    for i, row in enumerate(rows):
        lines.append("| " + " | ".join(str(cell).ljust(widths[j]) for j, cell in enumerate(row)) + " |")
        if i == 0:
            lines.append("| " + " | ".join("-" * widths[j] for j in range(len(row))) + " |")
    return "\n".join(lines)


def _safe_acc(correct: int, total: int) -> float:
    return (100.0 * correct / total) if total else 0.0


def main() -> None:
    if not INDEX_PATH.exists():
        raise FileNotFoundError(f"Missing index: {INDEX_PATH}")
    if not LATEST_PATH.exists():
        raise FileNotFoundError(f"Missing manual score file: {LATEST_PATH}")

    records = json.loads(INDEX_PATH.read_text(encoding="utf-8"))
    latest = json.loads(LATEST_PATH.read_text(encoding="utf-8"))

    rows_by_mag = defaultdict(list)
    for rec in records:
        score = latest.get(rec["key"])
        if score is None:
            continue
        row = {
            "case": rec["case_name"],
            "variant": rec["variant"],
            "magnitude": rec["magnitude"],
            "value": int(score["value"]),
        }
        rows_by_mag[rec["magnitude"]].append(row)

    metrics = {
        "magnitudes": {},
        "overall": {},
        "scored_count": len(latest),
        "indexed_count": len(records),
    }

    for mag in sorted(rows_by_mag.keys()):
        case_bucket = defaultdict(lambda: {
            "nr_correct": 0,
            "nr_total": 0,
            "r_correct": 0,
            "r_total": 0,
            "all_correct": 0,
            "all_total": 0,
        })

        for row in rows_by_mag[mag]:
            c = case_bucket[row["case"]]
            if row["variant"] == "nr":
                c["nr_total"] += 1
                c["nr_correct"] += row["value"]
            else:
                c["r_total"] += 1
                c["r_correct"] += row["value"]
            c["all_total"] += 1
            c["all_correct"] += row["value"]

        report_rows = [[
            "Case",
            "NR",
            "NR Acc",
            "R",
            "R Acc",
            "Combined",
            "Combined Acc",
        ]]

        nr_correct_sum = nr_total_sum = 0
        r_correct_sum = r_total_sum = 0
        all_correct_sum = all_total_sum = 0

        for case in sorted(case_bucket.keys()):
            c = case_bucket[case]
            nr_correct_sum += c["nr_correct"]
            nr_total_sum += c["nr_total"]
            r_correct_sum += c["r_correct"]
            r_total_sum += c["r_total"]
            all_correct_sum += c["all_correct"]
            all_total_sum += c["all_total"]

            report_rows.append([
                case,
                f"{c['nr_correct']}/{c['nr_total']}",
                f"{_safe_acc(c['nr_correct'], c['nr_total']):.1f}%",
                f"{c['r_correct']}/{c['r_total']}",
                f"{_safe_acc(c['r_correct'], c['r_total']):.1f}%",
                f"{c['all_correct']}/{c['all_total']}",
                f"{_safe_acc(c['all_correct'], c['all_total']):.1f}%",
            ])

        mag_stats = {
            "nr": {"correct": nr_correct_sum, "total": nr_total_sum, "accuracy": _safe_acc(nr_correct_sum, nr_total_sum)},
            "r": {"correct": r_correct_sum, "total": r_total_sum, "accuracy": _safe_acc(r_correct_sum, r_total_sum)},
            "combined": {
                "correct": all_correct_sum,
                "total": all_total_sum,
                "accuracy": _safe_acc(all_correct_sum, all_total_sum),
            },
            "cases": len(case_bucket),
        }
        metrics["magnitudes"][mag] = mag_stats

        out_dir = OUT_ROOT / mag
        out_dir.mkdir(parents=True, exist_ok=True)
        table = _rows_to_md_table(report_rows)
        md = f"""# Manual Accuracy Report - {mag}

> NR and R are reported separately, plus combined statistics.
> Correct = 1, Wrong = 0 from manual scoring UI.

{table}

**Magnitude Summary**
- NR Accuracy: {mag_stats['nr']['accuracy']:.1f}% ({mag_stats['nr']['correct']}/{mag_stats['nr']['total']})
- R Accuracy: {mag_stats['r']['accuracy']:.1f}% ({mag_stats['r']['correct']}/{mag_stats['r']['total']})
- Combined Accuracy: {mag_stats['combined']['accuracy']:.1f}% ({mag_stats['combined']['correct']}/{mag_stats['combined']['total']})
"""
        (out_dir / "accuracy_report.md").write_text(md, encoding="utf-8")

    # Cross magnitude summary
    cross_rows = [["Magnitude", "Cases", "NR Accuracy", "R Accuracy", "Combined Accuracy"]]

    all_nr_correct = all_nr_total = 0
    all_r_correct = all_r_total = 0
    all_c_correct = all_c_total = 0

    for mag in sorted(metrics["magnitudes"].keys()):
        m = metrics["magnitudes"][mag]
        cross_rows.append([
            mag,
            str(m["cases"]),
            f"{m['nr']['accuracy']:.1f}%",
            f"{m['r']['accuracy']:.1f}%",
            f"{m['combined']['accuracy']:.1f}%",
        ])
        all_nr_correct += m["nr"]["correct"]
        all_nr_total += m["nr"]["total"]
        all_r_correct += m["r"]["correct"]
        all_r_total += m["r"]["total"]
        all_c_correct += m["combined"]["correct"]
        all_c_total += m["combined"]["total"]

    metrics["overall"] = {
        "nr": {"correct": all_nr_correct, "total": all_nr_total, "accuracy": _safe_acc(all_nr_correct, all_nr_total)},
        "r": {"correct": all_r_correct, "total": all_r_total, "accuracy": _safe_acc(all_r_correct, all_r_total)},
        "combined": {"correct": all_c_correct, "total": all_c_total, "accuracy": _safe_acc(all_c_correct, all_c_total)},
    }

    cross_table = _rows_to_md_table(cross_rows)
    cross_md = f"""# Cross-Magnitude Manual Accuracy Comparison - Pure LLM Baseline

> Manual review results grouped by magnitude.

{cross_table}

**Overall Summary**
- NR Accuracy: {metrics['overall']['nr']['accuracy']:.1f}% ({metrics['overall']['nr']['correct']}/{metrics['overall']['nr']['total']})
- R Accuracy: {metrics['overall']['r']['accuracy']:.1f}% ({metrics['overall']['r']['correct']}/{metrics['overall']['r']['total']})
- Combined Accuracy: {metrics['overall']['combined']['accuracy']:.1f}% ({metrics['overall']['combined']['correct']}/{metrics['overall']['combined']['total']})
- Scored / Indexed: {metrics['scored_count']} / {metrics['indexed_count']}
"""
    (OUT_ROOT / "cross_magnitude_comparison.md").write_text(cross_md, encoding="utf-8")
    METRICS_PATH.write_text(json.dumps(metrics, indent=2, ensure_ascii=False), encoding="utf-8")

    print(f"Saved: {(OUT_ROOT / 'cross_magnitude_comparison.md')}")
    print(f"Saved: {METRICS_PATH}")


if __name__ == "__main__":
    main()
