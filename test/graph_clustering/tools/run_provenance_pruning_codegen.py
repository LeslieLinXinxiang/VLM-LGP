#!/usr/bin/env python3
"""
Run provenance clustering + pruning scheduler, then emit Phase2 executable files.

This is a test harness aligned to mainline codegen format:
- clustering result JSON
- execution policy trace JSON
- Prompt1/Prompt2-like strategy JSON
- solver-facing .fol/.lgp step files via core.phase2_codegen.generate_step_files
"""

import argparse
import json
import os
import sys
from collections import defaultdict
from typing import Dict, List, Set, Tuple


ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", ".."))
if ROOT_DIR not in sys.path:
    sys.path.insert(0, ROOT_DIR)

from core.phase2_codegen import generate_step_files


def _load_phase1(path: str) -> Dict:
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)


def _graph(phase1: Dict):
    node_ids = []
    object_name = {}
    supporters = defaultdict(list)
    children = defaultdict(list)
    pos_map = {}

    for obj in phase1.get("objects", []):
        nid = obj.get("id")
        if not isinstance(nid, int):
            continue
        node_ids.append(nid)
        object_name[nid] = obj.get("object", "unknown")
        for e in obj.get("edges", []):
            s = e.get("supporter")
            if isinstance(s, int):
                supporters[nid].append(s)
                children[s].append(nid)
                if isinstance(e.get("position"), str):
                    pos_map[(s, nid)] = e.get("position")

    node_ids = sorted(set(node_ids))
    return node_ids, object_name, supporters, children, pos_map


def _layers(node_ids: List[int], supporters: Dict[int, List[int]]) -> Dict[int, int]:
    layer = {nid: -1 for nid in node_ids}
    if 0 in layer:
        layer[0] = 0

    changed = True
    while changed:
        changed = False
        for nid in node_ids:
            if nid == 0 or layer[nid] != -1:
                continue
            preds = supporters.get(nid, [])
            if preds and all(layer.get(p, -1) != -1 for p in preds):
                layer[nid] = 1 + max(layer[p] for p in preds)
                changed = True

    for nid in node_ids:
        if layer[nid] == -1:
            layer[nid] = 0
    return layer


def _roots(node_ids: List[int], supporters: Dict[int, List[int]], pos_map: Dict[Tuple[int, int], str]):
    roots = []
    for nid in node_ids:
        if nid != 0 and 0 in supporters.get(nid, []):
            roots.append(nid)

    position_order = {"left": 0, "center": 1, "middle": 1, "right": 2}
    roots.sort(key=lambda r: (position_order.get((pos_map.get((0, r)) or "").lower(), 9), r))
    return roots


def _provenance(node_ids: List[int], supporters: Dict[int, List[int]], roots: List[int]) -> Dict[int, Set[int]]:
    prov = {nid: set() for nid in node_ids}
    for r in roots:
        prov[r].add(r)

    changed = True
    while changed:
        changed = False
        for nid in node_ids:
            if nid == 0:
                continue
            preds = [p for p in supporters.get(nid, []) if p != 0]
            if not preds:
                continue
            s = set()
            for p in preds:
                s |= prov.get(p, set())
            if s and s != prov[nid]:
                prov[nid] = s
                changed = True
    return prov


def _clusters_from_prov(node_ids: List[int], prov: Dict[int, Set[int]]):
    cluster_key_nodes = defaultdict(list)
    for nid in node_ids:
        if nid == 0:
            continue
        sig = tuple(sorted(prov.get(nid, set())))
        key = "sig:" + ",".join(str(x) for x in sig)
        cluster_key_nodes[key].append(nid)

    keys = sorted(cluster_key_nodes.keys())
    key_to_id = {k: i for i, k in enumerate(keys)}
    id_to_key = {i: k for k, i in key_to_id.items()}
    cluster_of = {}
    for k, nodes in cluster_key_nodes.items():
        for n in nodes:
            cluster_of[n] = key_to_id[k]

    return cluster_of, id_to_key, {k: sorted(v) for k, v in cluster_key_nodes.items()}


def _pure_cluster_id_set(id_to_key: Dict[int, str]) -> Set[int]:
    pure = set()
    for cid, key in id_to_key.items():
        sig = key.replace("sig:", "")
        count = len([x for x in sig.split(",") if x])
        if count == 1:
            pure.add(cid)
    return pure


def _schedule(
    node_ids: List[int],
    supporters: Dict[int, List[int]],
    layer: Dict[int, int],
    cluster_of: Dict[int, int],
    id_to_key: Dict[int, str],
    roots: List[int],
    max_batch_size: int = 2,
    max_merge_per_subtask: int = 2,
    max_pure_branch_rise_streak: int = 1,
):
    pending = set([n for n in node_ids if n != 0])
    placed = {0}

    pure_clusters = _pure_cluster_id_set(id_to_key)

    policy_trace = []
    order: List[int] = []

    def is_ready(nid: int) -> bool:
        return all(pred in placed for pred in supporters.get(nid, []))

    pure_queues: Dict[int, List[int]] = {}
    for root in roots:
        key = f"sig:{root}"
        pure_queues[root] = sorted(
            [n for n in list(pending) if id_to_key[cluster_of[n]] == key],
            key=lambda n: (layer[n], n),
        )

    while any(pure_queues[r] for r in roots):
        progressed = False
        for root in roots:
            q = pure_queues[root]
            if not q:
                continue

            prev_layer = None
            rise_streak = 0
            while q:
                ready_nodes = [n for n in q if is_ready(n)]
                if not ready_nodes:
                    break
                chosen = ready_nodes[0]

                if prev_layer is not None and layer[chosen] > prev_layer:
                    if rise_streak >= max_pure_branch_rise_streak:
                        break
                    rise_streak += 1

                q.remove(chosen)
                pending.remove(chosen)
                placed.add(chosen)
                order.append(chosen)
                progressed = True
                prev_layer = layer[chosen]

                policy_trace.append(
                    {
                        "phase": "pure",
                        "chosen_node": chosen,
                        "chosen_cluster": int(cluster_of[chosen]),
                        "cluster_key": id_to_key[cluster_of[chosen]],
                        "ready_set": sorted([n for n in node_ids if n in pending and is_ready(n)]),
                        "rules": {
                            "precedence_ok": True,
                            "pure_branch_first": True,
                            "root_order": roots,
                            "max_pure_branch_rise_streak": max_pure_branch_rise_streak,
                            "current_rise_streak": rise_streak,
                        },
                    }
                )

            pure_queues[root] = q

        if not progressed:
            break

    merge_count_subtask = 0
    while pending:
        ready = sorted([n for n in pending if is_ready(n)], key=lambda n: (layer[n], n))
        if not ready:
            raise ValueError("No ready node found: dependency cycle or invalid graph.")

        chosen = ready[0]
        pending.remove(chosen)
        placed.add(chosen)
        order.append(chosen)

        is_merge = cluster_of[chosen] not in pure_clusters
        if is_merge:
            merge_count_subtask += 1

        policy_trace.append(
            {
                "phase": "merge",
                "chosen_node": chosen,
                "chosen_cluster": int(cluster_of[chosen]),
                "cluster_key": id_to_key[cluster_of[chosen]],
                "ready_set": [int(x) for x in ready],
                "rules": {
                    "precedence_ok": True,
                    "layer_first": True,
                    "merge_cap_per_subtask": max_merge_per_subtask,
                    "merge_count_subtask_so_far": merge_count_subtask,
                },
            }
        )

    batches: List[List[int]] = []
    current_batch: List[int] = []
    current_layer = None
    merge_count_subtask = 0

    for n in order:
        nid_layer = layer[n]
        is_merge = cluster_of[n] not in pure_clusters

        should_cut = False
        if current_batch and nid_layer != current_layer:
            should_cut = True
        if current_batch and len(current_batch) >= max_batch_size:
            should_cut = True
        if current_batch and is_merge and merge_count_subtask >= max_merge_per_subtask:
            should_cut = True

        if should_cut:
            batches.append(current_batch)
            current_batch = []
            current_layer = None
            merge_count_subtask = 0

        current_batch.append(n)
        current_layer = nid_layer
        if is_merge:
            merge_count_subtask += 1

    if current_batch:
        batches.append(current_batch)

    return batches, order, policy_trace


def main():
    parser = argparse.ArgumentParser(description="Run provenance clustering + pruning and generate executable step files.")
    parser.add_argument("--input", required=True, help="Path to Phase1 target-graph JSON.")
    parser.add_argument("--out-dir", default=os.path.join(ROOT_DIR, "generated", "provenance_policy_run"))
    parser.add_argument("--node-id", type=int, default=99)
    args = parser.parse_args()

    phase1 = _load_phase1(args.input)
    node_ids, object_name, supporters, children, pos_map = _graph(phase1)
    layer = _layers(node_ids, supporters)
    roots = _roots(node_ids, supporters, pos_map)
    prov = _provenance(node_ids, supporters, roots)

    cluster_of, id_to_key, cluster_key_nodes = _clusters_from_prov(node_ids, prov)
    batches, order, policy_trace = _schedule(
        node_ids=node_ids,
        supporters=supporters,
        layer=layer,
        cluster_of=cluster_of,
        id_to_key=id_to_key,
        roots=roots,
    )

    prompt1 = {
        "strategies": [
            {
                "id": "strategy_1_provenance_pruned",
                "description": "Provenance clustering + pruning scheduler policy",
                "order": order,
                "batches": batches,
                "metadata": {
                    "algorithm": "ProvenanceSetBranchClustering+Pruning",
                    "cluster_key_nodes": cluster_key_nodes,
                    "cluster_assignment": [{"node_id": n, "cluster_id": int(cluster_of[n]), "cluster_key": id_to_key[cluster_of[n]]} for n in sorted(cluster_of)],
                },
            }
        ]
    }
    prompt2 = {"selected": "strategy_1_provenance_pruned", "reason": "Policy-driven deterministic schedule."}

    os.makedirs(args.out_dir, exist_ok=True)
    trace_path = os.path.join(args.out_dir, "policy_trace.json")
    plan_path = os.path.join(args.out_dir, "execution_plan.json")
    strategy_path = os.path.join(args.out_dir, "phase2_strategy_policy.json")

    with open(trace_path, "w", encoding="utf-8") as f:
        json.dump(policy_trace, f, indent=2, ensure_ascii=True)

    with open(plan_path, "w", encoding="utf-8") as f:
        json.dump(
            {
                "input": args.input,
                "roots": roots,
                "clusters": cluster_key_nodes,
                "batches": batches,
                "order": order,
                "node_id": args.node_id,
            },
            f,
            indent=2,
            ensure_ascii=True,
        )

    with open(strategy_path, "w", encoding="utf-8") as f:
        json.dump({"prompt1": prompt1, "prompt2": prompt2}, f, indent=2, ensure_ascii=True)

    generated_files = generate_step_files(
        phase1_json=phase1,
        prompt1_output=prompt1,
        prompt2_output=prompt2,
        out_dir=args.out_dir,
        inventory_data=None,
    )

    print("[POLICY_TEST] input:", args.input)
    print("[POLICY_TEST] out_dir:", args.out_dir)
    print("[POLICY_TEST] clusters:", cluster_key_nodes)
    print("[POLICY_TEST] batches:", batches)
    print("[POLICY_TEST] generated files:", len(generated_files))


if __name__ == "__main__":
    main()
