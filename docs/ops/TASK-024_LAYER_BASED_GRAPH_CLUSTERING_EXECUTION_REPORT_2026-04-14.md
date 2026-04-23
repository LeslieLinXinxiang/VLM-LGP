# TASK-024 Execution Report: Layer-Based Graph Clustering Refinement

## 1) Request Restatement (Confirmed)

The next task is to refine graph clustering logic to a **layer-based** policy:

1. Objects in the same layer are treated as a jointly executable task set.
2. In higher layers, objects that originate from the same source node are grouped as one branch.
3. Objects that converge to the same destination can also indicate branch relation, but **shared source has higher priority**.
4. If two objects both satisfy “from source A” but go to different destinations (`B` and `C`), they still belong to the same branch due to source-priority.
5. For efficiency/stability, if a branch has more than 2 objects, split left-to-right in chunks of 2.
6. Execution order within the same branch is left-to-right.

## 2) First-Principles Interpretation

- **Layer principle**: dependency depth defines concurrency boundary.
- **Branch principle**: preserve assembly provenance first (source-priority), then destination affinity.
- **Execution principle**: deterministic order and bounded solve size improve solver stability.

## 3) Proposed Formal Rules (for implementation)

### 3.1 Layer construction

- Build DAG from support graph.
- Compute layer index by topological depth from base and supports.
- Same-layer nodes form one parallel candidate set.

### 3.2 Branch assignment

- Primary key: nearest shared source ancestor in prior layer(s).
- Secondary key: common destination convergence in later layer(s).
- Conflict resolution: source-priority overrides destination-based split.

### 3.3 Branch splitting and ordering

- For each branch, sort members by horizontal x-position (left-to-right).
- If branch size > 2, split as `[0:2], [2:4], ...`.
- Execute chunks in sequence; within each chunk execute left-to-right.

## 4) Acceptance Criteria

1. Same-layer objects are grouped as jointly executable set in generated plan metadata.
2. Branch labels are reproducible and satisfy source-priority in ambiguous cases.
3. Branches with >2 objects are chunked by pairs in left-to-right order.
4. Generated execution order is deterministic across repeated runs.
5. Existing non-ambiguous benchmarks maintain or improve solve stability and time.

## 5) Planned Code Touchpoints

- [core/graph_clustering.py](core/graph_clustering.py): layer extraction, branch assignment, split policy.
- [pipeline/run_phase2.py](pipeline/run_phase2.py): integrate new clustering outputs into solve scheduling.
- [docs/roadmap.md](docs/roadmap.md): status tracking.

## 6) Current Status

- TASK-023 has been closed.
- TASK-024 has been closed (2026-04-20 14:27).
- This report now serves as implementation-and-evidence index for roadmap archival.

## 7) Completion Evidence Path Mapping

Implementation:

- `core/graph_clustering.py` (class `BranchAwareLayerCuttingClustering`)
- `pipeline/run_phase2.py` (default integration path)

Test harness and regression tests:

- `test/layer_based_clustering/run_layer_based_codegen.py`
- `test/layer_based_clustering/test_batch_distribution.py`
- `test/layer_based_clustering/test_batch_level_codegen.py`
- `test/layer_based_clustering/test_mainline_reachability_manipulability_lgp.py`

Generated artifacts and reports:

- `generated/layer_based_policy_run/`
- `generated/layer_based_policy_run_batch/`
- `generated/layer_based_batch_distribution_test/`
- `generated/layer_based_mainline_manipulability_report.json`

Related docs:

- `docs/module_specs/graph_clustering_engine.md`
- `docs/roadmap.md`
