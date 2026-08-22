# Manual Content Accuracy — cubeStacking / 6cubes

> **Descriptive only.** N=10 at this magnitude (may span multiple trials per
> case). Per the Track 1 reporting rule fixed before running, accuracy is reported
> *pooled per benchmark*; this per-magnitude cell is here to locate individual
> failures, not to support a per-tier trend claim.
>
> "How scored" of `auto_match_trial01` means this trial's ordered_triples was
> auto-verified identical to a trial_01 already confirmed correct — see
> `diff_vlm_msgraph_trial_vs_reference.py` — not independently re-reviewed by a human.

| Case         | Trial | Score | How scored         | Result    |
| ------------ | ----- | ----- | ------------------ | --------- |
| cube_n06_s01 | 01    | 1     | correct            | ✓ correct |
| cube_n06_s01 | 02    | 1     | auto_match_trial01 | ✓ correct |
| cube_n06_s02 | 01    | 1     | correct            | ✓ correct |
| cube_n06_s02 | 02    | 1     | auto_match_trial01 | ✓ correct |
| cube_n06_s03 | 01    | 1     | correct            | ✓ correct |
| cube_n06_s03 | 02    | 1     | auto_match_trial01 | ✓ correct |
| cube_n06_s04 | 01    | 0     | wrong              | ✗ wrong   |
| cube_n06_s04 | 02    | 1     | correct            | ✓ correct |
| cube_n06_s05 | 01    | 1     | correct            | ✓ correct |
| cube_n06_s05 | 02    | 1     | auto_match_trial01 | ✓ correct |

- Accuracy at this magnitude: **90.0%** (9/10)
- Benchmark pooled accuracy (the number to quote): **92.0%** (46/50)
