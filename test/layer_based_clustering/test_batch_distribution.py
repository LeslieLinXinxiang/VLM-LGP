#!/usr/bin/env python3
"""
Minimal regression test for the layer-based clustering pipeline.

Purpose:
1) Verify the clustering plan still produces the intended batches.
2) Show where batch splitting happens in Phase2 codegen.
3) Confirm the current codegen expands one planned batch into multiple step files.

This test is intentionally small and uses the same Phase1 input format as the
current pipeline.
"""

import json
import os
import shutil
import sys


ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
if ROOT_DIR not in sys.path:
    sys.path.insert(0, ROOT_DIR)
TEST_DIR = os.path.dirname(__file__)
if TEST_DIR not in sys.path:
    sys.path.insert(0, TEST_DIR)

from core.phase2_codegen import generate_step_files
from run_layer_based_codegen import LayerBasedClustering


INPUT_PATH = os.path.join(ROOT_DIR, "generated", "phase1_target_graph.json")
OUT_DIR = os.path.join(ROOT_DIR, "generated", "layer_based_batch_distribution_test")


def main():
    with open(INPUT_PATH, "r", encoding="utf-8") as f:
        phase1 = json.load(f)

    clustering = LayerBasedClustering(phase1_json=phase1, max_batch_size=2)
    result = clustering.build_execution_plan()

    expected_batches = [[1, 2], [3, 4], [5, 6], [7], [8], [9]]
    actual_batches = result["prompt1"]["strategies"][0]["batches"]
    assert actual_batches == expected_batches, (
        f"Layer-based planning changed unexpectedly: {actual_batches} != {expected_batches}"
    )

    if os.path.exists(OUT_DIR):
        shutil.rmtree(OUT_DIR)
    os.makedirs(OUT_DIR, exist_ok=True)

    files = generate_step_files(
        phase1_json=phase1,
        prompt1_output=result["prompt1"],
        prompt2_output=result["prompt2"],
        out_dir=OUT_DIR,
        inventory_data=None,
    )

    generated_names = [os.path.basename(path) for path in files]

    # The current codegen expands each planned batch into per-object step files.
    assert "step_1_batch_1.fol" in generated_names
    assert "step_1_batch_2.fol" in generated_names
    assert "step_1_batch_1.lgp" in generated_names
    assert "step_1_batch_2.lgp" in generated_names

    print("[TEST] plan_batches =", actual_batches)
    print("[TEST] generated_files =", generated_names)
    print("[TEST] control_point = test/layer_based_clustering/run_layer_based_codegen.py")
    print("[TEST] NOTE: same-layer siblings now merge by direct-supporter signature.")


if __name__ == "__main__":
    main()
