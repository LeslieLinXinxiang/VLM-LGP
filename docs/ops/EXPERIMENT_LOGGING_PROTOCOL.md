# Experiment Logging Protocol

## 1. Purpose

This document defines the canonical run-level log schema for FMB/Cube comparative experiments.
The schema is designed for:
- reproducibility
- traceability
- no-rerun data reuse

## 2. File Formats

Primary store:
- `jsonl`: one run record per line

Secondary store:
- `csv`: flattened summary table for spreadsheet/statistics tooling

## 3. Canonical Fields

Required fields:
- `run_id`: unique run identifier
- `timestamp`: UTC ISO timestamp
- `benchmark`: `cube` or `fmb`
- `task_size_n`: integer
- `redundancy_ratio`: `1x` or `2x`
- `scenario_id`: scenario name/id
- `repeat_id`: integer repeat index
- `random_seed`: integer
- `method_id`: method key
- `input_scene_g_path`: source scene path
- `input_task_graph_path`: source task graph path
- `prompt_version`: prompt identifier
- `code_version`: git commit hash or tag
- `status`: `completed` or `failed`
- `failure_code`: taxonomy code or empty string
- `failure_message`: short detail
- `solve_success`: `0` or `1`
- `task_success`: `0` or `1`
- `solver_time_sec`: float
- `total_time_sec`: float
- `predicate_count`: integer
- `artifact_dir`: artifact directory path
- `case_hash`: deterministic hash for reuse

Optional fields:
- `api_model`: model name if LLM/VLM is used
- `timeout_sec`: timeout threshold
- `command`: resolved command
- `notes`: free-form note
- `input_image_path`: frozen target image path for this scenario
- `input_bundle_id`: bundle id that binds image/scene/task graph (for example `cube_set_v1`)
- `input_freeze_version`: input freeze version tag (for example `input_bundle_v1`)

## 4. Failure Code Rules

Allowed values:
- `""` (empty, only if run is successful)
- `format_error`
- `syntax_error`
- `unsat`
- `timeout`
- `execution_fail`
- `infra_error`

Consistency rules:
- If `status=completed`, `failure_code` must be empty.
- If `failure_code` is non-empty, both `solve_success` and `task_success` must be `0`.

## 5. Error Analysis Policy

Lightweight mandatory attribution (minimum):
- format/syntax category
- unsat category
- timeout category
- execution failure category
- infrastructure category

This is sufficient for fair comparison and later extension without requiring deep forensic reruns.

## 6. Recommended Record Retention

Keep all run artifacts for accepted paper figures/tables.
At minimum, keep:
- run-level records
- command snapshot
- solver stdout/stderr
- generated symbolic files used for solving
- frozen input mapping table (`scenario_id -> image/scene/task_graph`)

## 7. Validation

Use validator:
- `python3 experiments/scripts/validate_experiment_logs.py --logs experiments/outputs/tables/run_records.jsonl`

Any invalid record should be fixed before aggregation and plotting.
