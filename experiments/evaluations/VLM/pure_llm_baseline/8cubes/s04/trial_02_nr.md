# Baseline Trial: trial_02_nr

- **Timestamp**: 2026-04-27 00:28:47
- **Elapsed**: 40.8s
- **Input Image**: `experiments/inputs/cubeStacking/8cubes/cube_n08_s04.png`
- **Input Scene**: `experiments/scenes/8cubes/s04/random_trials/trial_02_nr.g`

## VLM Raw Response (Pure LLM Output)

```xml
<REASONING_DRAFT>
## 1. Stock Audit
From scene_named.g:
- Cubes (0.03 x 0.03 x 0.03): obj_01, obj_02, obj_03, obj_04, obj_05, obj_06 → 6 cubes
- Long RectPrisms (0.03 x 0.095 x 0.03): obj_07, obj_08 → 2 long rectprisms
- RectPrisms (0.065): None
- TriPrisms: None

Total: 6 Cubes + 2 Long RectPrisms = 8 objects (matches visual structure)

## 2. Visual Structural Draft (bottom → top)

**Layer 1:**
- Long RectPrism (bottom-most, horizontal long block)
- Plumb lines: all hit table
- Supporter: table

**Layer 2:**
- Three Cubes (left, center, right) sitting on Layer 1 Long RectPrism
- Each cube: left/center/right plumb lines all hit the same Long RectPrism
- Supporter for each: single (the Layer 1 Long RectPrism)

**Layer 3:**
- Long RectPrism (horizontal long block)
- Left plumb line → hits left Cube (Layer 2)
- Center plumb line → hits center Cube (Layer 2)
- Right plumb line → hits right Cube (Layer 2)
- Three distinct supporters → multi-supporter bridge case

**Layer 4:**
- Three Cubes (left, center, right) sitting on Layer 3 Long RectPrism
- Each cube: left/center/right plumb lines all hit the same Long RectPrism
- Supporter for each: single (the Layer 3 Long RectPrism)

## 3. Binding Draft
- Layer 1 Long RectPrism → Long_RectPrism_1 (obj_07 or obj_08)
- Layer 2 Cubes (L→R) → Cube_1, Cube_2, Cube_3 (obj_01-06)
- Layer 3 Long RectPrism → Long_RectPrism_2 (obj_07 or obj_08)
- Layer 4 Cubes (L→R) → Cube_4, Cube_5, Cube_6 (obj_01-06)

## 4. Slot Resolution
- Long_RectPrism_1: only object on table → `table_center`
- Cube_1/2/3: single supporter (Long_RectPrism_1) which has 3 children → suffixes REQUIRED: `_left`, `_center`, `_right`
- Long_RectPrism_2: multi-supporter bridge (3 supporters) → NO suffixes on supporters
- Cube_4/5/6: single supporter (Long_RectPrism_2) which has 3 children → suffixes REQUIRED: `_left`, `_center`, `_right`

## 5. Compilation Plan
Build order: Layer 1 → Layer 2 → Layer 3 → Layer 4
- node_1: Long_RectPrism_1 on table_center
- node_2: Cube_1 on Long_RectPrism_1_left
- node_3: Cube_2 on Long_RectPrism_1_center
- node_4: Cube_3 on Long_RectPrism_1_right
- node_5: Long_RectPrism_2 on Cube_1 Cube_2 Cube_3
- node_6: Cube_4 on Long_RectPrism_2_left
- node_7: Cube_5 on Long_RectPrism_2_center
- node_8: Cube_6 on Long_RectPrism_2_right
</REASONING_DRAFT>

<FILE name="node_1.lgp">
fol: <template.fol>
terminal: " (on table_center Long_RectPrism_1) "
genericCollisions: true
coll: []
</FILE>

<FILE name="node_2.lgp">
fol: <template.fol>
terminal: " (on Long_RectPrism_1_left Cube_1) "
genericCollisions: true
coll: []
</FILE>

<FILE name="node_3.lgp">
fol: <template.fol>
terminal: " (on Long_RectPrism_1_center Cube_2) "
genericCollisions: true
coll: []
</FILE>

<FILE name="node_4.lgp">
fol: <template.fol>
terminal: " (on Long_RectPrism_1_right Cube_3) "
genericCollisions: true
coll: []
</FILE>

<FILE name="node_5.lgp">
fol: <template.fol>
terminal: " (on Cube_1 Cube_2 Cube_3 Long_RectPrism_2) "
genericCollisions: true
coll: []
</FILE>

<FILE name="node_6.lgp">
fol: <template.fol>
terminal: " (on Long_RectPrism_2_left Cube_4) "
genericCollisions: true
coll: []
</FILE>

<FILE name="node_7.lgp">
fol: <template.fol>
terminal: " (on Long_RectPrism_2_center Cube_5) "
genericCollisions: true
coll: []
</FILE>

<FILE name="node_8.lgp">
fol: <template.fol>
terminal: " (on Long_RectPrism_2_right Cube_6) "
genericCollisions: true
coll: []
</FILE>
```
