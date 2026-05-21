        # Cross-Magnitude Accuracy Comparison — Gemini Proposed Method

        > Each case's accuracy = % of valid trials whose FINAL_PDDL block matches the selected reference trial.

        | Magnitude | Cases | Avg Accuracy | Min  | Max  |
| --------- | ----- | ------------ | ---- | ---- |
| 4cubes    | 5     | 100.0%       | 100% | 100% |
| 5cubes    | 5     | 100.0%       | 100% | 100% |
| 6cubes    | 5     | 100.0%       | 100% | 100% |
| 7cubes    | 5     | 88.0%        | 50%  | 100% |
| 8cubes    | 5     | 92.0%        | 70%  | 100% |

        **Overall Average Accuracy: 96.0%**

        ---

        ## Notes
        - Reference answer selection:
          - Find the answer with the highest support rate across all trials.
          - If multiple answers have equal high support, pick the one whose first trial appears earliest.
                    - Trial range analyzed: `trial_02.md` → `trial_11.md`.
