        # Cross-Magnitude Accuracy Comparison — Gemini Proposed Method

        > Each case's accuracy = % of valid trials whose FINAL_PDDL block matches the selected reference trial.

        | Magnitude | Cases | Avg Accuracy | Min  | Max  |
| --------- | ----- | ------------ | ---- | ---- |
| 4cubes    | 5     | 100.0%       | 100% | 100% |
| 5cubes    | 5     | 100.0%       | 100% | 100% |
| 6cubes    | 5     | 100.0%       | 100% | 100% |
| 7cubes    | 5     | 98.0%        | 90%  | 100% |
| 8cubes    | 5     | 92.0%        | 70%  | 100% |

        **Overall Average Accuracy: 98.0%**

        ---

        ## Notes
        - Reference answer selection:
          - Find the answer with the highest support rate across all trials.
          - If multiple answers have equal high support, pick the one whose first trial appears earliest.
        - Trial range analyzed: `trial_02.md` → `trial_11.md`.
        - Graph comparison is id-numbering-independent (`canonicalize_graph`): two
          trials that agree on every object's type/color/supporter-set/position but
          assign different sequential `id`s (an artifact of scan order, not a real
          structural difference) are treated as the same answer. An earlier version
          of this script compared raw JSON text instead, which could fragment a
          correct majority across multiple id-orderings and let a wrong minority win
          the GT vote by coincidence — this was confirmed for FMB `3objs/004` and this
          fix was ported here to check cube for the same failure mode.
        - Manual override: `cube_n07_s01` (7cubes) is scored 100% instead of the raw
          50% GT-vote result. See its accuracy_report.md footnote for the reasoning —
          the automated vote split it 5/10 vs 5/10 between two topologies that manual
          image review confirmed are *both* geometrically valid readings of the same
          structure, not a VLM error.
