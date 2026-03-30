# TASK-020 Provenance Clustering + Execution Pruning Guide

## Suggested Notion Tags

- `task-020`
- `graph-clustering`
- `provenance-clustering`
- `execution-pruning`
- `phase2`
- `planning-policy`
- `safety-constraints`

## 1) About the XY values in clustering plots

The `x` and `y` values in current provenance plot outputs are **layout coordinates** for visualization only.

- `x`: cluster lane position + intra-cluster offset
- `y`: topological layer height (scaled)

They are **not physical world coordinates**, **not robot poses**, and **not solver trajectory coordinates**.

Use cases:

- explain grouping structure
- inspect branch separation and merge chain
- debug policy behavior

Non-use cases:

- direct motion planning
- collision checking
- geometric feasibility

## 2) Recommended architecture boundary

Use two stages:

1. **Clustering stage**: produce structural groups from support DAG
2. **Pruning/scheduling stage**: apply execution constraints and produce solver-facing batches

Rationale:

- keeps clustering definition clean and paper-friendly
- keeps hardware/runtime constraints explicit and adjustable
- easier ablation and debugging (`cluster quality` vs `execution policy`)

## 3) Rule set (formalized from oral policy)

Let support DAG be $G=(V,E)$, edge $u\to v$ means $u$ supports $v$.
Let `layer(v)` be topological level.

### R1. Dependency validity (hard)

Never place node before any predecessor:

$$
\forall (u\to v)\in E:\; t(u) < t(v)
$$

### R2. Build direction preference (soft)

Prefer lower to upper, left to right:

$$
\min \sum_v \big(\alpha\,\text{upward\_penalty}(v)+\beta\,\text{rightward\_penalty}(v)\big)
$$

### R3. Single-branch priority (soft)

Prefer completing pure branches before merge chain when both are ready.

### R4. Branch stability cap (hard/soft hybrid)

Consecutive placements in the same branch should not exceed 1 when branch height keeps rising (i.e., at most two stacked layers per continuous run):

$$
   ext{consecutive\_same\_branch\_rise} \le 1
$$

If exceeded, schedule a ready task from another branch.

### R5. Merge task cap per subtask (hard)

Within one solver subtask, merge-type placements cannot exceed 2:

$$
\#\text{merge\_nodes\_in\_subtask} \le 2
$$

If still larger after previous splitting, cut every 2 placements.

### R6. Batch size cap (hard)

To match compute limit:

$$
\#\text{nodes\_per\_batch} \le 2
$$

### R7. Ready-set legality (hard)

Each scheduled node must be from current ready set:

$$
   ext{Pred}(v)\subseteq \text{Placed}
$$

## 4) Additional rules worth adding

### A1. Frontier-first for merge chain

For merge cluster, place frontier node first, then interior chain.

### A2. Height-balance tie-breaker

When multiple branches are ready, pick the branch with lower current built height.

### A3. Recovery slack guard

Reserve at least one alternative ready node for next step when possible (avoid dead-end micro-choices).

### A4. Reachability/regrasp gate (if available)

Do not enqueue node if kinematic check fails; postpone and log reason.

### A5. Time-budget cap per subtask

Stop extending a subtask when estimated solve time exceeds threshold.

### A6. Determinism

Fix tie-break order (layer, branch id, node id) for reproducibility.

## 5) Suggested scheduling pipeline

1. Build clusters from provenance signatures
2. Mark node type: `pure` vs `merge`
3. Iterate ready-set scheduling with rule priority:
   - hard constraints (`R1,R5,R6,R7`)
   - stability control (`R4`)
   - preference objectives (`R2,R3`)
4. Emit solver-facing batches
5. Log policy decisions for audit (`why this node now`)

## 6) Logging schema (recommended)

Per scheduled step:

- `step_id`
- `ready_set`
- `chosen_node`
- `chosen_cluster`
- `rules_triggered` (e.g., `R4 branch cap`)
- `deferred_candidates`
- `batch_id`

This is critical for paper traceability and debugging.

## 7) Conclusion

For this project, policy should be:

- **Clustering = structural decomposition**
- **Pruning/Scheduling = execution constraints + risk/compute control**

This split keeps logic clear and generalizable to larger cases (e.g., 4x4 stacking, multi-merge towers)

## 8) Mathematical abstraction (compact form)

Let $G=(V,E)$ be a DAG, with edge $u\to v$ meaning supporter-to-supported precedence.

### 8.1 Provenance clustering

Let base roots be

$$
R=\{r\in V\setminus\{0\}\mid (0\to r)\in E\}.
$$

For each node $v$, define provenance set

$$
P(v)=\{r\in R\mid r\leadsto v\}.
$$

Cluster key is the signature of $P(v)$:

$$
\kappa(v)=\text{sorted-tuple}(P(v)).
$$

Nodes with same $\kappa$ form one structural cluster (optionally split by disconnected components).

### 8.2 Independent-completion criterion

For a cluster $C\subseteq V$, define frontier

$$
F(C)=\{v\in C\mid \mathrm{Pred}(v)\setminus C\neq\varnothing\}.
$$

Independent completion means interior closure:

$$
\forall v\in C\setminus F(C):\; \mathrm{Pred}(v)\subseteq C.
$$

### 8.3 Scheduling objective with hard constraints

Let $t(v)$ be execution index of node $v$.

Hard constraints:

$$
\forall (u\to v)\in E:\; t(u)<t(v)
$$

$$
\#\text{nodes per batch}\le 2,
\quad
\#\text{merge nodes per subtask}\le 2.
$$

Soft preference (lexicographic / weighted):

1. pure cluster before merge cluster,
2. lower layer first,
3. left-to-right root order,
4. same-branch rising streak cap $\le 1$ (if alternatives exist).

## 9) Acceptance standard (mainline-aligned)

Mainline reference for executable artifact format is `core/phase2_codegen.py`.

Acceptance should validate:

1. **Strategy schema compatibility** (`prompt1/prompt2`)
2. **Executable file generation** (`step_*.fol`, `step_*.lgp`)
3. **Dependency-valid order and batches**
4. **Policy trace auditable** (`why chosen now`)

Recommended harness script:

- `test/graph_clustering/tools/run_provenance_pruning_codegen.py`

Expected outputs in one run:

- `execution_plan.json`
- `phase2_strategy_policy.json`
- `policy_trace.json`
- `step_*.fol` / `step_*.lgp`

This directly checks whether clustering + pruning actually yields solver-facing executable plans.

## 10) Closure update (2026-03-26)

- Unified scheduling policy is finalized by removing the `no-merge-fallback` branch in `test/graph_clustering/tools/run_provenance_pruning_codegen.py`.
- All benchmark graphs now use one consistent path:
  1. pure-branch scheduling,
  2. merge-chain scheduling,
  3. layer-constrained batching.
- Verified outputs:
  - three-branch: `[[1],[3,4],[2],[5,6],[7],[8],[9]]`
  - pyramid: `[[1,2],[3],[4,5],[6],[7],[8]]`
  - 3x5: `[[1],[4],[2],[5],[3],[6],[7],[10],[8],[11],[9],[12],[13,14],[15]]`
- This closes TASK-020 with one unified rule set and without per-shape fallback logic.
