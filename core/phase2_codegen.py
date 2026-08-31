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

def _fol_header(has_wait: bool = False) -> str:
    # We ignore has_wait for now because WAIT keyword causes crashes in this binary version
    return """\
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
# Supports both standard formats (from prompts) and VLM's actual PascalCase outputs

_TYPE_PREFIX = {
    # Standard format (from prompts)
    "rectangular prism": "rect",
    "cylinder":          "cyl",
    "triangular prism":  "tri",
    "cube":              "cube",
    "box":               "cube",
    "long rectangular prism": "longrect",
    
    # VLM's PascalCase formats (fallback support)
    "rectprism":         "rectprism",
    "triprism":          "triprism",
    "longrectprism":     "longrect",
    "long_rectprism":    "longrect",
    "long rectprism":    "longrect",
    
    # FMB Shape support
    "shape 1": "shape_1",
    "shape 2": "shape_2",
    "shape 3": "shape_3",
    "shape 4": "shape_4",
}


def _norm(obj_str: str) -> str:
    return obj_str.strip().lower()


def build_id_to_name(phase1_objects: list, inventory_data: list = None) -> dict:
    """
    Map Phase1 integer IDs to actual scene frame names (logical_id) using inventory.
      id=0 (table) → "table"
      Others: pop available IDs from phase0_layout.json dictionary matching shape type.
    """
    import re
    def natural_sort_key(s):
        return [int(text) if text.isdigit() else text.lower() for text in re.split('([0-9]+)', s)]

    inventory_by_prefix = {}
    if inventory_data:
        for item in inventory_data:
            logical_id = item.get("logical_id", "")
            # [Fix] Improved regex to capture prefixes before the first underscore
            # This ensures 'longrect_1' yields 'longrect' as the prefix
            m = re.match(r'^([a-zA-Z_]+)(?=_\d+)', logical_id)
            if m:
                pfx = m.group(1).lower()
                inventory_by_prefix.setdefault(pfx, []).append(logical_id)
            else:
                # Fallback if no digit suffix
                pfx = re.match(r'^([a-zA-Z_]+)', logical_id).group(1).lower()
                inventory_by_prefix.setdefault(pfx, []).append(logical_id)
        
        for pfx in inventory_by_prefix:
            inventory_by_prefix[pfx].sort(key=natural_sort_key)

    counters: dict = {}
    result:   dict = {}
    for obj in sorted(phase1_objects, key=lambda o: o["id"]):
        oid = obj["id"]
        if oid == 0:
            result[0] = "table"
            continue
        
        obj_name_norm = _norm(obj["object"])
        prefix = _TYPE_PREFIX.get(obj_name_norm, obj_name_norm.replace(" ", "_"))
        
        # Handle prefix aliases to be robust to rect/rectprism and tri/triprism naming differences
        lookup_prefix = prefix
        if inventory_data:
            if lookup_prefix not in inventory_by_prefix or not inventory_by_prefix[lookup_prefix]:
                if lookup_prefix == "rectprism" and "rect" in inventory_by_prefix and inventory_by_prefix["rect"]:
                    lookup_prefix = "rect"
                elif lookup_prefix == "rect" and "rectprism" in inventory_by_prefix and inventory_by_prefix["rectprism"]:
                    lookup_prefix = "rectprism"
                elif lookup_prefix == "triprism" and "tri" in inventory_by_prefix and inventory_by_prefix["tri"]:
                    lookup_prefix = "tri"
                elif lookup_prefix == "tri" and "triprism" in inventory_by_prefix and inventory_by_prefix["triprism"]:
                    lookup_prefix = "triprism"

        if inventory_data and lookup_prefix in inventory_by_prefix and inventory_by_prefix[lookup_prefix]:
            # Exact Match Pop from dictionary
            result[oid] = inventory_by_prefix[lookup_prefix].pop(0)
        else:
            # Fallback legacy behavior if dictionary is depleted/missing
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

def _terminal(obj_name: str, edges: list, id_to_name: dict, id_to_obj: dict) -> str:
    """
    Build the LGP terminal predicate string.

    edges: list of {"supporter": <id>, "position"?: "left"/"right"}
    """
    if len(edges) == 1:
        edge     = edges[0]
        sup_id   = edge["supporter"]
        sup_name = id_to_name[sup_id]
        pos      = edge.get("position", "").lower()

        if pos in ("left", "right", "center", "middle", "front", "back"):
            slot_key = "center" if pos == "middle" else pos
            # Table: Table_Left / Table_Right / Table_Center
            if sup_name == "table":
                slot = f"Table_{slot_key.capitalize()}"
                return f"(on {slot} {obj_name})"
            # rectprism_N: rectprism_1_Left / rectprism_1_Right / rectprism_1_Center
            m = re.match(r"^(rectprism|rect|longrect)_(\d+)$", sup_name)
            if m:
                # Use sup_name directly to preserve case (e.g., 'rectprism_1')
                slot = f"{sup_name}_{slot_key.capitalize()}"
                return f"(on {slot} {obj_name})"
        
        # [Marc's Fix] Fallback for Table without specific position
        if sup_name == "table":
            return f"(on Table_Center {obj_name})"

        # default: place on supporter directly (cyl_N, cube_N, etc.)
        return f"(on {sup_name} {obj_name})"
    else:
        # An object with 2+ edges each carries the SAME "position" value on every edge when
        # the VLM described it as e.g. "this Shape 4 spans both Shape 2 pieces, on the left" -
        # that own-position label is the disambiguator between multiple bridging objects that
        # span the SAME pair of supporters (e.g. two Shape 4 pieces both bridging a front-Shape2
        # and a back-Shape2, one meant for the left side, one for the right). Check it BEFORE
        # falling back to the supporters'-own-position heuristic below: that heuristic keys
        # only on the SUPPORTERS' positions (front/back), which is identical for both objects
        # in exactly this case, and collapsed both to the same "(on Table_Center obj)" terminal
        # - two different objects targeting the identical point, which is geometrically
        # unsatisfiable without heavy overlap and made the solver time out searching for a
        # feasible dual placement instead of failing fast or (worse) silently placing one atop
        # the other. Only acts when every edge on THIS object agrees; any other case
        # (no label, or a genuinely mixed label) falls through to the existing logic unchanged.
        own_pos_set = {e.get("position", "").lower() for e in edges if e.get("position")}
        if own_pos_set == {"left"}:
            return f"(on Table_Left {obj_name})"
        elif own_pos_set == {"right"}:
            return f"(on Table_Right {obj_name})"
        elif own_pos_set in ({"center"}, {"middle"}):
            return f"(on Table_Center {obj_name})"

        # FMB Shape custom logic: map multi-supporter slots to Table slots
        # For multiple supporters, check their relative positions on the table
        sup_pos_set = set()
        for e in edges:
            sup_id = e["supporter"]
            # Look up the supporter object to find its slot position
            if sup_id in id_to_obj:
                sup_obj = id_to_obj[sup_id]
                if len(sup_obj.get("edges", [])) == 1:
                    sup_pos = sup_obj["edges"][0].get("position", "").lower()
                    if sup_pos:
                        sup_pos_set.add(sup_pos)
        
        if "front" in sup_pos_set and "back" in sup_pos_set:
            return f"(on Table_Center {obj_name})"
        elif all(p == "left" for p in sup_pos_set if p):
            return f"(on Table_Left {obj_name})"
        elif all(p == "right" for p in sup_pos_set if p):
            return f"(on Table_Right {obj_name})"
        elif all(p == "center" for p in sup_pos_set if p):
            return f"(on Table_Center {obj_name})"

        # multi-supporter bridge: (on s1 s2 [s3 [s4]] obj)
        sup_names = " ".join(id_to_name[e["supporter"]] for e in edges)
        return f"(on {sup_names} {obj_name})"


# ─── File content builders ────────────────────────────────────────────────────

def _fol_content(pick: str, place: str, has_wait: bool = False) -> str:
    return _fol_header(has_wait=has_wait) + pick + "\n" + place + "\n"


def _global_fol_content(has_wait: bool = False) -> str:
    """A single unified FOL containing ALL pick and place rules.
    Used by split_global mode: every step gets a copy of this same file,
    giving the solver a globally consistent rule-set across all phases.
    """
    all_rules = (
        _RULE_PICK_TOUCH + "\n" +
        _RULE_PICK_CYLINDER + "\n" +
        _RULE_PLACE_STRAIGHT + "\n" +
        _RULE_PLACE_2 + "\n" +
        _RULE_PLACE_3 + "\n" +
        _RULE_PLACE_4 + "\n"
    )
    return _fol_header(has_wait=has_wait) + all_rules


def _lgp_content(fol_filename: str, terminal: str, collision_mode: str = "global") -> str:
    """
    collision_mode:
      "global" → genericCollisions: true, coll: []   (split_global behavior)
      "smart"  → genericCollisions: false, coll: []  (split_smart: active_runtime fills coll at runtime)
    """
    generic = "true" if collision_mode == "global" else "false"
    return (
        f"fol: <{fol_filename}>\n"
        f'terminal: " {terminal} "\n'
        f"genericCollisions: {generic}\n"
        f"coll: []\n"
    )


# ─── Main entry point ─────────────────────────────────────────────────────────

def generate_step_files(
    phase1_json:    dict,
    prompt1_output: dict,
    prompt2_output: dict,
    out_dir:        str,
    inventory_data: list = None,
    collision_mode: str  = "global",
    has_wait: bool = False,
    combine_terminals: bool = False,
) -> list:
    """
    Generate all step_N_batch_M.fol and .lgp files into out_dir.
    Returns sorted list of generated file paths.
    """
    os.makedirs(out_dir, exist_ok=True)

    for fname in os.listdir(out_dir):
        if fname.endswith(".fol") or fname.endswith(".lgp"):
            os.remove(os.path.join(out_dir, fname))

    # Normalize phase1_json if in G=(V,E) format
    if "objects" not in phase1_json and "V" in phase1_json:
        objects = []
        edges_by_to = {}
        for e in phase1_json.get("E", []):
            edge_obj = {"supporter": e["from"]}
            if "position" in e: edge_obj["position"] = e["position"]
            edges_by_to.setdefault(e["to"], []).append(edge_obj)
            
        for v in phase1_json.get("V", []):
            objects.append({
                "id": v["id"],
                "object": v["object"],
                "edges": edges_by_to.get(v["id"], [])
            })
        phase1_json = {"objects": objects}

    objects    = phase1_json["objects"]
    id_to_name = build_id_to_name(objects, inventory_data)
    id_to_obj  = {o["id"]: o for o in objects}

    # Resolve selected strategy (tolerate "strategies" or "candidates" key)
    selected_id = prompt2_output["selected"]
    raw_list    = prompt1_output.get("strategies", prompt1_output.get("candidates", []))
    selected    = next((s for s in raw_list if s["id"] == selected_id), None)
    if selected is None:
        raise ValueError(f"Strategy '{selected_id}' not found in Prompt1 output.")

    batches   = selected["batches"]
    generated = []

    if combine_terminals:
        # Merge the entire trial into a single task file.
        # Keep md order: batches are traversed in order, then objects in each batch.
        combined_terminals = []
        combined_obj_names = []
        seen_ids = set()

        for batch in batches:
            for obj_id in batch:
                if obj_id in seen_ids:
                    continue
                seen_ids.add(obj_id)

                obj      = id_to_obj[obj_id]
                obj_name = id_to_name[obj_id]
                edges    = obj["edges"]
                if not edges:
                    raise ValueError(f"Object id={obj_id} ({obj_name}) has no edges/supporters.")

                term = _terminal(obj_name, edges, id_to_name, id_to_obj)
                combined_terminals.append(term)
                combined_obj_names.append(obj_name)

        terminal = " ".join(combined_terminals)
        base     = "step_1_batch_1"
        fol_path = os.path.join(out_dir, f"{base}.fol")
        lgp_path = os.path.join(out_dir, f"{base}.lgp")

        with open(fol_path, "w") as f:
            f.write(_global_fol_content(has_wait=has_wait))
        with open(lgp_path, "w") as f:
            f.write(_lgp_content(f"{base}.fol", terminal, collision_mode=collision_mode))

        generated.extend([fol_path, lgp_path])
        print(f"  [codegen] {base:25s}  obj=COMBINED    terminal={terminal}")
    else:
        for step_idx, batch in enumerate(batches, start=1):
            for batch_idx, obj_id in enumerate(batch, start=1):
                obj      = id_to_obj[obj_id]
                obj_name = id_to_name[obj_id]
                edges    = obj["edges"]

                if not edges:
                    raise ValueError(f"Object id={obj_id} ({obj_name}) has no edges/supporters.")
                
                terminal = _terminal(obj_name, edges, id_to_name, id_to_obj)
                num_supporters = len(terminal.strip("()").split()) - 2

                pick     = _pick_rule(_norm(obj["object"]))
                place    = _place_rule(num_supporters)

                base     = f"step_{step_idx}_batch_{batch_idx}"
                fol_path = os.path.join(out_dir, f"{base}.fol")
                lgp_path = os.path.join(out_dir, f"{base}.lgp")

                with open(fol_path, "w") as f:
                    if collision_mode == "global":
                        f.write(_global_fol_content(has_wait=has_wait))
                    else:
                        f.write(_fol_content(pick, place, has_wait=has_wait))
                    
                with open(lgp_path, "w") as f:
                    f.write(_lgp_content(f"{base}.fol", terminal, collision_mode=collision_mode))

                generated.extend([fol_path, lgp_path])
                print(f"  [codegen] {base:25s}  obj={obj_name:10s}  terminal={terminal}")

    return sorted(generated)
