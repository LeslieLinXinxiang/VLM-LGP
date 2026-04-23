# general_base Axis Dimension Markers

Source mesh: `assets/fmb/new_fmb/base_board.obj`

Units: meters

## 1) Axis Levels (all key coordinate planes)

- X levels: `[-0.115, -0.075, -0.045, -0.015, 0.015, 0.045, 0.075, 0.115]`
- Y levels: `[-0.025, 0.000, 0.025]`
- Z levels: `[-0.115, -0.100, -0.060, -0.020, 0.020, 0.060, 0.100, 0.115]`

## 2) Full Extents

- X extent: `0.230` (`-0.115` to `0.115`)
- Y extent: `0.050` (`-0.025` to `0.025`)
- Z extent: `0.230` (`-0.115` to `0.115`)

## 3) Step Widths Between Adjacent Levels

- X spacings: `[0.040, 0.030, 0.030, 0.030, 0.030, 0.030, 0.040]`
- Y spacings: `[0.025, 0.025]`
- Z spacings: `[0.015, 0.040, 0.040, 0.040, 0.040, 0.040, 0.015]`

## 4) Symmetric Marker Pairs (for patch planning)

- X symmetric pairs around center:
  - `(+/-0.015)`, `(+/-0.045)`, `(+/-0.075)`, `(+/-0.115)`
- Z symmetric pairs around center:
  - `(+/-0.020)`, `(+/-0.060)`, `(+/-0.100)`, `(+/-0.115)`
- Y top and bottom surfaces:
  - top: `0.025`
  - mid-plane: `0.000`
  - bottom: `-0.025`

## 5) Practical Placement Reference (recommended)

If you place patches on the top surface, use:

- Surface plane: `Y = 0.025`
- Candidate X anchors: `[-0.075, -0.045, -0.015, 0.015, 0.045, 0.075]`
- Candidate Z anchors: `[-0.100, -0.060, -0.020, 0.020, 0.060, 0.100]`

These anchor sets avoid the absolute outer boundary (`|X|=0.115`, `|Z|=0.115`) and align with repeated structural steps in the mesh.
