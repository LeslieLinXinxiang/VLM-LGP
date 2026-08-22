#!/usr/bin/env python3
"""Analyse manual scores for the VLM-MSGraph baseline (Track 1) and write reports.

Reporting rule, fixed in advance by the experiment design
(docs/ops/VLM_MSGRAPH_BASELINE_EXPERIMENT_DESIGN_2026-08-16.md §4 Track 1):
    "report Track 1 as pooled accuracy per benchmark per method (N=25 cube, N=15 FMB),
     *not* as per-configuration accuracy curves. At N=5 per config cell, per-tier trend
     claims would not be statistically supportable."

So the headline in every artefact here is the pooled per-benchmark number with a Wilson
95% interval. Per-magnitude tables are still emitted because they are useful for
spotting *individual* failures to go re-read, but each is stamped as descriptive-only
(N=5 per cell) and must not be quoted as a trend.

Two distinct numbers are reported side by side and never merged:
  - content accuracy: this manual review — does the sequence match the picture?
  - format compliance: validate_baseline_vlm_msgraph_format.py — is it well-formed?
    (GT-free schema check; a file can be perfectly formatted and still describe the
    wrong scene, and vice versa.)

Usage:
    python3 analyse_vlm_msgraph_manual_scores.py
"""
from __future__ import annotations

import json
import math
import re
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT_ROOT = ROOT / "experiments/outputs/VLM-MSGraph_baseline/accuracy_analysis"
INDEX_PATH = OUT_ROOT / "review_index.json"
LATEST_PATH = OUT_ROOT / "manual_review/latest_scores.json"
METRICS_PATH = OUT_ROOT / "metrics_summary.json"

BENCHMARK_ORDER = ["cubeStacking", "FMB"]

sys.path.insert(0, str(Path(__file__).resolve().parent))


def _magnitude_sort_key(mag: str) -> int:
    m = re.search(r"\d+", mag)
    return int(m.group()) if m else 0


def _rows_to_md_table(rows) -> str:
    widths = [max(len(str(r[c])) for r in rows) for c in range(len(rows[0]))]
    lines = []
    for i, row in enumerate(rows):
        lines.append("| " + " | ".join(str(c).ljust(widths[j]) for j, c in enumerate(row)) + " |")
        if i == 0:
            lines.append("| " + " | ".join("-" * widths[j] for j in range(len(row))) + " |")
    return "\n".join(lines)


def _acc(correct: int, total: int) -> float:
    return (100.0 * correct / total) if total else 0.0


def wilson_ci(correct: int, total: int, z: float = 1.96):
    """Wilson score interval in percent. Reported because N=25/15 is small enough that a
    bare point estimate invites over-reading."""
    if total == 0:
        return 0.0, 0.0
    p = correct / total
    denom = 1 + z * z / total
    centre = (p + z * z / (2 * total)) / denom
    half = z * math.sqrt(p * (1 - p) / total + z * z / (4 * total * total)) / denom
    return 100.0 * max(0.0, centre - half), 100.0 * min(1.0, centre + half)


def format_compliance(records) -> dict:
    """Re-run the schema validator over the same files so both numbers land in one
    report. Failures here are format/paste problems, not content judgements."""
    try:
        from validate_baseline_vlm_msgraph_format import validate_file
    except Exception as exc:
        return {"available": False, "error": str(exc)}

    per_bench = defaultdict(lambda: {"pass": 0, "total": 0, "failures": []})
    for rec in records:
        errs = [e for e in validate_file(Path(rec["md_path"])) if not e.startswith("[WARN]")]
        b = per_bench[rec["benchmark"]]
        b["total"] += 1
        if errs:
            b["failures"].append({"key": rec["key"], "errors": errs})
        else:
            b["pass"] += 1
    out = {"available": True, "per_benchmark": {}}
    tp = tt = 0
    for bench, v in per_bench.items():
        out["per_benchmark"][bench] = {
            "pass": v["pass"], "total": v["total"],
            "rate": _acc(v["pass"], v["total"]), "failures": v["failures"],
        }
        tp += v["pass"]
        tt += v["total"]
    out["overall"] = {"pass": tp, "total": tt, "rate": _acc(tp, tt)}
    return out


def main() -> None:
    if not INDEX_PATH.exists():
        raise FileNotFoundError(
            f"Missing {INDEX_PATH}\nRun: python3 experiments/scripts/build_vlm_msgraph_review_index.py"
        )
    if not LATEST_PATH.exists():
        raise FileNotFoundError(
            f"Missing {LATEST_PATH}\nRun: python3 experiments/scripts/review_vlm_msgraph_scores.py"
        )

    records = json.loads(INDEX_PATH.read_text(encoding="utf-8"))
    latest = json.loads(LATEST_PATH.read_text(encoding="utf-8"))

    by_key = {r["key"]: r for r in records}
    unscored = [r["key"] for r in records if r["key"] not in latest]

    metrics = {
        "protocol": {
            "track": "Track 1 (semantic/matching layer, non-redundant scenarios only)",
            "sampling": "8 configs x 5 scenarios x 1 seed = 40 trials",
            "reporting_rule": "pooled per benchmark; per-magnitude cells are descriptive only (N=5)",
            "design_doc": "docs/ops/VLM_MSGRAPH_BASELINE_EXPERIMENT_DESIGN_2026-08-16.md",
        },
        "indexed_count": len(records),
        "scored_count": sum(1 for r in records if r["key"] in latest),
        "unscored_keys": unscored,
        "benchmarks": {},
        "overall": {},
        "wrong_cases": [],
        "format_compliance": format_compliance(records),
    }

    grand_c = grand_t = 0

    for bench in BENCHMARK_ORDER:
        bench_recs = [r for r in records if r["benchmark"] == bench]
        if not bench_recs:
            continue

        per_mag = defaultdict(lambda: {"correct": 0, "total": 0, "cases": []})
        by_trial = defaultdict(lambda: {"correct": 0, "total": 0})
        b_c = b_t = 0
        for rec in bench_recs:
            score = latest.get(rec["key"])
            if score is None:
                continue
            v = int(score["value"])
            trial = rec["trial"]
            m = per_mag[rec["magnitude"]]
            m["total"] += 1
            m["correct"] += v
            # (case, trial, value, label) — keyed by case+trial, not bare case name:
            # once trial_02+ exist for the same case, a bare-case-name dict key would
            # silently collide and drop one trial's result (confirmed real bug, fixed
            # 2026-08-18 when trial_02 was added).
            m["cases"].append((rec["case_name"], trial, v, score.get("label", "")))
            by_trial[trial]["total"] += 1
            by_trial[trial]["correct"] += v
            b_t += 1
            b_c += v
            if v == 0:
                metrics["wrong_cases"].append(rec["key"])

        lo, hi = wilson_ci(b_c, b_t)
        bench_stats = {
            "pooled": {
                "correct": b_c, "total": b_t, "accuracy": _acc(b_c, b_t),
                "wilson95_low": lo, "wilson95_high": hi,
            },
            "by_trial": {
                str(t): {"correct": v["correct"], "total": v["total"], "accuracy": _acc(v["correct"], v["total"])}
                for t, v in sorted(by_trial.items())
            },
            "magnitudes": {},
        }

        trial_rows = [["Trial", "Correct/Total", "Accuracy"]]
        for t in sorted(by_trial):
            v = by_trial[t]
            trial_rows.append([f"trial_{t:02d}", f"{v['correct']}/{v['total']}", f"{_acc(v['correct'], v['total']):.1f}%"])

        mag_rows = [["Magnitude", "Correct/Total", "Accuracy"]]
        for mag in sorted(per_mag, key=_magnitude_sort_key):
            m = per_mag[mag]
            bench_stats["magnitudes"][mag] = {
                "correct": m["correct"], "total": m["total"],
                "accuracy": _acc(m["correct"], m["total"]),
                "cases": {f"{c}/trial_{t:02d}": v for c, t, v, _ in sorted(m["cases"])},
            }
            mag_rows.append([mag, f"{m['correct']}/{m['total']}", f"{_acc(m['correct'], m['total']):.1f}%"])

            case_rows = [["Case", "Trial", "Score", "How scored", "Result"]]
            for case, trial, v, label in sorted(m["cases"]):
                case_rows.append([case, f"{trial:02d}", str(v), label or "-", "✓ correct" if v else "✗ wrong"])
            mag_dir = OUT_ROOT / bench / mag
            mag_dir.mkdir(parents=True, exist_ok=True)
            (mag_dir / "accuracy_report.md").write_text(
                f"""# Manual Content Accuracy — {bench} / {mag}

> **Descriptive only.** N={m['total']} at this magnitude (may span multiple trials per
> case). Per the Track 1 reporting rule fixed before running, accuracy is reported
> *pooled per benchmark*; this per-magnitude cell is here to locate individual
> failures, not to support a per-tier trend claim.
>
> "How scored" of `auto_match_trial01` means this trial's ordered_triples was
> auto-verified identical to a trial_01 already confirmed correct — see
> `diff_vlm_msgraph_trial_vs_reference.py` — not independently re-reviewed by a human.

{_rows_to_md_table(case_rows)}

- Accuracy at this magnitude: **{_acc(m['correct'], m['total']):.1f}%** ({m['correct']}/{m['total']})
- Benchmark pooled accuracy (the number to quote): **{_acc(b_c, b_t):.1f}%** ({b_c}/{b_t})
""",
                encoding="utf-8",
            )

        fc = metrics["format_compliance"].get("per_benchmark", {}).get(bench, {})
        fc_line = (
            f"- Format compliance (separate, GT-free schema check): "
            f"**{fc.get('rate', 0.0):.1f}%** ({fc.get('pass', 0)}/{fc.get('total', 0)})"
            if fc else "- Format compliance: not computed"
        )
        (OUT_ROOT / bench).mkdir(parents=True, exist_ok=True)
        (OUT_ROOT / bench / "accuracy_report.md").write_text(
            f"""# Manual Content Accuracy — {bench} (pooled)

> Track 1, non-redundant scenarios only, per the sampling protocol fixed on
> 2026-08-17. **Pooled accuracy across all scored trials is the reportable number.**

## Headline

- Pooled content accuracy (all trials combined): **{_acc(b_c, b_t):.1f}%** ({b_c}/{b_t})
- Wilson 95% interval: **[{lo:.1f}%, {hi:.1f}%]**
{fc_line}

## By trial

{_rows_to_md_table(trial_rows)}

## Per-magnitude breakdown (descriptive only — N per cell scales with trials scored)

{_rows_to_md_table(mag_rows)}

Do not read the per-magnitude table as a degradation curve — at low N per cell a single
flip moves a cell by a large margin. If a per-tier trend claim is wanted, increase
seeds/trials first and record the change in the design doc.
""",
            encoding="utf-8",
        )

        metrics["benchmarks"][bench] = bench_stats
        grand_c += b_c
        grand_t += b_t

    g_lo, g_hi = wilson_ci(grand_c, grand_t)
    metrics["overall"] = {
        "correct": grand_c, "total": grand_t, "accuracy": _acc(grand_c, grand_t),
        "wilson95_low": g_lo, "wilson95_high": g_hi,
    }

    cross_rows = [["Benchmark", "Pooled Correct/Total", "Pooled Accuracy", "Wilson 95% CI", "Format Compliance"]]
    for bench in BENCHMARK_ORDER:
        if bench not in metrics["benchmarks"]:
            continue
        p = metrics["benchmarks"][bench]["pooled"]
        fc = metrics["format_compliance"].get("per_benchmark", {}).get(bench, {})
        cross_rows.append([
            bench,
            f"{p['correct']}/{p['total']}",
            f"{p['accuracy']:.1f}%",
            f"[{p['wilson95_low']:.1f}%, {p['wilson95_high']:.1f}%]",
            f"{fc.get('rate', 0.0):.1f}% ({fc.get('pass', 0)}/{fc.get('total', 0)})" if fc else "n/a",
        ])

    wrong_block = "\n".join(f"- `{k}`" for k in metrics["wrong_cases"]) or "- (none)"
    unscored_block = "\n".join(f"- `{k}`" for k in unscored) or "- (none — all trials scored)"
    fmt_fail_block = ""
    for bench, v in metrics["format_compliance"].get("per_benchmark", {}).items():
        for f in v.get("failures", []):
            fmt_fail_block += f"- `{f['key']}`\n" + "".join(f"    - {e}\n" for e in f["errors"])
    fmt_fail_block = fmt_fail_block or "- (none)\n"

    (OUT_ROOT / "cross_magnitude_comparison.md").write_text(
        f"""# VLM-MSGraph Baseline — Track 1 Manual Review Summary

> **Track 1 only**: semantic/matching-layer accuracy on non-redundant scenarios,
> matching the conditions the source paper validated under. Redundant scenarios are
> excluded by design (the baseline has no instance-disambiguation mechanism — see
> design doc §3). This is a supplementary number, not the paper's core claim.
>
> Sampling: 8 configs x 5 scenarios x 1 seed = 40 trials. Scored manually against the
> input image (Correct=1 / Wrong=0); no automated GT is used at this stage.

## Pooled accuracy per benchmark (the reportable numbers)

{_rows_to_md_table(cross_rows)}

**Overall across both benchmarks**: {metrics['overall']['accuracy']:.1f}% ({grand_c}/{grand_t}),
Wilson 95% [{g_lo:.1f}%, {g_hi:.1f}%]

Scored / indexed: {metrics['scored_count']} / {metrics['indexed_count']}

## Two numbers, kept separate

| Number | What it measures | Source |
| ------ | ---------------- | ------ |
| Content accuracy | Does the ordered sequence match the image? | this manual review |
| Format compliance | Is the output a well-formed instance of the schema? | `validate_baseline_vlm_msgraph_format.py` (no GT) |

A trial can pass format and fail content, or the reverse. Never merge them into one
"accuracy" figure.

## Trials scored WRONG (content)

{wrong_block}

## Trials failing format compliance

{fmt_fail_block}
## Unscored

{unscored_block}
""",
        encoding="utf-8",
    )

    METRICS_PATH.write_text(json.dumps(metrics, indent=2, ensure_ascii=False), encoding="utf-8")

    print(f"Saved: {OUT_ROOT / 'cross_magnitude_comparison.md'}")
    print(f"Saved: {METRICS_PATH}")
    for bench in BENCHMARK_ORDER:
        if bench in metrics["benchmarks"]:
            p = metrics["benchmarks"][bench]["pooled"]
            print(f"  {bench:14s} pooled {p['accuracy']:5.1f}%  ({p['correct']}/{p['total']})"
                  f"  95% CI [{p['wilson95_low']:.1f}, {p['wilson95_high']:.1f}]")
    print(f"  {'OVERALL':14s} pooled {metrics['overall']['accuracy']:5.1f}%  ({grand_c}/{grand_t})")
    if unscored:
        print(f"  ! {len(unscored)} trial(s) still unscored")


if __name__ == "__main__":
    main()
