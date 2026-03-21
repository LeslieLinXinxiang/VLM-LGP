# Branch-Aware Topological Clustering Algorithm Report

## 1. Introduction & Overview

In Phase 2 of the VLM-LGP pipeline, the strategy generation has been transitioned from a non-deterministic VLM approach to a **Branch-Aware Topological Clustering (BATC)** algorithm.

This algorithm operates on the structural graph generated in Phase 1 ($G = (V, E)$), where vertices represent objects and directed edges represent physical support dependencies. The primary goal of the BATC algorithm is to decompose the global assembly task into a sequence of executable, collision‑free sub‑tasks (batches) while maintaining the physical stability of the structure and optimizing for parallel robot execution (e.g., dual‑arm coordination).

## 2. Theoretical Framework & Mathematical Formulation

Let the assembly structure be defined as a Directed Acyclic Graph (DAG) $G = (V, E)$, where:
- $V = \{v_1, v_2, \dots, v_n\}$ is the set of objects.
- $E = \{(u, v) \mid u, v \in V\}$ is the set of structural dependencies, meaning object $v$ is supported by object $u$.
- $P(u, v)$ is an optional attribute on edge $(u, v)$ representing the relative geometric placement (e.g., "left", "right").

### 2.1 Layer Computation (Topological Depth)

To ensure physical stability, an object can only be placed after all its supporting objects are placed. We formally define the layer (or depth) $L(v)$ for each vertex $v \in V$:

$$
L(v) =
\begin{cases}
0 & \text{if } \text{indegree}(v) = 0 \\
\max_{\{u \mid (u, v) \in E\}} L(u) + 1 & \text{otherwise}
\end{cases}
$$

**Explanation:**
- The base of the structure (e.g., the table) has an indegree of 0 and is assigned to Layer 0.
- Any other object is assigned a layer strictly greater than the maximum layer of all its supporters. This guarantees a strict partial order.

### 2.2 Branch Assignment (Spatial Partitioning)

To optimize multi‑arm execution, the structure is spatially partitioned into "branches" (e.g., left tower vs. right tower). We define a branch assignment function $B(v)$ for each vertex:

**Base Case (Layer 1):**
For objects directly resting on the base ($L(v) = 1$), their branch is defined by their relative placement on the base $u$:

$$
B(v) = P(u, v) \quad \text{where } L(u) = 0 \text{ and } (u,v) \in E
$$

**Recursive Propagation (Layer > 1):**
For higher‑level objects, the branch is inherited from its supporters. Let $S_B(v)$ be the set of unique branches of all supporters of $v$:

$$
S_B(v) = \{ B(u) \mid (u, v) \in E \}
$$

The assignment function is piecewise based on $|S_B(v)|$:

$$
B(v) =
\begin{cases}
 b & \text{if } S_B(v) = \{b\} \quad (\text{Single Branch Inheritance}) \\
"bridge" & \text{if } |S_B(v)| > 1 \quad (\text{Cross‑Branch Spanning})
\end{cases}
$$

**Explanation:**
- If an object rests exclusively on components from a single branch (e.g., the "left" branch), it inherits that branch identity.
- If an object spans multiple branches (e.g., a lintel resting on two separate pillars), it is classified as a "bridge". Bridges synchronize parallel branches.

### 2.3 Executable Batch Generation

Let $S_k \subset V$ be the set of safely placed objects at iteration $k$. Initially, $S_0 = \{v \in V \mid L(v) = 0\}$.

At iteration $k$, the set of **placeable** objects $P_k$ (those whose dependencies are fully satisfied) is defined as:

$$
P_k = \{ v \in V \setminus S_k \mid \forall u \text{ where } (u, v) \in E,\; u \in S_k \}
$$

To form execution batches $C_k$, the algorithm partitions $P_k$ by branch:

$$
P_k^{(b)} = \{ v \in P_k \mid B(v) = b \}
$$

For a given maximum robotic capacity $M$ ($M=2$ for dual‑arm), the algorithm extracts subsets of size at most $M$ from each branch partition $P_k^{(b)}$ deterministically to form the output batches for this iteration.

## 3. Algorithm Summarization

1. **Parse Input Graph:** Read $V$ and $E$ and initialize $L(v) = -1$ and $B(v) = \text{null}$.
2. **Compute Dependencies:** Iteratively compute $L(v)$ for all vertices until all layers are resolved (equivalent to a topological sort).
3. **Partition Space:** Assign roots to their specific physical branches, then propagate these branches upwards. Detect and label multi‑support objects as "bridges".
4. **Greedy Grouping:** Maintain a set of placed objects. While unplaced objects exist:
   - Identify all placeable objects whose supporters are already placed.
   - Group them by their branch identity.
   - For each branch, slice the placeable objects into sequential batches of maximum size $M$.
   - Yield these batches and add their objects to the placed set.

## 4. Advantages of this Approach

1. **Absolute Determinism:** Eliminates the hallucination and stochastic behavior previously observed when relying solely on LLM/VLMs for step planning.
2. **Physical Feasibility Guarantee:** By adhering strictly to the topological layers $L(v)$, physical violations (floating objects) are mathematically impossible.
3. **Spatial Parallelism Readiness:** The $B(v)$ function cleanly separates disjoint physical sets, natively exposing parallelism for dual‑arm manipulators while accurately identifying bottleneck synchronization points (bridges).
