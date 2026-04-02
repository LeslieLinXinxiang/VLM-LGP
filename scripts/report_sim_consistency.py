#!/usr/bin/env python3
import argparse
import json
import math
import re
import xml.etree.ElementTree as ET
from pathlib import Path


OBJ_RE = re.compile(r"^\s*([A-Za-z0-9_]+)\s*\([^)]*\)\s*\{[^\n]*Q:\"t\(([^)]+)\)")
GRIPPER_RE = re.compile(r"\bgripper\b\([^)]*\)\s*:?\s*\{[^\n]*Q:\s*\"([^\"]+)\"")
T_ONLY_RE = re.compile(r"t\(([-+0-9.eE\s]+)\)")


def _parse_xyz(token: str):
    vals = [float(x) for x in token.split()[:3]]
    if len(vals) != 3:
        raise ValueError(f"Cannot parse xyz from token: {token}")
    return vals


def parse_g_objects(g_path: Path):
    txt = g_path.read_text(encoding="utf-8", errors="ignore")
    objs = {}
    for line in txt.splitlines():
        m = OBJ_RE.search(line)
        if not m:
            continue
        name = m.group(1)
        xyz = _parse_xyz(m.group(2))
        objs[name] = xyz
    return objs, txt


def parse_mj_bodies(xml_path: Path):
    root = ET.parse(xml_path).getroot()
    worldbody = root.find("worldbody")
    if worldbody is None:
        return {}
    objs = {}
    for body in worldbody.findall("body"):
        name = body.get("name")
        if not name:
            continue
        pos = body.get("pos")
        if not pos:
            continue
        try:
            objs[name] = _parse_xyz(pos)
        except Exception:
            continue
    return objs


def parse_mj_tcp_definition(panda_xml: Path):
    root = ET.parse(panda_xml).getroot()
    left_finger = None
    left_pad = None
    default_pad = None
    hand = None
    link7_to_hand = None

    # fingertip_pad is often defined in <default class="fingertip_pad"> and inherited by geom.
    for d in root.findall(".//default"):
        if d.get("class") == "fingertip_pad":
            g = d.find("geom")
            if g is not None and g.get("pos"):
                default_pad = g.get("pos")

    for body in root.findall(".//body"):
        name = body.get("name")
        if name == "hand":
            hand = body.get("pos", "0 0 0")
        if name == "left_finger":
            left_finger = body.get("pos", "0 0 0")
            for geom in body.findall("geom"):
                if geom.get("class") == "fingertip_pad":
                    left_pad = geom.get("pos", default_pad or "0 0 0")

    if left_pad is None:
        left_pad = default_pad

    # Find link7->hand offset by searching the hand body's parent chain context.
    for body in root.findall(".//body"):
        if body.get("name") == "hand":
            link7_to_hand = body.get("pos", "0 0 0")
            break

    return {
        "link7_to_hand": _parse_xyz(link7_to_hand or "0 0 0"),
        "hand_to_finger_origin": _parse_xyz(left_finger or "0 0 0"),
        "finger_to_pad": _parse_xyz(left_pad or "0 0 0"),
    }


def parse_rai_gripper_definition(panda_g_text: str):
    m = GRIPPER_RE.search(panda_g_text)
    if not m:
        return {"joint7_to_gripper_marker": [None, None, None]}
    q_expr = m.group(1)
    mt = T_ONLY_RE.search(q_expr)
    if not mt:
        return {"joint7_to_gripper_marker": [None, None, None]}
    return {"joint7_to_gripper_marker": _parse_xyz(mt.group(1))}


def compare_objects(g_objs, mj_objs):
    common = sorted(set(g_objs).intersection(set(mj_objs)))
    rows = []
    for name in common:
        gx, gy, gz = g_objs[name]
        mx, my, mz = mj_objs[name]
        dx, dy, dz = mx - gx, my - gy, mz - gz
        norm = math.sqrt(dx * dx + dy * dy + dz * dz)
        rows.append(
            {
                "name": name,
                "g_xyz": [gx, gy, gz],
                "mj_xyz": [mx, my, mz],
                "delta": [dx, dy, dz],
                "delta_norm": norm,
            }
        )
    rows.sort(key=lambda r: r["delta_norm"], reverse=True)
    return rows


def main():
    parser = argparse.ArgumentParser(description="Report RAI/MuJoCo consistency for scene and TCP definitions.")
    parser.add_argument("--g-scene", default="generated/scene/scene_named.g", help="Path to generated .g scene")
    parser.add_argument(
        "--mj-scene",
        default="simulation/mujoco_ros2_control_examples/panda_resources/panda_mujoco/franka_emika_panda/scene_block.xml",
        help="Path to MuJoCo scene XML (scene_block.xml or scene_planar.xml)",
    )
    parser.add_argument(
        "--panda-g",
        default="rai/test/newLGP/rai-robotModels/panda/panda.g",
        help="Path to RAI Panda model .g",
    )
    parser.add_argument(
        "--panda-xml",
        default="simulation/mujoco_ros2_control_examples/panda_resources/panda_mujoco/franka_emika_panda/panda.xml",
        help="Path to MuJoCo panda.xml",
    )
    parser.add_argument("--json-out", default="", help="Optional output json path")
    args = parser.parse_args()

    g_scene_path = Path(args.g_scene)
    mj_scene_path = Path(args.mj_scene)
    panda_g_path = Path(args.panda_g)
    panda_xml_path = Path(args.panda_xml)

    g_objs, _ = parse_g_objects(g_scene_path)
    mj_objs = parse_mj_bodies(mj_scene_path)
    obj_rows = compare_objects(g_objs, mj_objs)

    panda_g_text = panda_g_path.read_text(encoding="utf-8", errors="ignore")
    rai_tcp = parse_rai_gripper_definition(panda_g_text)
    mj_tcp = parse_mj_tcp_definition(panda_xml_path)

    result = {
        "inputs": {
            "g_scene": str(g_scene_path),
            "mj_scene": str(mj_scene_path),
            "panda_g": str(panda_g_path),
            "panda_xml": str(panda_xml_path),
        },
        "scene_common_object_count": len(obj_rows),
        "scene_top_deltas": obj_rows[:20],
        "tcp_definition": {
            "rai": rai_tcp,
            "mujoco": mj_tcp,
        },
        "diagnosis": [
            "If scene deltas are near-zero but grasp still drifts, prioritize TCP mismatch checks.",
            "Distance-amplified error usually indicates frame rotation/base alignment mismatch, not pure constant offset.",
            "If homing/playback fails intermittently, run trajectory timestamp cleaner before execution.",
        ],
    }

    print("=== Consistency Report ===")
    print(f"G scene:  {g_scene_path}")
    print(f"MJ scene: {mj_scene_path}")
    print(f"Common objects: {len(obj_rows)}")

    if obj_rows:
        print("\nTop scene deltas (name | norm | dx dy dz):")
        for r in obj_rows[:10]:
            dx, dy, dz = r["delta"]
            print(f"- {r['name']:12s} | {r['delta_norm']:.6f} | {dx:+.6f} {dy:+.6f} {dz:+.6f}")

    print("\nTCP definitions:")
    print(f"- RAI joint7->gripper marker: {result['tcp_definition']['rai']['joint7_to_gripper_marker']}")
    print(f"- MJ  link7->hand:           {result['tcp_definition']['mujoco']['link7_to_hand']}")
    print(f"- MJ  hand->finger origin:   {result['tcp_definition']['mujoco']['hand_to_finger_origin']}")
    print(f"- MJ  finger->pad:           {result['tcp_definition']['mujoco']['finger_to_pad']}")

    if args.json_out:
        out_path = Path(args.json_out)
        out_path.write_text(json.dumps(result, indent=2), encoding="utf-8")
        print(f"\nSaved JSON: {out_path}")


if __name__ == "__main__":
    main()
