# MISSION: ROBOTIC SCENE SEMANTIC BINDING (TOP-DOWN MODE)

You are an expert **Spatial Reasoning Engine**. Your task is to analyze a **Top-Down (Bird's Eye View)** image.

---
# CORE PROTOCOL (Execute Step-by-Step)

## STEP 1: DEFINE COORDINATE SYSTEM
-   **Viewpoint:** Orthographic Top-Down. No perspective distortion.
-   **Primary Anchor (0,0):** Robot Base Projection (the Panda base center in image plane), NOT the image corner.
-   **Y-Axis:** Vertical. Up = "Back", Down = "Front".
-   **X-Axis:** Horizontal. Left = "Left", Right = "Right".

## STEP 2: GROUP & SORT OBJECTS
1.  Group objects by **object_type** (cylinder / cube / rectprism / triprism).
2.  For each group, sort by **Euclidean distance to Robot Base Anchor**.
3.  Tie-break rule: if distances are equal, sort by `y`, then `x`.

## STEP 3: BRIDGE VISUAL TO DATA & APPLY NAMING RULE
For each sorted object from STEP 2, match its visual color to the `color_rgb` from the `Object Specs` JSON to assign its true identity (`anon_id`).
Then, you MUST formulate its `logical_id` using **STRICTLY** the following prefix names followed by an underscore and its sorted distance index `_1`, `_2`, etc:
- 60x30x30 Box -> `rect_1`, `rect_2`, etc.
- 30x30x30 Box -> `cube_1`, `cube_2`, etc.
- Cylinder -> `cyl_1`, `cyl_2`, etc.
- Triangular Prism / Mesh -> `tri_1` (and so forth).

*   **Example Thought Process:**
    1.  *Visual Sort*: "The green cylinder is the closest cylinder to the robot base, so it gets index 1: `cyl_1`."
    2.  *Color Bridge*: "The `Object Specs` list shows that `obj_01` has the green `color_rgb` of `[0.0, 0.8, 0.0]`."
    3.  *Binding*: "Therefore, I conclude that `obj_01` corresponds to `cyl_1`."

## STEP 4: GENERATE ENRICHED OBJECT LIST
For each object in the input `Object Specs`, create a new JSON object that includes its **newly assigned logical ID**, and carry over `shape`, `object_type`, `size_signature`, and `color_rgb`.

---

# INPUT DATA STREAM

## 1. SCENE IMAGE
[Python Script will inject the `initial_scene_unnamed.png` image here]

## 2. OBJECT SPECS (Visual Summary from .g file)
```json
[
  { "anon_id": "obj_01", "shape": "cylinder", "object_type": "cylinder", "size_signature": [0.03,0.03,0.03], "color_rgb": [0.0, 0.8, 0.0] },
  { "anon_id": "obj_02", "shape": "box", "object_type": "rectprism", "size_signature": [0.06,0.03,0.03], "color_rgb": [1.0, 0.9, 0.0] },
  ...
]
```

---

# REQUIRED OUTPUT (JSON ONLY)

Based on your analysis, provide a JSON **list of objects**. Each object in the list must contain these keys:
- `anon_id`
- `logical_id`
- `shape` (coarse primitive: box/cylinder/mesh)
- `object_type` (fine type: rectprism/cube/cylinder/triprism)
- `size_signature` (3D size signature as `[x, y, z]`, copied from specs)
- `color_rgb`

**Do not include any other text or explanation in your final answer.**

```json
[
  {
    "anon_id": "obj_01",
    "logical_id": "cyl_1",
    "shape": "cylinder",
    "object_type": "cylinder",
    "size_signature": [0.03, 0.03, 0.03],
    "color_rgb": [0.0, 0.8, 0.0]
  },
  {
    "anon_id": "obj_02",
    "logical_id": "cyl_2",
    "shape": "cylinder",
    "object_type": "cylinder",
    "size_signature": [0.03, 0.03, 0.03],
    "color_rgb": [1.0, 0.9, 0.0]
  },
  {
    "anon_id": "obj_03",
    "logical_id": "cube_1",
    "shape": "box",
    "object_type": "cube",
    "size_signature": [0.03, 0.03, 0.03],
    "color_rgb": [0.8, 0.8, 0.8]
  },
  ...
]
```
