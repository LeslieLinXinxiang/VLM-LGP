from pipeline.run_phase0 import execute_phase0
import os

input_g = "/home/leslie/Projects/VLM_LGP/experiments/scenes/4cubes/s01/random_trials/trial_01_nr.g"

res = execute_phase0(
    use_vlm=False,
    unnamed_g_path=input_g,
    auto_prepare_from_named_scene=False,
    reachability_mode="gmm_esdf_mvp"
)
if res and res.get("success"):
    print(f"PREPROCESS_SUCCESS: {res['scene_named_path']}")
else:
    print("PREPROCESS_FAILED")
