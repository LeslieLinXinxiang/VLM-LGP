# VLM-MSGraph Baseline — Experiment Design & Comparison Protocol

**Date**: 2026-08-16 | **Status**: Design agreed, implementation pending | **Source paper**: VLM-MSGraph (Li et al., *Robotics and Computer-Integrated Manufacturing* 94 (2025) 102978)

---

## 1. Purpose

Implement VLM-MSGraph's method (not its published experiments) as a baseline inside our own Cube Stacking / FMB evaluation framework, to argue for the necessity of our LGP-based constrained execution layer. This document records the design decisions reached during scoping discussion, so implementation can proceed without re-deriving them.

---

## 2. Source method summary (what we are implementing)

Two decoupled modules in the original paper:

**Module A — high-level semantic sequencing** (paper §3.1)
- 3-stage VLM chain: Relation Narrator + Image Narrator (parallel, produce `<subject, predicate, object>` triples) → Base Searcher + Action Narrator (pick anchor object, reorder into sequence) → Triple Extractor (self-review/correction)
- Input: one image + a part list containing **names and quantities only — no coordinates**
- Output: ordered triples. Predicate vocabulary includes spatial relations (above/below/left/right) and assembly-action verbs (attach_to/screw/insert/wrap/go_through)
- VLM never sees or outputs a numeric coordinate at this stage

**Module B — low-level execution** (paper §3.2, Eq. 1–7)
- Perception: Grounding DINO (open-vocab detection) + GroundedSAM-v2 (segmentation) on real RGB-D, used only to **match a triple's object name to a real scene detection via text query** — this is a name→detection lookup, not a VLM capability

**Scene grounding mechanism — precise description** (matters for §3 below)

The grounding is **unidirectional and single-pass**, not a two-sided semantic match:
1. Module A's VLM emits an object name inside a triple (e.g. `"red large gear"`).
2. That exact string is fed **directly as the text prompt** to Grounding DINO — open-vocabulary detection means "given this text, locate the matching image region."
3. The detector returns bounding box(es); GroundedSAM-v2 refines to a mask.
4. Paper §3.2: "The detected labels of each object's bounding boxes and masks are then synchronized with nodes N recorded in the high-level MSGraph G." Table 3 confirms the step-1..5 text prompts are literally the same strings as the high-level object names.

There is **no second semantic-matching stage**: the VLM does not compare its own output against an independently-produced CV description, and no reconciliation model exists. The high-level name *is* the detector's instruction. Consequently, when several objects in the scene satisfy the same text query, the detector returns multiple candidates and **the method specifies no procedure for selecting among them** — the architecture simply has no instance-disambiguation step, because its design premise is that each text prompt maps to exactly one object.
- Pose: ICP registration between assembly/disassembly point clouds → precise `[R,T]`
- Grasp: AnyGrasp, filtered by detection mask
- **Motion (Eq. 7)**: reorient in place → 4-step decelerating straight-line interpolation (`P+0.8T, +0.92T, +0.96T, +T`) → gripper open/close. Applied once for pick, once for place. **No collision checking, no joint-limit checking, no lift/transit/descend decomposition.**
- Despite rich verb vocabulary at Module A (screw/insert/wrap), Module B only ever executes generic pick-and-place — there is no distinct rotational/torque motion primitive anywhere in the implementation.
- Ambiguity in paper: `P` is described as "adjacent gripper location," leaving unclear how the arm transits from a distant prior pose to this local start point. **Our implementation decision: treat T as the full displacement from the gripper's actual current position, applying Eq.7 across the whole motion** (most literal reading; also maximizes exposure of the no-collision-avoidance property, which is what we want to test).

---

## 3. Key finding: the method has no mechanism for duplicate/redundant object disambiguation

Module B's object grounding is entirely name-based (text query → detector). The paper's own evaluation (127-image drawing dataset, 5-product DiffRedMax sim, 5-step real robot gearbox) **never once includes duplicate or distractor objects** — every evaluated object is uniquely nameable (distinct colors/parts). There is no described mechanism for choosing among multiple detections of the same query, nor any concept of pick order among indistinguishable instances.

**Conclusion**: this is a structural limitation of the method, confirmed both by the grounding mechanism described in §2 (single-pass name→detector query, no disambiguation stage) and by its own published evaluation scope — not an artifact of a harder test we are imposing. The gap is categorical, not a matter of degree: the method does not have a weak instance-selection mechanism, it has none. This makes the method's semantic/matching layer **inherently, non-comparably weaker than ours under redundancy**, and we choose not to force a comparison there.

---

## 4. Comparison protocol (two decoupled tracks)

### Track 1 — semantic/matching layer accuracy (standalone, non-redundant only)
- Evaluated **only on non-redundant, visually/nominally distinguishable-object scenarios**, matching the conditions the original paper itself validated under.
- Compares: baseline's 3-stage triple output vs. our own high-level VLM module's structured graph output, given **identical VLM input** (one image; no coordinates given to either side — this matches what our own high-level module actually receives, per `phase1_graph_planner.md`).
- Under redundancy: **excluded from comparison by design**. Documented reason: the baseline's open-vocabulary text-to-object matching has no defined disambiguation behavior for duplicate objects, and the original paper never tested this condition either. Reporting a number here would not be a meaningful comparison.
- This track produces a supplementary/contextual accuracy number, not part of the core feasibility claim.

**Track 1 sampling protocol (decided 2026-08-17, before running — not post-hoc):**
- Axes kept at full coverage: magnitude tiers (cube n=4..8, FMB n=3..5 → 8 configs) × 5 scenario variants.
- Seeds reduced from the 10 used in the main matrix to **1 per scenario**. Rationale: Track 1 is explicitly supplementary and does not carry the core feasibility claim, so it does not need the statistical power of Track 2; seeds only add within-tier image resampling, which is the least informative axis here.
- Total: 8 configs × 5 scenarios × 1 seed × 2 methods = **80 VLM calls** (reducible to ~40 new calls if our own method's existing non-redundant runs can be reused rather than re-run — check before executing).
- **Reporting rule, fixed in advance**: report Track 1 as **pooled accuracy per benchmark per method** (N=25 cube, N=15 FMB), *not* as per-configuration accuracy curves. At N=5 per config cell, per-tier trend claims ("accuracy degrades as n grows") would not be statistically supportable, and presenting them as a trend would overstate the evidence. If a per-tier trend claim is later wanted, seeds must be increased first and the change recorded here.
- Applies to Track 1 only. Track 2 keeps the full matrix unchanged (see below).

### Track 2 — execution-layer feasibility (primary experimental matrix)
- **Both methods receive an identical, externally-given task assignment** (which object, from which pose, to which pose, in which step order) — sourced from our own method's/ground-truth output. Neither method's own upstream reasoning determines this assignment for Track 2 purposes.
- This sidesteps the Track 1 limitation entirely: redundant objects are simply static clutter in the workspace during Track 2, not something either method needs to "recognize" or "disambiguate."
- Only the trajectory-generation step differs: baseline uses Eq.7 naive straight-line interpolation (no constraint checking), ours uses LGP constrained optimization.
- Full existing experiment matrix applies, matching the protocol already used in the paper body (`bare_jrnl.tex`: 5 scenarios × 10 seeds = 50 trials per configuration): `benchmark ∈ {cube, fmb}` × `task_size_n` (**cube: 4..8; FMB: 3..5** — the benchmarks have different tier ranges, per `experiments/configs/`) × `redundancy_ratio ∈ {1x, 2x}` × 5 scenario variants × 10 seeds.
- Metrics: success rate, failure_code taxonomy (collision_violation among them), solve_time — same schema as `run_records.jsonl`.
- This is the core evidence for the paper's central claim (LGP guarantees feasibility; naive execution does not), and it is the cleanest possible design because the only varying factor is the execution strategy.

---

## 5. Guardrails (must hold for the comparison to be defensible)

1. Both methods evaluated on **the exact same scene files** per scenario — no separate "easier" or "harder" scene set per method.
2. **Full matrix reported**, not cherry-picked cells — including cases where the baseline performs adequately.
3. Any new scenario axis (e.g., tighter `min_center_distance` packing) must be **defined before running**, not selected post-hoc after seeing which parameter makes the baseline fail more.
4. If a comparably capable VLM backbone is used for the baseline's Module A (Track 1), it must be **the same tier of model** used for our own method — no deliberately weak backbone.
5. Baseline implementation choices (Section 2 above) must be **faithful to the paper's described formulas**, not weakened beyond what the paper specifies.

---

## 6. Module A implementation decision: single VLM call

The paper's Module A is literally a chain of 5 agent roles across 3 stages. **We implement it as one VLM call** whose `REASONING_DRAFT` contains the five roles as explicit ordered sections (Relation Narrator + Image Narrator → Base Searcher + Action Narrator → Triple Extractor), each producing its intermediate output before the next consumes it.

Justification (record this in the paper's method description, do not leave it implicit):
- **Compute parity is the fairness-critical property, not call count.** Our own high-level module (`phase1_graph_planner.md`) is a single call. Giving the baseline five sequential calls would hand it a larger inference budget than our method receives, which would bias Track 1 in the *baseline's* favour and make the comparison unclean in the opposite direction.
- All five roles' reasoning steps are preserved and separately observable in the output, so the method's structure — staged relation extraction, anchor identification, reordering, self-review — is reproduced, not collapsed.
- Consistent with the repo's existing convention for multi-step reasoning prompts.

Trade-off accepted: error propagation between stages is somewhat weaker within one call than across independent calls (shared context lets later stages see earlier reasoning). If a reviewer challenges the simplification, the fallback is to split into 5 prompt files + multi-call driver and re-run Track 1 only — Track 2 is unaffected either way since it does not use Module A output.

---

## 7. Open implementation items

- Locate the existing collision/feasibility checker used by the LGP pipeline, to reuse for scoring Track 2's naive-interpolation trajectories.
- Confirm which script actually implements the `--mode <name>` dispatch referenced in `methods.yaml` (root `driver.py` does not currently expose this flag — may be `driver_gemini_mainline.py` or another entry point).
- Decide Cube Stacking object-labeling scheme (whether cubes get distinguishing IDs/legend in the prompt) — affects whether Track 1 is meaningful for Cube Stacking specifically.
