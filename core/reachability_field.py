import math
import os
import re
from typing import Dict, List, Optional, Tuple

import numpy as np

_NAME_PARENT_PATTERN = re.compile(r"^\s*([A-Za-z_][\w]*)\s*\(([^)]*)\)")
_T_PATTERN = re.compile(r"t\(([^)]+)\)")
_LOGICAL_PATTERN = re.compile(r"logical\s*:\s*\{([^}]*)\}", re.IGNORECASE)
_SHAPE_PATTERN = re.compile(r"shape\s*:\s*([A-Za-z_][\w]*)", re.IGNORECASE)
_SIZE_PATTERN = re.compile(r"size\s*:\s*\[([^\]]+)\]", re.IGNORECASE)
_CONTACT_PATTERN = re.compile(r"contact\s*:\s*([\d\.\-]+)", re.IGNORECASE)


def _parse_float_list(raw: str) -> List[float]:
    parts = [p for p in raw.replace(",", " ").split() if p]
    return [float(p) for p in parts]


def _parse_xyz_from_q(block: str) -> Optional[Tuple[float, float, float]]:
    m = _T_PATTERN.search(block)
    if not m:
        return None
    nums = _parse_float_list(m.group(1))
    if len(nums) < 3:
        return None
    return nums[0], nums[1], nums[2]


def _parse_logical_flags(block: str) -> List[str]:
    m = _LOGICAL_PATTERN.search(block)
    if not m:
        return []
    return [x.strip() for x in m.group(1).split(",") if x.strip()]


def _parse_shape(block: str) -> str:
    m = _SHAPE_PATTERN.search(block)
    if not m:
        return ""
    return m.group(1).lower()


def _parse_size(block: str) -> List[float]:
    m = _SIZE_PATTERN.search(block)
    if not m:
        return []
    return _parse_float_list(m.group(1))


def _parse_contact(block: str) -> float:
    m = _CONTACT_PATTERN.search(block)
    if not m:
        return 0.0
    try:
        return float(m.group(1))
    except ValueError:
        return 0.0


def _parse_scene_frames(scene_path: str) -> Dict[str, Dict]:
    if not os.path.exists(scene_path):
        raise FileNotFoundError(f"Scene file not found: {scene_path}")

    frames: Dict[str, Dict] = {}
    with open(scene_path, "r") as f:
        for raw in f:
            line = raw.strip()
            if not line or line.startswith("#"):
                continue

            lbrace = line.find("{")
            rbrace = line.rfind("}")
            if lbrace < 0 or rbrace <= lbrace:
                continue

            header = line[:lbrace].strip()
            block = line[lbrace + 1 : rbrace]

            m = _NAME_PARENT_PATTERN.match(header)
            if not m:
                continue

            name = m.group(1)
            parent = m.group(2).strip()
            t = _parse_xyz_from_q(block)

            frames[name] = {
                "name": name,
                "parent": parent,
                "local_t": t,
                "logical_flags": _parse_logical_flags(block),
                "shape": _parse_shape(block),
                "size": _parse_size(block),
                "contact": _parse_contact(block),
            }

    return frames


def _world_pos(frame_name: str, frames: Dict[str, Dict], memo: Dict[str, np.ndarray]) -> np.ndarray:
    if frame_name in memo:
        return memo[frame_name]
    fr = frames.get(frame_name)
    if fr is None:
        p = np.zeros(3, dtype=float)
        memo[frame_name] = p
        return p

    local_t = fr.get("local_t")
    local = np.asarray(local_t if local_t is not None else (0.0, 0.0, 0.0), dtype=float)
    parent = (fr.get("parent") or "").strip()
    if not parent or parent == "world" or parent == "False":
        memo[frame_name] = local
        return local

    parent_world = _world_pos(parent, frames, memo)
    p = parent_world + local
    memo[frame_name] = p
    return p


def _obstacle_radius(shape: str, size: List[float]) -> float:
    if not size:
        return 0.03
    s = shape.lower()
    if s in {"ssbox", "box"} and len(size) >= 3:
        return 0.5 * math.sqrt(size[0] ** 2 + size[1] ** 2 + size[2] ** 2)
    if s in {"cylinder", "sscylinder", "capsule"}:
        if len(size) >= 2:
            h = size[0]
            r = size[1]
            return math.sqrt((0.5 * h) ** 2 + r ** 2)
    if len(size) >= 3:
        return 0.5 * math.sqrt(size[0] ** 2 + size[1] ** 2 + size[2] ** 2)
    return max(0.02, size[0] * 0.5)


def _is_object(fr: Dict) -> bool:
    return "is_object" in set(fr.get("logical_flags", []))


def _is_robot_frame(name: str) -> bool:
    return name.startswith("l_") or "panda" in name


def _is_obstacle_frame(name: str, fr: Dict) -> bool:
    lname = name.lower()
    logical = set(fr.get("logical_flags", []))
    if lname.startswith("collision_"):
        return True
    if "obstacle" in lname:
        return True
    if lname.startswith("obs_"):
        return True
    if "is_obstacle" in logical:
        return True
    # conservative fallback: explicit non-object collision proxy naming only
    if fr.get("contact", 0.0) > 0 and not _is_object(fr) and not _is_robot_frame(name) and "collision" in lname:
        return True
    return False

def _build_gmm_scores(points: np.ndarray, sigma: float = 0.12) -> np.ndarray:
    # GMM/KDE 打分（当前实现语义）
    # ------------------------------------------------------------
    # 这里的输入 points 来自对象采样点（handle 或 center），不是机器人关节状态 q。
    # 因此本函数只反映“对象点位在任务空间中的统计密度先验”，不包含：
    # - 关节角度上下限
    # - 连杆长度/体积碰撞
    # - IK/KOMO 可行性
    # 换言之：这是“几何先验分数”，不是机械臂真实可达性的充分条件。
    if points.shape[0] == 0:
        return np.zeros((0,), dtype=float)
    if points.shape[0] == 1:
        return np.ones((1,), dtype=float)

    diffs = points[:, None, :] - points[None, :, :]
    d2 = np.sum(diffs * diffs, axis=2)
    kernel = np.exp(-0.5 * d2 / max(1e-6, sigma * sigma))
    # 绝对核密度分数（约在 [1/N, 1]）。
    # 采用绝对尺度，避免相对归一化把“最低样本”硬压到 0。
    raw = np.mean(kernel, axis=1)
    return np.asarray(raw, dtype=float)


def _build_esdf_scores(sample_points: np.ndarray, obstacle_centers: np.ndarray, obstacle_radii: np.ndarray) -> np.ndarray:
    # ESDF 近似评分（当前实现语义）
    # ------------------------------------------------------------
    # 当前不是完整体素 ESDF，而是“点到障碍近似体(中心+半径)”的距离评分：
    #   d_k = ||p - c_k|| - r_k
    #   dmin = min_k d_k
    #   score = clip(dmin, 0, d_cap) / d_cap
    # 其中 d_cap = 0.20 米（当前硬编码）。
    # 对应判定含义：
    # - dmin <= 0      -> score = 0（贴障碍/穿透）
    # - dmin >= 0.20m  -> score = 1（足够远）
    # - 中间区间线性插值
    # 该评分仍是“对象采样点级”风险信号，不是整条机械臂体积碰撞证明。
    if sample_points.shape[0] == 0:
        return np.zeros((0,), dtype=float)
    if obstacle_centers.shape[0] == 0:
        return np.ones((sample_points.shape[0],), dtype=float)

    scores = []
    d_cap = 0.20
    for p in sample_points:
        d = np.linalg.norm(obstacle_centers - p[None, :], axis=1) - obstacle_radii
        dmin = float(np.min(d))
        clamped = max(0.0, min(d_cap, dmin))
        scores.append(clamped / d_cap)
    return np.asarray(scores, dtype=float)


def compute_reachability_scores_from_unnamed_g(
    scene_path: str,
    layout_list: List[Dict],
    alpha: float = 0.6,
    beta: float = 0.4,
    tau_r: float = 0.45,
    seed: int = 42,
) -> Dict:
    rng = np.random.default_rng(seed)
    _ = rng  # reserved for deterministic extension

    frames = _parse_scene_frames(scene_path)
    memo: Dict[str, np.ndarray] = {}

    layout_by_logical: Dict[str, Dict] = {str(x.get("logical_id")): x for x in layout_list if isinstance(x, dict)}

    # Map logical ids to concrete object frames.
    # unnamed.g uses anon_id (obj_XX), while layout carries logical_id + anon_id.
    object_rows = []
    for item in layout_list:
        if not isinstance(item, dict):
            continue
        anon = item.get("anon_id")
        logical_id = item.get("logical_id")
        if not anon or not logical_id:
            continue
        fr = frames.get(anon)
        if fr is None:
            continue

        center = _world_pos(anon, frames, memo)
        sample = center.copy()
        sample_source = "center"

        # 采样点策略：优先使用 handle 子帧，否则使用对象中心。
        # 注意：这一步仍然没有任何机器人姿态/关节信息参与。
        for name, cand in frames.items():
            if cand.get("parent") == anon and "handle" in name.lower():
                sample = _world_pos(name, frames, memo)
                sample_source = "handle"
                break

        object_rows.append(
            {
                "logical_id": logical_id,
                "anon_id": anon,
                "object_type": item.get("object_type", "unknown"),
                "sample_point_source": sample_source,
                "sample_point_xyz": sample.tolist(),
            }
        )

    gmm_sigma = 0.12
    # sample_points 仅来自对象点位（场景几何）；不含机器人 q、关节限位等信息。
    sample_points = np.asarray([r["sample_point_xyz"] for r in object_rows], dtype=float) if object_rows else np.zeros((0, 3), dtype=float)
    gmm_scores = _build_gmm_scores(sample_points, sigma=gmm_sigma)

    obstacle_centers = []
    obstacle_radii = []
    for name, fr in frames.items():
        if not _is_obstacle_frame(name, fr):
            continue
        c = _world_pos(name, frames, memo)
        r = _obstacle_radius(fr.get("shape", ""), fr.get("size", []))
        obstacle_centers.append(c)
        obstacle_radii.append(r)

    oc = np.asarray(obstacle_centers, dtype=float) if obstacle_centers else np.zeros((0, 3), dtype=float)
    orad = np.asarray(obstacle_radii, dtype=float) if obstacle_radii else np.zeros((0,), dtype=float)
    esdf_scores = _build_esdf_scores(sample_points, oc, orad)
    # 融合：当前仅做简单线性加权。
    # reachability_score 高，代表“几何先验 + 点级清障”更好；
    # 但不等价于“机械臂姿态一定可执行”。
    fused = alpha * gmm_scores + beta * esdf_scores

    out_objects = []
    decisions = {}
    for i, row in enumerate(object_rows):
        score = float(fused[i])
        decision = "feasible" if score >= tau_r else "infeasible"
        out = {
            **row,
            "gmm_score": float(gmm_scores[i]),
            "esdf_score": float(esdf_scores[i]),
            "reachability_score": score,
            "threshold": tau_r,
            "decision": decision,
            "reason": "score>=tau_r" if decision == "feasible" else "score<tau_r",
        }
        out_objects.append(out)
        decisions[row["logical_id"]] = out

    return {
        "version": "v1",
        "method": "gmm_esdf_mvp",
        "scene_input": os.path.basename(scene_path),
        "params": {
            "alpha": alpha,
            "beta": beta,
            "tau_r": tau_r,
            "seed": seed,
            "gmm_sigma": gmm_sigma,
            "gmm_score_mode": "absolute_kernel_density",
        },
        "obstacle_count": int(oc.shape[0]),
        "objects": out_objects,
        "decisions": decisions,
    }
