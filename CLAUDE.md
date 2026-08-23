# CLAUDE.md — Working State

This file is the cross-session/cross-device handoff record for this repo. Read it at the
start of a new session (on any machine) to pick up where the last session left off.
Update it before ending a work session — append or revise, don't just delete history that
might still be relevant next time.

---

## Current phase: VLM-MSGraph baseline paper insertion — done, needs Overleaf sync

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

### Done: paper insertion (2026-08-23)

`paper/VLM-LGP-Assembly/main.tex` — found present locally on this Mac but **not git-tracked**
(Overleaf-synced via the `.overleaf/` VSCode-extension integration, not a git remote). All 6
existing data-bearing figures in the Results section were converted to `\begin{table}`
environments (kept as figures: workflow diagram, reachability diagram, manipulability
field/slice visualization, the two real-robot-execution photo grids — none of these are
bar/line data charts). Two new tables added for our own baseline numbers: Track 1
(`tab:vlm_accuracy_baseline`, replacing the old `fig:vlm_accuracy_baseline`, in
`subsec:res_vlm_accuracy`) and Track 2 (`tab:baseline_execution`, new content in the
previously-empty `subsec:res_direct` "Direct-Action LLM Baseline is Infeasible" section — only
success-rate data, no collision/failure-breakdown numbers per explicit instruction). No prose
was touched; the Results subsections had no body text at all yet, only headers + figures, so
there was nothing to preserve/break. Compiles clean with `latexmk -pdf` (this Mac has a full
TeX Live 2026 install after all — CLAUDE.md's old note about no LaTeX toolchain was stale);
zero new overfull/underfull warnings introduced (one pre-existing unrelated overfull hbox at
an Eq. 2 line remains, not touched).

**Data-integrity finding surfaced and resolved with the user**: the FMB scalability figure
(`fig:fmb_scalability`, generated by `generate_fmb_plot.py`) silently **excludes any
scenario×policy×mode group with exactly 0/N success from the denominator** before computing
the displayed rate. This matches the already-published `Arxived/main.tex` `tab:fmb_sr` table
for every cell except one: 5-object Global-R, where Arxived reports the *unexcluded* raw rate
(6.0% = 3/50) instead of the excluded rate the same script would give (15.0% = 3/20) — an
internal inconsistency in the old published table, not a new bug. User chose to standardize on
the excluded-groups methodology (matches the current figure) for the new table, i.e. the new
`tab:fmb_sr` reports **15.0%** for that cell, diverging from Arxived's 6.0%. If this table is
compared against the old Arxived draft or against `experiments/outputs/LGP_execution_stats/
cross_magnitude_comparison.md` (a *different*, non-exclusion-based aggregation that also
doesn't match either number) don't assume one of them is wrong without re-reading this note —
all three are internally consistent, they just answer "what counts as a valid trial"
differently. Cube-stacking scalability (`tab:cube_sr`/`tab:cube_time`) has no such issue —
`generate_final_plots.py` has no exclusion logic, and its numbers match Arxived exactly.

**Follow-up investigation (2026-08-23, same session, after initial insertion)**: dug into
*why* those scenario×policy×mode groups hit exactly 0/N, and found the exclusion issue is
bigger than just the one disputed cell — **it affects Smart too, not only Global**, at 3 and
4 objects:

- At 3objs, only 3 scenarios exist on disk (s001/s002/s003, not 5). `s002` is **0/10 for
  every policy×mode combination** (Smart-NR, Smart-R, Global-NR, Global-R all zero). Raw
  (unexcluded) rates: Smart-NR 19/30=63.3%, Smart-R 20/30=66.7%, Global-NR/R 19/30=63.3%.
  Excluding `s002` is what turns these into the 95.0/100.0/95.0/95.0 now in `tab:fmb_sr`.
- At 4objs (5 scenarios), `s003` and `s005` are **both 0/10 for every policy×mode
  combination**. Raw rates: Smart-NR/R 29/50=58.0%, Global-NR 25/50=50.0%, Global-R
  22/50=44.0%. Excluding those two scenarios is what turns these into 96.7/96.7/83.3/73.3.
- At 5objs, by contrast, Smart-NR/R and Global-NR are natural 49-50/50 (no exclusion
  happens for them); **only Global-R** has 3 of 5 scenarios at 0/10, dropping N from 50 to 20
  and the rate from the raw 6.0% to the excluded 15.0%.

**The two situations are qualitatively different**: `s002`@3objs and `s003`/`s005`@4objs fail
for *every* policy and mode equally (even our own Smart can't solve them) — this looks like
broken/infeasible scenario assets, not a Global-specific planning weakness, so excluding them
doesn't distort the Smart-vs-Global comparison. The 5objs Global-R exclusion is different: it
specifically hides a Global-only failure mode under the hardest condition, which is exactly
the comparison the paper is trying to make.

**User's decision (reversed twice, final as of 2026-08-23)**: round 1, keep the excluded
numbers (15.0% etc.). Round 2, switched to raw/true denominators, no exclusion at all (3objs
63.3/66.7/63.3/63.3, 4objs 58.0/58.0/50.0/44.0, 5objs 98.0/98.0/66.0/6.0), reasoning that this
is still a draft and shouldn't dress up incomplete data with an exclusion methodology. Round 3
(final): back to the **excluded-groups numbers** — 3objs 95.0/100.0/95.0/95.0, 4objs
96.7/96.7/83.3/73.3, 5objs 98.0/98.0/66.0/15.0 (Smart NR/R, Global NR/R column order) — because
the raw numbers made the advisor reading the draft confused (63-67% success reads as a genuine
weak result, not as "these are two broken scenarios pending a rerun"). The user's actual
constraint throughout all three rounds was consistent and never changed: **do not add an
N/exclusion explanation to the table's caption**, regardless of which number set is shown —
only the choice of which numbers to display flip-flopped. If a future session sees this table
looking "too high" and is tempted to swap back to raw numbers, don't do it unilaterally — this
specific back-and-forth already happened twice in one session; ask first and link this note.

### TODO (next session, on the Ubuntu machine): rerun the 3 broken FMB scenarios and backfill `tab:fmb_sr`

**Exactly what's missing/broken** (self-contained — do not need to re-derive this from git
history or chat transcript):

| Magnitude | Scenario | Dir | Broken for |
|---|---|---|---|
| 3objs | `s002` | `experiments/evaluations/LGP/FMB/3objs/s002/` | ALL 4 combos: `lgp_split_smart`×{nr,r}, `lgp_split_global`×{nr,r} — 0/10 each |
| 4objs | `s003` | `experiments/evaluations/LGP/FMB/4objs/s003/` | ALL 4 combos — 0/10 each |
| 4objs | `s005` | `experiments/evaluations/LGP/FMB/4objs/s005/` | ALL 4 combos — 0/10 each |

That's 3 scenarios × 4 policy×mode combos × 10 trials = 120 trials total, all currently
failing, all silently excluded from `tab:fmb_sr`'s denominator (see "Data-integrity finding"
above for the full derivation of these numbers — this table's 95.0/100.0/95.0/95.0 (3objs) and
96.7/96.7/83.3/73.3 (4objs) cells only look that clean because these 120 trials are missing
from them; the raw/unexcluded rates counting them as failures are 58–67% for the same cells).
No other scenario at any magnitude has this all-zero pattern (5objs is clean except for
Global-R, which is a separate, already-understood issue — see above, not part of this TODO).

**Diagnostic steps** (do these in order — don't jump straight to "rerun the solver"):
1. Open the `.g` scene file for each of the 3 scenarios and check it's not simply malformed
   (e.g. compare object count/geometry against a working scenario at the same magnitude like
   `s001`).
2. Check whether *any* trial for these scenarios ever succeeded historically (search git log /
   older `experiments/evaluations/` backups if any exist) — if it never worked, this is more
   likely a genuinely infeasible scene than a regression.
3. If the scene looks fine, rerun a handful of trials for each scenario under both
   `lgp_split_smart` and `lgp_split_global` and read the actual failure mode (timeout? memory?
   IK failure? — same `trial_meta.json` fields used elsewhere in this doc: `success`,
   `timeout`, `memory_exceeded`, `runtime_s`).

**Two possible outcomes and what to do for each**:
- **Genuinely infeasible scene** (e.g. an object placed unreachably, or geometrically
  impossible support relation): current `tab:fmb_sr` numbers are fine as-is, no paper change
  needed — but note this in the scenario's own directory (e.g. a `KNOWN_INFEASIBLE.md`) so a
  third pass doesn't re-investigate the same dead end.
- **Bug/regression** (scene generation or solver pipeline issue that happens to hit these
  three): fix it, rerun the 120 trials, recompute `tab:fmb_sr` and `tab:fmb_time` using the
  same excluded-groups aggregation as `experiments/scripts/generate_fmb_plot.py` (see the
  comment block directly above `tab:fmb_sr` in `main.tex`, currently ~line 703, for the exact
  methodology), and update both tables in `main.tex` (currently at lines ~716–745). Also update
  the `tab:fmb_sr` caption's underlying data if the excluded/raw gap changes materially — but
  per the user's twice-confirmed call, still do **not** add an N/exclusion explanation to the
  caption itself; ask if this constraint should change.

This is the direct follow-up to close out this table before the paper is finalized, not a
someday-maybe item.

**Still open**: the edited `main.tex` is local-only until synced back to Overleaf (this
session cannot push to Overleaf directly — no git remote for it). User needs to let the
Overleaf extension pick up the change, or re-upload manually. Also noticed mid-session that
`main.tex` on disk got touched by something external (Overleaf's watcher, most likely) and
reverted a couple of in-progress table-formatting fixes (the `tab:vlm_accuracy_baseline`
overfull-hbox fix) — re-applied them, but if you pick this up on another machine, re-run
`latexmk -pdf -g main.tex` and grep the log for `Overfull`/`Underfull` before trusting the PDF
looks the way this session left it.

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
