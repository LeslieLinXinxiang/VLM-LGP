# Project Charter (Layer 0)

## 1. Objective
Develop and refine the VLM-LGP (Vision-Language Model - Logic Geometric Programming) robotic manipulation framework to reliably plan and execute complex, multi-step assembly tasks, such as building a multi-layer pyramid using various shapes (cubes, rectangular prisms, triangular prisms).

## 2. Problem Statement
The robotic path planning and constraint satisfaction solver (KOMO) struggles with complex contacts, floating objects, and inefficient trajectory planning due to conflicting, redundant, or hard-coded constraints. AI oversight over the codebase risks hallucination and configuration drift without a strict documentation protocol.

## 3. Expected Outputs
- A robust C++ robotic solver core (`manipTools.cpp`, `LGP_TAMP`, etc.).
- Python verification scripts for batch generation and visualization (`run_pyramid_assembly.py`, `view_full_assembly.py`).
- 100% successful physical simulation placements without hovering, clipping, or violent oscillations.
- Strict DDE-Bootstrap document management.
- The formal academic manuscript and associated LaTeX/PDF assets documenting the VLM-LGP approach (`paper/`).

## 4. Non-Goals
- Changing the fundamental solver libraries (e.g., replacing KOMO).
- Training the Vision-Language Model (VLM) component within this specific execution phase.
- Real-world hardware deployment configurations (currently focusing on robust simulation `output_state.g`).

## 5. Scope Definition
- **In-Scope**: `rai/src/KOMO/manipTools.cpp`, `bin/main.cpp`, python execution scripts (`scripts/*`), `.fol` and `.lgp` logic files, local Git repository management, and the `paper/` directory for academic documentation.
- **Out-of-Scope**: Modifying core rai (Robotic Artificial Intelligence) library source code outside of the user's specific manipulator manipulation targets.

## 6. Assumptions
- **ASSUMPTION**: The core simulation environment (PhysX) and underlying KOMO optimization backend are stable and functioning correctly.
- **ASSUMPTION**: The generated `.fol` logical steps are correct sequences for the pyramid assembly.

## 7. Risks
- Solver slow-downs due to over-constrained optimization.
- "Amnesia" or code drift if modifications bypass the DDE-Bootstrap protocol.
- Merge conflicts when integrating parallel experimental branches (e.g., pos+vel+acc logging vs vanilla).
