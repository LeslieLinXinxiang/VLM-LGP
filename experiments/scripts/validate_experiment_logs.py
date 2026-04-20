#!/usr/bin/env python3
import argparse
import json
from pathlib import Path
from typing import Any


ALLOWED_FAILURE = {
    "",
    "format_error",
    "syntax_error",
    "unsat",
    "timeout",
    "execution_fail",
    "infra_error",
}

REQUIRED_FIELDS = {
    "run_id",
    "timestamp",
    "benchmark",
    "task_size_n",
    "redundancy_ratio",
    "scenario_id",
    "repeat_id",
    "random_seed",
    "method_id",
    "input_scene_g_path",
    "input_task_graph_path",
    "prompt_version",
    "code_version",
    "status",
    "failure_code",
    "failure_message",
    "solve_success",
    "task_success",
    "solver_time_sec",
    "total_time_sec",
    "predicate_count",
    "artifact_dir",
    "case_hash",
}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Validate experiment run_records jsonl")
    parser.add_argument("--logs", required=True, help="Path to run_records.jsonl")
    return parser.parse_args()


def read_jsonl(path: Path) -> list[dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    with path.open("r", encoding="utf-8") as file:
        for idx, line in enumerate(file, start=1):
            line = line.strip()
            if not line:
                continue
            try:
                rows.append(json.loads(line))
            except json.JSONDecodeError as exc:
                raise ValueError(f"Invalid JSON at line {idx}: {exc}") from exc
    return rows


def validate_row(row: dict[str, Any], index: int) -> list[str]:
    errors: list[str] = []

    missing = REQUIRED_FIELDS - set(row.keys())
    if missing:
        errors.append(f"row {index}: missing fields {sorted(missing)}")

    failure_code = row.get("failure_code", "")
    if failure_code not in ALLOWED_FAILURE:
        errors.append(f"row {index}: invalid failure_code={failure_code}")

    status = row.get("status")
    if status not in {"completed", "failed"}:
        errors.append(f"row {index}: invalid status={status}")

    solve_success = int(row.get("solve_success", 0))
    task_success = int(row.get("task_success", 0))

    if failure_code != "" and (solve_success != 0 or task_success != 0):
        errors.append(f"row {index}: failed run must have solve_success=0 and task_success=0")

    if status == "completed" and failure_code != "":
        errors.append(f"row {index}: completed run cannot carry failure_code")

    if row.get("benchmark") not in {"cube", "fmb"}:
        errors.append(f"row {index}: benchmark must be cube/fmb")

    if row.get("redundancy_ratio") not in {"1x", "2x"}:
        errors.append(f"row {index}: redundancy_ratio must be 1x/2x")

    return errors


def main() -> int:
    args = parse_args()
    path = Path(args.logs).resolve()
    rows = read_jsonl(path)

    errors: list[str] = []
    for idx, row in enumerate(rows, start=1):
        errors.extend(validate_row(row, idx))

    if errors:
        print("[VALIDATION] FAILED")
        for err in errors:
            print(f"- {err}")
        return 1

    print(f"[VALIDATION] OK | rows={len(rows)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
