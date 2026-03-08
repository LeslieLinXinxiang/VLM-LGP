# Module: Python Scripting Layer (Layer 2 - Module Spec)

## 1. Module Name
Python scripts (`scripts/run_pyramid_assembly.py`, `scripts/view_full_assembly.py`, etc.)

## 2. Responsibility
Orchestrates the environment execution, running batch planning processes, capturing standard output, and visualizing the solved trajectories or end-states.

## 3. Inputs
- Project execution directories (e.g., `generated/pyramid_assembly_run/`).
- Geometric configurations (`.g`).

## 4. Outputs
- Console execution logs.
- Triggering the visualization GUI (`robotic` PIP package viewer).

## 5. Public Functions
- `run_pyramid_assembly.py: subprocess.run()` calls to main executable.
- Various test scripts for setting up scene and object geometries.

## 6. Internal Functions
- Directory scanning (e.g., `glob.glob("*.lgp")`).

## 7. Dependencies
- Standard Python `os`, `sys`, `subprocess`.
- The `bin/x.exe` solver binary.

## 8. Forbidden Dependencies
- No direct manipulation of `.cpp` headers or KOMO optimization objectives. All manipulation must go through solver binary arguments or configuration files.

## 9. Failure Modes
- Missing `.lgp` or `.g` files in target directory.
- Main executable crashing (non-zero return code).
