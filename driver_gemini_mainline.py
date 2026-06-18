#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import os
import shutil
import sys
from pathlib import Path

ROOT_DIR = Path(__file__).resolve().parent


def _parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Gemini + reachability + manipulability + layered mainline")
    parser.add_argument("--image", default=str(ROOT_DIR / "generated" / "phase1_target.png"), help="Target image for Phase1")
    parser.add_argument("--unnamed-g", default=str(ROOT_DIR / "unnamed.g"), help="Input scene file")
    parser.add_argument("--prompt", default=str(ROOT_DIR / "prompts" / "phase1_graph_planner_length_rank_test.md"), help="Phase1 prompt file")
    parser.add_argument("--output-root", default=str(ROOT_DIR / "generated" / "gemini_mainline_run"), help="Output directory for this run")
    parser.add_argument("--vlm-backend", default="gemini", choices=["gemini", "qwen"], help="VLM backend")
    parser.add_argument("--gemini-model", default="gemini-3.0-flash", help="Gemini model name")
    parser.add_argument("--execution-mode", default="docker", choices=["docker", "ros2", "none"], help="How to replay the planned trajectory")
    parser.add_argument("--skip-physical-execution", action="store_true", help="Do not replay the trajectory after planning")
    parser.add_argument("--max-batch-size", type=int, default=2, help="Phase2 batch size")
    return parser.parse_args()


def _prepare_env(args: argparse.Namespace) -> None:
    os.environ["VLM_BACKEND"] = args.vlm_backend
    if args.vlm_backend == "gemini":
        resolved_model = args.gemini_model
        if resolved_model == "gemini-3.0-flash":
            resolved_model = "gemini-3-flash-preview"
        os.environ["GEMINI_MODEL_NAME"] = resolved_model
        args.resolved_gemini_model = resolved_model
    else:
        args.resolved_gemini_model = ""



def _ensure_path(path: str | Path) -> Path:
    return Path(path).expanduser().resolve()



def _write_json(path: Path, payload) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(payload, indent=2, ensure_ascii=True), encoding="utf-8")



def main() -> int:
    args = _parse_args()
    _prepare_env(args)

    sys.path.insert(0, str(ROOT_DIR))
    sys.path.insert(0, str(ROOT_DIR / "test" / "manipulability"))

    from core.deployment_export import export_trajectory_and_gripper_bundle
    from core.utils import load_json
    from pipeline.run_phase0 import execute_phase0
    from pipeline.run_phase1 import execute_phase1
    from pipeline.run_phase2 import run_phase2_pipeline

    import importlib.util

    manip_module_path = ROOT_DIR / "test" / "manipulability" / "urdf_static_manipulability.py"
    manip_spec = importlib.util.spec_from_file_location("urdf_static_manipulability", manip_module_path)
    if manip_spec is None or manip_spec.loader is None:
        print(f"[GeminiMainline] Cannot load manipulability module: {manip_module_path}")
        return 1
    manip_module = importlib.util.module_from_spec(manip_spec)
    manip_spec.loader.exec_module(manip_module)
    compute_static_manipulability_report = manip_module.compute_static_manipulability_report

    if args.execution_mode == "docker":
        from core.zmq_bridge import ExecutionManager as DockerExecutionManager
    else:
        from core.ros2_bridge import ExecutionManager as Ros2ExecutionManager

    image_path = _ensure_path(args.image)
    unnamed_g_path = _ensure_path(args.unnamed_g)
    prompt_path = _ensure_path(args.prompt)
    output_root = _ensure_path(args.output_root)

    if not image_path.exists():
        print(f"[GeminiMainline] Missing image: {image_path}")
        return 1
    if not unnamed_g_path.exists():
        print(f"[GeminiMainline] Missing scene: {unnamed_g_path}")
        return 1
    if not prompt_path.exists():
        print(f"[GeminiMainline] Missing prompt: {prompt_path}")
        return 1

    if output_root.exists():
        shutil.rmtree(output_root)
    output_root.mkdir(parents=True, exist_ok=True)

    layout_path = output_root / "phase0_layout.json"
    infeasible_path = output_root / "infeasible_objects.json"
    reachability_path = output_root / "reachability_score_report.json"
    phase1_path = output_root / "phase1_target_graph.json"
    manip_path = output_root / "manipulability_report.json"
    raw_log_path = output_root / "raw_trajectory.log"
    report_path = output_root / "mainline_report.md"

    print("[GeminiMainline] Phase 0 start")
    phase0_result = execute_phase0(
        use_vlm=False,
        unnamed_g_path=str(unnamed_g_path),
        layout_output_path=str(layout_path),
        infeasible_output_path=str(infeasible_path),
        reachability_mode="gmm_esdf_mvp",
        reachability_score_output_path=str(reachability_path),
    )
    if not phase0_result or not phase0_result.get("success"):
        print("[GeminiMainline] Phase 0 failed")
        return 1

    print("[GeminiMainline] Phase 0.5 manipulability start")
    manip_report = compute_static_manipulability_report(
        layout_path=str(layout_path),
        infeasible_path=str(infeasible_path),
        g_path=str(phase0_result["scene_named_path"]),
        urdf_path=str(ROOT_DIR / "rai" / "test" / "newLGP" / "rai-robotModels" / "panda" / "panda_arm_hand.urdf"),
    )
    _write_json(manip_path, manip_report)

    print("[GeminiMainline] Phase 1 start")
    phase1_ok, phase1_graph_path = execute_phase1(
        target_img_path=str(image_path),
        output_json_path=str(phase1_path),
        prompt_path=str(prompt_path),
    )
    if not phase1_ok or not phase1_graph_path:
        print("[GeminiMainline] Phase 1 failed")
        return 1

    phase1_json = load_json(phase1_graph_path)

    print("[GeminiMainline] Phase 2 start")
    p2_ok, output_g, _, node_summary, used_ids, stdout = run_phase2_pipeline(
        node_data={"node_id": 1},
        current_g_path=str(phase0_result["scene_named_path"]),
        full_target_graph=phase1_json,
        inventory_data=load_json(str(layout_path)),
        history_chain=[],
        stop_before_solver=False,
        clustering_algorithm="branch_layer_cutting",
        output_root_dir=str(output_root),
    )
    if not p2_ok or not stdout:
        print("[GeminiMainline] Phase 2 failed")
        return 1

    raw_log_path.write_text(stdout, encoding="utf-8")
    deployment_info = export_trajectory_and_gripper_bundle(
        stdout=stdout,
        output_dir=output_root / "deployment",
    )

    if args.skip_physical_execution or args.execution_mode == "none":
        execution_status = "skipped"
    elif args.execution_mode == "docker":
        print("[GeminiMainline] Docker replay start")
        executor = DockerExecutionManager()
        execution_status = "unknown"
        try:
            from core.trajectory_parser import TrajectoryParser

            all_tasks = TrajectoryParser.parse_all(stdout, time_scale=1.0)
            executor.home_robot()
            for task_idx, segments in enumerate(all_tasks):
                executor.move_gripper(0.04)
                for seg_idx, segment in enumerate(segments):
                    if not segment:
                        continue
                    waypoints = [p["q"] for p in segment]
                    executor.execute_trajectory(waypoints)
                    is_last_segment = seg_idx == len(segments) - 1
                    is_complex_task = len(segments) > 2
                    if is_last_segment and is_complex_task:
                        executor.move_gripper(0.04)
                    elif seg_idx % 2 == 0:
                        executor.move_gripper(0.0)
                    else:
                        executor.move_gripper(0.04)
            execution_status = "replayed"
        except Exception as exc:
            execution_status = f"failed: {exc}"
            print(f"[GeminiMainline] Docker replay failed: {exc}")
    else:
        print("[GeminiMainline] ROS2 replay start")
        executor = Ros2ExecutionManager()
        execution_status = "unknown"
        try:
            executor.home_robot()
            executor.execute_trajectory_string(stdout, node_id=1)
            execution_status = "replayed"
        except Exception as exc:
            execution_status = f"failed: {exc}"
            print(f"[GeminiMainline] ROS2 replay failed: {exc}")

    report_lines = [
        "# Gemini Mainline Run Report",
        "",
        f"- Image: {image_path}",
        f"- Prompt: {prompt_path}",
        f"- Scene: {unnamed_g_path}",
        f"- Output root: {output_root}",
        f"- Execution mode: {args.execution_mode}",
        f"- Requested Gemini model: {args.gemini_model}",
        f"- Resolved Gemini model: {getattr(args, 'resolved_gemini_model', '')}",
        f"- Execution status: {execution_status}",
        "",
        "## Artifacts",
        "",
        f"- Phase0 layout: {layout_path}",
        f"- Reachability report: {reachability_path}",
        f"- Manipulability report: {manip_path}",
        f"- Phase1 graph: {phase1_path}",
        f"- Raw trajectory log: {raw_log_path}",
        f"- Trajectory bundle: {deployment_info['trajectory_path']}",
        f"- Gripper schedule: {deployment_info['gripper_path']}",
        f"- Final output g: {output_g}",
        "",
        "## Gripper protocol",
        "",
        "- default state: open",
        "- gripper.txt stores 1-based trajectory line numbers",
        "- first marker => close, second marker => open, then alternate",
        "",
        "## Phase2 summary",
        "",
        json.dumps(node_summary, indent=2, ensure_ascii=True),
        "",
        "## Used ids",
        "",
        json.dumps(used_ids, ensure_ascii=True),
    ]
    report_path.write_text("\n".join(report_lines), encoding="utf-8")

    print("[GeminiMainline] Done")
    print(f"[GeminiMainline] report: {report_path}")
    print(f"[GeminiMainline] trajectory: {deployment_info['trajectory_path']}")
    print(f"[GeminiMainline] gripper: {deployment_info['gripper_path']}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
