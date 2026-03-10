# Module: Python Scripting Layer (Layer 2 - Module Spec)

## 1. Module Name
Python scripts (`scripts/run_pyramid_assembly.py`, `scripts/view_full_assembly.py`, etc.)

## 2. Responsibility
Orchestrates the environment execution, running batch planning processes, capturing standard output, and visualizing the solved trajectories or end-states.
Also handles VLM-facing orchestration for Phase0/Phase1 prompt+image inference and JSON validation flows.

## 3. Inputs
- Project execution directories (e.g., `generated/pyramid_assembly_run/`).
- Geometric configurations (`.g`).
- Prompt files (e.g., `prompts/phase0_binding_prompt.md`, `prompts/phase1_graph_planner.md`).
- Image inputs for visual reasoning (e.g., `test/image.png`).

## 4. Outputs
- Console execution logs.
- Triggering the visualization GUI (`robotic` PIP package viewer).
- Generated intermediate JSONs (e.g., `generated/phase0_layout.json`, `generated/phase1_target_graph*.json`).

## 5. Public Functions
- `run_pyramid_assembly.py: subprocess.run()` calls to main executable.
- Various test scripts for setting up scene and object geometries.
- `core.vlm.VLMClient.generate_assembly_plan(...)` for Phase1 graph generation.

## 6. Internal Functions
- Directory scanning (e.g., `glob.glob("*.lgp")`).

## 7. Dependencies
- Standard Python `os`, `sys`, `subprocess`.
- The `bin/x.exe` solver binary.
- `opencv-python` (`cv2`) for image handling.
- `Pillow` for image serialization in multimodal calls.
- `openai` client (Qwen compatible mode) and optional `google.generativeai` fallback.
- Runtime secrets exported from `.env` through `scripts/env.sh`.

## 8. Forbidden Dependencies
- No direct manipulation of `.cpp` headers or KOMO optimization objectives. All manipulation must go through solver binary arguments or configuration files.

## 9. Failure Modes
- Missing `.lgp` or `.g` files in target directory.
- Main executable crashing (non-zero return code).
- Running tests in wrong python interpreter (e.g., base conda) causing missing modules such as `cv2`.
- Not sourcing `scripts/env.sh`, causing missing `QWEN_API_KEY` and VLM init failures.
