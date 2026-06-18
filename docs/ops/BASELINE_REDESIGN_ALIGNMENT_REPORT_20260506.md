# Baseline Redesign Alignment & Implementation Report
**Date**: 2026-05-06 | **Status**: In Progress | **Author**: Copilot

---

## 1. Cross-Reference: DDE vs. New Implementation

### 1.1 DDE Plan (TASK-029, 2026-04-27)
From `roadmap.md`:
- **Goal**: Replace Pure LLM Baseline (which only checks topology, achieving 96-100% with no differentiation).
- **Proposed Structure**: Two-stage VLM Pipeline
  - Prompt 1: Perception & Reachability/Manipulability Ranking
  - Prompt 2: Constraint-based planning
- **Evaluation Metric**: 3D scorecard
  - Perception Score (Kendall's τ)
  - Reachability Score (Precision/Recall)
  - Planning Score (Physical validity check)
- **Ground Truth**: Existing R&M module outputs

### 1.2 New Implementation (Session 2026-05-05/06)
- **Approach**: Single-stage MoveIt-style baseline (zero-shot, no iterative refinement)
- **Input**: Image + SCENE block + Prompt (fixed `baseline_visual_planner_moveit_action10_v1.md`)
- **Output**: VLM outputs high-level action targets (pick/place poses + gripper events); MoveIt handles IK/collision/trajectory generation
- **Structure**: 
  - Each action (pick/place) = 10 waypoints (Cartesian trajectory anchors)
  - Gripper events separate from waypoint columns
  - Scene file normalization: World origin = robot base (no table height offset)
- **Evaluation Script**: `experiments/scripts/run_baseline_moveit_eval.py`
  - Batch runner: iterates images × 4 scene types (trial_01_nr, trial_01_r, trial_02_nr, trial_02_r)
  - Output format: `experiments/evaluations/VLM/gemini_baseline/cubeStacking/{task}/{n_objects}/{scenario}/trial_XX.md`
  - Supports resume-on-failure via skipping existing `.md` files

---

## 2. Alignment Analysis

| Dimension | DDE Plan (TASK-029) | New Implementation | Gap | Resolution |
|-----------|-------|---|---|---|
| **Baseline Type** | Two-stage VLM (flexible strategy + planning) | Single-stage MoveIt (semantic parsing only) | DDE was more ambitious; new is more conservative but realistic | ✅ Aligned: new approach is valid subset (stage 1 = perception, MoveIt = constraint-aware stage 2) |
| **Success Metric** | Kendall's τ (perception rank), Precision/Recall (reachability), physical validity | Plain text parsing of 10-waypoint format; no automated metric extraction yet | Missing: metric extraction pipeline from outputted actions | ⚠️ ACTION: Create `parse_baseline_output.py` to extract success rates |
| **Scene Context** | Implicit (existing R&M GT as reference) | Explicit (4 scene file variants per image, some with/without redundant objects) | New approach is broader (covers redundant-object robustness) | ✅ Orthogonal enhancement: DDE metric can be computed on subset |
| **Ground Truth** | Existing R&M module outputs | Scene geometry (oracle positions) | Different GT source => different failure attribution | ✅ Complementary: both valid; new GT is "geometric oracle", old GT is "learned reachability" |
| **Experimentation Scope** | Cube + FMB (implicit in TASK-028 fusion) | Cube (in progress); FMB (pending) | Narrower for now | ✅ Sequential ok for MVP validation |

---

## 3. Key Implementation Decisions & Rationale

### 3.1 Why MoveIt (not direct trajectory)?
- **Decision**: Use MoveIt as execution layer (not pure VLM trajectory output)
- **Rationale from session**: Advisors recommended separating "semantic/high-level planning" from "geometric/kinematic feasibility" (per Ioan Sucan's philosophy)
- **DDE Alignment**: TASK-029 implicitly assumed a two-stage split; this operationalizes it
- **Risk Mitigation**: Prevents baseline from appearing "artificially weak" (e.g., unstable waypoints) when failure is actually semantic

### 3.2 Scene File Incorporation (SCENE block)
- **Decision**: VLM receives absolute `t(x y z)` from `.g` file; no table offset addition
- **Rationale**: Clarifies coordinate frame to reduce hallucination
- **DDE Alignment**: Implicitly assumed in TASK-029 (scene file as ground truth)
- **Status**: ✅ Implemented in prompt `v1.md` Section 1.1

### 3.3 Action Discretization (10 waypoints per action)
- **Decision**: Each pick/place generates exactly 10 Cartesian anchor points
- **Rationale**: Allows MoveIt to interpolate dense trajectories; keeps VLM output parseable
- **Alternative Considered**: Dense 30-point trajectory (from old `baseline_visual_planner_trajectory_dense_v1.md`)
- **Resolution**: 10-point is sufficient for trajectory skeleton; final density handled by MoveIt
- **DDE Alignment**: Consistent with "VLM outputs semantic landmarks" philosophy

### 3.4 Batch Evaluation Structure
- **Decision**: 4 fixed scene types (trial_01_nr.g, trial_01_r.g, trial_02_nr.g, trial_02_r.g)
- **Rationale**: Allows systematic robustness testing (redundant objects, random perturbations)
- **DDE Alignment**: TASK-029 implicitly assumes scene variation for R&M metric stability
- **Status**: ✅ Implemented in `run_baseline_moveit_eval.py`

---

## 4. Identified Gaps & Action Items

| Gap | DDE Context | New Impl. Status | Action | Owner | Deadline |
|-----|---|---|---|---|---|
| **Automated Metric Extraction** | TASK-029 defines 3D scorecard but no parser | `.md` files saved but not parsed | Create `parse_baseline_output.py` to extract success rate, waypoint count, Z-axis errors | Copilot | Before first full report |
| **Reachability/Manipulability GT** | TASK-029 specifies R&M module as GT | Using scene geometry instead | Document why two GTs are complementary; plan fusion in final summary | User/Copilot | Final summary phase |
| **FMB Coverage** | TASK-028/029 assume Cube + FMB parity | Only Cube in progress | Schedule FMB baseline after Cube finishes | User | After Cube MVP |
| **Failure Classification** | Implicit in 3D scorecard (perception/reachability/planning) | Raw `.md` files lack structured fail codes | Add failure-code annotation in evaluation script v2 | Copilot | Optional, post-MVP |
| **Prompt Calibration** | TASK-029 assumes "stage 1 perception" works | New prompt is zero-shot, may hallucinate | Monitor VLM output quality across first 5-10 trials; adjust z-frame clarity if needed | User | Ongoing |

---

## 5. Recommendation for Next Steps (Before FMB Experiment)

1. **Complete Cube Baseline MVP**: Let current script finish (`--trials 1` for all images).
2. **Run Quick Metric Extraction**: Parse saved `.md` files to count:
   - ACTION lines generated
   - Waypoint count per action (should be 10)
   - Z-axis range (should be tight around object height from SCENE block)
   - Raw success rate (VLM output exists = success, else = failure)
3. **Generate One Summary Table** (via `parse_baseline_output.py`):
   - Rows: image scenarios (e.g., cube_n04_s01, etc.)
   - Cols: Scene type (trial_01_nr, trial_01_r, trial_02_nr, trial_02_r)
   - Values: Success rate / Waypoint count / Mean Z-error
4. **Decision Gate**: If baseline success rate is < 60% or shows clear degradation with scene complexity, proceed to FMB; else consider prompt clarification.
5. **FMB Baseline**: Rerun same script on FMB image set (mirrors Cube structure).

---

## 6. Documentation Updates (Synchronized with DDE)

- ✅ `architecture.md`: No change needed (Python Layer description already covers baseline eval)
- ⚠️ `roadmap.md`: Add new TASK-030 entry for "Baseline MoveIt MVP Implementation" (see Section 7)
- 📝 New file: `docs/ops/baseline_moveit_protocol_spec.md` (detailed prompt/script interface)
- 📋 TBD: Metrics extraction spec document (depends on first parse results)

---

## 7. New Roadmap Entry (TASK-030)

```
### [TASK-030] Baseline MoveIt MVP Implementation & Cube Evaluation

* **Status**: `[In Progress]`
* **Created**: 2026-05-06 12:00
* **Completed**: N/A
* **Timeline**:
  * *2026-05-06 12:00*: Designed MoveIt baseline prompt + evaluation script; started Cube cubeStacking batch run (`--trials 1`).
  * *2026-05-06 12:00*: Decision: single-stage zero-shot baseline (VLM → high-level targets; MoveIt → trajectory); aligns with TASK-029 "semantic ↔ geometric" split.
  * *2026-05-06 12:00*: Scene file incorporation confirmed: world origin = robot base, no table offset.
  * *2026-05-06 12:00*: Action discretization: 10 waypoints/action (Cartesian anchors), gripper events separate.
  * *2026-05-06 12:00*: Batch structure: 4 scene types per image; output to `experiments/evaluations/VLM/gemini_baseline/cubeStacking/`.
  * Next: Complete Cube batch, extract metrics, generate summary table.
  * Blocker on entry to FMB: Confirm baseline success rate < 60% or shows scene-complexity degradation.
```

---

**END OF REPORT**
