# Experiments Workspace

This folder contains reproducible experiment assets for FMB and Cube Stacking comparisons.

## Structure

- `configs/`: manifest schema/templates and method config
- `scripts/`: batch run, log validation, aggregation
- `templates/`: log schema and reusable examples
- `outputs/`: generated artifacts and tables

## Quick Start

1. Prepare runtime:
```bash
source /home/leslie/anaconda3/etc/profile.d/conda.sh && conda activate vlm_jazzy
source scripts/env.sh
```

2. Prepare manifest (`.jsonl`) and methods config (`.yaml`).

3. Run batch:
```bash
python3 experiments/scripts/run_experiment_batch.py \
  --manifest experiments/configs/manifest_cube_template.jsonl \
  --methods experiments/configs/methods.yaml \
  --output-root experiments/outputs
```

4. Validate logs:
```bash
python3 experiments/scripts/validate_experiment_logs.py \
  --logs experiments/outputs/tables/run_records.jsonl
```

5. Aggregate:
```bash
python3 experiments/scripts/aggregate_experiment_results.py \
  --logs experiments/outputs/tables/run_records.jsonl \
  --out-dir experiments/outputs/tables
```
