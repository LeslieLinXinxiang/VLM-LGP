# Cube4 Anonymous Scene Generation Report

- Goal: Generate paired anonymous scenes for no-redundancy and redundancy modes.
- Constraint: Keep all spawned objects in init_region and outside work_region.

## Outputs

- nr: experiments/scenes/cube4/without_redundancy/cube4_s01_nr.g
  - object_total: 4
  - constraint_pass: True
- r: experiments/scenes/cube4/with_redundancy/cube4_s01_r.g
  - object_total: 8
  - constraint_pass: True
