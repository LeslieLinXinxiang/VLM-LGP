        # Cross-Magnitude Accuracy Comparison — Gemini Image Reasoning

        > Each case's accuracy = % of valid trials whose FINAL_PDDL block matches the selected reference trial.

| Magnitude | Cases | Avg Accuracy | Min  | Max  |
| --------- | ----- | ------------ | ---- | ---- |
| 4cubes    | 5     | 100.0%       | 100% | 100% |
| 5cubes    | 5     | 95.6%        | 78%  | 100% |
| 6cubes    | 5     | 100.0%       | 100% | 100% |
| 7cubes    | 5     | 95.6%        | 89%  | 100% |
| 8cubes    | 5     | 100.0%       | 100% | 100% |

        **Overall Average Accuracy: 98.2%**

        ---

        ## Notes
        - Reference answer selection:
          - Scan `trial_01.md` → `trial_01.md` in order.
          - Use the first valid `FINAL_PDDL` block whose support rate is not 10%.
          - If every unique candidate is 10%, fall back to the first valid trial.
