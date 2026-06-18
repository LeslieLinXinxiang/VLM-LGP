# MISSION: ROBOTIC BLOCK ASSEMBLY POSE OUTPUT (WEAK V1)

You are given one combined image:
- left: Object List (Legend)
- right: target structure

Return object poses in the required format.

---

## 1. HARD CONSTRAINTS

- Use ONLY exact text labels from the Legend.
- `table` is the base object.
- Keep output strictly inside `FINAL_PDDL_START/END`.

### 1.1 OBJECT VOCABULARY

- Name objects with sequential prefixes: `1_[Label]`, `2_[Label]`, `3_[Label]`, ...
- `table` has no numeric prefix.

### 1.2 SUPPORT POSITION NAMING

When one supporter holds multiple objects, mark supporter regions with `_[position]`.

- Table supporter regions: `table_left`, `table_center`, `table_right`, `table_top`, `table_bottom`.
- Non-table supporter regions: `[ID]_[Label]_[position]`.
- Valid `position`: `left`, `center`, `right`.
- If one object is supported by multiple distinct supporters, list them directly (e.g., `2_A, 3_B`).

---

## 2. INPUT GEOMETRY

Table anchor pose (global 6D):
- table: [0.00, 0.25, 0.11, 0, 0, 0]

Table region anchors (global 6D):
- table_left:   [-0.08, 0.10, 0.051, 0, 0, 0]
- table_center: [ 0.00, 0.10, 0.051, 0, 0, 0]
- table_right:  [ 0.08, 0.10, 0.051, 0, 0, 0]
- table_top:    [ 0.00, 0.02, 0.051, 0, 0, 0]
- table_bottom: [ 0.00, 0.18, 0.051, 0, 0, 0]

Object sizes:
- Cube:           [0.03,  0.03,  0.03]
- RectPrism:      [0.03,  0.065, 0.03]
- Long RectPrism: [0.03,  0.095, 0.03]
- TriPrism:       [0.06,  0.03,  0.03]

---

## 3. OUTPUT REQUIREMENTS

For each object, output:
- object name
- direct supporter name
- size
- pose6d

Do not output reasoning text.

---

## 4. OUTPUT FORMAT

## FINAL_PDDL_START
(:object-pose-list
    (object <id_label>)
    (supporter <supporter_name>)
    (size <sx> <sy> <sz>)
    (pose6d <x> <y> <z> <roll> <pitch> <yaw>)
)
## FINAL_PDDL_END
