# TASK: Structural Logic Translation (Text -> JSON)

**Context**: You are converting a visual report into a robot assembly plan.
**Input**: A text description of 3 Panels.
**Output**: A strict JSON Graph.

---
### 1. THE PHYSICS LOGIC (TEACHING THE LAYER CONCEPT)

You are building a tower layer by layer. Understand the relationship between panels:

*   **Panel 1 (Layer 1)**: This is the foundation.
    *   The Base sits on `"table"`.
    *   The Cylinders sit on this Base.

*   **Panel 2 (Layer 2)**: This is built ON TOP OF Layer 1.
    *   **The Support Rule**: To build Layer 2, you must first place a new Base on top of the cylinders from Layer 1.
    *   **Logic**: If Layer 1 had **3** cylinders, the Layer 2 Base rests on **3** generic `"cylinder"` items.
    *   *JSON*: `"placed_on": ["cylinder", "cylinder", "cylinder"]`

*   **Panel 3 (Layer 3)**: This is built ON TOP OF Layer 2.
    *   **The Support Rule**: The Layer 3 Base rests on top of the cylinders from Layer 2.
    *   **Logic**: If Layer 2 had **4** cylinders, the Layer 3 Base rests on **4** generic `"cylinder"` items.

---
### 2. THE SPATIAL LOGIC (SIMPLE MAPPING)

Map the natural text to these 9 standard slots. Ignore minor deviations.
*   **Corners**: `top_left`, `top_right`, `bottom_left`, `bottom_right`
*   **Sides**: `mid_left`, `mid_right`, `top_center`, `bottom_center`

*   **Abstraction**: Convert ALL specific colors (Red, Blue...) to the generic name `"cylinder"`.

---
### 3. THINKING PROCESS (REQUIRED)

Before generating JSON, think briefly:
1.  **Count Layer 1**: How many cylinders are in Panel 1? -> This is the support count for Layer 2.
2.  **Count Layer 2**: How many cylinders are in Panel 2? -> This is the support count for Layer 3.

---
### 4. STRICT OUTPUT FORMAT

Only output the JSON. Do not explain.

```json
{
  "assembly_nodes": [
    {
      "node_id": 1,
      "description": "Foundation",
      "actions": [
        { "object": "base", "placed_on": "table", "at_slot": null },
        // Generate Cylinder actions based on Panel 1 text...
        { "object": "cylinder", "placed_on": "base", "at_slot": "..." }
      ]
    },
    {
      "node_id": 2,
      "description": "Second Layer",
      "actions": [
        // The support list must match the number of cylinders in Node 1
        { "object": "base", "placed_on": ["cylinder", ...], "at_slot": null },
        // Generate Cylinder actions based on Panel 2 text...
        { "object": "cylinder", "placed_on": "base", "at_slot": "..." }
      ]
    },
    {
      "node_id": 3,
      "description": "Third Layer",
      "actions": [
        // The support list must match the number of cylinders in Node 2
        { "object": "base", "placed_on": ["cylinder", ...], "at_slot": null }
        // Generate Cylinder actions based on Panel 3 text...
      ]
    }
  ]
}