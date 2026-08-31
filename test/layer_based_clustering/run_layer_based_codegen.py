    #!/usr/bin/env python3
"""
Minimal layer-based clustering test harness.

Goals:
1) Use the current pipeline Phase1 input format (objects+edges, compatible with V/E).
2) Keep Prompt1/Prompt2 output schema identical to existing Phase2 consumers.
3) Generate full execution artifacts, including .fol/.lgp files.
4) Emit a detailed run report with input/output schema and policy trace.
"""

import argparse
import json
import os
import sys
from collections import defaultdict
from dataclasses import dataclass
from datetime import datetime
from typing import Dict, List, Set, Tuple


ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
if ROOT_DIR not in sys.path:
    sys.path.insert(0, ROOT_DIR)

from core.phase2_codegen import generate_step_files


@dataclass
class ParsedGraph:
    node_ids: List[int]
    object_name: Dict[int, str]
    supporters: Dict[int, List[int]]
    children: Dict[int, List[int]]
    edge_position: Dict[Tuple[int, int], str]


class LayerBasedClustering:
    """
    TASK-024 oriented minimal implementation:
    - same-layer grouping as execution candidates
    - branch assignment with source-priority (provenance roots)
    - left-to-right ordering inside branch
    - split branch chunk size <= 2
    """

    def __init__(self, phase1_json: Dict, max_batch_size: int = 2):
        self.phase1_json = phase1_json
        self.max_batch_size = max(1, int(max_batch_size))
        self.graph = self._parse_graph(phase1_json)

    @staticmethod
    def _parse_graph(phase1_json: Dict) -> ParsedGraph:
        object_name = {}
        supporters = defaultdict(list)
        children = defaultdict(list)
        edge_position = {}
        node_ids = set()

        if "objects" in phase1_json:
            for obj in phase1_json.get("objects", []):
                nid = obj.get("id")
                if not isinstance(nid, int):
                    continue
                node_ids.add(nid)
                object_name[nid] = obj.get("object", "unknown")
                for e in obj.get("edges", []):
                    s = e.get("supporter")
                    if isinstance(s, int):
                        supporters[nid].append(s)
                        children[s].append(nid)
                        if isinstance(e.get("position"), str):
                            edge_position[(s, nid)] = e["position"].lower()
        elif "V" in phase1_json and "E" in phase1_json:
            for v in phase1_json.get("V", []):
                nid = v.get("id")
                if not isinstance(nid, int):
                    continue
                node_ids.add(nid)
                object_name[nid] = v.get("object", "unknown")
            for e in phase1_json.get("E", []):
                s = e.get("from")
                t = e.get("to")
                if isinstance(s, int) and isinstance(t, int):
                    supporters[t].append(s)
                    children[s].append(t)
                    if isinstance(e.get("position"), str):
                        edge_position[(s, t)] = e["position"].lower()
        else:
            raise ValueError("Unsupported Phase1 format. Expected 'objects' or 'V/E'.")

        for nid in node_ids:
            supporters.setdefault(nid, [])
            children.setdefault(nid, [])

        return ParsedGraph(
            node_ids=sorted(node_ids),
            object_name=object_name,
            supporters=supporters,
            children=children,
            edge_position=edge_position,
        )

    def compute_layers(self) -> Dict[int, int]:
        layer = {nid: -1 for nid in self.graph.node_ids}
        if 0 in layer:
            layer[0] = 0

        changed = True
        while changed:
            changed = False
            for nid in self.graph.node_ids:
                if nid == 0 or layer[nid] != -1:
                    continue
                preds = self.graph.supporters.get(nid, [])
                if preds and all(layer.get(p, -1) != -1 for p in preds):
                    layer[nid] = 1 + max(layer[p] for p in preds)
                    changed = True

        for nid in self.graph.node_ids:
            if layer[nid] == -1:
                layer[nid] = 0
        return layer

    def roots_by_table_position(self) -> List[int]:
        roots = [
            nid
            for nid in self.graph.node_ids
            if nid != 0 and 0 in self.graph.supporters.get(nid, [])
        ]
        # A root with NO explicit position label is the scene's anchor/base object (e.g.
        # FMB's "Shape 2" board that other pieces are placed relative to) - it should be
        # scheduled FIRST, not last. An earlier version ranked the missing-label case as 9
        # (worse than left/center/right), which put the anchor object last whenever other
        # same-layer siblings had explicit left/right labels - the opposite of the intended
        # "place the base piece down before the pieces around it" ordering.
        pos_rank = {"left": 0, "center": 1, "middle": 1, "right": 2}
        roots.sort(
            key=lambda r: (
                pos_rank.get(self.graph.edge_position.get((0, r), ""), -1),
                r,
            )
        )
        return roots

    def provenance_sets(self, roots: List[int]) -> Dict[int, Set[int]]:
        prov = {nid: set() for nid in self.graph.node_ids}
        for r in roots:
            prov[r].add(r)

        changed = True
        while changed:
            changed = False
            for nid in self.graph.node_ids:
                if nid == 0:
                    continue
                preds = [p for p in self.graph.supporters.get(nid, []) if p != 0]
                if not preds:
                    continue
                merged = set()
                for p in preds:
                    merged |= prov.get(p, set())
                if merged and merged != prov[nid]:
                    prov[nid] = merged
                    changed = True

        return prov

    def x_priority_score(
        self,
        node_id: int,
        roots: List[int],
        provenance: Dict[int, Set[int]],
    ) -> float:
        pos_rank = {"left": 0.0, "center": 1.0, "middle": 1.0, "right": 2.0}

        incoming = []
        for sup in self.graph.supporters.get(node_id, []):
            pos = self.graph.edge_position.get((sup, node_id))
            if pos in pos_rank:
                incoming.append(pos_rank[pos])

        if incoming:
            return float(sum(incoming) / len(incoming))

        root_idx = {r: i for i, r in enumerate(roots)}
        pset = sorted(provenance.get(node_id, set()))
        if pset:
            vals = [float(root_idx.get(r, 100 + r)) for r in pset]
            return float(sum(vals) / len(vals))

        return float(1000 + node_id)

    @staticmethod
    def branch_key(node_id: int, prov_set: Set[int]) -> str:
        if not prov_set:
            return f"branch:singleton:{node_id}"
        if len(prov_set) == 1:
            return f"branch:source:{next(iter(prov_set))}"
        sig = ",".join(str(x) for x in sorted(prov_set))
        return f"branch:merge:{sig}"

    def supporter_signature(self, node_id: int) -> Tuple[int, ...]:
        """Signature of direct supporters, including table/base 0."""
        return tuple(sorted(self.graph.supporters.get(node_id, [])))

    def branch_priority(self, node_ids: List[int], layer: Dict[int, int]) -> Tuple[int, int, int, str]:
        """
        Prefer lower supporter layers first, then left-to-right-ish ordering.

        This keeps the grouping general:
        - siblings with the same direct supporter signature stay in one batch;
        - branches whose supporters come from lower layers are executed earlier.
        """
        if not node_ids:
            return (10**9, 10**9, 10**9, "")

        supporter_ids = set()
        for node_id in node_ids:
            supporter_ids.update(self.graph.supporters.get(node_id, []))

        supporter_ids.discard(0)
        supporter_layers = [layer.get(sup_id, 0) for sup_id in supporter_ids] or [0]
        support_layer_min = min(supporter_layers)
        support_layer_mean = int(sum(supporter_layers) / len(supporter_layers))
        min_node = min(node_ids)
        signature_text = ",".join(str(x) for x in sorted(supporter_ids)) or "base"
        return (support_layer_min, support_layer_mean, min_node, signature_text)

    def build_execution_plan(self) -> Dict:
        layer = self.compute_layers()
        roots = self.roots_by_table_position()
        provenance = self.provenance_sets(roots)

        pending = {n for n in self.graph.node_ids if n != 0}
        placed = {0}

        global_batches: List[List[int]] = []
        global_order: List[int] = []
        policy_trace: List[Dict] = []
        layer_blocks: List[Dict] = []

        while pending:
            ready = [
                n
                for n in sorted(pending)
                if all(s in placed for s in self.graph.supporters.get(n, []))
            ]
            if not ready:
                raise ValueError("No ready nodes found. Input graph likely has dependency cycles.")

            min_ready_layer = min(layer[n] for n in ready)
            same_layer_ready = [n for n in ready if layer[n] == min_ready_layer]

            by_branch: Dict[str, List[int]] = defaultdict(list)
            for n in same_layer_ready:
                bkey = ",".join(str(x) for x in self.supporter_signature(n)) or "base"
                by_branch[bkey].append(n)

            branch_items = []
            for bkey, nodes in by_branch.items():
                ordered = sorted(
                    nodes,
                    key=lambda n: (
                        self.x_priority_score(n, roots, provenance),
                        n,
                    ),
                )
                chunks = [
                    ordered[i : i + self.max_batch_size]
                    for i in range(0, len(ordered), self.max_batch_size)
                ]
                branch_items.append((bkey, ordered, chunks))

            branch_items.sort(
                key=lambda item: self.branch_priority(item[1], layer)
            )

            layer_record = {
                "layer": int(min_ready_layer),
                "same_layer_ready": [int(n) for n in same_layer_ready],
                "branches": [],
            }

            for bkey, ordered, chunks in branch_items:
                supporter_signature_text = bkey if bkey != "base" else "0"
                layer_record["branches"].append(
                    {
                        "branch_key": f"supporters:{supporter_signature_text}",
                        "ordered_nodes_left_to_right": [int(n) for n in ordered],
                        "chunks": [[int(n) for n in c] for c in chunks],
                    }
                )

                for chunk in chunks:
                    for n in chunk:
                        pending.remove(n)
                        placed.add(n)
                        global_order.append(n)
                    global_batches.append(chunk)
                    policy_trace.append(
                        {
                            "phase": "layer_based",
                            "layer": int(min_ready_layer),
                            "selected_branch": f"supporters:{supporter_signature_text}",
                            "batch": [int(n) for n in chunk],
                            "rules": {
                                "same_layer_grouping": True,
                                "source_priority_branching": True,
                                "left_to_right_inside_branch": True,
                                "max_batch_size": int(self.max_batch_size),
                            },
                        }
                    )

            layer_blocks.append(layer_record)

        assignment = []
        for n in sorted(self.graph.node_ids):
            if n == 0:
                continue
            pset = sorted(provenance.get(n, set()))
            assignment.append(
                {
                    "node_id": int(n),
                    "layer": int(layer[n]),
                        "branch_key": f"supporters:{','.join(str(x) for x in self.supporter_signature(n)) or '0'}",
                    "provenance_roots": [int(x) for x in pset],
                    "x_priority": float(self.x_priority_score(n, roots, provenance)),
                }
            )

        prompt1 = {
            "strategies": [
                {
                    "id": "strategy_1_layer_based",
                    "description": "Layer-based clustering with source-priority branching and left-to-right chunking.",
                    "order": [int(x) for x in global_order],
                    "batches": [[int(x) for x in b] for b in global_batches],
                    "metadata": {
                        "algorithm": "LayerBasedClustering",
                        "max_batch_size": int(self.max_batch_size),
                        "roots": [int(r) for r in roots],
                        "layer_blocks": layer_blocks,
                        "branch_assignment": assignment,
                    },
                }
            ]
        }
        prompt2 = {
            "selected": "strategy_1_layer_based",
            "reason": "Deterministic layer-based policy with source-priority semantics.",
        }

        return {
            "layer": {str(k): int(v) for k, v in sorted(layer.items())},
            "roots": [int(r) for r in roots],
            "provenance": {
                str(n): [int(x) for x in sorted(ps)] for n, ps in sorted(provenance.items()) if n != 0
            },
            "prompt1": prompt1,
            "prompt2": prompt2,
            "policy_trace": policy_trace,
            "execution_plan": {
                "algorithm": "LayerBasedClustering",
                "order": [int(x) for x in global_order],
                "batches": [[int(x) for x in b] for b in global_batches],
                "layer_blocks": layer_blocks,
            },
        }


def _write_json(path: str, payload: Dict):
    with open(path, "w", encoding="utf-8") as f:
        json.dump(payload, f, indent=2, ensure_ascii=True)


def _schema_examples() -> Dict:
    return {
        "phase1_input_schema": {
            "objects": [
                {
                    "id": "int",
                    "object": "str",
                    "edges": [{"supporter": "int", "position": "str(optional)"}],
                }
            ]
        },
        "phase2_prompt1_schema": {
            "strategies": [
                {
                    "id": "str",
                    "description": "str",
                    "order": ["int"],
                    "batches": [["int"]],
                    "metadata": "dict",
                }
            ]
        },
        "phase2_prompt2_schema": {"selected": "str", "reason": "str"},
        "execution_plan_schema": {
            "algorithm": "str",
            "order": ["int"],
            "batches": [["int"]],
            "layer_blocks": [
                {
                    "layer": "int",
                    "same_layer_ready": ["int"],
                    "branches": [
                        {
                            "branch_key": "str",
                            "ordered_nodes_left_to_right": ["int"],
                            "chunks": [["int"]],
                        }
                    ],
                }
            ],
        },
    }


def _write_markdown_report(
    out_path: str,
    input_path: str,
    out_dir: str,
    node_id: int,
    result: Dict,
    generated_files: List[str],
):
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    schemas = _schema_examples()
    prompt1 = result["prompt1"]
    prompt2 = result["prompt2"]
    plan = result["execution_plan"]

    lines = [
        "# Layer-Based Clustering Minimal Test Report",
        "",
        f"- Generated at: {now}",
        f"- Input: {input_path}",
        f"- Output directory: {out_dir}",
        f"- Node ID: {node_id}",
        "",
        "## 1) Objective",
        "",
        "Run a minimal layer-based clustering test with pipeline-compatible IO and generate full executable planning artifacts.",
        "",
        "## 2) Algorithm (implemented)",
        "",
        "1. Parse support DAG from Phase1 JSON.",
        "2. Compute topological layers.",
        "3. Derive source-provenance sets from table roots (source-priority branching).",
        "4. At each step, select the minimum ready layer as a same-layer execution block.",
        "5. Group same-layer ready nodes by branch key from provenance.",
        "6. Inside each branch, sort nodes left-to-right (edge position first, provenance-root index fallback).",
        "7. Split branch sequence into chunks with max size 2.",
        "8. Emit Prompt1/Prompt2 compatible outputs and generate .fol/.lgp step files.",
        "",
        "## 3) Input / Output format contract",
        "",
        "### 3.1 Input schema (Phase1)",
        "```json",
        json.dumps(schemas["phase1_input_schema"], indent=2, ensure_ascii=True),
        "```",
        "",
        "### 3.2 Output schema (Prompt1)",
        "```json",
        json.dumps(schemas["phase2_prompt1_schema"], indent=2, ensure_ascii=True),
        "```",
        "",
        "### 3.3 Output schema (Prompt2)",
        "```json",
        json.dumps(schemas["phase2_prompt2_schema"], indent=2, ensure_ascii=True),
        "```",
        "",
        "### 3.4 Output schema (Execution Plan)",
        "```json",
        json.dumps(schemas["execution_plan_schema"], indent=2, ensure_ascii=True),
        "```",
        "",
        "## 4) Run result summary",
        "",
        "### 4.1 Selected strategy",
        "```json",
        json.dumps(prompt2, indent=2, ensure_ascii=True),
        "```",
        "",
        "### 4.2 Order and batches",
        "```json",
        json.dumps(
            {
                "order": prompt1["strategies"][0]["order"],
                "batches": prompt1["strategies"][0]["batches"],
            },
            indent=2,
            ensure_ascii=True,
        ),
        "```",
        "",
        "### 4.3 Layer blocks",
        "```json",
        json.dumps(plan["layer_blocks"], indent=2, ensure_ascii=True),
        "```",
        "",
        "## 5) Generated artifacts",
        "",
    ]

    for f in generated_files:
        lines.append(f"- {f}")

    lines.extend(
        [
            "",
            "## 6) Notes",
            "",
            "- This harness is minimal and deterministic.",
            "- It keeps output schema compatible with current Phase2 codegen consumers.",
            "- It is intended for isolated testing under test/layer_based_clustering.",
            "",
        ]
    )

    with open(out_path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))


def main():
    parser = argparse.ArgumentParser(description="Minimal layer-based clustering test and codegen harness")
    parser.add_argument(
        "--input",
        default=os.path.join(ROOT_DIR, "generated", "phase1_target_graph.json"),
        help="Path to Phase1 graph JSON (objects+edges or V/E).",
    )
    parser.add_argument(
        "--out-dir",
        default=os.path.join(ROOT_DIR, "generated", "layer_based_policy_run"),
        help="Output directory for plan/report/step files.",
    )
    parser.add_argument("--node-id", type=int, default=301)
    parser.add_argument("--max-batch-size", type=int, default=2)
    args = parser.parse_args()

    with open(args.input, "r", encoding="utf-8") as f:
        phase1 = json.load(f)

    clustering = LayerBasedClustering(phase1_json=phase1, max_batch_size=args.max_batch_size)
    result = clustering.build_execution_plan()

    prompt1 = result["prompt1"]
    prompt2 = result["prompt2"]

    os.makedirs(args.out_dir, exist_ok=True)

    plan_path = os.path.join(args.out_dir, "execution_plan.json")
    trace_path = os.path.join(args.out_dir, "policy_trace.json")
    strategy_path = os.path.join(args.out_dir, "phase2_strategy_policy.json")
    layer_meta_path = os.path.join(args.out_dir, "layer_based_metadata.json")

    _write_json(plan_path, {
        "input": args.input,
        "node_id": int(args.node_id),
        **result["execution_plan"],
    })
    _write_json(trace_path, result["policy_trace"])
    _write_json(strategy_path, {"prompt1": prompt1, "prompt2": prompt2})
    _write_json(
        layer_meta_path,
        {
            "layer": result["layer"],
            "roots": result["roots"],
            "provenance": result["provenance"],
            "branch_assignment": prompt1["strategies"][0]["metadata"].get("branch_assignment", []),
        },
    )

    generated_files = generate_step_files(
        phase1_json=phase1,
        prompt1_output=prompt1,
        prompt2_output=prompt2,
        out_dir=args.out_dir,
        inventory_data=None,
    )

    report_path = os.path.join(args.out_dir, "layer_based_test_report.md")
    artifact_files = [
        os.path.basename(plan_path),
        os.path.basename(trace_path),
        os.path.basename(strategy_path),
        os.path.basename(layer_meta_path),
    ] + [os.path.basename(p) for p in generated_files]
    _write_markdown_report(
        out_path=report_path,
        input_path=args.input,
        out_dir=args.out_dir,
        node_id=args.node_id,
        result=result,
        generated_files=artifact_files,
    )

    print("[LAYER-BASED TEST] input:", args.input)
    print("[LAYER-BASED TEST] out_dir:", args.out_dir)
    print("[LAYER-BASED TEST] selected:", prompt2.get("selected"))
    print("[LAYER-BASED TEST] order:", prompt1["strategies"][0]["order"])
    print("[LAYER-BASED TEST] batches:", prompt1["strategies"][0]["batches"])
    print("[LAYER-BASED TEST] generated files:", len(generated_files))
    print("[LAYER-BASED TEST] report:", report_path)


if __name__ == "__main__":
    main()
