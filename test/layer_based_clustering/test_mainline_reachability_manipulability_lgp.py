#!/usr/bin/env python3
"""
Mainline-connected smoke test for layer-based clustering.

This test does NOT use VLM. It connects the current pipeline path end-to-end:
1) Phase0 reachability / scene binding from unnamed.g
2) static manipulability report generation
3) Phase2 graph-gated execution and solver run

It is intended as the next step after the batch-level codegen test, before
promoting the batch-oriented logic into the mainline code.
"""

import argparse
import json
import os
import shutil
import sys
from datetime import datetime
from pathlib import Path


ROOT_DIR = Path(__file__).resolve().parents[2]
TEST_DIR = Path(__file__).resolve().parent
MANIP_DIR = ROOT_DIR / "test" / "manipulability"
if str(ROOT_DIR) not in sys.path:
    sys.path.insert(0, str(ROOT_DIR))
if str(TEST_DIR) not in sys.path:
    sys.path.insert(0, str(TEST_DIR))
if str(MANIP_DIR) not in sys.path:
    sys.path.insert(0, str(MANIP_DIR))

from pipeline.run_phase0 import execute_phase0
from pipeline.run_phase2 import run_phase2_pipeline
from run_layer_based_codegen import LayerBasedClustering
from urdf_static_manipulability import compute_static_manipulability_report


DEFAULT_UNNAMED_G = ROOT_DIR / "unnamed.g"
DEFAULT_PHASE1 = ROOT_DIR / "generated" / "phase1_target_graph.json"
DEFAULT_SCENE = ROOT_DIR / "generated" / "scene" / "scene_named.g"
DEFAULT_LAYOUT = ROOT_DIR / "generated" / "phase0_layout.json"
DEFAULT_INFEASIBLE = ROOT_DIR / "generated" / "infeasible_objects.json"
DEFAULT_REACHABILITY = ROOT_DIR / "generated" / "reachability_score_report.json"
DEFAULT_MANIP_REPORT = ROOT_DIR / "generated" / "layer_based_mainline_manipulability_report.json"
DEFAULT_OUT_DIR = ROOT_DIR / "generated" / "layer_based_mainline_smoke_run"


def _write_json(path: Path, payload):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(payload, indent=2, ensure_ascii=True), encoding="utf-8")


def _read_json(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


def _artifact_report(path: Path) -> str:
    return f"{path.name}: {'present' if path.exists() else 'missing'}"


def main():
    parser = argparse.ArgumentParser(description="Mainline reachability + manipulability + LGP smoke test")
    parser.add_argument("--unnamed-g", default=str(DEFAULT_UNNAMED_G))
    parser.add_argument("--phase1", default=str(DEFAULT_PHASE1))
    parser.add_argument("--scene", default=str(DEFAULT_SCENE))
    parser.add_argument("--layout", default=str(DEFAULT_LAYOUT))
    parser.add_argument("--infeasible", default=str(DEFAULT_INFEASIBLE))
    parser.add_argument("--reachability-out", default=str(DEFAULT_REACHABILITY))
    parser.add_argument("--manip-report", default=str(DEFAULT_MANIP_REPORT))
    parser.add_argument("--out-dir", default=str(DEFAULT_OUT_DIR))
    parser.add_argument("--max-batch-size", type=int, default=2)
    args = parser.parse_args()

    unnamed_g = Path(args.unnamed_g)
    phase1_path = Path(args.phase1)
    scene_path = Path(args.scene)
    layout_path = Path(args.layout)
    infeasible_path = Path(args.infeasible)
    reachability_path = Path(args.reachability_out)
    manip_report_path = Path(args.manip_report)
    out_dir = Path(args.out_dir)

    if not unnamed_g.exists():
        raise FileNotFoundError(f"Missing unnamed.g: {unnamed_g}")
    if not phase1_path.exists():
        raise FileNotFoundError(f"Missing phase1 graph: {phase1_path}")

    if out_dir.exists():
        shutil.rmtree(out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    # 1) Phase0 reachability / scene binding, no VLM.
    phase0_result = execute_phase0(
        use_vlm=False,
        unnamed_g_path=str(unnamed_g),
        layout_output_path=str(layout_path),
        infeasible_output_path=str(infeasible_path),
        reachability_mode="gmm_esdf_mvp",
        reachability_score_output_path=str(reachability_path),
    )
    if not phase0_result or not phase0_result.get("success"):
        raise SystemExit("[MAINLINE_SMOKE] Phase0 failed")

    # 2) Static manipulability report based on Phase0 outputs.
    manip_report = compute_static_manipulability_report(
        layout_path=str(layout_path),
        infeasible_path=str(infeasible_path),
        g_path=str(scene_path),
        urdf_path=str(ROOT_DIR / "rai" / "test" / "newLGP" / "rai-robotModels" / "panda" / "panda_arm_hand.urdf"),
    )
    _write_json(manip_report_path, manip_report)

    # 3) Layer-based clustering plan (for inspection in the report).
    phase1_json = _read_json(phase1_path)
    clustering = LayerBasedClustering(phase1_json=phase1_json, max_batch_size=args.max_batch_size)
    layer_plan = clustering.build_execution_plan()

    # 4) Mainline Phase2 + solver execution. This is the actual LGP path.
    success, output_g, _, summary, _, stdout = run_phase2_pipeline(
        node_data={"node_id": 301},
        current_g_path=str(scene_path),
        full_target_graph=phase1_json,
        inventory_data=_read_json(layout_path),
        history_chain=[],
        stop_before_solver=False,
    )
    if not success:
        raise SystemExit("[MAINLINE_SMOKE] Phase2/solver execution failed")

    report_path = out_dir / "mainline_smoke_report.md"
    report_path.write_text(
        "\n".join(
            [
                "# Mainline Reachability + Manipulability + LGP Smoke Test",
                "",
                f"- Generated at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
                f"- Phase1 input: {phase1_path}",
                f"- Unnamed scene: {unnamed_g}",
                f"- Scene named: {scene_path}",
                f"- Output directory: {out_dir}",
                "",
                "## 1) What was connected",
                "",
                "1. Phase0 reachability + scene binding (no VLM).",
                "2. Static manipulability report generation.",
                "3. Layer-based planning report (for inspection).",
                "4. Phase2 graph-gated execution with solver run.",
                "",
                "## 2) Key outputs",
                "",
                f"- Phase0 reachability report: {reachability_path}",
                f"- Manipulability report: {manip_report_path}",
                f"- Phase2 output_g: {output_g}",
                f"- Phase2 summary status: {summary.get('status')}",
                "",
                "## 3) Layer-based plan snapshot",
                "",
                json.dumps(layer_plan["prompt1"]["strategies"][0]["batches"], indent=2, ensure_ascii=True),
                "",
                "## 4) Artifact checks",
                "",
                _artifact_report(layout_path),
                _artifact_report(infeasible_path),
                _artifact_report(reachability_path),
                _artifact_report(manip_report_path),
                _artifact_report(Path(output_g)) if output_g else "output_g: missing",
                "",
                "## 5) Notes",
                "",
                "- This test intentionally does not touch VLM.",
                "- It uses current mainline Phase0 and Phase2 entry points.",
                "- If this passes, the batch-oriented logic is safe to promote into mainline code.",
            ]
        ),
        encoding="utf-8",
    )

    print("[MAINLINE_SMOKE] phase0: PASS")
    print("[MAINLINE_SMOKE] manipulability: PASS")
    print("[MAINLINE_SMOKE] phase2_solver: PASS")
    print("[MAINLINE_SMOKE] output_g:", output_g)
    print("[MAINLINE_SMOKE] report:", report_path)
    print("[MAINLINE_SMOKE] stdout_summary:")
    print(stdout)


if __name__ == "__main__":
    main()
