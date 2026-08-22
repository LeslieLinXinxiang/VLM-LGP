# VLM-MSGraph Baseline — Track 1 Manual Review Summary

> **Track 1 only**: semantic/matching-layer accuracy on non-redundant scenarios,
> matching the conditions the source paper validated under. Redundant scenarios are
> excluded by design (the baseline has no instance-disambiguation mechanism — see
> design doc §3). This is a supplementary number, not the paper's core claim.
>
> Sampling: 8 configs x 5 scenarios x 1 seed = 40 trials. Scored manually against the
> input image (Correct=1 / Wrong=0); no automated GT is used at this stage.

## Pooled accuracy per benchmark (the reportable numbers)

| Benchmark    | Pooled Correct/Total | Pooled Accuracy | Wilson 95% CI  | Format Compliance |
| ------------ | -------------------- | --------------- | -------------- | ----------------- |
| cubeStacking | 46/50                | 92.0%           | [81.2%, 96.8%] | 100.0% (50/50)    |
| FMB          | 14/30                | 46.7%           | [30.2%, 63.9%] | 100.0% (30/30)    |

**Overall across both benchmarks**: 75.0% (60/80),
Wilson 95% [64.5%, 83.2%]

Scored / indexed: 80 / 80

## Two numbers, kept separate

| Number | What it measures | Source |
| ------ | ---------------- | ------ |
| Content accuracy | Does the ordered sequence match the image? | this manual review |
| Format compliance | Is the output a well-formed instance of the schema? | `validate_baseline_vlm_msgraph_format.py` (no GT) |

A trial can pass format and fail content, or the reverse. Never merge them into one
"accuracy" figure.

## Trials scored WRONG (content)

- `cubeStacking/5cubes/cube_n05_s02/trial_01`
- `cubeStacking/6cubes/cube_n06_s04/trial_01`
- `cubeStacking/7cubes/cube_n07_s01/trial_02`
- `cubeStacking/8cubes/cube_n08_s04/trial_01`
- `FMB/3objs/001/trial_01`
- `FMB/3objs/004/trial_02`
- `FMB/4objs/001/trial_02`
- `FMB/4objs/003/trial_02`
- `FMB/4objs/004/trial_01`
- `FMB/4objs/004/trial_02`
- `FMB/4objs/005/trial_01`
- `FMB/5objs/001/trial_01`
- `FMB/5objs/001/trial_02`
- `FMB/5objs/002/trial_01`
- `FMB/5objs/003/trial_01`
- `FMB/5objs/003/trial_02`
- `FMB/5objs/004/trial_01`
- `FMB/5objs/004/trial_02`
- `FMB/5objs/005/trial_01`
- `FMB/5objs/005/trial_02`

## Trials failing format compliance

- (none)

## Unscored

- (none — all trials scored)
