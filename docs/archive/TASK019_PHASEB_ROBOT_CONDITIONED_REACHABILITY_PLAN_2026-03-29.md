# TASK-019 Phase-B Plan: Robot-Conditioned Differentiable Reachability

- Date: 2026-03-29
- Task: TASK-019 (reopened)
- Goal: Upgrade from geometry-only pre-score to robot-conditioned, constraint-consistent differentiable reachability

---

## 0) Executive Summary

Current MVP (`GMM + ESDF`) is useful as a **pre-filter / ranking prior**, but it is **not a proof of executable reachability** because it does not encode full robot constraints (joint limits, self-collision, IK feasibility, singularity margin, approach orientation constraints).

Phase-B target:
1. Learn a differentiable function `f_R(x)` from **Franka-conditioned labels**.
2. Use `f_R(x) >= 0` as **hard reachability gate**.
3. Keep current `GMM + ESDF` as **soft ranking** within feasible candidates.

This aligns with first principles and with the Murooka 2025 style of model-conditioned differentiable reachability.

---

## 1) What is Kernel Density (KDE/GMM score) and what it can/cannot do

## 1.1 Kernel density idea
Given points `x_1,...,x_N` in task space, kernel density at `x` is:

\[
\hat p(x)=\frac{1}{N}\sum_{i=1}^N K_\sigma(x-x_i), \quad
K_\sigma(\Delta)=\exp\left(-\frac{\|\Delta\|^2}{2\sigma^2}\right)
\]

Intuition:
- high value: `x` lies in a dense region of samples;
- low value: `x` lies in sparse/outlier region.

Current implementation computes this type of score over per-object sample points in the current scene.

## 1.2 Why people sometimes use it for reachability priors
If samples are generated from known feasible robot end-effector poses, density can correlate with “often feasible” zones. This is a **statistical prior**, not a hard feasibility certificate.

## 1.3 Why KDE alone cannot validate reachability
Density does not encode full constraints by itself:

- joint limits;
- self-collision;
- approach orientation and gripper alignment constraints;
- path/connectivity from current robot state.

Therefore, KDE/GMM can rank candidates, but cannot prove `IK/KOMO` feasibility for a specific robot state and constraint set.

## 1.4 In current TASK-019 MVP

- `gmm_score`: geometric-statistical prior over object sample points;
- `esdf_score`: obstacle clearance proxy;
- fused score ranks/selects candidates.

This is useful for pruning and ordering but must be paired with robot-conditioned gate.

## 1.5 Current MVP boundary (explicit)

Current `gmm_score` in the repository is computed from object sample points (`handle`/`center`) only.
It does **not** include robot state constraints such as:

- joint limits;
- link-length/posture realizability in joint space;
- singularity or near-singularity penalties;
- full-body collision at a specific joint configuration.

Therefore, current `reachability_score` should be interpreted as a **geometry prior score**, not a final executable feasibility proof.

## 1.6 Meaning of "statistical density prior"

In this context, "statistical density prior" means:

- we estimate where candidate points are concentrated in task space;
- denser regions get higher `gmm_score`;
- sparse/outlier regions get lower `gmm_score`.

This answers "where is common/typical in current sample distribution".
It does **not** answer "is this robot posture awkward/unreachable" unless the sample set itself is generated under robot constraints.

---

## 1.7 If the final goal is true reachability, how to inject joint/singularity/posture constraints

To use GMM for **reachability-oriented** computation (not just geometric prior), build it on robot-conditioned samples:

1. Define task-space target `x` (position + required end-effector orientation constraints).
2. For each `x`, solve IK (KOMO optional, not mandatory).
3. Keep sample only if all hard checks pass:
   - joint limits satisfied;
   - self-collision clear;
   - environment collision clear at the checked frame;
   - posture/singularity quality above threshold (e.g., min singular value or manipulability floor).
4. Build GMM from this filtered feasible sample set.

Then `gmm_score` has a clearer reachability meaning:

- high score = near frequently feasible robot-conditioned poses;
- low score = far from feasible manifold.

Recommended runtime decomposition remains:

- Hard gate: IK + constraints + collision;
- Soft rank: conditioned `gmm_score` (+ optional ESDF/margin/manipulability terms).

---

## 2) Reachability check: proper layered definition

We define two layers:

1. **Feasibility layer (hard):**
   - robot-conditioned and constraint-consistent;
   - outputs `feasible / infeasible` for each candidate;
   - must be conservative (avoid false feasible).

2. **Preference layer (soft):**
   - ranks only feasible candidates;
   - can use `GMM + ESDF` and manipulability.

Formalized:

\[
\text{HardFeasible}(x)=\mathbf{1}[f_R(x)\ge 0 \land \text{env/path checks pass}]
\]

\[
\text{RankScore}(x)=w_g s_{gmm}(x)+w_e s_{esdf}(x)+w_m s_{mani}(x)
\]

Only if `HardFeasible=1` does `RankScore` matter.

---

## 3) Phase-B Full Technical Plan (robot-conditioned differentiable function)

## 3.1 Input space definition (`x`)
Use task-space features tied to Franka setup:
- end-effector relative position to `l_panda_base`: `(dx,dy,dz)`;
- end-effector orientation representation (rotation matrix components or reduced parameterization);
- optional context features: gripper approach axis, object type code.

Recommended initial version:
- position-only model for robustness + speed;
- orientation-aware extension in v2.

## 3.2 Label generation (`y`) from robot constraints
For each sampled target pose `x`:
- solve IK/KOMO with current action constraints (consistent with `action_pick` / `action_pick_cylinder`);
- enforce:
  - joint limits;
  - self-collision constraints;
  - required gripper orientation constraints;
  - minimum clearance margin.

Labeling rule:
- `y = +1` if solver finds feasible solution within tolerance;
- `y = -1` otherwise.

Optional continuous margin label:
- `m(x)` = signed residual margin (positive feasible margin, negative violation), for calibration and debugging.

## 3.3 Sampling strategy
Avoid naive full-grid in high dimensions.

Use mixed strategy:
1. broad random sampling in bounded workspace;
2. boundary-focused active sampling near decision surface (`|f_R(x)|` small or solver near-fail);
3. hard-negative mining from failure cases observed in real runs.

Dataset split:
- train/val/test by scene and pose bins to avoid leakage.

## 3.4 Model choice for differentiable `f_R`
Two practical options:

A) MLP classifier (recommended first)
- input: `x`;
- output scalar `f_R(x)`;
- decision: `f_R(x) >= 0`;
- loss: softplus/logistic hinge style.

B) RBF-SVM decision function
- differentiable in input;
- harder scaling in high-dimensional settings.

Recommendation for this repo: start with MLP (faster inference and easier retraining).

## 3.5 Training objective and calibration
Base loss:

\[
\mathcal{L}_{cls}=\operatorname{softplus}(-y\,f_R(x))
\]

Class imbalance handling:
- weighted loss or focal term.

Calibration:
- fit threshold `tau_f` on validation set to minimize false-feasible under target recall.
- store calibration metadata in model artifact.

## 3.6 Runtime usage in Phase0
For each object candidate point `x_obj`:
1. compute `f_R(x_obj)`;
2. hard gate: reject if `f_R(x_obj) < tau_f`;
3. for remaining candidates, compute `GMM+ESDF` rank score;
4. optional final policy gate via current checker for strict safety.

Output should expose:

- `fR_score`;
- `hard_feasible`;
- `hard_reject_reason`;
- rank score components.

## 3.7 Environment/obstacle handling

Important separation:

- robot-conditioned reachability model mostly captures intrinsic kinematic feasibility;
- obstacle-dependent feasibility should be checked online (ESDF/collision/path).

Thus runtime hard gate should be:

\[
\text{HardFeasible}=\mathbf{1}[f_R(x)\ge \tau_f] \land \mathbf{1}[\text{clearance/path ok}]
\]

This directly addresses cases where obstacle blocks approach corridor near robot even if object point seems open.

## 3.8 No-KOMO static grasp-frame checker (GMM + volume-level ESDF)

User requirement in this phase: no KOMO-based optimization; only evaluate whether the robot would collide at the target grasp frame.

Reference logic (aligned with robo-centric ESDF style in arXiv:2306.16046):

- build/query ESDF efficiently;
- evaluate collision using robot body geometry, not a single point;
- use minimum signed distance as safety metric.

### Inputs

1. Target grasp frame (from GMM-ranked candidate).
2. One robot joint state candidate `q` corresponding to that grasp frame.
3. Environment ESDF map.
4. Robot collision proxy geometry (sphere set / capsules / mesh samples per link).

### Core evaluation at one frame

For each sampled body point `p_j(q)` on robot links (including gripper), query ESDF:

\[
d_j = \text{ESDF}(p_j(q))
\]

Aggregate whole-body clearance:

\[
d_{\min}(q)=\min_j d_j
\]

Static collision decision:

- collision if `d_min(q) < 0`;
- safety margin satisfied if `d_min(q) >= d_safe`.

Optional smooth penalty:

\[
\phi_{coll}(q)=\sum_j \operatorname{softplus}(d_{safe}-d_j)
\]

### How to combine with GMM (without KOMO)

1. Use GMM as candidate prior/ranker for grasp targets.
2. For top-K candidates, obtain/lookup corresponding joint candidates `q` (from IK cache, nearest-neighbor reachable library, or lightweight IK solver not using KOMO).
3. Run volume-level ESDF whole-body collision check at the grasp frame.
4. Keep only candidates passing `d_min >= d_safe`.
5. Rank survivors by `GMM` (or `GMM + clearance bonus`).

This keeps semantics clean:

- GMM: preference prior;
- ESDF volume check: frame-level collision feasibility.

### What this catches that point-ESDF misses

- obstacle close to robot base/links but far from object center;
- tall/wide barriers intersecting arm links while end-effector point remains free;
- non-convex robot shape effects approximated via many body samples.

### Limits of this no-KOMO static check

- checks a single frame, not transition path connectivity;
- quality depends on body geometry approximation density;
- still requires a valid `q` candidate for each grasp frame.

### Immediate acceptance tests

1. Far target + near-base wall case must be rejected if any link penetrates obstacle (`d_min < 0`).
2. Same target with wall removed must pass if `d_min >= d_safe`.
3. Increase obstacle height from low to high should monotonically reduce pass rate for blocked-side targets.
4. Compared with point-only ESDF baseline, false-feasible cases should decrease.

---

## 4) Code Integration Plan (repo-specific)

## 4.1 New modules

1. `core/reachability_training_dataset.py`
   - pose sampler;
   - IK/KOMO labeling interface;
   - dataset export (`.npz`/`.jsonl`).

2. `core/reachability_model.py`
   - MLP model definition;
   - inference utility `predict_fR(x)`.

3. `scripts/train_reachability_model.py`
   - train/val/test;
   - metrics and calibration;
   - save artifact under `generated/reachability_model/`.

4. `scripts/eval_reachability_model.py`
   - confusion matrix;
   - ROC/PR;
   - boundary error analysis.

## 4.2 Existing modules to modify

1. `core/phase0_parser.py`
   - insert hard gate call before rank scoring;
   - keep compatibility output format.

2. `core/reachability_field.py`
   - demote current score to ranking helper;
   - include `fR_score` integration hook.

3. `pipeline/run_phase0.py`
   - add config flags:
     - `reachability_hard_gate_mode`;
     - `reachability_model_path`;
     - `reachability_gate_threshold`.

## 4.3 Artifact contracts

- model: `generated/reachability_model/model.pt`;
- calibration: `generated/reachability_model/calibration.json`;
- training report: `generated/reachability_model/train_report.json`;
- runtime score report extends existing schema with `fR_score`, `hard_gate` fields.

---

## 5) Validation and acceptance criteria

## 5.1 Model-level

- balanced accuracy / F1 on held-out set;
- false-feasible rate below target threshold;
- calibration curve within tolerance.

## 5.2 Pipeline-level

- hard gate rejects known unreachable far targets;
- obstacle-near-robot blocking cases correctly rejected by clearance/path checks;
- downstream planning success improves or stays stable.

## 5.3 Regression safety

- legacy `generated/infeasible_objects.json` remains consumable;
- if model artifact missing, fallback mode explicit and logged.

---

## 6) Why this resolves current conceptual gap

Current gap: geometric density/clearance may rate a point high even when robot cannot physically realize grasp.

Phase-B fix:

- hard gate learned from robot-constrained labels captures “can the robot actually realize this pose under constraints?”;
- soft scores still useful for efficiency and prioritization among feasible options.

So the method is no longer “naive geometry-only score,” but a layered architecture with clear semantics.

---

## 7) Milestones

M1: dataset and labeler

- implement sampler + IK/KOMO labeling;
- generate first train/val split.

M2: differentiable model

- train MLP classifier;
- produce calibrated threshold.

M3: Phase0 hard gate integration

- wire inference and decision fields;
- keep backward compatibility.

M4: benchmark and closure

- run obstacle/far-target/real-scene regressions;
- freeze config profile;
- prepare merge notes.

---

## 8) Immediate next action list

1. lock feature definition of `x` (position-only v1).
2. implement `reachability_training_dataset.py` with IK/KOMO labeling bridge.
3. generate first labeled dataset and baseline MLP model.
4. integrate hard gate into Phase0 and rerun existing obstacle tests.

---

## 9) Final note

KDE/GMM is not wrong; it is just not a complete feasibility oracle.
Use it where it is strongest (prior/ranking), and put robot-conditioned constraints into the hard gate. This is the correct decomposition for practical optimization pipelines.
