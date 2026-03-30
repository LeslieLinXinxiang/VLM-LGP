# VLM-LGP Testing Standard Operating Procedure (SOP)

## 1. Environment Setup
Always ensure you are in the correct Conda environment and that the `rai` library path is set.

```bash
conda activate vlm_jazzy
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/leslie/Projects/VLM_LGP/rai/lib
```

## 2. Planar Assembly Test (Current Major Benchmark)
This test validates the end-to-end chained planning of FMB (Factory Model Benchmark) parts on a base board.

### Execution
Run the automated script from the project root:
```bash
python3 scripts/run_planar_assembly.py
```

### Key Files & Locations
- **Scene Definition**: `test/planar_exp/planar_scene.g` (Defines robot, table, parts, and slots)
- **Logic Sequences**: `test/planar_exp/run_01/step_1.lgp` through `step_4.lgp`
- **Output State**: Results are saved to `test/planar_exp/run_01/output_state.g`

### Verification
- **Visual Check**: Open the latest result in the viewer:
  ```bash
  python3 scripts/view_scene.py test/planar_exp/run_01/output_state.g
  ```
- **Collision Check**: Review `test/planar_exp/run_01/active_collision_report.json` to verify that the `Active Constraint Strategy` correctly identified environmental and task-related collision pairs.

## 3. Pyramid Assembly Test (Reference Benchmark)
Validates 5-layer stacking logic.

```bash
python3 scripts/run_pyramid_assembly.py
```
*Note: Ensure the scenario directory `test/pyramid_run` is prepared before execution.*

## 4. Design Guidelines for New Tests
- **Handles**: Any movable object MUST have a child frame named with the substring `"handle"` (e.g., `part_handle`) to enable eccentric grasping.
- **Joints**: Movable parts must be declared with `joint:rigid` in the `.g` file.
- **Logical Tags**: Use `logical:{ is_object, is_box, is_place }` for FOL reasoning.
- **Mesh Logic**: Do not specify `size:[...]` for `.obj` meshes; the backend now calculates Z-height bounding boxes automatically.

## 5. Maintenance & Archiving
- Archive old trajectory logs (`.txt`, `.log`) and debugging screenshots into `test/retired/` regularly to maintain a clean workspace.
