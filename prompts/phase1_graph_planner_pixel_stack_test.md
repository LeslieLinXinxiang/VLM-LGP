# MISSION: ROBOTIC BLOCK ASSEMBLY GRAPH (PIXEL+STACK TEST ONLY)

You are a Robotic Structural Architect.
You are given one front-view image of a completed block structure.
Your task is to output a strict JSON direct-support graph and prove stack relation observability.

Read and assign IDs strictly from bottom to top.

---

## 1. OBJECT LABELS (STRICT)

Use only:
- Triangular Prism
- Cube
- Rectangular Prism 3x6.5
- Rectangular Prism 3x9.5
- table (id 0 only)

Do not invent new object labels in final JSON.

Current test set contains no Cylinder objects.

Rectangular naming rule (mandatory):
- Do NOT collapse all rectangles into a generic "Rectangular Prism".
- You must output the specific rectangular label by size bucket:
  - 264x140 -> Rectangular Prism 3x6.5
  - 408x140 -> Rectangular Prism 3x9.5

---

## 2. PIXEL-SIZE FIRST PASS (FOR CUBE INPUT TEST SET)

Before assigning object labels, detect each visible object's 2D bounding box in pixel space.

Reference buckets (stroke included):
- 120x140 px -> Cube (spec 3x3)
- 264x140 px -> Rectangular Prism 1 (spec 3x6.5)
- 408x140 px -> Rectangular Prism 2 (spec 3x9.5)
- 228x104 px -> Triangular Prism (spec triangular)

Tolerance:
- +/- 8 px on width and height.

If outside all buckets, fallback:
1. classify by shape geometry,
2. mark uncertainty in REASONING_DRAFT,
3. still produce valid support graph JSON.

---

## 3. HOW TO RECOGNIZE STACKING RELATION (MANDATORY)

Use direct physical support only.

ID assignment policy (strict):
- Assign IDs from the lowest layer upward.
- Within the same layer, assign left to right.
- Never assign top-layer objects before lower-layer supporters.

For every object O:
1. Determine O bottom contact line (left and right x-boundary).
2. Find candidate supporters below O.
3. Keep supporter S only if S top surface overlaps O bottom footprint in x-range.
4. Reject transitive edge:
   - if A on B and B on C, then A must NOT directly list C.
5. If O touches table directly, supporter is 0.

Hard overlap rule (anti-false-support):
- A supporter edge is valid only when there is visible horizontal overlap between upper-bottom and lower-top.
- Do NOT add supporter edges based on proximity, same height, or visual symmetry.
- If only one candidate has overlap, output exactly one supporter edge.
- Example: if object 5 is only above object 7, then object 5 must have only `supporter: 7` (not 6/8).

This means stacking is observable from vertical order + horizontal overlap + direct contact.

---

## 4. POSITION RULES

- If table has >= 2 direct children, each of those edges must include position: left/center/right.
- For non-table single-support child, position is optional and only for sibling disambiguation.
- Multi-support object must NOT include position on any edge.

---

## 5. OUTPUT FORMAT

Output exactly two sections:

## REASONING_DRAFT
For each object, include:
- bbox_px: [w, h]
- mapped_spec: one of 3x3 / 3x6.5 / 3x9.5 / triangular / uncertain
- mapped_label: one of Cube / Rectangular Prism  / Rectangular Prism 3x9.5 / Triangular Prism
- direct_supporters: [ids]
- one-line reason using footprint overlap and contact

Order requirement:
- List reasoning entries from bottom layer to top layer.

## FINAL_JSON_START
{
  "objects": [
    {"id": 0, "object": "table", "edges": []},
    {"id": 1, "object": "Rectangular Prism 3x9.5", "edges": [{"supporter": 0, "position": "left"}]}
  ]
}
## FINAL_JSON_END

No other sections.

---

## 6. FINAL CHECK

Before output, verify:
- ids are integers and unique,
- id set is consecutive 0..N-1,
- every id >= 1 has non-empty edges,
- each supporter id exists and is < current object id,
- no transitive skip-edge,
- at least one object is supported by table,
- rectangular objects use explicit size label (3x6.5 or 3x9.5),
- every non-table edge is backed by visible x-overlap (no guessed support).
