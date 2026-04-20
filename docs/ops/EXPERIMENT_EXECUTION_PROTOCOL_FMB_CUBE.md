# Experiment Execution Protocol (FMB + Cube)

## 1. Purpose

This SOP defines a reproducible execution protocol for comparative experiments on two benchmarks:
- FMB
- Cube Stacking

The protocol is designed to support method comparison without rerunning completed cases when experiment matrix changes.

## 2. Scope

In scope:
- Success-rate track and solve-time track
- Baselines and proposed method comparison
- Manifest-driven batch execution
- Structured logging and result aggregation

Out of scope:
- Sensor/perception error evaluation (per current project assumption)
- Real robot hardware safety operation details

## 3. Global Assumptions

- All methods receive equivalent scene/task input artifacts.
- Perception correctness is treated as given in this experiment phase.
- Syntax/format hallucination from LLM/VLM is counted as experiment failure.

## 3.1 Input Freeze Gate (First Priority)

Before running any comparative matrix, input assets must be frozen.

Mandatory freeze checklist:
- Freeze target images per scenario id.
- Freeze scene files (`.g`) per scenario id.
- Freeze expected task graph reference per scenario id.
- Freeze one-to-one mapping: `scenario_id -> image + scene + task_graph`.
- Record one bundle version string (for example `input_bundle_v1`) in logs.

No large-scale run is allowed before this gate is complete.

## 4. Experiment Matrix

Dimensions:
- Benchmark: `cube`, `fmb`
- Target size: `n in {4,5,6,7,8}`
- Redundancy ratio: `1x`, `2x`
- Scenario variants per `(benchmark, n, redundancy)`: 5
- Repeats per scenario: configurable `K`

Suggested total case count:
- `2 * 5 * 2 * 5 * K`

## 5. Method Groups

Success track:
- `pure_llm`
- `proposed`

Solve-time track:
- `lgp_monolithic`
- `lgp_split_manual`
- `lgp_split_manual_smart_collision`
- `proposed_auto`

## 6. Runtime Environment Rule

Always run with project runtime shell:
1. `source /home/leslie/anaconda3/etc/profile.d/conda.sh && conda activate vlm_jazzy`
2. `source scripts/env.sh`
3. Run any experiment script

## 7. Manifest-Driven Execution

Each experiment case is one JSON object line in manifest (`.jsonl`).
Minimum required fields are defined in:
- `experiments/configs/manifest_schema.md`

Recommended for frozen-input traceability:
- include `input_image_path`
- include `input_bundle_id`
- include `input_freeze_version`

Runner entry:
- `python3 experiments/scripts/run_experiment_batch.py --manifest <path> --methods experiments/configs/methods.yaml --output-root experiments/outputs`

## 8. Artifact Layout

Per run:
- `experiments/outputs/runs/<run_id>/input_case.json`
- `experiments/outputs/runs/<run_id>/resolved_command.txt`
- `experiments/outputs/runs/<run_id>/stdout.log`
- `experiments/outputs/runs/<run_id>/stderr.log`
- Optional generated intermediate files from method pipeline

Global:
- `experiments/outputs/tables/run_records.jsonl`
- `experiments/outputs/tables/run_records.csv`
- `experiments/outputs/tables/aggregate_summary.json`
- `experiments/outputs/tables/aggregate_summary.csv`

## 9. Reuse and No-Rerun Policy

The runner computes `case_hash` from canonical fields.
If a completed record with same `case_hash` exists:
- Default behavior: reuse old result and skip execution
- Override behavior: `--force-rerun`

This policy allows matrix expansion without replaying all historical runs.

## 10. Failure Taxonomy

Allowed failure codes:
- `format_error`
- `syntax_error`
- `unsat`
- `timeout`
- `execution_fail`
- `infra_error`

Rule:
- Any non-empty failure code implies `task_success=0`

## 11. Aggregation Procedure

Aggregate command:
- `python3 experiments/scripts/aggregate_experiment_results.py --logs experiments/outputs/tables/run_records.jsonl --out-dir experiments/outputs/tables`

Minimum report outputs:
- success rate
- solve success rate
- timeout rate
- solve-time median and p90 on successful solve subset

## 12. Change Governance

If experiment dimensions, success criteria, or failure taxonomy change:
1. Update this SOP and logging protocol first.
2. Update manifest schema and scripts.
3. Record change reason in commit message and experiment note.
