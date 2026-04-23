#!/usr/bin/env python3
"""
Isolated tests for graph clustering algorithms (TASK-020).

Why this file exists:
- This test is intentionally separated from pipeline tests.
- It validates clustering behavior using only target-graph input.

Test goals:
1) Determinism: same input + same seed => same cluster assignment.
2) Dependency safety: generated batches satisfy supporter precedence.
3) Artifact generation: clustering report and strategy files are generated.
"""

import argparse
import json
import os
import sys


ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
if ROOT_DIR not in sys.path:
    sys.path.insert(0, ROOT_DIR)

from core.graph_clustering import KMeansBranchClustering


def _read_json(path):
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)


def _assert_dependency_safe(phase1_json, batches):
    node_to_batch = {}
    for idx, batch in enumerate(batches):
        for node_id in batch:
            node_to_batch[node_id] = idx

    for obj in phase1_json.get("objects", []):
        node_id = obj.get("id")
        if not isinstance(node_id, int) or node_id == 0:
            continue
        edges = obj.get("edges", [])
        for edge in edges:
            supporter = edge.get("supporter")
            if supporter == 0:
                continue
            assert supporter in node_to_batch, f"supporter {supporter} missing from batches"
            assert node_id in node_to_batch, f"node {node_id} missing from batches"
            assert node_to_batch[supporter] <= node_to_batch[node_id], (
                f"dependency violation: supporter {supporter} placed after node {node_id}"
            )


def main():
    parser = argparse.ArgumentParser(description="Isolated test for k-means graph clustering.")
    parser.add_argument(
        "--input",
        default=os.path.join(ROOT_DIR, "generated", "phase1_target_graph.json"),
        help="Path to Phase1 target-graph JSON.",
    )
    parser.add_argument(
        "--out-dir",
        default=os.path.join(ROOT_DIR, "generated", "kmeans_test_artifacts"),
        help="Directory for test artifacts.",
    )
    args = parser.parse_args()

    phase1_json = _read_json(args.input)

    c1 = KMeansBranchClustering(phase1_json, k=2, seed=7, max_batch_size=2)
    c2 = KMeansBranchClustering(phase1_json, k=2, seed=7, max_batch_size=2)

    r1 = c1.generate_cluster_report()
    r2 = c2.generate_cluster_report()

    assign1 = [(n["node_id"], n["cluster_id"]) for n in r1["nodes"]]
    assign2 = [(n["node_id"], n["cluster_id"]) for n in r2["nodes"]]
    assert assign1 == assign2, "cluster assignment is not deterministic under fixed seed"

    cluster_ids = sorted({n["cluster_id"] for n in r1["nodes"]})
    assert len(cluster_ids) == 2, f"expected 2 clusters, got {cluster_ids}"

    _assert_dependency_safe(phase1_json, r1["global_batches"])

    p1, p2 = c1.generate_optimal_strategy()
    assert "strategies" in p1 and len(p1["strategies"]) == 1, "invalid prompt1 strategy schema"
    assert p2.get("selected") == "strategy_1_kmeans_branch", "unexpected selected strategy id"

    os.makedirs(args.out_dir, exist_ok=True)
    out_report = os.path.join(args.out_dir, "phase2_kmeans_clusters.json")
    out_strategy = os.path.join(args.out_dir, "phase2_kmeans_strategy.json")
    with open(out_report, "w", encoding="utf-8") as f:
        json.dump(r1, f, indent=2, ensure_ascii=True)
    with open(out_strategy, "w", encoding="utf-8") as f:
        json.dump({"prompt1": p1, "prompt2": p2}, f, indent=2, ensure_ascii=True)

    print("[TEST] PASS: isolated k-means clustering is deterministic and dependency-safe.")
    print("[TEST] report:", out_report)
    print("[TEST] strategy:", out_strategy)


if __name__ == "__main__":
    main()
