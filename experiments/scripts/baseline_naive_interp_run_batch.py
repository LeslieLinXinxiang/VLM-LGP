#!/usr/bin/env python3
"""
Track 2 (VLM-MSGraph naive-interpolation baseline) — Phase 5: full-scale batch runner.

Iterates the Cube Stacking scenario matrix (`experiments/scenes/{mag}/{s_folder}/random_trials/
trial_{NN}_{mode}.g`), derives the task assignment once per (mag, scenario) via Phase 1.2
(`baseline_naive_interp_task_assignment.extract_action_sequence`, itself reused per-trial only
for the scene-specific object renaming), executes the whole action sequence via Phase 3
(`baseline_naive_interp_execute.execute_trial`), and writes one `trial_meta.json` + one final
screenshot per trial under `experiments/evaluations/Baseline_execution/cubeStacking/...`.

FMB is intentionally out of scope for this runner: FMB's manipulable objects are mostly
`shape:mesh` geometry, and the Phase 2 converter (`baseline_naive_interp_convert_g_to_mjcf`)
does not yet emit a collision geom for mesh objects (only box/cylinder) - running FMB now
would silently produce objects with no physical body. Revisit once mesh geometry is added.

Video recording is off by default (`--record-video` to enable per-run) - it roughly doubles
wall time and produces ~100KB-1MB per trial, not worth it for a batch sweep whose job is
producing numbers, not footage; re-run a specific trial standalone (see
`baseline_naive_interp_execute.py`'s `__main__`) if a result needs visual inspection.
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
import traceback
from pathlib import Path
from typing import Dict, List, Optional

ROOT_DIR = Path(__file__).resolve().parents[2]
if str(ROOT_DIR) not in sys.path:
    sys.path.insert(0, str(ROOT_DIR))

from experiments.scripts.baseline_naive_interp_execute import execute_trial  # noqa: E402
from experiments.scripts.baseline_naive_interp_scene_parser import parse_scene  # noqa: E402
from experiments.scripts.baseline_naive_interp_task_assignment import (  # noqa: E402
    _extract_final_json_from_md,
    _extract_gt_trial,
    extract_action_sequence,
)

OUT_ROOT = ROOT_DIR / "experiments" / "evaluations" / "Baseline_execution" / "cubeStacking"


def _summarize_trial_result(result: Dict) -> Dict:
    """Reduces execute_trial's full log into the two things this batch cares about: did it
    finish cleanly, and how bad was any collision (severity = deepest penetration + how many
    physics steps it was in violation for, not just a yes/no)."""
    actions = result.get("actions", [])
    all_violations: List[Dict] = []
    for a in actions:
        all_violations.extend(a.get("violations", []))
    max_penetration_m = min((v["dist"] for v in all_violations), default=0.0)  # most negative = deepest
    n_actions = len(actions)
    n_actions_ok = sum(1 for a in actions if a["success"])
    n_actions_collided = sum(1 for a in actions if a.get("collision_violation"))
    place_errors = [a["final_place_error"] for a in actions if a.get("final_place_error") is not None]
    return {
        "success": bool(result.get("success")),
        "n_actions": n_actions,
        "n_actions_completed_ok": n_actions_ok,
        "collision_violation": len(all_violations) > 0,
        "n_actions_with_collision": n_actions_collided,
        "max_penetration_m": max_penetration_m,
        "total_violation_samples": len(all_violations),
        "mean_final_place_error_m": (sum(place_errors) / len(place_errors)) if place_errors else None,
        "snapshot": result.get("snapshot"),
        "video": result.get("video"),
    }


def run_one_trial(mag: str, s_folder: str, mode: str, trial_name: str, phase1_json: Dict, record_video: bool) -> Dict:
    scene_g = ROOT_DIR / "experiments" / "scenes" / mag / s_folder / "random_trials" / f"{trial_name}.g"
    case_name = f"cube_n{int(mag.replace('cubes', '')):02d}_{s_folder}"
    trial_dir = OUT_ROOT / mag / s_folder / mode / trial_name / "naive_interp"
    ta_dir = trial_dir / "task_assignment"

    t0 = time.time()
    sequence, scene_named_path = extract_action_sequence(scene_g, phase1_json, ta_dir)
    scene = parse_scene(scene_named_path)
    exec_dir = trial_dir / "exec"
    result = execute_trial(scene_named_path, sequence, scene, exec_dir, render_snapshot=True, record_video=record_video)
    wall_s = time.time() - t0

    meta = {
        "mode_name": "naive_interp",
        "benchmark": "cubeStacking",
        "mag": mag,
        "case": case_name,
        "redundancy_mode": mode,
        "trial": trial_name,
        "scene": str(scene_g),
        "action_sequence": sequence,
        "wall_time_s": wall_s,
        **_summarize_trial_result(result),
    }
    trial_dir.mkdir(parents=True, exist_ok=True)
    (trial_dir / "trial_meta.json").write_text(json.dumps(meta, indent=2))
    return meta


# --- FMB benchmark ---
# Mirrors run_one_trial()/main() above but for FMB's own directory/naming conventions:
# magnitudes are "{n}objs" (not "{n}cubes"), scenario folders are "s001".."s005" (zero-padded
# to 3, not 2), case names in the accuracy report / VLM ground-truth path are the bare zero-
# padded scenario number ("003", not "cube_n08_s03"). extract_action_sequence/execute_trial
# themselves are already benchmark-agnostic (scene path + phase1_json in, action log out), so
# this only needs its own path-construction glue, not a parallel execution engine.
FMB_OUT_ROOT = ROOT_DIR / "experiments" / "evaluations" / "Baseline_execution" / "FMB"


def run_one_trial_fmb(mag: str, s_folder: str, mode: str, trial_name: str, phase1_json: Dict, record_video: bool) -> Dict:
    scene_g = ROOT_DIR / "experiments" / "scenes" / "fmb" / mag / s_folder / "random_trials" / f"{trial_name}.g"
    case_name = s_folder.lstrip("s")
    trial_dir = FMB_OUT_ROOT / mag / s_folder / mode / trial_name / "naive_interp"
    ta_dir = trial_dir / "task_assignment"

    t0 = time.time()
    sequence, scene_named_path = extract_action_sequence(scene_g, phase1_json, ta_dir)
    scene = parse_scene(scene_named_path)
    exec_dir = trial_dir / "exec"
    result = execute_trial(scene_named_path, sequence, scene, exec_dir, render_snapshot=True, record_video=record_video)
    wall_s = time.time() - t0

    meta = {
        "mode_name": "naive_interp",
        "benchmark": "FMB",
        "mag": mag,
        "case": case_name,
        "redundancy_mode": mode,
        "trial": trial_name,
        "scene": str(scene_g),
        "action_sequence": sequence,
        "wall_time_s": wall_s,
        **_summarize_trial_result(result),
    }
    trial_dir.mkdir(parents=True, exist_ok=True)
    (trial_dir / "trial_meta.json").write_text(json.dumps(meta, indent=2))
    return meta


def main_fmb(args) -> None:
    phase1_json_cache: Dict[str, Dict] = {}
    total = completed = failed_hard = 0

    for mag in args.fmb_mags:
        acc_report_path = ROOT_DIR / "experiments" / "outputs" / "gemini_proposed_method" / "accuracy_analysis" / "FMB" / mag / "accuracy_report.md"
        if not acc_report_path.exists():
            print(f"[SKIP mag={mag}] no accuracy_report.md at {acc_report_path}")
            continue

        for s_idx in range(1, args.scenarios + 1):
            s_folder = f"s{s_idx:03d}"
            case_name = f"{s_idx:03d}"
            cache_key = f"{mag}/{s_folder}"
            try:
                if cache_key not in phase1_json_cache:
                    gt_trial_num = _extract_gt_trial(acc_report_path, case_name)
                    vlm_md = ROOT_DIR / "experiments" / "evaluations" / "VLM" / "gemini_proposed_method" / "FMB" / mag / case_name / f"trial_{gt_trial_num}.md"
                    phase1_json_cache[cache_key] = _extract_final_json_from_md(vlm_md)
                phase1_json = phase1_json_cache[cache_key]
            except Exception as e:
                print(f"[SKIP {cache_key}] could not load GT phase1_json: {e}")
                continue

            for mode in args.modes:
                for t_idx in range(1, args.trials_per_scenario + 1):
                    trial_name = f"trial_{t_idx:02d}_{mode}"
                    total += 1
                    trial_meta_path = FMB_OUT_ROOT / mag / s_folder / mode / trial_name / "naive_interp" / "trial_meta.json"
                    if args.skip_existing and trial_meta_path.exists():
                        print(f"[SKIP existing] {mag}/{s_folder}/{trial_name}")
                        completed += 1
                        continue
                    scene_g = ROOT_DIR / "experiments" / "scenes" / "fmb" / mag / s_folder / "random_trials" / f"{trial_name}.g"
                    if not scene_g.exists():
                        print(f"[SKIP missing scene] {scene_g}")
                        continue
                    print(f"[RUN] fmb/{mag}/{s_folder}/{mode}/{trial_name} ...", flush=True)
                    try:
                        meta = run_one_trial_fmb(mag, s_folder, mode, trial_name, phase1_json, args.record_video)
                        completed += 1
                        print(
                            f"  -> success={meta['success']} collision={meta['collision_violation']} "
                            f"max_pen={meta['max_penetration_m']:.4f}m actions_ok={meta['n_actions_completed_ok']}/{meta['n_actions']} "
                            f"wall={meta['wall_time_s']:.1f}s"
                        )
                    except Exception as e:
                        failed_hard += 1
                        print(f"  -> HARD FAILURE: {e}")
                        traceback.print_exc()

    print(f"\n=== FMB batch done: {completed}/{total} trials completed, {failed_hard} hard failures ===")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--benchmark", choices=["cubeStacking", "fmb"], default="cubeStacking")
    parser.add_argument("--mags", nargs="+", default=["4cubes", "5cubes", "6cubes", "7cubes", "8cubes"])
    parser.add_argument("--fmb-mags", nargs="+", default=["3objs", "4objs", "5objs"])
    parser.add_argument("--scenarios", type=int, default=5, help="how many s01..sNN scenarios per magnitude")
    parser.add_argument("--modes", nargs="+", default=["nr", "r"])
    parser.add_argument("--trials-per-scenario", type=int, default=10)
    parser.add_argument("--record-video", action="store_true")
    parser.add_argument("--skip-existing", action="store_true", default=True)
    args = parser.parse_args()

    if args.benchmark == "fmb":
        main_fmb(args)
        return

    acc_report_cache: Dict[str, Path] = {}
    phase1_json_cache: Dict[str, Dict] = {}

    total = 0
    completed = 0
    failed_hard = 0

    for mag in args.mags:
        mag_num = mag.replace("cubes", "").zfill(2)
        acc_report_path = ROOT_DIR / "experiments" / "outputs" / "gemini_proposed_method" / "accuracy_analysis" / "cubeStacking" / mag / "accuracy_report.md"
        if not acc_report_path.exists():
            print(f"[SKIP mag={mag}] no accuracy_report.md at {acc_report_path}")
            continue

        for s_idx in range(1, args.scenarios + 1):
            s_folder = f"s{s_idx:02d}"
            case_name = f"cube_n{mag_num}_s{s_idx:02d}"
            cache_key = f"{mag}/{s_folder}"
            try:
                if cache_key not in phase1_json_cache:
                    gt_trial_num = _extract_gt_trial(acc_report_path, case_name)
                    vlm_md = ROOT_DIR / "experiments" / "evaluations" / "VLM" / "gemini_proposed_method" / "cubeStacking" / mag / case_name / f"trial_{gt_trial_num}.md"
                    phase1_json_cache[cache_key] = _extract_final_json_from_md(vlm_md)
                phase1_json = phase1_json_cache[cache_key]
            except Exception as e:
                print(f"[SKIP {cache_key}] could not load GT phase1_json: {e}")
                continue

            for mode in args.modes:
                for t_idx in range(1, args.trials_per_scenario + 1):
                    trial_name = f"trial_{t_idx:02d}_{mode}"
                    total += 1
                    trial_meta_path = OUT_ROOT / mag / s_folder / mode / trial_name / "naive_interp" / "trial_meta.json"
                    if args.skip_existing and trial_meta_path.exists():
                        print(f"[SKIP existing] {mag}/{s_folder}/{trial_name}")
                        completed += 1
                        continue
                    scene_g = ROOT_DIR / "experiments" / "scenes" / mag / s_folder / "random_trials" / f"{trial_name}.g"
                    if not scene_g.exists():
                        print(f"[SKIP missing scene] {scene_g}")
                        continue
                    print(f"[RUN] {mag}/{s_folder}/{mode}/{trial_name} ...", flush=True)
                    try:
                        meta = run_one_trial(mag, s_folder, mode, trial_name, phase1_json, args.record_video)
                        completed += 1
                        print(
                            f"  -> success={meta['success']} collision={meta['collision_violation']} "
                            f"max_pen={meta['max_penetration_m']:.4f}m actions_ok={meta['n_actions_completed_ok']}/{meta['n_actions']} "
                            f"wall={meta['wall_time_s']:.1f}s"
                        )
                    except Exception as e:
                        failed_hard += 1
                        print(f"  -> HARD FAILURE: {e}")
                        traceback.print_exc()

    print(f"\n=== batch done: {completed}/{total} trials completed, {failed_hard} hard failures ===")


if __name__ == "__main__":
    main()
