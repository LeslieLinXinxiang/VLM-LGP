# Dataflow and Data Ownership (Layer 2)

## 1. Data Entities
- **Scene Configurations**: `.g` files defining shapes, positions, joints.
- **Phase0 Reachability Map**: `generated/infeasible_objects.json` dictating which objects are unreachable due to single-frame bounds.
- **Phase0 VLM Inputs**: `generated/phase0_capture.png`, `generated/phase0_specs.json`, and the selected Phase0 prompt markdown file passed into `VLMClient.match_objects(...)`.
- **Phase0 Semantic Layout**: `generated/phase0_layout.json` containing the VLM semantic matching results before later graph/strategy stages consume them.
- **Task Logic**: `.fol` and `.lgp` files dictating symbol steps (e.g., `pick_touch`, `place_on_multi_support`).
- **Optimization States**: Continuous joint angles and velocities across timelines (KOMO structures).
- **Output Trajectories**: Resampled text files containing Pos, Vel, Acc.

## 2. Data Producers
- The **User/Phase0 Builder**: Produces initial scene assets plus `phase0_specs.json` and the Phase0 prompt selection.
- **VLMClient (`core/vlm.py`)**: Produces `phase0_layout.json` from the Phase0 capture image, specs JSON, and prompt file.
- **LGP_TAMP**: Produces the motif sequences and symbolic plan.
- **KOMO Solver**: Produces the unrefined continuous trajectory.
- **Main `resampleAndPrint`**: Produces the final 1000Hz 21-dim trajectory file.

## 3. Data Consumers
- **Phase0 / Phase1 bridge code**: Consumes `phase0_layout.json` to construct named scene/layout structures for later symbolic reasoning.
- **KOMO Solver**: Consumes scene configuration and logic states to build non-linear optimization trees.
- **Python Viewer (`view_full_assembly.py`)**: Consumes the final `output_state.g` to visualize results.

## 4. Flow Diagram (Textual)
`Phase0 Reachability Check` -> `phase0_layout.json` & `infeasible_objects.json` -> `Manipulability Ranking` -> `VLMClient.match_objects(...)` -> `Branch-Aware Clustering` -> `Deterministic Strategy` -> `LGP Core / Python bridge` -> `Motif & Symbol Plan` -> `KOMO (manipTools)` -> `Optimization Solver` -> `Raw Joint Frames` -> `Main executable` -> `1000Hz Trajectory.txt` & `output_state.g` & `active_collision_history/report_xxx.json`.

## 5. Data Ownership Rules
- `manipTools.cpp` exclusively owns the mathematical definition of physical contacts and manipulation constraints.
- The Git repository exclusively owns the version history. No code shall bypass version control.

## 6. Dataflow Optimization (Current)
- Strategy generation/decision has been migrated from VLM-centric outputs to deterministic **Branch-Aware Topological Clustering**, significantly reducing hallucination.
- Euclidean distance checks and geometric layout consensus are now governed by direct `.g` scene parsing and inventory dictionary binding, removing latent VLM geometric estimation noise.
