# Controlled Branch Grouping and Hierarchy-Aware Batch Cutting

## 1. Document Scope

This document describes the **algorithm that is currently implemented and tested in
the repository**, rather than the broader mature algorithm family that may be adopted
later.

The current algorithm is:

- code class name: `BranchAwareLayerCuttingClustering`
- document name: `Controlled Branch Grouping + Layer-Aware Batch Cutting`

It is important to keep the scope precise:

1. this is a **controlled prototype** for the current assembly task,
2. it is **not** yet a full implementation of multilevel graph partitioning,
3. it is designed to validate a clean two-stage decomposition story on the current
   support graph format.

The current mainline integration status is:

1. `pipeline/run_phase2.py` now uses `BranchAwareLayerCuttingClustering` by default,
2. the legacy `BranchAwareClustering` call is kept in the code as a commented fallback,
3. both implementations expose the same `generate_optimal_strategy()` JSON schema so
   downstream consumers can switch between them without changing file formats.

## 2. What the Current Algorithm Does

The input is the current Phase1 support graph:

- `generated/phase1_target_graph.json`

The output is an ordered sequence of solver-facing batches.

The algorithm explicitly separates two stages:

1. **branch grouping**
2. **hierarchy-aware batch cutting**

On the current running example, the desired decomposition is:

- branch grouping: `134 | 256 | 789`
- final execution sequence: `1 | 34 | 2 | 56 | 7 | 8 | 9`

## 3. Formal Name and Control Boundary

### 3.1 Name

The current repository implementation should be referred to as:

- **Controlled Branch Grouping + Hierarchy-Aware Batch Cutting**

This name is intentionally conservative. It reflects what the current code actually
does and avoids overstating the implementation as a complete graph partitioning
solver.

### 3.2 Why It Is Called “Controlled”

The algorithm is called **controlled** for three reasons:

1. the input format is fixed to the current support-graph schema,
2. the current validation target is a fixed representative example,
3. the grouping and cutting logic are designed to be interpretable and testable before
   any larger pipeline replacement.

In other words, the goal at this stage is not “generic graph clustering for all
graphs,” but “a stable and explainable decomposition mechanism for the current task.”

## 4. Core Principles of the Current Implementation

The current implementation in `core/graph_clustering.py` follows five principles.

### 4.1 Support-Graph Parsing

The Phase1 JSON is parsed into a directed support graph `G=(V,E)`:

- nodes represent target objects,
- directed edges represent direct support dependencies.

This preserves the execution-critical fact that if object `u` supports object `v`,
then `u` must be realized before `v`.

### 4.2 Global Layer Computation

The algorithm first computes a global topological layer for every node:

- nodes without supporters are assigned to the lowest layer,
- every other node is assigned one layer above the maximum layer of its supporters.

This gives a stable hierarchy over the whole support graph.

### 4.3 Branch Grouping

The current branch grouping mechanism is rule-guided and graph-based:

1. layer-1 nodes initialize branch labels from base support positions such as
   `left` and `right`,
2. higher-layer nodes inherit branch labels from their supporters,
3. nodes whose supporters come from multiple branches are labeled as `bridge`.

On the current example, this produces:

- `left -> [1, 3, 4]`
- `right -> [2, 5, 6]`
- `bridge -> [7, 8, 9]`

This branch-level result is the intermediate aggregation:

- `134 | 256 | 789`

### 4.4 Hierarchy-Aware Batch Cutting

After branch grouping, the algorithm cuts each branch into solver-facing batches.

For each branch:

1. the induced subgraph is recovered,
2. local layers are recomputed inside that branch,
3. nodes are processed from lower local layers to higher local layers,
4. same-layer nodes are grouped only when they share the same immediate structural
   role,
5. batch size remains bounded by the current solver-facing limit.

This yields:

- `134 -> 1 | 34`
- `256 -> 2 | 56`
- `789 -> 7 | 8 | 9`

### 4.5 Branch-Level Precedence Ordering

The algorithm then builds a dependency graph between branches and expands the branch
local batches in a dependency-safe order.

On the current example, the final global sequence becomes:

- `1 | 34 | 2 | 56 | 7 | 8 | 9`

## 5. Reference Algorithm Family and Paper

The mature algorithm family that motivates the current decomposition story is
**multilevel graph partitioning**.

The classical reference is:

- George Karypis and Vipin Kumar, *Multilevel k-way partitioning scheme for irregular graphs*, Journal of Parallel and Distributed Computing, 48(1):96-129, 1998.

That line of work is built around three stages:

1. **coarsening**
2. **partitioning**
3. **uncoarsening / refinement**

This is the mature graph-partitioning route we previously discussed as a future
upgrade path.

## 6. What Is Borrowed from That Literature, and What Is Not

This distinction must be explicit.

### 6.1 What Is Borrowed

The current prototype borrows the following high-level idea from the multilevel graph
partitioning literature:

- structure should be **aggregated first**,
- execution-oriented decomposition should be done **after aggregation**, not mixed into
  one opaque heuristic.

That is why the current algorithm is organized as:

- branch grouping first,
- hierarchy-aware cutting second.

### 6.2 What Is Not Yet Implemented

The current repository implementation does **not** yet include:

- graph coarsening,
- coarse-graph partition optimization,
- uncoarsening / refinement,
- a formal partition objective with cut minimization.

Therefore, the current code should **not** be described as “we implemented multilevel
graph partitioning.” The truthful wording is:

- the current repository contains a **controlled two-stage prototype**,
- its decomposition story is **inspired by** the multilevel graph partitioning
  literature,
- a full multilevel partitioning implementation remains future work.

## 7. Comparison Against the Legacy BATC Logic

The legacy method in the repository is:

- `BranchAwareClustering`

Its output on the current example is:

- `1 | 2 | 34 | 56 | 7 | 8 | 9`

The controlled two-stage prototype outputs:

- intermediate grouping: `134 | 256 | 789`
- final sequence: `1 | 34 | 2 | 56 | 7 | 8 | 9`

The practical difference is that the new prototype separates:

1. **which nodes belong to the same structural branch**, and
2. **how each branch is cut into execution batches**.

That separation makes the current method easier to explain, easier to test, and
easier to evolve toward a more formal graph-partitioning implementation later.

## 8. Repository Test Coverage

The standalone validation script is:

- `test/pipeline/test_phase2_layer_aware_cutting.py`

It checks three expectations on the fixed current input:

1. legacy batching result,
2. branch grouping result,
3. final hierarchy-aware cutting result.

This keeps the current algorithm description grounded in an executable test rather than
only in narrative documentation.
