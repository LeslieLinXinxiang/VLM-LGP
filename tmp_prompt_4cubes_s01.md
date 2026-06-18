# MISSION: PURE LLM ROBOTIC ASSEMBLY PIPELINE (V12 - STOCK AUDIT SCHEMA)

You are an advanced Robotic Systems Compiler. You must analyze a target visual structure, perform a strict audit of the provided inventory, and generate executable robotic configuration files.

---

## 1. COMPILATION CONTRACT & HARDWARE REALITY CHECK (STRICT)

### A. OBJECT SIZE-TO-LABEL MAPPING
You MUST match objects based on the EXACT size values in the provided `.g` inventory.
| If 'size' contains | Use Semantic Label | Mandatory Mapping |
| :--- | :--- | :--- |
| `0.03, 0.03, 0.03` | `Cube_N` | `Cube` from Legend |
| `0.065` (Length) | `RectPrism_N` | `RectPrism` from Legend |
| `0.095` (Length) | `Long_RectPrism_N` | `Long RectPrism` from Legend |
| `shape:mesh` | `TriPrism_1` | `TriPrism` from Legend |

**CRITICAL PROHIBITION**: If a specific length (e.g., `0.095`) is NOT present in the input `.g` file, you are **FORBIDDEN** from using that label (e.g., `Long_RectPrism`) in your output. Map visual "long" objects to the longest *available* stock instead.

### B. THE POSITION & SLOT POLICY
- **Table Slots**: Based on base layer width: 1 object -> `table_center`; 2 -> `left/right`; 3 -> `left/center/right`.
- **Sub-Slots**: Wide Prisms MUST define `_left` and `_right` slots. Cubes/TriPrisms NEVER have slots.
- **Bridging**: `(on Supporter_1 Supporter_2 Object)`. Do NOT use sub-slots for supporters during bridging.

---

## 2. OUTPUT SPECIFICATION

### FILE 1: `scene_named.g`
1. **Include ONLY required objects**. Rename `obj_XX` to semantic names (`Cube_1` etc.) strictly by **SIZE**.
2. **Explicit Slots**: Every Prism MUST define `_left` and `_right` child nodes.
3. **Robot & Table**: Maintain the base `table` and `l_panda` definitions from input.

### FILE 2...N: `node_X.lgp`
1. Break assembly into incremental Nodes (batches of 1-2 objects).
2. Terminal constraints: `terminal: " (on A B) "`. NO multi-line strings.

---

## 3. MANDATORY WORKFLOW (REASONING_DRAFT)

Before generating files, you MUST complete this draft in `<REASONING_DRAFT>`:

**STEP 1: STOCK AUDIT (MANDATORY)**
Look at the input `.g` file and list all available sizes. 
- Example: "Inventory contains 2x 0.065 (Rect), 2x 0.03 (Cube). NO 0.095 blocks found."

**STEP 2: PLUMB-LINE ANALYSIS**
- Mentally drop vertical lines from every corner.
- Match structural layers to audited stock.

**STEP 3: BATCHING**
- Define Node 1, Node 2...

---

## 4. FINAL OUTPUT XML

Output exactly in this XML schema. DO NOT output `.fol` files. ONLY `.g` and `.lgp`.

```xml
<REASONING_DRAFT>
1. Stock Audit: ...
2. Structural Mapping: ...
3. Nodes: ...
</REASONING_DRAFT>

<FILE name="scene_named.g">
[Paste the complete modified scene file here]
</FILE>

<FILE name="node_1.lgp">
fol: <template.fol>
terminal: " (on table_left RectPrism_1) "
genericCollisions: true
coll: []
</FILE>
```


--- 
## SCENE INVENTORY (Input Data)
```lisp
# Auto-generated | 4cubes_s01 | mode=nr
world {}
table (world) { shape:ssBox, size:[2.0, 4.0, 0.1, 0.02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

Prefix: "l_"
Include: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" }
Edit l_panda_joint1 { q: 0.0 }
Edit l_panda_joint2 { q: -1.5 }
Edit l_panda_joint3 { q: 0.0 }
Edit l_panda_joint4 { q: -2.5 }
Edit l_panda_joint5 { q: 0.0 }
Edit l_panda_joint6 { q: 1.5 }
Edit l_panda_joint7 { q: 0.0 }
Edit l_panda_finger_joint1 { q: 0.04 }
Edit l_panda_finger_joint2 { q: 0.04 }

Work_Center (table) { Q:"t(0.40 0.00 .051)", shape:ssBox, size:[.04 .04 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Init_Center (table) { Q:"t(-0.36 0.00 .051)", shape:ssBox, size:[.04 .04 .001 .0005], color:[1 1 0 0], contact:0, logical:{ is_place } }

obj_01 (table) { Q:"t(-0.4523 -0.2143 0.065) d(-127.73 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_02 (table) { Q:"t(0.2389 -0.2366 0.065) d(93.63 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_03 (table) { Q:"t(-0.3040 0.1704 0.065) d(42.40 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_04 (table) { Q:"t(-0.2721 0.0637 0.065) d(9.16 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }

```
---