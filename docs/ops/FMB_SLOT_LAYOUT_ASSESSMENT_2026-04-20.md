# FMB Slot Layout Assessment and Execution Plan (2026-04-20)

## 1) Scope and Goal

This document records a parameter-level assessment of current slot markers in existing `.g` scenes, and defines an executable plan for:

1. finishing FMB input image design/freeze,
2. standardizing slot names + positions,
3. validating prompt/schema/code/scene consistency before benchmark scale-up.

---

## 2) Data Sources (Current Repo)

### Cube-family scene references

- `unnamed.g`
- `generated/scene/scene_named.g`

### FMB-family scene references

- `test/fmb_new_experiment/scene_new_fmb_preview.g`
- `test/fmb_guiding_input/scene file/new_fmb_*/**.g`

### Code contract references

- `pipeline/run_phase1.py` (`allowed_positions = {left, center, right}`)
- `core/phase2_gatekeeper.py` (place-frame existence check currently for `left/right`)
- `core/phase2_codegen.py` (`position` -> terminal slot string mapping)

---

## 3) Slot Parameters Extracted from Existing `.g` Files

## 3.1 Cube markers (table + rect top patches)

### 3.1.1 Base markers (table parent, cross pattern)

Parameters:

- `Base_Center` on `table`: `Q:t(0.00, 0.10, 0.051)`, size `(0.025, 0.025, 0.002, 0.001)`
- `Base_Left` on `table`: `Q:t(-0.08, 0.10, 0.051)`, size same as above
- `Base_Right` on `table`: `Q:t(0.08, 0.10, 0.051)`, size same as above
- `Base_Top` on `table`: `Q:t(0.00, 0.02, 0.051)`, size same as above
- `Base_Bottom` on `table`: `Q:t(0.00, 0.18, 0.051)`, size same as above

Derived center spacing:

- left-right spacing: `0.16 m`
- top-bottom spacing: `0.16 m`

### 3.1.2 Layer-1 table slots

Parameters:

- `Table_Left` on `table`: `Q:t(-0.05, 0.10, 0.051)`, size `(0.025, 0.025, 0.001, 0.0005)`
- `Table_Right` on `table`: `Q:t(0.05, 0.10, 0.051)`, size `(0.025, 0.025, 0.001, 0.0005)`

Derived center spacing:

- left-right spacing: `0.10 m`

### 3.1.3 Rect top slots

`Rect_N_Left/Right` are defined for `N=1..8`:

- `Rect_N_Left` on `rect_N`: `Q:t(-0.015, 0, 0.0155)`, size `(0.025, 0.025, 0.001, 0.0005)`
- `Rect_N_Right` on `rect_N`: `Q:t(0.015, 0, 0.0155)`, size `(0.025, 0.025, 0.001, 0.0005)`

Derived center spacing:

- rect top left-right spacing: `0.03 m`

---

## 3.2 FMB markers (base_board parent)

### 3.2.1 Canonical set in preview scene

From `test/fmb_new_experiment/scene_new_fmb_preview.g`:

Parameters:

- `Table_Left` on `base_board`: `Q:t(0.000, 0.000, 0.080)`, `d(-90 1 0 0)`, size `(0.02, 0.02, 0.001, 0.0005)`
- `Table_Right` on `base_board`: `Q:t(0.000, 0.000, -0.080)`, `d(90 1 0 0)`, size same
- `Table_Front` on `base_board`: `Q:t(0.060, 0.000, 0.000)`, `d(90 1 0 0)`, size same
- `Table_Back` on `base_board`: `Q:t(-0.060, 0.000, 0.000)`, `d(90 1 0 0)`, size same
- `Table_Center` on `base_board`: `Q:t(0.000, 0.000, 0.000)`, `d(-90 1 0 0)`, size same

Derived center spacing:

- left-right spacing: `0.16 m`
- front-back spacing: `0.12 m`

### 3.2.2 Observed variance in guiding scenes

In `test/fmb_guiding_input/scene file/new_fmb_*/**.g`:

- `Table_Front` is either `x=0.060` or `x=0.059`
- `Table_Back` is either `x=-0.060` or `x=-0.061`
- `Table_Left/Right/Center` are stable at `z=+0.080 / -0.080 / 0.000`

Numeric variance summary:

- front/back x-offset jitter range: `±0.001 m` around nominal `±0.060 m`

---

## 4) Compatibility Assessment (Prompt -> Validator -> Gatekeeper -> Codegen)

## 4.1 Current behavior

1. **Phase1 validator** allows `position` in `{left, center, right}`.
2. **Gatekeeper** place-frame existence check currently triggers for `left/right` only.
3. **Codegen** can generate terminal with `left/right/center/middle`.

## 4.2 Current risk points

1. `Rect_N_Center` frames are not defined in current cube scenes.

   - If `position=center` appears on non-table supporter `rect_N`, codegen may emit `Rect_N_Center` and fail downstream.

2. `front/back` exists in FMB scenes but is not represented in Phase1 allowed position set.
3. FMB marker rotations (`d(...)`) are inconsistent (`+90/-90` mixed); current checks do not validate orientation consistency.

---

## 5) Canonical Slot Spec Proposal (V1)

## 5.1 Naming and allowed values

### Cube family (current production-safe)

- table slots: `Table_Left`, `Table_Right`
- rect slots: `Rect_N_Left`, `Rect_N_Right` (`N=1..8`)
- **Position tokens (phase1)**: `left/right` only for now in cube benchmark path.

### FMB family (target)

- board slots: `Table_Left`, `Table_Right`, `Table_Center`, `Table_Front`, `Table_Back`
- **Position tokens (phase1 target extension)**: `left/right/center/front/back`
- If prompt/schema is not extended yet, map front/back via a separate field (e.g., `position_slot`) in post-processing.

## 5.2 Canonical numeric constants (for scene generation / checking)

### Cube

- `TABLE_SLOT_X = ±0.05`
- `TABLE_SLOT_Y = 0.10`
- `TABLE_SLOT_Z = 0.051`
- `RECT_SLOT_X = ±0.015`
- `RECT_SLOT_Y = 0.0`
- `RECT_SLOT_Z = 0.0155`

### FMB

- `BOARD_SLOT_LEFT_RIGHT_Z = ±0.080`
- `BOARD_SLOT_FRONT_BACK_X = ±0.060`
- `BOARD_SLOT_CENTER = (0,0,0)`
- `SLOT_SIZE = (0.02, 0.02, 0.001, 0.0005)`
- tolerance for slot coordinate checks: `±0.001 m`

---

## 6) Execution Tasks and Milestones

## 6.1 TASK-026 (FMB input image freeze)

Deliverables:

1. Final FMB image bundle (`n` and scenario mapping frozen).
2. Manifest fields frozen per scenario:

   - `scenario_id`
   - `input_image_path`
   - `input_scene_g_path`
   - `input_task_graph_path`
   - `input_bundle_id`
   - `input_freeze_version`
3. Log entry in experiment tracking docs.

Acceptance criteria:

- one-to-one mapping complete,
- no ambiguous/temporary image assets,
- replay script resolves all paths without manual edits.

## 6.2 TASK-027 (slot naming/position standardization + tests)

### Step A: Contract lock

- Add slot layout spec JSON (recommended path: `experiments/configs/slot_layouts/slot_layout_v1.json`).
- Encode per-scene family allowed slots + nominal coordinates + tolerances.

### Step B: Scene conformance checks

- Add checker script to parse `.g` and validate slot existence + coordinates + parent frame.
- Required checks:

  1. missing required slots,
  2. duplicate slot names,
  3. coordinate deviation > tolerance,
  4. unsupported slot names for scene family.

### Step C: Pipeline compatibility updates

- Prompt/schema path:

  - keep cube on `left/right` path,
  - FMB path supports `center/front/back` through explicit schema extension or `position_slot` fallback.

- Gatekeeper:

  - validate all configured slot tokens, not only left/right.

- Codegen:

  - resolve terminal by explicit slot name when provided, fallback to old logic otherwise.

### Step D: Test additions

- Unit tests:

  - slot parser / coordinate tolerance / name normalization

- Integration tests:

  - phase1->phase2 with FMB center/front/back slots
  - negative tests for missing slot frame

Acceptance criteria:

- deterministic pass/fail report for slot conformance,
- no runtime failure caused by undefined terminal slot names,
- replayable test case for cube and FMB each.

---

## 7) Immediate Next Actions (ordered)

1. Freeze FMB input image set and scenario mapping (TASK-026).
2. Implement slot layout spec file and checker (TASK-027 Step A/B).
3. Patch gatekeeper/codegen compatibility for explicit slot names (TASK-027 Step C).
4. Execute and archive conformance + integration test reports (TASK-027 Step D).

---

## 8) Quick Decision Notes

- For **Cube benchmark mainline**, keep `left/right` strict until `Rect_N_Center` is intentionally introduced.
- For **FMB experiments**, keep 5-slot board topology (`L/R/F/B/C`) but enforce numeric tolerance checks before benchmark runs.
- Do not start mass benchmark rerun until TASK-026 + TASK-027 pass artifacts are archived.
