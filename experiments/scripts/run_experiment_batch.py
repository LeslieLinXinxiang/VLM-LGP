#!/usr/bin/env python3
import argparse
import csv
import datetime as dt
import hashlib
import json
import shlex
import subprocess
import sys
import uuid
from pathlib import Path
from typing import Any


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Run experiment cases from JSONL manifest.")
    parser.add_argument("--manifest", required=True, help="Path to manifest jsonl.")
    parser.add_argument("--methods", required=True, help="Path to methods yaml-like config.")
    parser.add_argument("--output-root", required=True, help="Output root directory.")
    parser.add_argument("--force-rerun", action="store_true", help="Ignore cache and rerun all cases.")
    parser.add_argument("--default-timeout", type=int, default=300, help="Fallback timeout seconds.")
    return parser.parse_args()


def utc_now_iso() -> str:
    return dt.datetime.now(dt.timezone.utc).isoformat()


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
                raise ValueError(f"Invalid JSON in {path}:{idx}: {exc}") from exc
    return rows


def load_methods(path: Path) -> dict[str, dict[str, Any]]:
    # Minimal YAML subset parser to avoid adding PyYAML dependency.
    methods: dict[str, dict[str, Any]] = {}
    current: str | None = None
    with path.open("r", encoding="utf-8") as file:
        for raw in file:
            line = raw.rstrip("\n")
            stripped = line.strip()
            if not stripped or stripped.startswith("#"):
                continue
            if not line.startswith(" ") and stripped.endswith(":"):
                current = stripped[:-1]
                methods[current] = {}
                continue
            if current is None:
                continue
            if ":" not in stripped:
                continue
            key, value = stripped.split(":", 1)
            key = key.strip()
            value = value.strip()
            if value.startswith(">-"):
                methods[current][key] = ""
                continue
            if key == "command_template" and value == "":
                methods[current][key] = ""
                continue
            if key == "timeout_sec":
                methods[current][key] = int(value)
            else:
                methods[current][key] = value

    # Second pass to collect multiline command templates.
    current = None
    collect_command = False
    with path.open("r", encoding="utf-8") as file:
        for raw in file:
            line = raw.rstrip("\n")
            stripped = line.strip()
            if not stripped or stripped.startswith("#"):
                continue
            if not line.startswith(" ") and stripped.endswith(":"):
                current = stripped[:-1]
                collect_command = False
                continue
            if current is None:
                continue
            if stripped.startswith("command_template:"):
                if stripped.endswith(">-"):
                    methods[current]["command_template"] = ""
                    collect_command = True
                    continue
            if collect_command:
                if line.startswith("    "):
                    methods[current]["command_template"] += line.strip() + " "
                    continue
                collect_command = False

    for method in methods.values():
        if "command_template" in method:
            method["command_template"] = method["command_template"].strip()
    return methods


def canonical_case(case: dict[str, Any]) -> dict[str, Any]:
    return {
        "benchmark": case.get("benchmark"),
        "task_size_n": case.get("task_size_n"),
        "redundancy_ratio": case.get("redundancy_ratio"),
        "scenario_id": case.get("scenario_id"),
        "repeat_id": case.get("repeat_id"),
        "random_seed": case.get("random_seed"),
        "method_id": case.get("method_id"),
        "input_scene_g_path": case.get("input_scene_g_path"),
        "input_task_graph_path": case.get("input_task_graph_path"),
        "prompt_version": case.get("prompt_version"),
        "predicate_count": case.get("predicate_count", 0),
        "timeout_sec": case.get("timeout_sec"),
        "overrides": case.get("overrides", {}),
    }


def compute_case_hash(case: dict[str, Any]) -> str:
    payload = json.dumps(canonical_case(case), sort_keys=True, ensure_ascii=True)
    return hashlib.sha256(payload.encode("utf-8")).hexdigest()


def build_context(case: dict[str, Any]) -> dict[str, Any]:
    ctx = dict(case)
    overrides = case.get("overrides") or {}
    if isinstance(overrides, dict):
        ctx.update(overrides)
    return ctx


def resolve_command(
    case: dict[str, Any],
    methods: dict[str, dict[str, Any]],
    default_timeout: int,
) -> tuple[str, int]:
    method_id = case.get("method_id")
    if method_id not in methods:
        raise ValueError(f"Unknown method_id: {method_id}")

    method = methods[method_id]
    command_template = method.get("command_template")
    if not command_template:
        raise ValueError(f"Method {method_id} missing command_template")

    ctx = build_context(case)
    try:
        command = command_template.format(**ctx)
    except KeyError as exc:
        raise ValueError(f"Missing placeholder field for command template: {exc}") from exc

    timeout = int(case.get("timeout_sec") or method.get("timeout_sec") or default_timeout)
    return command, timeout


def load_existing_records(path: Path) -> list[dict[str, Any]]:
    if not path.exists():
        return []
    return read_jsonl(path)


def find_cached_record(records: list[dict[str, Any]], case_hash: str) -> dict[str, Any] | None:
    for record in reversed(records):
        if record.get("case_hash") == case_hash and record.get("status") in {"completed", "failed"}:
            return record
    return None


def ensure_dirs(output_root: Path) -> tuple[Path, Path]:
    runs_dir = output_root / "runs"
    tables_dir = output_root / "tables"
    runs_dir.mkdir(parents=True, exist_ok=True)
    tables_dir.mkdir(parents=True, exist_ok=True)
    return runs_dir, tables_dir


def get_git_code_version(repo_root: Path) -> str:
    try:
        result = subprocess.run(
            ["git", "rev-parse", "HEAD"],
            cwd=repo_root,
            check=True,
            capture_output=True,
            text=True,
        )
        return result.stdout.strip()
    except Exception:
        return "unknown"


def append_jsonl(path: Path, row: dict[str, Any]) -> None:
    with path.open("a", encoding="utf-8") as file:
        file.write(json.dumps(row, ensure_ascii=False) + "\n")


def dump_csv(path: Path, rows: list[dict[str, Any]]) -> None:
    if not rows:
        return
    keys = sorted({k for row in rows for k in row.keys()})
    with path.open("w", encoding="utf-8", newline="") as file:
        writer = csv.DictWriter(file, fieldnames=keys)
        writer.writeheader()
        for row in rows:
            writer.writerow(row)


def classify_failure(return_code: int, timed_out: bool, stdout_text: str, stderr_text: str) -> tuple[str, str]:
    if timed_out:
        return "timeout", "Process exceeded timeout"
    if return_code == 0:
        return "", ""

    combined = f"{stdout_text}\n{stderr_text}".lower()

    if "format_error" in combined or "final_json" in combined or "invalid format" in combined:
        return "format_error", f"Process exited with code {return_code}"
    if "syntax_error" in combined or "jsondecodeerror" in combined or "invalid json" in combined:
        return "syntax_error", f"Process exited with code {return_code}"
    if "unsat" in combined or "infeasible" in combined or "no solution" in combined:
        return "unsat", f"Process exited with code {return_code}"
    if "connection" in combined or "network" in combined or "429" in combined or "api" in combined:
        return "infra_error", f"Process exited with code {return_code}"

    return "execution_fail", f"Process exited with code {return_code}"


def execute_case(
    case: dict[str, Any],
    methods: dict[str, dict[str, Any]],
    runs_dir: Path,
    code_version: str,
    default_timeout: int,
) -> dict[str, Any]:
    run_id = f"{dt.datetime.now().strftime('%Y%m%d_%H%M%S')}_{uuid.uuid4().hex[:8]}"
    artifact_dir = runs_dir / run_id
    artifact_dir.mkdir(parents=True, exist_ok=True)

    command, timeout = resolve_command(case, methods, default_timeout)

    (artifact_dir / "input_case.json").write_text(
        json.dumps(case, indent=2, ensure_ascii=False),
        encoding="utf-8",
    )
    (artifact_dir / "resolved_command.txt").write_text(command + "\n", encoding="utf-8")

    start = dt.datetime.now(dt.timezone.utc)
    timed_out = False
    return_code = -1
    stdout_text = ""
    stderr_text = ""

    try:
        completed = subprocess.run(
            shlex.split(command),
            capture_output=True,
            text=True,
            timeout=timeout,
            cwd=Path(__file__).resolve().parents[2],
        )
        return_code = completed.returncode
        stdout_text = completed.stdout or ""
        stderr_text = completed.stderr or ""
    except subprocess.TimeoutExpired as exc:
        timed_out = True
        stdout_text = exc.stdout or ""
        stderr_text = exc.stderr or ""
        return_code = 124

    end = dt.datetime.now(dt.timezone.utc)
    elapsed = (end - start).total_seconds()

    (artifact_dir / "stdout.log").write_text(stdout_text, encoding="utf-8")
    (artifact_dir / "stderr.log").write_text(stderr_text, encoding="utf-8")

    failure_code, failure_message = classify_failure(return_code, timed_out, stdout_text, stderr_text)
    solve_success = 1 if failure_code == "" else 0
    task_success = 1 if failure_code == "" else 0
    status = "completed" if failure_code == "" else "failed"

    record = {
        "run_id": run_id,
        "timestamp": utc_now_iso(),
        "benchmark": case.get("benchmark"),
        "task_size_n": int(case.get("task_size_n")),
        "redundancy_ratio": case.get("redundancy_ratio"),
        "scenario_id": case.get("scenario_id"),
        "repeat_id": int(case.get("repeat_id")),
        "random_seed": int(case.get("random_seed")),
        "method_id": case.get("method_id"),
        "input_scene_g_path": case.get("input_scene_g_path"),
        "input_task_graph_path": case.get("input_task_graph_path"),
        "prompt_version": case.get("prompt_version"),
        "code_version": code_version,
        "status": status,
        "failure_code": failure_code,
        "failure_message": failure_message,
        "solve_success": solve_success,
        "task_success": task_success,
        "solver_time_sec": float(elapsed),
        "total_time_sec": float(elapsed),
        "predicate_count": int(case.get("predicate_count", 0)),
        "artifact_dir": str(artifact_dir),
        "case_hash": compute_case_hash(case),
        "timeout_sec": timeout,
        "command": command,
        "notes": case.get("notes", ""),
    }
    return record


def main() -> int:
    args = parse_args()

    manifest_path = Path(args.manifest).resolve()
    methods_path = Path(args.methods).resolve()
    output_root = Path(args.output_root).resolve()

    cases = read_jsonl(manifest_path)
    methods = load_methods(methods_path)

    runs_dir, tables_dir = ensure_dirs(output_root)
    records_path = tables_dir / "run_records.jsonl"
    csv_path = tables_dir / "run_records.csv"

    existing_records = load_existing_records(records_path)
    all_records = list(existing_records)

    repo_root = Path(__file__).resolve().parents[2]
    code_version = get_git_code_version(repo_root)

    executed = 0
    reused = 0

    for case in cases:
        case_hash = compute_case_hash(case)
        cached = find_cached_record(existing_records, case_hash)
        if cached and not args.force_rerun:
            reused += 1
            continue

        record = execute_case(case, methods, runs_dir, code_version, args.default_timeout)
        append_jsonl(records_path, record)
        all_records.append(record)
        executed += 1

    dump_csv(csv_path, all_records)

    summary = {
        "manifest": str(manifest_path),
        "methods": str(methods_path),
        "output_root": str(output_root),
        "executed_cases": executed,
        "reused_cases": reused,
        "total_records": len(all_records),
    }
    print(json.dumps(summary, indent=2, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    sys.exit(main())
