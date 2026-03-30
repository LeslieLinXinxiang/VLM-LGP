# Method Upgrade Taskbook (2026-03-25)

## 1. Purpose

This taskbook defines an implementation path to upgrade three engineering-heavy components into optimization-oriented, publication-ready methods:

1. execution ordering: from Euclidean-only sort to multi-objective optimization with manipulability,
2. reachability: from per-object waypoint checker loop to differentiable GMM + ESDF heatmap scoring,
3. graph clustering: from controlled heuristic decomposition to a mature clustering pipeline (k-means family).

This document is aligned with DDE Layer 0-4 and is intended as the execution contract for TASK-018/019/020.

---

## 2. Baseline Snapshot (Current State)

### 2.1 Execution ordering baseline

- Current direct ordering logic in Phase0 inventory naming uses Euclidean distance to robot base as primary rank signal.
- Limitation: single-factor objective ignores dexterity/posture quality.

### 2.2 Reachability baseline

- Current Phase0 flow (`split_infeasible_objects_from_reachability`) invokes the checker object-by-object and reads one binary feasibility result per object.
- Limitation: no generalized continuous metric, no differentiable field, weak transferability to new scenes.

### 2.3 Clustering baseline

- Current Phase2 default uses `BranchAwareLayerCuttingClustering` with rule-guided branch labels and layer cutting.
- Limitation: interpretable but still heuristic-dominant; lacks mature objective-based clustering semantics.

---

## 3. Workstream A — Manipulability-First Execution Ordering (TASK-018)

### 3.1 Goal

Replace Euclidean-based ordering with manipulability-first ordering.

$$
\max_{o \in \mathcal{O}_{\mathrm{feasible}}} \ m(o)
$$

Where:

- $m(o)$: manipulability score for object candidate $o$,
- $\mathcal{O}_{\mathrm{feasible}}$: candidates that already passed reachability decision,
- no distance term is used in v1 ordering.

### 3.2 Modification scope

- Candidate modules:

  - `core/phase0_parser.py` (ordering policy extraction),
  - `pipeline/run_phase0.py` (configuration plumb-through),
  - optional new module `core/object_ordering.py`.

- No changes to legacy tuple return contract in `pipeline/run_phase2.py`.
- Keep same-type local ordering (within object-type groups), consistent with current naming/grouping policy.
- Keep existing tie-break behavior unchanged (follow current stable ordering logic in `core/phase0_parser.py`).

### 3.3 Input/Output standard

- Input:

  - feasible candidate set (from current reachability split),
  - robot/object state required for manipulability computation,
  - deterministic ordering policy configuration (seed/report flags).

- Output (new artifact proposal):

  - `generated/ordering_score_report.json` containing per-object breakdown:

    - `manipulability_score`, `unknown_threshold`, `status` (`ranked`/`unknown`), `rank`.

  - downstream handoff format remains current feasible/infeasible schema (unchanged contract).

### 3.4 Acceptance criteria

1. Deterministic ranking under fixed seed/config.
2. Unknown manipulability candidates are deterministically pushed to queue tail (no distance fallback).
3. Report includes full score decomposition for auditability.
4. Unknown classification must be threshold-based and explicitly logged (`score < threshold`).

### 3.5 Boundaries

- v1 does not alter solver constraints directly; only candidate execution order.
- v1 does not use Euclidean distance as fallback ranking factor.

### 3.6 Coupling with Reachability (Locked Boundary)

Selected orchestration is serial:

1. Reachability decision is completed first in current Phase0 flow.
2. Workstream A consumes only feasible candidates.
3. Workstream A outputs ranking data for auditing.
4. Interface to next node remains the existing feasible/infeasible format.

Locked decisions:

- 1A: ordering scope is same-type local ordering.
- 2A: unknown manipulability is queued to tail.
- 3A: decision + continuous data are produced in current flow, but downstream receives current format only.
- 4A: serial coupling (`reachability -> ordering`).

### 3.7 Unknown Threshold Policy (Locked)

- Unknown must use an explicit numeric threshold.
- Threshold is for internal handling/visualization/analysis and must be recorded in sidecar reports.
- Unknown data is not forwarded as a new external contract to the next node in v1.

### 3.8 Implementation Consensus (Locked for v1)

1. Ordering is executed after reachability filtering (`reachability -> ordering`).
1. Ordering uses manipulability-style continuous score first, then thresholded status for audit/control:

$$
\operatorname{status}(o)=
\begin{cases}
\operatorname{ranked}, & m(o) \ge \tau_m\\
\operatorname{unknown}, & m(o) < \tau_m \text{ or invalid}
\end{cases}
$$

1. Unknown is **not** equivalent to infeasible. Unknown objects are pushed to queue tail, while infeasible is decided in Workstream B.
1. Initial threshold for implementation bootstrap: $\tau_m = 0.08$ (assuming normalized $m(o)\in[0,1]$).
1. Manipulability metric should follow a mature Jacobian-based route (Yoshikawa-style family) and be robot-parameterized for Franka.

---

## 4. Workstream B — Differentiable Reachability Heatmap (TASK-019)

### 4.1 Goal

Define a continuous reachability score field via GMM + ESDF and threshold it into feasible/infeasible labels.

Proposed score form:

$$
R(x) = \alpha \cdot P_{\text{GMM}}(x) + \beta \cdot S_{\text{ESDF}}(x)
$$

And decision rule:

$$
\text{reachable}(x)=\mathbb{1}[R(x) \ge \tau]
$$

Where:

- $P_{\text{GMM}}(x)$: probability-like dexterity/reach prior,
- $S_{\text{ESDF}}(x)$: collision-clearance-derived score,
- $\tau$: global threshold (or per-object-class threshold in v2).

### 4.2 Modification scope

- Candidate modules:

  - `core/phase0_parser.py` (replace per-object subprocess loop strategy),
  - optional new modules:

    - `core/reachability_field.py` (GMM/ESDF fusion),
    - `core/reachability_threshold.py` (decision and calibration),

  - `pipeline/run_phase0.py` (new report output wiring).

### 4.3 Input/Output standard

- Input:

  - object target poses,
  - scene collision geometry/ESDF source,
  - robot kinematic sampling for GMM fitting or inference.

- Output (new artifact proposal):

  - `generated/reachability_heatmap.json`:

    - grid/meta,
    - continuous score statistics,
    - threshold and binary decisions.

  - `generated/infeasible_objects.json` remains backward-compatible (derived view).

### 4.4 Acceptance criteria

1. Heatmap output is continuous and numerically stable.
2. Binary split is produced by explicit threshold logic (not ad hoc branching).
3. Existing downstream consumer of `infeasible_objects.json` remains valid.

### 4.5 Boundaries

- v1 allows offline precompute; real-time incremental ESDF updates are out-of-scope.
- v1 does not claim formal probabilistic calibration; only reproducible score-threshold mapping.

### 4.6 Scope Clarification (018 vs 019)

- TASK-018 (`Manipulability-First Ordering`): pure ranking over feasible candidates; no ESDF term in the ordering objective.
- TASK-019 (`Differentiable Reachability`): uses GMM + ESDF score terms inside reachability scoring and thresholding.
- Downstream interface remains the same feasible/infeasible contract for compatibility.

### 4.7 Literature-grounded Note (Murooka et al., 2025)

Observed method characteristics from `assets/literature/Murooka et al. - 2025 - Learning Differentiable Reachability Maps for Optimization-based Humanoid Motion Generation.pdf`:

1. The paper uses NN/SVM-based differentiable reachability maps as the main method (classification-style scalar field), not GMM as the main model.
2. GMM is discussed in related work as one common prior approach.
3. Sample generation includes kinematic constraints with self-collision/joint-limit checks (FK/IK-based dataset construction).
4. Obstacle avoidance is added as additional optimization constraints in planning experiments.
5. Signed-distance-like behavior is discussed for optimization friendliness, while efficient construction in high-dimensional spaces is described as challenging.

### 4.8 Implementation Consensus (Locked for v1)

1. Reachability and ordering are different stages and must not be merged.
1. Workstream B decides feasible/infeasible with thresholded continuous score.
1. Workstream A ranks only feasible candidates.
1. Workstream B target score uses GMM prior plus ESDF clearance term:

$$
R(x)=\alpha\,P_{\mathrm{GMM}}(x)+\beta\,S_{\mathrm{ESDF}}(x),\quad
\operatorname{reachable}(x)=\mathbb{1}[R(x)\ge\tau_r]
$$

1. ESDF clearance semantics are handled inside TASK-019 score construction; no separate extra collision term is required in the written objective.
1. This can be completed offline and locally (no mandatory real-time simulator loop). Required capabilities are kinematics + ESDF construction/inference.
1. Existing `generated/infeasible_objects.json` remains the backward-compatible contract; new continuous reports remain additive.

---

## 5. Workstream C — Academic Graph Clustering Upgrade (TASK-020)

### 5.1 Goal

Upgrade from rule-only branch/layer logic to a mature clustering process centered on k-means family methods.

Recommended path:

1. construct node feature vectors from graph topology + geometry + dependency context,
2. run k-means (or k-means on spectral embedding),
3. repair cluster order with DAG-safe precedence reconstruction,
4. output solver-facing batches with dependency guarantees.

### 5.2 Modification scope

- Candidate modules:

  - `core/graph_clustering.py` (new class, keep legacy classes intact),
  - `pipeline/run_phase2.py` (switchable algorithm selector),
  - `test/pipeline/test_phase2_layer_aware_cutting.py` + new clustering tests.

- Must preserve Prompt1/Prompt2 output schema compatibility.

### 5.3 Input/Output standard

- Input:

  - Phase1 support graph (`objects` schema and/or `V,E` schema),
  - clustering hyperparameters (`k`, feature set, seed).

- Output:

  - existing strategy schema with added metadata:

    - `algorithm`, `k`, `feature_version`, `cluster_assignment`, `dependency_repair_log`.

### 5.4 Acceptance criteria

1. No dependency violations in output batches.
2. Reproducible clustering with fixed seed.
3. Better decomposition quality than heuristic baseline on benchmark graphs (define objective in test report).

### 5.5 Boundaries

- v1 focuses on k-means family; full multilevel partitioning is future work.
- v1 does not remove legacy branch-aware fallback.

### 5.6 Implementation Blueprint (Practical Path)

To avoid mixing goals, implement in three explicit passes:

1. **Graph-safe preprocessing**: parse to unified DAG (`V,E`) and compute topological `layer`, in/out degree, and supporter-role fingerprints.
1. **Mature clustering core (k-means family)**: build node feature vectors from topology (+ optional geometry), run k-means on raw features or on spectral embedding, and fix seed for deterministic assignment.
1. **Dependency-safe repair and batching**: detect cross-cluster precedence violations, repair by DAG-respecting cluster order, and cut each cluster into solver-facing batches using layer constraints.

Recommended rollout:

- v1: add a switchable `KMeansBranchClustering` while keeping `BranchAwareLayerCuttingClustering` as fallback.
- v2: add objective-based evaluation (intra-cluster coherence, cross-cluster dependency cost).

---

## 6. Cross-Task Integration Rules

1. Keep canonical generated artifacts under `generated/` and preserve existing contracts consumed by `driver.py`.
2. Any new score/heatmap artifact must be additive and backward-compatible.
3. Do not bypass Phase1 ID to scene-name mapping in `core/phase2_codegen.py`.
4. Maintain deterministic behavior by explicit seed and config logging.

## 6.1 Dev Environment Portability (Mac/Linux)

1. Method design, Python orchestration, feature engineering, and report-schema development are not deeply bound to one OS.
2. Day-to-day algorithm coding can be done on macOS and synchronized to Linux.
3. Native solver build/runtime validation should still be verified on the primary Linux machine before merge/release.
4. Keep artifacts and configs deterministic so cross-machine replay is straightforward.

---

## 7. Skill/Workflow Plan (DDE-Oriented)

- Research and method tradeoff: `dde-ext-brainstorm` workflow style.
- Validation loop: `dde-ext-verification-loop` workflow style.
- Python testing: `dde-ext-python-testing` workflow style.
- Write gate and contract safety: follow Layer 3 approval flow and roadmap lifecycle.

---

## 8. Suggested Milestones

- M1 (Spec Freeze): lock objective formulas, feature definitions, thresholds, and report schemas.
- M2 (Prototype): implement all three workstreams behind configuration flags.
- M3 (A/B Validation): compare new methods against current baseline on fixed scenarios.
- M4 (Default Switch): enable upgraded methods as defaults with fallback retained.
- M5 (Paper Sync): update method text and claims after metric-backed validation.

---

## 9. Reference Exemplars (for implementation style)

- Manipulability metric: Yoshikawa-style manipulability index and Jacobian-based dexterity measures.
- ESDF modeling: signed distance field-based collision clearance scoring (robotics mapping/planning practice).
- Clustering baseline: k-means and spectral-embedding + k-means as academic graph grouping baselines.

Note: these references define method direction; exact citation formatting will be finalized in paper editing stage.

---

## 10. Open Questions for Next Dialogue Round

1. Should Workstream A use a single global weight set or object-class-specific weights?
2. For Workstream B threshold $\tau$, do we prefer fixed global threshold first, or percentile-based adaptive threshold first?
3. For Workstream C, should default be direct k-means on engineered features or spectral embedding + k-means?
4. What is the mandatory benchmark set for A/B comparison before default switch?
