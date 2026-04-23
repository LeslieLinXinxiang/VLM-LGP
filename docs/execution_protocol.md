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

## 11. DDE Optional Extension Invocation Protocol
The DDE protocol remains the single command authority. Extension skills are optional and subordinate helpers.

### 11.1 Authority Rules
1. `dde-bootstrap` remains the global coordinator for session state and document truth.
2. `dde-code-guard` remains the only write gate for code file modifications.
3. Extension skills can run discovery, testing, and verification commands, but cannot bypass `RFC_MODE`, `[APPROVED]`, or `[TASK_COMPLETED]`.

### 11.2 Enabled Subordinate Extensions
- `dde-ext-search-first`: research-before-implementation helper.
- `dde-ext-verification-loop`: build/test/lint/type/security verification helper.
- `dde-ext-cpp-testing`: C++ test workflow helper.
- `dde-ext-python-testing`: Python pytest workflow helper.
- `dde-ext-brainstorm`: pre-implementation ideation and tradeoff helper (advisory-only).

### 11.3 Write Escalation Gate
If any extension requires file writes to complete its objective, it MUST emit handoff metadata and return control to `dde-code-guard` proposal flow before editing files.

Required handoff fields:
- Reason
- Target files
- Expected effect
- Risk notes

### 11.4 Trigger Policy
Extensions are opt-in:
- explicit user request, or
- explicit DDE workflow selection for the current task phase.

Default behavior is no extension execution.

## 12. Documentation Information Architecture Rule
To keep `docs/` maintainable and reduce mixed-context drift:
1. Layer 0-4 files remain fixed at `docs/` root:
	- `project_charter.md`, `architecture.md`, `dataflow.md`, `execution_protocol.md`, `roadmap.md`
2. Layer 2 module details remain under `docs/module_specs/`.
3. Supplementary docs must be filed by purpose:
	- `docs/ops/` for troubleshooting and runtime SOPs
	- `docs/decisions/` for decision templates/records
	- `docs/archive/` for historical handoff or one-off records
	- `docs/governance/` for optional process governance notes
4. `docs/README.md` is mandatory as the docs system index in every project using DDE.
5. If these subfolders exist, each must include a local README:
	- `docs/ops/README.md`
	- `docs/decisions/README.md`
	- `docs/archive/README.md`
	- `docs/governance/README.md`
	- `docs/module_specs/README.md`
6. DDR template has dual source:
	- skill-level template: `dde-ext-brainstorm/templates/DDR_TEMPLATE.md` (reusable source)
	- project instance: `docs/decisions/DDR_TEMPLATE.md` (project-local working copy)
7. Use project instance first; if missing, initialize from skill template and then continue.
8. New documentation files must be registered in `docs/README.md`.

## 13. Roadmap Deterministic Update Rule (Layer 4 Hard Guard)

To avoid fragile direct edits on `docs/roadmap.md`, roadmap updates must use scripted guards:

1. Run validation before and after any roadmap mutation:
   - `python3 ~/.copilot/skills/roadmap-guard/scripts/roadmap_guard.py validate docs/roadmap.md`
2. When closing a task, use scripted transition instead of manual section surgery:
   - `python3 ~/.copilot/skills/roadmap-guard/scripts/roadmap_guard.py close --task-id TASK-XXX --completed-at "YYYY-MM-DD HH:MM" --summary "..."`
3. Enable local commit gate once per clone:
   - `chmod +x .githooks/pre-commit && git config core.hooksPath .githooks`
4. Pre-commit must block commits if roadmap validation fails.
5. See operational details in `docs/ops/ROADMAP_GUARD_SOP.md`.

## 14. Experiment Governance and Logging Rule (FMB + Cube)

For comparative experiments, use a manifest-driven workflow and structured run logs to avoid rerunning completed cases.

Required references:
- `docs/ops/EXPERIMENT_EXECUTION_PROTOCOL_FMB_CUBE.md`
- `docs/ops/EXPERIMENT_LOGGING_PROTOCOL.md`

Required execution assets:
- `experiments/configs/manifest_schema.md`
- `experiments/configs/methods.yaml`
- `experiments/scripts/run_experiment_batch.py`
- `experiments/scripts/validate_experiment_logs.py`
- `experiments/scripts/aggregate_experiment_results.py`

Hard requirements:
1. Every run must produce one structured record in `run_records.jsonl`.
2. Failure attribution must use standardized failure codes only.
3. Reuse policy must be hash-based (`case_hash`) unless force rerun is explicitly requested.
4. Aggregation outputs used for reports must come from validated logs.
