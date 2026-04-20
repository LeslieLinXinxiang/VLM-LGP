# Manifest Schema (JSONL)

Each line in manifest is one JSON object representing one experiment case.

## Required Fields

- `benchmark`: `cube` or `fmb`
- `task_size_n`: integer in `[4,5,6,7,8]`
- `redundancy_ratio`: `1x` or `2x`
- `scenario_id`: string
- `repeat_id`: integer
- `random_seed`: integer
- `method_id`: string key from `methods.yaml`
- `input_scene_g_path`: path string
- `input_task_graph_path`: path string
- `prompt_version`: string
- `predicate_count`: integer

## Optional Fields

- `timeout_sec`: integer
- `overrides`: object for method-specific override variables
- `notes`: string
- `input_image_path`: frozen target image path
- `input_bundle_id`: bundle id for frozen mapping (image + scene + task graph)
- `input_freeze_version`: freeze version tag

## Minimal Example

```json
{"benchmark":"cube","task_size_n":4,"redundancy_ratio":"1x","scenario_id":"cube_n4_r1x_s01","repeat_id":1,"random_seed":1001,"method_id":"proposed","input_scene_g_path":"generated/scenes/cube_n4_r1x_s01.g","input_task_graph_path":"generated/tasks/cube_n4_r1x_s01.json","prompt_version":"phase2_v20260420","predicate_count":12}
```

## Variable Interpolation for Method Commands

The batch runner replaces placeholders in command templates:
- `{benchmark}`
- `{task_size_n}`
- `{redundancy_ratio}`
- `{scenario_id}`
- `{repeat_id}`
- `{random_seed}`
- `{input_scene_g_path}`
- `{input_task_graph_path}`
- `{prompt_version}`

Any value from `overrides` is also available as `{key}`.
