# pipelines/run_phase2.py
import os
import json
from typing import Dict, List, Optional, Tuple

from core.vlm import VLMClient
from core.phase2_codegen import generate_step_files
from core.phase2_gatekeeper import validate_phase2_selection, save_gate_report
from core.solver_bridge import SolverBridge


def _build_selector_feedback(rejected: List[Dict]) -> Dict:
    return {
        "instruction": (
            "Do not re-select rejected strategies. "
            "Pick another candidate that satisfies graph dependencies and batch constraints."
        ),
        "rejected_attempts": rejected,
    }


def _build_strategist_feedback(gate_report: Dict, selected_attempts: List[Dict]) -> Dict:
    return {
        "instruction": (
            "Your previous 3 strategies failed graph gate checks. "
            "Generate 3 NEW strategies that satisfy all dependency and batch constraints."
        ),
        "why_failed": gate_report.get("strategy_reports", []),
        "selector_attempts": selected_attempts,
    }


def _phase2_graph_gated_loop(
    phase1_json: Dict,
    root_dir: str,
    generated_dir: str,
    scene_g_path: Optional[str],
    max_prompt1_rounds: int = 3,
    max_prompt2_retries: int = 5,
) -> Tuple[bool, Optional[Dict], Optional[Dict], Dict, str]:
    """
    Returns:
      success,
      accepted_prompt1_output,
      accepted_prompt2_output,
      final_gate_report,
      debug_message
    """
    vlm = VLMClient()
    strategist_prompt = os.path.join(root_dir, "prompts", "phase2_strategist.md")
    selector_prompt = os.path.join(root_dir, "prompts", "phase2_selector.md")

    strategist_feedback = None
    last_gate_report = {
        "passed": False,
        "errors": ["gatekeeper not started"],
        "strategy_reports": [],
        "all_failed": False,
    }

    for p1_round in range(1, max_prompt1_rounds + 1):
        print(f"[Phase2][Gate] Prompt1 round {p1_round}/{max_prompt1_rounds}")
        p1_out = vlm.phase2_generate_strategies(
            phase1_json,
            strategist_prompt,
            rejection_feedback=strategist_feedback,
        )

        p1_round_path = os.path.join(generated_dir, f"phase2_prompt1_output_round_{p1_round}.json")
        with open(p1_round_path, "w", encoding="utf-8") as f:
            json.dump(p1_out, f, indent=2, ensure_ascii=True)

        rejected_attempts = []
        tried_selected_ids = set()

        for p2_round in range(1, max_prompt2_retries + 1):
            print(f"[Phase2][Gate] Prompt2 round {p2_round}/{max_prompt2_retries} (under P1 round {p1_round})")

            p2_feedback = _build_selector_feedback(rejected_attempts) if rejected_attempts else None
            p2_out = vlm.phase2_select_strategy(
                phase1_json,
                p1_out,
                selector_prompt,
                rejection_feedback=p2_feedback,
            )

            p2_round_path = os.path.join(generated_dir, f"phase2_prompt2_output_round_{p1_round}_{p2_round}.json")
            with open(p2_round_path, "w", encoding="utf-8") as f:
                json.dump(p2_out, f, indent=2, ensure_ascii=True)

            gate_report = validate_phase2_selection(
                phase1_json=phase1_json,
                prompt1_output=p1_out,
                prompt2_output=p2_out,
                scene_g_path=scene_g_path,
            )
            gate_report["round"] = {"prompt1": p1_round, "prompt2": p2_round}

            selected_id = p2_out.get("selected")
            if selected_id in tried_selected_ids:
                gate_report["passed"] = False
                gate_report.setdefault("errors", []).append(
                    f"selector repeated previously rejected strategy: {selected_id}"
                )
            tried_selected_ids.add(selected_id)

            gate_path = os.path.join(generated_dir, f"phase2_gate_report_round_{p1_round}_{p2_round}.json")
            save_gate_report(gate_path, gate_report)
            last_gate_report = gate_report

            if gate_report.get("passed"):
                print(f"[Phase2][Gate] PASS with selected strategy: {selected_id}")

                with open(os.path.join(generated_dir, "phase2_prompt1_output.json"), "w", encoding="utf-8") as f:
                    json.dump(p1_out, f, indent=2, ensure_ascii=True)
                with open(os.path.join(generated_dir, "phase2_prompt2_output.json"), "w", encoding="utf-8") as f:
                    json.dump(p2_out, f, indent=2, ensure_ascii=True)
                save_gate_report(os.path.join(generated_dir, "phase2_gate_report.json"), gate_report)

                return True, p1_out, p2_out, gate_report, "gatekeeper accepted"

            rejected_attempts.append(
                {
                    "selected": p2_out.get("selected"),
                    "reason": p2_out.get("reason", ""),
                    "gate_errors": gate_report.get("errors", []),
                }
            )

            if len(tried_selected_ids) >= 3 or gate_report.get("all_failed"):
                print("[Phase2][Gate] All current strategies rejected. Escalate back to Prompt1.")
                break

        strategist_feedback = _build_strategist_feedback(last_gate_report, rejected_attempts)

    return False, None, None, last_gate_report, "all strategist rounds exhausted"


def _legacy_placeholder_failure(node_id: int):
    msg = (
        "[Phase2] Legacy image+XML path has been superseded by graph-gated JSON path. "
        "Please pass Phase1 objects+edges graph to run the new pipeline."
    )
    print(msg)
    return False, None, None, {"node_id": node_id, "status": "legacy_not_supported"}, [], msg


def run_phase2_pipeline(
    node_data,
    current_g_path,
    full_target_graph,
    inventory_data,
    history_chain,
    stop_before_solver: bool = False,
):
    """
    New Phase2 graph-gated pipeline.

    If full_target_graph has Phase1 schema (objects+edges):
      Prompt1 -> Prompt2 -> Gatekeeper loop -> Python codegen -> (optional) solver

    Returns a legacy-compatible tuple:
      success, output_g_path, result_img_path, node_summary, used_ids, stdout
    """
    root_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
    generated_dir = os.path.join(root_dir, "generated")
    os.makedirs(generated_dir, exist_ok=True)

    node_id = 1
    if isinstance(node_data, dict):
        node_id = node_data.get("node_id", 1)

    print(f"\n[Phase2] >>> Initiating graph-gated execution for Node {node_id}...")

    if not (isinstance(full_target_graph, dict) and "objects" in full_target_graph):
        return _legacy_placeholder_failure(node_id)

    scene_g_path = os.path.join(root_dir, "generated", "scene", "scene_named.g")
    if current_g_path and os.path.exists(current_g_path):
        scene_g_path = current_g_path

    ok, p1_out, p2_out, gate_report, debug_msg = _phase2_graph_gated_loop(
        phase1_json=full_target_graph,
        root_dir=root_dir,
        generated_dir=generated_dir,
        scene_g_path=scene_g_path,
    )

    if not ok:
        stdout = json.dumps({"phase2_gatekeeper": gate_report, "message": debug_msg}, ensure_ascii=True)
        return False, None, None, {"node_id": node_id, "status": "gate_failed"}, [], stdout

    task_dir = os.path.join(generated_dir, f"node_{node_id}_run")
    print(f"[Phase2] Generating execution files into: {task_dir}")
    files = generate_step_files(full_target_graph, p1_out, p2_out, task_dir)

    node_summary = {
        "node_id": node_id,
        "status": "phase2_codegen_ready",
        "selected": p2_out.get("selected"),
        "reason": p2_out.get("reason", ""),
        "generated_files": [os.path.basename(p) for p in files],
    }

    stdout_lines = [
        "[Phase2] Gatekeeper PASS",
        f"[Phase2] Selected strategy: {p2_out.get('selected')}",
        f"[Phase2] Output directory: {task_dir}",
        "[Phase2] Files:",
    ]
    stdout_lines.extend([f"  - {os.path.basename(p)}" for p in files])
    stdout = "\n".join(stdout_lines)

    if stop_before_solver:
        print("[Phase2] stop_before_solver=True -> skip solver execution.")
        return True, None, None, node_summary, [], stdout

    solver_path = os.path.join(root_dir, "bin", "x.exe")
    solver = SolverBridge(executable_path=solver_path)
    success, output_g_path, solver_stdout = solver.run(task_dir, current_g_path)

    merged_stdout = stdout + "\n\n" + (solver_stdout or "")
    return success, output_g_path, None, node_summary, [], merged_stdout
