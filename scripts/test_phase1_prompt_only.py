#!/usr/bin/env python3
import argparse
import json
from functools import lru_cache
from pathlib import Path

from core.vlm import VLMClient


def analyze_graph(plan: dict) -> dict:
    objects = plan.get("objects", []) if isinstance(plan, dict) else []
    obj_by_id = {o.get("id"): o for o in objects if isinstance(o, dict)}

    checks = {
        "has_objects_key": isinstance(plan, dict) and "objects" in plan,
        "object_count": len(objects),
        "has_table_id_0": 0 in obj_by_id and str(obj_by_id[0].get("object", "")).lower() == "table",
        "all_non_table_have_edges": True,
        "all_supporters_exist_and_lower": True,
        "table_supported_count": 0,
        "multi_support_nodes": 0,
        "no_position_in_multi_support_edges": True,
        "inferred_layers_ok": True,
    }

    for oid, obj in obj_by_id.items():
        if oid == 0:
            continue

        edges = obj.get("edges", [])
        if not isinstance(edges, list) or len(edges) == 0:
            checks["all_non_table_have_edges"] = False
            continue

        if len(edges) > 1:
            checks["multi_support_nodes"] += 1

        for edge in edges:
            sid = edge.get("supporter")
            if sid == 0:
                checks["table_supported_count"] += 1

            if sid not in obj_by_id or (isinstance(sid, int) and sid >= oid):
                checks["all_supporters_exist_and_lower"] = False

            if len(edges) > 1 and "position" in edge:
                checks["no_position_in_multi_support_edges"] = False

    @lru_cache(None)
    def depth(oid: int) -> int:
        if oid == 0:
            return 0

        obj = obj_by_id.get(oid, {})
        edges = obj.get("edges", []) if isinstance(obj, dict) else []
        if not edges:
            return 0

        parents = [e.get("supporter") for e in edges if isinstance(e.get("supporter"), int)]
        parents = [p for p in parents if p in obj_by_id]
        if not parents:
            return 0

        return 1 + max(depth(p) for p in parents)

    layers = {}
    try:
        for oid in sorted(k for k in obj_by_id if isinstance(k, int)):
            layers[str(oid)] = depth(oid)
    except RecursionError:
        checks["inferred_layers_ok"] = False

    return {"checks": checks, "layers": layers}


def main() -> int:
    parser = argparse.ArgumentParser(description="Standalone Phase1 prompt-only test")
    parser.add_argument("--image", required=True, help="Input image path")
    parser.add_argument("--prompt", required=True, help="Prompt markdown path")
    parser.add_argument("--out-json", required=True, help="Output JSON path")
    parser.add_argument("--out-report", required=True, help="Output report path")
    args = parser.parse_args()

    out_json = Path(args.out_json)
    out_report = Path(args.out_report)
    out_json.parent.mkdir(parents=True, exist_ok=True)
    out_report.parent.mkdir(parents=True, exist_ok=True)

    plan = VLMClient().generate_assembly_plan(args.image, args.prompt)
    out_json.write_text(json.dumps(plan, indent=2, ensure_ascii=False), encoding="utf-8")

    analysis = analyze_graph(plan)
    report = {
        "image": args.image,
        "prompt": args.prompt,
        "checks": analysis["checks"],
        "layers": analysis["layers"],
    }
    out_report.write_text(json.dumps(report, indent=2, ensure_ascii=False), encoding="utf-8")

    print("[PROMPT_ONLY_TEST] output_json=", out_json)
    print("[PROMPT_ONLY_TEST] output_report=", out_report)
    print("[PROMPT_ONLY_TEST] checks=", json.dumps(analysis["checks"], ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
