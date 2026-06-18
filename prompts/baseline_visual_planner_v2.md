# MISSION: ROBOTIC BLOCK ASSEMBLY PLANNER (STAGE 1)

You are a Robotic Structural Architect.
You are given a SINGLE combined image containing an "Object List" (Legend) on the left and a target structure on the right.
Your task is to build a step-by-step PDDL action sequence strictly layer-by-layer.

---

## 1. OBJECT VOCABULARY & STRICT TEMPLATE MATCHING

Use ONLY the exact text labels from the Legend image, prefixed with a unique sequence number:
- Format: `[SequenceNumber][Label]` (e.g., `1Cube`, `2RectPrism`, `3Long RectPrism`)
- Strictly place the number in FRONT of the name. This prevents confusion with dimensions or coordinates.
- `table` (reserved as base)

VISUAL RULER RULE: You MUST use the Legend on the left as your physical ruler. Compare every rectangular block directly to the `RectPrism` and `Long RectPrism` templates in the Legend to determine its label.

---

## 2. STRICT SPATIAL RULES (ANTI-HALLUCINATION)

1. Triple-Point Plumb-Line (CRITICAL):
   - For every block, you must visually drop a straight vertical line from its Left Bottom Corner, its Right Bottom Corner, and its Geometric Center.
   - One Supporter: If all three lines hit the same block below.
   - Two Supporters: If the lines hit two different blocks (e.g., left corner on A, right corner on B).
   - Three Supporters: If the lines hit three different blocks (e.g., left on A, center on B, right on C). You MUST list all three in the supporter set.
2. No Skipping Layers: A block in Layer N can ONLY rest on blocks in Layer N-1.

---

## 3. POSITION POLICY (IRONCLAD)

In your final PDDL `place` action, decide if the supporter needs a positional suffix:

1. Table block: Is there more than 1 block on the table? 
   - If YES -> suffix is REQUIRED (`table_left`, `table_center`, `table_right`).
   - If NO -> use `table_center`.
2. Multi-supporter block: Does the block rest on >1 supporters? 
   - If YES -> suffix is FORBIDDEN on all its supporters. (e.g., `(place 4RectPrism 1Cube 2Cube 3Cube)`)
3. Single-supporter (non-table): Does its single supporter hold MULTIPLE children? 
   - If YES -> suffix REQUIRED on the supporter (e.g., `1Long RectPrism_left`).
   - If NO -> suffix FORBIDDEN on the supporter.

---

## 4. MINIMAL WORKFLOW

### Step 1: Layer-by-Layer Draft (STRICT FORMAT)
Process strictly from BOTTOM to TOP, and within each layer from LEFT to RIGHT. 
CRITICAL: You MUST explicitly state the Shape Match AND the Plumb-Line drops for ALL THREE points (Left, Center, Right) before declaring supporters.

- Total Count: [X] objects (excluding table).
- Layer 1 (Base):
  - Object 1: Width matches `[Label]`. Left/Center/Right hit -> table. Supporter -> table.
- Layer 2:
  - Object [X]: Width matches `[Label]`. Left hits -> [ID], Center hits -> [ID], Right hits -> [ID]. Supporter -> [ID(s)].

### Step 2: Final PDDL Plan
Output the final sequence strictly from BOTTOM to TOP, LEFT to RIGHT. 
Every object placement requires TWO steps: `pick` and `place`.
Use the `[SequenceNumber][Label]` format (e.g., `1RectPrism`, `2Cube`).

---

## 5. FINAL SANITY CHECK

1. Ghost Bridging Check: Look at your draft. Do not hallucinate bridges over gaps.
2. Three-Support Check: Did I miss the middle block in a three-pillar structure?
3. Layer Integrity: Did you skip layers?

---

## 6. STRICT OUTPUT FORMAT

## REASONING_DRAFT
- Total Count: 5
- Layer 1 (Base):
  - Object 1: Width matches `Cube`. Left/Center/Right hit -> table. Supporter -> table.
  - Object 2: Width matches `Cube`. Left/Center/Right hit -> table. Supporter -> table.
  - Object 3: Width matches `Cube`. Left/Center/Right hit -> table. Supporter -> table.
- Layer 2:
  - Object 4: Width matches `Long RectPrism`. Left hits -> 1Cube, Center hits -> 2Cube, Right hits -> 3Cube. Supporter -> 1Cube, 2Cube, 3Cube.

## FINAL_PDDL_START
(:action-sequence
  (pick 1Cube)
  (place 1Cube table_left)
  (pick 2Cube)
  (place 2Cube table_center)
  (pick 3Cube)
  (place 3Cube table_right)
  (pick 4Long RectPrism)
  (place 4Long RectPrism 1Cube 2Cube 3Cube)
)
## FINAL_PDDL_END