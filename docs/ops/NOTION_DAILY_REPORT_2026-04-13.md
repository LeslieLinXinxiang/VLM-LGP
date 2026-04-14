🎯 1. Core Objective (Objective)
Stabilize the FMB new-experiment grasp/place frame setup and identify the root cause of the remaining pick-frame misalignment.

🐛 2. Key Findings & Debugging
- Pick frame skew was traced to `Table_Center` having an extra yaw term: `d(90 0 0 1)`.
- Removing that extra yaw restored expected frame alignment during `pick_touch`.
- `shape_3_1` and `shape_4_1` showed similar skew patterns because center-handle strategy plus nearby object interactions increased collision-coupled pose drift.

🛠️ 3. Actions Taken
- Compared object and handle definitions across `shape_1_1`, `shape_1_2`, `shape_3_1`, `shape_4_1` in `test/fmb_new_experiment/scene_new_fmb_preview.g`.
- Reviewed `action_pick` constraints in `rai/src/KOMO/manipTools.cpp` and temporarily disabled final descent collision term for A/B diagnosis.
- Rebuilt KOMO (`cd rai/src/KOMO && make`) and re-ran minimal solver checks (`bin/x.exe test/fmb_new_experiment/min_run_on_left test/fmb_new_experiment/scene_new_fmb_preview.g`).
- Validated that single-object pick tests now run through with aligned grasp/place frames.

📊 4. Results & Validation
- Grasp and place frame setup is now stable for the current new-FMB scene.
- Position alignment and single-object pick tests are passing in the minimal run path.
- The center patch orientation fix (`Table_Center` yaw removal) is the direct cause of observed improvement.

🚀 5. Next Steps / Backlog
- Resolve representation consistency between slot-based placement and support-based stacking in VLM outputs.
- Define a unified contract for cases like suspended multi-support placements (for example `shape_2_1` on `shape_1_1` + `shape_1_2`) where no base slot exists.
- Implement and test a normalization policy so all generated plans use one coherent placement semantics per task.
