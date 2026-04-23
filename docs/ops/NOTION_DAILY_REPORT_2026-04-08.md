# 260408 Experimental Daily Report - Decoupled Pick/Place Frame Calibration for Planar FMB (VLM-LGP)

## 🎯 1. Core Objective
Stabilize planar pick-and-place behavior for FMB parts by correcting frame-definition issues and making object placement control independent from raw OBJ geometric center.

## 🐛 2. Key Findings & Debugging
- Directly modifying OBJ center-of-mass did not produce stable or monotonic placement behavior in the solver loop.
- In multiple calibration attempts, placement response appeared opposite to expected direction under the current scene/action coupling, which made COM-only tuning unreliable.
- The root practical blocker was tight coupling between geometric center, collision behavior, and grasp/place control frame semantics.

## 🛠️ 3. Actions Taken
- Ran iterative COM-shift experiments on selected assembly OBJ assets (mainly part2/part5 variants) to probe sensitivity and directionality.
- Switched from direct mesh-only semantics to a decoupled scene representation:
  - simplified proxy body for control-level pose semantics,
  - mesh child frame retained for collision/contact fidelity,
  - dedicated handle marker for explicit grasp targeting.
- Updated planar scene definitions to support independent tuning of pick/place reference frames without forcing further mesh-center recentering loops.
- Re-ran planar assembly pipeline validation (`scripts/run_planar_assembly.py`) and iterative scene checks to confirm operational behavior.

## 📊 4. Results & Validation
- The decoupled proxy + mesh + handle scheme successfully separated pick/place frame control from OBJ center perturbations.
- Current experiment status: successful for the intended planar calibration objective.
- Practical outcome: pick and place frame adjustments can now be tuned independently at scene/frame level, improving repeatability and reducing COM-adjustment ambiguity.

## 🚀 5. Next Steps / Backlog
1. Consolidate shape frame conventions (proxy size, mesh offset, handle orientation) into a reusable scene pattern for all FMB parts.
2. Run side-by-side success-rate comparison against prior COM-only workflow to quantify robustness gain.
3. Propagate the decoupled frame template into broader FMB assembly scenarios and verify no regression in downstream LGP motif solving.
