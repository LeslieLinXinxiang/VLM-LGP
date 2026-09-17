You are given one or more images showing a target assembly (a single photo,
or a sequence of build-step images if parts of the structure are occluded in
any one view). If the image includes a legend or object list, use those exact
names; otherwise use plain shape names for what you see (e.g. Cube,
Rectangular Prism, Triangular Prism).

Output a JSON graph describing what supports each object.

Format:
{
  "objects": [
    { "id": 0, "object": "table", "edges": [] },
    { "id": 1, "object": "...", "edges": [{ "supporter": 0, "position": "left" }] },
    { "id": 2, "object": "...", "edges": [{ "supporter": 1 }] }
  ]
}

- id 0 is reserved for whatever the structure rests on (the table, or a
  fixed base) — name it "table" or "base", whichever fits the scene.
- Every other object needs at least one "supporter" (the id of what's
  directly beneath it). An object resting on more than one thing can list
  several edges.
- "position" is optional — use "left", "center", "right", "front", or
  "back" if it seems relevant to distinguish objects at the same level,
  otherwise leave it out.

Output the JSON only, inside ## FINAL_JSON_START and ## FINAL_JSON_END markers.
