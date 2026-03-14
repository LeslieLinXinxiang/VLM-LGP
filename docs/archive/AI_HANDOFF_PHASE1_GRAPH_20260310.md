# AI Task Handoff: Phase 1 Graph Format Refinement

**Timestamp**: 2026-03-10
**Context**: The previous AI session established a new, scientifically robust graph representation for Phase 1's `target_graph.json` output for planar arrangement / pyramid building tasks. Due to token limits, the task was paused right before implementation.

## 1. The Core Objective
Convert the existing VLM-LGP Phase 1 Planner to use a strict **Computer Science Adjacency List (Vertices & Edges)** DAG format, discarding explicit spatial slots (`top_left`, `layer1_center`) and arbitrary `graph_id` strings.

## 2. The Finalized JSON Graph Schema

This is the exact format agreed upon with the user. The VLM should output this, and the Python validators should expect it.

```json
{
  "graph": {
    "vertices": [
      { "id": 0, "object": "Rectangular Prism", "spatial_position": "left" },
      { "id": 1, "object": "Rectangular Prism", "spatial_position": "center" },
      { "id": 2, "object": "Rectangular Prism", "spatial_position": "right" },
      { "id": 3, "object": "Cube", "spatial_position": "left" },
      { "id": 4, "object": "Cube", "spatial_position": "right" },
      { "id": 5, "object": "Cube", "spatial_position": "left" },
      { "id": 6, "object": "Cube", "spatial_position": "right" },
      { "id": 7, "object": "Rectangular Prism" },
      { "id": 8, "object": "Triangular Prism" }
    ],
    "edges": [
      { "source": 0, "target": "table" },
      { "source": 1, "target": "table" },
      { "source": 2, "target": "table" },
      { "source": 3, "target": 0 },
      { "source": 4, "target": 0 },
      { "source": 5, "target": 2 },
      { "source": 6, "target": 2 },
      { "source": 7, "target": 4 },
      { "source": 7, "target": 5 },
      { "source": 8, "target": 7 }
    ]
  }
}
```

### Key Logical Rules for the Schema:
1. **`spatial_position` (Optional)**: Can be `"left"`, `"center"`, or `"right"`.
   - **MUST BE USED** for bottom-layer objects (nodes on `"table"`).
   - **MUST BE USED** for one-to-many placements (e.g. 2 cubes stacked on 1 rect).
   - **MUST BE OMITTED** for multi-support / spanning structures (e.g. 1 big board resting on 2 cubes - gravity naturally centers it).
   - **MUST BE OMITTED** for 1-on-1 stacking.
2. **`table` Keyword**: Representing the ground anchor. Used ONLY as a string value inside the `target` parameter of `edges`, NOT as a physical item in the `vertices` list.
3. **Allowed Object Types**: `Triangular Prism`, `Cube`, `Rectangular Prism`, `Cylinder`.

## 3. Immediate Action Items for the Next AI

1. **Modify `prompts/phase1_graph_planner.md`**:
   - Strip out outdated slot names (e.g., `top_left`, `bottom_right`).
   - Introduce the allowed visual dictionary (`Triangular Prism`, `Cube`, `Rectangular Prism`, `Cylinder`) instead of generic `"base"` and `"cylinder"`.
   - Inject the new `graph` (vertices + edges) JSON schema and explain the rules for `spatial_position` logic and `"table"` target mapping explicitly so the VLM gets it right.

2. **Modify `pipelines/run_phase1.py`**:
   - Locate the function `validate_plan(plan_json, valid_inventory_list)`.
   - Change the structural verification to check for `graph -> vertices` and `graph -> edges`.
   - Expand `VALID_GENERICS` to include the new shapes (`Triangular Prism`, `Cube`, `Rectangular Prism`, `Cylinder`).
   - Verify that all `edges` refer to valid `id`s inside `vertices` or the string `"table"`.

3. **Run a Test**:
   - Use the `test_phase0_interface.py` or create a new test script for `run_phase1.py` that handles planar images and dumps the resulting `target_graph.json` to verify the new format is properly output by the model. 
   - Note: Make sure the Qwen API is configured properly in `core/vlm.py` and the `QWEN_API_KEY` is set in the environment before testing.
