# Multilevel Graph Partitioning with Hierarchy-Aware Batch Cutting

## 1. Overview

This document replaces the previous rule-based batching description with a two-stage
decomposition procedure for the VLM-LGP pipeline.

The input is an object-support graph
$G=(V,E)$, where each node is a target object and each directed edge denotes a direct
support dependency. The output is an ordered sequence of solver-facing batches that
respects support precedence while preserving as much branch-level structural coherence
as possible.

The key design decision is to separate:

1. **branch aggregation**, and
2. **execution batch cutting**.

The previous rule-based approach entangled these two operations. The revised method
first aggregates coherent structural branches with multilevel graph partitioning and
only then cuts each branch into dependency-safe batches.

## 2. Stage One: Branch Aggregation by Multilevel Graph Partitioning

### 2.1 Goal

The first stage does **not** emit execution batches. Its goal is to identify which
nodes should be treated as belonging to the same structural branch.

### 2.2 Auxiliary Graph

The directed support graph is converted into an auxiliary weighted graph
$\bar{G}=(V,\bar{E},W)$ for partitioning. During this stage, edge direction is not the
primary concern; instead, the graph weights encode structural affinity:

- edges inside a single-support chain receive higher affinity,
- edges entering a structural merge can receive lower affinity,
- refinement favors keeping strongly coupled substructures inside the same partition.

### 2.3 Optimization Objective

We solve a multilevel graph partitioning problem of the form

$$
\min_{\mathcal{P}}
\sum_{(u,v)\in\bar{E}} w_{uv}\,\mathbb{I}[\pi(u)\neq\pi(v)]
\;+\;
\lambda\sum_j \left||P_j|-\bar{s}\right|,
$$

where:

- $\mathcal{P}=\{P_1,\dots,P_m\}$ is the partition set,
- $\pi(v)$ is the partition index of node $v$,
- $w_{uv}$ is the edge affinity,
- $\bar{s}$ is the target partition scale.

The algorithm follows the standard multilevel pattern:

1. coarsen the graph,
2. partition the coarse graph,
3. uncoarsen and refine the partition on finer graphs.

### 2.4 Running Example

For the representative support graph in the current draft, the branch aggregation stage
produces three coherent groups:

- `134`
- `256`
- `789`

These groups are the branch-level subgraphs. They are **not yet** the final execution
sequence.

## 3. Stage Two: Hierarchy-Aware Batch Cutting

### 3.1 Goal

The second stage converts each aggregated branch into actual execution batches.

### 3.2 Cutting Rules

For each branch subgraph:

1. recover the original directed support edges,
2. compute local depth / hierarchy,
3. cut from lower layers to higher layers,
4. ensure each batch satisfies support precedence,
5. keep the batch within the current solver-facing scale,
6. group same-layer nodes together only when they share the same immediate structural
   role.

### 3.3 Running Example

The branch groups are cut as:

- `134 -> 1 | 34`
- `256 -> 2 | 56`
- `789 -> 7 | 8 | 9`

After precedence-consistent global ordering, the final execution sequence becomes:

`1 | 34 | 2 | 56 | 7 | 8 | 9`

## 4. Why This Is Better Than the Previous Rule-Based Scheme

The previous rule-based batching scheme mixed branch inference and execution ordering
inside a single heuristic routine. That made the decomposition difficult to justify
analytically.

The revised method is better for four reasons:

1. **Branch discovery is principled.**
   Branches are produced by a mature graph partitioning procedure rather than by
   hand-written label propagation.

2. **Batch cutting is interpretable.**
   Each branch is first aggregated structurally and then cut according to hierarchy.

3. **The algorithm story is cleaner.**
   The method can be described as “aggregate first, cut second,” which is easier to
   explain in a paper.

4. **Future extensibility is better.**
   The branch discovery stage remains meaningful even when the support graph becomes
   larger or more irregular.

## 5. Comparison on the Current Example

### Previous Rule-Based Batching

Final output:

`1 | 2 | 34 | 56 | 7 | 8 | 9`

### Revised Two-Stage Decomposition

Intermediate branch aggregation:

`134 | 256 | 789`

Final hierarchy-aware cutting:

`1 | 34 | 2 | 56 | 7 | 8 | 9`

The revised result is easier to explain because it explicitly reflects the branch
structure before batch generation.
