# CLAUDE.md — Working State

This file is the cross-session/cross-device handoff record for this repo. Read it at the
start of a new session (on any machine) to pick up where the last session left off.
Update it before ending a work session — append or revise, don't just delete history that
might still be relevant next time.

---

## Current phase: VLM-MSGraph baseline (Track 1 done, Track 2 next)

Full design/rationale lives in
[docs/ops/VLM_MSGRAPH_BASELINE_EXPERIMENT_DESIGN_2026-08-16.md](docs/ops/VLM_MSGRAPH_BASELINE_EXPERIMENT_DESIGN_2026-08-16.md)
— read that first for the *why* behind every decision below. This file only tracks *where
things stand*.

### Done: Track 1 (semantic/matching layer accuracy)

- Prompt [prompts/baseline_vlm_msgraph_style_v1.md](prompts/baseline_vlm_msgraph_style_v1.md)
  is schema-locked and debugged over several rounds against real VLM output (Gemini 3 Flash
  Preview via API, billing enabled).
- Pipeline: `experiments/scripts/{run_vlm_msgraph_baseline_api,
  validate_baseline_vlm_msgraph_format, build_vlm_msgraph_review_index,
  review_vlm_msgraph_scores, diff_vlm_msgraph_trial_vs_reference,
  analyse_vlm_msgraph_manual_scores, visualize_vlm_msgraph_manual_scores}.py`.
- Data: 2 trials × 40 non-redundant scenarios (8 configs × 5 scenarios) under
  `experiments/evaluations/VLM/VLM-MSGraph_baseline/`. Manually graded via the matplotlib
  GUI scorer against the actual input images (not just topology-plausibility).
- **Current pooled content accuracy** (`experiments/outputs/VLM-MSGraph_baseline/accuracy_analysis/`):
  - cubeStacking: **92.0%** (46/50), Wilson 95% CI [81.2%, 96.8%]
  - FMB: **46.7%** (14/30), Wilson 95% CI [30.2%, 63.9%]
  - Format compliance: 100% both benchmarks (separate GT-free schema metric, don't conflate
    with content accuracy — see the report's own caveat).
- Pushed to `writing_paper` at commit `c42e5c27`.
- **Known open item, deliberately left alone**: `cubeStacking/4cubes/cube_n04_s03` —
  trial_01/trial_02 both describe a flat 4-cube layout, but two independent verification
  reruns (trial_03/trial_04, since deleted) both reproduced a "left/right base, each
  stacked one more cube on top" structure instead. The user re-marked trial_01/02 as
  "correct" in the GUI regardless and explicitly said to leave this alone for now. If this
  resurfaces, don't silently "fix" it — the prior investigation is in this conversation's
  history, not in a file, so ask before touching those two scores again.
- Also fixed along the way: `cubeStacking/8cubes/cube_n08_s04/trial_01` was downgraded from
  correct to wrong after a stricter re-audit (it invented a "RectPrism" object name that
  doesn't exist in that scene's part list — pixel measurement confirmed both bars are
  identical-width Long RectPrism instances, so it should have said `Long RectPrism_2`).

### Next: Track 2 (execution-layer feasibility) — to run on Ubuntu

Per the design doc §4 Track 2 and its guardrails:

- **Reuse our own method's existing scene files and task assignment as-is** — do NOT
  generate new scenes for the baseline. Guardrail #1: both methods must run on *the exact
  same scene files* per scenario, no separate easier/harder set for either side.
- Task assignment (which object, from which pose, to which pose, in which step order) is
  **externally given**, sourced from our own method's/ground-truth output — the baseline's
  own upstream reasoning does not determine this for Track 2. This sidesteps the Track 1
  redundant-object limitation entirely (see design doc §3).
- **Only the trajectory-generation step differs**: swap our LGP constrained optimization
  for the paper's **Eq. 7 naive straight-line interpolation** (reorient in place → 4-step
  decelerating interpolation `P+0.8T, +0.92T, +0.96T, +T` → gripper open/close, applied once
  for pick and once for place). No collision checking, no joint-limit checking, no
  lift/transit/descend decomposition — that absence is the point being tested.
- Implementation decision already recorded in the design doc (§2): treat `T` as the full
  displacement from the gripper's actual current position, applying Eq.7 across the whole
  motion (most literal reading of the paper; also maximizes exposure of the
  no-collision-avoidance property).
- Full matrix: `benchmark ∈ {cube, fmb}` × `task_size_n` (cube 4..8, FMB 3..5) ×
  `redundancy_ratio ∈ {1x, 2x}` × 5 scenario variants × 10 seeds — same protocol as the
  paper body's existing matrix, unchanged from what we already run for our own method.
- Metrics: success rate, failure_code taxonomy (collision_violation among them), solve_time
  — same schema as `run_records.jsonl`.

**Unresolved implementation items (design doc §7, still open, needed before Track 2 can run)**:
1. Locate the existing collision/feasibility checker used by the LGP pipeline, to reuse for
   *scoring* (not generating) Track 2's naive-interpolation trajectories.
2. Confirm which script actually implements the `--mode <name>` dispatch referenced in
   `methods.yaml` — root `driver.py` does not currently expose this flag; check
   `driver_gemini_mainline.py` or another entry point.
3. Cube Stacking object-labeling scheme decision (Track 1 item, already resolved in
   practice — indexed names like `Cube_1`.. are in use — but not yet back-filled into the
   design doc's open-items list).

**Platform note**: next session's Track 2 work happens on an Ubuntu machine, not this Mac —
this repo is synced via OneDrive, so pull latest before starting there. The KOMO physics
backend (see recent commit `b8167d86 Backup before KOMO zero-velocity modifications`) is
presumably why execution work moves to Linux; confirm the KOMO/LGP execution environment is
set up on that machine before starting.

---

## Repo orientation

- `docs/ops/` — design docs recording decisions with their rationale (read before
  re-deriving a decision that's already been made).
- `experiments/scripts/` — all pipeline code; VLM-MSGraph-specific scripts are prefixed/
  suffixed `vlm_msgraph`.
- `experiments/evaluations/` — per-method, per-benchmark trial outputs.
- `experiments/outputs/` — analysis reports, metrics JSON, visualizations. Never edit these
  by hand — they're regenerated by the `analyse_*`/`visualize_*` scripts.
- `paper/VLM-LGP-Assembly/` — the paper itself, synced via Overleaf (`.overleaf/` present).
  Being actively restructured (moved from `bare_jrnl.tex` to an IEEE conference `main.tex`
  template as of ~2026-08-20) — unrelated to the experiment pipeline, don't touch it as a
  side effect of experiment work.
