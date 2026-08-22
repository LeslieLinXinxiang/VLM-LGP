        # Cross-Magnitude Accuracy Comparison — Gemini Proposed Method (FMB)

        > Each case's accuracy = % of valid trials whose FINAL_JSON block matches the selected reference trial.

        | Magnitude | Cases | Avg Accuracy | Min  | Max  |
| --------- | ----- | ------------ | ---- | ---- |
| 3objs     | 5     | 94.0%        | 70%  | 100% |
| 4objs     | 5     | 100.0%       | 100% | 100% |
| 5objs     | 5     | 88.0%        | 70%  | 100% |

        **Overall Average Accuracy: 94.0%**

        ---

        ## Notes
        - Reference answer selection:
          - Find the answer with the highest support rate across all trials.
          - If multiple answers have equal high support, pick the one whose first trial appears earliest.
        - Trial range analyzed: `trial_01.md` → `trial_10.md`.
        - Graph comparison is id-numbering-independent (`canonicalize_graph`): two
          trials that agree on every object's type/color/supporter-set/position but
          assign different sequential `id`s (an artifact of scan order, not a real
          structural difference) are treated as the same answer. An earlier version
          of this script compared raw JSON text instead, which could fragment a
          correct majority across multiple id-orderings and let a wrong minority win
          the GT vote by coincidence — this happened for `3objs/004` (see git history
          of this file / accuracy_report.md for that case).
        - Color is not scored: two trials describing the same object at the same
          structural position (same supporters, same position label) count as the
          same answer regardless of what color name each used (e.g. "purple" vs
          "magenta" for one RGB(255,52,255) swatch — verified by pixel sampling on
          `3objs/005`). Color only exists in the schema so the VLM can tell apart
          simultaneously-present same-type objects in its own reasoning; it is not a
          placement fact.
        - Position on a multi-supporter (bridging) edge is not scored: verified
          empirically against the real downstream consumer
          (`core.graph_clustering.KMeansBranchClustering`) that including vs. omitting
          a left/right label on a bridging edge only perturbs solver batch-grouping
          (batch *count* can differ), never build precedence or physical feasibility —
          `_build_dependency_safe_batches` enforces dependency-safe ordering regardless
          of raw cluster assignment. Affected `4objs/004` and `5objs/005`.
        - Single-supporter position (e.g. front/back on an object resting directly on
          base) is still scored: it is the only thing distinguishing otherwise-identical
          placements. One case (`5objs/003`) was investigated as a possible GT
          mis-selection (majority omits position on an edge that looked off-center) but
          pixel-measurement of the source image showed the disputed object's centerline
          sits within 0.2% of the base's centerline — the majority's "omit" is correct
          per the prompt's own centering rule, not a bug. Left unchanged at 70%.
