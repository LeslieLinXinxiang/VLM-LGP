#!/usr/bin/env python3
"""
Track 2 (VLM-MSGraph naive-interpolation baseline) — Phase 1.1: pure-math `.g` scene parser.

No RAI, no KOMO, no solver. Given a scene `.g` file (the same files our own LGP/KOMO
pipeline consumes), resolves the world-space pose of every top-level frame (table,
named place slots `Table_Left/Center/Right/Back`, `Base_Front`, and object frames
`obj_NN` / `shape_N_M`) by composing `t()`/`d()` transforms along the parent chain.

Deliberately reuses the already-tested transform primitives from
`test/manipulability/urdf_static_manipulability.py` (`_parse_q_expr`, `_axis_angle_to_rot`,
`_make_transform`, `parse_initial_q_from_g`) instead of re-deriving rotation composition —
that module already resolves `.g` poses correctly for the reachability/manipulability
pipeline, so this parser only adds what it doesn't do: a general named-frame graph
(not just `obj_*` positions) with full orientation, shape, size and logical tags.
"""
from __future__ import annotations

import re
import sys
from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, List, Optional

import numpy as np

ROOT_DIR = Path(__file__).resolve().parents[2]
MANIP_DIR = ROOT_DIR / "test" / "manipulability"
if str(MANIP_DIR) not in sys.path:
    sys.path.insert(0, str(MANIP_DIR))

from urdf_static_manipulability import (  # noqa: E402
    _parse_q_expr,
    parse_initial_q_from_g,
)

_NAME_PARENT_PATTERN = re.compile(r"^\s*([A-Za-z_][\w]*)\s*\(([^)]*)\)")
_Q_PATTERN = re.compile(r'Q\s*:\s*"([^"]+)"', re.IGNORECASE)
_SHAPE_PATTERN = re.compile(r"shape\s*:\s*([A-Za-z_][\w]*)", re.IGNORECASE)
_SIZE_PATTERN = re.compile(r"size\s*:\s*\[([^\]]+)\]", re.IGNORECASE)
_LOGICAL_PATTERN = re.compile(r"logical\s*:\s*\{([^}]*)\}", re.IGNORECASE)
_MASS_PATTERN = re.compile(r"mass\s*:\s*([\d.eE+-]+)", re.IGNORECASE)
_MESH_PATTERN = re.compile(r'mesh\s*:\s*"([^"]+)"', re.IGNORECASE)
_CONTACT_PATTERN = re.compile(r"contact\s*:\s*(-?\d+)", re.IGNORECASE)
_JOINT_PATTERN = re.compile(r"joint\s*:\s*([A-Za-z_][\w]*)", re.IGNORECASE)
# NB: parse_initial_q_from_g() prepends "l_" itself, so pass UNPREFIXED joint names.
_PANDA_JOINT_NAMES = [f"panda_joint{i}" for i in range(1, 8)] + [
    "panda_finger_joint1",
    "panda_finger_joint2",
]


@dataclass
class SceneFrame:
    name: str
    parent: str
    T_local: np.ndarray  # 4x4, identity if no Q given
    shape: str = ""
    size: List[float] = field(default_factory=list)
    logical: List[str] = field(default_factory=list)
    mass: Optional[float] = None
    mesh_path: str = ""
    contact: Optional[int] = None
    joint: str = ""


@dataclass
class ParsedScene:
    path: Path
    frames: Dict[str, SceneFrame]
    panda_base_parent: str
    panda_home_q: Dict[str, float]

    def world_transform(self, name: str, _memo: Optional[Dict[str, np.ndarray]] = None) -> np.ndarray:
        """4x4 homogeneous world transform for a named frame (identity if unknown/root)."""
        memo = _memo if _memo is not None else {}
        if name in memo:
            return memo[name]
        fr = self.frames.get(name)
        if fr is None:
            T = np.eye(4)
            memo[name] = T
            return T
        parent = fr.parent
        if not parent or parent in {"world", "False"}:
            T = fr.T_local
        else:
            if parent not in self.frames:
                # A missing parent used to silently fall back to an identity transform here,
                # which masked a real bug (execute_phase0()'s renaming/reordering step can emit
                # a genuine DUPLICATE frame name for some FMB scenes - the dict-building loop in
                # parse_scene() then lets the second `frames[name] = ...` silently overwrite the
                # first, leaving any frame that pointed at the overwritten one as a "parent" with
                # nothing to resolve). Silently defaulting to identity teleported the orphaned
                # child to near the world origin instead - a wildly wrong but not-obviously-wrong
                # position, which produced a confusing cascade of "genuine-looking" collision
                # violations that took real diagnosis effort to trace back to a parse-time data
                # problem rather than a physics/geometry one. Fail loudly instead.
                raise KeyError(
                    f"frame {name!r} references parent {parent!r}, which is not a known frame "
                    f"(likely a duplicate/collided name from execute_phase0's renaming step - "
                    f"check the source .g file for a repeated block name)"
                )
            T = self.world_transform(parent, memo) @ fr.T_local
        memo[name] = T
        return T

    def world_pose(self, name: str) -> "tuple[np.ndarray, np.ndarray]":
        """Returns (xyz[3], R[3x3]) in world coordinates."""
        T = self.world_transform(name)
        return T[:3, 3].copy(), T[:3, :3].copy()

    def object_names(self) -> List[str]:
        return sorted(
            n for n, fr in self.frames.items() if "is_object" in fr.logical
        )

    def place_slot_names(self) -> List[str]:
        return sorted(
            n
            for n, fr in self.frames.items()
            if "is_place" in fr.logical and "is_object" not in fr.logical and n != "table"
        )


def _parse_float_list(raw: str) -> List[float]:
    return [float(x) for x in raw.replace(",", " ").split() if x]


def parse_scene(g_path: str | Path) -> ParsedScene:
    g_path = Path(g_path)
    text = g_path.read_text(encoding="utf-8")

    frames: Dict[str, SceneFrame] = {"world": SceneFrame("world", "", np.eye(4))}
    panda_base_parent = "table"

    for raw in text.splitlines():
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        if line.startswith("Include:") or line.startswith("Prefix:"):
            continue
        if line.startswith("Edit "):
            m = re.match(r"Edit\s+l_panda_base\s*\(([^)]*)\)", line)
            if m:
                panda_base_parent = m.group(1).strip()
                qm = _Q_PATTERN.search(line)
                T_local = _parse_q_expr(qm.group(1)) if qm else np.eye(4)
                frames["l_panda_base"] = SceneFrame("l_panda_base", panda_base_parent, T_local)
            continue

        lbrace = line.find("{")
        rbrace = line.rfind("}")
        if lbrace < 0 or rbrace <= lbrace:
            continue
        header = line[:lbrace].strip()
        body = line[lbrace + 1 : rbrace]
        m = _NAME_PARENT_PATTERN.match(header)
        if not m:
            continue
        name = m.group(1)
        parent = m.group(2).strip()

        qm = _Q_PATTERN.search(body)
        T_local = _parse_q_expr(qm.group(1)) if qm else np.eye(4)

        shape = ""
        sm = _SHAPE_PATTERN.search(body)
        if sm:
            shape = sm.group(1).lower()

        size: List[float] = []
        szm = _SIZE_PATTERN.search(body)
        if szm:
            size = _parse_float_list(szm.group(1))

        logical: List[str] = []
        lgm = _LOGICAL_PATTERN.search(body)
        if lgm:
            # tags appear either bare ("is_place") or with an explicit value
            # ("is_place:True") - normalize both to the bare tag name.
            logical = [tok.strip().split(":")[0].strip() for tok in lgm.group(1).split(",") if tok.strip()]

        mass = None
        mm = _MASS_PATTERN.search(body)
        if mm:
            mass = float(mm.group(1))

        mesh_path = ""
        mshm = _MESH_PATTERN.search(body)
        if mshm:
            mesh_path = mshm.group(1)

        contact = None
        ctm = _CONTACT_PATTERN.search(body)
        if ctm:
            contact = int(ctm.group(1))

        joint = ""
        jtm = _JOINT_PATTERN.search(body)
        if jtm:
            joint = jtm.group(1).lower()

        frames[name] = SceneFrame(name, parent, T_local, shape, size, logical, mass, mesh_path, contact, joint)

    home_q: Dict[str, float] = {}
    try:
        q_arr = parse_initial_q_from_g(str(g_path), _PANDA_JOINT_NAMES)
        home_q = {f"l_{jn}": float(v) for jn, v in zip(_PANDA_JOINT_NAMES, q_arr)}
    except Exception:
        home_q = {}

    return ParsedScene(path=g_path, frames=frames, panda_base_parent=panda_base_parent, panda_home_q=home_q)


def _self_check(g_path: Path) -> None:
    """Cross-checks object world positions against the independent
    `urdf_static_manipulability.parse_scene_positions` implementation."""
    from urdf_static_manipulability import parse_scene_positions

    scene = parse_scene(g_path)
    _, ref_objs = parse_scene_positions(str(g_path))

    print(f"\n=== {g_path} ===")
    print(f"objects: {scene.object_names()}")
    print(f"place slots: {scene.place_slot_names()}")
    print(f"home q: {scene.panda_home_q}")

    max_err = 0.0
    for oid, ref_pos in ref_objs.items():
        pos, _ = scene.world_pose(oid)
        err = float(np.linalg.norm(pos - ref_pos))
        max_err = max(max_err, err)
        status = "OK" if err < 1e-6 else "MISMATCH"
        print(f"  {oid}: mine={pos.round(4)} ref={ref_pos.round(4)} err={err:.2e} [{status}]")

    for slot in scene.place_slot_names():
        pos, _ = scene.world_pose(slot)
        print(f"  {slot} (world): {pos.round(4)}")

    assert max_err < 1e-6, f"position mismatch vs reference parser, max_err={max_err}"

    # FMB objects (shape_N_M) aren't covered by parse_scene_positions' obj_* regex,
    # so hand-verify at least one against its raw Q string's t() translation.
    hand_checks = {
        "shape_2_1": np.array([-0.1730, 0.3808, 0.663]),  # table world z=0.6 + t()'s 0.063
    }
    for name, expected in hand_checks.items():
        if name not in scene.frames:
            continue
        pos, _ = scene.world_pose(name)
        err = float(np.linalg.norm(pos - expected))
        status = "OK" if err < 1e-6 else "MISMATCH"
        print(f"  [hand-check] {name}: mine={pos.round(4)} expected={expected.round(4)} err={err:.2e} [{status}]")
        assert err < 1e-6, f"hand-check failed for {name}: {pos} vs {expected}"

    print("self-check PASSED (matches parse_scene_positions reference + hand-computed FMB check)")


if __name__ == "__main__":
    targets = sys.argv[1:] or [
        "experiments/scenes/4cubes/s01/random_trials/trial_01_nr.g",
        "experiments/scenes/8cubes/s05/random_trials/trial_10_r.g",
        "experiments/scenes/fmb/3objs/s001/random_trials/trial_01_nr.g",
    ]
    for t in targets:
        _self_check(ROOT_DIR / t)
