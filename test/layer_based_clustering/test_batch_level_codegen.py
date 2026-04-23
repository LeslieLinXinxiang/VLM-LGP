#!/usr/bin/env python3
"""
Batch-level layer-based clustering codegen test.

This script keeps the current Phase1/Prompt1/Prompt2 input-output contract,
but changes the execution-file emission policy so that each planned batch
produces exactly one .fol/.lgp pair.

It is meant to be a minimal, inspectable regression target for the new
batch-oriented codegen logic.
"""

import argparse
import json
import os
import shutil
import sys
from datetime import datetime
from typing import Dict, List


ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
TEST_DIR = os.path.dirname(__file__)
if ROOT_DIR not in sys.path:
    sys.path.insert(0, ROOT_DIR)
if TEST_DIR not in sys.path:
    sys.path.insert(0, TEST_DIR)

from run_layer_based_codegen import LayerBasedClustering


DEFAULT_INPUT = os.path.join(ROOT_DIR, "generated", "phase1_target_graph.json")
DEFAULT_OUT_DIR = os.path.join(ROOT_DIR, "generated", "layer_based_policy_run_batch")


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


_RULE_PICK_TOUCH = """\
DecisionRule pick_touch {
  Obj, From, Hand,
  { (is_gripper Hand) (is_object Obj) (is_cylinder Obj)! (on From Obj) (is_place From) (busy Hand)! }
  { (on From Obj)! (above Obj From)! (touch Obj From)! (stable From Obj)! (stableOn From Obj)!\
    (on Hand Obj) (busy Hand) (movable Obj) (touch Hand Obj) (stable Hand Obj) }
}"""


_RULE_PICK_CYLINDER = """\
DecisionRule pick_cylinder {
  Obj, From, Hand,
  { (is_gripper Hand) (is_object Obj) (is_cylinder Obj) (on From Obj) (is_place From) (busy Hand)! }
  { (on From Obj)! (above Obj From)! (touch Obj From)! (stable From Obj)! (stableOn From Obj)!\
    (on Hand Obj) (busy Hand) (movable Obj) (touch Hand Obj) (stable Hand Obj) }
}"""


_RULE_PLACE_STRAIGHT = """\
DecisionRule place_straightOn {
  Obj, Hand, To,
  { (is_gripper Hand) (is_object Obj) (on Hand Obj) (is_place To) (busy Obj)! }
  { (busy Hand)! (on Hand Obj)! (stable Hand Obj)! (touch Hand Obj)! (movable Obj)!\
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


def _norm(obj_str: str) -> str:
    return obj_str.strip().lower()


def _place_rule(n_supporters: int) -> str:
    if n_supporters == 1:
        return _RULE_PLACE_STRAIGHT
    if n_supporters == 2:
        return _RULE_PLACE_2
    if n_supporters == 3:
        return _RULE_PLACE_3
    if n_supporters == 4:
        return _RULE_PLACE_4
    raise ValueError(f"Unsupported supporter count: {n_supporters}")


def _pick_rule(obj_type_norm: str) -> str:
    return _RULE_PICK_CYLINDER if obj_type_norm == "cylinder" else _RULE_PICK_TOUCH


def _phase1_objects(phase1: Dict) -> List[Dict]:
    if "objects" in phase1:
        return phase1["objects"]
    if "V" in phase1:
        edges_by_to = {}
        for e in phase1.get("E", []):
            edge = {"supporter": e["from"]}
            if "position" in e:
                edge["position"] = e["position"]
            edges_by_to.setdefault(e["to"], []).append(edge)
        return [
            {"id": v["id"], "object": v["object"], "edges": edges_by_to.get(v["id"], [])}
            for v in phase1.get("V", [])
        ]
    raise ValueError("Unsupported Phase1 format. Expected 'objects' or 'V/E'.")


def _id_to_name(phase1_objects: List[Dict]) -> Dict[int, str]:
    result = {}
    counters = {}
    type_prefix = {
        "rectangular prism": "rect",
        "cylinder": "cyl",
        "triangular prism": "tri",
        "cube": "cube",
        "box": "cube",
    }
    for obj in sorted(phase1_objects, key=lambda o: o["id"]):
        oid = obj["id"]
        if oid == 0:
            result[oid] = "table"
            continue
        prefix = type_prefix.get(_norm(obj["object"]), _norm(obj["object"]).replace(" ", "_"))
        counters[prefix] = counters.get(prefix, 0) + 1
        result[oid] = f"{prefix}_{counters[prefix]}"
    return result


def _terminal(obj_name: str, edges: List[Dict], id_to_name: Dict[int, str]) -> str:
    if len(edges) == 1:
        edge = edges[0]
        sup_id = edge["supporter"]
        sup_name = id_to_name[sup_id]
        pos = str(edge.get("position", "")).lower()
        if pos in ("left", "right", "center", "middle"):
            slot_key = "center" if pos == "middle" else pos
            if sup_name == "table":
                return f"(on Table_{slot_key.capitalize()} {obj_name})"
            if sup_name.startswith("rect_"):
                suffix = sup_name.split("_", 1)[1]
                return f"(on Rect_{suffix}_{slot_key.capitalize()} {obj_name})"
        return f"(on {sup_name} {obj_name})"
    sup_names = " ".join(id_to_name[e["supporter"]] for e in edges)
    return f"(on {sup_names} {obj_name})"


def _fol_content(batch_objects: List[Dict]) -> str:
    # Batch-level files can share the same generic rule library.
    # We emit the rule set once per batch for inspectability.
    if not batch_objects:
        raise ValueError("Cannot build batch file from an empty batch.")
    place_rule = _place_rule(len(batch_objects[0].get("edges", [])))
    pick_rule = _pick_rule(_norm(batch_objects[0]["object"]))
    return _FOL_HEADER + pick_rule + "\n" + place_rule + "\n"


def _lgp_content(fol_filename: str, terminals: List[str]) -> str:
    terminal_line = " ".join(terminals)
    return (
        f"fol: <{fol_filename}>\n"
        f'terminal: " {terminal_line} "\n'
        f"genericCollisions: true\n"
        f"coll: []\n"
    )


def _write_json(path: str, payload: Dict):
    with open(path, "w", encoding="utf-8") as f:
        json.dump(payload, f, indent=2, ensure_ascii=True)


def main():
    parser = argparse.ArgumentParser(description="Batch-level layer-based codegen test")
    parser.add_argument("--input", default=DEFAULT_INPUT, help="Phase1 JSON path")
    parser.add_argument("--out-dir", default=DEFAULT_OUT_DIR, help="Output directory")
    parser.add_argument("--max-batch-size", type=int, default=2, help="Batch size used by planning")
    args = parser.parse_args()

    with open(args.input, "r", encoding="utf-8") as f:
        phase1 = json.load(f)

    clustering = LayerBasedClustering(phase1_json=phase1, max_batch_size=args.max_batch_size)
    result = clustering.build_execution_plan()

    plan_batches = result["prompt1"]["strategies"][0]["batches"]
    phase1_objects = _phase1_objects(phase1)
    id_to_name = _id_to_name(phase1_objects)
    object_by_id = {obj["id"]: obj for obj in phase1_objects}

    if os.path.exists(args.out_dir):
        shutil.rmtree(args.out_dir)
    os.makedirs(args.out_dir, exist_ok=True)

    generated_files: List[str] = []
    batch_manifest = []

    for step_idx, batch in enumerate(plan_batches, start=1):
        terminals = []
        batch_objects = []
        for obj_id in batch:
            obj = object_by_id[obj_id]
            batch_objects.append(obj)
            terminals.append(_terminal(id_to_name[obj_id], obj.get("edges", []), id_to_name))

        fol_name = f"step_{step_idx}_batch_1.fol"
        lgp_name = f"step_{step_idx}_batch_1.lgp"
        fol_path = os.path.join(args.out_dir, fol_name)
        lgp_path = os.path.join(args.out_dir, lgp_name)

        with open(fol_path, "w", encoding="utf-8") as f:
            f.write(_fol_content(batch_objects))
        with open(lgp_path, "w", encoding="utf-8") as f:
            f.write(_lgp_content(fol_name, terminals))

        batch_manifest.append(
            {
                "step": step_idx,
                "batch": batch,
                "terminals": terminals,
                "fol": fol_name,
                "lgp": lgp_name,
            }
        )
        generated_files.extend([fol_path, lgp_path])

    _write_json(
        os.path.join(args.out_dir, "batch_level_execution_plan.json"),
        {
            "input": args.input,
            "algorithm": "LayerBasedClusteringBatchCodegen",
            "planned_batches": plan_batches,
            "batch_manifest": batch_manifest,
        },
    )
    _write_json(
        os.path.join(args.out_dir, "phase2_strategy_policy.json"),
        {"prompt1": result["prompt1"], "prompt2": result["prompt2"]},
    )
    _write_json(
        os.path.join(args.out_dir, "batch_level_metadata.json"),
        {
            "generated_at": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            "note": "One .fol/.lgp pair per planned batch; terminal line concatenates all object terminals in the batch.",
            "batch_count": len(plan_batches),
            "file_count": len(generated_files),
        },
    )

    report_path = os.path.join(args.out_dir, "batch_level_test_report.md")
    with open(report_path, "w", encoding="utf-8") as f:
        f.write(
            "# Batch-Level Layer-Based Codegen Test Report\n\n"
            f"- Input: {args.input}\n"
            f"- Output directory: {args.out_dir}\n"
            f"- Planned batches: {plan_batches}\n"
            f"- Generated file pairs: {len(generated_files) // 2}\n\n"
            "## Logic\n\n"
            "1. Reuse the current layer-based planner.\n"
            "2. Keep the batch structure intact.\n"
            "3. Generate one .fol/.lgp pair per batch.\n"
            "4. Put all object terminals of the batch into one LGP terminal line.\n\n"
            "## File layout\n\n"
            "Each batch becomes: `step_<n>_batch_1.fol` and `step_<n>_batch_1.lgp`.\n"
        )

    print("[BATCH-CODEGEN] input:", args.input)
    print("[BATCH-CODEGEN] out_dir:", args.out_dir)
    print("[BATCH-CODEGEN] planned_batches:", plan_batches)
    print("[BATCH-CODEGEN] generated_pairs:", len(generated_files) // 2)
    print("[BATCH-CODEGEN] report:", report_path)


if __name__ == "__main__":
    main()
