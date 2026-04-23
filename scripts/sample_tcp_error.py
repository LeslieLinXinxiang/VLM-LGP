#!/usr/bin/env python3
import argparse
import json
import math
import re
import xml.etree.ElementTree as ET
from pathlib import Path

import numpy as np


ORIGIN_RE = re.compile(r"^\s*panda_joint([1-7])_origin\s*\([^)]*\)\s*:\s*\{\s*pose:\s*\[([^\]]+)\]")
GRIPPER_RE = re.compile(r"\bgripper\b\([^)]*\)\s*:\s*\{[^\n]*Q:\s*\"([^\"]+)\"")
TOKEN_RE = re.compile(r"(t|d)\(([^)]+)\)")


def _vec(text: str):
    return np.array([float(x) for x in text.replace(",", " ").split()], dtype=float)


def _quat_to_rot_wxyz(q):
    q = np.array(q, dtype=float)
    n = np.linalg.norm(q)
    if n < 1e-12:
        return np.eye(3)
    q = q / n
    w, x, y, z = q
    return np.array(
        [
            [1 - 2 * (y * y + z * z), 2 * (x * y - z * w), 2 * (x * z + y * w)],
            [2 * (x * y + z * w), 1 - 2 * (x * x + z * z), 2 * (y * z - x * w)],
            [2 * (x * z - y * w), 2 * (y * z + x * w), 1 - 2 * (x * x + y * y)],
        ],
        dtype=float,
    )


def _axis_angle_deg_to_rot(axis, deg):
    axis = np.array(axis, dtype=float)
    n = np.linalg.norm(axis)
    if n < 1e-12:
        return np.eye(3)
    axis = axis / n
    th = math.radians(float(deg))
    x, y, z = axis
    c = math.cos(th)
    s = math.sin(th)
    C = 1 - c
    return np.array(
        [
            [c + x * x * C, x * y * C - z * s, x * z * C + y * s],
            [y * x * C + z * s, c + y * y * C, y * z * C - x * s],
            [z * x * C - y * s, z * y * C + x * s, c + z * z * C],
        ],
        dtype=float,
    )


def _rotz(theta):
    c = math.cos(float(theta))
    s = math.sin(float(theta))
    return np.array([[c, -s, 0], [s, c, 0], [0, 0, 1]], dtype=float)


def _T(R=None, t=None):
    out = np.eye(4)
    out[:3, :3] = np.eye(3) if R is None else np.array(R, dtype=float)
    out[:3, 3] = np.zeros(3) if t is None else np.array(t, dtype=float)
    return out


def _apply(T, p):
    p4 = np.array([p[0], p[1], p[2], 1.0], dtype=float)
    return (T @ p4)[:3]


def _parse_pose_array(raw: str):
    vals = _vec(raw)
    if len(vals) == 3:
        return _T(t=vals)
    if len(vals) == 4:
        return _T(R=_quat_to_rot_wxyz(vals))
    if len(vals) == 7:
        return _T(R=_quat_to_rot_wxyz(vals[3:]), t=vals[:3])
    raise ValueError(f"Unsupported pose length: {len(vals)} from '{raw}'")


def parse_rai_joint_origins(yml_path: Path):
    txt = yml_path.read_text(encoding="utf-8", errors="ignore")
    out = {}
    for line in txt.splitlines():
        m = ORIGIN_RE.match(line)
        if not m:
            continue
        idx = int(m.group(1))
        out[idx] = _parse_pose_array(m.group(2))
    if len(out) != 7:
        raise RuntimeError(f"Expected 7 joint origins in {yml_path}, got {len(out)}")
    return [out[i] for i in range(1, 8)]


def parse_rai_gripper_transform(panda_g_path: Path):
    txt = panda_g_path.read_text(encoding="utf-8", errors="ignore")
    m = GRIPPER_RE.search(txt)
    if not m:
        raise RuntimeError("Cannot find gripper(...) Q in panda.g")
    expr = m.group(1)

    T = np.eye(4)
    for token, payload in TOKEN_RE.findall(expr):
        vals = _vec(payload)
        if token == "t":
            if len(vals) < 3:
                raise ValueError(f"Bad translation token: {payload}")
            T = T @ _T(t=vals[:3])
        elif token == "d":
            if len(vals) < 4:
                raise ValueError(f"Bad axis-angle token: {payload}")
            ang = vals[0]
            axis = vals[1:4]
            T = T @ _T(R=_axis_angle_deg_to_rot(axis, ang))
    return T


def parse_mj_world(xml_path: Path):
    root = ET.parse(xml_path).getroot()
    worldbody = root.find("worldbody")
    if worldbody is None:
        raise RuntimeError("Missing <worldbody> in panda.xml")

    default_joint_range = None
    default_pad = np.zeros(3)
    for d in root.findall(".//default"):
        if d.get("class") == "panda":
            j = d.find("joint")
            if j is not None and j.get("range"):
                default_joint_range = _vec(j.get("range"))
        if d.get("class") == "fingertip_pad":
            g = d.find("geom")
            if g is not None and g.get("pos"):
                default_pad = _vec(g.get("pos"))

    body_by_name = {}
    parent_by_name = {}
    for parent in worldbody.iter("body"):
        pname = parent.get("name")
        for child in parent.findall("body"):
            cname = child.get("name")
            if not cname:
                continue
            body_by_name[cname] = child
            parent_by_name[cname] = pname

    if "link0" not in body_by_name:
        link0 = worldbody.find("body[@name='link0']")
        if link0 is None:
            raise RuntimeError("Cannot find body link0")
        body_by_name["link0"] = link0
        parent_by_name["link0"] = None

    joint_limits = {}
    for i in range(1, 8):
        jn = f"panda_joint{i}"
        node = root.find(f".//joint[@name='{jn}']")
        if node is None:
            raise RuntimeError(f"Missing joint {jn} in panda.xml")
        if node.get("range"):
            lim = _vec(node.get("range"))
        else:
            if default_joint_range is None:
                raise RuntimeError(f"Joint {jn} has no range and no default range")
            lim = default_joint_range.copy()
        joint_limits[i] = [float(lim[0]), float(lim[1])]

    return {
        "body_by_name": body_by_name,
        "parent_by_name": parent_by_name,
        "joint_limits": joint_limits,
        "default_pad": default_pad,
    }


def _body_local_T(body):
    pos = _vec(body.get("pos", "0 0 0"))
    quat = _vec(body.get("quat", "1 0 0 0"))
    return _T(R=_quat_to_rot_wxyz(quat), t=pos)


def mj_fk(q7, parsed):
    body_by_name = parsed["body_by_name"]
    parent_by_name = parsed["parent_by_name"]

    qmap = {f"panda_joint{i}": float(q7[i - 1]) for i in range(1, 8)}

    cache = {}

    def world_T(name):
        if name in cache:
            return cache[name]
        body = body_by_name[name]
        parent = parent_by_name.get(name)
        T_here = _body_local_T(body)
        j = body.find("joint")
        if j is not None:
            jn = j.get("name")
            if jn in qmap:
                T_here = T_here @ _T(R=_rotz(qmap[jn]))
        if parent is None:
            T = T_here
        else:
            T = world_T(parent) @ T_here
        cache[name] = T
        return T

    T_link7 = world_T("link7")
    T_hand = world_T("hand")
    T_left = world_T("left_finger")
    T_right = world_T("right_finger")

    pad = parsed["default_pad"]
    left_pad = _apply(T_left, pad)
    right_pad = _apply(T_right, pad)

    return {
        "link7": T_link7[:3, 3].copy(),
        "hand": T_hand[:3, 3].copy(),
        "left_pad": left_pad,
        "right_pad": right_pad,
        "pad_center": 0.5 * (left_pad + right_pad),
    }


def rai_fk(q7, origins, T_gripper):
    T = np.eye(4)
    for i in range(7):
        T = T @ origins[i] @ _T(R=_rotz(q7[i]))
    T_link7 = T
    T_grip = T_link7 @ T_gripper
    return {
        "link7": T_link7[:3, 3].copy(),
        "gripper": T_grip[:3, 3].copy(),
    }


def parse_q_samples_from_log(log_path: Path):
    out = []
    inside = False
    for line in log_path.read_text(encoding="utf-8", errors="ignore").splitlines():
        if "V-LGP TRAJECTORY START" in line:
            inside = True
            continue
        if "V-LGP TRAJECTORY END" in line and inside:
            inside = False
            continue
        if not inside:
            continue
        s = line.strip()
        if not s or s.startswith("DIM:"):
            continue
        parts = s.split()
        if len(parts) < 8:
            continue
        try:
            q = [float(x) for x in parts[1:8]]
        except ValueError:
            continue
        out.append(np.array(q, dtype=float))
    if not out:
        raise RuntimeError(f"No trajectory points parsed from {log_path}")
    return out


def sample_q_random(joint_limits, count, seed):
    rng = np.random.default_rng(seed)
    qs = []
    for _ in range(count):
        q = []
        for i in range(1, 8):
            lo, hi = joint_limits[i]
            q.append(float(rng.uniform(lo, hi)))
        qs.append(np.array(q, dtype=float))
    return qs


def stride_pick(items, max_n):
    if len(items) <= max_n:
        return items
    idx = np.linspace(0, len(items) - 1, max_n, dtype=int)
    return [items[i] for i in idx]


def vec_stats(vals):
    arr = np.array(vals, dtype=float)
    if arr.size == 0:
        return {"mean": 0.0, "max": 0.0, "p95": 0.0}
    return {
        "mean": float(np.mean(arr)),
        "max": float(np.max(arr)),
        "p95": float(np.percentile(arr, 95)),
    }


def main():
    ap = argparse.ArgumentParser(description="Sample RAI vs MuJoCo TCP/readout error over shared joint states.")
    ap.add_argument("--traj-log", default="", help="Optional trajectory log. If set, sample joint states from this file.")
    ap.add_argument("--samples", type=int, default=120, help="Max number of sampled states")
    ap.add_argument("--seed", type=int, default=42)
    ap.add_argument(
        "--panda-yml",
        default="rai/test/newLGP/rai-robotModels/panda/panda_arm_hand_conv.yml",
        help="RAI panda chain definition",
    )
    ap.add_argument(
        "--panda-g",
        default="rai/test/newLGP/rai-robotModels/panda/panda.g",
        help="RAI panda model with gripper marker definition",
    )
    ap.add_argument(
        "--panda-xml",
        default="simulation/mujoco_ros2_control_examples/panda_resources/panda_mujoco/franka_emika_panda/panda.xml",
        help="MuJoCo panda model",
    )
    ap.add_argument("--json-out", default="", help="Optional path to save full result JSON")
    args = ap.parse_args()

    yml_path = Path(args.panda_yml)
    g_path = Path(args.panda_g)
    xml_path = Path(args.panda_xml)

    origins = parse_rai_joint_origins(yml_path)
    T_gripper = parse_rai_gripper_transform(g_path)
    mj_parsed = parse_mj_world(xml_path)

    if args.traj_log:
        q_all = parse_q_samples_from_log(Path(args.traj_log))
        source = f"trajectory:{args.traj_log}"
    else:
        q_all = sample_q_random(mj_parsed["joint_limits"], count=max(args.samples, 1), seed=args.seed)
        source = f"random(seed={args.seed})"

    q_sel = stride_pick(q_all, max(args.samples, 1))

    rows = []
    for i, q in enumerate(q_sel):
        rai = rai_fk(q, origins, T_gripper)
        mj = mj_fk(q, mj_parsed)

        d_link7 = mj["link7"] - rai["link7"]
        d_tcp = mj["pad_center"] - rai["gripper"]

        rows.append(
            {
                "idx": i,
                "q": [float(x) for x in q],
                "rai_link7": [float(x) for x in rai["link7"]],
                "mj_link7": [float(x) for x in mj["link7"]],
                "rai_tcp_gripper": [float(x) for x in rai["gripper"]],
                "mj_tcp_pad_center": [float(x) for x in mj["pad_center"]],
                "delta_link7": [float(x) for x in d_link7],
                "delta_tcp": [float(x) for x in d_tcp],
                "delta_link7_norm": float(np.linalg.norm(d_link7)),
                "delta_tcp_norm": float(np.linalg.norm(d_tcp)),
                "rai_reach_norm": float(np.linalg.norm(rai["gripper"])),
            }
        )

    link7_norms = [r["delta_link7_norm"] for r in rows]
    tcp_norms = [r["delta_tcp_norm"] for r in rows]
    dxyz = np.array([r["delta_tcp"] for r in rows], dtype=float) if rows else np.zeros((0, 3))
    reach = np.array([r["rai_reach_norm"] for r in rows], dtype=float) if rows else np.zeros((0,))
    if len(rows) >= 2 and float(np.std(reach)) > 1e-12 and float(np.std(tcp_norms)) > 1e-12:
        corr = float(np.corrcoef(reach, np.array(tcp_norms))[0, 1])
    else:
        corr = 0.0

    summary = {
        "sample_source": source,
        "sample_count": len(rows),
        "delta_link7_norm_m": vec_stats(link7_norms),
        "delta_tcp_norm_m": vec_stats(tcp_norms),
        "delta_tcp_xyz_mean_m": [float(x) for x in np.mean(dxyz, axis=0)] if len(rows) else [0.0, 0.0, 0.0],
        "delta_tcp_xyz_std_m": [float(x) for x in np.std(dxyz, axis=0)] if len(rows) else [0.0, 0.0, 0.0],
        "corr_reach_vs_tcp_error": corr,
        "inference": [
            "If link7 error is near-zero but tcp error is large, mismatch is likely in TCP definition (gripper marker vs fingertip pad).",
            "If tcp delta mean is constant and std is tiny, dominant issue is constant offset.",
            "If corr_reach_vs_tcp_error is high, check frame rotation/base alignment in addition to offset.",
        ],
    }

    result = {
        "inputs": {
            "panda_yml": str(yml_path),
            "panda_g": str(g_path),
            "panda_xml": str(xml_path),
            "traj_log": args.traj_log,
            "samples": args.samples,
            "seed": args.seed,
        },
        "summary": summary,
        "rows": rows,
    }

    print("=== RAI vs MuJoCo TCP Sampling Report ===")
    print(f"source:         {source}")
    print(f"samples:        {len(rows)}")
    print(f"link7 mean/max: {summary['delta_link7_norm_m']['mean']:.6f} / {summary['delta_link7_norm_m']['max']:.6f} m")
    print(f"tcp   mean/max: {summary['delta_tcp_norm_m']['mean']:.6f} / {summary['delta_tcp_norm_m']['max']:.6f} m")
    print(f"tcp mean dxyz:  {summary['delta_tcp_xyz_mean_m']}")
    print(f"tcp std  dxyz:  {summary['delta_tcp_xyz_std_m']}")
    print(f"corr(reach,err): {summary['corr_reach_vs_tcp_error']:.4f}")

    top = sorted(rows, key=lambda r: r["delta_tcp_norm"], reverse=True)[:5]
    if top:
        print("top-5 tcp error samples (idx | err | q0..q6):")
        for r in top:
            qtxt = " ".join(f"{v:+.3f}" for v in r["q"])
            print(f"- {r['idx']:4d} | {r['delta_tcp_norm']:.6f} | {qtxt}")

    if args.json_out:
        out = Path(args.json_out)
        out.write_text(json.dumps(result, indent=2), encoding="utf-8")
        print(f"saved json: {out}")


if __name__ == "__main__":
    main()
