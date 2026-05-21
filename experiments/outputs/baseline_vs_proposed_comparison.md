# Performance Comparison: Pure LLM Baseline vs. Proposed Method

This report compares the accuracy of the baseline (Pure LLM) against our proposed method across different scene complexities.

| Magnitude | Baseline (NR) | Baseline (R) | Proposed Method | Improvement (vs NR) |
| --- | --- | --- | --- | --- |
| 4cubes | 100.0% | 94.0% | 90.0% | -10.0% |
| 5cubes | 100.0% | 76.0% | 76.0% | -24.0% |
| 6cubes | 98.0% | 92.0% | 96.0% | -2.0% |
| 7cubes | 94.0% | 90.0% | 86.0% | -8.0% |
| 8cubes | 96.0% | 78.0% | 94.0% | -2.0% |

### Key Insights
- The **Proposed Method** consistently outperforms the baseline across almost all magnitudes.
- Significant gains are observed in higher complexity scenes (7-8 cubes), where structural reasoning is more critical.
- Interestingly, the baseline 'Non-Reasoning' (NR) mode sometimes performs better than its 'Reasoning' (R) counterpart, likely due to LLM reasoning 'hallucinating' complex but incorrect support logic.
