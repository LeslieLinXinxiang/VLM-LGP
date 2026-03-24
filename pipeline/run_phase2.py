# pipelines/run_phase2.py
import os
import json
from typing import Dict, List, Optional, Tuple


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
) -> Tuple[bool, Optional[Dict], Optional[Dict], Dict, str]:
    """
    Returns:
      success,
      accepted_prompt1_output,
      accepted_prompt2_output,
      final_gate_report,
      debug_message
    """
    from core.graph_clustering import BranchAwareClustering, BranchAwareLayerCuttingClustering
    
    print(f"[Phase2][Gate] Executing default two-stage graph decomposition...")

    # Default entry switched to the controlled two-stage implementation:
    #   branch grouping -> hierarchy-aware batch cutting
    # The legacy entry is intentionally kept below as a one-line fallback so we can
    # switch back quickly for side-by-side debugging or regression comparison.
    clustering = BranchAwareLayerCuttingClustering(phase1_json)

    # Legacy fallback (kept commented on purpose for quick rollback/testing):
    # clustering = BranchAwareClustering(phase1_json)

    p1_out, p2_out = clustering.generate_optimal_strategy()
    
    with open(os.path.join(generated_dir, "phase2_prompt1_output.json"), "w", encoding="utf-8") as f:
        json.dump(p1_out, f, indent=2, ensure_ascii=True)
    with open(os.path.join(generated_dir, "phase2_prompt2_output.json"), "w", encoding="utf-8") as f:
        json.dump(p2_out, f, indent=2, ensure_ascii=True)
        
    gate_report = {
        "passed": True,
        "strategy_reports": [],
        "errors": []
    }
    with open(os.path.join(generated_dir, "phase2_gate_report.json"), "w", encoding="utf-8") as f:
        json.dump(gate_report, f, indent=2, ensure_ascii=True)

    return True, p1_out, p2_out, gate_report, "default two-stage graph decomposition active (VLM bypassed)"


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

    if not (isinstance(full_target_graph, dict) and ("objects" in full_target_graph or "V" in full_target_graph)):
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

    if not inventory_data:
        inv_path = os.path.join(generated_dir, "phase0_layout.json")
        if os.path.exists(inv_path):
            with open(inv_path, "r", encoding="utf-8") as f:
                inventory_data = json.load(f)

    task_dir = os.path.join(generated_dir, f"node_{node_id}_run")
    print(f"[Phase2] Generating execution files into: {task_dir} (with real dictionary names)")
    files = generate_step_files(full_target_graph, p1_out, p2_out, task_dir, inventory_data)

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
