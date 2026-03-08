# Module: Main Executable (Layer 2 - Module Spec)

## 1. Module Name
`bin/main.cpp`

## 2. Responsibility
The primary C++ entry point that loads task configurations, invokes the LGP solver, executes the homing routine, and resamples trajectories for downstream execution.

## 3. Inputs
- `<task_dir>`: Directory containing `.lgp` files.
- `<input_g_file>`: Initial scene configuration.
- `[master_home_g]`: Optional global home configuration.

## 4. Outputs
- Resampled 1000Hz trajectory text (`>>> V-LGP TRAJECTORY START <<<`).
- Sequentially generated `.g` files and final `output_state.g`.

## 5. Public Functions
- `main`: Entry point, parses arguments, and manages Phase A (LGP) and Phase B (Homing).
- `resampleAndPrintTrajectory`: Converts B-Spline logical paths to real Pos/Vel/Acc outputs.
- `writeCleanKinematicState`: Merges polluted optimization frames back into a clean scene tree.

## 6. Internal Functions
- N/A (Standard standalone helper functions).

## 7. Dependencies
- `LGP/LGP_Tool.h`, `KOMO/komo.h`, `Kin`, `Optim`.
- Local `.g` scene file I/O.

## 8. Forbidden Dependencies
- Python libraries. Must run as a pure C++ binary.

## 9. Failure Modes
- Kinematic topology mismatch between `C_initial` and `C_final`.
- Homing solver failure if `total_gap > 0.2`.
