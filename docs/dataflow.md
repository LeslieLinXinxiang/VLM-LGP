# Dataflow and Data Ownership (Layer 2)

## 1. Data Entities
- **Scene Configurations**: `.g` files defining shapes, positions, joints.
- **Task Logic**: `.fol` and `.lgp` files dictating symbol steps (e.g., `pick_touch`, `place_on_multi_support`).
- **Optimization States**: Continuous joint angles and velocities across timelines (KOMO structures).
- **Output Trajectories**: Resampled text files containing Pos, Vel, Acc.

## 2. Data Producers
- The **User/VLM**: Produces initial `.fol` and `.g` definitions.
- **LGP_TAMP**: Produces the motif sequences and symbolic plan.
- **KOMO Solver**: Produces the unrefined continuous trajectory.
- **Main `resampleAndPrint`**: Produces the final 1000Hz 21-dim trajectory file.

## 3. Data Consumers
- **KOMO Solver**: Consumes scene configuration and logic states to build non-linear optimization trees.
- **Python Viewer (`view_full_assembly.py`)**: Consumes the final `output_state.g` to visualize results.

## 4. Flow Diagram (Textual)
`User Logic (.fol)` -> `LGP Core` -> `Motif & Symbol Plan` -> `KOMO (manipTools)` -> `Optimization Solver` -> `Raw Joint Frames` -> `Main executable` -> `1000Hz Trajectory.txt` & `output_state.g`.

## 5. Data Ownership Rules
- `manipTools.cpp` exclusively owns the mathematical definition of physical contacts and manipulation constraints.
- The Git repository exclusively owns the version history. No code shall bypass version control.
