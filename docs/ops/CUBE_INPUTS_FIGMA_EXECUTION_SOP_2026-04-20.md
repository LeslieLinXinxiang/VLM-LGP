# Cube Stacking Input Freeze — Figma Execution SOP (TASK-025)

- Date: 2026-04-20
- Owner: TASK-025 execution stream
- Scope: Generate frozen Cube Stacking target image inputs before large-scale comparative runs

## 1. Goal

Build a **frozen, auditable, one-to-one mapping** for Cube benchmark scenarios:

- `scenario_id -> image + scene(.g) + task_graph(.json)`

This SOP focuses on the **image** side using Figma, and defines exactly what must be produced so the downstream experiment stack can consume it without ambiguity.

---

## 2. Context Anchors (Current Repo Contracts)

1. Input freeze is a hard gate before batch runs:
   - `docs/roadmap.md` TASK-025
   - `docs/ops/EXPERIMENT_EXECUTION_PROTOCOL_FMB_CUBE.md` Section 3.1
2. Logging requires frozen mapping trace fields:
   - `docs/ops/EXPERIMENT_LOGGING_PROTOCOL.md`
3. Allowed object labels (visual dictionary):
   - `Triangular Prism`, `Cube`, `Rectangular Prism`, `Cylinder`
4. Existing Phase0 naming/size conventions include:
   - Cube: `30x30x30` (0.03m)
   - RectPrism: `60x30x30` (0.06m x 0.03m x 0.03m)
   - TriPrism mesh reference: `generated/triangular_prism.obj`

---

## 3. Status Check: Is background info already sufficient?

### 3.1 What is already clear

The repo already gives enough governance and pipeline-level requirements for:

- Why freeze is required
- Which artifacts must be bound together
- How logs should record freeze version
- Which object taxonomy is valid

### 3.2 Remaining ambiguities that must be pinned before final lock

The following items are still ambiguous and must be fixed explicitly (this SOP includes defaults, but they should be confirmed):

1. **`task_size_n` range**
   - Confirmed: use `n in [4,5,6,7,8]`.
   - No schema extension to `3` is needed.

2. **Shape size contract mismatch**
   - Current canonical sizes heavily reference 0.03 / 0.06 scale family.
   - New request includes values such as `3*3.5`, `6*6.5`, `6*3.5`, and triangular based on current OBJ.
   - Required action: define exact per-shape `(X,Y,Z)` in meters and bind to object labels.

3. **Cube input modality**
   - Confirmed: Cube uses **single target image per scenario**.
   - No per-scenario sequential frame bundle is required for Cube in this freeze round.

4. **Visual variation policy for “5 different images”**
   - Need deterministic variation dimensions (layout topology, occlusion level, clutter ratio, etc.), not subjective differences.

After pinning the above, the remaining active ambiguity is shape-size contract finalization.

---

## 4. Default Decision Set (Proposed for immediate execution)

If no override is given, use the defaults below.

### 4.1 Dataset cardinality

- `n = 4,5,6,7,8`
- 5 variants per `n`
- Total images: `5 * 5 = 25`

### 4.2 Scenario ID format

- `cube_n{NN}_s{VV}`
- Example: `cube_n04_s01`, `cube_n08_s05`

### 4.3 Shape dictionary (provisional until size contract freeze)

- For this Cube image-freeze round: **Rect + Tri only** (no circle/cylinder drawing in input image)
- `Rect_3x3.5` (square-like small block)
- `Rect_6x3.5` (wide rectangular block)
- `Rect_6x6.5` (tall rectangular block)
- `Tri_6x3.5` (triangle block, used as roof/top)

### 4.4 Camera and render rules

- Fixed camera family per bundle (no random perspective per scenario)
- Same canvas size for all exports
- Neutral background
- Grayscale-priority rendering (color optional fallback)
- No textual annotations/watermarks in exported image

### 4.5 Variation dimensions for the 5 variants per `n`

For each `n`, force the following 5 variant intents:

1. `s01`: clean, low occlusion
2. `s02`: medium occlusion
3. `s03`: high compactness / contact-rich
4. `s04`: asymmetric support arrangement
5. `s05`: distractor-heavy but still solvable

This avoids creating 5 near-duplicates.

### 4.6 Frozen 2D Technical Spec (Drawing Contract v1)

This section is the **authoritative drawing spec** for manual sketching and later auto-generation.

#### 4.6.1 Per-image canvas

- Image size: `1024 x 1024` px
- Background: solid light gray `#EBEBEB` (or equivalent)
- Safe margin on all sides: `64` px
- Effective safe region: `896 x 896` px

#### 4.6.2 Primitive part sizes (pixel)

- `Rect_3x3.5`: `120 x 140` px
- `Rect_6x3.5`: `240 x 140` px
- `Rect_6x6.5`: `240 x 260` px
- `Tri_6x3.5` bounding box: `240 x 140` px

Style (all parts):

- Fill: none
- Stroke color: black
- Stroke weight: `10` px
- Corner radius (rect only): `16` px
- Triangle: outline-only, upright

#### 4.6.3 Spacing and boundary constraints

- Horizontal inter-object minimum gap (`GapH`): `24` px
- Vertical inter-layer minimum gap (`GapV`): `24` px
- Bottom-layer to canvas bottom minimum (`BottomMargin`): `84` px
- Side edge to nearest bottom-layer object minimum: `64` px
- Top object to top safe edge minimum: `64` px

#### 4.6.4 Randomization envelope (for 5 variants)

On each `n` page (`5` inputs), randomness is controlled by bounded jitter:

- Global stack X offset: `[-24, +24]` px
- Layer-local X jitter: `[-12, +12]` px
- Layer-local Y jitter: `[-8, +8]` px
- Gap jitter: `GapH = 24 ± 6`, `GapV = 24 ± 4`

Hard constraints under randomization:

1. No overlap between any two shapes.
2. Every upper piece must be visually supported by piece(s) below.
3. All pieces remain fully inside safe region.
4. No circles are allowed in final cube input images.

#### 4.6.5 Page organization in Figma

- One page per `n`: `Cube_n4_inputs`, `Cube_n5_inputs`, ..., `Cube_n8_inputs`
- Each page contains one section with exactly five frames: `cube_n0{n}_s01` ... `cube_n0{n}_s05`
- Each frame is one single input image target (no sequence frames).

#### 4.6.6 Reusable assets in Figma (recommended)

Yes — parts should be saved as reusable assets to improve consistency.

- Create components: `Part/Rect_3x3_5`, `Part/Rect_6x3_5`, `Part/Rect_6x6_5`, `Part/Tri_6x3_5`
- Keep all on a spec library page: `00_Cube_Input_Spec_Library`
- Build each scenario by instancing components rather than redrawing primitives.

Variables are optional but recommended:

- Numeric tokens as FLOAT variables: `canvas/size = 1024`, `margin/safe = 64`, `gap/h = 24`, `gap/v = 24`, `stroke/weight = 10`, `radius/rect = 16`

Even if some geometry values are still manually applied, tokenizing these constants makes later batch generation and QA easier.

---

## 5. Required Inputs Before Figma Drawing

You must have these inputs pinned first:

1. **Shape size table (final)**
   - Per object type: exact `(x, y, z)` in meters
2. **Canvas/export spec**
   - Resolution (e.g., 1024x1024)
   - File format (`.png`)
3. **Style spec**
   - Grayscale or color mode
   - Shadow/lighting consistency
4. **Bundle identity**
   - `input_bundle_id` (e.g., `cube_figma_v1`)
   - `input_freeze_version` (e.g., `input_bundle_v1`)
5. **Downstream binding targets**
   - `scene_g_path` per scenario
   - `task_graph_path` per scenario

---

## 6. Output Deliverables (Mandatory)

### 6.1 Image assets

Recommended path:

- `experiments/assets/cube_inputs/<freeze_version>/images/`

File naming:

- `<scenario_id>.png`
- Example: `cube_n04_s01.png`

### 6.2 Mapping table (freeze truth)

Recommended path:

- `experiments/assets/cube_inputs/<freeze_version>/mapping.jsonl`

Each line must include at least:

- `scenario_id`
- `benchmark` (`cube`)
- `task_size_n`
- `variant_id` (`s01`~`s05`)
- `input_image_path`
- `input_scene_g_path`
- `input_task_graph_path`
- `input_bundle_id`
- `input_freeze_version`
- `figma_file_url`
- `figma_frame_id`

### 6.3 Visual generation provenance

Recommended path:

- `experiments/assets/cube_inputs/<freeze_version>/figma_export_manifest.json`

Include:

- export timestamp
- operator
- figma file/page/frame references
- per-image checksum (sha256)

---

## 7. Figma MCP Operation SOP (VS Code)

1. Open Figma Desktop and target file.
2. Ensure **Design Mode** (not Dev Mode).
3. Open plugin: **Figma Desktop Bridge** and keep floating window alive.
4. In VS Code, confirm MCP servers from `.vscode/mcp.json` can start:
   - `figma`
   - `figma-dev-mode-mcp-server`
   - `figma-console`
5. Validate runtime health:
   - server tools callable
   - Desktop Bridge connected
   - active file detected

Failure signature and meaning:

- `WebSocket not connected. Open the Desktop Bridge plugin in Figma.`
  - MCP server exists, but Figma Desktop Bridge is not connected.

---

## 8. End-to-End Execution Checklist

1. Freeze shape-size table.
2. Freeze scenario matrix (`n=4..8`, 5 variants each).
3. Create/organize Figma page sections by `n`.
4. Draw 25 frames with deterministic variant intents and v1 drawing contract.
5. Export all frames to canonical filenames.
6. Compute image checksums.
7. Build `mapping.jsonl` (image-scene-graph one-to-one).
8. Run sanity checks:
   - 25/25 images exist
   - no duplicate checksum across variants of same `n`
   - every scenario has scene+graph paths
9. Commit freeze bundle metadata and assets.

---

## 9. Acceptance Criteria

Task is accepted only if all are true:

1. For each scenario, exactly one frozen image path is recorded.
2. Mapping is complete for all scenarios in the matrix.
3. `input_bundle_id` and `input_freeze_version` are populated.
4. Export artifacts are reproducible from Figma references.
5. No unresolved ambiguity remains on `n` range or shape-size contract.

---

## 10. Fallback: Ultra-Detailed Prompt for Figma Make

Use this when MCP write automation is unavailable.

### Prompt (copy as-is)

You are generating benchmark target images for a robotics Cube Stacking dataset. Create a clean, consistent, top-down/isometric visual style suitable for vision-language parsing. Follow all constraints exactly.

Global objective:

- Produce 25 final images for scenario IDs `cube_n04_s01` to `cube_n08_s05`.
- For each `n` in {4,5,6,7,8}, produce 5 distinct variants (`s01`..`s05`).
- Each scenario is represented by **one single target image**.

Object vocabulary (only these 4):

- Cube
- Rectangular Prism
- Cylinder
- Triangular Prism

Size rules:

- Use the project size contract. If not explicitly provided, keep strict relative scale consistency within the same bundle.
- Do not distort proportions between variants.

Visual style rules:

- Fixed camera family across all 25 images.
- Neutral background, no text labels, no arrows, no watermark.
- Soft shading, clear object boundaries, stable light direction.
- Prefer grayscale-first style; if color is enabled, keep a muted palette and avoid color-only discrimination cues.
- Identical canvas size and framing for all outputs.

Variant semantics for each n:

- `s01`: clean layout, low occlusion, easy separation.
- `s02`: medium occlusion.
- `s03`: compact/high-contact arrangement.
- `s04`: asymmetric support relations.
- `s05`: distractor-heavy but still physically plausible and parseable.

Physics/plausibility rules:

- No impossible floating contacts.
- Support relations should be visually understandable.
- Keep arrangement solvable for a manipulation planner.

Output naming and structure:

- Export PNG files named exactly `<scenario_id>.png`.
- Required IDs:

  - n=4: `cube_n04_s01`..`cube_n04_s05`
  - n=5: `cube_n05_s01`..`cube_n05_s05`
  - n=6: `cube_n06_s01`..`cube_n06_s05`
  - n=7: `cube_n07_s01`..`cube_n07_s05`
  - n=8: `cube_n08_s01`..`cube_n08_s05`

Quality checks before finalizing:

- All 25 images present.
- No duplicate composition within same n.
- Shape proportions and camera consistency preserved globally.
- No text artifacts or UI elements in exported images.

Return:

- A list of exported frame names and confirmation that all constraints were followed.
