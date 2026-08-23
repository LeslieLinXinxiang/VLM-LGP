# CLAUDE.md — Working State

This file is the cross-session/cross-device handoff record for this repo. Read it at the
start of a new session (on any machine) to pick up where the last session left off.
Update it before ending a work session — append or revise, don't just delete history that
might still be relevant next time.

---

## Current phase: VLM-MSGraph baseline (Track 1 + Track 2 done, paper insertion next)

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

### Done: Track 2 (execution-layer feasibility, Eq.7 naive interpolation baseline)

Full pipeline built from scratch under `experiments/scripts/baseline_naive_interp_{scene_parser,
task_assignment,convert_g_to_mjcf,execute,run_batch}.py` — pure MuJoCo + a self-written
damped-least-squares IK solver, **no MoveIt/ROS** (deliberate: this baseline's whole point is
demonstrating what happens WITHOUT collision-aware planning, so pulling in a planner would
defeat the comparison). Phases: (1) parse the *same* `.g` scene files our own LGP method
consumes (guardrail: identical scenes, no separate easier/harder set), (1.2) derive the action
sequence externally via our own method's `execute_phase0()` + clustering/codegen (task
assignment is given, not decided by the baseline), (2) convert to MuJoCo MJCF, (3) execute
Eq.7 (reorient → `P+0.8T,+0.92T,+0.96T,+T` decelerating interpolation → gripper open/close, no
collision/joint-limit checking, no lift/transit/descend decomposition), (5) batch runner.

**Both benchmarks fully run, 800/800 trials, 0 hard failures.** Results:
[Baseline_execution_stats/cubeStacking_summary.md](experiments/outputs/Baseline_execution_stats/cubeStacking_summary.md),
[Baseline_execution_stats/FMB_summary.md](experiments/outputs/Baseline_execution_stats/FMB_summary.md).

- Cube Stacking (500 trials): 3.4% overall success, 89.4% collision rate, success drops
  12%→3%→0%→0%→2% as magnitude goes 4→8 cubes. Collision is the dominant per-action failure
  mode (43.2% of actions).
- FMB (300 trials): **0.0%** overall success (every trial has at least one action that doesn't
  cleanly complete), 58.0% collision rate. Per-action failure is dominated by **unreachability,
  not collision** (60.3% of actions neither complete nor collide — the straight-line IK target
  is simply never reached — vs. Cube Stacking's 11.7%). The two benchmarks fail for genuinely
  different reasons; useful contrast for the paper.
- Per-object visual verification methodology (user-driven): render one isolated pick-place per
  new shape family, user watches the video, confirms before moving to the next. All three FMB
  shape families (`shape_2`, `shape_3`, `shape_4` — there is no `shape_1`/`5`/`6`, only these
  three families with up to 6 numbered instances each) individually confirmed correct.

**Bugs found and fixed along the way (all pushed to `writing_paper` together with this Track 2
work — see git log for exact commit)**:
1. **Concave-mesh collision inflation**: MuJoCo auto-convexifies `type="mesh"` collision geoms.
   FMB's `shape_3_1`/`shape_4_1`/`base_board` meshes are genuinely non-convex (confirmed via a
   per-face plane test — up to 90-215mm of geometry a naive convex hull would fill in as
   phantom solid volume), which showed up as an "invisible wall" during grasp approach — the
   gripper registered a collision well before touching the visible surface. Fixed by CoACD
   convex-decomposing each affected mesh (`simulation/scripts/decompose_mesh.py`, output in
   `assets/fmb/new_fmb/decomposed/`) into several genuinely-convex pieces; the raw mesh is kept
   for rendering only (`contype=0`), the decomposed pieces carry real collision
   (`baseline_naive_interp_convert_g_to_mjcf.py::_decomposed_pieces`).
2. **`base_board` free-falling / disappearing**: a static-object detection rule (root object,
   `contact:0` on itself, no `contact:1` child) now gives fixtures like `base_board` a plain
   body with no freejoint instead of a free-falling one. An earlier version of this rule used
   the `is_place` tag instead, which wrongly caught ordinary Cube Stacking blocks too (any
   block another block can stack onto is also tagged `is_place`) and crashed `run_to_ctrl_target`
   the moment one of those objects was placed — see bug 3.
3. **`core/utils.py::parse_and_inject` permutation-rename bug — the big one, affects the
   SHARED `execute_phase0()` pipeline, not just this baseline.** It renames objects by
   substituting each old name for its new name sequentially into the same text buffer. Any
   *permutation* in the rename mapping (e.g. `shape_3_1↔shape_3_2` swapping places, which the
   physics-aware reordering step produces routinely) is the classic "swap without a temp
   variable" bug: the second substitution's global regex can't tell an original occurrence of
   its source name from one the first substitution just wrote, and collapses both into the
   same name — a silently duplicated object with another object's name never assigned at all.
   Confirmed via a 90-scene sample: **80/90 (89%) of FMB multi-object scenes were affected**
   before the fix, 0/90 after. Cube Stacking was asymptomatic (physics-reordering rarely
   permutes same-typed cubes relative to their original order) but uses the exact same code
   path, so it was latently at risk too. Fixed with a two-phase rename through unique
   placeholders — behaviorally identical for non-permuting mappings, correct for any cycle.
   **This was initially misdiagnosed as a concurrent-process race condition** (a real, separate,
   already-documented hazard — `execute_phase0()` writes to a hardcoded shared path — but not
   what was actually happening here); worth remembering that race-condition symptoms and
   deterministic-corruption symptoms can look identical from the output alone.
4. Orientation fix (place logic was resetting the HAND to canonical yaw instead of the OBJECT,
   so rectangular blocks landed 90° off), release-clearance tuning (0.008m → 0.05m to avoid a
   flush-fit launch), grasp-target-height (tried -2cm, reverted to 0 once bug #1 was found to
   be the real cause of the original observation), camera framing (aim at the workspace
   reference's own height, not +0.2m above it — was clipping `base_board` out of frame).

### Next: get this into the paper

- Insert the Cube Stacking / FMB baseline numbers above into the paper body (`paper/
  VLM-LGP-Assembly/`, IEEE conference `main.tex` template — see repo orientation note below;
  don't touch this directory as a side effect of unrelated experiment work, but this IS the
  next task).
- Convert the chart visualizations already produced this session (success/collision rate by
  magnitude, action-level failure-reason breakdown Cube Stacking vs FMB) into paper-ready
  **tables** — charts don't belong in a LaTeX submission the way they were shown in-session;
  the underlying numbers are already tabulated in the two `Baseline_execution_stats/*.md`
  reports linked above, so this is reformatting for the paper's own table style, not
  re-deriving data.

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
