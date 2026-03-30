#!/usr/bin/env python3
"""
Generate k-means clustering artifacts from a Phase1 target-graph.

Input (required):
- generated/phase1_target_graph*.json

Outputs:
- phase2_kmeans_clusters.json: full clustering report
- phase2_kmeans_strategy.json: Prompt1/Prompt2-compatible strategy payload
- phase2_kmeans_points.json: 2D points table for review
- phase2_kmeans_plot.svg: visualization similar to standard 2-cluster scatter plots
"""

import argparse
import json
import os
import sys
from typing import Dict, List


ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", ".."))
if ROOT_DIR not in sys.path:
    sys.path.insert(0, ROOT_DIR)

from core.graph_clustering import KMeansBranchClustering


def _normalize_points(points: List[Dict], width: int, height: int, pad: int = 48):
    xs = [p["x_2d"] for p in points]
    ys = [p["y_2d"] for p in points]
    min_x, max_x = min(xs), max(xs)
    min_y, max_y = min(ys), max(ys)

    x_span = max(max_x - min_x, 1e-9)
    y_span = max(max_y - min_y, 1e-9)

    out = []
    for p in points:
        nx = pad + (p["x_2d"] - min_x) / x_span * (width - 2 * pad)
        ny = height - pad - (p["y_2d"] - min_y) / y_span * (height - 2 * pad)
        q = dict(p)
        q["svg_x"] = float(nx)
        q["svg_y"] = float(ny)
        out.append(q)
    return out


def _write_svg(points: List[Dict], path: str, width: int = 1200, height: int = 700):
    points = _normalize_points(points, width=width, height=height)
    colors = {
        0: "#1e88e5",
        1: "#f4b400",
        2: "#0f9d58",
        3: "#8e24aa",
    }

    lines = [
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" viewBox="0 0 {width} {height}">',
        '<rect x="0" y="0" width="100%" height="100%" fill="#f6f6f6"/>',
        '<text x="600" y="44" text-anchor="middle" font-size="34" fill="#333">k-means clustering on Phase1 target-graph (k=2)</text>',
        '<line x1="170" y1="100" x2="170" y2="620" stroke="#222" stroke-width="4"/>',
        '<line x1="170" y1="620" x2="1020" y2="620" stroke="#222" stroke-width="4"/>',
        '<text x="120" y="360" text-anchor="middle" font-size="28" fill="#444">Y-axis</text>',
        '<text x="610" y="680" text-anchor="middle" font-size="34" fill="#444">X-axis</text>',
    ]

    for p in points:
        cluster_id = int(p["cluster_id"])
        color = colors.get(cluster_id, "#666")
        x = p["svg_x"]
        y = p["svg_y"]
        node_id = p["node_id"]
        lines.append(f'<circle cx="{x:.2f}" cy="{y:.2f}" r="18" fill="{color}" stroke="#666" stroke-width="1.5"/>')
        lines.append(f'<text x="{x + 22:.2f}" y="{y - 16:.2f}" font-size="16" fill="#333">id={node_id}, c={cluster_id}</text>')

    lines.append('<rect x="1010" y="110" width="160" height="90" rx="8" fill="#ffffff" stroke="#ddd"/>')
    lines.append('<circle cx="1035" cy="140" r="10" fill="#1e88e5"/>')
    lines.append('<text x="1055" y="146" font-size="16" fill="#333">Cluster 0</text>')
    lines.append('<circle cx="1035" cy="172" r="10" fill="#f4b400"/>')
    lines.append('<text x="1055" y="178" font-size="16" fill="#333">Cluster 1</text>')

    lines.append("</svg>")

    with open(path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))


def main():
    parser = argparse.ArgumentParser(description="Visualize k-means clustering on Phase1 target-graph.")
    parser.add_argument("--input", default=os.path.join(ROOT_DIR, "generated", "phase1_target_graph.json"))
    parser.add_argument("--out-clusters", default=os.path.join(ROOT_DIR, "generated", "phase2_kmeans_clusters.json"))
    parser.add_argument("--out-strategy", default=os.path.join(ROOT_DIR, "generated", "phase2_kmeans_strategy.json"))
    parser.add_argument("--out-points", default=os.path.join(ROOT_DIR, "generated", "phase2_kmeans_points.json"))
    parser.add_argument("--out-plot", default=os.path.join(ROOT_DIR, "generated", "phase2_kmeans_plot.svg"))
    parser.add_argument("--k", type=int, default=2)
    parser.add_argument("--seed", type=int, default=7)
    args = parser.parse_args()

    with open(args.input, "r", encoding="utf-8") as f:
        phase1_json = json.load(f)

    clustering = KMeansBranchClustering(phase1_json, k=args.k, seed=args.seed, max_batch_size=2)
    report = clustering.generate_cluster_report()
    p1_out, p2_out = clustering.generate_optimal_strategy()

    os.makedirs(os.path.dirname(args.out_clusters), exist_ok=True)

    with open(args.out_clusters, "w", encoding="utf-8") as f:
        json.dump(report, f, indent=2, ensure_ascii=True)

    with open(args.out_strategy, "w", encoding="utf-8") as f:
        json.dump({"prompt1": p1_out, "prompt2": p2_out}, f, indent=2, ensure_ascii=True)

    with open(args.out_points, "w", encoding="utf-8") as f:
        json.dump(report["nodes"], f, indent=2, ensure_ascii=True)

    _write_svg(report["nodes"], args.out_plot)

    print("[KMEANS_VIS] input:", args.input)
    print("[KMEANS_VIS] clusters:", args.out_clusters)
    print("[KMEANS_VIS] strategy:", args.out_strategy)
    print("[KMEANS_VIS] points:", args.out_points)
    print("[KMEANS_VIS] plot:", args.out_plot)


if __name__ == "__main__":
    main()
