# Testing and Merge Call Guide

## 1) Goal

This guide defines a stable call contract for testing and later integration merge:

- keep all project-owned test harnesses under `test/**`
- verify module behavior first
- run integration only after module checks pass

This prevents scattered entry points and makes merge-time invocation deterministic.

## 2) Directory Contract

- **Runtime/Ops scripts**: `scripts/**`
- **Test harness and verification tools**: `test/**`

For graph clustering, all test-facing tools are now under:

- `test/graph_clustering/test_kmeans_clustering.py`
- `test/graph_clustering/tools/run_provenance_pruning_codegen.py`
- `test/graph_clustering/tools/visualize_phase1_kmeans.py`
- `test/graph_clustering/tools/visualize_phase1_provenance_clustering.py`

## 3) Call Sequence (must follow)

### Stage A — Module verification

1. Run deterministic/contract tests:
   - `python3 test/graph_clustering/test_kmeans_clustering.py`
2. Run provenance policy harness for solver-facing artifacts:
   - `python3 test/graph_clustering/tools/run_provenance_pruning_codegen.py --input generated/phase1_target_graph.json --out-dir generated/three_branch_policy_run --node-id 202`

### Stage B — Module artifact review

1. Provenance visualization:
   - `python3 test/graph_clustering/tools/visualize_phase1_provenance_clustering.py --input generated/phase1_target_graph.json`
2. KMeans visualization:
   - `python3 test/graph_clustering/tools/visualize_phase1_kmeans.py --input generated/phase1_target_graph.json`

### Stage C — Integration merge verification

After Stage A/B are green, run pipeline/integration suites under:

- `test/pipeline/**`
- `test/integration/**`

## 4) Outputs and What They Mean

`run_provenance_pruning_codegen.py` produces:

- `execution_plan.json`: order + batches + cluster structure
- `phase2_strategy_policy.json`: Prompt1/Prompt2-compatible strategy payload
- `policy_trace.json`: per-step policy decision trace
- `step_*.fol` / `step_*.lgp`: solver-facing executable files

These artifacts are the merge-time contract for Phase2 scheduling behavior.

## 5) Merge Checklist

Before merging graph-clustering changes:

1. Stage A passes with no dependency-order violation.
2. Stage B artifacts are generated and inspectable.
3. Stage C pipeline/integration tests pass.
4. New/changed harnesses remain under `test/**`.
