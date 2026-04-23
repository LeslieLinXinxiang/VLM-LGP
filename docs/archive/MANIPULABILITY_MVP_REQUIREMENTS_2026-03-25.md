# Manipulability MVP Requirement Report (TASK-018)

## 1. Purpose

This report defines a minimum viable implementation path for manipulability-first ordering in Phase0, with the following hard constraints:

1. Keep the current feasible/infeasible external contract unchanged.
2. Run ordering only on feasible candidates.
3. Keep same-type local ordering and current tie-break style unless explicitly replaced.
4. Add only sidecar outputs for observability/audit.

---

## 2. Problem Statement

Current ordering in Phase0 is distance-oriented within type groups. This MVP replaces the rank signal with a Jacobian-based manipulability score while preserving compatibility.

Target decision:

$$
\operatorname{rank\_key}(o) = -m(o)
$$

Unknown policy:

$$
\operatorname{status}(o)=
\begin{cases}
\operatorname{ranked}, & m(o)\ge \tau_m\\
\operatorname{unknown}, & m(o)<\tau_m \text{ or invalid}
\end{cases}
$$

Initial threshold for MVP:

$$
\tau_m = 0.08
$$

(assuming normalized score in $[0,1]$)

---

## 3. Path Dependencies (What must exist first)

### 3.1 Runtime and environment

1. Project Python runtime with repo environment variables (per repo instruction: activate `vlm_jazzy`, then source `scripts/env.sh`).
2. Reachability split remains callable before ordering (existing Phase0 flow).

### 3.2 Data dependencies

1. Input scene parse from Phase0 path (existing): `unnamed.g` or generated scene path.
2. Reachability output for feasible filtering: existing `generated/infeasible_objects.json` contract.
3. Robot model access for Jacobian evaluation (Franka Panda kinematic chain).

### 3.3 Integration dependencies

1. Phase0 orchestration in `execute_phase0()`.
2. Existing layout schema (`logical_id`, `object_type`, etc.) must remain valid.

---

## 4. References (for method grounding)

1. Yoshikawa, T. (1985). Manipulability of robotic mechanisms.
2. Siciliano et al., Robotics textbooks on Jacobian, singular values, dexterity indices.
3. Franka Panda kinematic/limit conventions (URDF + joint limits used in repo toolchain).

Notes for this MVP:

- Use Jacobian-based mature metric first (Yoshikawa family).
- Dynamic manipulability is out-of-scope for MVP.

---

## 5. Scope Boundary for MVP

In scope:

1. Compute manipulability score per feasible object candidate.
2. Replace distance-first ordering by manipulability-first ordering.
3. Write additive sidecar report.

Out of scope:

1. Any downstream API/tuple contract change.
2. Full task-level unlock planning (relocation) logic.
3. Replacing TASK-019 reachability machinery.

---

## 6. Affected Files and Functions

## 6.1 Primary files

1. [core/phase0_parser.py](../../core/phase0_parser.py)
2. [pipeline/run_phase0.py](../../pipeline/run_phase0.py)
3. Optional new module: [core/object_ordering.py](../../core/object_ordering.py)

## 6.2 Candidate function-level impact

In [core/phase0_parser.py](../../core/phase0_parser.py):

1. `build_phase0_layout_from_unnamed_g()`
   - current role: parse and type-group ordering baseline.
   - MVP change: keep parse/classify logic; move ordering policy to manipulability-aware function.

2. New helper (recommended):
   - `compute_manipulability_score_for_object(...)`
   - `rank_objects_by_manipulability(...)`

In [pipeline/run_phase0.py](../../pipeline/run_phase0.py):

1. `execute_phase0()`
   - current role: parse -> inject names -> reachability split.
   - MVP change: call ordering stage after feasible filtering and before final layout handoff, then write sidecar.

---

## 7. Input / Output Contract for MVP

## 7.1 Input

1. Phase0 layout list (existing list of objects with `logical_id`, `object_type`).
2. Feasibility report (`infeasible_objects`) from current reachability split.
3. Robot kinematic config needed to evaluate Jacobian at candidate grasp state.
4. Config:
   - `tau_m` (default 0.08)
   - deterministic seed/report flags.

## 7.2 Output

1. Existing outputs remain:
   - `generated/phase0_layout.json`
   - `generated/infeasible_objects.json`

2. New additive sidecar:
   - `generated/ordering_score_report.json`

Suggested schema:

```json
{
  "version": "v1",
  "tau_m": 0.08,
  "score_type": "yoshikawa_normalized",
  "objects": [
    {
      "logical_id": "cube_1",
      "object_type": "cube",
      "feasibility": "feasible",
      "manipulability_score": 0.62,
      "status": "ranked",
      "rank": 1,
      "reason": "score>=tau_m"
    }
  ]
}
```

---

## 8. Implementation Plan (MVP)

### Step A — Keep parse and feasibility unchanged

Do not touch object extraction/classification contracts.

### Step B — Build feasible candidate pool

From layout list, exclude logical IDs present in `infeasible_objects`.

### Step C — Compute manipulability score

For each feasible candidate `o`:

1. build candidate grasp query state,
2. evaluate Jacobian `J(q)` at selected pose/IK solution,
3. compute raw score:

$$
m_{raw}(o)=\sqrt{\det(JJ^\top)}
$$

1. normalize into $[0,1]$ over current candidate set.

### Step D — Threshold and rank

1. assign `status=unknown` if score invalid or `< tau_m`.
2. ranked subset sorted by descending score.
3. unknown subset appended at tail (deterministic order preserves current tie-break style).

### Step E — Emit sidecar and keep compatibility

1. write `ordering_score_report.json`.
2. keep existing feasible/infeasible data flow unchanged.

---

## 9. Minimal Test Plan (Run-through on existing inputs)

## 9.1 Test objective

Validate that the new ordering logic runs end-to-end on existing repository inputs and generates deterministic sidecar output.

## 9.2 Minimal test data

Use existing input path first (no synthetic scene required):

1. `unnamed.g` (repo root) or `generated/scene/unnamed.g`
2. Existing Phase0 flow via `execute_phase0()`

## 9.3 Pass criteria

1. Phase0 completes successfully.
2. `generated/ordering_score_report.json` is created.
3. Feasible/infeasible external files remain unchanged in schema.
4. Repeated run with fixed seed yields same rank order.
5. At least one known test case shows different rank than distance baseline.

## 9.4 Suggested unit checks

1. Score function sanity:
   - valid Jacobian -> finite score.
   - singular-like case -> low score.
2. Threshold behavior:
   - score `< tau_m` -> `unknown`.
3. ordering invariants:
   - all `ranked` before `unknown`.
   - unknown tail order deterministic.

---

## 10. Risks and Mitigations

1. IK/Jacobian evaluation instability for some objects.
   - Mitigation: fallback to `unknown` with explicit reason logging.

2. Score scale drift across scenes.
   - Mitigation: per-scene normalization + logged `tau_m`.

3. Runtime overhead.
   - Mitigation: cache repeated kinematics calls and keep MVP at single-candidate evaluation per object.

---

## 11. Deliverables Checklist (MVP)

1. Manipulability ranking implementation behind config flag.
2. Sidecar audit file in `generated/`.
3. Minimal tests (unit + one pipeline run-through).
4. Short benchmark note comparing old distance rank vs new rank on one fixed scene.

---

## 12. Definition of Done

MVP is done when:

1. Phase0 runs on existing scene input without breaking current contracts.
2. Ranking is manipulability-first for feasible candidates.
3. Unknown threshold policy is enforced and logged.
4. Sidecar report is reproducible and reviewable.
