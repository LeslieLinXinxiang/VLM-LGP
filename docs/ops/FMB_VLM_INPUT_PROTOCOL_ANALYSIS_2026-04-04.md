# FMB VLM Input Protocol: Single-Modality Design Report

- Date: 2026-04-04
- Scope: FMB front-end visual binding and relation extraction
- Decision level: execution-ready protocol for current three-task FMB benchmark

## 1. Problem Statement (First-Principles)

The VLM front-end has a narrow responsibility in this project:

1. Identify which known objects from the provided set are present in the scene.
2. Recover relative spatial/support relations under occlusion.
3. Emit output in the same schema style as current Phase0 binding output.

The VLM is not responsible for:

1. Open-set category discovery.
2. End-to-end planning/code generation.
3. Inferring hidden geometry without constraints.

Design target:

- Minimal pipeline changes.
- Maximum stability under occlusion.
- No hardcoded scene-specific rules.

## 2. Final Decision: One Input Modality Only

For FMB experiments, use exactly one primary modality:

**Fixed-view sequential isometric guiding images**.

Definition:

1. Same camera intrinsics/extrinsics for all frames.
2. Strict temporal order (assembly step order).
3. No mixed modality at inference time (no exploded view, no collage-only mode).

Why this is selected:

1. Temporal visibility resolves occlusion without requiring speculative reasoning.
2. It maps directly to the assembly process and is easier to audit.
3. It avoids multi-modal conflicts that can increase hallucination.

Why alternatives are rejected for this task:

1. Single final image is under-constrained under heavy occlusion.
2. Exploded-only input can drift from true assembled contact/support state.
3. N-panel collage weakens explicit step boundaries.

## 3. Boundary Conditions and Failure Modes

### 3.1 Information-Theoretic Boundary

If an object is never sufficiently visible in any step frame, no model can reliably infer its exact role without priors.

Mitigation:

1. Enforce per-object minimum visibility across sequence.
2. Add one dedicated reveal step when needed.

### 3.2 Symmetry/Ambiguity Boundary

Two objects with similar silhouette can be swapped by the model if color is removed and no geometric asymmetry is exposed.

Mitigation:

1. Keep the sequence order stable and fixed.
2. Use size/aspect cues as primary discriminators.
3. Add a disambiguation frame when two candidates remain equivalent.

### 3.3 Color Leakage Boundary

Color may become a shortcut feature and hurt generalization.

Mitigation:

1. Prefer grayscale-shaded rendering as default training/inference style.
2. Keep color as fallback mode only if grayscale performance is below threshold.

## 4. Color Policy (De-bias Without Breaking 3D Cues)

### 4.1 Recommended Render Style

Use **monochrome shaded rendering**:

1. Grayscale albedo.
2. Directional lighting + soft shadows.
3. Ambient occlusion (optional but recommended).

This preserves 3D shape cues while suppressing color shortcuts.

### 4.2 Operational Policy

1. Train/prompt with grayscale sequence first.
2. Evaluate relation extraction quality.
3. Enable color only if grayscale cannot meet minimum quality target.

No hardcoded color-to-object mapping is allowed.

## 5. Few-Shot Strategy (Low-Data, Non-Overfit)

### 5.1 Need for Few-Shot

Few-shot is required, but strictly bounded. Its role is to lock:

1. Task interpretation.
2. Output format.
3. Occlusion reasoning pattern.

It must not become implicit hardcoding.

### 5.2 Granularity and Count

Recommended count for this benchmark size:

1. **2 to 3 examples** as default.
2. Maximum **4 examples**.

Rationale:

1. Below 2, format and reasoning variance increases.
2. Above 4, risk of template overfitting increases with little gain.

### 5.3 Example Composition

Each few-shot example should include:

1. One short sequential image set (same camera rule).
2. One occlusion pattern focus (for example, U-shape partially hidden).
3. One strict JSON output using the Phase0-style schema.

Avoid:

1. Many near-duplicate examples.
2. Color-dependent explanation text.
3. Natural-language-only outputs.

## 6. Output Contract (Aligned with Phase0 Style)

The final output should remain a JSON list with these keys per object:

1. `anon_id`
2. `logical_id`
3. `shape`
4. `object_type`
5. `size_signature`
6. `color_rgb`

Reference style: `prompts/phase0_binding_prompt.md`.

Notes:

1. `color_rgb` remains part of schema for compatibility, even when inference uses grayscale images.
2. Relation extraction can be computed in prompt reasoning, but the emitted contract remains Phase0-compatible unless downstream schema is explicitly expanded.

## 7. Minimal-Change End-to-End Flow

### 7.1 Input Builder

1. Generate fixed-view sequential isometric frames.
2. Optionally generate grayscale-shaded variant (preferred default).
3. Do not attach any task-side manifest or object list.

### 7.2 Prompting

1. Keep one task prompt template.
2. Insert 2 to 3 few-shot examples.
3. Insert current sequence frames in strict order.
4. Force JSON-only output.

### 7.3 Validation

1. Schema validation (Phase0 style keys).
2. ID uniqueness checks.
3. Ordered-file consistency checks against the folder filename sequence.
4. Optional consistency checks against known assembly order.

No hardcoded object-specific if-else logic is introduced.

## 8. Acceptance Criteria

A protocol run is accepted only if all are true:

1. Same output schema format as current Phase0 binding contract.
2. Stable object binding across repeated runs with same inputs.
3. Occlusion cases in the three FMB tasks remain parseable without manual edits.
4. No dependence on explicit color matching rules.

## 9. Final Recommendation

For the current FMB scope (three tasks), the protocol should be locked as:

1. Single modality: fixed-view sequential isometric guiding images.
2. Few-shot: 2 to 3 examples, max 4.
3. Color policy: grayscale-shaded first, color fallback only if required.
4. Output: Phase0-style JSON schema for compatibility and minimal pipeline disruption.

This is the minimum-change path with the highest expected robustness under occlusion.

## 10. Concrete Input Specification (Implementation-Level)

This section defines the exact artifacts to prepare before each VLM call.

### 10.1 Required Files

1. One prompt markdown file (`.md`) as the instruction contract.
2. One real-task image folder containing only ordered sequence images.
3. Fixed few-shot folders reused across tasks.

`md` is required because instruction stability must be versioned.

The real task input must be folder-only; no task-side manifest is allowed in the runtime path.

### 10.2 Recommended Folder Layout

```text
prompts/
	phase0_fmb_sequential_binding.md

test/fmb_protocol/
	task_01/
		sequence/
			step_01.png
			step_02.png
			step_03.png
			step_04.png

	fewshot/
		fewshot_manifest.json
		fs_01_u_occlusion/
			step_01.png
			step_02.png
			step_03.png
			expected_output.json
		fs_02_bridge_occlusion/
			step_01.png
			step_02.png
			step_03.png
			expected_output.json
```

Rules:

1. The task folder is the only runtime input for the real task.
2. Images must be injected in filename order (`001`, `002`, `003`, ...).
3. The model must not receive any task-side manifest or object list.
4. Few-shot folders remain fixed and are not task-specific.
5. Output must remain Phase0-style JSON.

## 11. Few-Shot: Exactly What to Include

Your proposed idea is valid and recommended with one correction: few-shot samples must be structured, not just pasted images.

### 11.1 Few-Shot Unit Definition

One few-shot unit contains:

1. A dedicated folder.
2. A short sequential image set (2 to 4 frames).
3. A strict expected JSON output file.
4. One short text focus label stored in the folder name or a tiny local README.

### 11.2 Suggested Few-Shot Set for Your Case

Given very limited benchmark size, use exactly 3 few-shots:

1. `fs_01_single_object_visibility`
2. `fs_02_u_shape_partial_occlusion`
3. `fs_03_bridge_or_overlap_relation`

Each few-shot should teach one concept only. Do not combine many concepts in one sample.

### 11.3 Anti-Overfit Constraints

1. Max 4 few-shot units total.
2. Do not reuse identical camera distance in all few-shots; allow minor pose jitter within fixed-view family.
3. Do not describe color identity in few-shot text.
4. Keep verbal explanation minimal; let `expected_output.json` teach format.

## 12. Interaction Protocol With VLM (Injection Order)

Do not send images alone. Send a structured prompt payload in strict order.

### 12.1 Injection Order

1. Prompt template text (`.md`).
2. Few-shot block 1 (folder name -> images -> expected JSON).
3. Few-shot block 2 (folder name -> images -> expected JSON).
4. Few-shot block 3 (folder name -> images -> expected JSON).
5. Actual task block:
	 1. task folder name,
	 2. ordered sequence images read from that folder,
	 3. output instruction (`JSON only`).

### 12.2 Prompt Content Construction (Compatible With Current `VLMClient`)

The current client already supports mixed text and image list payloads (`prompt_content` list). Use this pattern:

```python
prompt_content = [template_md_text]

# few-shot unit i
prompt_content.extend([
		"\\n--- FEWSHOT 1 ---\\n",
		"folder:", fs1_folder_name,
		"frame_1:", fs1_img1,
		"frame_2:", fs1_img2,
		"expected_output:",
		f"```json\\n{json.dumps(fs1_expected, ensure_ascii=True)}\\n```"
])

# actual task
prompt_content.extend([
		"\\n--- ACTUAL TASK ---\\n",
		"task_folder:", task_folder_name,
		"step_1:", task_img1,
		"step_2:", task_img2,
		"step_3:", task_img3,
		"Return JSON only."
])
```

This is aligned with how `generate_assembly_plan(..., example_content=...)` and `_call_vlm_with_retry(...)` currently assemble payloads.

## 13. Should You Add an Index Dictionary?

For the real task, no. The real task input must remain folder-only.

For few-shot management, a local index dictionary is allowed for the test harness, but it must not become a task-side runtime requirement.

Example `fewshot_manifest.json`:

```json
{
	"schema_version": "phase0_style_v1",
	"fewshots": [
		{
			"id": "fs_01_single_object_visibility",
			"path": "fs_01_single_object_visibility",
			"focus": "single_visible",
			"enabled": true
		},
		{
			"id": "fs_02_u_shape_partial_occlusion",
			"path": "fs_02_u_shape_partial_occlusion",
			"focus": "u_partial_occluded",
			"enabled": true
		},
		{
			"id": "fs_03_bridge_or_overlap_relation",
			"path": "fs_03_bridge_or_overlap_relation",
			"focus": "bridge_relation",
			"enabled": true
		}
	]
}
```

## 14. Rendering Pipeline Requirements (Grayscale Sequential Mode)

To keep color from dominating while preserving shape:

1. Render all sequence frames in grayscale-shaded mode.
2. Keep light direction fixed across all frames.
3. Keep camera fixed; do not orbit camera between steps.
4. Maintain identical image resolution and crop.

Optional fallback:

If grayscale fails acceptance criteria, run a second pass with color, but keep all other settings unchanged.

## 15. Final Operational Checklist

Before each task run:

1. Confirm prompt `.md` exists and version is pinned.
2. Confirm the real task folder contains only ordered images and no task manifest.
3. Confirm 2 to 3 enabled few-shot units in the fixed few-shot folders.
4. Confirm all images are grayscale-shaded and fixed-view.
5. Build `prompt_content` with the exact injection order in Section 12.
6. Enforce JSON-only output and Phase0-style schema validation.

If all six pass, the protocol is considered fully defined and executable.