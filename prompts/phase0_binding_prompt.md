# MISSION: ROBOTIC SCENE SEMANTIC BINDING (TOP-DOWN MODE)

You are an expert **Spatial Reasoning Engine**. Your task is to analyze a **Top-Down (Bird's Eye View)** image.

---
# CORE PROTOCOL (Execute Step-by-Step)

## STEP 1: DEFINE COORDINATE SYSTEM
-   **Viewpoint:** Orthographic Top-Down. No perspective distortion.
-   **Origin (0,0):** Bottom-Left Corner of the image.
-   **Y-Axis:** Vertical. Up = "Back", Down = "Front".
-   **X-Axis:** Horizontal. Left = "Left", Right = "Right".

## STEP 2: GROUP & SORT OBJECTS
1.  **Cylinder Group**: Sort by distance from Origin (0,0).
2.  **Base Group**: Sort by distance from Origin (0,0).

## STEP 3: BRIDGE VISUAL TO DATA (The Color Key)
For each sorted object from STEP 2, find its corresponding anonymous ID from the `Object Specs` JSON by matching its visual color to the `color_rgb` value.

*   **Example Thought Process:**
    1.  *Visual Sort*: "The green cylinder is closest to the origin, so it is `cyl1`."
    2.  *Color Bridge*: "The `Object Specs` list shows that `obj_01` has the green `color_rgb` of `[0.0, 0.8, 0.0]`."
    3.  *Binding*: "Therefore, I conclude that `obj_01` corresponds to `cyl1`."

## STEP 4: GENERATE ENRICHED OBJECT LIST
For each object in the input `Object Specs`, create a new JSON object that includes its **newly assigned logical ID**, and carry over its `shape` and `color_rgb` properties.

---

# INPUT DATA STREAM

## 1. SCENE IMAGE
[Python Script will inject the `initial_scene_unnamed.png` image here]

## 2. OBJECT SPECS (Visual Summary from .g file)
```json
[
  { "anon_id": "obj_01", "shape": "cylinder", "color_rgb": [0.0, 0.8, 0.0] },
  { "anon_id": "obj_02", "shape": "cylinder", "color_rgb": [1.0, 0.9, 0.0] },
  ...
]
```

---

# REQUIRED OUTPUT (JSON ONLY)

Based on your analysis, provide a JSON **list of objects**. Each object in the list must contain three keys: `logical_id`, `shape`, and `color_rgb`. **Do not include any other text or explanation in your final answer.**

```json
[
  {
    "anon_id": "obj_01",
    "logical_id": "cyl1",
    "shape": "cylinder",
    "color_rgb": [0.0, 0.8, 0.0]
  },
  {
    "anon_id": "obj_02",
    "logical_id": "cyl2",
    "shape": "cylinder",
    "color_rgb": [1.0, 0.9, 0.0]
  },
  {
    "anon_id": "obj_03",
    "logical_id": "base1",
    "shape": "box",
    "color_rgb": [0.8, 0.8, 0.8]
  },
  ...
]
```
