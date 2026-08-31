#!/usr/bin/env python3
"""
FMB Full Batch LGP Evaluation.

Supports:
    - lgp_split_smart
    - lgp_split_global
    - lgp_combined (single merged task file per trial)

VLM plans: experiments/evaluations/VLM/gemini_proposed_method/FMB/{Nobjs}/{NNN}/trial_XX.md
Scenes:     experiments/scenes/fmb/{Nobjs}/{sNNN}/random_trials/trial_XX_{mode}.g
Output:     experiments/evaluations/LGP/FMB/{Nobjs}/{sNNN}/trial_XX_{mode}/<mode>/
"""
import argparse
import json
import os
import re
import shutil
import sys
import time
from pathlib import Path

import psutil
import subprocess
import select

ROOT_DIR = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT_DIR))

from core.phase2_codegen import generate_step_files
from pipeline.run_phase0 import execute_phase0

import importlib.util

def _load_layer_based_clustering():
    module_path = ROOT_DIR / "test/layer_based_clustering/run_layer_based_codegen.py"
    spec = importlib.util.spec_from_file_location("layer_based_codegen", str(module_path))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module.LayerBasedClustering

LayerBasedClustering = _load_layer_based_clustering()


def _extract_json_from_md(md_path: Path) -> dict:
    content = md_path.read_text(encoding="utf-8")
    # Try fenced first
    m = re.search(r"## FINAL_JSON_START\s*```(?:json)?\n(.*?)\n```\s*## FINAL_JSON_END", content, re.DOTALL)
    if m:
        return json.loads(m.group(1))
    # Raw block
    m = re.search(r"## FINAL_JSON_START\s*(\{.*?\})\s*## FINAL_JSON_END", content, re.DOTALL)
    if m:
        return json.loads(m.group(1))
    raise ValueError(f"No FINAL_JSON block in {md_path}")


def _selected_strategy(prompt1: dict, prompt2: dict) -> dict:
    raw_list = prompt1.get("strategies", prompt1.get("candidates", []))
    selected_id = prompt2["selected"]
    selected = next((s for s in raw_list if s["id"] == selected_id), None)
    if selected is None:
        raise ValueError(f"Strategy '{selected_id}' not found in Prompt1 output.")
    return selected


def _run_solver(exec_dir: Path, scene_g: Path, timeout_s: int, max_mem_mb: int, collision_policy: str = "active_runtime") -> dict:
    solver = ROOT_DIR / "bin/x.exe"
    cmd = [str(solver), str(exec_dir.resolve()), str(scene_g.resolve()), f"--collision-policy={collision_policy}"]
    start = time.time()
    stdout_lines = []
    peak_mb = 0.0
    memory_exceeded = False
    timeout_hit = False

    proc = subprocess.Popen(cmd, cwd=str(ROOT_DIR / "bin"),
                            stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                            text=True, bufsize=1)
    try:
        ps_proc = psutil.Process(proc.pid)
        while True:
            if proc.poll() is not None:
                break
            elapsed = time.time() - start
            if elapsed > timeout_s:
                timeout_hit = True
                proc.kill()
                break
            try:
                rss = ps_proc.memory_info().rss
                for c in ps_proc.children(recursive=True):
                    try: rss += c.memory_info().rss
                    except psutil.Error: pass
                peak_mb = max(peak_mb, rss / 1024.0 / 1024.0)
                if peak_mb >= max_mem_mb:
                    memory_exceeded = True
                    proc.kill()
                    break
            except psutil.Error:
                pass
            if proc.stdout:
                ready, _, _ = select.select([proc.stdout], [], [], 0.3)
                if ready:
                    line = proc.stdout.readline()
                    if line: stdout_lines.append(line)
            else:
                time.sleep(0.3)
        if proc.stdout:
            rest = proc.stdout.read()
            if rest: stdout_lines.append(rest)
        rc = proc.returncode if proc.returncode is not None else -9
        runtime = time.time() - start
        output_state = exec_dir / "output_state.g"
        success = (rc == 0) and output_state.exists() and not memory_exceeded and not timeout_hit
        return {
            "success": success,
            "runtime_s": round(runtime, 2),
            "exit_code": rc,
            "timeout": timeout_hit,
            "memory_exceeded": memory_exceeded,
            "memory_peak_mb": round(peak_mb, 2),
            "stdout": "".join(stdout_lines),
        }
    finally:
        try: proc.kill()
        except: pass


def run_one(vlm_md, scene_g, trial_work_dir, timeout_s, max_mem_mb, mode_filter: str | None = None):
    trial_work_dir.mkdir(parents=True, exist_ok=True)

    # Phase 0
    phase0 = execute_phase0(
        use_vlm=False,
        unnamed_g_path=str(scene_g),
        auto_prepare_from_named_scene=False,
        reachability_mode="gmm_esdf_mvp",
        disable_physics_reordering=True,  # Keep original object names from scene file
    )
    if not phase0 or not phase0.get("success"):
        return [{"success": False, "error": "phase0_failed", "runtime_s": 0}]

    scene_ready = Path(phase0["scene_named_path"])
    layout = phase0["layout"]

    # Phase 1 JSON
    phase1_json = _extract_json_from_md(vlm_md)

    # Clustering + codegen
    clustering = LayerBasedClustering(phase1_json=phase1_json, max_batch_size=2)
    plan = clustering.build_execution_plan()
    selected_strategy = _selected_strategy(plan["prompt1"], plan["prompt2"])

    results = []

    mode_specs = [
        {
            "name": "lgp_split_smart",
            "collision_policy": "active_runtime",
            "collision_mode": "smart",
            "combine_terminals": False,
        },
        {
            "name": "lgp_split_global",
            "collision_policy": "follow_lgp",
            "collision_mode": "global",
            "combine_terminals": False,
        },
        {
            "name": "lgp_combined",
            "collision_policy": "follow_lgp",
            "collision_mode": "global",
            "combine_terminals": True,
        },
    ]

    if mode_filter:
        mode_specs = [m for m in mode_specs if m["name"] == mode_filter]
        if not mode_specs:
            raise ValueError(f"Unknown mode_filter: {mode_filter}")

    for spec in mode_specs:
        lgp_mode = spec["name"]
        mode_dir = trial_work_dir / lgp_mode
        if (mode_dir / "trial_meta.json").exists():
            # A definitive result (success, timeout, or OOM) was already recorded for this
            # submode - re-running would just reproduce the same outcome. cached=True tells
            # main() not to overwrite the existing trial_meta.json.
            print(f"  - {lgp_mode} already has a recorded result, skipping.")
            results.append({"success": (mode_dir / "output_state.g").exists(), "cached": True, "mode": lgp_mode})
            continue

        if mode_dir.exists():
            shutil.rmtree(mode_dir)
        mode_dir.mkdir(parents=True, exist_ok=True)

        policy = spec["collision_policy"]
        coll_mode = spec["collision_mode"]

        generate_step_files(
            phase1_json=phase1_json,
            prompt1_output=plan["prompt1"],
            prompt2_output=plan["prompt2"],
            out_dir=str(mode_dir),
            inventory_data=layout,
            collision_mode=coll_mode,
            combine_terminals=spec["combine_terminals"],
        )

        print(f"  - Running {lgp_mode} (policy={policy})...")
        solver_res = _run_solver(exec_dir=mode_dir, scene_g=scene_ready, timeout_s=timeout_s, max_mem_mb=max_mem_mb, collision_policy=policy)
        (mode_dir / "solver_stdout.log").write_text(solver_res.pop("stdout"), encoding="utf-8")
        solver_res["mode"] = lgp_mode
        results.append(solver_res)

    return results


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--mags", nargs="+", default=["3objs", "4objs", "5objs"])
    parser.add_argument("--modes", nargs="+", choices=["nr", "r"], default=["nr", "r"])
    parser.add_argument("--trials", nargs="+", type=int, default=list(range(1, 11)))
    parser.add_argument("--timeout-s", type=int, default=300)
    parser.add_argument("--max-mem-mb", type=int, default=16000)
    parser.add_argument("--skip-existing", action="store_true")
    parser.add_argument("--scenarios", nargs="+", default=["001", "002", "003", "004", "005"])
    parser.add_argument("--mode", choices=["lgp_split_smart", "lgp_split_global", "lgp_combined"], default=None)
    args = parser.parse_args()

    vlm_base = ROOT_DIR / "experiments/evaluations/VLM/gemini_proposed_method/FMB"
    scene_base = ROOT_DIR / "experiments/scenes/fmb"
    out_base = ROOT_DIR / "experiments/evaluations/LGP/FMB"

    total = 0
    success = 0
    fail = 0
    skip = 0
    results_log = []

    for mag in args.mags:
        for scen_num in args.scenarios:
            scen_id = f"s{scen_num}"  # e.g. s001
            for trial_idx in args.trials:
                # VLM md path uses 3-digit number dir and trial_XX.md
                vlm_md = vlm_base / mag / scen_num / f"trial_{trial_idx:02d}.md"
                if not vlm_md.exists():
                    print(f"  [SKIP] VLM md missing: {vlm_md}")
                    skip += 1
                    continue

                for mode in args.modes:
                    scene_g = scene_base / mag / scen_id / "random_trials" / f"trial_{trial_idx:02d}_{mode}.g"
                    if not scene_g.exists():
                        print(f"  [SKIP] Scene missing: {scene_g}")
                        skip += 1
                        continue

                    trial_work_dir = out_base / mag / scen_id / f"trial_{trial_idx:02d}_{mode}"

                    if args.mode:
                        if args.skip_existing and (trial_work_dir / args.mode / "trial_meta.json").exists():
                            print(f"  [CACHED] {mag}/{scen_id}/trial_{trial_idx:02d}_{mode} [{args.mode}]")
                            skip += 1
                            continue
                    else:
                        all_submodes = ["lgp_split_smart", "lgp_split_global", "lgp_combined"]
                        if args.skip_existing and all((trial_work_dir / m / "trial_meta.json").exists() for m in all_submodes):
                            print(f"  [CACHED] {mag}/{scen_id}/trial_{trial_idx:02d}_{mode}")
                            skip += 1
                            continue

                    total += 1
                    tag = f"{mag}/{scen_id}/trial_{trial_idx:02d}_{mode}"
                    print(f"\n[{total}] Running: {tag}")

                    try:
                        res_list = run_one(vlm_md, scene_g, trial_work_dir, timeout_s=args.timeout_s, max_mem_mb=args.max_mem_mb, mode_filter=args.mode)
                    except Exception as e:
                        res_list = [{"success": False, "error": str(e), "runtime_s": 0}]

                    for res in res_list:
                        ok = res.get("success", False)
                        if ok:
                            success += 1
                        else:
                            fail += 1

                        status = "✓" if ok else "✗"
                        print(f"  {status} [{res.get('mode', 'unk')}] success={ok} runtime={res.get('runtime_s', 0):.1f}s "
                              f"mem={res.get('memory_peak_mb', 0):.0f}MB "
                              f"timeout={res.get('timeout', False)} oom={res.get('memory_exceeded', False)}")

                        if not res.get("cached", False):
                            # Save per-trial meta
                            meta = {"tag": tag, "vlm_md": str(vlm_md), "scene_g": str(scene_g), **res}
                            mode_sub = res.get('mode', 'unk')
                            if mode_sub != 'unk':
                                (trial_work_dir / mode_sub / "trial_meta.json").write_text(json.dumps(meta, indent=2), encoding="utf-8")
                            results_log.append(meta)


    # Summary
    print(f"\n{'='*60}")
    print(f"DONE. Total={total}  Success={success}  Fail={fail}  Skipped={skip}")
    if total > 0:
        print(f"Success rate: {success/total*100:.1f}%")

    # Save aggregate
    agg_path = out_base / "batch_results.json"
    agg_path.parent.mkdir(parents=True, exist_ok=True)
    agg_path.write_text(json.dumps({"total": total, "success": success, "fail": fail,
                                     "skip": skip, "results": results_log}, indent=2), encoding="utf-8")
    print(f"Aggregate saved: {agg_path}")


if __name__ == "__main__":
    main()
