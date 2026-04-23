import argparse
import json
import os
import sys


ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if ROOT_DIR not in sys.path:
    sys.path.append(ROOT_DIR)

from core.graph_adapter import build_graph_from_phase1, graph_to_pretty_json


def main():
    parser = argparse.ArgumentParser(
        description="Interval test: receive Phase1 JSON and convert to graph G=(V,E)."
    )
    parser.add_argument(
        "--input",
        default=os.path.join(ROOT_DIR, "generated", "phase1_target_graph_img1_retry_marked.json"),
        help="Path to Phase1 JSON file (objects+edges).",
    )
    parser.add_argument(
        "--save-as",
        default="",
        help="Optional path to save generated graph JSON.",
    )
    args = parser.parse_args()

    with open(args.input, "r", encoding="utf-8") as f:
        plan_json = json.load(f)

    print(f"[TEST] Input path: {args.input}")
    print("[TEST] SUCCESS: Phase1 JSON received.")

    graph = build_graph_from_phase1(plan_json)

    print(
        "[TEST] SUCCESS: Graph built -> "
        f"|V|={graph['meta']['vertex_count']}, |E|={graph['meta']['edge_count']}"
    )
    print("[TEST] Graph Output:")
    print(graph_to_pretty_json(graph))

    if args.save_as:
        save_path = args.save_as
        if not os.path.isabs(save_path):
            save_path = os.path.join(ROOT_DIR, save_path)
        os.makedirs(os.path.dirname(save_path), exist_ok=True)
        with open(save_path, "w", encoding="utf-8") as f:
            f.write(graph_to_pretty_json(graph) + "\n")
        print(f"[TEST] Saved graph JSON to: {save_path}")


if __name__ == "__main__":
    main()