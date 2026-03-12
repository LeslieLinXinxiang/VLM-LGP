import json
import os
import re
from typing import Dict, List, Optional, Set


def _real_object_ids(phase1_json: Dict) -> List[int]:
    objs = phase1_json.get("objects", [])
    return sorted([o.get("id") for o in objs if isinstance(o, dict) and isinstance(o.get("id"), int) and o.get("id") >= 1])


def _id_to_edges(phase1_json: Dict) -> Dict[int, List[Dict]]:
    m = {}
    for obj in phase1_json.get("objects", []):
        if not isinstance(obj, dict):
            continue
        oid = obj.get("id")
        if not isinstance(oid, int) or oid < 1:
            continue
        edges = obj.get("edges", [])
        if isinstance(edges, list):
            m[oid] = [e for e in edges if isinstance(e, dict) and isinstance(e.get("supporter"), int)]
        else:
            m[oid] = []
    return m


def _collect_place_frames(scene_g_path: Optional[str]) -> Set[str]:
    if not scene_g_path or not os.path.exists(scene_g_path):
        return set()

    frames = set()
    pattern = re.compile(r"^\s*([A-Za-z_][\w]*)\s*\(")
    with open(scene_g_path, "r", encoding="utf-8") as f:
        for line in f:
            m = pattern.match(line)
            if m:
                frames.add(m.group(1))
    return frames


def _flatten_batches(batches: List[List[int]]) -> List[int]:
    out = []
    for b in batches:
        if isinstance(b, list):
            out.extend(b)
    return out


def _evaluate_strategy(strategy: Dict, phase1_json: Dict, place_frames: Set[str]) -> Dict:
    errors = []
    sid = strategy.get("id", "?")
    order = strategy.get("order", [])
    batches = strategy.get("batches", [])

    expected_ids = _real_object_ids(phase1_json)
    expected_set = set(expected_ids)

    if not isinstance(order, list) or not all(isinstance(x, int) for x in order):
        errors.append("order must be int array")
        order = []

    if set(order) != expected_set:
        errors.append(f"order ids mismatch: expected={sorted(expected_set)} got={sorted(set(order))}")
    if len(order) != len(set(order)):
        errors.append("order contains duplicate object ids")

    if not isinstance(batches, list):
        errors.append("batches must be array")
        batches = []

    for i, b in enumerate(batches, start=1):
        if not isinstance(b, list) or not all(isinstance(x, int) for x in b):
            errors.append(f"batch[{i}] must be int array")
            continue
        if len(b) == 0 or len(b) > 2:
            errors.append(f"batch[{i}] size must be 1..2")

    flat = _flatten_batches(batches)
    if flat != order:
        errors.append("batches flatten sequence must exactly equal order")

    idx = {oid: i for i, oid in enumerate(order)}
    edge_map = _id_to_edges(phase1_json)

    for oid in expected_ids:
        edges = edge_map.get(oid, [])
        if not edges:
            errors.append(f"object {oid} has empty edges")
            continue

        if oid not in idx:
            continue

        for edge in edges:
            sup = edge.get("supporter")
            if sup is None:
                errors.append(f"object {oid} edge supporter missing")
                continue
            if sup < 0:
                errors.append(f"object {oid} supporter {sup} invalid")
                continue

            # Dependency check (supporter object must appear earlier than child)
            if sup != 0:
                if sup not in idx:
                    errors.append(f"object {oid} supporter {sup} not in order")
                elif idx[sup] >= idx[oid]:
                    errors.append(f"dependency violated: supporter {sup} must be before {oid}")

            # Position slot sanity check when position exists
            pos = edge.get("position")
            if isinstance(pos, str) and pos.lower() in ("left", "right"):
                pos_u = pos.capitalize()
                if sup == 0:
                    expected_slot = f"Table_{pos_u}"
                else:
                    expected_slot = f"Rect_{sup}_{pos_u}"

                if place_frames and expected_slot not in place_frames:
                    errors.append(f"missing place frame in scene: {expected_slot}")

    return {"id": sid, "passed": len(errors) == 0, "errors": errors}


def validate_phase2_selection(
    phase1_json: Dict,
    prompt1_output: Dict,
    prompt2_output: Dict,
    scene_g_path: Optional[str] = None,
) -> Dict:
    strategies = prompt1_output.get("strategies", prompt1_output.get("candidates", []))
    selected = prompt2_output.get("selected")

    place_frames = _collect_place_frames(scene_g_path)

    reports = []
    by_id = {}
    for s in strategies:
        if not isinstance(s, dict):
            continue
        r = _evaluate_strategy(s, phase1_json, place_frames)
        reports.append(r)
        by_id[r["id"]] = r

    errors = []
    if selected not in by_id:
        errors.append(f"selected strategy not found: {selected}")
        passed = False
    else:
        if by_id[selected]["passed"]:
            passed = True
        else:
            passed = False
            errors.extend([f"selected({selected}): {e}" for e in by_id[selected]["errors"]])

    all_failed = len(reports) > 0 and all(not r["passed"] for r in reports)

    return {
        "passed": passed,
        "selected": selected,
        "errors": errors,
        "all_failed": all_failed,
        "strategy_reports": reports,
    }


def save_gate_report(path: str, report: Dict) -> None:
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        json.dump(report, f, indent=2, ensure_ascii=True)
