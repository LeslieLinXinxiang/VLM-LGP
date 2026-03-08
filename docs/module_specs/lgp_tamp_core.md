# Module: LGP TAMP Core (Layer 2 - Module Spec)

## 1. Module Name
`rai/src/LGP/LGP_TAMP_default.cpp`

## 2. Responsibility
Handles Task and Motion Planning using First Order Logic (FOL) coupled with A* tree search to expand logical nodes into continuous optimization problems.

## 3. Inputs
- `rai::Configuration` (initial world state)
- `.lgp` and `.fol` files (logical domain and problem definitions)

## 4. Outputs
- Generated action sequences (e.g., `pick_touch`, `place_on_multi_support`) as `StringA`.
- Unrefined `KOMO` problem instances for each phase.

## 5. Public Functions
- `getNewActionSequence`: Runs A* to find the next logical symbol sequence.
- `setup_sequence` & `setup_motion`: Initializes `KOMO` instances for trajectory optimization.
- `add_action_constraints`: Translates parsed `action(0)` strings into `manipTools` function calls.

## 6. Internal Functions
- `Default_LGP_TAMP_Abstraction` constructor: Parses config files and initializes `FOL_World` and `AStar`.

## 7. Dependencies
- `KOMO/manipTools.h`
- `Search/AStar.h`
- `initFol.h`

## 8. Forbidden Dependencies
- No direct execution on the real robot arm. Must return sequences to the main loop.

## 9. Failure Modes
- Unsolvable logic goals: A* out of memory or no path found.
- Invalid `.fol` tokens leading to parse errors.
