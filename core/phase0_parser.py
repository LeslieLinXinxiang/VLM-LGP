import json
import math
import os
import re
import subprocess
import sys
from typing import Dict, List, Tuple

from core.reachability_field import compute_reachability_scores_from_unnamed_g


_BASE_PATTERN = re.compile(
    r"Edit\s+l_panda_base\b[^\n]*\{\s*Q:\s*\"[^\"]*t\(([^)]+)\)",
    re.IGNORECASE,
)
_OBJECT_BLOCK_PATTERN = re.compile(r"(?m)^\s*((?:obj|shape)_\d+(?:_\d+)?)\s*\([^)]*\)\s*\{([^}]*)\}")
_TRANSLATION_PATTERN = re.compile(r"Q\s*:\s*\"[^\"]*t\(([^)]+)\)", re.IGNORECASE)
_SHAPE_PATTERN = re.compile(r"shape\s*:\s*([A-Za-z_][\w]*)", re.IGNORECASE)
_SIZE_PATTERN = re.compile(r"size\s*:\s*\[([^\]]+)\]", re.IGNORECASE)
_COLOR_PATTERN = re.compile(r"color\s*:\s*\[([^\]]+)\]", re.IGNORECASE)
_MESH_PATTERN = re.compile(r"mesh\s*:\s*\"([^\"]+)\"", re.IGNORECASE)


def _parse_float_list(raw: str) -> List[float]:
    parts = [p for p in raw.replace(",", " ").split() if p]
    return [float(p) for p in parts]


def _parse_float_triplet(raw: str) -> Tuple[float, float, float]:
    nums = _parse_float_list(raw)
    if len(nums) < 3:
        raise ValueError(f"Expected at least 3 floats, got: {raw}")
    return nums[0], nums[1], nums[2]


def _normalize_shape(shape: str) -> str:
    s = shape.lower()
    if s in {"ssbox", "box"}:
        return "box"
    if s == "cylinder":
        return "cylinder"
    if s == "mesh":
        return "mesh"
    return s


def _to_size_signature(shape: str, raw_size: List[float]) -> List[float]:
    if not raw_size:
        return []

    if shape == "box":
        if len(raw_size) >= 3:
            return [raw_size[0], raw_size[1], raw_size[2]]
        return raw_size

    if shape == "cylinder":
        if len(raw_size) >= 2:
            h, r = raw_size[0], raw_size[1]
            d = 2.0 * r
            return [d, d, h]
        return raw_size

    if len(raw_size) >= 3:
        return [raw_size[0], raw_size[1], raw_size[2]]
    return raw_size


def _is_near(a: float, b: float, eps: float = 1e-6) -> bool:
    return abs(a - b) <= eps


def _classify_object_type(shape: str, logical_id_hint: str, size_signature: List[float], mesh_path: str) -> str:
    # FMB shape pattern: shape_N_M or shape_N (preserve for named scenes)
    if logical_id_hint:
        lid_l = (logical_id_hint or "").lower()
        m = re.search(r"shape_(\d+)", lid_l)
        if m:
            return f"shape_{m.group(1)}"
    
    if shape == "cylinder":
        return "cylinder"

    if shape == "box":
        if len(size_signature) >= 3:
            x, y, z = size_signature[0], size_signature[1], size_signature[2]
            if _is_near(x, y) and _is_near(y, z):
                return "cube"
            if max(x, y) > 0.08:  # 阈值：长度大于 8cm 判定为长方体
                return "longrect"
        return "rectprism"

    if shape == "mesh":
        mesh_l = (mesh_path or "").lower()
        
        if "tri" in mesh_l or "prism" in mesh_l:
            return "triprism"
        return "mesh"

    return shape


def _load_scene_text(scene_path: str) -> str:
    if not os.path.exists(scene_path):
        raise FileNotFoundError(f"Scene file not found: {scene_path}")
    with open(scene_path, "r") as f:
        return f.read()


def _extract_robot_base(scene_text: str) -> Tuple[float, float, float]:
    m = _BASE_PATTERN.search(scene_text)
    if not m:
        return (0.0, 0.0, 0.0)
    return _parse_float_triplet(m.group(1))


def _extract_objects(scene_text: str) -> List[Dict]:
    objects: List[Dict] = []
    for m in _OBJECT_BLOCK_PATTERN.finditer(scene_text):
        anon_id = m.group(1)
        block = m.group(2)

        t_m = _TRANSLATION_PATTERN.search(block)
        if not t_m:
            continue
        x, y, z = _parse_float_triplet(t_m.group(1))

        shape_m = _SHAPE_PATTERN.search(block)
        if not shape_m:
            continue
        shape = _normalize_shape(shape_m.group(1))

        size_m = _SIZE_PATTERN.search(block)
        raw_size = _parse_float_list(size_m.group(1)) if size_m else []
        size_sig = _to_size_signature(shape, raw_size)

        color_m = _COLOR_PATTERN.search(block)
        color = _parse_float_list(color_m.group(1)) if color_m else []

        mesh_m = _MESH_PATTERN.search(block)
        mesh_path = mesh_m.group(1) if mesh_m else ""

        object_type = _classify_object_type(shape, anon_id, size_sig, mesh_path)
        objects.append(
            {
                "anon_id": anon_id,
                "shape": shape,
                "object_type": object_type,
                "size_signature": size_sig,
                "color_rgb": color,
                "position": [x, y, z],
            }
        )

    return objects


def build_phase0_layout_from_unnamed_g(unnamed_g_path: str) -> List[Dict]:
    scene_text = _load_scene_text(unnamed_g_path)
    base_x, base_y, _ = _extract_robot_base(scene_text)
    objects = _extract_objects(scene_text)

    grouped: Dict[str, List[Dict]] = {
        "cylinder": [],
        "cube": [],
        "rectprism": [],
        "longrect": [],
        "triprism": [],
        "mesh": [],
    }

    for obj in objects:
        ot = obj["object_type"]
        if ot not in grouped:
            grouped[ot] = []
        grouped[ot].append(obj)

    prefix_map = {
        "cylinder": "cyl",
        "cube": "cube",
        "rectprism": "rect",
        "triprism": "tri",
        "mesh": "mesh",
    }

    layout: List[Dict] = []
    for object_type, group in grouped.items():
        group.sort(
            key=lambda item: (
                math.hypot(item["position"][0] - base_x, item["position"][1] - base_y),
                item["position"][1],
                item["position"][0],
            )
        )
        prefix = prefix_map.get(object_type, object_type)
        for idx, item in enumerate(group, start=1):
            layout.append(
                {
                    "anon_id": item["anon_id"],
                    "logical_id": f"{prefix}_{idx}",
                    "shape": item["shape"],
                    "object_type": item["object_type"],
                    "size_signature": item["size_signature"],
                    "color_rgb": item["color_rgb"],
                }
            )

    layout.sort(key=lambda item: item["anon_id"])
    return layout


def split_infeasible_objects_from_reachability(
    root_dir: str,
    scene_named_g_path: str,
    layout_list: List[Dict],
) -> Dict:
    run_script = os.path.join(root_dir, "test", "reachability", "run_pick_waypoint_check.py")
    report_path = os.path.join(root_dir, "generated", "pick_waypoint_report.json")
    exe_path = os.path.join(root_dir, "bin", "pick_waypoint_check.exe")

    if not os.path.exists(run_script) or not os.path.exists(exe_path):
        return {
            "status": "skipped",
            "reason": "reachability checker unavailable",
            "infeasible_objects": {},
        }

    infeasible: Dict[str, Dict] = {}
    errors: Dict[str, Dict] = {}

    for item in layout_list:
        logical_id = item.get("logical_id")
        if not logical_id:
            continue

        cmd = [
            sys.executable,
            run_script,
            "--scene",
            scene_named_g_path,
            "--object",
            logical_id,
            "--json",
            report_path,
        ]
        proc = subprocess.run(cmd, cwd=root_dir, capture_output=True, text=True)

        if proc.returncode != 0:
            errors[logical_id] = {
                "status": "error",
                "message": "reachability checker failed",
                "returncode": proc.returncode,
            }
            continue

        if not os.path.exists(report_path):
            errors[logical_id] = {
                "status": "error",
                "message": "missing reachability report",
            }
            continue

        with open(report_path, "r") as f:
            reachability = json.load(f)

        state = (reachability.get("results", {}) or {}).get(logical_id)
        if not isinstance(state, dict):
            errors[logical_id] = {
                "status": "error",
                "message": "missing object result in report",
            }
            continue

        status = state.get("status", "unknown")
        if status != "feasible":
            infeasible[logical_id] = {
                "status": status,
                "message": state.get("message", ""),
                "pick_action": state.get("pick_action", ""),
                "object_type": state.get("object_type", ""),
            }

    status = "ok" if not errors else "partial"
    return {
        "status": status,
        "scene_path": scene_named_g_path,
        "infeasible_objects": infeasible,
        "errors": errors,
    }


def split_infeasible_objects_from_reachability_field(
    root_dir: str,
    unnamed_g_path: str,
    scene_named_g_path: str,
    layout_list: List[Dict],
    alpha: float = 0.6,
    beta: float = 0.4,
    tau_r: float = 0.45,
    seed: int = 42,
    use_komo_policy_gate: bool = True,
) -> Tuple[Dict, Dict]:
    """
    TASK-019 MVP reachability split.

    Returns:
      (infeasible_report_compatible, reachability_score_report)
    """
    score_report = compute_reachability_scores_from_unnamed_g(
        scene_path=unnamed_g_path,
        layout_list=layout_list,
        alpha=alpha,
        beta=beta,
        tau_r=tau_r,
        seed=seed,
    )

    policy_gate_report: Dict = {
        "status": "skipped",
        "reason": "disabled",
        "infeasible_objects": {},
        "errors": {},
    }
    if use_komo_policy_gate:
        policy_gate_report = split_infeasible_objects_from_reachability(
            root_dir=root_dir,
            scene_named_g_path=scene_named_g_path,
            layout_list=layout_list,
        )

    policy_infeasible = (policy_gate_report.get("infeasible_objects") or {}) if isinstance(policy_gate_report, dict) else {}
    policy_errors = (policy_gate_report.get("errors") or {}) if isinstance(policy_gate_report, dict) else {}

    infeasible: Dict[str, Dict] = {}
    objects = score_report.get("objects", []) if isinstance(score_report, dict) else []
    for row in objects:
        logical_id = row.get("logical_id")
        if not logical_id:
            continue

        if logical_id in policy_infeasible:
            row["decision"] = "infeasible"
            row["reason"] = "komo_policy_gate_infeasible"

        decision = row.get("decision", "infeasible")
        if decision != "feasible":
            infeasible[logical_id] = {
                "status": "infeasible",
                "message": row.get("reason", "score<tau_r"),
                "pick_action": "pick_touch",
                "object_type": row.get("object_type", ""),
                "reachability_score": row.get("reachability_score", None),
                "gmm_score": row.get("gmm_score", None),
                "esdf_score": row.get("esdf_score", None),
            }

    status = "ok" if not policy_errors else "partial"
    compatible_report = {
        "status": status,
        "scene_path": scene_named_g_path,
        "infeasible_objects": infeasible,
        "errors": policy_errors,
    }

    score_report["policy_gate"] = {
        "enabled": bool(use_komo_policy_gate),
        "status": policy_gate_report.get("status", "skipped") if isinstance(policy_gate_report, dict) else "skipped",
        "infeasible_count": len(policy_infeasible),
        "error_count": len(policy_errors),
        "reference": "action_pick/action_pick_cylinder constraints in manipTools.cpp",
    }
    return compatible_report, score_report
