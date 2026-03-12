#!/usr/bin/env python3
import json
import os
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if ROOT not in sys.path:
    sys.path.insert(0, ROOT)

from pipelines.run_phase2 import run_phase2_pipeline


def main():
    phase1_path = os.path.join(ROOT, "generated", "phase1_target_graph_img1_retry_marked.json")
    scene_path = os.path.join(ROOT, "generated", "scene", "scene_named.g")

    if not os.path.exists(phase1_path):
        raise FileNotFoundError(f"Missing phase1 json: {phase1_path}")

    phase1_json = json.load(open(phase1_path, "r", encoding="utf-8"))

    success, output_g, _, summary, _, stdout = run_phase2_pipeline(
        node_data={"node_id": 1},
        current_g_path=scene_path,
        full_target_graph=phase1_json,
        inventory_data=[],
        history_chain=[],
        stop_before_solver=True,
    )

    print("[TEST] success:", success)
    print("[TEST] output_g:", output_g)
    print("[TEST] summary:", json.dumps(summary, indent=2, ensure_ascii=True))
    print("[TEST] stdout:\n", stdout)


if __name__ == "__main__":
    main()
