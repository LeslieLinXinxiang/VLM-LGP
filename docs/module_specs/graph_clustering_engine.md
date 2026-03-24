# Module Spec: Graph Clustering Engine

## 1. Module Name
Graph Clustering Engine

## 2. Responsibility
Provide deterministic graph decomposition and strategy ordering for object manipulation
tasks, replacing VLM-only strategy selection in Phase2 planning.

## 3. Inputs
- `generated/phase0_layout.json`
- `generated/phase1_target_graph*.json`
- Parsed scene semantics from `.g`-derived object dictionaries

## 4. Outputs
- Deterministic strategy candidates and selected execution ordering
- Intermediate clustering metadata used by Phase2 orchestration

## 5. Public Functions
- `BranchAwareLayerCuttingClustering` (current default entry class for clustering and ordering)
- `BranchAwareClustering` (legacy fallback entry, kept for quick rollback/comparison)
- Phase2 integration entry in `pipeline/run_phase2.py` for strategy generation

## 6. Internal Functions
- Topology-aware grouping utilities
- Layer-aware branch cutting utilities
- Inventory binding and object-name normalization helpers
- Deterministic ordering/scoring helpers

## 7. Dependencies
- Python runtime in project environment
- `core/graph_clustering.py`
- `core/utils.py` and Phase0/Phase1 generated artifacts

## 8. Forbidden Dependencies
- Direct dependency on C++ solver internals (`rai/src/KOMO/*`)
- Hard dependency on external VLM calls for final ordering decisions

## 9. Failure Modes
- Invalid or incomplete graph JSON leads to empty or degraded strategy set
- Object inventory mismatch causes binding failure and fallback behavior
- Missing upstream artifacts (`phase0_layout`, `phase1_target_graph`) blocks execution
