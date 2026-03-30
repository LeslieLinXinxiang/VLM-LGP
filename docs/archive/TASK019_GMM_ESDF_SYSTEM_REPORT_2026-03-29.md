# TASK-019 Detailed System Report (GMM + ESDF Reachability)

- Task ID: TASK-019
- Date: 2026-03-29
- Status: Completed (MVP scope)
- Branch: `dev/GMM+ESDF`
- Scope baseline: unnamed.g-only external input, Phase0 integration, backward compatibility with `generated/infeasible_objects.json`

---

## 1. Purpose and Positioning

This module replaces pure object-by-object binary engineering checks with a continuous reachability scoring path in Phase0, while keeping compatibility with legacy consumers.

Primary goals:
1. Produce a continuous score for each object grasp sample point.
2. Keep thresholded feasible/infeasible split for downstream pipeline compatibility.
3. Preserve optional policy consistency with existing KOMO waypoint checks.
4. Keep single external input contract (`unnamed.g`).

---

## 2. What "Reachability" Means Here

For each object candidate:
- A sample point is selected:
  - preferred: object child frame containing `handle` in name;
  - fallback: object center.
- Two components are computed:
  - `gmm_score`: empirical prior density over all object sample points in current scene.
  - `esdf_score`: clearance-like score from distance to detected obstacle proxies.
- Final score:

\[
R = \alpha \cdot G + \beta \cdot E
\]

where:
- `G = gmm_score`,
- `E = esdf_score`,
- threshold `tau_r` yields feasible/infeasible decision.

---

## 3. Franka Usage Clarification

### 3.1 In default TASK-019 field-only mode
No direct Franka dynamics/kinematics solving is executed during scoring itself.
- The field score path is geometric/statistical and scene-driven.
- Inputs are parsed from scene frames in `.g` files.

### 3.2 Optional policy gate mode (KOMO alignment)
When `use_komo_policy_gate=True`, the system runs the existing pick waypoint checker per object and merges policy infeasible outcomes into final decision.

This path uses:
- Panda/Franka scene setup from named scene (`l_panda_*`, `l_gripper`).
- Existing solver/binary checker (`bin/pick_waypoint_check.exe`) invoked by `test/reachability/run_pick_waypoint_check.py`.
- Constraint policy defined by manip tools (`action_pick`, `action_pick_cylinder`) in `rai/src/KOMO/manipTools.cpp`.

Hence, Franka-related information is used in policy gate mode, not in pure field-score computation.

---

## 4. Algorithm Design (Principle -> Formula -> Decision)

### 4.1 Sample point extraction
For each layout object:
1. map `logical_id` -> `anon_id` (`obj_XX`)
2. world position from parent-chain transform accumulation
3. sample source:
   - handle marker if present
   - otherwise object center

### 4.2 GMM empirical prior term
Given object sample points \(x_i\), compute pairwise Gaussian kernel:

\[
K_{ij} = \exp\left(-\frac{\|x_i-x_j\|^2}{2\sigma^2}\right)
\]

Absolute density-like score:

\[
G_i = \frac{1}{N}\sum_{j=1}^{N}K_{ij}
\]

Current implementation uses absolute kernel density (not min-max relative normalization) to avoid forcing minimum object to 0.

### 4.3 ESDF-like clearance term
For each sample point \(x\), obstacle proxies \((c_k, r_k)\):

\[
d_k = \|x-c_k\| - r_k, \quad d_{\min}=\min_k d_k
\]

Saturated normalized clearance:

\[
E = \frac{\operatorname{clip}(d_{\min}, 0, d_{cap})}{d_{cap}}
\]

Current \(d_{cap}=0.20\,m\).

### 4.4 Fusion and thresholding

\[
R = \alpha G + \beta E
\]

Decision:
- feasible if \(R \ge \tau_r\)
- infeasible otherwise

Policy gate (optional): if KOMO checker says infeasible, final decision is forced infeasible.

---

## 5. Data and I/O Contracts

## 5.1 Inputs
- External required input: `unnamed.g`
- Internal generated input for policy gate: `generated/scene/scene_named.g`
- Parsed frame metadata: name, parent, `Q:t(x y z)`, logical flags, shape, size, contact

## 5.2 Outputs
1. Legacy-compatible split report:
   - `generated/infeasible_objects.json`
2. Extended score report:
   - `generated/reachability_score_report.json`

Additional run-specific outputs used in tests:
- `generated/reachability_score_report_obstacle1.json`
- `generated/infeasible_objects_obstacle1.json`

### 5.3 Output schema highlights
Each object row includes:
- ids (`logical_id`, `anon_id`)
- `sample_point_source`, `sample_point_xyz`
- `gmm_score`, `esdf_score`, `reachability_score`
- `threshold`, `decision`, `reason`

Root-level metadata includes:
- params (`alpha`, `beta`, `tau_r`, `seed`, `gmm_sigma`, `gmm_score_mode`)
- `obstacle_count`
- `policy_gate` status block

---

## 6. Code Landing Map

### 6.1 Core scoring engine
- `core/reachability_field.py`
  - scene frame parser
  - world transform accumulation
  - obstacle detection by naming/flags
  - GMM score, ESDF score, fusion score

### 6.2 Phase0 integration and compatibility layer
- `core/phase0_parser.py`
  - `split_infeasible_objects_from_reachability_field(...)`
  - optional KOMO policy gate merge
  - backward-compatible infeasible dictionary generation

### 6.3 Orchestrator entrypoint
- `pipeline/run_phase0.py`
  - `reachability_mode="gmm_esdf_mvp"`
  - config params (`alpha`, `beta`, `tau_r`, `seed`, gate flag)
  - score report sidecar write path

### 6.4 Testing utilities
- `test/reachability/run_reachability_field_minimal_test.py`
  - one-command smoke runner
- `test/reachability/unnamed_with_obstacle_1.g`
  - obstacle stress scene (`obstacle_1` naming convention)
- `test/reachability/visualize_reachability_report.py`
  - XY + bar + component-space plots

### 6.5 Existing policy checker (reused)
- `test/reachability/run_pick_waypoint_check.py`
- `bin/pick_waypoint_check.exe`
- `rai/src/KOMO/manipTools.cpp`

---

## 7. Testing Strategy and Acceptance Criteria

## 7.1 Minimal smoke acceptance
- command completes without exception
- score report generated
- per-object decision count is internally consistent

## 7.2 Obstacle scene acceptance
In obstacle stress scene:
- right cluster under obstacle should exhibit low ESDF score
- left cluster away from obstacle should retain high ESDF score
- final feasible/infeasible split should reflect obstacle asymmetry

## 7.3 Compatibility acceptance
- `generated/infeasible_objects.json` remains consumable by downstream pipeline
- no change required in existing reader code for legacy infeasible format

## 7.4 Policy gate acceptance (when enabled)
- if policy checker marks object infeasible, final decision must be infeasible regardless of fused score

---

## 8. Usage Guide

## 8.1 Quick run (field-only)
Use minimal test script with KOMO gate disabled:
- input: `unnamed.g` or custom test scene
- output: score report + infeasible report

## 8.2 Gate-aligned run
Enable policy gate (default in script unless disabled flag passed) to enforce consistency with existing pick constraints.

## 8.3 Parameter tuning recommendations
- `alpha`, `beta`: prior-vs-clearance balance
- `tau_r`: strictness of feasibility split
- `d_cap` (code-level): ESDF saturation range
- `gmm_sigma`: locality scale in empirical prior

Suggested tuning protocol:
1. lock representative scene set
2. grid-search `(alpha,beta,tau_r)`
3. evaluate mismatch vs policy gate and downstream solve success
4. freeze profile and document per benchmark family

---

## 9. Known Limitations

1. ESDF is proxy-based (obstacle center + radius), not full signed distance field over exact meshes.
2. Obstacle classification currently relies on naming/logical heuristics.
3. Continuous ESDF may appear near-binary when scene geometry causes saturation at 0 or 1.
4. Field score itself does not solve full robot kinematics; policy gate should be kept for strict safety alignment.

---

## 10. Integration Plan to Mainline

Recommended merge path:
1. Keep current MVP as `reachability_mode` option (already done).
2. Add benchmark profile config presets for common scene families.
3. Introduce richer obstacle extraction (mesh-aware distance where needed).
4. Add regression suite:
   - baseline scene
   - obstacle scene
   - near-boundary clearance scene
5. Track KPI:
   - false-feasible/false-infeasible vs policy gate
   - downstream solve success rate
   - runtime overhead in Phase0

---

## 11. Reproducibility Checklist

- [x] single external input (`unnamed.g`)
- [x] deterministic seed exposed
- [x] report files preserved under `generated/`
- [x] obstacle stress test file included
- [x] visualization script included
- [x] roadmap entry updated to closed state

---

## 12. Recommended Reading Order for Fast Onboarding

1. This report
2. `docs/ops/TASK019_EXECUTION_PLAN_UNNAMEDG_ONLY_2026-03-29.md`
3. `docs/ops/TASK019_MINIMAL_TEST_MODIFICATION_REPORT_2026-03-29.md`
4. `core/reachability_field.py`
5. `core/phase0_parser.py`
6. `pipeline/run_phase0.py`
7. `test/reachability/run_reachability_field_minimal_test.py`
8. `test/reachability/visualize_reachability_report.py`

---

## 13. Final Closure Statement

TASK-019 MVP objectives are met:
- differentiable-like continuous scoring path integrated,
- compatibility maintained,
- obstacle stress test and visualization utilities delivered,
- optional policy alignment retained for Franka/KOMO consistency.
