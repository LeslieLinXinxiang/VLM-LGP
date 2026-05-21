#!/usr/bin/env python3
import argparse
import importlib.util
import json
import os
import re
import select
import shutil
import subprocess
import sys
import time
from datetime import datetime
from typing import Dict, List, Tuple

import psutil

ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "../.."))
if ROOT_DIR not in sys.path:
    sys.path.insert(0, ROOT_DIR)

import core.phase2_codegen as p2_codegen
from core.phase2_codegen import build_id_to_name, generate_step_files
from pipeline.run_phase0 import execute_phase0

MANIP_DIR = os.path.join(ROOT_DIR, "test", "manipulability")
if MANIP_DIR not in sys.path:
    sys.path.insert(0, MANIP_DIR)

from urdf_static_manipulability import compute_static_manipulability_report


def _load_layer_based_clustering_class():
    module_path = os.path.join(
        ROOT_DIR,
        "test",
        "layer_based_clustering",
        "run_layer_based_codegen.py",
    )
    spec = importlib.util.spec_from_file_location("layer_based_codegen", module_path)
    if spec is None or spec.loader is None:
        raise ImportError(f"Cannot load layer-based module: {module_path}")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    if not hasattr(module, "LayerBasedClustering"):
        raise ImportError("LayerBasedClustering not found in run_layer_based_codegen.py")
    return module.LayerBasedClustering


LayerBasedClustering = _load_layer_based_clustering_class()


def _read_text(path: str) -> str:
    with open(path, "r", encoding="utf-8") as f:
        return f.read()


def _write_text(path: str, text: str) -> None:
    with open(path, "w", encoding="utf-8") as f:
        f.write(text)


def _extract_final_json_from_md(md_path: str) -> Dict:
    content = _read_text(md_path)
    fenced = re.search(r"## FINAL_JSON_START\s*```(?:json)?\n(.*?)\n```\s*## FINAL_JSON_END", content, re.DOTALL)
    if fenced:
        return json.loads(fenced.group(1))

    raw = re.search(r"## FINAL_JSON_START\s*(\{.*?\})\s*## FINAL_JSON_END", content, re.DOTALL)
    if raw:
        return json.loads(raw.group(1))

    raise ValueError(f"No FINAL_JSON block found: {md_path}")


def _extract_gt_trial(accuracy_md: str, case_name: str) -> str:
    text = _read_text(accuracy_md)
    for line in text.splitlines():
        if f"| {case_name} |" in line:
            cells = [c.strip() for c in line.split("|") if c.strip()]
            if len(cells) < 2:
                continue
            gt_cell = cells[-1]
            m = re.match(r"T(\d{2})", gt_cell)
            if m:
                return m.group(1)
    raise ValueError(f"GT trial not found for {case_name} in {accuracy_md}")


def _load_inventory() -> List[Dict]:
    path = os.path.join(ROOT_DIR, "generated", "phase0_layout.json")
    if not os.path.exists(path):
        return []
    data = json.loads(_read_text(path))
    return data.get("inventory", []) if isinstance(data, dict) else []


def _prepare_scene_with_reachability_and_manipulability(input_scene_g: str, out_root: str) -> Dict:
    phase0_result = execute_phase0(
        use_vlm=False,
        scene_named_g_path=os.path.abspath(input_scene_g),
        auto_prepare_from_named_scene=True,
        reachability_mode="gmm_esdf_mvp",
    )
    if not phase0_result or not phase0_result.get("success"):
        raise RuntimeError("Phase0 preprocess failed before minimal LGP test")

    scene_ready = phase0_result["scene_named_path"]
    layout_path = phase0_result["layout_path"]
    infeasible_path = phase0_result["infeasible_path"]

    manip_report = compute_static_manipulability_report(
        layout_path=layout_path,
        infeasible_path=infeasible_path,
        g_path=scene_ready,
        urdf_path=os.path.join(ROOT_DIR, "rai", "test", "newLGP", "rai-robotModels", "panda", "panda_arm_hand.urdf"),
    )
    manip_report_path = os.path.join(out_root, "preprocess_manipulability_report.json")
    _write_text(manip_report_path, json.dumps(manip_report, indent=2, ensure_ascii=True))

    return {
        "scene_ready": scene_ready,
        "layout_path": layout_path,
        "infeasible_path": infeasible_path,
        "reachability_score_path": phase0_result.get("reachability_score_path"),
        "manip_report_path": manip_report_path,
    }


def _split_prompt(phase1_json: Dict) -> Tuple[Dict, Dict]:
    clustering = LayerBasedClustering(phase1_json=phase1_json, max_batch_size=2)
    result = clustering.build_execution_plan()
    return result["prompt1"], result["prompt2"]


def _shared_fol_content() -> str:
    # One fol with all core rules to be reused by all split .lgp tasks.
    return (
        p2_codegen._FOL_HEADER
        + p2_codegen._RULE_PICK_TOUCH
        + "\n"
        + p2_codegen._RULE_PICK_CYLINDER
        + "\n"
        + p2_codegen._RULE_PLACE_STRAIGHT
        + "\n"
        + p2_codegen._RULE_PLACE_2
        + "\n"
        + p2_codegen._RULE_PLACE_3
        + "\n"
        + p2_codegen._RULE_PLACE_4
        + "\n"
    )


def _lgp_terminal_for_object(obj: Dict, id_to_name: Dict[int, str]) -> str:
    obj_name = id_to_name[obj["id"]]
    return p2_codegen._terminal(obj_name, obj["edges"], id_to_name)


def _build_monolithic_files(
    phase1_json: Dict,
    out_dir: str,
    inventory: List[Dict],
    global_collision: bool,
) -> Tuple[List[str], int]:
    objects = sorted(phase1_json.get("objects", []), key=lambda o: o["id"])
    move_objs = [o for o in objects if isinstance(o.get("id"), int) and o["id"] >= 1]

    id_to_name = build_id_to_name(objects, inventory)
    terminals: List[str] = []
    for obj in move_objs:
        if not obj.get("edges"):
            raise ValueError(f"Object id={obj['id']} has no supporters/edges.")
        terminals.append(_lgp_terminal_for_object(obj, id_to_name))

    shared_fol = os.path.join(out_dir, "plan_all.fol")
    _write_text(shared_fol, _shared_fol_content())

    lgp_path = os.path.join(out_dir, "plan_all.lgp")
    lgp_text = (
        "fol: <plan_all.fol>\n"
        f'terminal: " {' '.join(terminals)} "\n'
        f"genericCollisions: {'true' if global_collision else 'false'}\n"
        "coll: []\n"
    )
    _write_text(lgp_path, lgp_text)

    return [shared_fol, lgp_path], 1


def _build_split_files(
    phase1_json: Dict,
    out_dir: str,
    inventory: List[Dict],
    global_collision: bool,
) -> Tuple[List[str], int]:
    p1, p2 = _split_prompt(phase1_json)
    generated = generate_step_files(
        phase1_json=phase1_json,
        prompt1_output=p1,
        prompt2_output=p2,
        out_dir=out_dir,
        inventory_data=inventory,
    )

    shared_fol = os.path.join(out_dir, "shared_rules.fol")
    _write_text(shared_fol, _shared_fol_content())

    lgp_files = sorted([p for p in generated if p.endswith(".lgp")])
    for lgp in lgp_files:
        text = _read_text(lgp)
        text = re.sub(r"fol:\s*<[^>]+>", "fol: <shared_rules.fol>", text)
        text = re.sub(r"genericCollisions:\s*(true|false)", f"genericCollisions: {'true' if global_collision else 'false'}", text)
        text = re.sub(r"coll:\s*\[[^\]]*\]", "coll: []", text)
        _write_text(lgp, text)

    for path in generated:
        if path.endswith(".fol") and os.path.basename(path) != "shared_rules.fol" and os.path.exists(path):
            os.remove(path)

    final_files = [shared_fol] + lgp_files
    return final_files, len(lgp_files)


def _run_solver(exec_dir: str, scene_g: str, max_mem_mb: int, timeout_s: int, kill_at_system_mem_pct: int, collision_policy: str) -> Dict:
    solver = os.path.join(ROOT_DIR, "bin", "x.exe")
    cmd = [solver, os.path.abspath(exec_dir), os.path.abspath(scene_g), f"--collision-policy={collision_policy}"]

    start = time.time()
    stdout_lines: List[str] = []
    peak_mb = 0.0
    memory_exceeded = False
    timeout_hit = False

    proc = subprocess.Popen(
        cmd,
        cwd=os.path.join(ROOT_DIR, "bin"),
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        bufsize=1,
    )

    try:
        while True:
            if proc.poll() is not None:
                break

            elapsed = time.time() - start
            if elapsed > timeout_s:
                timeout_hit = True
                proc.kill()
                break

            vm = psutil.virtual_memory()
            if vm.percent >= kill_at_system_mem_pct:
                memory_exceeded = True
                proc.kill()
                break

            try:
                p = psutil.Process(proc.pid)
                rss = p.memory_info().rss
                for c in p.children(recursive=True):
                    try:
                        rss += c.memory_info().rss
                    except psutil.Error:
                        pass
                peak_mb = max(peak_mb, rss / (1024.0 * 1024.0))
                if peak_mb >= max_mem_mb:
                    memory_exceeded = True
                    proc.kill()
                    break
            except psutil.Error:
                pass

            if proc.stdout is not None:
                ready, _, _ = select.select([proc.stdout], [], [], 0.2)
                if ready:
                    line = proc.stdout.readline()
                    if line:
                        stdout_lines.append(line)
            else:
                time.sleep(0.2)

        if proc.stdout is not None:
            rest = proc.stdout.read()
            if rest:
                stdout_lines.append(rest)

        rc = proc.returncode if proc.returncode is not None else -9
        runtime = time.time() - start
        output_state = os.path.join(exec_dir, "output_state.g")
        success = (rc == 0) and os.path.exists(output_state) and (not memory_exceeded) and (not timeout_hit)

        return {
            "success": success,
            "runtime_s": runtime,
            "exit_code": rc,
            "timeout": timeout_hit,
            "memory_exceeded": memory_exceeded,
            "memory_peak_mb": round(peak_mb, 2),
            "stdout": "".join(stdout_lines),
            "output_state_exists": os.path.exists(output_state),
        }
    finally:
        try:
            proc.kill()
        except Exception:
            pass


def _clear_mode_dirs(out_root: str, mode_dirs: List[str]) -> None:
    for mode in mode_dirs:
        path = os.path.join(out_root, mode)
        if os.path.exists(path):
            shutil.rmtree(path)


def main() -> None:
    parser = argparse.ArgumentParser(description="Run minimal 3-mode LGP test")
    parser.add_argument("--case", default="cube_n04_s01")
    parser.add_argument("--scene", default=os.path.join(ROOT_DIR, "experiments/scenes/4cubes/s01/random_trials/trial_01_nr.g"))
    parser.add_argument("--max-mem-mb", type=int, default=16000)
    parser.add_argument("--timeout-s", type=int, default=300)
    parser.add_argument("--kill-at-system-mem-pct", type=int, default=99)
    parser.add_argument("--skip-preprocess", action="store_true", help="Skip reachability/manipulability scene preprocessing")
    parser.add_argument("--mode", choices=["lgp_monolithic", "lgp_split_global", "lgp_split_smart"], help="Run only a specific mode")
    args = parser.parse_args()

    case = args.case
    eval_root = os.path.join(ROOT_DIR, "experiments/evaluations/VLM/gemini_proposed_method/cubeStacking/4cubes", case)
    acc_report = os.path.join(ROOT_DIR, "experiments/outputs/gemini_proposed_method/accuracy_analysis/cubeStacking/4cubes/accuracy_report.md")

    gt_num = _extract_gt_trial(acc_report, case)
    trial_md = os.path.join(eval_root, f"trial_{gt_num}.md")
    phase1_json = _extract_final_json_from_md(trial_md)

    scene_name = os.path.splitext(os.path.basename(args.scene))[0]
    out_root = os.path.join(
        ROOT_DIR,
        "experiments/evaluations/LGP/cubeStacking/4cubes",
        case,
        scene_name,
    )
    os.makedirs(out_root, exist_ok=True)

    preprocess_info = {
        "scene_ready": os.path.abspath(args.scene),
        "layout_path": os.path.join(ROOT_DIR, "generated", "phase0_layout.json"),
        "infeasible_path": os.path.join(ROOT_DIR, "generated", "infeasible_objects.json"),
        "reachability_score_path": os.path.join(ROOT_DIR, "generated", "reachability_score_report.json"),
        "manip_report_path": None,
        "preprocess_enabled": not args.skip_preprocess,
    }

    if not args.skip_preprocess:
        preprocess_info = {
            **preprocess_info,
            **_prepare_scene_with_reachability_and_manipulability(args.scene, out_root),
        }

    inventory = _load_inventory()

    mode_specs = [
        {
            "name": "lgp_monolithic",
            "build": lambda d: _build_monolithic_files(phase1_json, d, inventory, global_collision=True),
            "collision_policy": "follow_lgp",
            "collision_mode": "global",
        },
        {
            "name": "lgp_split_global",
            "build": lambda d: _build_split_files(phase1_json, d, inventory, global_collision=True),
            "collision_policy": "follow_lgp",
            "collision_mode": "global",
        },
        {
            "name": "lgp_split_smart",
            "build": lambda d: _build_split_files(phase1_json, d, inventory, global_collision=True),
            "collision_policy": "active_runtime",
            "collision_mode": "smart_runtime",
        },
    ]

    if args.mode:
        mode_specs = [m for m in mode_specs if m["name"] == args.mode]
        if not mode_specs:
            print(f"Error: mode {args.mode} not found in specs.")
            return

    # _clear_mode_dirs(out_root, [m["name"] for m in mode_specs] + ["lgp_split_manual", "lgp_split_manual_smart_collision"])
    # Commented out clear_mode_dirs to preserve other modes if we run only one
    for spec in mode_specs:
        mode_dir = os.path.join(out_root, spec["name"])
        if os.path.exists(mode_dir):
            shutil.rmtree(mode_dir)

    summary = {
        "case": case,
        "scene": os.path.abspath(args.scene),
        "scene_ready": os.path.abspath(preprocess_info["scene_ready"]),
        "gt_trial": gt_num,
        "phase1_source": os.path.abspath(trial_md),
        "preprocess": preprocess_info,
        "started_at": datetime.now().isoformat(),
        "modes": {},
    }

    for spec in mode_specs:
        mode = spec["name"]
        mode_dir = os.path.join(out_root, mode)
        os.makedirs(mode_dir, exist_ok=True)

        generated_files, batch_count = spec["build"](mode_dir)

        result = _run_solver(
            exec_dir=mode_dir,
            scene_g=preprocess_info["scene_ready"],
            max_mem_mb=args.max_mem_mb,
            timeout_s=args.timeout_s,
            kill_at_system_mem_pct=args.kill_at_system_mem_pct,
            collision_policy=spec["collision_policy"],
        )

        stdout_path = os.path.join(mode_dir, "solver_stdout.log")
        _write_text(stdout_path, result.pop("stdout"))

        meta = {
            "mode": mode,
            "collision_mode": spec["collision_mode"],
            "collision_policy": spec["collision_policy"],
            "batch_count": batch_count,
            "generated_files": [os.path.basename(x) for x in generated_files],
            "scene_file": os.path.abspath(preprocess_info["scene_ready"]),
            "phase1_source": os.path.abspath(trial_md),
            **result,
        }

        with open(os.path.join(mode_dir, "trial_meta.json"), "w", encoding="utf-8") as f:
            json.dump(meta, f, indent=2, ensure_ascii=True)

        summary["modes"][mode] = meta
        print(f"[{mode}] success={meta['success']} runtime={meta['runtime_s']:.2f}s mem_peak={meta['memory_peak_mb']}MB")

    summary["finished_at"] = datetime.now().isoformat()
    with open(os.path.join(out_root, "summary.json"), "w", encoding="utf-8") as f:
        json.dump(summary, f, indent=2, ensure_ascii=True)

    print("\n=== MINIMAL TEST DONE ===")
    print(f"Output root: {out_root}")
    print(json.dumps({m: {"success": v["success"], "runtime_s": v["runtime_s"]} for m, v in summary["modes"].items()}, indent=2))


if __name__ == "__main__":
    main()
