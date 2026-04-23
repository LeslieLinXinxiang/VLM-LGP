# Copilot instructions for VLM-LGP

## Runtime first (required)
- Run repository commands in the project runtime shell: activate `vlm_jazzy` conda env, then `source scripts/env.sh`.
- `scripts/env.sh` exports `PYTHONPATH`/`LD_LIBRARY_PATH` for `rai` and loads secrets from `.env`.
- Missing env setup commonly causes `cv2` import errors or missing VLM keys.

## Big picture architecture
- This is a closed-loop TAMP stack: Phase0 (scene binding) -> Phase1 (target graph) -> Phase2 (strategy + codegen + solve) -> execution bridge.
- Main orchestrator: `driver.py` (`SystemDriver`) calling `pipeline/run_phase0.py`, `pipeline/run_phase1.py`, `pipeline/run_phase2.py`.
- Solver boundary: Python writes `.fol/.lgp` tasks; C++ solver binary `bin/x.exe` executes tasks and emits trajectory text + `output_state.g`.
- Deterministic planning replaced most Phase2 VLM strategy logic: `core/graph_clustering.py` (`BranchAwareClustering`) now drives Prompt1/2 outputs.

## Data contracts you must preserve
- Canonical generated artifacts live under `generated/`:
  - `phase0_layout.json` (inventory dictionary), `infeasible_objects.json`, `phase1_target_graph.json`, `node_*_run/`, `scene/scene_named.g`.
- Phase1 modern schema is `{"objects": [...], "edges" via per-object edge entries}`; id `0` is table.
- `core/phase2_codegen.py` maps Phase1 IDs to scene names via `phase0_layout.json` (do not bypass this mapping).
- `pipeline/run_phase2.py` returns legacy tuple shape `(success, output_g, result_img, node_summary, used_ids, stdout)` used by `driver.py`.

## Critical workflow commands
- Build native solver: `cd bin && make -j$(nproc)` (Docker headless variant: `cd docker_bin && make -j$(nproc)`).
- End-to-end main loop: `python3 driver.py`.
- Planar benchmark: `python3 scripts/run_planar_assembly.py`.
- Pyramid benchmark: `python3 scripts/run_pyramid_assembly.py`.
- Scene viewer: `python3 scripts/view_scene.py <path/to/output_state.g>`.

## Project-specific coding patterns
- Prefer deterministic graph path for Phase2; avoid reintroducing VLM-based strategy selection unless explicitly requested.
- Keep dual-schema compatibility where already implemented (`objects` new schema + `assembly_nodes` legacy fallback), especially in `pipeline/run_phase1.py` validators.
- Phase0 is now rule-based (`build_phase0_layout_from_unnamed_g`); `use_vlm=True` is deprecated and intentionally ignored.
- Keep file-path normalization logic intact in Phase0 (`_normalize_scene_include`) because solver scene includes are sensitive.
- `driver.py` mutates `inventory_data` status (`available`/`used`) across nodes; do not convert this to immutable copies.

## Integration boundaries
- Native execution bridge: `core/ros2_bridge.py` (ROS2 action clients for arm/gripper).
- Docker split-brain bridge: `core/zmq_bridge.py` (REQ/REP to host at `tcp://localhost:5555`).
- Solver subprocess wrapper and stdout capture: `core/solver_bridge.py`.
- VLM backend switch is environment-driven in `core/vlm.py` (`VLM_BACKEND=qwen|gemini`).

## Documentation and governance in this repo
- Architecture truth is maintained in `docs/architecture.md`, `docs/dataflow.md`, `docs/execution_protocol.md`.
- When changes alter behavior/contracts, update the corresponding docs layer files in the same PR.
- Existing governance docs request RFC/approval flow before major edits; align with current maintainer instructions in task discussions.
