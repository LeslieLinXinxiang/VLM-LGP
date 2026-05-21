# 3D Printing Assets (Cube Stacking)

This folder stores printable model specifications for the cube-stacking experiment set.

## 1. File format choice

- `OBJ` can be used for 3D printing in many slicers (PrusaSlicer, OrcaSlicer, Cura), but OBJ is unitless and may import with wrong scale if unit policy is unclear.
- `STL` is not strictly mandatory, but it is the most widely compatible format for 3D printing workflows.
- Recommended practice in this project:
  - Keep editable/source geometry in `OBJ`.
  - Export final print-ready files as `STL` (mm unit convention in export settings).
  - Optional: provide `3MF` for slicer profiles and print settings.

## 2. Current spec set

- `Rect_3x3`
- `Rect_3x3x6.5`
- `Rect_3x9.5` (updated from previous `Rect_6x6.5`)
- `Tri_current` (bound to current `generated/triangular_prism.obj`)

## 3. Meta-file rule

Each part has one meta file under `specs/`:

- Naming: `<part_id>.meta.json`
- Required keys:
  - `part_id`
  - `family`
  - `dimensions_mm`
  - `source_model`
  - `recommended_print_output`
  - `print_preset`

## 4. Notes for this round

- `Tri_current` dimensions come from the normalized model `experiments/printing/models/obj/tri_current_mm.obj`:
  - base width: `30 mm`
  - depth: `30 mm`
  - height: `30 mm`
- Rectangle parts in this folder are set to `30 mm` height for consistency with the current triangular prism.
