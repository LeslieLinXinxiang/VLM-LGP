#!/usr/bin/env python3
"""
Track 2 (VLM-MSGraph naive-interpolation baseline) — Phase 2: `.g` -> MuJoCo scene converter.

Does NOT hand-build a Panda body tree from scratch. Reuses the vendored, working Panda MJCF
model (`simulation/mujoco_ros2_control_examples/panda_resources/panda_mujoco/franka_emika_panda/panda.xml`)
as-is for the arm's body/mesh/joint definitions, and only:
  - re-roots the `link0` body under a new wrapper body placed at the world pose resolved
    from the scene's `Edit l_panda_base (table): { Q: ... }` line (Phase 1 parser),
  - adds 7 new `<position>` actuators for panda_joint1..7 (the vendored file only ships a
    gripper actuator — no arm actuation at all),
  - adds a `table` body, one body per scene object (freejoint + box/cylinder geom from the
    `.g` shape/size), and one `<site>` per named place slot (`Table_Left` etc.) as reference
    markers for Phase 3's grasp/place pose lookups.

Currently handles `ssBox`/box and cylinder object geometry (the Cube Stacking benchmark).
Mesh-shaped FMB objects are carried through as MuJoCo mesh geoms when a `.obj`/`.stl` mesh
path is present in the `.g` file, but this path is not yet validated end-to-end (Phase 2/3
validation target is Cube Stacking first, per plan).
"""
from __future__ import annotations

import math
import sys
import xml.etree.ElementTree as ET
from pathlib import Path
from typing import Dict, List, Optional

import numpy as np

ROOT_DIR = Path(__file__).resolve().parents[2]
if str(ROOT_DIR) not in sys.path:
    sys.path.insert(0, str(ROOT_DIR))

from experiments.scripts.baseline_naive_interp_scene_parser import parse_scene  # noqa: E402

# CoACD convex-decomposition pieces (see `simulation/scripts/decompose_mesh.py`), keyed by the
# source mesh's own basename. A raw concave mesh (e.g. FMB's `shape_4_1` peg or `base_board`,
# both non-convex - confirmed by a per-face plane test: 22/60 and 93/116 faces respectively lie
# outside their neighboring faces' planes, by up to 90mm and 215mm) gets its COLLISION geometry
# auto-convexified by MuJoCo to a single hull that fills in every concave notch - inflating a
# ~3x8x15cm peg by up to 9cm of phantom volume, enough for the gripper to register a "collision"
# well before touching the visible surface. CoACD instead splits the mesh into several genuinely
# convex pieces whose union closely matches the true (concave) shape, each piece independently
# hull-collided by MuJoCo with no inflation. When decomposed pieces exist for a mesh, the RAW
# mesh is kept for rendering only (contype/conaffinity 0) and the pieces carry the real collision.
_DECOMPOSED_DIR = ROOT_DIR / "assets" / "fmb" / "new_fmb" / "decomposed"


def _decomposed_pieces(mesh_path: str) -> List[Path]:
    base_name = Path(mesh_path).stem
    if not _DECOMPOSED_DIR.exists():
        return []
    pieces = sorted(
        _DECOMPOSED_DIR.glob(f"{base_name}_*.obj"),
        key=lambda p: int(p.stem.rsplit("_", 1)[1]),
    )
    return pieces

PANDA_XML = (
    ROOT_DIR
    / "simulation"
    / "mujoco_ros2_control_examples"
    / "panda_resources"
    / "panda_mujoco"
    / "franka_emika_panda"
    / "panda.xml"
)
PANDA_ASSETS_DIR = PANDA_XML.parent / "assets"

# Rough Menagerie-style PD gains: strong enough to track slow Eq.7 waypoints without wild
# overshoot; joint 1 (largest inertia at the base) gets the highest gain, tapering outward.
_ARM_ACTUATOR_GAINS = {
    "panda_joint1": (4500, 450),
    "panda_joint2": (4500, 450),
    "panda_joint3": (3500, 350),
    "panda_joint4": (3500, 350),
    "panda_joint5": (2000, 200),
    "panda_joint6": (2000, 200),
    "panda_joint7": (2000, 200),
}


def _rot_to_quat_wxyz(R: np.ndarray) -> np.ndarray:
    """3x3 rotation matrix -> (w, x, y, z) quaternion (MuJoCo convention)."""
    tr = np.trace(R)
    if tr > 0:
        S = math.sqrt(tr + 1.0) * 2
        w = 0.25 * S
        x = (R[2, 1] - R[1, 2]) / S
        y = (R[0, 2] - R[2, 0]) / S
        z = (R[1, 0] - R[0, 1]) / S
    elif R[0, 0] > R[1, 1] and R[0, 0] > R[2, 2]:
        S = math.sqrt(1.0 + R[0, 0] - R[1, 1] - R[2, 2]) * 2
        w = (R[2, 1] - R[1, 2]) / S
        x = 0.25 * S
        y = (R[0, 1] + R[1, 0]) / S
        z = (R[0, 2] + R[2, 0]) / S
    elif R[1, 1] > R[2, 2]:
        S = math.sqrt(1.0 + R[1, 1] - R[0, 0] - R[2, 2]) * 2
        w = (R[0, 2] - R[2, 0]) / S
        x = (R[0, 1] + R[1, 0]) / S
        y = 0.25 * S
        z = (R[1, 2] + R[2, 1]) / S
    else:
        S = math.sqrt(1.0 + R[2, 2] - R[0, 0] - R[1, 1]) * 2
        w = (R[1, 0] - R[0, 1]) / S
        x = (R[0, 2] + R[2, 0]) / S
        y = (R[1, 2] + R[2, 1]) / S
        z = 0.25 * S
    q = np.array([w, x, y, z])
    return q / np.linalg.norm(q)


def _fmt(vals) -> str:
    return " ".join(f"{v:.6g}" for v in vals)


def _half_extents(size: List[float]) -> List[float]:
    # RAI ssBox size = [full_dx, full_dy, full_dz, corner_radius]; MuJoCo box size = half-extents.
    return [max(s, 1e-4) / 2.0 for s in size[:3]]


def _look_at_xyaxes(cam_pos: np.ndarray, target: np.ndarray, world_up=(0.0, 0.0, 1.0)) -> np.ndarray:
    """MuJoCo `xyaxes` (camera local +x, +y; camera looks along its own -z)."""
    forward = target - cam_pos
    forward = forward / np.linalg.norm(forward)
    up = np.asarray(world_up, dtype=float)
    right = np.cross(forward, up)
    right = right / np.linalg.norm(right)
    true_up = np.cross(right, forward)
    return np.concatenate([right, true_up])


def convert_g_to_mjcf(g_path: str | Path, out_xml_path: str | Path) -> Path:
    g_path = Path(g_path)
    out_xml_path = Path(out_xml_path)
    scene = parse_scene(g_path)

    panda_tree = ET.parse(PANDA_XML)
    panda_root = panda_tree.getroot()
    link0_el = panda_root.find(".//body[@name='link0']")
    if link0_el is None:
        raise RuntimeError(f"could not find link0 body in {PANDA_XML}")

    mjc = ET.Element("mujoco", {"model": "track2_baseline_scene"})
    ET.SubElement(mjc, "compiler", {"angle": "radian", "meshdir": str(PANDA_ASSETS_DIR), "autolimits": "true"})
    visual_el = ET.SubElement(mjc, "visual")
    ET.SubElement(visual_el, "global", {"offwidth": "1280", "offheight": "960"})

    option_el = panda_root.find("option")
    if option_el is not None:
        mjc.append(option_el)

    default_el = panda_root.find("default")
    if default_el is not None:
        mjc.append(default_el)

    asset_el = panda_root.find("asset")
    if asset_el is not None:
        mjc.append(asset_el)

    worldbody = ET.SubElement(mjc, "worldbody")
    ET.SubElement(worldbody, "light", {"name": "top", "pos": "0 0 2", "mode": "trackcom"})
    ET.SubElement(
        worldbody,
        "geom",
        {"name": "floor", "type": "plane", "size": "0 0 0.05", "pos": "0 0 0", "rgba": "0.6 0.6 0.6 1"},
    )

    # --- table ---
    table_fr = scene.frames.get("table")
    if table_fr is not None:
        t_pos, t_R = scene.world_pose("table")
        t_quat = _rot_to_quat_wxyz(t_R)
        t_size = _half_extents(table_fr.size) if table_fr.size else [1.0, 2.0, 0.05]
        table_body = ET.SubElement(
            worldbody, "body", {"name": "table", "pos": _fmt(t_pos), "quat": _fmt(t_quat)}
        )
        ET.SubElement(
            table_body,
            "geom",
            {"name": "table_geom", "type": "box", "size": _fmt(t_size), "rgba": "0.3 0.3 0.3 1"},
        )

    # --- panda arm, re-rooted at the scene's l_panda_base world pose ---
    base_pos, base_R = scene.world_pose("l_panda_base")
    base_quat = _rot_to_quat_wxyz(base_R)
    panda_mount = ET.SubElement(
        worldbody, "body", {"name": "panda_mount", "pos": _fmt(base_pos), "quat": _fmt(base_quat)}
    )
    panda_mount.append(link0_el)

    # --- a fixed "front" camera: beyond the table (opposite side from the robot base),
    # elevated, looking back across the workspace at the robot - i.e. the view a person
    # standing in front of the robot watching it work would see. Framed around FMB's
    # `base_board` when present, not the generic `table` frame - FMB's actual work surface
    # sits well away from the nominal table center (e.g. offset along +X), so using `table`
    # here left the real workspace out of frame / hidden behind the arm.
    if table_fr is not None:
        workspace_ref_fr = scene.frames.get("base_board")
        t_pos = scene.world_pose("base_board")[0] if workspace_ref_fr is not None else t_pos
        forward_xy = t_pos[:2] - base_pos[:2]
        norm = np.linalg.norm(forward_xy)
        forward_xy = forward_xy / norm if norm > 1e-6 else np.array([1.0, 0.0])
        # Target the workspace-reference frame's OWN height (not +0.2m above it) - for FMB,
        # base_board sits close to table height, so aiming above it tilted the "front" view
        # up past the board entirely, leaving it out of frame (only the arm's upper body and
        # floating objects/sites were visible). Camera height/offset also pulled in (0.65->0.4,
        # 0.9->0.7) so the board isn't so distant/high that it reads as a sliver near frame edge.
        cam_pos = np.array([t_pos[0] + forward_xy[0] * 0.7, t_pos[1] + forward_xy[1] * 0.7, t_pos[2] + 0.4])
        cam_target = np.array([(base_pos[0] + t_pos[0]) / 2, (base_pos[1] + t_pos[1]) / 2, t_pos[2]])
        xyaxes = _look_at_xyaxes(cam_pos, cam_target)
        ET.SubElement(
            worldbody,
            "camera",
            {"name": "front", "pos": _fmt(cam_pos), "xyaxes": _fmt(xyaxes), "fovy": "50"},
        )

        # --- "top": bird's-eye, straight down at the workspace center ---
        workspace_center_xy = (base_pos[:2] + t_pos[:2]) / 2
        top_pos = np.array([workspace_center_xy[0], workspace_center_xy[1], t_pos[2] + 1.2])
        top_target = np.array([workspace_center_xy[0], workspace_center_xy[1], t_pos[2]])
        ET.SubElement(
            worldbody,
            "camera",
            {"name": "top", "pos": _fmt(top_pos), "xyaxes": _fmt(_look_at_xyaxes(top_pos, top_target, world_up=(1.0, 0.0, 0.0))), "fovy": "50"},
        )

        # --- "side": perpendicular to the front view, level with the workspace ---
        side_dir = np.array([-forward_xy[1], forward_xy[0]])
        side_pos = np.array([workspace_center_xy[0] + side_dir[0] * 0.9, workspace_center_xy[1] + side_dir[1] * 0.9, t_pos[2] + 0.45])
        side_target = np.array([workspace_center_xy[0], workspace_center_xy[1], t_pos[2] + 0.15])
        ET.SubElement(
            worldbody,
            "camera",
            {"name": "side", "pos": _fmt(side_pos), "xyaxes": _fmt(_look_at_xyaxes(side_pos, side_target)), "fovy": "50"},
        )

    # a TCP reference site between the fingers, used by Phase 3's IK target
    hand_body = panda_mount.find(".//body[@name='hand']")
    if hand_body is not None:
        ET.SubElement(
            hand_body,
            "site",
            {"name": "tcp", "pos": "0 0 0.1034", "size": "0.005", "rgba": "1 0 0 1"},
        )

    # --- objects ---
    # Some FMB parts are a THREE-frame chain in the .g file: a small `ssBox` "proxy" (logical
    # frame-control anchor, `contact:0` - not meant to be a real physical body), a `_mesh`
    # child carrying the actual visual/collision geometry (`contact:1`), and a `_handle`
    # marker for grasp targeting. All three carry `is_object`, so `scene.object_names()`
    # returns all of them - but the child frames use `joint:rigid` in the source scene (fixed
    # to their parent), not a free body. Giving every one of them its OWN top-level freejoint
    # (as an earlier version of this converter did) breaks that rigid attachment: the mesh
    # geometry then physically detaches from the proxy the moment the proxy gets grasped and
    # moved, leaving real collision geometry stranded at its ORIGINAL spawn point while an
    # (accidentally still-collidable) small proxy cube gets carried around instead - this
    # produced both a phantom extra block in the scene and wildly wrong collision/placement
    # behavior. Fix: only objects whose PARENT is not itself a movable object get a `<body>` +
    # `<freejoint>`; objects parented to another object become a nested, RIGIDLY FIXED child
    # body (no freejoint, positioned by the parent-local `Q` offset already on file) instead,
    # so they move exactly together with their parent, matching the source scene's intent.
    # `joint:rigid` alone can't distinguish a genuinely-manipulable object from a static
    # fixture: RAI tags BOTH the same way (e.g. FMB's `shape_4_1` - the proxy actually picked
    # and placed - and `base_board` - the fixed workspace foundation objects get placed ON -
    # carry an identical `joint:rigid` relative to `table`). An earlier version of this rule
    # used the `is_place` tag to single out `base_board` (it hosts the named place-slot child
    # frames Table_Left/Center/...), reasoning a dual `is_object, is_place` tag meant "static
    # surface, not a pick target" - but that's WRONG for Cube Stacking: `is_place` there marks
    # ANY block another block can be stacked onto, so ordinary pickable blocks like
    # `rectprism_1` (task step 1: `rectprism_1 -> Table_Left`) are ALSO `is_object, is_place`
    # tagged - the is_place rule wrongly denied them a freejoint too, leaving
    # `run_to_ctrl_target`'s `mj_name2id(..., f"{obj_name}_freejoint")` lookup unable to find
    # one, falling back to numpy's `[-1]` (silently the LAST joint in the model, e.g. a 1-dof
    # gripper finger) and crashing with a qpos broadcast-shape error the moment that object was
    # placed. The real signal is `contact` combined with children: `base_board` has `contact:0`
    # on itself AND none of its children (`Table_Left` etc, all `is_place` markers) ever carry
    # `contact:1` - there is no real collision geometry anywhere in that group, so giving it a
    # freejoint just means "free-falls with nothing to ever rest against." FMB's `shape_4_1`
    # also has `contact:0` on its own proxy frame, but its `shape_4_1_mesh` CHILD is `contact:1`
    # - real collision exists in the group, so it needs to stay movable. Cube Stacking objects
    # have `contact:1` directly on themselves, so this rule never even reaches the child check
    # for them - they always keep their freejoint regardless of `is_place`.
    object_names_set = set(scene.object_names())

    def _has_colliding_child(name: str) -> bool:
        return any(fr.parent == name and fr.contact == 1 for fr in scene.frames.values())

    static_object_names = [
        n for n in scene.object_names()
        if scene.frames[n].parent not in object_names_set
        and scene.frames[n].contact == 0
        and not _has_colliding_child(n)
    ]
    root_object_names = [
        n for n in scene.object_names()
        if scene.frames[n].parent not in object_names_set and n not in static_object_names
    ]
    child_object_names = [n for n in scene.object_names() if scene.frames[n].parent in object_names_set]
    body_elements: Dict[str, ET.Element] = {}

    def add_object_geom(parent_el: ET.Element, obj_name: str, fr) -> None:
        mass = fr.mass if fr.mass is not None else 0.1
        contact_attrs = {"contype": "0", "conaffinity": "0"} if fr.contact == 0 else {}
        if fr.shape in {"ssbox", "box"} and fr.size:
            ET.SubElement(
                parent_el,
                "geom",
                {
                    "name": f"{obj_name}_geom",
                    "type": "box",
                    "size": _fmt(_half_extents(fr.size)),
                    "mass": f"{mass:.4g}",
                    "rgba": "0.9 0.6 0.1 1",
                    **contact_attrs,
                },
            )
        elif fr.shape == "cylinder" and fr.size:
            radius = fr.size[0] if fr.size else 0.02
            half_h = (fr.size[1] / 2.0) if len(fr.size) > 1 else 0.02
            ET.SubElement(
                parent_el,
                "geom",
                {
                    "name": f"{obj_name}_geom",
                    "type": "cylinder",
                    "size": f"{radius:.6g} {half_h:.6g}",
                    "mass": f"{mass:.4g}",
                    "rgba": "0.9 0.6 0.1 1",
                    **contact_attrs,
                },
            )
        elif fr.shape == "mesh" and fr.mesh_path:
            mesh_asset_name = f"{obj_name}_mesh_asset"
            ET.SubElement(asset_el, "mesh", {"name": mesh_asset_name, "file": fr.mesh_path})
            pieces = _decomposed_pieces(fr.mesh_path)
            if pieces:
                # visual-only: the true (possibly concave) shape, excluded from collision AND
                # from mass (mass lives on the collision pieces below - giving it mass too would
                # double-count and inflate the body's real inertia).
                ET.SubElement(
                    parent_el,
                    "geom",
                    {
                        "name": f"{obj_name}_geom",
                        "type": "mesh",
                        "mesh": mesh_asset_name,
                        "mass": "0",
                        "rgba": "0.9 0.6 0.1 1",
                        "contype": "0",
                        "conaffinity": "0",
                    },
                )
                piece_mass = mass / len(pieces)
                for i, piece_path in enumerate(pieces):
                    piece_asset_name = f"{obj_name}_piece{i}_asset"
                    ET.SubElement(asset_el, "mesh", {"name": piece_asset_name, "file": str(piece_path)})
                    # Deliberately NOT applying `contact_attrs` here: these pieces exist
                    # specifically to give the object real, accurate collision geometry (that's
                    # the entire point of the CoACD decomposition), regardless of the source
                    # `.g` frame's own `contact` flag. `base_board` has `contact:0` in the `.g`
                    # file (RAI's own proxy-level flag, on the pre-decomposition single mesh),
                    # but the whole reason it now has decomposed pieces at all is so it behaves
                    # as a real, solid foundation - applying `contact_attrs` here (as an earlier
                    # version of this code did) silently zeroed contype/conaffinity right back
                    # out, so `shape_4_1` physically passed straight through the board on
                    # placement despite the pieces being geometrically present.
                    ET.SubElement(
                        parent_el,
                        "geom",
                        {
                            "name": f"{obj_name}_piece{i}_geom",
                            "type": "mesh",
                            "mesh": piece_asset_name,
                            "mass": f"{piece_mass:.4g}",
                            "rgba": "0.9 0.6 0.1 1",
                            "group": "3",
                        },
                    )
            else:
                ET.SubElement(
                    parent_el,
                    "geom",
                    {
                        "name": f"{obj_name}_geom",
                        "type": "mesh",
                        "mesh": mesh_asset_name,
                        "mass": f"{mass:.4g}",
                        "rgba": "0.9 0.6 0.1 1",
                        **contact_attrs,
                    },
                )

    for obj_name in static_object_names:
        fr = scene.frames[obj_name]
        if fr.shape not in {"ssbox", "box", "cylinder", "mesh"}:
            continue
        pos, R = scene.world_pose(obj_name)
        quat = _rot_to_quat_wxyz(R)
        body = ET.SubElement(worldbody, "body", {"name": obj_name, "pos": _fmt(pos), "quat": _fmt(quat)})
        body_elements[obj_name] = body
        add_object_geom(body, obj_name, fr)

    for obj_name in root_object_names:
        fr = scene.frames[obj_name]
        if fr.shape not in {"ssbox", "box", "cylinder", "mesh"}:
            continue
        pos, R = scene.world_pose(obj_name)
        quat = _rot_to_quat_wxyz(R)
        body = ET.SubElement(worldbody, "body", {"name": obj_name, "pos": _fmt(pos), "quat": _fmt(quat)})
        ET.SubElement(body, "freejoint", {"name": f"{obj_name}_freejoint"})
        body_elements[obj_name] = body
        add_object_geom(body, obj_name, fr)

    # second pass: attach children to whichever parent body element exists (parent is always
    # processed first since `root_object_names`/`child_object_names` is one level of nesting
    # in every scene observed so far - `.g` files could in principle nest deeper, but neither
    # Cube Stacking nor FMB currently do).
    for obj_name in child_object_names:
        fr = scene.frames[obj_name]
        if fr.shape not in {"ssbox", "box", "cylinder", "mesh"}:
            continue
        parent_el = body_elements.get(fr.parent)
        if parent_el is None:
            continue  # parent itself wasn't a renderable object (e.g. unsupported shape) - skip
        local_pos = fr.T_local[:3, 3]
        local_quat = _rot_to_quat_wxyz(fr.T_local[:3, :3])
        child_body = ET.SubElement(parent_el, "body", {"name": obj_name, "pos": _fmt(local_pos), "quat": _fmt(local_quat)})
        body_elements[obj_name] = child_body
        add_object_geom(child_body, obj_name, fr)

    # --- named place slots as reference sites (non-colliding) ---
    for slot in scene.place_slot_names():
        pos, R = scene.world_pose(slot)
        quat = _rot_to_quat_wxyz(R)
        ET.SubElement(
            worldbody,
            "site",
            {"name": slot, "pos": _fmt(pos), "quat": _fmt(quat), "type": "sphere", "size": "0.004", "rgba": "0 1 1 0.6"},
        )

    tendon_el = panda_root.find("tendon")
    if tendon_el is not None:
        mjc.append(tendon_el)
    equality_el = panda_root.find("equality")
    if equality_el is not None:
        mjc.append(equality_el)

    actuator = ET.SubElement(mjc, "actuator")
    for jn, (kp, kv) in _ARM_ACTUATOR_GAINS.items():
        ET.SubElement(
            actuator,
            "position",
            {"name": f"act_{jn}", "joint": jn, "kp": str(kp), "kv": str(kv)},
        )
    panda_actuator_el = panda_root.find("actuator")
    if panda_actuator_el is not None:
        for child in list(panda_actuator_el):
            actuator.append(child)

    # arm-only self-collision fix (empirically observed, not present in the intended home
    # pose below): the vendored mesh asset's link5/hand collision volumes overlap at qpos=0,
    # which is what MuJoCo defaults to before a keyframe/explicit qpos is applied. Track 2 is
    # not testing Panda's own self-collision modeling, so exclude this one known pair.
    contact_el = ET.SubElement(mjc, "contact")
    ET.SubElement(contact_el, "exclude", {"body1": "link5", "body2": "hand"})

    # home keyframe: the scene's `Edit l_panda_jointN { q: ... }` values. Hinge/slide joints
    # default to qpos=0 otherwise (freejoint objects default to their body pos/quat already).
    # A keyframe qpos vector must cover the full nq, so pad with each object's own freejoint
    # pos/quat (identical to what qpos0 would already default to from the body pos/quat -
    # just made explicit alongside the arm's non-default home values).
    arm_joint_order = [f"panda_joint{i}" for i in range(1, 8)] + ["panda_finger_joint1", "panda_finger_joint2"]
    home_qpos_parts = [float(scene.panda_home_q.get(f"l_{jn}", 0.0)) for jn in arm_joint_order]
    # only ROOT objects have a freejoint (and therefore a qpos entry to pad) - nested children
    # are now rigidly fixed to their parent body, no qpos of their own.
    obj_pose_parts: List[float] = []
    for obj_name in root_object_names:
        fr = scene.frames[obj_name]
        if fr.shape not in {"ssbox", "box", "cylinder", "mesh"}:
            continue
        pos, R = scene.world_pose(obj_name)
        quat = _rot_to_quat_wxyz(R)
        obj_pose_parts.extend([float(v) for v in pos])
        obj_pose_parts.extend([float(v) for v in quat])
    keyframe_el = ET.SubElement(mjc, "keyframe")
    ET.SubElement(keyframe_el, "key", {"name": "home", "qpos": _fmt(home_qpos_parts + obj_pose_parts)})

    out_xml_path.parent.mkdir(parents=True, exist_ok=True)
    ET.ElementTree(mjc).write(out_xml_path, encoding="unicode", xml_declaration=False)
    return out_xml_path


if __name__ == "__main__":
    g_path = ROOT_DIR / (sys.argv[1] if len(sys.argv) > 1 else "experiments/scenes/4cubes/s01/random_trials/trial_01_nr.g")
    out_path = ROOT_DIR / "experiments" / "evaluations" / "Baseline_execution" / "_phase2_validation" / "trial_01_nr.mjcf.xml"

    convert_g_to_mjcf(g_path, out_path)
    print(f"wrote {out_path}")

    import mujoco

    model = mujoco.MjModel.from_xml_path(str(out_path))
    data = mujoco.MjData(model)
    mujoco.mj_resetDataKeyframe(model, data, 0)  # apply the "home" keyframe (arm's actual home q)
    mujoco.mj_forward(model, data)

    print(f"nq={model.nq} nv={model.nv} nbody={model.nbody} nu={model.nu}")
    print("joints:", [mujoco.mj_id2name(model, mujoco.mjtObj.mjOBJ_JOINT, i) for i in range(model.njnt)])
    print("bodies:", [mujoco.mj_id2name(model, mujoco.mjtObj.mjOBJ_BODY, i) for i in range(model.nbody)])

    n_contacts_penetrating = sum(1 for c in data.contact if c.dist < -1e-4)
    print(f"ncon={data.ncon} penetrating(dist<-1e-4)={n_contacts_penetrating}")
    assert n_contacts_penetrating == 0, "converted scene has interpenetration at t=0"
    print("self-check PASSED: model compiles, loads, and is collision-free at t=0.")
