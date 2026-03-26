import json
import math
import re
import xml.etree.ElementTree as ET
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List, Optional, Tuple

import numpy as np

"""
URDF 静态可操作度（manipulability）测试模块
=====================================

设计目标：
1) 完全不依赖 RAI/robotic；
2) 仅使用 URDF + 场景 .g 文本中的位姿信息；
3) 使用静态（kinematic）Yoshikawa 指标进行评分；
4) 输出可审计的对象级报告（分数、状态、原因、排序）。

主要外部 API 调用说明：
- `xml.etree.ElementTree.parse(...)`：解析 URDF XML。
- `numpy.linalg.solve(...)`：求解 DLS 线性方程。
- `numpy.linalg.det(...)`：计算 `J J^T` 行列式。
- `Path.read_text(...)`：读取 JSON/.g 文本。
- `json.loads(...)`：解析已有 Phase0 输出。
"""


# -------------------------------
# Data models
# -------------------------------


@dataclass
class JointModel:
    name: str
    parent: str
    child: str
    joint_type: str
    origin_xyz: np.ndarray
    origin_rpy: np.ndarray
    axis: np.ndarray
    limit_lower: Optional[float]
    limit_upper: Optional[float]


@dataclass
class RobotChain:
    base_link: str
    ee_link: str
    joints: List[JointModel]  # ordered base->ee
    active_joint_names: List[str]
    q_lower: np.ndarray
    q_upper: np.ndarray


# -------------------------------
# Basic transforms
# -------------------------------


def _rpy_to_rot(rpy: np.ndarray) -> np.ndarray:
    r, p, y = float(rpy[0]), float(rpy[1]), float(rpy[2])
    cr, sr = math.cos(r), math.sin(r)
    cp, sp = math.cos(p), math.sin(p)
    cy, sy = math.cos(y), math.sin(y)

    rx = np.array([[1, 0, 0], [0, cr, -sr], [0, sr, cr]], dtype=float)
    ry = np.array([[cp, 0, sp], [0, 1, 0], [-sp, 0, cp]], dtype=float)
    rz = np.array([[cy, -sy, 0], [sy, cy, 0], [0, 0, 1]], dtype=float)
    return rz @ ry @ rx


def _axis_angle_to_rot(axis: np.ndarray, angle: float) -> np.ndarray:
    axis = np.asarray(axis, dtype=float)
    n = np.linalg.norm(axis)
    if n < 1e-12:
        return np.eye(3)
    axis = axis / n
    x, y, z = axis
    c = math.cos(angle)
    s = math.sin(angle)
    C = 1.0 - c
    return np.array(
        [
            [c + x * x * C, x * y * C - z * s, x * z * C + y * s],
            [y * x * C + z * s, c + y * y * C, y * z * C - x * s],
            [z * x * C - y * s, z * y * C + x * s, c + z * z * C],
        ],
        dtype=float,
    )


def _make_transform(R: np.ndarray, t: np.ndarray) -> np.ndarray:
    T = np.eye(4, dtype=float)
    T[:3, :3] = R
    T[:3, 3] = t
    return T


def _transform_point(T: np.ndarray, p: np.ndarray) -> np.ndarray:
    ph = np.ones(4, dtype=float)
    ph[:3] = p
    return (T @ ph)[:3]


# -------------------------------
# URDF parsing
# -------------------------------


def _parse_vec(text: Optional[str], dim: int, default: float = 0.0) -> np.ndarray:
    if not text:
        return np.full((dim,), default, dtype=float)
    vals = [float(x) for x in text.strip().split()]
    if len(vals) != dim:
        raise ValueError(f"Expected {dim} floats, got '{text}'")
    return np.asarray(vals, dtype=float)


def load_urdf_chain(urdf_path: str, base_link: str = "panda_link0", ee_link: str = "panda_hand") -> RobotChain:
    """
    从 URDF 提取 base->ee 的有序关节链（不依赖仿真器）。

    参数：
    - urdf_path: URDF 文件路径。
    - base_link: 链起点 link 名称（默认 panda_link0）。
    - ee_link: 链终点 link 名称（默认 panda_hand）。

    返回：
    - RobotChain
        - joints: 从 base 到 ee 的关节顺序。
        - active_joint_names: 当前实现用于可操作度的主动关节（revolute/continuous）。
        - q_lower/q_upper: 主动关节限位，用于 IK 迭代中的裁剪。

    关键实现细节：
    1) 先扫描 URDF 所有关节，建立 `child -> joint` 反向索引；
    2) 从 ee_link 反向追踪到 base_link；
    3) 反转得到 base->ee 顺序；
    4) 提取主动关节限位。

    关键 API：
    - `ET.parse(urdf_path).getroot()`：读取并获取 XML 根节点。
    - `element.find(...)`：读取 `origin/axis/limit` 等字段。
    """
    root = ET.parse(urdf_path).getroot()

    joints_all: Dict[str, JointModel] = {}
    child_to_joint: Dict[str, str] = {}

    for j in root.findall("joint"):
        name = j.attrib["name"]
        joint_type = j.attrib.get("type", "fixed")

        parent_el = j.find("parent")
        child_el = j.find("child")
        if parent_el is None or child_el is None:
            continue

        origin_el = j.find("origin")
        axis_el = j.find("axis")
        limit_el = j.find("limit")

        origin_xyz = _parse_vec(origin_el.attrib.get("xyz") if origin_el is not None else None, 3, 0.0)
        origin_rpy = _parse_vec(origin_el.attrib.get("rpy") if origin_el is not None else None, 3, 0.0)
        axis = _parse_vec(axis_el.attrib.get("xyz") if axis_el is not None else None, 3, 0.0)

        lower = None
        upper = None
        if limit_el is not None:
            if "lower" in limit_el.attrib:
                lower = float(limit_el.attrib["lower"])
            if "upper" in limit_el.attrib:
                upper = float(limit_el.attrib["upper"])

        jm = JointModel(
            name=name,
            parent=parent_el.attrib["link"],
            child=child_el.attrib["link"],
            joint_type=joint_type,
            origin_xyz=origin_xyz,
            origin_rpy=origin_rpy,
            axis=axis,
            limit_lower=lower,
            limit_upper=upper,
        )
        joints_all[name] = jm
        child_to_joint[jm.child] = name

    # Recover path from ee_link back to base_link
    rev_chain: List[JointModel] = []
    cur = ee_link
    while cur != base_link:
        jname = child_to_joint.get(cur)
        if jname is None:
            raise ValueError(f"Cannot connect '{ee_link}' back to '{base_link}' in URDF")
        jm = joints_all[jname]
        rev_chain.append(jm)
        cur = jm.parent

    joints = list(reversed(rev_chain))

    active_joint_names = [j.name for j in joints if j.joint_type in ("revolute", "continuous")]
    q_lower = []
    q_upper = []
    for j in joints:
        if j.joint_type in ("revolute", "continuous"):
            q_lower.append(-np.pi if j.limit_lower is None else j.limit_lower)
            q_upper.append(np.pi if j.limit_upper is None else j.limit_upper)

    return RobotChain(
        base_link=base_link,
        ee_link=ee_link,
        joints=joints,
        active_joint_names=active_joint_names,
        q_lower=np.asarray(q_lower, dtype=float),
        q_upper=np.asarray(q_upper, dtype=float),
    )


# -------------------------------
# FK + position Jacobian
# -------------------------------


def clamp_q(q: np.ndarray, q_lower: np.ndarray, q_upper: np.ndarray) -> np.ndarray:
    return np.minimum(np.maximum(q, q_lower), q_upper)


def fk_and_jacobian_position(chain: RobotChain, q: np.ndarray, base_T_world: np.ndarray) -> Tuple[np.ndarray, np.ndarray]:
    """
    计算末端位置与位置雅可比 Jp（3xn）。

    参数：
    - chain: 由 `load_urdf_chain()` 生成的关节链。
    - q: 主动关节向量（长度必须等于 `active_joint_names`）。
    - base_T_world: base_link 在 world 下的 4x4 齐次变换。

    返回：
    - p_ee: 末端位置（world 坐标，3 维）。
    - J: 位置雅可比（3xn）。

    数学：
    - revolute 关节的列向量为：
        `J[:, i] = z_i × (p_ee - p_i)`
        其中 `z_i`、`p_i` 分别是关节轴方向和关节原点（world）。

    说明：
    - 本函数只做 position Jacobian，不含姿态 Jacobian；
    - 对于本次静态排序任务已经足够。
    """
    q = np.asarray(q, dtype=float).reshape(-1)
    if q.shape[0] != len(chain.active_joint_names):
        raise ValueError("q dimension mismatch")

    T = base_T_world.copy()
    active_idx = 0
    joint_world_pos: List[np.ndarray] = []
    joint_world_axis: List[np.ndarray] = []

    for j in chain.joints:
        R0 = _rpy_to_rot(j.origin_rpy)
        T = T @ _make_transform(R0, j.origin_xyz)

        if j.joint_type in ("revolute", "continuous"):
            axis_local = j.axis if np.linalg.norm(j.axis) > 1e-12 else np.array([0.0, 0.0, 1.0])
            axis_world = T[:3, :3] @ (axis_local / np.linalg.norm(axis_local))
            pos_world = T[:3, 3].copy()

            joint_world_pos.append(pos_world)
            joint_world_axis.append(axis_world)

            Rq = _axis_angle_to_rot(axis_local, q[active_idx])
            T = T @ _make_transform(Rq, np.zeros(3, dtype=float))
            active_idx += 1

        elif j.joint_type == "prismatic":
            axis_local = j.axis if np.linalg.norm(j.axis) > 1e-12 else np.array([0.0, 0.0, 1.0])
            T = T @ _make_transform(np.eye(3), axis_local * q[active_idx])
            active_idx += 1

        else:
            # fixed
            pass

    p_ee = T[:3, 3].copy()
    n = len(joint_world_pos)
    J = np.zeros((3, n), dtype=float)
    for i in range(n):
        J[:, i] = np.cross(joint_world_axis[i], p_ee - joint_world_pos[i])

    return p_ee, J


# -------------------------------
# IK + scores
# -------------------------------


def solve_ik_position_dls(
    chain: RobotChain,
    target_xyz: np.ndarray,
    q0: np.ndarray,
    base_T_world: np.ndarray,
    max_iter: int = 200,
    tol: float = 1e-4,
    damping: float = 1e-2,
    step_scale: float = 0.8,
) -> Tuple[bool, np.ndarray, float]:
    """
    使用阻尼最小二乘（DLS）求解位置 IK。

    参数：
    - chain: 机器人关节链。
    - target_xyz: 目标末端位置（world）。
    - q0: 初始关节值。
    - base_T_world: base 在 world 下位姿。
    - max_iter: 最大迭代次数。
    - tol: 位置误差收敛阈值。
    - damping: DLS 阻尼系数 λ。
    - step_scale: 步长缩放。

    返回：
    - (ok, q_sol, err_norm)
        - ok: 是否收敛；
        - q_sol: 最终关节；
        - err_norm: 最终位置误差范数。

    迭代核心：
    - `dq = J^T (J J^T + λ²I)^(-1) e`
    - `q <- clamp(q + step_scale * dq)`

    关键 API：
    - `np.linalg.solve(A, e)`：求解线性系统，避免显式求逆。
    """
    q = clamp_q(np.asarray(q0, dtype=float).copy(), chain.q_lower, chain.q_upper)
    target_xyz = np.asarray(target_xyz, dtype=float).reshape(3)

    for _ in range(max_iter):
        p, J = fk_and_jacobian_position(chain, q, base_T_world)
        err = target_xyz - p
        err_norm = float(np.linalg.norm(err))
        if err_norm <= tol:
            return True, q, err_norm

        JJt = J @ J.T
        A = JJt + (damping ** 2) * np.eye(3, dtype=float)
        try:
            dq = J.T @ np.linalg.solve(A, err)
        except np.linalg.LinAlgError:
            return False, q, err_norm

        q = clamp_q(q + step_scale * dq, chain.q_lower, chain.q_upper)

    p, _ = fk_and_jacobian_position(chain, q, base_T_world)
    final_err = float(np.linalg.norm(target_xyz - p))
    return final_err <= tol, q, final_err


def yoshikawa_position_score(Jp: np.ndarray) -> Tuple[Optional[float], str]:
    """
    计算位置域 Yoshikawa 可操作度原始分数。

    公式：
    - `m_raw = sqrt(det(Jp @ Jp.T))`

    返回：
    - (score, reason)
        - score: 浮点分数或 None；
        - reason: 错误原因/状态标签，便于审计。

    数值健壮性策略：
    - 若 det 非有限值 -> `det_non_finite`；
    - 若 det < 0 且接近 0（浮点误差）-> 截断到 0；
    - 若 det 明显负值 -> `det_negative`。
    """
    if Jp.shape[0] != 3:
        return None, "invalid_jacobian_shape"
    JJt = Jp @ Jp.T
    detv = float(np.linalg.det(JJt))
    if not np.isfinite(detv):
        return None, "det_non_finite"
    if detv < 0.0:
        if detv > -1e-10:
            detv = 0.0
        else:
            return None, "det_negative"
    score = math.sqrt(detv)
    if not np.isfinite(score):
        return None, "score_non_finite"
    return score, "ok"


def normalize_scores(raw_scores: List[Optional[float]], eps: float = 1e-12) -> List[Optional[float]]:
    """
    对有效原始分数做 min-max 归一化到 [0,1]。

    参数：
    - raw_scores: 允许包含 None（无效样本）。
    - eps: 分母保护项，防止全相等时除零。

    规则：
    - None 保持 None；
    - 有效值按 `(v-vmin)/(vmax-vmin+eps)` 归一化。
    """
    vals = [v for v in raw_scores if v is not None]
    if not vals:
        return [None for _ in raw_scores]
    vmin = min(vals)
    vmax = max(vals)
    denom = max(vmax - vmin, eps)
    out: List[Optional[float]] = []
    for v in raw_scores:
        if v is None:
            out.append(None)
        else:
            out.append(float((v - vmin) / denom))
    return out


# -------------------------------
# Scene/layout helpers (no RAI)
# -------------------------------


_BASE_EDIT_PATTERN = re.compile(
    r'Edit\s+l_panda_base\s*\(table\)\s*:\s*\{\s*Q\s*:\s*"([^"]+)"',
    re.IGNORECASE,
)
_TABLE_PATTERN = re.compile(
    r'(?m)^\s*table\s*\([^)]*\)\s*\{[^\n]*Q\s*:\s*"([^"]+)"',
    re.IGNORECASE,
)
_OBJ_PATTERN = re.compile(
    r'(?m)^\s*(obj_\d+)\s*\([^)]*\)\s*\{[^\n]*Q\s*:\s*"([^"]+)"',
    re.IGNORECASE,
)


def _parse_q_expr(q_expr: str) -> np.ndarray:
    """
    解析 .g 中 Q 表达式（仅解析本模块需要的子集）。

    支持：
    - 平移：`t(x y z)`
    - 轴角旋转（角度制）：`d(deg ax ay az)`

    返回：
    - 4x4 齐次变换矩阵。

    说明：
    - 该解析器是轻量实现，用于离线计算，不依赖 RAI。
    """
    T = np.eye(4, dtype=float)

    for m in re.finditer(r"t\(([^)]+)\)", q_expr):
        xyz = np.asarray([float(v) for v in m.group(1).replace(",", " ").split()], dtype=float)
        T = T @ _make_transform(np.eye(3), xyz)

    for m in re.finditer(r"d\(([^)]+)\)", q_expr):
        parts = [float(v) for v in m.group(1).replace(",", " ").split()]
        if len(parts) != 4:
            continue
        deg, ax, ay, az = parts
        R = _axis_angle_to_rot(np.array([ax, ay, az], dtype=float), math.radians(deg))
        T = T @ _make_transform(R, np.zeros(3, dtype=float))

    return T


def parse_scene_positions(g_path: str) -> Tuple[np.ndarray, Dict[str, np.ndarray]]:
    """
    从 .g 文本中提取：
    1) 机器人基座 world 位姿 `T_base_world`
    2) 所有 `obj_*` 的 world 位置

    输入：
    - g_path: 场景文件路径（如 `unnamed.g`）。

    输出：
    - `T_base_world`: 4x4
    - `objs`: `{anon_id -> xyz}`

    解析策略：
    - 读取 table 的 `Q`（作为父系参考）；
    - 读取 `Edit l_panda_base (table)` 的相对 Q；
    - 对象 `obj_i(table)` 也按 table 父系合成 world 位姿。
    """
    txt = Path(g_path).read_text(encoding="utf-8")

    table_m = _TABLE_PATTERN.search(txt)
    base_m = _BASE_EDIT_PATTERN.search(txt)
    if table_m is None or base_m is None:
        raise ValueError("Cannot find table/base transforms in g file")

    T_table = _parse_q_expr(table_m.group(1))
    T_base_rel = _parse_q_expr(base_m.group(1))
    T_base_world = T_table @ T_base_rel

    objs: Dict[str, np.ndarray] = {}
    for m in _OBJ_PATTERN.finditer(txt):
        oid = m.group(1)
        T_obj_rel = _parse_q_expr(m.group(2))
        T_obj_world = T_table @ T_obj_rel
        objs[oid] = T_obj_world[:3, 3].copy()

    return T_base_world, objs


def load_phase0_layout(layout_path: str) -> List[Dict]:
    return json.loads(Path(layout_path).read_text(encoding="utf-8"))


def load_infeasible(infeasible_path: str) -> Dict[str, Dict]:
    data = json.loads(Path(infeasible_path).read_text(encoding="utf-8"))
    return data.get("infeasible_objects", {}) or {}


def parse_initial_q_from_g(g_path: str, joint_names: List[str]) -> np.ndarray:
    """
    从 .g 文本中的 `Edit l_<joint> { q: ... }` 提取初始关节值。

    目的：
    - 作为 IK 初值，减少迭代难度并提升稳定性。

    约定：
    - 若某关节未找到编辑值，回退为 0.0。
    """
    txt = Path(g_path).read_text(encoding="utf-8")
    qmap: Dict[str, float] = {}

    for jn in joint_names:
        # scene uses prefixed names, e.g., l_panda_joint1
        pref = f"l_{jn}"
        pat = re.compile(rf"Edit\s+{re.escape(pref)}\s*\{{\s*q\s*:\s*([-+]?\d*\.?\d+(?:[eE][-+]?\d+)?)", re.IGNORECASE)
        m = pat.search(txt)
        if m:
            qmap[jn] = float(m.group(1))

    q0 = []
    for jn in joint_names:
        q0.append(qmap.get(jn, 0.0))
    return np.asarray(q0, dtype=float)


def derive_feasible(layout: List[Dict], infeasible: Dict[str, Dict]) -> List[Dict]:
    """
    由已有 `layout` 与 `infeasible_objects` 直接计算 feasible 集。

    这一步完全复用历史输出，不再调用 reachability checker。
    """
    infeasible_ids = set(infeasible.keys())
    return [it for it in layout if it.get("logical_id") not in infeasible_ids]


def group_type_order(feasible_items: List[Dict]) -> List[str]:
    # Keep legacy style order from phase0 parser
    preferred = ["cylinder", "cube", "rectprism", "triprism", "mesh"]
    seen = {it.get("object_type") for it in feasible_items}
    ordered = [t for t in preferred if t in seen]
    for t in feasible_items:
        ot = t.get("object_type")
        if ot not in ordered:
            ordered.append(ot)
    return ordered


def rank_same_type_with_unknown_tail(rows: List[Dict], tau_m: float) -> List[Dict]:
    """
    执行同类型局部排序策略：
    1) `ranked`（m >= tau_m）按分数降序；
    2) `unknown` 放该类型尾部；
    3) `unknown` 内按 `logical_id` 稳定排序。

    注意：
    - `tau_m` 在本函数中不直接参与比较（状态已在上游计算），
      保留参数是为了接口语义清晰。
    """
    by_type: Dict[str, List[Dict]] = {}
    for r in rows:
        by_type.setdefault(r["object_type"], []).append(r)

    out: List[Dict] = []
    for ot in group_type_order(rows):
        group = by_type.get(ot, [])
        ranked = [r for r in group if r["status"] == "ranked"]
        unknown = [r for r in group if r["status"] != "ranked"]

        ranked.sort(key=lambda x: (-x["manipulability_score"], x["logical_id"]))
        unknown.sort(key=lambda x: x["logical_id"])

        local_rank = 1
        for r in ranked:
            r["rank"] = local_rank
            local_rank += 1
        for r in unknown:
            r["rank"] = None

        out.extend(ranked)
        out.extend(unknown)

    return out


def compute_static_manipulability_report(
    layout_path: str,
    infeasible_path: str,
    g_path: str,
    urdf_path: str,
    tau_m: float = 0.08,
    approach_offset_z: float = 0.08,
    base_link: str = "panda_link0",
    ee_link: str = "panda_hand",
) -> Dict:
    """
    端到端生成“静态可操作度排序报告”。

    流程：
    1) 读取 `phase0_layout.json` 与 `infeasible_objects.json`；
    2) 直接派生 feasible 对象集（不跑 reachability）；
    3) 载入 URDF 关节链；
    4) 从 .g 文本解析 base/object 位姿、关节初值；
    5) 对每个 feasible 对象执行：
       - 构造目标点（对象位置 + approach_offset_z）；
       - DLS IK；
       - 计算 Yoshikawa 原始分数；
    6) 归一化 + 阈值分类（ranked/unknown）；
    7) 同类排序 + unknown 尾部；
    8) 生成最终 JSON report。

    参数：
    - tau_m: unknown 阈值（默认 0.08）。
    - approach_offset_z: 目标点在对象上方偏置，降低碰撞/不可达风险。

    返回：
    - report 字典（可直接 `json.dump` 保存）。
    """
    layout = load_phase0_layout(layout_path)
    infeasible = load_infeasible(infeasible_path)
    feasible = derive_feasible(layout, infeasible)

    chain = load_urdf_chain(urdf_path=urdf_path, base_link=base_link, ee_link=ee_link)
    base_T_world, obj_pos = parse_scene_positions(g_path)
    q0 = parse_initial_q_from_g(g_path, chain.active_joint_names)

    rows: List[Dict] = []
    raw_scores: List[Optional[float]] = []

    for item in feasible:
        anon_id = item.get("anon_id")
        logical_id = item.get("logical_id")
        object_type = item.get("object_type")

        pos = obj_pos.get(anon_id)
        if pos is None:
            rows.append(
                {
                    "anon_id": anon_id,
                    "logical_id": logical_id,
                    "object_type": object_type,
                    "target_xyz": None,
                    "ik_error": None,
                    "raw_score": None,
                    "manipulability_score": None,
                    "status": "unknown",
                    "reason": "missing_object_pose_in_g",
                }
            )
            raw_scores.append(None)
            continue

        target = pos.copy()
        target[2] += float(approach_offset_z)

        ok, q_sol, ik_err = solve_ik_position_dls(chain, target, q0=q0, base_T_world=base_T_world)
        if not ok:
            rows.append(
                {
                    "anon_id": anon_id,
                    "logical_id": logical_id,
                    "object_type": object_type,
                    "target_xyz": target.tolist(),
                    "ik_error": ik_err,
                    "raw_score": None,
                    "manipulability_score": None,
                    "status": "unknown",
                    "reason": "ik_failed",
                }
            )
            raw_scores.append(None)
            continue

        _, Jp = fk_and_jacobian_position(chain, q_sol, base_T_world=base_T_world)
        raw_score, reason = yoshikawa_position_score(Jp)
        rows.append(
            {
                "anon_id": anon_id,
                "logical_id": logical_id,
                "object_type": object_type,
                "target_xyz": target.tolist(),
                "ik_error": ik_err,
                "raw_score": raw_score,
                "manipulability_score": None,
                "status": "unknown",
                "reason": reason,
            }
        )
        raw_scores.append(raw_score)

    norm_scores = normalize_scores(raw_scores)
    for r, ns in zip(rows, norm_scores):
        r["manipulability_score"] = ns
        if ns is None:
            r["status"] = "unknown"
            if r["reason"] == "ok":
                r["reason"] = "score_invalid"
        elif ns >= tau_m:
            r["status"] = "ranked"
            r["reason"] = "score>=tau_m"
        else:
            r["status"] = "unknown"
            r["reason"] = "score<tau_m"

    ranked_rows = rank_same_type_with_unknown_tail(rows, tau_m=tau_m)

    report = {
        "version": "v1_static_test",
        "score_type": "yoshikawa_position_normalized",
        "tau_m": tau_m,
        "base_link": base_link,
        "ee_link": ee_link,
        "inputs": {
            "layout_path": str(layout_path),
            "infeasible_path": str(infeasible_path),
            "g_path": str(g_path),
            "urdf_path": str(urdf_path),
            "approach_offset_z": approach_offset_z,
            "counts": {
                "layout_total": len(layout),
                "infeasible_count": len(infeasible),
                "feasible_count": len(feasible),
            },
        },
        "objects": ranked_rows,
    }
    return report
