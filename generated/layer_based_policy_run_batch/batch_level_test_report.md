# Batch-Level Layer-Based Codegen Test Report

- Input: generated/phase1_target_graph.json
- Output directory: generated/layer_based_policy_run_batch
- Planned batches: [[1, 2], [3, 4], [5, 6], [7], [8], [9]]
- Generated file pairs: 6

## Logic

1. Reuse the current layer-based planner.
2. Keep the batch structure intact.
3. Generate one .fol/.lgp pair per batch.
4. Put all object terminals of the batch into one LGP terminal line.

## File layout

Each batch becomes: `step_<n>_batch_1.fol` and `step_<n>_batch_1.lgp`.
