# FMB Input Audit Report

- Trials scanned: 45
- OK trials: 23
- Fatal trials: 22
- Fatal issues: 22
- Info issues: 0

## Issue counts by category
- scene_extra_objects: 22

## Trial-level status
| Trial | Status | Issues |
| --- | --- | ---: |
| 3objs/s001/trial_01_nr/lgp_split_global | OK | 0 |
| 3objs/s001/trial_01_nr/lgp_split_smart | OK | 0 |
| 3objs/s001/trial_01_r/lgp_split_global | FATAL | 1 |
| 3objs/s001/trial_01_r/lgp_split_smart | FATAL | 1 |
| 3objs/s001/trial_02_nr/lgp_split_global | OK | 0 |
| 3objs/s001/trial_02_nr/lgp_split_smart | OK | 0 |
| 3objs/s001/trial_02_r/lgp_split_global | FATAL | 1 |
| 3objs/s001/trial_02_r/lgp_split_smart | FATAL | 1 |
| 3objs/s001/trial_03_nr/lgp_split_global | OK | 0 |
| 3objs/s001/trial_03_nr/lgp_split_smart | OK | 0 |
| 3objs/s001/trial_03_r/lgp_split_global | FATAL | 1 |
| 3objs/s001/trial_03_r/lgp_split_smart | FATAL | 1 |
| 3objs/s001/trial_04_nr/lgp_split_global | OK | 0 |
| 3objs/s001/trial_04_nr/lgp_split_smart | OK | 0 |
| 3objs/s001/trial_04_r/lgp_split_global | FATAL | 1 |
| 3objs/s001/trial_04_r/lgp_split_smart | FATAL | 1 |
| 3objs/s001/trial_05_nr/lgp_split_global | OK | 0 |
| 3objs/s001/trial_05_nr/lgp_split_smart | OK | 0 |
| 3objs/s001/trial_05_r/lgp_split_global | FATAL | 1 |
| 3objs/s001/trial_05_r/lgp_split_smart | FATAL | 1 |
| 3objs/s001/trial_06_nr/lgp_split_global | OK | 0 |
| 3objs/s001/trial_06_nr/lgp_split_smart | OK | 0 |
| 3objs/s001/trial_06_r/lgp_split_global | FATAL | 1 |
| 3objs/s001/trial_06_r/lgp_split_smart | FATAL | 1 |
| 3objs/s001/trial_07_nr/lgp_split_global | OK | 0 |
| 3objs/s001/trial_07_nr/lgp_split_smart | OK | 0 |
| 3objs/s001/trial_07_r/lgp_split_global | FATAL | 1 |
| 3objs/s001/trial_07_r/lgp_split_smart | FATAL | 1 |
| 3objs/s001/trial_08_nr/lgp_split_global | OK | 0 |
| 3objs/s001/trial_08_nr/lgp_split_smart | OK | 0 |
| 3objs/s001/trial_08_r/lgp_split_global | FATAL | 1 |
| 3objs/s001/trial_08_r/lgp_split_smart | FATAL | 1 |
| 3objs/s001/trial_09_nr/lgp_split_global | OK | 0 |
| 3objs/s001/trial_09_nr/lgp_split_smart | OK | 0 |
| 3objs/s001/trial_09_r/lgp_split_global | FATAL | 1 |
| 3objs/s001/trial_09_r/lgp_split_smart | FATAL | 1 |
| 3objs/s001/trial_10_nr/lgp_split_global | OK | 0 |
| 3objs/s001/trial_10_nr/lgp_split_smart | OK | 0 |
| 3objs/s001/trial_10_r/lgp_split_global | FATAL | 1 |
| 3objs/s001/trial_10_r/lgp_split_smart | FATAL | 1 |
| 3objs/s002/trial_01_nr/lgp_split_global | OK | 0 |
| 3objs/s002/trial_01_nr/lgp_split_smart | OK | 0 |
| 3objs/s002/trial_01_r/lgp_split_global | FATAL | 1 |
| 3objs/s002/trial_01_r/lgp_split_smart | FATAL | 1 |
| 3objs/s002/trial_02_nr/lgp_split_smart | OK | 0 |

## Detailed issues
- **FATAL** [scene_extra_objects] 3objs/s001/trial_01_r/lgp_split_global — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_01_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_01_r/lgp_split_smart — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_01_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_02_r/lgp_split_global — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_02_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_02_r/lgp_split_smart — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_02_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_03_r/lgp_split_global — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_03_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_03_r/lgp_split_smart — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_03_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_04_r/lgp_split_global — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_04_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_04_r/lgp_split_smart — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_04_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_05_r/lgp_split_global — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_05_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_05_r/lgp_split_smart — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_05_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_06_r/lgp_split_global — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_06_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_06_r/lgp_split_smart — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_06_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_07_r/lgp_split_global — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_07_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_07_r/lgp_split_smart — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_07_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_08_r/lgp_split_global — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_08_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_08_r/lgp_split_smart — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_08_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_09_r/lgp_split_global — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_09_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_09_r/lgp_split_smart — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_09_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_10_r/lgp_split_global — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_10_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s001/trial_10_r/lgp_split_smart — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s001/random_trials/trial_10_r.g
  - Evidence: `{"extra": ["shape_2_3", "shape_2_4", "shape_4_2"], "expected": ["shape_2_1", "shape_2_2", "shape_4_1"], "actual": ["shape_2_1", "shape_2_2", "shape_2_3", "shape_2_4", "shape_4_1", "shape_4_2"]}`
- **FATAL** [scene_extra_objects] 3objs/s002/trial_01_r/lgp_split_global — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s002/random_trials/trial_01_r.g
  - Evidence: `{"extra": ["shape_2_2", "shape_4_3", "shape_4_4"], "expected": ["shape_2_1", "shape_4_1", "shape_4_2"], "actual": ["shape_2_1", "shape_2_2", "shape_4_1", "shape_4_2", "shape_4_3", "shape_4_4"]}`
- **FATAL** [scene_extra_objects] 3objs/s002/trial_01_r/lgp_split_smart — Scene contains extra task objects not present in FINAL_JSON
  - Path: /home/leslie/Projects/VLM_LGP/experiments/scenes/fmb/3objs/s002/random_trials/trial_01_r.g
  - Evidence: `{"extra": ["shape_2_2", "shape_4_3", "shape_4_4"], "expected": ["shape_2_1", "shape_4_1", "shape_4_2"], "actual": ["shape_2_1", "shape_2_2", "shape_4_1", "shape_4_2", "shape_4_3", "shape_4_4"]}`
