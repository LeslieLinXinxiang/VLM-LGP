fmb_output_test

Purpose:
- Minimal end-to-end test from Phase1 VLM graph output to Phase2 codegen files.
- No strategy generation from VLM.
- No Phase0 reachability/manipulability checks.
- Uses graph clustering + phase2_codegen directly.

Run:
1) Activate runtime environment:
   conda activate vlm_jazzy
   source scripts/env.sh
2) Start test:
   python3 test/fmb_output_test/test_phase1_to_codegen.py

Workflow:
- Select an image folder in popup (e.g. test/fmb_guiding_input/images/fmb_1).
- Script sends images + prompt to VLM (qwen backend).
- Parses Phase1 graph JSON.
- Runs BranchAwareLayerCuttingClustering.
- Generates .fol/.lgp files using phase2_codegen.
- Saves artifacts under test/fmb_output_test/outputs/<timestamp>_<case>/.
