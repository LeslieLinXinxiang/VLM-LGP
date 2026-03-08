# System Architecture (Layer 1)

## 1. System Overview
VLM-LGP is a hybrid TAMP (Task and Motion Planning) framework. It uses logical sequences (FOL - First Order Logic) to define high-level task sequences, and delegates the continuous manifold optimization (motion trajectories, contact forces, kinematics) to the KOMO solver.

## 2. Module List
- `KOMO ManipTools`: Low-level physical manipulation constraints.
- `LGP TAMP Core`: Tree search and logical node expansion for Task and Motion Planning.
- `Python Scripting Layer`: Environment execution, batch running, and visual verification.
- `Main Executable`: Reads `.lgp` configurations and executes the solver loop.

## 3. Module Responsibilities
- **KOMO ManipTools**: Define exact mathematical objectives (e.g., `FS_positionDiff`, `FS_vectorZ`) to guide the robotic arm for picking, placing, and navigating without collisions.
- **Main Executable**: Load trajectories, resample them (e.g., to 1000Hz for Pos/Vel/Acc), and interact with external interfaces.

## 4. Dependency Rules
- The C++ Core does not depend on Python.
- Python scripts depend strictly on the serialized outputs (jectories, `.g` scene files) of the C++ Core and the `robotic` PIP package.

## 5. External Interfaces
- **Input**: `.fol` (Logic), `.lgp` (Parameters), `.g` (Scene geometry and initial states).
- **Output**: Trajectory text files, updated `.g` scenes (`output_state.g`).

## 6. Architectural Constraints
- All hard placement constraints must use relative coordinates (`FS_positionDiff`) rather than absolute World Coordinates to avoid dependency on global geometrical origin offsets.
- Fast solver convergence requires purging redundant soft constraints (`OT_sos`) that clash with exact equality constraints (`OT_eq`).
