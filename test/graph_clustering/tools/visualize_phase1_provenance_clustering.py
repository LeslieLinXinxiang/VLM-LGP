#!/usr/bin/env python3
"""
Experimental branch clustering by provenance-set logic (independent completion view).

Core idea:
- Build support DAG G=(V,E), where u->v means u supports v.
- Let R be base roots (direct children of table node 0).
- For each node v, provenance set P(v) = {r in R | r reaches v}.
- Cluster rule:
  * |P(v)| == 1 : assign to that unique root branch cluster
  * |P(v)|  > 1 : assign to merge/bridge cluster

This script writes JSON artifacts and an SVG visualization for quick review.
"""

import argparse
import json
import os
from collections import defaultdict, deque
from typing import Dict, List, Set, Tuple


ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", ".."))


def _load_graph(phase1_json: Dict) -> Tuple[List[int], Dict[int, List[int]], Dict[int, List[int]], Dict[Tuple[int, int], str]]:
    objs = phase1_json.get("objects", [])
    node_ids = []
    supporters: Dict[int, List[int]] = defaultdict(list)
    children: Dict[int, List[int]] = defaultdict(list)
    pos_map: Dict[Tuple[int, int], str] = {}

    for obj in objs:
        node_id = obj.get("id")
        if not isinstance(node_id, int):
            continue
        node_ids.append(node_id)
        for edge in obj.get("edges", []):
            sup = edge.get("supporter")
            if isinstance(sup, int):
                supporters[node_id].append(sup)
                children[sup].append(node_id)
                if isinstance(edge.get("position"), str):
                    pos_map[(sup, node_id)] = edge["position"]

    node_ids = sorted(set(node_ids))
    return node_ids, supporters, children, pos_map


def _compute_layers(node_ids: List[int], supporters: Dict[int, List[int]]) -> Dict[int, int]:
    layers = {node_id: -1 for node_id in node_ids}
    if 0 in layers:
        layers[0] = 0

    changed = True
    while changed:
        changed = False
        for node_id in node_ids:
            if node_id == 0 or layers[node_id] != -1:
                continue
            preds = supporters.get(node_id, [])
            if not preds:
                layers[node_id] = 0
                changed = True
                continue
            if all(layers.get(pred, -1) != -1 for pred in preds):
                layers[node_id] = 1 + max(layers[pred] for pred in preds)
                changed = True

    for node_id in node_ids:
        if layers[node_id] == -1:
            layers[node_id] = 0
    return layers


def _compute_provenance(node_ids: List[int], supporters: Dict[int, List[int]]) -> Tuple[List[int], Dict[int, Set[int]]]:
    roots = sorted([node_id for node_id in node_ids if node_id != 0 and 0 in supporters.get(node_id, [])])
    prov: Dict[int, Set[int]] = {node_id: set() for node_id in node_ids}
    for root in roots:
        prov[root].add(root)

    changed = True
    while changed:
        changed = False
        for node_id in node_ids:
            if node_id == 0:
                continue
            preds = [p for p in supporters.get(node_id, []) if p != 0]
            if not preds:
                continue
            new_set: Set[int] = set()
            for pred in preds:
                new_set |= prov.get(pred, set())
            if new_set and new_set != prov[node_id]:
                prov[node_id] = new_set
                changed = True

    return roots, prov


def _find_connected_components(nodes: List[int], supporters: Dict[int, List[int]], children: Dict[int, List[int]]) -> List[List[int]]:
    node_set = set(nodes)
    seen = set()
    comps: List[List[int]] = []

    for start in sorted(nodes):
        if start in seen:
            continue
        q = deque([start])
        seen.add(start)
        comp = []
        while q:
            u = q.popleft()
            comp.append(u)
            neigh = []
            neigh.extend([v for v in supporters.get(u, []) if v in node_set])
            neigh.extend([v for v in children.get(u, []) if v in node_set])
            for v in neigh:
                if v not in seen:
                    seen.add(v)
                    q.append(v)
        comps.append(sorted(comp))

    return comps


def _assign_clusters(
    node_ids: List[int],
    roots: List[int],
    prov: Dict[int, Set[int]],
    supporters: Dict[int, List[int]],
    children: Dict[int, List[int]],
    split_disconnected: bool = True,
) -> Tuple[Dict[int, int], Dict[int, str], Dict[str, List[int]]]:
    signature_groups: Dict[str, List[int]] = defaultdict(list)
    for node_id in node_ids:
        if node_id == 0:
            continue
        sig = tuple(sorted(prov.get(node_id, set())))
        key = "sig:" + ",".join(str(x) for x in sig)
        signature_groups[key].append(node_id)

    cluster_nodes: Dict[str, List[int]] = {}
    for sig_key, nodes in sorted(signature_groups.items(), key=lambda kv: kv[0]):
        if split_disconnected:
            comps = _find_connected_components(nodes, supporters, children)
            if len(comps) == 1:
                cluster_nodes[sig_key] = comps[0]
            else:
                for idx, comp in enumerate(comps):
                    cluster_nodes[f"{sig_key}#cc{idx}"] = comp
        else:
            cluster_nodes[sig_key] = sorted(nodes)

    cluster_key_to_id: Dict[str, int] = {}
    id_to_name: Dict[int, str] = {}
    for idx, key in enumerate(sorted(cluster_nodes.keys())):
        cluster_key_to_id[key] = idx
        id_to_name[idx] = key

    node_cluster: Dict[int, int] = {}
    for key, nodes in cluster_nodes.items():
        cid = cluster_key_to_id[key]
        for node_id in nodes:
            node_cluster[node_id] = cid

    return node_cluster, id_to_name, {key: sorted(nodes) for key, nodes in cluster_nodes.items()}


def _frontier(nodes_in_cluster: Set[int], supporters: Dict[int, List[int]]) -> List[int]:
    f = []
    for node_id in sorted(nodes_in_cluster):
        preds = [p for p in supporters.get(node_id, []) if p != 0]
        if any(pred not in nodes_in_cluster for pred in preds):
            f.append(node_id)
    return f


def _compute_independence_report(cluster_nodes: Dict[int, List[int]], supporters: Dict[int, List[int]]) -> Dict[str, Dict]:
    report = {}
    for cluster_id, nodes in sorted(cluster_nodes.items(), key=lambda kv: kv[0]):
        s = set(nodes)
        frontier = _frontier(s, supporters)
        interior = [n for n in sorted(nodes) if n not in set(frontier)]
        interior_ok = True
        violations = []
        for node_id in interior:
            preds = [p for p in supporters.get(node_id, []) if p != 0]
            ext = [p for p in preds if p not in s]
            if ext:
                interior_ok = False
                violations.append({"node_id": node_id, "external_predecessors": ext})

        report[str(cluster_id)] = {
            "frontier": frontier,
            "interior": interior,
            "independent_completion": interior_ok,
            "violations": violations,
        }
    return report


def _layout_points(
    node_ids: List[int],
    layers: Dict[int, int],
    cluster_of: Dict[int, int],
    max_cluster_id: int,
    cluster_gap_x: float,
    layer_gap_y: float,
    intra_cluster_gap_x: float,
    include_ground: bool,
) -> Dict[int, Tuple[float, float]]:
    points: Dict[int, Tuple[float, float]] = {}
    by_group: Dict[Tuple[int, int], List[int]] = defaultdict(list)
    for node_id in node_ids:
        if node_id == 0:
            continue
        by_group[(cluster_of[node_id], layers[node_id])].append(node_id)

    for (cluster_id, layer), bucket in by_group.items():
        bucket = sorted(bucket)
        for rank, node_id in enumerate(bucket):
            x = float(cluster_id * cluster_gap_x + rank * intra_cluster_gap_x)
            y = float(layer * layer_gap_y)
            points[node_id] = (x, y)

    if include_ground:
        points[0] = (float(max_cluster_id * (cluster_gap_x / 2.0)), 0.0)
    return points


def _write_svg(
    points: Dict[int, Tuple[float, float]],
    cluster_of: Dict[int, int],
    out_svg: str,
    width: int,
    height: int,
    pad: int,
    fit_margin_ratio: float,
    y_axis_label_offset: int,
):
    if not points:
        raise ValueError("No points to render.")

    fit_points = [(nid, xy) for nid, xy in points.items() if nid != 0]
    if not fit_points:
        fit_points = list(points.items())

    xs = [xy[0] for _, xy in fit_points]
    ys = [xy[1] for _, xy in fit_points]
    min_x, max_x = min(xs), max(xs)
    min_y, max_y = min(ys), max(ys)

    base_x_span = max(max_x - min_x, 1e-9)
    base_y_span = max(max_y - min_y, 1e-9)
    min_x -= base_x_span * fit_margin_ratio
    max_x += base_x_span * fit_margin_ratio
    min_y -= base_y_span * fit_margin_ratio
    max_y += base_y_span * fit_margin_ratio

    x_span = max(max_x - min_x, 1e-9)
    y_span = max(max_y - min_y, 1e-9)

    def sx(x):
        return pad + (x - min_x) / x_span * (width - 2 * pad)

    def sy(y):
        return height - pad - (y - min_y) / y_span * (height - 2 * pad)

    colors = {
        0: "#2f7ed8",
        1: "#4caf50",
        2: "#c97d8d",
        3: "#f4b400",
        4: "#8e44ad",
        5: "#17a2b8",
    }

    lines = [
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" viewBox="0 0 {width} {height}">',
        '<rect x="0" y="0" width="100%" height="100%" fill="#f5f5f7"/>',
        f'<text x="{width/2:.1f}" y="46" text-anchor="middle" font-size="34" fill="#222">Provenance-set Branch Clustering (independent completion)</text>',
        f'<line x1="{pad:.1f}" y1="{pad:.1f}" x2="{pad:.1f}" y2="{height-pad:.1f}" stroke="#222" stroke-width="4"/>',
        f'<line x1="{pad:.1f}" y1="{height-pad:.1f}" x2="{width-pad:.1f}" y2="{height-pad:.1f}" stroke="#222" stroke-width="4"/>',
        f'<text x="{pad-y_axis_label_offset:.1f}" y="{height/2:.1f}" font-size="26" fill="#444">Y-axis</text>',
        f'<text x="{width/2:.1f}" y="{height-18:.1f}" font-size="30" fill="#444" text-anchor="middle">X-axis</text>',
    ]

    for node_id in sorted(points):
        x, y = points[node_id]
        cx, cy = sx(x), sy(y)
        cid = cluster_of.get(node_id, -1)
        color = "#777" if node_id == 0 else colors.get(cid % 6, "#777")
        radius = 22 if node_id == 0 else 20
        lines.append(f'<circle cx="{cx:.2f}" cy="{cy:.2f}" r="{radius}" fill="{color}" stroke="#333" stroke-width="2"/>')
        lines.append(f'<text x="{cx:.2f}" y="{cy+6:.2f}" text-anchor="middle" font-size="22" fill="#111">{node_id}</text>')

    lines.append('</svg>')
    with open(out_svg, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))


def main():
    parser = argparse.ArgumentParser(description="Visualize provenance-set branch clustering.")
    parser.add_argument("--input", default=os.path.join(ROOT_DIR, "generated", "phase1_target_graph.json"))
    parser.add_argument("--out-json", default=os.path.join(ROOT_DIR, "generated", "phase2_provenance_clusters.json"))
    parser.add_argument("--out-svg", default=os.path.join(ROOT_DIR, "generated", "phase2_provenance_plot.svg"))
    parser.add_argument("--cluster-gap-x", type=float, default=5.5)
    parser.add_argument("--layer-gap-y", type=float, default=2.4)
    parser.add_argument("--intra-cluster-gap-x", type=float, default=1.0)
    parser.add_argument("--include-ground", action="store_true")
    parser.add_argument("--canvas-width", type=int, default=1400)
    parser.add_argument("--canvas-height", type=int, default=860)
    parser.add_argument("--canvas-pad", type=int, default=90)
    parser.add_argument("--fit-margin-ratio", type=float, default=0.12)
    parser.add_argument("--y-axis-label-offset", type=int, default=70)
    parser.add_argument("--split-disconnected", action="store_true")
    args = parser.parse_args()

    with open(args.input, "r", encoding="utf-8") as f:
        phase1 = json.load(f)

    node_ids, supporters, children, pos_map = _load_graph(phase1)
    layers = _compute_layers(node_ids, supporters)
    roots, prov = _compute_provenance(node_ids, supporters)
    node_cluster, cluster_names, cluster_key_nodes = _assign_clusters(
        node_ids=node_ids,
        roots=roots,
        prov=prov,
        supporters=supporters,
        children=children,
        split_disconnected=args.split_disconnected,
    )

    cluster_nodes: Dict[int, List[int]] = defaultdict(list)
    for node_id, cid in sorted(node_cluster.items()):
        cluster_nodes[cid].append(node_id)

    indep_report = _compute_independence_report(cluster_nodes, supporters)
    points = _layout_points(
        node_ids=node_ids,
        layers=layers,
        cluster_of=node_cluster,
        max_cluster_id=max(cluster_names.keys()) if cluster_names else 0,
        cluster_gap_x=args.cluster_gap_x,
        layer_gap_y=args.layer_gap_y,
        intra_cluster_gap_x=args.intra_cluster_gap_x,
        include_ground=args.include_ground,
    )

    payload = {
        "meta": {
            "algorithm": "ProvenanceSetBranchClustering",
            "definition": "Cluster by provenance-set cardinality and root identity",
            "roots": roots,
            "k_selected": len(cluster_nodes),
            "k_selection_mode": "variable (derived from provenance signatures)",
            "cluster_names": {str(k): v for k, v in sorted(cluster_names.items())},
            "cluster_key_nodes": {k: v for k, v in sorted(cluster_key_nodes.items(), key=lambda kv: kv[0])},
            "ground_node_excluded_from_clustering": True,
        },
        "clusters": [
            {
                "cluster_id": int(cid),
                "cluster_name": cluster_names.get(cid, "unknown"),
                "nodes": sorted(nodes),
            }
            for cid, nodes in sorted(cluster_nodes.items(), key=lambda kv: kv[0])
        ],
        "nodes": [
            {
                "node_id": int(node_id),
                "layer": int(layers.get(node_id, 0)),
                "cluster_id": int(node_cluster.get(node_id, -1)),
                "provenance_set": sorted(list(prov.get(node_id, set()))),
                "x": float(points[node_id][0]),
                "y": float(points[node_id][1]),
            }
            for node_id in sorted(node_ids)
            if node_id != 0
        ],
        "independence_report": indep_report,
    }

    os.makedirs(os.path.dirname(args.out_json), exist_ok=True)
    with open(args.out_json, "w", encoding="utf-8") as f:
        json.dump(payload, f, indent=2, ensure_ascii=True)

    _write_svg(
        points=points,
        cluster_of=node_cluster,
        out_svg=args.out_svg,
        width=args.canvas_width,
        height=args.canvas_height,
        pad=args.canvas_pad,
        fit_margin_ratio=args.fit_margin_ratio,
        y_axis_label_offset=args.y_axis_label_offset,
    )

    print("[PROVENANCE_CLUSTER] input:", args.input)
    print("[PROVENANCE_CLUSTER] json:", args.out_json)
    print("[PROVENANCE_CLUSTER] svg:", args.out_svg)


if __name__ == "__main__":
    main()
