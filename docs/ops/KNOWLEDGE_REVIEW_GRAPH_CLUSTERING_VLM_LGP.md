# Knowledge Review: Graph Clustering in VLM-LGP (Theory -> Policy -> Executable Plan)

## 0) Why this note exists

This note is for **知识回顾** of our graph-clustering line in VLM-LGP:

- graph abstraction,
- clustering variants,
- provenance scheduling policy,
- solver-facing artifact generation.

---

## 1) Core principle (independent of project)

Given a support DAG $G=(V,E)$, edge $u\to v$ means $u$ must be built before $v$.

Graph clustering here means:

1. structural grouping of nodes,
2. then dependency-safe scheduling into executable batches.

Why split into 2 stages:

- better interpretability,
- better debugging (`cluster quality` vs `execution policy`),
- easier to keep solver constraints explicit.

---

## 2) Algorithms implemented in this repo

Main implementation file:

- [core/graph_clustering.py](core/graph_clustering.py)

There are 3 classes you need to remember.

## 2.1 `BranchAwareClustering` (legacy baseline)

- Rule-based branch assignment from base positions and supporter inheritance.
- Output is deterministic batches but with simpler grouping logic.

Anchor:

- [core/graph_clustering.py](core/graph_clustering.py#L6)

## 2.2 `BranchAwareLayerCuttingClustering` (current phase2 default)

- Stage A: branch grouping.
- Stage B: local-layer-aware cutting inside each branch.
- Then inter-branch dependency-safe expansion.

Anchor:

- [core/graph_clustering.py](core/graph_clustering.py#L158)

## 2.3 `KMeansBranchClustering` (TASK-020 experimental path)

- Uses topology feature vectors from Phase1 graph only.
- Deterministic k-means with fixed seed.
- Includes dependency repair/gating to keep final batches DAG-safe.

Anchor:

- [core/graph_clustering.py](core/graph_clustering.py#L341)

---

## 3) Project-specific mathematical abstraction (provenance path)

## 3.1 Provenance-set clustering

Let roots be base-supported nodes:

$$
R=\{r\in V\setminus\{0\}\mid (0\to r)\in E\}
$$

For node $v$:

$$
P(v)=\{r\in R\mid r\leadsto v\}
$$

Cluster signature:

$$
\kappa(v)=\mathrm{sorted}(P(v))
$$

Nodes with same $\kappa(v)$ are grouped together.

## 3.2 Scheduling hard constraints

Dependency legality:

$$
\forall (u\to v)\in E:\ t(u)<t(v)
$$

Batch cap:

$$
\#\text{nodes per batch}\le 2
$$

Merge cap per subtask:

$$
\#\text{merge nodes per subtask}\le 2
$$

## 3.3 Scheduling soft preferences

1. pure clusters before merge clusters,
2. lower layer first,
3. stable root/branch order,
4. branch rise streak cap.

Policy reference:

- [docs/ops/TASK020_PROVENANCE_CLUSTERING_AND_PRUNING_GUIDE.md](docs/ops/TASK020_PROVENANCE_CLUSTERING_AND_PRUNING_GUIDE.md)

---

## 4) Features used by k-means path (repo exact)

`KMeansBranchClustering` feature vector (v1 topology only):

- `layer`
- `in_degree`
- `out_degree`
- `supporter_layer_mean`
- `is_multi_support`
- `pos_left_count`
- `pos_right_count`
- `pos_unknown_count`

Then:

1. z-score normalization,
2. deterministic k-means++ init,
3. fixed-seed iterations,
4. dependency-safe batch reconstruction.

Anchors:

- [core/graph_clustering.py](core/graph_clustering.py#L365)
- [core/graph_clustering.py](core/graph_clustering.py#L449)
- [core/graph_clustering.py](core/graph_clustering.py#L557)

---

## 5) How it is inserted into phase2 pipeline

Integration entry:

- [pipeline/run_phase2.py](pipeline/run_phase2.py)

Key behavior:

- default `clustering_algorithm="branch_layer_cutting"`;
- switch to k-means by passing `clustering_algorithm="kmeans"`;
- still emits Prompt1/Prompt2-compatible schema;
- then `core/phase2_codegen.py` generates `step_*.fol/.lgp`.

Important compatibility point:

- `run_phase2_pipeline()` return tuple shape remains legacy-compatible for `driver.py`.

---

## 6) Executable artifact contract (what makes clustering useful)

For acceptance we require not only JSON clusters, but executable planning files.

Expected artifacts per policy run:

- `execution_plan.json`
- `phase2_strategy_policy.json`
- `policy_trace.json`
- `step_*.fol`
- `step_*.lgp`

Examples:

- [generated/three_branch_policy_run/execution_plan.json](generated/three_branch_policy_run/execution_plan.json)
- [generated/pyramid_policy_run/execution_plan.json](generated/pyramid_policy_run/execution_plan.json)
- [generated/rect_3x5_policy_run/execution_plan.json](generated/rect_3x5_policy_run/execution_plan.json)

Visualization/cluster examples:

- [generated/phase2_provenance_clusters.json](generated/phase2_provenance_clusters.json)
- [generated/phase2_provenance_plot.svg](generated/phase2_provenance_plot.svg)
- [generated/phase2_kmeans_clusters.json](generated/phase2_kmeans_clusters.json)
- [generated/phase2_kmeans_plot.svg](generated/phase2_kmeans_plot.svg)

---

## 7) Concrete benchmark outcomes (repo-verified)

Unified provenance scheduling outputs:

- three-branch: `[[1],[3,4],[2],[5,6],[7],[8],[9]]`
- pyramid: `[[1,2],[3],[4,5],[6],[7],[8]]`
- 3x5: `[[1],[4],[2],[5],[3],[6],[7],[10],[8],[11],[9],[12],[13,14],[15]]`

This is the finalized no-fallback unified policy recorded in TASK-020 closure.

Reference:

- [docs/roadmap.md](docs/roadmap.md)

---

## 8) Testing and call contract (for recall)

Canonical test/tools location:

- [test/graph_clustering](test/graph_clustering)

Run order:

1. module test:
   - `python3 test/graph_clustering/test_kmeans_clustering.py`
2. provenance policy harness:
   - `python3 test/graph_clustering/tools/run_provenance_pruning_codegen.py --input generated/phase1_target_graph.json --out-dir generated/three_branch_policy_run --node-id 202`
3. visual diagnostics:
   - `python3 test/graph_clustering/tools/visualize_phase1_provenance_clustering.py --input generated/phase1_target_graph.json`
   - `python3 test/graph_clustering/tools/visualize_phase1_kmeans.py --input generated/phase1_target_graph.json`

Guide:

- [docs/ops/TESTING_AND_MERGE_CALL_GUIDE.md](docs/ops/TESTING_AND_MERGE_CALL_GUIDE.md)

---

## 9) Knowledge map: from theory to code to planning

1. Theory layer:
   - DAG precedence + cluster abstraction.
2. Algorithm layer:
   - branch/layer or k-means/provenance clustering.
3. Policy layer:
   - hard constraints + soft priorities.
4. Execution layer:
   - Prompt1/Prompt2 + `step_*.fol/.lgp` codegen.
5. Validation layer:
   - benchmark plans + policy traces + visualization.

This chain is exactly what makes our clustering work auditable and deployable.

---

## 10) References for further study

1. Karypis, G., Kumar, V. "Multilevel k-way partitioning scheme for irregular graphs." *JPDC*, 48(1):96-129, 1998.
2. Schaeffer, S. E. "Graph clustering." *Computer Science Review*, 1(1):27-64, 2007.
3. Battaglia, P. W. et al. "Relational inductive biases, deep learning, and graph networks." arXiv:1806.01261, 2018.

Project internal references:

- [docs/clustering_algorithm_report.md](docs/clustering_algorithm_report.md)
- [docs/module_specs/graph_clustering_engine.md](docs/module_specs/graph_clustering_engine.md)
- [docs/ops/TASK020_PROVENANCE_CLUSTERING_AND_PRUNING_GUIDE.md](docs/ops/TASK020_PROVENANCE_CLUSTERING_AND_PRUNING_GUIDE.md)
