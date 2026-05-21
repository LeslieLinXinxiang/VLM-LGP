        # Cross-Magnitude Accuracy Comparison — Image Reasoning (VLM)

        > Each case's accuracy = % of valid trials whose FINAL_PDDL block matches the selected reference trial.

| Magnitude | Cases | Avg Accuracy | Min | Max  |
| --------- | ----- | ------------ | --- | ---- |
| 4cubes    | 5     | 84.0%        | 30% | 100% |
| 5cubes    | 5     | 64.0%        | 40% | 90%  |
| 6cubes    | 5     | 76.0%        | 40% | 100% |
| 7cubes    | 5     | 92.0%        | 90% | 100% |
| 8cubes    | 5     | 64.0%        | 20% | 100% |

        **Overall Average Accuracy: 76.0%**

        ---

        ## Notes
        - Reference answer selection:
          - Scan `trial_01.md` → `trial_10.md` in order.
          - Use the first valid `FINAL_PDDL` block whose support rate is not 10%.
          - If every unique candidate is 10%, fall back to the first valid trial.
