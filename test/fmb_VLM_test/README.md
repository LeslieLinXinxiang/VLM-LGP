# fmb_VLM_test

Purpose:
- Batch-evaluate pasted VLM outputs for the current FMB task.
- Extract every `FINAL_JSON_START ... FINAL_JSON_END` block from each model `.txt`.
- Compare each extracted JSON against the fixed gold answer.
- Export accuracy statistics and an SVG bar chart.

Input Convention:
- Put all model output files directly under `test/fmb_VLM_test/`.
- Each `.txt` filename is treated as the model name.
- One `.txt` may contain multiple pasted raw outputs.
- Recommended: separate each pasted output with a single line `---`.
- Legacy compatibility: if no `---` is present, the script falls back to old-style `FINAL_JSON_START ... FINAL_JSON_END` block grouping.
- Inside each sample, exactly one `FINAL_JSON_START ... FINAL_JSON_END` block is required.

Gold Answer:
- The script contains the current fixed gold answer set internally.
- A candidate is marked correct if it matches any one gold answer after normalization.
- Formatting differences such as spaces, indentation, line breaks, and JSON object key order do not affect correctness.
- The script normalizes `objects` by `id` and normalizes `edges` by `(supporter, position)` before comparison.

Run:
```bash
python3 test/fmb_VLM_test/evaluate_fmb_vlm_accuracy.py
```

Outputs:
- `test/fmb_VLM_test/outputs/accuracy_summary.json`
- `test/fmb_VLM_test/outputs/accuracy_summary.csv`
- `test/fmb_VLM_test/outputs/detailed_results.json`
- `test/fmb_VLM_test/outputs/accuracy_bar_chart.svg`

Notes:
- Samples without a valid `FINAL_JSON_START ... FINAL_JSON_END` block are counted as `format_error`, and still remain in the denominator.
- The SVG chart ranks models by accuracy from high to low.
- `detailed_results.json` records which gold answer was matched for each correct sample.
