#!/usr/bin/env python3
import argparse
import csv
import json
import statistics
from pathlib import Path
from typing import Any


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Aggregate run records.")
    parser.add_argument("--logs", required=True, help="run_records.jsonl path")
    parser.add_argument("--out-dir", required=True, help="output directory")
    return parser.parse_args()


def read_jsonl(path: Path) -> list[dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    with path.open("r", encoding="utf-8") as file:
        for line in file:
            line = line.strip()
            if not line:
                continue
            rows.append(json.loads(line))
    return rows


def percentile(values: list[float], q: float) -> float:
    if not values:
        return 0.0
    values = sorted(values)
    if len(values) == 1:
        return values[0]
    pos = (len(values) - 1) * q
    low = int(pos)
    high = min(low + 1, len(values) - 1)
    frac = pos - low
    return values[low] * (1.0 - frac) + values[high] * frac


def group_key(row: dict[str, Any]) -> tuple[Any, ...]:
    return (
        row.get("benchmark"),
        row.get("task_size_n"),
        row.get("redundancy_ratio"),
        row.get("method_id"),
    )


def aggregate(rows: list[dict[str, Any]]) -> list[dict[str, Any]]:
    grouped: dict[tuple[Any, ...], list[dict[str, Any]]] = {}
    for row in rows:
        grouped.setdefault(group_key(row), []).append(row)

    out: list[dict[str, Any]] = []
    for key, items in grouped.items():
        benchmark, task_size_n, redundancy_ratio, method_id = key
        total = len(items)
        task_success_count = sum(int(i.get("task_success", 0)) for i in items)
        solve_success_count = sum(int(i.get("solve_success", 0)) for i in items)
        timeout_count = sum(1 for i in items if i.get("failure_code") == "timeout")

        solve_times = [float(i.get("solver_time_sec", 0.0)) for i in items if int(i.get("solve_success", 0)) == 1]

        result = {
            "benchmark": benchmark,
            "task_size_n": task_size_n,
            "redundancy_ratio": redundancy_ratio,
            "method_id": method_id,
            "num_runs": total,
            "task_success_rate": task_success_count / total if total else 0.0,
            "solve_success_rate": solve_success_count / total if total else 0.0,
            "timeout_rate": timeout_count / total if total else 0.0,
            "solver_time_median_sec": statistics.median(solve_times) if solve_times else 0.0,
            "solver_time_p90_sec": percentile(solve_times, 0.9) if solve_times else 0.0,
        }
        out.append(result)

    out.sort(key=lambda x: (x["benchmark"], x["task_size_n"], x["redundancy_ratio"], x["method_id"]))
    return out


def write_csv(path: Path, rows: list[dict[str, Any]]) -> None:
    if not rows:
        path.write_text("", encoding="utf-8")
        return
    fields = list(rows[0].keys())
    with path.open("w", encoding="utf-8", newline="") as file:
        writer = csv.DictWriter(file, fieldnames=fields)
        writer.writeheader()
        for row in rows:
            writer.writerow(row)


def main() -> int:
    args = parse_args()
    logs_path = Path(args.logs).resolve()
    out_dir = Path(args.out_dir).resolve()
    out_dir.mkdir(parents=True, exist_ok=True)

    rows = read_jsonl(logs_path)
    summary = aggregate(rows)

    summary_json = out_dir / "aggregate_summary.json"
    summary_csv = out_dir / "aggregate_summary.csv"

    summary_json.write_text(json.dumps(summary, indent=2, ensure_ascii=False), encoding="utf-8")
    write_csv(summary_csv, summary)

    print(json.dumps({
        "input_records": len(rows),
        "output_groups": len(summary),
        "aggregate_json": str(summary_json),
        "aggregate_csv": str(summary_csv),
    }, indent=2, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
