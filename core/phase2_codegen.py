"""
phase2_codegen.py

Generates .fol and .lgp step files from:
  - Phase1 JSON  (object types + edges)
  - Prompt1 output (strategy candidates)
  - Prompt2 output (selected strategy id)

Output: directory of  step_N_batch_M.fol / step_N_batch_M.lgp  files.

DecisionRule selection logic:
  Pick:
    is_cylinder object  → pick_cylinder
    all others          → pick_touch

  Place (by number of supporters in edges):
    1 → place_straightOn
    2 → place_on_2_supports
    3 → place_on_3_supports
    4 → place_on_4_supports

Terminal condition:
    1 supporter, no position         → (on <sup_name> <obj_name>)
    1 supporter, position left/right
      + supporter is rect_N          → (on Rect_N_Left/Right <obj_name>)
      + supporter is table or other  → (on <sup_name> <obj_name>)
    N supporters (N≥2, bridging)     → (on <s1> <s2> ... <sN> <obj_name>)
"""

import json
import os
import re

# ─── FOL fixed header ────────────────────────────────────────────────────────

_FOL_HEADER = """\
FOL_World{
  hasWait=false
  gamma = 1.
  stepCost = 1.
  timeCost = 0.
}
## basic predicates
is_gripper
is_object
is_place
is_pose
is_box
is_sphere
is_capsule
is_cylinder
## predicates for rules
on
busy
movable
stableOnMulti
## skeletons
above
touch
impulse
restingOn
poseEq
push_
stable
stableOn
quasiStaticOn
dynamic
dynamicOn
liftDownUp
## initial state
START_STATE {}
### RULES
### Reward
REWARD {}
"""

# ─── DecisionRule text blocks ─────────────────────────────────────────────────

_RULE_PICK_TOUCH = """\
DecisionRule pick_touch {
  Obj, From, Hand,
  { (is_gripper Hand) (is_object Obj) (is_cylinder Obj)! (on From Obj) (is_place From) (busy Hand)! }
  { (on From Obj)! (above Obj From)! (touch Obj From)! (stable From Obj)! (stableOn From Obj)!
    (on Hand Obj) (busy Hand) (movable Obj) (touch Hand Obj) (stable Hand Obj) }
}"""

_RULE_PICK_CYLINDER = """\
DecisionRule pick_cylinder {
  Obj, From, Hand,
  { (is_gripper Hand) (is_object Obj) (is_cylinder Obj) (on From Obj) (is_place From) (busy Hand)! }
  { (on From Obj)! (above Obj From)! (touch Obj From)! (stable From Obj)! (stableOn From Obj)!
    (on Hand Obj) (busy Hand) (movable Obj) (touch Hand Obj) (stable Hand Obj) }
}"""

_RULE_PLACE_STRAIGHT = """\
DecisionRule place_straightOn {
  Obj, Hand, To,
  { (is_gripper Hand) (is_object Obj) (on Hand Obj) (is_place To) (busy Obj)! }
  { (busy Hand)! (on Hand Obj)! (stable Hand Obj)! (touch Hand Obj)! (movable Obj)!
    (on To Obj)
    (stableOn To Obj)
  }
}"""

_RULE_PLACE_2 = """\
DecisionRule place_on_2_supports { S1, S2, Obj, Hand,
  { (is_gripper Hand), (on Hand Obj), (is_object S1), (is_object S2) }
  { (on Hand Obj)!, (busy Hand)!, (movable Obj)!, (on S1 S2 Obj), (stableOnMulti S1 S2 Obj) }
}"""

_RULE_PLACE_3 = """\
DecisionRule place_on_3_supports { S1, S2, S3, Obj, Hand,
  { (is_gripper Hand), (on Hand Obj), (is_object S1), (is_object S2), (is_object S3) }
  { (on Hand Obj)!, (busy Hand)!, (movable Obj)!,
    (on S1 S2 S3 Obj),
    (stableOnMulti S1 S2 S3 Obj)
  }
}"""

_RULE_PLACE_4 = """\
DecisionRule place_on_4_supports { S1, S2, S3, S4, Obj, Hand,
  { (is_object S1), (is_object S2), (is_object S3), (is_object S4), (is_object Obj),
    (is_gripper Hand), (on Hand Obj) }
  { (on Hand Obj)!, (busy Hand)!, (movable Obj)!,
    (on S1 S2 S3 S4 Obj),
    (stableOnMulti S1 S2 S3 S4 Obj)
  }
}"""

# ─── Object type → scene name prefix ─────────────────────────────────────────

_TYPE_PREFIX = {
    "rectangular prism": "rect",
    "cylinder":          "cyl",
    "triangular prism":  "tri",
    "cube":              "cube",
    "box":               "cube",
}


def _norm(obj_str: str) -> str:
    return obj_str.strip().lower()


def build_id_to_name(phase1_objects: list) -> dict:
    """
    Map Phase1 integer IDs to scene frame names.
      id=0 (table) → "table"
      Others: type-counter per ascending id  e.g. rect_1, rect_2, cyl_1, tri_1
    """
    counters: dict = {}
    result:   dict = {}
    for obj in sorted(phase1_objects, key=lambda o: o["id"]):
        oid = obj["id"]
        if oid == 0:
            result[0] = "table"
            continue
        prefix = _TYPE_PREFIX.get(_norm(obj["object"]), _norm(obj["object"]).replace(" ", "_"))
        counters[prefix] = counters.get(prefix, 0) + 1
        result[oid] = f"{prefix}_{counters[prefix]}"
    return result


# ─── Rule selectors ───────────────────────────────────────────────────────────

def _pick_rule(obj_type_norm: str) -> str:
    return _RULE_PICK_CYLINDER if obj_type_norm == "cylinder" else _RULE_PICK_TOUCH


_PLACE_RULES = {1: _RULE_PLACE_STRAIGHT, 2: _RULE_PLACE_2, 3: _RULE_PLACE_3, 4: _RULE_PLACE_4}


def _place_rule(n: int) -> str:
    if n not in _PLACE_RULES:
        raise ValueError(f"Unsupported supporter count: {n}. Supported: 1-4.")
    return _PLACE_RULES[n]


# ─── Terminal builder ─────────────────────────────────────────────────────────

def _terminal(obj_name: str, edges: list, id_to_name: dict) -> str:
    """
    Build the LGP terminal predicate string.

    edges: list of {"supporter": <id>, "position"?: "left"/"right"}
    """
    if len(edges) == 1:
        edge     = edges[0]
        sup_id   = edge["supporter"]
        sup_name = id_to_name[sup_id]
        pos      = edge.get("position", "").lower()

        if pos in ("left", "right"):
            # Table: Table_Left / Table_Right
            if sup_name == "table":
                slot = f"Table_{pos.capitalize()}"
                return f"(on {slot} {obj_name})"
            # Rect_N: Rect_N_Left / Rect_N_Right
            m = re.match(r"^rect_(\d+)$", sup_name)
            if m:
                slot = f"Rect_{m.group(1)}_{pos.capitalize()}"
                return f"(on {slot} {obj_name})"
        # default: place on supporter directly (cyl_N, rect_N no-pos, etc.)
        return f"(on {sup_name} {obj_name})"
    else:
        # multi-supporter bridge: (on s1 s2 [s3 [s4]] obj)
        sup_names = " ".join(id_to_name[e["supporter"]] for e in edges)
        return f"(on {sup_names} {obj_name})"


# ─── File content builders ────────────────────────────────────────────────────

def _fol_content(pick: str, place: str) -> str:
    return _FOL_HEADER + pick + "\n" + place + "\n"


def _lgp_content(fol_filename: str, terminal: str) -> str:
    return (
        f"fol: <{fol_filename}>\n"
        f'terminal: " {terminal} "\n'
        f"genericCollisions: true\n"
        f"coll: []\n"
    )


# ─── Main entry point ─────────────────────────────────────────────────────────

def generate_step_files(
    phase1_json:    dict,
    prompt1_output: dict,
    prompt2_output: dict,
    out_dir:        str,
) -> list:
    """
    Generate all step_N_batch_M.fol and .lgp files into out_dir.
    Returns sorted list of generated file paths.
    """
    os.makedirs(out_dir, exist_ok=True)

    objects    = phase1_json["objects"]
    id_to_name = build_id_to_name(objects)
    id_to_obj  = {o["id"]: o for o in objects}

    # Resolve selected strategy (tolerate "strategies" or "candidates" key)
    selected_id = prompt2_output["selected"]
    raw_list    = prompt1_output.get("strategies", prompt1_output.get("candidates", []))
    selected    = next((s for s in raw_list if s["id"] == selected_id), None)
    if selected is None:
        raise ValueError(f"Strategy '{selected_id}' not found in Prompt1 output.")

    batches   = selected["batches"]
    generated = []

    for step_idx, batch in enumerate(batches, start=1):
        for batch_idx, obj_id in enumerate(batch, start=1):
            obj      = id_to_obj[obj_id]
            obj_name = id_to_name[obj_id]
            edges    = obj["edges"]

            if not edges:
                raise ValueError(f"Object id={obj_id} ({obj_name}) has no edges/supporters.")

            pick     = _pick_rule(_norm(obj["object"]))
            place    = _place_rule(len(edges))
            terminal = _terminal(obj_name, edges, id_to_name)

            base     = f"step_{step_idx}_batch_{batch_idx}"
            fol_path = os.path.join(out_dir, f"{base}.fol")
            lgp_path = os.path.join(out_dir, f"{base}.lgp")

            with open(fol_path, "w") as f:
                f.write(_fol_content(pick, place))
            with open(lgp_path, "w") as f:
                f.write(_lgp_content(f"{base}.fol", terminal))

            generated.extend([fol_path, lgp_path])
            print(f"  [codegen] {base:25s}  obj={obj_name:10s}  terminal={terminal}")

    return sorted(generated)
