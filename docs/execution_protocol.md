# Execution and Automation Protocol (Layer 3)

## 1. Change Proposal Procedure
Any intended codebase modification MUST be prefaced by an RFC or Phase 1 proposal stating:
- Reasoning
- Original Logic
- Expected Result
- First Principles Check (Constraint against existing Architecture).

## 2. Approval Requirement
AI Agents MUST enter a block state awaiting the verbatim string `[APPROVED]` from the human controller before modifying `.cpp`, `.py`, `.fol`, or `.h` files.

## 3. Patch Diff Rule
Any modifications to code must be exact replacements focusing only on the target functions without refactoring out-of-scope behaviors.

## 4. Documentation Update Rule
Upon fixing a bug or adding a feature, the AI MUST review Layer 1 and Layer 2 documents (e.g., `manipTools.md`) to ensure the changes are reflected. If they drift, update the `.md` files immediately.

## 5. Rollback Procedure
All changes should be committed to Git atomically. 
If an AI agent produces a hallucination:
1. `git restore .` (to clear working tree).
2. The current AI session MUST be terminated.
3. A new session must be initiated, which will bootstrap from the uncorrupted Git checkout of the `docs/` hierarchy.

## 6. Consistency Re-Validation Rule
At the start of new sessions, the AI must verify all modules listed in `architecture.md` correspond to existing files in `module_specs/`. Output `CONSISTENCY_ERROR` if mismatched.

## 7. Environment & Secret Management Rule
API keys (such as `QWEN_API_KEY`) and application settings MUST NEVER be hardcoded into python files or documentation.
1. All secrets are stored in the git-ignored `.env` file in the project root.
2. Before executing any command in this repository, AI Agents MUST source the project environment by running `source scripts/env.sh`, which automatically parses `.env` and exports the secrets into the terminal session.

## 8. Python Runtime Selection Rule (Critical)
To avoid false failures and dependency drift, all repository operations (testing, code modification, script execution, and validation) MUST run in the project runtime environment:
1. Activate conda env: `source /home/leslie/anaconda3/etc/profile.d/conda.sh && conda activate vlm_jazzy`.
2. Then source project env: `source scripts/env.sh`.
3. Only then run any project command (`python`, `pytest`, `make`, utility scripts, etc.).

Violation policy:
- If current shell is not `vlm_jazzy`, STOP and re-enter the shell correctly before any action.
- If `source scripts/env.sh` has not been run in current shell, STOP and source it first.

Known failure signatures when this rule is violated:
- `ModuleNotFoundError: No module named 'cv2'` (wrong python env selected).
- Missing `QWEN_API_KEY`/`VLM_MODEL_NAME` in process env (forgot to source `scripts/env.sh`).

## 9. Phase2 Prompt1 Isolated Handshake Test
When testing only Prompt1 (Phase1 JSON -> strategy candidates handshake), use this exact runtime sequence:
1. `source /home/leslie/anaconda3/etc/profile.d/conda.sh && conda activate vlm_jazzy`
2. `source scripts/env.sh`
3. `python -c "import json,os; from core.vlm import VLMClient; root='.'; p=open('prompts/phase2_strategist.md','r',encoding='utf-8').read(); phase1=json.load(open('generated/phase1_target_graph_img1_retry_marked.json','r',encoding='utf-8')); out=VLMClient()._call_gemini_with_retry([p,'\n--- INPUT DATA ---\n','phase1_json:',json.dumps(phase1,ensure_ascii=True)], is_json_output=True); json.dump(out, open('generated/phase2_prompt1_output.json','w',encoding='utf-8'), indent=2, ensure_ascii=True); print('[PROMPT1_TEST] SUCCESS: Prompt1 handshake generated.')"`

Expected terminal markers:
- `[PROMPT1_TEST] SUCCESS: Phase1 JSON loaded.`
- `[PROMPT1_TEST] SUCCESS: Prompt1 handshake generated.`

## 10. Phase1 Isolated I/O Test Procedure
When asked to test Phase1 input/output only (prompt + image -> JSON), execute this sequence:
1. Use `prompts/phase1_graph_planner.md` as prompt input.
2. Use explicit image path (for current baseline test: `test/image.png`).
3. Run one direct VLM call via `core.vlm.VLMClient.generate_assembly_plan(...)`.
4. Save output to `generated/phase1_target_graph_test.json`.
5. Validate strict schema:
	- Top-level key is exactly `graph`.
	- `graph.vertices` and `graph.edges` are arrays.
	- Vertex ids are unique integers.
	- Allowed object labels: `Triangular Prism`, `Cube`, `Rectangular Prism`, `Cylinder`.
	- Edge `source` is an existing vertex id.
	- Edge `target` is existing vertex id or `table`.
