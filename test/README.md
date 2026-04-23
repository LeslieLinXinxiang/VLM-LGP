# Test Directory Layout

This folder is the **single entry point** for project-owned tests.

## Policy (important)

- Test and verification scripts must live under `test/**`.
- `scripts/**` is reserved for runtime/ops utilities, not test harnesses.
- Module verification and integration verification are separated, then merged by ordered calls.

## Subfolders

- `graph_clustering/`: graph-clustering module tests and tooling
  - `test_kmeans_clustering.py`: deterministic + dependency-safe module test
  - `tools/run_provenance_pruning_codegen.py`: provenance scheduling harness (produces solver-facing artifacts)
  - `tools/visualize_phase1_kmeans.py`: k-means visualization/export tool
  - `tools/visualize_phase1_provenance_clustering.py`: provenance clustering visualization/export tool
- `pipeline/`: Phase0/1/2 Python pipeline interface tests
- `integration/`: end-to-end runner scripts (solver + bridge + execution loops)
- `scenes/`: canonical and variant `.g` scene files used by tests
- `viewers/`: manual visualization scripts

## Call Flow (module -> integration)

1) **Run module tests first** (no integration assumptions)
2) **Run module test harness tools** for artifact validation
3) **Run pipeline/integration tests** after module status is green

This enables "module-pass now, merge-and-joint-debug later" without losing call clarity.

## Command examples

- KMeans module test:
  - `python3 test/graph_clustering/test_kmeans_clustering.py`
- Provenance scheduling harness:
  - `python3 test/graph_clustering/tools/run_provenance_pruning_codegen.py --input generated/phase1_target_graph.json --out-dir generated/three_branch_policy_run --node-id 202`
- Provenance visualization:
  - `python3 test/graph_clustering/tools/visualize_phase1_provenance_clustering.py --input generated/phase1_target_graph.json`
- KMeans visualization:
  - `python3 test/graph_clustering/tools/visualize_phase1_kmeans.py --input generated/phase1_target_graph.json`

## Notes

- Upstream or third-party tests are intentionally not moved here:
  - `rai/test/**`
  - `python_lib/**/tests/**`
- Existing generated outputs under `generated/**` remain untouched.
