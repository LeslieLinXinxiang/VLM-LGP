# Cross-Magnitude Accuracy Comparison — Proposed Method (VLM)

> Each case's accuracy = % of 10 trials whose graph topology matches the designated ground truth trial.

| Magnitude | Cases | Avg Accuracy | Min | Max  |
| --------- | ----- | ------------ | --- | ---- |
| 4cubes    | 5     | 90.0%        | 70% | 100% |
| 5cubes    | 5     | 76.0%        | 60% | 100% |
| 6cubes    | 5     | 96.0%        | 80% | 100% |
| 7cubes    | 5     | 86.0%        | 30% | 100% |
| 8cubes    | 5     | 94.0%        | 80% | 100% |

**Overall Average Accuracy: 88.4%**

---

## Notes
- Ground truth overrides (manually verified):
  - `cube_n05_s02` → trial_02
  - `cube_n05_s03` → trial_03
  - `cube_n06_s04` → trial_02
  - `cube_n07_s02` → trial_02
- All others → trial_01
