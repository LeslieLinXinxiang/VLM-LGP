# Manual Content Accuracy — FMB / 5objs

> **Descriptive only.** N=10 at this magnitude (may span multiple trials per
> case). Per the Track 1 reporting rule fixed before running, accuracy is reported
> *pooled per benchmark*; this per-magnitude cell is here to locate individual
> failures, not to support a per-tier trend claim.
>
> "How scored" of `auto_match_trial01` means this trial's ordered_triples was
> auto-verified identical to a trial_01 already confirmed correct — see
> `diff_vlm_msgraph_trial_vs_reference.py` — not independently re-reviewed by a human.

| Case | Trial | Score | How scored | Result    |
| ---- | ----- | ----- | ---------- | --------- |
| 001  | 01    | 0     | wrong      | ✗ wrong   |
| 001  | 02    | 0     | wrong      | ✗ wrong   |
| 002  | 01    | 0     | wrong      | ✗ wrong   |
| 002  | 02    | 1     | correct    | ✓ correct |
| 003  | 01    | 0     | wrong      | ✗ wrong   |
| 003  | 02    | 0     | wrong      | ✗ wrong   |
| 004  | 01    | 0     | wrong      | ✗ wrong   |
| 004  | 02    | 0     | wrong      | ✗ wrong   |
| 005  | 01    | 0     | wrong      | ✗ wrong   |
| 005  | 02    | 0     | wrong      | ✗ wrong   |

- Accuracy at this magnitude: **10.0%** (1/10)
- Benchmark pooled accuracy (the number to quote): **46.7%** (14/30)
