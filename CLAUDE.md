# CLAUDE.md — Working State

This file is the cross-session/cross-device handoff record for this repo. Read it at the
start of a new session (on any machine) to pick up where the last session left off.
Update it before ending a work session — append or revise, don't just delete history that
might still be relevant next time.

---

## Current phase (2026-09-12): method figures done, ablation experiments next

See **"Paper figures and ablation plan (2026-09-12)"** at the bottom of this file for the
live task list. Everything above that section is historical record.

---

## Earlier phase: Results section fully written (tables + prose) — pushed, needs Overleaf sync

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

### Done (2026-08-31): the 3 broken FMB scenarios were a bug, not infeasibility — fixed and rerun

**Resolution**: it was the bug/regression outcome (second bullet below), not infeasibility.
Root cause (commit `d300637e`, pushed from the Ubuntu machine): `_terminal()` in
`core/phase2_codegen.py` had two bugs in how it resolved a multi-supporter (bridging) object's
placement terminal — (1) it didn't check the bridging object's own per-edge position label
before falling back to the supporters' positions, so two distinct bridging objects spanning the
same supporter pair collapsed onto the identical `Table_Center` terminal, and (2) supporter
position aggregation silently dropped an unlabeled supporter instead of treating it as
implicit "center", so a bridging object with one labeled + one unlabeled supporter resolved to
a raw "stack on both supporters" terminal instead of `Table_Center`. Both produced solver
*timeouts*, not fast failures — which is why the diagnostic in this TODO (looking for a
`timeout`/`memory_exceeded`/IK-failure split) would have found "mostly timeout" and pointed
here.

Fixed, then **all of FMB was rerun with the 300s wall-clock cap removed** (16GB memory cap
only) to separate genuine infeasibility from under-provisioned search time — not just the 3
broken scenarios, the whole `{3objs,4objs,5objs}` matrix (900 solves), since the old
exclusion-based-denominator methodology this TODO was working around is no longer needed once
nothing is artificially timing out. Confirmed post-fix: Smart is 20/20 on all three previously
all-zero scenarios (`3objs/s002`, `4objs/s003`, `4objs/s005`) — genuinely a bug, not an
infeasible scene. Also added a `lgp_combined` (monolithic, no decomposition) column for both
benchmarks — FMB fully (`--combined-only`, no timeout), cube stacking only at 4cubes (100
trials, 0% success, memory-bound; 5–8cubes not executed, per the rule that a strictly easier
magnitude already failing completely implies the harder ones do too).

`tab:planning_sr`/`tab:planning_time` (Table VI/VII) were updated accordingly on 2026-08-31 —
see the new entry near the bottom of this file ("Table VI/VII FMB refresh") for the exact old
vs. new numbers and the commit hashes to revert against. The paragraphs below (the original
TODO write-up) are kept as the historical record of how this was diagnosed; nothing below this
point needs further action.

<details>
<summary>Original TODO text (resolved, kept for history)</summary>

**Status** (as originally written, 2026-08-24): user is currently rerunning the FMB matrix
(Smart / Global / Monolithic) on the Ubuntu machine to resolve exactly this TODO. Once that run
lands, they'll decide whether `main.tex`'s numbers/prose need updating — do not preemptively
rewrite `tab:planning_sr` or the Results prose around it before that decision is made; ask
first, per the diagnostic outcomes below.

**Note on labels**: this TODO was written when the FMB success-rate table was still
`tab:fmb_sr` (a standalone table in its own subsection). As of the 2026-08-23/24 Results-prose
session, that table was merged into `tab:planning_sr` (Table V in the compiled PDF), which now
also includes a third VLM-MSGraph column-group and lives in the merged "Execution and Planning"
subsection (`subsec:res_exec`) in `main.tex`. Everywhere below that says `tab:fmb_sr`, read
`tab:planning_sr`'s *FMB block* (rows `3 objects`/`4 objects`/`5 objects`, the `Smart (Ours)` and
`Global` column-groups only — the new `VLM-MSGraph` columns are unrelated to this TODO and
should not be touched by it).

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
  three): fix it, rerun the 120 trials, recompute the FMB rows of `tab:planning_sr` (Table V)
  and `tab:planning_time` (Table VI) using the same excluded-groups aggregation as
  `experiments/scripts/generate_fmb_plot.py`, and update both tables in `main.tex`
  (`subsec:res_exec`). Also recompute the pooled FMB prose numbers ($97.5\%$ Smart / $71.2\%$
  Global, stated in the paragraph right before Table V) if they change. Per the user's
  twice-confirmed call, still do **not** add an N/exclusion explanation to the `tab:planning_sr`
  caption itself; ask if this constraint should change.

This is the direct follow-up to close out this table before the paper is finalized, not a
someday-maybe item.

**Historical note**: during this same session, `main.tex` on disk got touched by something
external (Overleaf's watcher, most likely) at least twice, each time reverting in-progress
table-formatting fixes (the `tab:vlm_accuracy_baseline` overfull-hbox fix, and once a full
revert of `tab:fmb_sr`'s numbers back to a stale raw/unexcluded version). Both times this was
caught by re-running `latexmk -pdf -g main.tex` and grepping the log for `Overfull`/`Underfull`
before trusting the PDF — do this on any future session too, don't assume the file on disk
matches what the last session left, even right after a `git pull`.

</details>

**Root cause identified (2026-08-31)**: it's **Antigravity IDE's "Overleaf Workshop" extension**,
not a vague "Overleaf's watcher". `paper/VLM-LGP-Assembly/.overleaf/settings.json` (git-tracked,
`uri: overleaf-workshop://www.overleaf.com/...project=699eb4a5...`) is this extension's config
file, and the extension appears to sync *any* local folder containing it against that Overleaf
project's *current cloud content* — bidirectionally, live, no explicit user action needed each
time. Confirmed the hard way this session: a **brand new `git clone`** to a non-OneDrive path
(`~/Projects/VLM-LGP`) got silently overwritten back to the same stale pre-rerun numbers within
minutes of cloning, plus a pile of old-draft assets reappeared (`bare_jrnl.tex`, `Flowchart.pdf`,
`workflow.svg`, etc. — leftovers from an early paper-template era) while several current ones
were deleted. **The Overleaf cloud project itself is behind both git and any local checkout** —
it has neither this session's VLM-section prose/figures nor the FMB re-run table data. Do not
assume a local file is stable just because it's a fresh clone; the exposure is the presence of
`.overleaf/settings.json`, not which folder or when it was created.

If you hit unexplained reverts again: check `ps aux | grep -i antigravity` — if Antigravity IDE
is running with this repo (or the OneDrive copy of it) open in a workspace, that's almost
certainly why. Ask the user to close that workspace (or quit Antigravity) before trusting edits
to stick, and re-verify the file content immediately after any edit, not just after compiling.

**Also found this session (unrelated to Overleaf, but same symptom of "file changes I didn't
make")**: the original OneDrive-synced working copy
(`~/Library/CloudStorage/OneDrive-UniversityofMacau/Publications/VLM-LGP`) has `git status`/
`git diff`/anything touching `.git/index` hang or fail with `fatal: mmap failed: Operation timed
out` — reproducible, not transient (retried with 9+ minute timeouts, still hung; killing and
letting `fileproviderd` restart didn't help either). Root cause not fully isolated, but strongly
correlated with macOS's File Provider layer backing that OneDrive mount. **Workaround, not a
fix**: work from a plain local clone instead (`~/Projects/VLM-LGP`, `git status` there is
instant) — this is now the actual working copy as of 2026-08-31; the OneDrive folder is left
alone as a reference/backup, not touched further. If a future session is asked to work in the
OneDrive path again and hits the same hang, don't fight it — clone fresh to a local path instead
of debugging the mount.

### Done (2026-08-24): Results section prose, written top to bottom

All Results subsections now have real prose, not just headers + tables (they previously had
none at all in the new `main.tex`, unlike `Arxived/main.tex` which had full prose — that gap is
what this pass closed). Restructured into two subsections per the user's explicit narrative,
not the original Arxived structure:

- **`subsec:res_vlm`** ("VLM Front-End: Graph-Generation Accuracy"): Direct-Action LLM
  (qualitative, no table — no trial ever completes, so there's nothing to tabulate) → backbone
  selection (`tab:vlm_backbone_selection`, moved here from its own subsection) → our method vs.
  VLM-MSGraph accuracy (`tab:vlm_accuracy_cube`/`tab:vlm_accuracy_fmb`).
- **`subsec:res_exec`** ("Execution and Planning: Success Rate and Solving Time"): monolithic-
  solving ablation (`tab:ablation_monolithic`) → VLM-MSGraph naive-interpolation execution →
  Global vs. Smart planning (`tab:planning_sr`/`tab:planning_time`).

Table changes made while writing (content, not just prose):
- `tab:vlm_backbone_selection`: Gemini-3-Flash Test-3 was showing a stale $30.0\%$ (3/10) from
  an outdated archived run — **user confirmed this is their own transcription error, not a data
  issue to investigate further; corrected to $100.0\%$ (10/10)** (matching Test-1). Also fixed
  Qwen3.5-Plus Test-3 from a value that didn't match its own source file ($50.0\%$/5/10 →
  $60.0\%$/6/10, per the archived `.txt`). Selection rationale in prose: Gemini-3-Flash and
  Qwen3.6-Plus performed comparably; Gemini-3-Flash chosen on balance, not because it strictly
  dominated (do not overstate this in future edits).
- `tab:baseline_execution` (VLM-MSGraph Track 2, previously its own table) was **merged into
  `tab:planning_sr`** as a third `VLM-MSGraph` column-group alongside `Smart (Ours)` and
  `Global`, per explicit user request so the three methods' success rates sit side by side for
  direct visual comparison. Caption flags that "success" means different things per
  column-group (Smart/Global = solver found a feasible plan; VLM-MSGraph = naive interpolation
  happened not to collide during simulated execution) — this is intentional and was reviewed,
  not an oversight to "fix" later. `tab:planning_time` (solving time) was deliberately **not**
  merged the same way — VLM-MSGraph's naive interpolation has no solving step, so a time
  comparison isn't meaningful for it.
- FMB pooled success-rate numbers in prose (Smart $97.5\%$, Global $71.2\%$) were **recomputed
  from `tab:planning_sr`'s current cell values**, not copied from Arxived's $60.5\%$ for Global
  — that old number mixed exclusion methodologies (see "Data-integrity finding" above); $71.2\%$
  is the number consistent with the now-standardized excluded-groups methodology used
  throughout this table. If `tab:planning_sr`'s FMB cells change (see the TODO above, currently
  in progress on Ubuntu), this pooled number must be recomputed again, not left stale.

**Style constraints given explicitly by the user, apply to any future edits of this section**:
restrained, academic wording, concise, avoid "AI-flavor" phrasing (no meta-commentary like "in
this section we...", no hedging filler, no listy over-explaining). Also: VLM-MSGraph's
execution primitive (straight-line interpolation, no collision checking) is **the method as
published**, not something we imposed or weakened — do not phrase it as if we added those
limitations; that critique belongs in the Execution results paragraph (where the actual
numbers are), not in the Setup section's method definitions. Global LGP's layer-based split is
described as mirroring a human manually partitioning a long-horizon task into subtasks — keep
this framing if the method description is touched again.

Compiles clean with `latexmk -pdf`; only pre-existing warnings remain (the Eq. 2 overfull hbox,
one cosmetic underfull hbox in the Setup paragraph, and the undefined `cite_komo_2014`
citation) — no new ones introduced by this pass.

---

### Done (2026-08-31): Table VI/VII — Combined column added, FMB Smart/Global numbers refreshed

Working copy is now `~/Projects/VLM-LGP` (plain local clone, not OneDrive — see the historical
note above under the FMB-scenarios TODO for why). Two commits on `writing_paper`, each a clean
revert point on its own:

- `ce243933` — added the `Combined` (monolithic, no decomposition) column to `tab:planning_sr`
  and `tab:planning_time`, using the `d300637e` re-run data. This commit still has the *old*
  (pre-refresh) Smart/Global numbers, so `git show ce243933` or `git diff ce243933~1 ce243933`
  is the clean "what did Combined add" diff.
- `bf477920` — refreshed the FMB Smart/Global cells in both tables (and the two prose sentences
  that quote them) from the old exclusion-based-denominator/300s-timeout numbers to numbers
  recomputed directly from the raw `trial_meta.json` files (N=50/cell, no exclusions, no
  wall-clock cap — same methodology already used for Combined). Cube-stacking Smart/Global was
  **not** touched (this re-run only covered FMB + the cube-stacking Combined column).

**To revert either change**: `git revert bf477920` (undo just the numeric refresh, keep
Combined) or `git revert bf477920 ce243933` (undo both, back to the original two-column table).
Both revert cleanly since neither commit touches anything outside these two tables + the one
paragraph.

**Old vs. new FMB numbers** (Smart/Global only — Combined and VLM-MSGraph columns unchanged
since their introduction):

| Magnitude | Cond | Smart (old→new) | Global (old→new) |
|---|---|---|---|
| 3 objects | NR | 95.0 → 96.0 | 95.0 → 92.0 |
| 3 objects | R | 100.0 → 96.0 | 95.0 → 62.0 |
| 4 objects | NR | 96.7 → 98.0 | 83.3 → 22.0 |
| 4 objects | R | 96.7 → 100.0 | 73.3 → 12.0 |
| 5 objects | NR | 98.0 → 96.0 | 66.0 → 0.0 |
| 5 objects | R | 98.0 → 96.0 | 15.0 (3/20, excluded-denominator) → 0.0 (0/50) |

Solving times (seconds, successful trials only) roughly **tripled for Smart** (e.g. 3objs NR
74.6 → 209.3) — this is the 300s-timeout removal surfacing genuinely-slower successful solves
that the old cap either excluded or cut off, not a regression. Global's 5-object cells lost
their only remaining successful trials entirely (both conditions now 0%, so `tab:planning_time`
shows `---` there instead of the old 131.0/284.8).

Pooled FMB prose numbers: Smart $97.5\% \to 97.0\%$, Global $71.2\% \to 31.3\%$ (both
recomputed by summing the fresh per-cell success counts across all 300 FMB trials —
Smart 291/300, Global 94/300).

**Why the gap between old and new is this large**: the old numbers used an exclusion-based
denominator (scenario-mode groups with 0/N success were dropped from the denominator rather
than counted as 0%) specifically to work around the 3 broken scenarios documented in the TODO
above. Once that bug was fixed and everything re-run at N=50/cell with no exclusions, Global's
real collapse at scale (it's memory-bound, same as Combined, just less severely) is no longer
hidden by the exclusion methodology — this is expected and is the whole point of the re-run,
not a sign something is wrong with the new numbers.

**If this needs verifying again**: the exact recomputation commands are in this session's
transcript (`python3` one-liners over
`experiments/evaluations/LGP/FMB/*/*/trial_*_{nr,r}/{lgp_split_smart,lgp_split_global,
lgp_combined}/trial_meta.json`, keying off each file's `success` and `runtime_s` fields) — not
saved as a script anywhere, so re-derive from scratch rather than searching for one.

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

---

## Paper figures and ablation plan (2026-09-12)

Advisor (周老师) reorganized the Results skeleton and the Method text himself; the `\zz{}`
placeholders in `paper/VLM-LGP-Assembly/main.tex` are his and map 1:1 to the tasks below.
Target: draft next week, submit within ~2 weeks (before Mid-Autumn).

### Method text changed under us — read this before touching reachability

The advisor rewrote `\subsubsection{Reachability Filtering}`. The new formulation is
**two stages, no ESDF, no obstacles, no reach-envelope**:

- geometric accessibility score `ρ(o_i) = ρ_spa(o_i) + α·ρ_clear(o_i)`, kept as a cheap
  pre-filter (`ρ ≥ τ_ρ`)
- `ρ_spa = 1 − (1/(N−1)) Σ_{j≠i} exp(−‖p_i−p_j‖²/2σ²)` — note the leading `1 −`: crowded
  now scores **low** (the code has the opposite sign)
- `ρ_clear = min(min_{j≠i}|p_i−p_j|, d_max)/d_max` — distance to the nearest **other
  object**, not to an obstacle frame
- then a short-horizon KOMO solve (grasp condition + joint limits + `d_col ≥ d_safe`);
  `S_r = {ρ ≥ τ_ρ ∧ ∃q*}`

His reasoning on WeChat: "komo 就行了，本来这些也都包含在 komo 的 constraints 里了", but
"score 留着". ESDF was explicitly dropped ("就当不存在吧").

**Code is behind the text (deliberately deferred — does not block submission):**
1. `core/reachability_field.py` `_build_gmm_scores` has no `1 −` (sign inverted vs. the
   paper) and includes the self-kernel with a `1/N` mean instead of `1/(N−1)` over `j≠i`
2. `_build_esdf_scores` measures distance to obstacle-tagged frames. **Verified: only 3 of
   300 scene `.g` files contain any obstacle frame, and all 3 are test fixtures** — so in
   every experiment scene `esdf ≡ 1.0` and that term has zero discriminating power
3. Consequence: with `esdf ≡ 1.0`, `score = 0.6·gmm + 0.4`, so pruning needs `gmm < 0.083`,
   i.e. roughly 12+ well-separated objects. **The pre-filter has never fired in their
   benchmarks** — a real report showed all 8 objects scoring 0.53–0.61 (all above τ=0.45)
   and every rejection carrying `reason: komo_policy_gate_infeasible`
4. `α` and `τ_ρ` must be re-tuned after the fix — the old `0.45` is meaningless for the new
   formula's range
5. `split_infeasible_objects_from_reachability` loops over the full `layout_list`, so KOMO
   currently runs on every object rather than only on pre-filter survivors. Making it a
   true cascade is **output-neutral** (the merge only ever downgrades to infeasible), so it
   needs no re-run — unlike fixes 1–3, which change which objects are pruned

Manipulability text vs. code, still unresolved: the paper ranks into a single global
`Ŝ_r`, the code ranks **per object category**; the paper ranks by `m` alone, the pipeline
(`pipeline/run_phase0.py:220-227`) orders by `reachability_score × manipulability_score`.

### Figures

Done and inserted into `main.tex`:
- `figures/graph_decomposition.pdf` → `fig:graph_decomposition`, 6-panel walkthrough of
  root / branch propagation / bridge / grouping / batch cutting, single column
- `figures/reachability_filtering.pdf` → `fig:reachability_filtering`, two stages
- `figures/manipulability_ordering.pdf` → `fig:manipulability_ordering`, two arm
  configurations + manipulability ellipsoid + reference circle + `m` vs. arm-extension inset
- `figures/vlm_input_fmb.pdf` / `vlm_input_cube_stacking.pdf` → `fig:problem_definition_input`

Figure conventions settled over many rounds — follow them for any new figure:
white background, panel borders `#E5E7EB` 1.5px radius 8, blue `#DBEAFE`/`#2563EB`, orange
`#FFEDD5`/`#EA580C`, green `#D1FAE5`/`#059669`, grey `#E5E7EB`/`#9CA3AF`, reject mark
`#DC2626`, sans-serif, **no dark panels, no shadows/gradients, no photorealistic robot
arm**. Text must be ≥30px on a 1200px-wide canvas (≈7pt once scaled to a 3.4in column).
Figure titles must match the corresponding `\subsubsection{}` heading verbatim.

**PARKED — overview figure (`figures/LGP_method.pdf`, `fig:workflow`) redesign.** Advisor:
simplify it, the detail now lives in the three figures above, and "画图的时候对应上每个模块
的名字和 notations". Agreed plan:

- formatting (from 心雨): drop the grey background band; centre each module title; solid
  borders; fix the arrows
- the arrow problem is structural: the real dataflow is **two parallel branches that
  converge**, not a left-to-right strip —
  `I → [VLM graph gen] --G--> [decomposition] --P-->` and
  `S → [reachability filtering] --S_r--> [manipulability ordering] --Ŝ_r-->`
  both feed `[symbolic action plan] → [LGP + active constraints] --q*--> [impedance exec]`
- label the arrows with the paper's notation (`I, S, G, P, S_r, Ŝ_r, q*`) so they read as
  dataflow rather than sequence
- cut: the branch-clustering scatter plot (it depicts `KMeansBranchClustering`, not the
  root/bridge algorithm the text describes), the layer-cutting sub-diagram, the ✓/✗
  reachability quad, the ranked-candidate shapes, the execution-order arc diagram
- rename every box to its `\subsubsection{}` name (current overview labels are all stale,
  and "0.1 Manipulability-Aware Ordering" actually depicts reachability)

Also outstanding: `main.tex:228` — redesign the cube-stacking target structure in
`fig:problem_definition_input(a)` so every shape in the legend (Cube / RectPrism / Long
Rect / TriPrism) actually appears. Easiest fix is to reuse the 9-object structure from
`fig:graph_decomposition`, which uses all four and gives the paper one running example.

### Ablations — machine requirements

**No compiled solver on the Mac**: `bin/` holds only `main.cpp`, `pick_waypoint_check.cpp`
and a Makefile. `core/phase0_parser.py` looks for `bin/pick_waypoint_check.exe`. Anything
needing KOMO/LGP must run on the Ubuntu box (or be built here first).

1. **Graph validator** (`main.tex:692`) — VLM API only, no simulator, no solver. Runs
   anywhere with network + key. Toggle is the retry loop in `pipeline/run_phase1.py`
   (`validate_plan` + `max_attempts = 3`). Decide up front how to score the
   without-validator runs whose JSON does not parse at all. Output: table, no figure.
2. **Reachability filtering** (`main.tex:696`) — needs `pick_waypoint_check` (a single-step
   KOMO solve per object, seconds) as the feasibility ground truth, but **not** the full
   LGP solver. Advisor wants a scene + a table + a small schematic comparison figure
   ("同一场景，没有 filter 时去抓够不到的那个，有 filter 时改抓另一个"); he said a rendered
   simulation image is not required.
3. **Active constraints** (`main.tex:700`) — **no new runs needed, the data already
   exists.** Verified in `experiments/scripts/run_fmb_batch_eval.py:150-175`: the
   clustering/plan is computed **once** and all three modes consume the same plan object.
   `lgp_split_smart` vs `lgp_split_global` therefore differ **only** in collision policy
   (`active_runtime` vs `follow_lgp`) — a clean active-constraints ablation. And
   `lgp_split_global` vs `lgp_combined` differ only in `combine_terminals`, giving a clean
   decomposition ablation for free.

Per-stage timing still missing (advisor asked for it explicitly, and insisted on real
numbers even if sub-millisecond): reachability and manipulability timed **separately**,
plus LGP, ~10+ runs, report means. VLM/graph-generation timing is **excluded** by
agreement (API call, network variance, no consistent measurement). Manipulability timing is
pure Python (`test/manipulability/urdf_static_manipulability.py`) and can run on the Mac;
reachability timing needs the solver binary.

### Naming — advisor was explicit and unhappy about the current names

- **"Global" must move out of the main baselines into the ablation section** as the
  no-active-constraints condition. Delete the "模拟人为拆分 / mirroring how a human would
  manually partition" framing from `main.tex` — it is simply false, the decomposition is
  identical to ours (confirmed in the runner above), and the advisor called it out.
- **"Combined" → "full graph LGP"** ("为啥这个你要起个名字叫 combined… 你直接就 full graph
  LGP 不就完了吗").
- Our method is **"Ours"** or **"Proposed"** in tables.
- The advisor revised naming in Experimental Setup himself; a **final consistency audit**
  (figures ↔ his setup text) is a separate end-of-writing task.

### Experimental setup facts he had to drag out of us — write them into `main.tex:665`

Cube Stacking 4/5/6/7/8 (5 magnitudes) and FMB 3/4/5 (3 magnitudes); **5 independently
designed target structures per magnitude** (s01–s05, not parameter variants of one
structure); each structure run under two redundancy modes, non-redundant and redundant
(same-type distractors, object count **doubled**); each structure × mode repeated over
**10 random seeds**. Also still missing from that section: hardware platform, which VLM,
and the reachability parameters (σ, d_max, α, τ_ρ).
