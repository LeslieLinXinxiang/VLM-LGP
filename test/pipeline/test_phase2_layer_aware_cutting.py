#!/usr/bin/env python3
import argparse
import json
import os
import sys


ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
if ROOT_DIR not in sys.path:
    sys.path.insert(0, ROOT_DIR)

from core.graph_clustering import (
    BranchAwareClustering,
    BranchAwareLayerCuttingClustering,
)


EXPECTED_LEGACY_BATCHES = [[1], [2], [3, 4], [5, 6], [7], [8], [9]]
EXPECTED_BRANCH_GROUPS = [
    {"branch": "left", "nodes": [1, 3, 4]},
    {"branch": "right", "nodes": [2, 5, 6]},
    {"branch": "bridge", "nodes": [7, 8, 9]},
]
EXPECTED_LAYER_CUT_BATCHES = [[1], [3, 4], [2], [5, 6], [7], [8], [9]]


def main():
    parser = argparse.ArgumentParser(
        description="Minimal standalone test for branch grouping + layer-aware cutting."
    )
    parser.add_argument(
        "--input",
        default=os.path.join(ROOT_DIR, "generated", "phase1_target_graph.json"),
        help="Path to the Phase1 target graph JSON.",
    )
    args = parser.parse_args()

    with open(args.input, "r", encoding="utf-8") as f:
        phase1_json = json.load(f)

    legacy = BranchAwareClustering(phase1_json)
    legacy_p1_out, _ = legacy.generate_optimal_strategy()
    legacy_batches = legacy_p1_out["strategies"][0]["batches"]

    two_stage = BranchAwareLayerCuttingClustering(phase1_json)
    report = two_stage.generate_decomposition_report()
    p1_out, p2_out = two_stage.generate_optimal_strategy()

    print(f"[TEST] Input path: {args.input}")
    print("[TEST] Legacy batches:")
    print(json.dumps(legacy_batches, indent=2, ensure_ascii=True))
    print("[TEST] Two-stage decomposition report:")
    print(json.dumps(report, indent=2, ensure_ascii=True))
    print("[TEST] Two-stage strategy output:")
    print(json.dumps({"prompt1": p1_out, "prompt2": p2_out}, indent=2, ensure_ascii=True))

    assert legacy_batches == EXPECTED_LEGACY_BATCHES, (
        "Legacy batching output changed unexpectedly: "
        f"{legacy_batches} != {EXPECTED_LEGACY_BATCHES}"
    )
    assert report["branch_groups"] == EXPECTED_BRANCH_GROUPS, (
        "Branch grouping does not match expected groups: "
        f"{report['branch_groups']} != {EXPECTED_BRANCH_GROUPS}"
    )
    assert report["global_batches"] == EXPECTED_LAYER_CUT_BATCHES, (
        "Layer-aware cutting does not match expected execution sequence: "
        f"{report['global_batches']} != {EXPECTED_LAYER_CUT_BATCHES}"
    )
    assert p1_out["strategies"][0]["batches"] == EXPECTED_LAYER_CUT_BATCHES, (
        "Two-stage strategy output batches do not match expected execution sequence: "
        f"{p1_out['strategies'][0]['batches']} != {EXPECTED_LAYER_CUT_BATCHES}"
    )
    assert p1_out["strategies"][0]["order"] == [1, 3, 4, 2, 5, 6, 7, 8, 9], (
        "Two-stage strategy order is not aligned with flattened batches."
    )
    assert p2_out["selected"] == "strategy_1_branch_layer_cutting", (
        "Two-stage selected strategy id is not the expected default id."
    )

    print("[TEST] PASS: layer-aware cutting matches the expected two-stage sequence.")


if __name__ == "__main__":
    main()
