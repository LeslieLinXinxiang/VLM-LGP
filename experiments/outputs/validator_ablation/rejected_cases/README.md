# Validator-rejected trials — case record

Source replay: `experiments/outputs/validator_ablation/replay_20260913_012006.json`  
Cases: 4 of the 19 mis-scored trials in the 400-trial evaluation (the other 15 pass the validator and are unaffected by the retry loop).

The validator performs internal-consistency checks on the predicted graph only — it uses no ground truth about the target. Each case below was rejected, regenerated with the validator's error report as feedback, and the regenerated graph compared against the reference.

| Benchmark | Magnitude | Case | Wrong trial | Rules fired | Corrected answers | Net. fails excl. |
|---|---|---|---|---|---|---|
| FMB | 5objs | `001` | T04 | supporter.not_int, supporter.not_int | 10/10 | 9 |
| FMB | 5objs | `005` | T08 | geometry.mixed_layer | 10/10 | 18 |
| cubeStacking | 7cubes | `cube_n07_s05` | T11 | geometry.skipped_support | 10/10 | 6 |
| cubeStacking | 8cubes | `cube_n08_s04` | T11 | geometry.skipped_support | 10/10 | 9 |

**Corrected on regeneration: 40/40 answers (100.0%, Wilson 95% CI [91.2%, 100.0%]) across 4/4 cases.**

Each case was sampled until 10 real answers were collected, matching the 10-seeds-per-scenario protocol used throughout the evaluation, so the rate is comparable with the paper's other numbers.

Per-case JSON files in this directory carry the input image paths, the validator report, and the three graphs (originally wrong / reference / regenerated) verbatim.

## Reading the numbers

Network failures are excluded from every ratio above. A call that never returned is not a wrong answer; counting those as mismatches understated an earlier version of this experiment (see `core/vlm.py`'s retry note).

Two measurement bugs were fixed before these numbers were trusted, both of which had produced false failures:

1. `canonicalize_graph` compared the raw `object` type string, so a structurally identical graph that said "Long Rectangular Prism" instead of "Long RectPrism" scored as a mismatch. Type names are now normalized.
2. `ablation_validator_replay.py` passed only the first image of an FMB case. FMB inputs are image *sequences*; the model was being shown a subset of the structure and its answer correctly described only what it saw. All images are now passed, matching `run_gemini_proposed_method_fmb_eval.py`.
