#!/usr/bin/env python3
"""
Pure-math static collision snapshot (no simulator, no KOMO, no source changes).

Given a scene .g and a reachability score report, pick one infeasible target and:
1) reconstruct a Franka kinematic chain from provided joint angles,
2) build per-link box collision volumes,
3) test overlap vs obstacle boxes (AABB conservative test),
4) render XY / XZ / YZ 3-view figure.
"""

from __future__ import annotations

import argparse
import json
import math
import re
from pathlib import Path
from typing import Dict, List, Tuple

import matplotlib.pyplot as plt
import numpy as np

_NAME_PARENT_PATTERN = re.compile(r"^\s*([A-Za-z_][\w]*)\s*\(([^)]*)\)")
_T_PATTERN = re.compile(r"t\(([^)]+)\)")
_SIZE_PATTERN = re.compile(r"size\s*:\s*\[([^\]]+)\]", re.IGNORECASE)
_SHAPE_PATTERN = re.compile(r"shape\s*:\s*([A-Za-z_][\w]*)", re.IGNORECASE)


def _parse_float_list(raw: str) -> List[float]:
    return [float(x) for x in raw.replace(",", " ").split() if x]


def _parse_scene_frames(scene_path: Path) -> Dict[str, Dict]:
    frames: Dict[str, Dict] = {}
    for raw in scene_path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#"):
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
        t = None
        tm = _T_PATTERN.search(body)
        if tm:
            nums = _parse_float_list(tm.group(1))
            if len(nums) >= 3:
                t = np.array(nums[:3], dtype=float)
        shape = ""
        sm = _SHAPE_PATTERN.search(body)
        if sm:
            shape = sm.group(1).lower()
        size = []
        szm = _SIZE_PATTERN.search(body)
        if szm:
            size = _parse_float_list(szm.group(1))
        frames[name] = {
            "parent": parent,
            "t": t,
            "shape": shape,
            "size": size,
        }
    return frames


def _world_pos(name: str, frames: Dict[str, Dict], memo: Dict[str, np.ndarray]) -> np.ndarray:
    if name in memo:
        return memo[name]
    fr = frames.get(name)
    if fr is None:
        p = np.zeros(3)
        memo[name] = p
        return p
    local = fr["t"] if fr.get("t") is not None else np.zeros(3)
    parent = fr.get("parent", "")
    if not parent or parent in {"world", "False"}:
        memo[name] = local
        return local
    p = _world_pos(parent, frames, memo) + local
    memo[name] = p
    return p


def _pick_infeasible_row(score_report: Dict, preferred_logical_id: str | None) -> Dict:
    rows = score_report.get("objects", [])
    if preferred_logical_id:
        for r in rows:
            if r.get("logical_id") == preferred_logical_id:
                return r
        raise ValueError(f"logical_id not found in report: {preferred_logical_id}")
    for r in rows:
        if r.get("decision") == "infeasible":
            return r
    if not rows:
        raise ValueError("score report has no objects")
    return rows[0]


def _dh(a: float, alpha: float, d: float, theta: float) -> np.ndarray:
    ct, st = math.cos(theta), math.sin(theta)
    ca, sa = math.cos(alpha), math.sin(alpha)
    return np.array(
        [
            [ct, -st * ca, st * sa, a * ct],
            [st, ct * ca, -ct * sa, a * st],
            [0.0, sa, ca, d],
            [0.0, 0.0, 0.0, 1.0],
        ],
        dtype=float,
    )


def franka_joint_positions(base_xyz: np.ndarray, q: np.ndarray) -> np.ndarray:
    """Approximate Panda FK with common DH parameters.
    Returns 9 points: base + 7 joints + hand.
    """
    if q.shape != (7,):
        raise ValueError("Expected 7 joint angles")

    a = [0.0, 0.0, 0.0, 0.0825, -0.0825, 0.0, 0.088, 0.0]
    alpha = [0.0, -math.pi / 2, math.pi / 2, math.pi / 2, -math.pi / 2, math.pi / 2, math.pi / 2, 0.0]
    d = [0.333, 0.0, 0.316, 0.0, 0.384, 0.0, 0.0, 0.107]
    theta = [q[0], q[1], q[2], q[3], q[4], q[5], q[6], 0.0]

    T = np.eye(4)
    T[:3, 3] = base_xyz
    pts = [T[:3, 3].copy()]

    for i in range(8):
        T = T @ _dh(a[i], alpha[i], d[i], theta[i])
        pts.append(T[:3, 3].copy())

    return np.asarray(pts)


def _segment_box_corners(p0: np.ndarray, p1: np.ndarray, half_w: float = 0.035) -> np.ndarray:
    v = p1 - p0
    L = np.linalg.norm(v)
    if L < 1e-8:
        v = np.array([1.0, 0.0, 0.0])
        L = 1.0
    ex = v / L

    up = np.array([0.0, 0.0, 1.0])
    if abs(np.dot(ex, up)) > 0.95:
        up = np.array([0.0, 1.0, 0.0])
    ey = np.cross(up, ex)
    ey /= np.linalg.norm(ey)
    ez = np.cross(ex, ey)
    ez /= np.linalg.norm(ez)

    c = 0.5 * (p0 + p1)
    hx, hy, hz = 0.5 * L, half_w, half_w

    corners = []
    for sx in (-1, 1):
        for sy in (-1, 1):
            for sz in (-1, 1):
                corners.append(c + sx * hx * ex + sy * hy * ey + sz * hz * ez)
    return np.asarray(corners)


def _aabb_from_corners(corners: np.ndarray) -> Tuple[np.ndarray, np.ndarray]:
    return np.min(corners, axis=0), np.max(corners, axis=0)


def _aabb_overlap(a_min: np.ndarray, a_max: np.ndarray, b_min: np.ndarray, b_max: np.ndarray) -> bool:
    return bool(np.all(a_min <= b_max) and np.all(b_min <= a_max))


def _extract_obstacle_boxes(frames: Dict[str, Dict], memo: Dict[str, np.ndarray]) -> List[Dict]:
    out = []
    for name, fr in frames.items():
        lname = name.lower()
        if "obstacle" not in lname:
            continue
        shape = fr.get("shape", "")
        size = fr.get("size", [])
        if shape not in {"ssbox", "box"} or len(size) < 3:
            continue
        c = _world_pos(name, frames, memo)
        he = 0.5 * np.array(size[:3], dtype=float)
        out.append({"name": name, "center": c, "half_ext": he})
    return out


def _draw_proj_box(ax, c, he, dims=(0, 1), color="k", lw=1.2, alpha=1.0, ls="-"):
    i, j = dims
    x0, x1 = c[i] - he[i], c[i] + he[i]
    y0, y1 = c[j] - he[j], c[j] + he[j]
    xs = [x0, x1, x1, x0, x0]
    ys = [y0, y0, y1, y1, y0]
    ax.plot(xs, ys, color=color, lw=lw, alpha=alpha, ls=ls)


def main():
    parser = argparse.ArgumentParser(description="Visualize one static collision snapshot (XY/XZ/YZ)")
    parser.add_argument("--scene", required=True, help="Path to scene .g")
    parser.add_argument("--score-report", required=True, help="Reachability score report json")
    parser.add_argument("--logical-id", default="", help="Optional logical id; default picks first infeasible")
    parser.add_argument("--q", default="0,-1.5,0,-2.5,0,1.5,0", help="7 joint values in rad")
    parser.add_argument("--base", default="0,-0.3,0.65", help="Base xyz")
    parser.add_argument("--out", default="generated/static_collision_3views.png")
    args = parser.parse_args()

    scene_path = Path(args.scene)
    score_path = Path(args.score_report)

    frames = _parse_scene_frames(scene_path)
    memo: Dict[str, np.ndarray] = {}

    report = json.loads(score_path.read_text(encoding="utf-8"))
    row = _pick_infeasible_row(report, args.logical_id.strip() or None)

    anon_id = row.get("anon_id")
    logical_id = row.get("logical_id", "unknown")
    if not anon_id:
        raise ValueError("Selected row has no anon_id")

    target = _world_pos(anon_id, frames, memo)
    obstacles = _extract_obstacle_boxes(frames, memo)

    q = np.array(_parse_float_list(args.q), dtype=float)
    base_xyz = np.array(_parse_float_list(args.base), dtype=float)
    pts = franka_joint_positions(base_xyz, q)

    link_boxes = []
    any_collision = False
    for i in range(len(pts) - 1):
        corners = _segment_box_corners(pts[i], pts[i + 1], half_w=0.035)
        bmin, bmax = _aabb_from_corners(corners)
        collided = False
        for obs in obstacles:
            omin = obs["center"] - obs["half_ext"]
            omax = obs["center"] + obs["half_ext"]
            if _aabb_overlap(bmin, bmax, omin, omax):
                collided = True
                any_collision = True
                break
        link_boxes.append({"bmin": bmin, "bmax": bmax, "collided": collided})

    fig, axs = plt.subplots(1, 3, figsize=(16, 5))
    views = [((0, 1), "XY"), ((0, 2), "XZ"), ((1, 2), "YZ")]

    for ax, (dims, title) in zip(axs, views):
        i, j = dims

        # obstacles
        for obs in obstacles:
            _draw_proj_box(ax, obs["center"], obs["half_ext"], dims=dims, color="#6e6e6e", lw=2.0)
            ax.text(obs["center"][i], obs["center"][j], obs["name"], fontsize=8)

        # links and joints
        ax.plot(pts[:, i], pts[:, j], "-o", color="#1f77b4", lw=2.0, ms=4)
        for bi in link_boxes:
            c = 0.5 * (bi["bmin"] + bi["bmax"])
            he = 0.5 * (bi["bmax"] - bi["bmin"])
            clr = "#d62728" if bi["collided"] else "#2ca02c"
            _draw_proj_box(ax, c, he, dims=dims, color=clr, lw=1.2, alpha=0.95)

        # target
        ax.scatter([target[i]], [target[j]], marker="*", s=180, color="#ff7f0e")
        ax.text(target[i], target[j], f"target:{logical_id}", fontsize=8)

        ax.set_title(f"{title} view")
        ax.set_xlabel(["x", "y", "z"][i])
        ax.set_ylabel(["x", "y", "z"][j])
        ax.grid(True, alpha=0.3)
        ax.set_aspect("equal", adjustable="box")

    fig.suptitle(
        f"Static collision snapshot | logical_id={logical_id} anon_id={anon_id} | any_collision={any_collision}",
        fontsize=11,
    )
    fig.tight_layout()

    out = Path(args.out)
    out.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(out, dpi=180)

    print("[SNAPSHOT]")
    print(f"scene={scene_path}")
    print(f"score_report={score_path}")
    print(f"selected logical_id={logical_id}, anon_id={anon_id}")
    print(f"obstacles={len(obstacles)}")
    print(f"any_collision={any_collision}")
    print(f"saved={out}")


if __name__ == "__main__":
    main()
