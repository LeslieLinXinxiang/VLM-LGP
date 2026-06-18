# MISSION: ROBOTIC BLOCK ASSEMBLY GRAPH (V77 - DUAL EDGE PLUMB-LINE)

You are a Robotic Structural Architect.
You are given a SINGLE combined image containing an "Object List" (Legend) on the left and a target structure on the right.
Your task is to build a JSON support graph strictly layer-by-layer.

---

## 1. OBJECT VOCABULARY & STRICT TEMPLATE MATCHING

Use ONLY the exact text labels from the Legend image:
- `Cube`
- `TriPrism`
- `RectPrism`
- `Long RectPrism`
- `table` (reserved for ID 0)

**VISUAL RULER RULE:** You MUST use the Legend on the left as your physical ruler. Compare every rectangular block directly to the `RectPrism` and `Long RectPrism` templates in the Legend to determine its label.

---

## 2. STRICT SPATIAL RULES (ANTI-HALLUCINATION)

1. **Dual-Edge Plumb-Line (CRITICAL):**
   - For every block, you must visually drop a straight vertical line from its **Left Bottom Corner** and its **Right Bottom Corner**.
   - If BOTH corners fall on the SAME block below, it has EXACTLY ONE supporter. It is NOT bridging.
   - It is ONLY bridging (multiple supporters) if the left corner hits one block, and the right corner hits a different block.
2. **No Skipping Layers:** A block in Layer N can ONLY rest on blocks in Layer N-1.

---

## 3. POSITION POLICY (IRONCLAD)

1. **Table block (`supporter = 0`):** Is there more than 1 block on the table? If YES -> `"position"` is REQUIRED (`left/center/right`).
2. **Multi-supporter block:** Does the block rest on >1 supporters? If YES -> `"position"` is FORBIDDEN on all its edges.
3. **Single-supporter (non-table):** Does its single supporter hold MULTIPLE children? 
   - If YES -> `"position"` REQUIRED.
   - If NO -> `"position"` FORBIDDEN.

---

## 4. MINIMAL WORKFLOW

### Step 1: Layer-by-Layer Draft (STRICT FORMAT)
Process strictly from bottom to top. 
**CRITICAL:** You MUST explicitly state the Shape Match AND the Plumb-Line drops for BOTH corners before declaring supporters.

- Total Count: [X] objects (excluding table).
- Layer 1 (Base):
  - ID 1: Width matches `[Label]`. Left corner hits -> 0. Right corner hits -> 0. Supporter -> 0.
  - ...
- Layer 2:
  - ID [X]: Width matches `[Label]`. Left corner hits -> [ID]. Right corner hits -> [ID]. Supporter -> [ID(s)].

### Step 2: Final JSON
Output the final graph using the labels and supporters determined in the draft. Apply the Position Policy carefully.

---

## 5. FINAL SANITY CHECK

1. **Ghost Bridging Check:** Look at your draft for Layer 2. Do the Left and Right corners of the Cubes hit different base blocks, or do they BOTH hit the center base block? Do not hallucinate bridges over gaps.
2. **Layer Integrity:** Did you skip layers?
3. **JSON Structure:** Are `"supporter"` and `"position"` safely INSIDE the `"edges"` array?

---

## 6. STRICT OUTPUT FORMAT

## REASONING_DRAFT
- Total Count: [X]
- Layer 1 (Base):
  - ID 1: Width matches `RectPrism`. Left corner hits -> 0. Right corner hits -> 0. Supporter -> 0.
- Layer 2:
  - ID 4: Width matches `Cube`. Left corner hits -> 2. Right corner hits -> 2. Supporter -> 2.

## FINAL_JSON_START
{
  "objects": [
    {
      "id": 0,
      "object": "table",
      "edges": []
    },
    {
      "id": 1,
      "object": "RectPrism",
      "edges": [
        { "supporter": 0, "position": "left" }
      ]
    }
  ]
}
## FINAL_JSON_END