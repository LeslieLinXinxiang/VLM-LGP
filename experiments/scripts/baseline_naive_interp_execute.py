#!/usr/bin/env python3
"""
Track 2 (VLM-MSGraph naive-interpolation baseline) — Phase 3: Eq.7 motion + MuJoCo execution.

Eq.7 (design doc §2 / Module B "Motion"): reorient in place -> 4-step decelerating
straight-line interpolation `P+0.8T, +0.92T, +0.96T, +T` -> gripper open/close. Applied once
for pick, once for place. No collision checking, no joint-limit checking, no
lift/transit/descend decomposition.

`P` = the gripper's actual current TCP pose at the start of that sub-motion (pick or place).
`T` = the full displacement vector from P to that sub-motion's target TCP pose (agreed
implementation choice, design doc §2: "most literal reading; also maximizes exposure of the
no-collision-avoidance property").

This module drives ONE pick-place action (one `(obj, to)` pair from Phase 1.2's task
assignment) through MuJoCo: IK-solve each of the 5 waypoints (1 reorient + 4 Eq.7 points) for
both the pick sub-motion and the place sub-motion, feed the solved joint angles to the
`<position>` actuators added in Phase 2, and step physics so the PD controllers actually
carry the arm there (not a teleport).

Grasping is modeled as a **kinematic attach**, not a MuJoCo `weld` equality constraint: a
first attempt used `weld`, but its default `relpose` is computed by the compiler from the
model's qpos0 configuration (hand nowhere near the object), not from wherever the arm
actually is when the gripper closes — activating it snapped the object violently towards the
wrong offset. Rather than hand-derive `eq_data`'s undocumented layout, grasp is implemented by
recording the hand->object relative transform at the moment the gripper closes, then
re-pinning the object's freejoint qpos to `hand_pose(t) ∘ relative_offset` after every physics
step while "holding" is true (zeroing its qvel so nothing carries over on release). This is
consistent with what's being tested here: Track 2 is about the motion strategy's lack of
collision avoidance for the ARM, not gripper contact/grasp-stability dynamics.

No collision avoidance/early-abort is implemented here on purpose: contacts are left for
Phase 4 to classify after the fact from the logged trajectory.
"""
from __future__ import annotations

import math
import sys
from pathlib import Path
from typing import Callable, Dict, List, Optional, Tuple

import mujoco
import numpy as np

ROOT_DIR = Path(__file__).resolve().parents[2]
if str(ROOT_DIR) not in sys.path:
    sys.path.insert(0, str(ROOT_DIR))

from experiments.scripts.baseline_naive_interp_convert_g_to_mjcf import (  # noqa: E402
    _rot_to_quat_wxyz,
    convert_g_to_mjcf,
)
from experiments.scripts.baseline_naive_interp_scene_parser import parse_scene  # noqa: E402

_ARM_JOINTS = [f"panda_joint{i}" for i in range(1, 8)]
_FINGER_JOINTS = ["panda_finger_joint1", "panda_finger_joint2"]
_EQ7_FRACTIONS = [0.8, 0.92, 0.96, 1.0]
_GRASP_APPROACH_QUAT = np.array([0.0, 1.0, 0.0, 0.0])  # gripper z-axis pointing straight down
_GRIPPER_OPEN = 0.04
_GRIPPER_CLOSED = 0.0
_RELEASE_CLEARANCE_M = 0.05  # gap above the computed surface height to avoid a flush-fit launch on release (0.008 still launched)
# A -2cm pick-height offset was tried per early user feedback, but the observation driving it
# (grasp point looking too high) turned out to be a symptom of the concave-mesh convex-hull
# inflation bug (see `baseline_naive_interp_convert_g_to_mjcf._decomposed_pieces`), not a
# genuinely wrong grasp height - now that meshes collide via their real CoACD decomposition
# instead of an inflated single hull, the un-offset grasp point is correct again.
_GRASP_HEIGHT_OFFSET_M = 0.0


def _grasp_height_offset_for(obj_name: str) -> float:
    return _GRASP_HEIGHT_OFFSET_M


def _body_pose(data: mujoco.MjData, body_id: int) -> Tuple[np.ndarray, np.ndarray]:
    return data.xpos[body_id].copy(), data.xquat[body_id].copy()


def _compose(pos_a: np.ndarray, quat_a: np.ndarray, pos_b: np.ndarray, quat_b: np.ndarray) -> Tuple[np.ndarray, np.ndarray]:
    """T_a ∘ T_b: apply transform b in a's frame, then a. Returns (pos, quat)."""
    mat_a = np.zeros(9)
    mujoco.mju_quat2Mat(mat_a, quat_a)
    mat_a = mat_a.reshape(3, 3)
    pos = pos_a + mat_a @ pos_b
    quat = np.zeros(4)
    mujoco.mju_mulQuat(quat, quat_a, quat_b)
    return pos, quat


def _relative_pose(pos_a: np.ndarray, quat_a: np.ndarray, pos_b: np.ndarray, quat_b: np.ndarray) -> Tuple[np.ndarray, np.ndarray]:
    """T_a^-1 ∘ T_b: pose of b expressed in a's frame."""
    inv_quat_a = np.zeros(4)
    mujoco.mju_negQuat(inv_quat_a, quat_a)
    mat_a_inv = np.zeros(9)
    mujoco.mju_quat2Mat(mat_a_inv, inv_quat_a)
    mat_a_inv = mat_a_inv.reshape(3, 3)
    rel_pos = mat_a_inv @ (pos_b - pos_a)
    rel_quat = np.zeros(4)
    mujoco.mju_mulQuat(rel_quat, inv_quat_a, quat_b)
    return rel_pos, rel_quat


def _yaw_from_quat_wxyz(quat: np.ndarray) -> float:
    """Extracts the world-Z rotation angle (rad) of a body resting on the table, whose
    orientation is otherwise identity (objects here only ever get a `d(deg 0 0 1)` yaw)."""
    mat = np.zeros(9)
    mujoco.mju_quat2Mat(mat, quat)
    mat = mat.reshape(3, 3)
    return float(np.arctan2(mat[1, 0], mat[0, 0]))


def object_yaw_quat(yaw: float) -> np.ndarray:
    """Pure world-Z rotation by `yaw`, as a quat - for describing an OBJECT's own target
    orientation (unlike `grasp_quat_for_object_yaw`, which bakes in the gripper's top-down
    approach flip and is for describing the HAND's orientation, not the object's)."""
    c, s = np.cos(yaw / 2.0), np.sin(yaw / 2.0)
    return np.array([c, 0.0, 0.0, s])


def grasp_quat_for_object_yaw(yaw: float) -> np.ndarray:
    """Rotates the base top-down approach orientation about WORLD Z by the object's own yaw,
    so the gripper's finger-opening axis lands flush on two opposing faces instead of on a
    corner. Composed in world frame (pre-multiply) so the fixed "points straight down"
    property of `_GRASP_APPROACH_QUAT` is preserved exactly - only the horizontal axes turn."""
    base_mat = np.zeros(9)
    mujoco.mju_quat2Mat(base_mat, _GRASP_APPROACH_QUAT)
    base_mat = base_mat.reshape(3, 3)
    c, s = np.cos(yaw), np.sin(yaw)
    Rz = np.array([[c, -s, 0.0], [s, c, 0.0], [0.0, 0.0, 1.0]])
    new_mat = Rz @ base_mat
    quat = np.zeros(4)
    mujoco.mju_mat2Quat(quat, new_mat.flatten())
    return quat


def object_symmetry_period(fr) -> float:
    """How much yaw an object's APPEARANCE tolerates without looking wrong: a square cross-
    section (cube) is unchanged by a 90 deg turn; an oblong box (rectprism/longrect) only by
    180 deg (rotating 90 deg would point the long axis the wrong way); anything else (mesh
    shapes - triprism, later FMB parts) gets no assumed symmetry at all (2*pi, i.e. only the
    exact computed angle, k=0, is used) since we don't know their geometry well enough to
    assume a period without risking a subtly-wrong final orientation."""
    if fr is not None and fr.shape in {"ssbox", "box"} and fr.size and len(fr.size) >= 2:
        sx, sy = fr.size[0], fr.size[1]
        if abs(sx - sy) < 0.2 * max(sx, sy):
            return math.pi / 2
        return math.pi
    return 2 * math.pi


# Confirmed by direct visual check (not assumed): FMB's `shape_2_x` mesh boards land rotated
# 90 deg from the intended "long face forward" canonical pose when reset to world identity.
# Box/cylinder objects (Cube Stacking) were separately confirmed correct AT identity, so this
# offset applies only to bare mesh-shaped objects, not the whole benchmark.
_MESH_CANONICAL_YAW_OFFSET = math.pi / 2


def object_canonical_yaw_offset(fr) -> float:
    """The world yaw an object should be reset to at PLACE time to look "front-aligned" -
    0 for box/cylinder (RAI's own `.g` convention already matches world identity there,
    confirmed on Cube Stacking), `_MESH_CANONICAL_YAW_OFFSET` for a bare mesh shape (its
    authored local axes aren't guaranteed to match)."""
    if fr is not None and fr.shape in {"ssbox", "box", "cylinder"}:
        return 0.0
    return _MESH_CANONICAL_YAW_OFFSET


def hand_quat_for_target_object_quat(target_obj_quat: np.ndarray, rel_quat: np.ndarray) -> np.ndarray:
    """Inverts the kinematic-attach relation `obj = hand ∘ rel` to solve for the hand
    orientation that puts the CARRIED OBJECT at `target_obj_quat` - not the hand's own
    orientation at that target. Resetting the hand to some canonical angle does NOT put the
    object at that same canonical angle unless `rel` happens to be identity, which was never
    guaranteed (it depends on the grasp-time alignment convention's relationship to the
    object's own local axes) - this is the fix for placed rectangular objects landing rotated
    90 deg from the intended "long face forward" orientation."""
    inv_rel = np.zeros(4)
    mujoco.mju_negQuat(inv_rel, rel_quat)
    result = np.zeros(4)
    mujoco.mju_mulQuat(result, target_obj_quat, inv_rel)
    return result


_AABB_CORNER_SIGNS = np.array([[sx, sy, sz] for sx in (-1, 1) for sy in (-1, 1) for sz in (-1, 1)], dtype=float)


def _mesh_world_corners(model: mujoco.MjModel, data: mujoco.MjData, obj_name: str) -> Optional[np.ndarray]:
    """The geom's 8 local AABB corners transformed into CURRENT world coordinates. Necessary
    (not just convenient) because MuJoCo silently reorients mesh geometry to its own computed
    principal inertial axes at compile time (`model.mesh_quat`) - confirmed on FMB's
    `shape_2_1`: raw `.obj` vertices span 19cm along their own X, but the compiled geom's
    LOCAL Z half-extent came back as 0.095 instead, i.e. mesh_quat permuted the axes. Reading
    `geom_aabb`'s local Z straight (as if it were the object's own authored vertical axis) is
    what produced the 9.5cm-too-high "dropped from mid-air" placements - transforming through
    the geom's actual world rotation sidesteps needing to understand mesh_quat's semantics at
    all: whatever the axes are, the WORLD-space corners are unambiguous."""
    geom_id = mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_GEOM, f"{obj_name}_geom")
    if geom_id < 0:
        return None
    aabb = model.geom_aabb[geom_id]
    center, half = aabb[:3], aabb[3:]
    corners_local = center + _AABB_CORNER_SIGNS * half  # 8x3
    geom_mat = data.geom_xmat[geom_id].reshape(3, 3)
    geom_pos = data.geom_xpos[geom_id]
    return corners_local @ geom_mat.T + geom_pos  # 8x3, world frame


def object_top_offset(model: mujoco.MjModel, data: mujoco.MjData, obj_name: str, fr) -> float:
    """Distance from an object's own origin (its qpos position) UP to its highest point in
    CURRENT world space - add this to the object's current Z to get the world Z of its top
    surface (what something else would rest ON). Box/cylinder use the `.g` `size:` field
    directly (origin = center, by RAI convention); meshes query MuJoCo's live compiled
    geometry (see `_mesh_world_corners`) instead of assuming a fixed default or trusting the
    AABB's local-frame axes, either of which silently misplaces every mesh object that acts
    as a support or gets placed."""
    if fr is not None and fr.shape in {"ssbox", "box"} and fr.size:
        return fr.size[2] / 2.0
    if fr is not None and fr.shape == "cylinder" and fr.size:
        return (fr.size[1] / 2.0) if len(fr.size) > 1 else 0.02
    corners = _mesh_world_corners(model, data, obj_name)
    if corners is not None:
        body_id = mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_BODY, obj_name)
        return float(corners[:, 2].max() - data.xpos[body_id][2])
    return 0.015


def object_bottom_offset(model: mujoco.MjModel, data: mujoco.MjData, obj_name: str, fr) -> float:
    """Distance from an object's own origin DOWN to its lowest point in CURRENT world space -
    add this to a support surface's world Z to get the qpos Z that rests the object's bottom
    exactly on that surface. Same reasoning as `object_top_offset`; for a box/cylinder this
    equals the top offset (origin at the geometric center), but a mesh's authored origin need
    not be centered at all, so top and bottom offsets are computed independently."""
    if fr is not None and fr.shape in {"ssbox", "box"} and fr.size:
        return fr.size[2] / 2.0
    if fr is not None and fr.shape == "cylinder" and fr.size:
        return (fr.size[1] / 2.0) if len(fr.size) > 1 else 0.02
    corners = _mesh_world_corners(model, data, obj_name)
    if corners is not None:
        body_id = mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_BODY, obj_name)
        return float(data.xpos[body_id][2] - corners[:, 2].min())
    return 0.015


def object_body_id_group(model: mujoco.MjModel, scene, obj_name: str) -> set:
    """`obj_name`'s own body id plus any body whose PARENT (per the `.g` frame tree, not
    necessarily the MuJoCo body tree) is `obj_name` - i.e. its rigidly-fixed mesh children
    (Phase 2's proxy/mesh nesting). Collision checks must treat this whole group as "the
    object being carried," not just the proxy's own id, or contact on the object's real
    collision geometry (the mesh child) reads as "touching a different object.\""""
    ids = set()
    for name, fr in scene.frames.items():
        if name == obj_name or fr.parent == obj_name:
            bid = mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_BODY, name)
            if bid >= 0:
                ids.add(bid)
    return ids


def object_grip_half_width(model: mujoco.MjModel, data: mujoco.MjData, obj_name: str, fr) -> float:
    """How far each finger should travel in to close on `obj_name` - object's own half-width
    along its size[0]/X axis for box/cylinder, or half the mesh's smaller HORIZONTAL
    (world X/Y) world-space extent otherwise - the vertical extent isn't what the fingers
    close around, and per `_mesh_world_corners`, the local AABB's own axes aren't reliable."""
    if fr is not None and fr.shape in {"ssbox", "box", "cylinder"} and fr.size:
        return fr.size[0] / 2.0
    corners = _mesh_world_corners(model, data, obj_name)
    if corners is not None:
        half_x = float((corners[:, 0].max() - corners[:, 0].min()) / 2.0)
        half_y = float((corners[:, 1].max() - corners[:, 1].min()) / 2.0)
        return min(half_x, half_y)
    return 0.015


def resolve_support_pose(name: str, model: mujoco.MjModel, data: mujoco.MjData, scene) -> Tuple[np.ndarray, Optional[int]]:
    """Resolves one `to` reference from an action's terminal (`(on to1 [to2 ...] obj)`) to a
    world-space resting point, returning (top_surface_pos, body_id_to_exempt_from_collision).

    Three cases, all keyed off the *scene's* CURRENT live state, not its original scene-file
    layout - because by the time a later action reads `rectprism_1_Left`, `rectprism_1` may
    already have been relocated by an earlier action in this same trial:
      1. `name` is itself a movable object (stacking directly on another object's body):
         use that body's CURRENT xpos/xquat + its own half-height.
      2. `name` is a named marker/sub-frame whose immediate parent is a movable object (e.g.
         `rectprism_1_Left`, a designated slot on a specific face of `rectprism_1`): compose
         the parent's CURRENT live pose with the marker's STATIC local offset from the scene
         file (the offset itself never changes, only where the parent now is).
      3. `name` is a marker/slot whose parent is a fixed frame (`Table_Left` etc., parent is
         the table, which never moves): the static scene-file resolution is safe as-is.
    """
    body_id = mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_BODY, name)
    if body_id >= 0 and name in scene.object_names():
        fr = scene.frames.get(name)
        top = data.xpos[body_id].copy()
        top[2] += object_top_offset(model, data, name, fr)
        return top, body_id

    fr = scene.frames.get(name)
    if fr is None:
        raise KeyError(f"unresolvable placement target: {name!r} (not a body, not a known frame)")
    if fr.parent in scene.object_names():
        parent_body_id = mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_BODY, fr.parent)
        parent_pos, parent_quat = data.xpos[parent_body_id].copy(), data.xquat[parent_body_id].copy()
        mat = np.zeros(9)
        mujoco.mju_quat2Mat(mat, parent_quat)
        mat = mat.reshape(3, 3)
        world_pos = parent_pos + mat @ fr.T_local[:3, 3]
        return world_pos, parent_body_id

    pos, _ = scene.world_pose(name)
    return pos, None


def resolve_grasp_target_pos(obj_name: str, model: mujoco.MjModel, data: mujoco.MjData, scene) -> np.ndarray:
    """Position to approach when PICKING `obj_name`: its own body center, unless a child frame
    whose name contains "handle" exists, in which case that handle's CURRENT world position is
    used instead. Mirrors KOMO's own `action_pick` convention exactly (`manipTools.cpp`:
    `bodyF`'s children searched for a name containing "handle") - this is the FMB pin/peg
    pattern (`shape_4_1` proxy + `shape_4_1_mesh` collision child + `shape_4_1_handle` grasp
    marker, zero relative rotation to the proxy), documented as a hard requirement in
    `docs/ops/TESTING_SOP_2026-03-21.md`. Cube Stacking objects never have a handle child, so
    this is a no-op there - same function covers both benchmarks."""
    obj_body_id = mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_BODY, obj_name)
    obj_pos, obj_quat = data.xpos[obj_body_id].copy(), data.xquat[obj_body_id].copy()

    handle_name = None
    for name, fr in scene.frames.items():
        if fr.parent == obj_name and "handle" in name.lower():
            handle_name = name
            break
    if handle_name is None:
        return obj_pos

    fr = scene.frames[handle_name]
    mat = np.zeros(9)
    mujoco.mju_quat2Mat(mat, obj_quat)
    mat = mat.reshape(3, 3)
    return obj_pos + mat @ fr.T_local[:3, 3]


def _grasp_yaw_of_current_hand(hand_quat: np.ndarray) -> float:
    """Inverse of `grasp_quat_for_object_yaw`: what yaw value would reproduce the hand's
    current orientation, so a symmetry-equivalent target can be chosen close to it."""
    hand_mat = np.zeros(9)
    mujoco.mju_quat2Mat(hand_mat, hand_quat)
    hand_mat = hand_mat.reshape(3, 3)
    base_mat = np.zeros(9)
    mujoco.mju_quat2Mat(base_mat, _GRASP_APPROACH_QUAT)
    base_mat = base_mat.reshape(3, 3)
    rz = hand_mat @ base_mat.T  # base_mat is orthonormal: transpose = inverse
    return float(np.arctan2(rz[1, 0], rz[0, 0]))


class IKResult:
    def __init__(self, success: bool, iters: int, pos_err: float, rot_err: float):
        self.success = success
        self.iters = iters
        self.pos_err = pos_err
        self.rot_err = rot_err


def solve_ik(
    model: mujoco.MjModel,
    data: mujoco.MjData,
    site_id: int,
    target_pos: np.ndarray,
    target_quat: np.ndarray,
    arm_qpos_idx: List[int],
    arm_dof_idx: List[int],
    max_iters: int = 300,
    pos_tol: float = 2e-3,
    rot_tol: float = 2e-2,
    damping: float = 1e-2,
    step_scale: float = 0.5,
) -> IKResult:
    """Damped-least-squares IK on a *scratch* copy of qpos (does not touch actuation/physics;
    caller is responsible for feeding the solved qpos to the position actuators)."""
    nv = model.nv
    jacp = np.zeros((3, nv))
    jacr = np.zeros((3, nv))
    q_lo = model.jnt_range[[model.joint(j).id for j in [mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_JOINT, jn) for jn in _ARM_JOINTS]], 0]
    q_hi = model.jnt_range[[model.joint(j).id for j in [mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_JOINT, jn) for jn in _ARM_JOINTS]], 1]

    last_pos_err = last_rot_err = 1e9
    for it in range(max_iters):
        mujoco.mj_forward(model, data)
        cur_pos = data.site_xpos[site_id].copy()
        cur_mat = data.site_xmat[site_id].reshape(3, 3).copy()
        cur_quat = np.zeros(4)
        mujoco.mju_mat2Quat(cur_quat, cur_mat.flatten())

        pos_err_vec = target_pos - cur_pos
        cur_quat_inv = np.zeros(4)
        mujoco.mju_negQuat(cur_quat_inv, cur_quat)
        err_quat = np.zeros(4)
        mujoco.mju_mulQuat(err_quat, target_quat, cur_quat_inv)
        rot_err_vec = np.zeros(3)
        mujoco.mju_quat2Vel(rot_err_vec, err_quat, 1.0)

        last_pos_err = float(np.linalg.norm(pos_err_vec))
        last_rot_err = float(np.linalg.norm(rot_err_vec))
        if last_pos_err < pos_tol and last_rot_err < rot_tol:
            return IKResult(True, it, last_pos_err, last_rot_err)

        mujoco.mj_jacSite(model, data, jacp, jacr, site_id)
        J = np.vstack([jacp[:, arm_dof_idx], jacr[:, arm_dof_idx]])
        err = np.concatenate([pos_err_vec, rot_err_vec])
        JJt = J @ J.T + (damping**2) * np.eye(6)
        dq = J.T @ np.linalg.solve(JJt, err)
        dq = np.clip(dq, -0.2, 0.2)

        q = data.qpos[arm_qpos_idx] + step_scale * dq
        q = np.clip(q, q_lo, q_hi)
        data.qpos[arm_qpos_idx] = q

    return IKResult(False, max_iters, last_pos_err, last_rot_err)


# Collision-only geoms (the CoACD decomposition pieces backing a concave mesh - see
# `baseline_naive_interp_convert_g_to_mjcf._decomposed_pieces`) are tagged group=3 and are
# near-coincident with their sibling visual mesh, so rendering both together z-fights. All
# three render call sites below share this option to hide group 3 and show only the true mesh.
_RENDER_SCENE_OPTION = mujoco.MjvOption()
_RENDER_SCENE_OPTION.geomgroup[3] = 0


class VideoRecorder:
    """Samples frames from a fixed named camera every `stride` physics steps."""

    def __init__(self, model: mujoco.MjModel, camera: str = "front", width: int = 1280, height: int = 960, stride: int = 20):
        self.renderer = mujoco.Renderer(model, height=height, width=width)
        self.camera = camera
        self.stride = stride
        self._counter = 0
        self.frames: List[np.ndarray] = []

    def maybe_capture(self, data: mujoco.MjData, force: bool = False) -> None:
        self._counter += 1
        if not force and (self._counter % self.stride != 0):
            return
        self.renderer.update_scene(data, camera=self.camera, scene_option=_RENDER_SCENE_OPTION)
        self.frames.append(self.renderer.render().copy())

    def write(self, out_path: Path, fps: int = 30) -> Optional[Path]:
        if not self.frames:
            return None
        import imageio.v2 as imageio  # noqa: E402

        out_path.parent.mkdir(parents=True, exist_ok=True)
        imageio.mimwrite(out_path, self.frames, fps=fps, macro_block_size=None)
        return out_path


def render_three_view(model: mujoco.MjModel, data: mujoco.MjData, out_path: Path, width: int = 640, height: int = 480) -> Path:
    """Renders front/top/side cameras side by side into one image - used to capture the
    exact instant a collision is first detected, since a single camera angle can hide
    exactly which two bodies are touching."""
    import imageio.v2 as imageio  # noqa: E402

    renderer = mujoco.Renderer(model, height=height, width=width)
    panels = []
    for cam in ("front", "top", "side"):
        renderer.update_scene(data, camera=cam, scene_option=_RENDER_SCENE_OPTION)
        panels.append(renderer.render().copy())
    combined = np.concatenate(panels, axis=1)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    imageio.imwrite(out_path, combined)
    return out_path


def run_to_ctrl_target(
    model: mujoco.MjModel,
    data: mujoco.MjData,
    arm_actuator_idx: List[int],
    q_target: np.ndarray,
    n_steps: int = 400,
    attach: Optional[Tuple] = None,
    recorder: Optional[VideoRecorder] = None,
    finger_qpos_idx: Optional[List[int]] = None,
    finger_dof_idx: Optional[List[int]] = None,
    gripper_hold: Optional[float] = None,
    collision_monitor: Optional["CollisionMonitor"] = None,
) -> None:
    """Sets position-actuator setpoints and steps physics forward so the PD controllers
    actually carry the arm there (as opposed to teleporting qpos). If `attach` is given as
    (obj_qpos_adr, hand_body_id, obj_body_id, rel_pos, rel_quat), the object's freejoint qpos
    is re-pinned to hand_pose(t) ∘ rel_pose after every step (kinematic grasp), qvel zeroed.
    If `gripper_hold` is given, the finger joints are re-pinned to that opening every step -
    otherwise the untouched gripper actuator (ctrl=0) silently drags them closed over a few
    hundred steps, which is what caused the gripper to visibly drift instead of holding open/
    closed through the approach and transit phases."""
    data.ctrl[arm_actuator_idx] = q_target
    for _ in range(n_steps):
        mujoco.mj_step(model, data)
        needs_forward = False
        if attach is not None:
            obj_qpos_adr, hand_body_id, obj_body_id, rel_pos, rel_quat = attach
            hand_pos, hand_quat = _body_pose(data, hand_body_id)
            new_pos, new_quat = _compose(hand_pos, hand_quat, rel_pos, rel_quat)
            data.qpos[obj_qpos_adr : obj_qpos_adr + 3] = new_pos
            data.qpos[obj_qpos_adr + 3 : obj_qpos_adr + 7] = new_quat
            obj_dof_adr = model.body_dofadr[obj_body_id]
            data.qvel[obj_dof_adr : obj_dof_adr + 6] = 0.0
            needs_forward = True
        if gripper_hold is not None and finger_qpos_idx is not None:
            data.qpos[finger_qpos_idx] = gripper_hold
            if finger_dof_idx is not None:
                data.qvel[finger_dof_idx] = 0.0
            needs_forward = True
        if needs_forward:
            mujoco.mj_forward(model, data)
        if collision_monitor is not None:
            collision_monitor.check(data)
        if recorder is not None:
            recorder.maybe_capture(data)


class ArmHandles:
    def __init__(self, model: mujoco.MjModel):
        self.tcp_site_id = mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_SITE, "tcp")
        self.hand_body_id = mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_BODY, "hand")
        self.arm_qpos_idx = [model.jnt_qposadr[mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_JOINT, jn)] for jn in _ARM_JOINTS]
        self.arm_dof_idx = [model.jnt_dofadr[mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_JOINT, jn)] for jn in _ARM_JOINTS]
        self.arm_actuator_idx = [mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_ACTUATOR, f"act_{jn}") for jn in _ARM_JOINTS]
        self.finger_qpos_idx = [model.jnt_qposadr[mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_JOINT, jn)] for jn in _FINGER_JOINTS]
        self.finger_dof_idx = [model.jnt_dofadr[mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_JOINT, jn)] for jn in _FINGER_JOINTS]
        self.arm_body_ids = {
            mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_BODY, n)
            for n in ["panda_mount", "link0", "link1", "link2", "link3", "link4", "link5", "link6", "link7", "hand", "left_finger", "right_finger"]
        }
        self.table_body_id = mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_BODY, "table")


class CollisionMonitor:
    """Classifies every contact seen during an action against a small allow-list (resting on
    the table; the carried object touching the hand/fingers that are holding it; the carried
    object touching its own intended target support) - everything else is logged as an
    unintended collision. This is what actually determines whether a naive-interpolation
    action "succeeded": the arm doing no collision avoidance can still land an object near its
    target by getting lucky along the way, which the final-position error alone won't catch."""

    def __init__(
        self,
        model: mujoco.MjModel,
        handles: ArmHandles,
        all_obj_body_ids: set,
        obj_body_ids: set,
        to_body_ids: Optional[set],
        on_first_violation: Optional["Callable[[mujoco.MjData], None]"] = None,
    ):
        self.model = model
        self.handles = handles
        # `obj_body_ids` is the CARRIED object's own body PLUS any rigidly-fixed mesh children
        # (see the Phase 2 converter's proxy/mesh nesting) - without folding children in here,
        # contact on the object's own real collision geometry (the child mesh, not the small
        # logical proxy) would be misclassified as "touching some other object."
        self.other_obj_body_ids = all_obj_body_ids - obj_body_ids
        self.obj_body_ids = obj_body_ids
        self.to_body_ids = to_body_ids or set()
        self.violations: List[Dict] = []
        self.on_first_violation = on_first_violation
        self._fired = False

    def check(self, data: mujoco.MjData) -> None:
        for c in data.contact:
            b1 = int(self.model.geom_bodyid[c.geom1])
            b2 = int(self.model.geom_bodyid[c.geom2])
            if b1 == b2:
                continue
            pair = {b1, b2}
            if self.handles.table_body_id in pair:
                continue  # resting on / approaching over the table is expected
            if self.to_body_ids and (pair & self.to_body_ids) and (pair & self.obj_body_ids):
                continue  # the carried object reaching its own intended target support
            is_arm = {b1 in self.handles.arm_body_ids, b2 in self.handles.arm_body_ids}
            is_carried = {b1 in self.obj_body_ids, b2 in self.obj_body_ids}
            if any(is_arm) and any(is_carried):
                continue  # hand/fingers holding the object they're grasping
            is_other = {b1 in self.other_obj_body_ids, b2 in self.other_obj_body_ids}
            if any(is_carried) and any(is_other):
                self.violations.append({"kind": "carried_vs_other", "body1": b1, "body2": b2, "dist": float(c.dist)})
            elif any(is_arm) and (any(is_other) or any(is_carried)):
                self.violations.append({"kind": "arm_vs_object", "body1": b1, "body2": b2, "dist": float(c.dist)})
        if self.violations and not self._fired:
            self._fired = True
            if self.on_first_violation is not None:
                self.on_first_violation(data)


def move_gripper_in_place(
    model: mujoco.MjModel,
    data: mujoco.MjData,
    handles: "ArmHandles",
    target_opening: float,
    n_steps: int = 100,
    recorder: Optional["VideoRecorder"] = None,
    collision_monitor: Optional["CollisionMonitor"] = None,
) -> None:
    """Ramps the finger joints to `target_opening` (0=closed, 0.04=open) while holding the
    arm's current commanded qpos FIXED (no translation) - gripper state changes complete
    before any motion starts/resumes, matching real pick-place sequencing."""
    data.ctrl[handles.arm_actuator_idx] = data.qpos[handles.arm_qpos_idx].copy()  # freeze arm
    start_vals = data.qpos[handles.finger_qpos_idx].copy()
    for i in range(n_steps):
        frac = (i + 1) / n_steps
        data.qpos[handles.finger_qpos_idx] = start_vals + frac * (target_opening - start_vals)
        data.qvel[handles.finger_dof_idx] = 0.0
        mujoco.mj_forward(model, data)
        mujoco.mj_step(model, data)
        if collision_monitor is not None:
            collision_monitor.check(data)
        if recorder is not None:
            recorder.maybe_capture(data)


def run_one_action(
    model: mujoco.MjModel,
    data: mujoco.MjData,
    handles: ArmHandles,
    obj_name: str,
    grasp_target_pos: np.ndarray,
    place_target_pos: np.ndarray,
    recorder: Optional[VideoRecorder] = None,
    obj_grip_half_width: float = 0.015,
    symmetry_period: float = math.pi / 2,
    canonical_yaw_offset: float = 0.0,
    all_obj_body_ids: Optional[set] = None,
    to_body_ids: Optional[set] = None,
    obj_body_id_group: Optional[set] = None,
    collision_snapshot_path: Optional[Path] = None,
) -> Dict:
    """One full pick-place action (2x Eq.7 sub-motions) on an already-loaded model/data.
    Safe to call repeatedly on the same model/data to run a whole trial's action sequence
    in one continuous simulation (so later actions see earlier actions' real end state).
    `obj_grip_half_width` is how far each finger travels in to close (object's own half-width
    along the grip axis) - closing all the way to 0 drives the fingertips through the object
    instead of stopping at its surface. `symmetry_period` (pi/2 for a cube, pi for an oblong
    box, 2*pi/"no assumed symmetry" otherwise - see `object_symmetry_period`) picks the
    yaw-equivalent grasp/place target closest to the gripper's current orientation instead of
    the raw computed one, so reaching it never twists the wrist further than the object's own
    rotational symmetry allows for free."""
    obj_body_id = mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_BODY, obj_name)
    obj_joint_id = mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_JOINT, f"{obj_name}_freejoint")
    obj_qpos_adr = model.jnt_qposadr[obj_joint_id]

    def wrapped_grasp_quat(target_yaw: float) -> np.ndarray:
        """Yaw-equivalent (symmetry_period) target closest to the gripper's CURRENT
        orientation, so reaching it never twists the wrist further than necessary."""
        current_gripper_yaw = _grasp_yaw_of_current_hand(data.xquat[handles.hand_body_id].copy())
        k = round((current_gripper_yaw - target_yaw) / symmetry_period)
        return grasp_quat_for_object_yaw(target_yaw + k * symmetry_period)

    def wrap_hand_quat_to_nearest(quat: np.ndarray) -> np.ndarray:
        """Same idea as `wrapped_grasp_quat`, but for an already-built hand quat (from
        `hand_quat_for_target_object_quat`) rather than one built fresh from a yaw value."""
        quat_yaw = _grasp_yaw_of_current_hand(quat)
        current_gripper_yaw = _grasp_yaw_of_current_hand(data.xquat[handles.hand_body_id].copy())
        k = round((current_gripper_yaw - quat_yaw) / symmetry_period)
        return grasp_quat_for_object_yaw(quat_yaw + k * symmetry_period)

    # pick: align the gripper's finger-opening axis with the object's actual (possibly
    # rotated) CURRENT orientation, so fingers land flush on two faces, not a corner.
    obj_yaw = _yaw_from_quat_wxyz(data.xquat[obj_body_id].copy())
    pick_quat = wrapped_grasp_quat(obj_yaw)
    gripper_closed_target = float(np.clip(obj_grip_half_width, 0.0, _GRIPPER_OPEN))

    def on_first_violation(d: mujoco.MjData) -> None:
        if collision_snapshot_path is not None:
            try:
                render_three_view(model, d, collision_snapshot_path)
                log["collision_snapshot"] = str(collision_snapshot_path)
            except Exception as e:  # pragma: no cover - rendering is best-effort
                log["collision_snapshot_error"] = str(e)

    collision_monitor = CollisionMonitor(model, handles, all_obj_body_ids or set(), obj_body_id_group or {obj_body_id}, to_body_ids, on_first_violation=on_first_violation)

    log: Dict = {"obj": obj_name, "waypoints": [], "success": True, "failure_reason": None}
    attach_state: List = [None]
    # Gripper cycle (explicit, held every single physics step - not just during the ramps):
    # open -> approach (stays open) -> close in place -> transit+place (stays closed) ->
    # open in place -> STAYS OPEN through the next action's approach too, since the caller
    # starts each new action already holding _GRIPPER_OPEN.
    gripper_state: List[float] = [_GRIPPER_OPEN]

    def do_submotion(target_pos: np.ndarray, target_quat: np.ndarray, label: str) -> bool:
        start_pos = data.site_xpos[handles.tcp_site_id].copy()
        T = target_pos - start_pos

        res = solve_ik(model, data, handles.tcp_site_id, start_pos, target_quat, handles.arm_qpos_idx, handles.arm_dof_idx)
        run_to_ctrl_target(
            model, data, handles.arm_actuator_idx, data.qpos[handles.arm_qpos_idx].copy(),
            attach=attach_state[0], recorder=recorder,
            finger_qpos_idx=handles.finger_qpos_idx, finger_dof_idx=handles.finger_dof_idx, gripper_hold=gripper_state[0],
            collision_monitor=collision_monitor,
        )
        log["waypoints"].append({"label": f"{label}_reorient", "ik_converged": res.success, "pos_err": res.pos_err, "rot_err": res.rot_err})
        if not res.success:
            log["success"] = False
            log["failure_reason"] = f"ik_failure:{label}_reorient"
            return False

        for frac in _EQ7_FRACTIONS:
            wp_target = start_pos + frac * T
            res = solve_ik(model, data, handles.tcp_site_id, wp_target, target_quat, handles.arm_qpos_idx, handles.arm_dof_idx)
            q_target = data.qpos[handles.arm_qpos_idx].copy()
            run_to_ctrl_target(
                model, data, handles.arm_actuator_idx, q_target,
                attach=attach_state[0], recorder=recorder,
                finger_qpos_idx=handles.finger_qpos_idx, finger_dof_idx=handles.finger_dof_idx, gripper_hold=gripper_state[0],
                collision_monitor=collision_monitor,
            )
            actual_pos = data.site_xpos[handles.tcp_site_id].copy()
            settle_err = float(np.linalg.norm(actual_pos - wp_target))
            log["waypoints"].append(
                {
                    "label": f"{label}_{frac}",
                    "ik_converged": res.success,
                    "pos_err": res.pos_err,
                    "rot_err": res.rot_err,
                    "settle_err_after_physics": settle_err,
                }
            )
            if not res.success:
                log["success"] = False
                log["failure_reason"] = f"ik_failure:{label}_{frac}"
                return False
        return True

    def finish(place_err_pos: Optional[np.ndarray] = None) -> Dict:
        log["final_object_pos"] = data.xpos[obj_body_id].tolist()
        if place_err_pos is not None:
            log["final_place_error"] = float(np.linalg.norm(data.xpos[obj_body_id] - place_err_pos))
        log["violations"] = collision_monitor.violations
        log["collision_violation"] = len(collision_monitor.violations) > 0
        # a naive-interpolation action that hit something along the way did NOT succeed,
        # even if the object happened to end up near the target - that's the whole property
        # Track 2 is measuring, so it must gate success, not just be reported alongside it.
        if log["collision_violation"]:
            log["success"] = False
            log["failure_reason"] = log["failure_reason"] or "collision_violation"
        return log

    # gripper must be fully open BEFORE approaching, and the open/close transitions must
    # complete while the arm is stationary - not mid-translation.
    move_gripper_in_place(model, data, handles, _GRIPPER_OPEN, recorder=recorder, collision_monitor=collision_monitor)
    gripper_state[0] = _GRIPPER_OPEN

    if not do_submotion(grasp_target_pos, pick_quat, "pick"):
        return finish()

    # close gripper IN PLACE at the grasp point, THEN attach, THEN move away. Stops at the
    # object's own half-width instead of 0 so fingertips land on its surface, not through it.
    move_gripper_in_place(model, data, handles, gripper_closed_target, recorder=recorder, collision_monitor=collision_monitor)
    gripper_state[0] = gripper_closed_target
    hand_pos, hand_quat = _body_pose(data, handles.hand_body_id)
    obj_pos, obj_quat = _body_pose(data, obj_body_id)
    rel_pos, rel_quat = _relative_pose(hand_pos, hand_quat, obj_pos, obj_quat)
    attach_state[0] = (obj_qpos_adr, handles.hand_body_id, obj_body_id, rel_pos, rel_quat)

    # place: reset the OBJECT (not the hand) to its canonical "front-aligned" orientation -
    # this task's objects all share one reference orientation once placed, regardless of how
    # they were scattered/rotated beforehand. Resetting the hand to yaw=0 does NOT put the
    # object at yaw=0 unless the hand-to-object offset captured at grasp time (`rel_quat`)
    # happens to be identity, which was never guaranteed - that was the actual bug behind
    # rectangular objects landing rotated 90 deg from "long face forward". Solve for the hand
    # orientation that puts the object at its canonical yaw instead, via the inverse of
    # `rel_quat`. `canonical_yaw_offset` (0 for box/cylinder, confirmed correct on Cube
    # Stacking) exists because a mesh's own authored local axes aren't guaranteed to line up
    # with world identity the way a `.g` box's do - confirmed off by exactly 90 deg for FMB's
    # `shape_2_x` boards by direct visual check, not assumed.
    target_obj_quat = object_yaw_quat(canonical_yaw_offset)
    place_quat_exact = hand_quat_for_target_object_quat(target_obj_quat, rel_quat)
    place_quat = wrap_hand_quat_to_nearest(place_quat_exact)
    if not do_submotion(place_target_pos, place_quat, "place"):
        return finish()

    # open gripper IN PLACE at the place point (releasing the object under real physics as
    # it opens), then STAY OPEN - the caller's next action will re-open (no-op) before its
    # own approach, so the gripper remains open through this transit too.
    attach_state[0] = None
    move_gripper_in_place(model, data, handles, _GRIPPER_OPEN, recorder=recorder, collision_monitor=collision_monitor)
    gripper_state[0] = _GRIPPER_OPEN
    for _ in range(100):
        mujoco.mj_step(model, data)
        data.qpos[handles.finger_qpos_idx] = gripper_state[0]
        data.qvel[handles.finger_dof_idx] = 0.0
        mujoco.mj_forward(model, data)
        collision_monitor.check(data)
        if recorder is not None:
            recorder.maybe_capture(data)

    return finish(place_target_pos)


def return_to_home(
    model: mujoco.MjModel,
    data: mujoco.MjData,
    handles: ArmHandles,
    home_qpos: np.ndarray,
    recorder: Optional[VideoRecorder] = None,
) -> Dict:
    """Not part of Eq.7/the task itself - a convenience motion appended after the last action
    so a rendered trajectory always ends at a known, recognizable pose, making it obvious at a
    glance whether the preceding placement actually finished (vs. the arm just being frozen
    wherever the last waypoint left it). Reuses the same 4-step decelerating interpolation
    shape as Eq.7, but directly in joint space (straight to the known home qpos - no IK
    needed) since the target here is an exact joint configuration, not a Cartesian pose."""
    start_qpos = data.qpos[handles.arm_qpos_idx].copy()
    delta = home_qpos - start_qpos
    log: Dict = {"obj": "_return_home", "waypoints": []}
    for frac in _EQ7_FRACTIONS:
        q_target = start_qpos + frac * delta
        run_to_ctrl_target(
            model, data, handles.arm_actuator_idx, q_target,
            recorder=recorder, finger_qpos_idx=handles.finger_qpos_idx,
            finger_dof_idx=handles.finger_dof_idx, gripper_hold=_GRIPPER_OPEN,
        )
        log["waypoints"].append({"label": f"return_home_{frac}", "qpos_err": float(np.linalg.norm(data.qpos[handles.arm_qpos_idx] - q_target))})
    return log


def execute_pick_place(
    g_path: Path,
    obj_name: str,
    grasp_target_pos: np.ndarray,
    place_target_pos: np.ndarray,
    work_dir: Path,
    render_snapshot: bool = True,
    record_video: bool = False,
    camera: str = "front",
) -> Dict:
    """Single-action convenience wrapper (sets up a fresh model/data, runs one action)."""
    mjcf_path = work_dir / "scene.mjcf.xml"
    convert_g_to_mjcf(g_path, mjcf_path)

    model = mujoco.MjModel.from_xml_path(str(mjcf_path))
    data = mujoco.MjData(model)
    mujoco.mj_resetDataKeyframe(model, data, 0)
    mujoco.mj_forward(model, data)

    recorder = VideoRecorder(model, camera=camera) if record_video else None
    handles = ArmHandles(model)
    log = run_one_action(model, data, handles, obj_name, grasp_target_pos, place_target_pos, recorder=recorder)
    return _finalize(log, model, data, work_dir, render_snapshot, obj_name, place_target_pos, recorder=recorder)


def execute_trial(
    g_path: Path,
    action_sequence: List[Tuple[str, List[str]]],
    scene,
    work_dir: Path,
    render_snapshot: bool = True,
    record_video: bool = True,
    camera: str = "front",
) -> Dict:
    """Runs a whole trial's ordered action sequence [(obj, [to1, to2, ...]), ...] in ONE
    continuous simulation, so later actions see earlier actions' real, possibly-disturbed
    current poses rather than the original scene-file layout. `to` is usually a single
    reference (a named table slot, or another object) but can list 2+ supports for a
    bridging/spanning placement (`stableOnMulti`, e.g. a long block resting on two cubes)."""
    mjcf_path = work_dir / "scene.mjcf.xml"
    convert_g_to_mjcf(g_path, mjcf_path)

    model = mujoco.MjModel.from_xml_path(str(mjcf_path))
    data = mujoco.MjData(model)
    mujoco.mj_resetDataKeyframe(model, data, 0)
    mujoco.mj_forward(model, data)

    recorder = VideoRecorder(model, camera=camera) if record_video else None
    handles = ArmHandles(model)

    all_obj_body_ids = {mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_BODY, n) for n in scene.object_names()}
    action_logs: List[Dict] = []
    overall_success = True

    for action_idx, (obj_name, to_names) in enumerate(action_sequence):
        obj_body_id = mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_BODY, obj_name)
        obj_half_h = object_bottom_offset(model, data, obj_name, scene.frames.get(obj_name))
        grasp_target = resolve_grasp_target_pos(obj_name, model, data, scene)  # handle child if present, else own center
        grasp_target = grasp_target + np.array([0.0, 0.0, _grasp_height_offset_for(obj_name)])

        support_positions = []
        to_body_ids = set()
        for to_name in to_names:
            pos, exempt_id = resolve_support_pose(to_name, model, data, scene)
            support_positions.append(pos)
            if exempt_id is not None:
                to_body_ids.add(exempt_id)
        support_positions = np.array(support_positions)
        # bridging (2+ supports): centered in xy over all supports, resting on the tallest
        # one's surface (if they're not exactly level, this still lands close since the
        # spanning object's own contact will settle it - not a physics fudge, matches how a
        # rigid span actually rests on two not-quite-equal-height supports in reality).
        #
        # _RELEASE_CLEARANCE_M: the height fix (world-space mesh AABB, see object_top_offset)
        # computes the true flush-contact height correctly now (confirmed: FMB shape_2_1's
        # placement error dropped from 7cm to 1.4cm) - but commanding an EXACT flush height
        # leaves ~zero contact margin, and the small residual IK/settle error (a couple mm)
        # was enough for the solver to see interpenetration and fire a large corrective
        # impulse, launching the object away. Releasing from a small clearance above the
        # true surface instead - falling those few mm under gravity - avoids that without
        # giving up the accurate height (unlike reverting to the old, wrong ~7cm-high drop).
        place_target = np.array(
            [support_positions[:, 0].mean(), support_positions[:, 1].mean(), support_positions[:, 2].max() + obj_half_h + _RELEASE_CLEARANCE_M]
        )

        obj_grip_half_width = object_grip_half_width(model, data, obj_name, scene.frames.get(obj_name))
        symmetry_period = object_symmetry_period(scene.frames.get(obj_name))
        canonical_yaw_offset = object_canonical_yaw_offset(scene.frames.get(obj_name))
        obj_body_id_group = object_body_id_group(model, scene, obj_name)
        snapshot_path = work_dir / f"collision_{action_idx:02d}_{obj_name}.png"
        log = run_one_action(
            model, data, handles, obj_name, grasp_target, place_target,
            recorder=recorder, obj_grip_half_width=obj_grip_half_width, symmetry_period=symmetry_period,
            canonical_yaw_offset=canonical_yaw_offset,
            all_obj_body_ids=all_obj_body_ids, to_body_ids=to_body_ids, obj_body_id_group=obj_body_id_group,
            collision_snapshot_path=snapshot_path,
        )
        log["to"] = to_names
        action_logs.append(log)
        if not log["success"]:
            overall_success = False
        # deliberately NOT stopping on failure/collision: run the whole action sequence to
        # completion regardless, so a mid-trial collision doesn't hide what would have
        # happened to the rest of the objects - this is what "did the naive baseline finish
        # this trial cleanly" actually needs to look at.

    # cosmetic/diagnostic only, not part of Eq.7 or the scored task: return the arm to its
    # starting joint configuration so the recording ends somewhere recognizable.
    home_qpos = np.array([scene.panda_home_q.get(f"l_{jn}", 0.0) for jn in _ARM_JOINTS])
    return_log = return_to_home(model, data, handles, home_qpos, recorder=recorder)

    result = _finalize(
        {"actions": action_logs, "return_home": return_log, "success": overall_success},
        model, data, work_dir, render_snapshot, action_sequence[-1][0] if action_sequence else "", recorder=recorder,
    )
    return result


def _finalize(log, model, data, work_dir, render_snapshot, obj_name, place_target_pos: Optional[np.ndarray] = None, recorder: Optional[VideoRecorder] = None) -> Dict:
    obj_body_id = mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_BODY, obj_name)
    log["final_object_pos"] = data.xpos[obj_body_id].tolist()
    if place_target_pos is not None:
        log["final_place_error"] = float(np.linalg.norm(data.xpos[obj_body_id] - place_target_pos))
    if render_snapshot:
        try:
            snap_renderer = mujoco.Renderer(model, height=960, width=1280)
            snap_renderer.update_scene(data, camera="front", scene_option=_RENDER_SCENE_OPTION)
            img = snap_renderer.render()
            import imageio.v2 as imageio  # noqa: E402

            out_png = work_dir / "final_state.png"
            imageio.imwrite(out_png, img)
            log["snapshot"] = str(out_png)
        except Exception as e:  # pragma: no cover - rendering is best-effort
            log["snapshot_error"] = str(e)
    if recorder is not None:
        recorder.maybe_capture(data, force=True)  # always end on the true final frame
        try:
            out_mp4 = work_dir / "trajectory.mp4"
            written = recorder.write(out_mp4)
            log["video"] = str(written) if written else None
        except Exception as e:  # pragma: no cover - video encoding is best-effort
            log["video_error"] = str(e)
    return log


if __name__ == "__main__":
    from experiments.scripts.baseline_naive_interp_task_assignment import (  # noqa: E402
        _extract_final_json_from_md,
        _extract_gt_trial,
        extract_action_sequence,
    )

    mag, s_idx, t_idx, mode = "4cubes", 1, 1, "nr"
    case_name = f"cube_n{int(mag.replace('cubes','')):02d}_s{s_idx:02d}"
    s_folder = f"s{s_idx:02d}"
    scene_g = ROOT_DIR / "experiments" / "scenes" / mag / s_folder / "random_trials" / f"trial_{t_idx:02d}_{mode}.g"

    acc_report = ROOT_DIR / "experiments" / "outputs" / "gemini_proposed_method" / "accuracy_analysis" / "cubeStacking" / mag / "accuracy_report.md"
    gt_trial_num = _extract_gt_trial(acc_report, case_name)
    vlm_md = ROOT_DIR / "experiments" / "evaluations" / "VLM" / "gemini_proposed_method" / "cubeStacking" / mag / case_name / f"trial_{gt_trial_num}.md"
    phase1_json = _extract_final_json_from_md(vlm_md)

    ta_work_dir = ROOT_DIR / "experiments" / "evaluations" / "Baseline_execution" / "_phase3_validation" / case_name / mode / f"trial_{t_idx:02d}" / "task_assignment"
    sequence, scene_named_path = extract_action_sequence(scene_g, phase1_json, ta_work_dir)
    print(f"full action sequence ({len(sequence)} actions): {sequence}")

    scene = parse_scene(scene_named_path)
    exec_work_dir = ROOT_DIR / "experiments" / "evaluations" / "Baseline_execution" / "_phase3_validation" / case_name / mode / f"trial_{t_idx:02d}" / "exec_full_trial"
    result = execute_trial(scene_named_path, sequence, scene, exec_work_dir, record_video=True)

    import json

    print(json.dumps(result, indent=2))
    n_actions = len(result["actions"])
    n_ok = sum(1 for a in result["actions"] if a["success"])
    print(f"\n{n_ok}/{n_actions} actions completed; overall success={result['success']}")
    for a in result["actions"]:
        err = a.get("final_place_error")
        n_viol = len(a.get("violations", []))
        print(f"  {a['obj']}: success={a['success']} final_place_error={err if err is None else round(err,4)} collision_violation={a.get('collision_violation')} (n={n_viol}) reason={a.get('failure_reason')}")
        if a.get("collision_snapshot"):
            print(f"      collision_snapshot: {a['collision_snapshot']}")
        for v in a.get("violations", [])[:5]:
            print(f"      {v}")
    if result["success"]:
        print("\nPhase 3 FULL-TRIAL check PASSED: all actions in the sequence completed.")
    else:
        print("\nPhase 3 FULL-TRIAL check FAILED partway through the sequence.")
