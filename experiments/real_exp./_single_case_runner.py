#!/usr/bin/env python3
"""Shared single-case runner for real experiment folders."""

from __future__ import annotations

import argparse
import importlib.util
import json
import os
import re
import shutil
import subprocess
from dataclasses import dataclass
from pathlib import Path

ROOT_DIR = Path(__file__).resolve().parents[2]

import sys

if str(ROOT_DIR) not in sys.path:
    sys.path.insert(0, str(ROOT_DIR))

from pipeline.run_phase0 import execute_phase0
from core.phase2_codegen import generate_step_files
import core.phase2_codegen as p2_codegen
from core.deployment_export import export_trajectory_and_gripper_bundle


@dataclass(frozen=True)
class CaseConfig:
    name: str
    vlm_md_rel: str
    scene_rel: str
    out_dir: Path


def add_common_arguments(parser: argparse.ArgumentParser) -> argparse.ArgumentParser:
    parser.add_argument(
        "--max-batch-size",
        type=int,
        default=2,
        help="LayerBasedClustering max batch size.",
    )
    parser.add_argument(
        "--collision-policy",
        default="active_runtime",
        help="Collision policy passed to solver.",
    )
    parser.add_argument(
        "--timeout",
        type=int,
        default=600,
        help="Solver timeout in seconds.",
    )
    parser.add_argument(
        "--log",
        default=None,
        help="Solver log path. Used by --only-export or when skipping solver.",
    )
    parser.add_argument(
        "--only-export",
        action="store_true",
        help="Only export traj/gripper from an existing solver log.",
    )
    parser.add_argument(
        "--skip-solver",
        action="store_true",
        help="Generate scene/steps but do not run solver.",
    )
    parser.add_argument(
        "--keep-existing-steps",
        action="store_true",
        help="Keep existing lgp_split_smart directory and reuse files.",
    )
    return parser


def _load_layer_based_clustering_class():
    module_path = ROOT_DIR / "test" / "layer_based_clustering" / "run_layer_based_codegen.py"
    spec = importlib.util.spec_from_file_location("layer_based_codegen", str(module_path))
    module = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(module)
    return module.LayerBasedClustering


LayerBasedClustering = _load_layer_based_clustering_class()


def _extract_final_json_from_md(md_path: Path) -> dict:
    content = md_path.read_text(encoding="utf-8")
    fenced = re.search(
        r"## FINAL_JSON_START\s*```(?:json)?\n(.*?)\n```\s*## FINAL_JSON_END",
        content,
        re.DOTALL,
    )
    if fenced:
        return json.loads(fenced.group(1))

    raw = re.search(r"## FINAL_JSON_START\s*(\{.*?\})\s*## FINAL_JSON_END", content, re.DOTALL)
    if raw:
        return json.loads(raw.group(1))

    raise ValueError(f"No FINAL_JSON block found: {md_path}")


def _modify_scene_for_real_exp(input_scene: Path, output_scene: Path) -> None:
    content = input_scene.read_text(encoding="utf-8")

    content = re.sub(r"table\s*\(world\)[^\n]*\n?", "", content)

    replacement = (
        "\n"
        "base (world) { shape:ssBox, size:[1.3 1.0 .11 .02], Q:\"t(0 0 .545)\", color:[.45 .45 .45], contact:1 }\n"
        "table (base) { shape:ssBox, size:[1.0 0.8 .1 .02], Q:\"t(0 0.25 .11)\", color:[.3 .3 .3], contact:1, logical:{ is_place } }\n"
    )
    content = content.replace("world {}", "world {}" + replacement)
    content = re.sub(
        r"Edit l_panda_base\s*\([^)]+\):.*",
        'Edit l_panda_base (base): { Q: "t(0 -.3 .05) d(90 0 0 1)" }',
        content,
    )

    # Fix marker parent naming: map obj_<NN> -> longrect_<NN>
    # Example: obj_04_Left(obj_04) -> longrect_04_Left(longrect_04)
    content = re.sub(r"\bobj_(0*\d+)\b", r"longrect_\1", content)

    output_scene.write_text(content, encoding="utf-8")


def _shared_fol_content() -> str:
    return (
        p2_codegen._fol_header()
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


def _run_solver(exec_dir: Path, scene_g: Path, collision_policy: str, timeout_s: int) -> tuple[bool, str]:
    solver = ROOT_DIR / "bin" / "x.exe"
    cmd = [str(solver), str(exec_dir.resolve()), str(scene_g.resolve()), f"--collision-policy={collision_policy}"]

    proc = subprocess.Popen(
        cmd,
        cwd=str(ROOT_DIR / "bin"),
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
    )
    stdout, _ = proc.communicate(timeout=timeout_s)

    log_path = exec_dir.parent / "solver_run.log"
    log_path.write_text(stdout, encoding="utf-8")

    output_state = exec_dir / "output_state.g"
    if proc.returncode != 0 or not output_state.exists():
        return False, stdout
    return True, stdout


def _resolve_log_path(out_dir: Path, log_arg: str | None) -> Path:
    if log_arg:
        p = Path(log_arg)
        if not p.is_absolute():
            p = (ROOT_DIR / p).resolve()
        return p

    candidates = [out_dir / "solver_run.log"]
    candidates.extend(sorted(out_dir.glob("solver_run*.log"), key=os.path.getmtime, reverse=True))
    for p in candidates:
        if p.exists() and p.is_file():
            return p

    raise FileNotFoundError(f"No solver log found in {out_dir}. Please pass --log.")


def _export_from_log(out_dir: Path, log_path: Path, case_name: str) -> None:
    stdout = log_path.read_text(encoding="utf-8")
    result = export_trajectory_and_gripper_bundle(
        stdout=stdout,
        output_dir=out_dir,
        traj_filename="traj.txt",
        gripper_filename="gripper.txt",
    )
    print(f"[{case_name}] Export complete")
    print(f"  log: {log_path}")
    print(f"  output: {out_dir}")
    print(f"  traj.txt lines: {result['trajectory_line_count']}")
    print(f"  gripper.txt toggles: {len(result['toggle_lines'])}")


def run_case(cfg: CaseConfig, args: argparse.Namespace) -> int:
    out_dir = cfg.out_dir.resolve()
    out_dir.mkdir(parents=True, exist_ok=True)
    exec_dir = out_dir / "lgp_split_smart"
    existing_lgp_files = sorted(exec_dir.glob("*.lgp")) if exec_dir.exists() else []
    reuse_existing_exec = bool(existing_lgp_files) and (exec_dir / "shared_rules.fol").exists()

    if args.only_export:
        log_path = _resolve_log_path(out_dir, args.log)
        _export_from_log(out_dir, log_path, cfg.name)
        return 0

    orig_scene = (ROOT_DIR / cfg.scene_rel).resolve()
    md_path = (ROOT_DIR / cfg.vlm_md_rel).resolve()
    elevated_scene = out_dir / "scene_named.g"

    if elevated_scene.exists():
        print(f"[{cfg.name}] [1/6] Using existing scene: {elevated_scene}")
    else:
        _modify_scene_for_real_exp(orig_scene, elevated_scene)
        print(f"[{cfg.name}] [1/6] Scene generated from original: {elevated_scene}")

    if reuse_existing_exec:
        print(f"[{cfg.name}] [2/6] Reusing existing execution files in {exec_dir} (skip md/phase0/codegen)")
        print(f"[{cfg.name}] [3/6] Step preparation skipped")
        print(f"[{cfg.name}] [4/6] Step files ready")
    else:
        phase1_json = _extract_final_json_from_md(md_path)
        print(f"[{cfg.name}] [2/6] FINAL_JSON loaded: {md_path}")

        phase0 = execute_phase0(
            use_vlm=False,
            scene_named_g_path=str(elevated_scene),
            auto_prepare_from_named_scene=True,
            reachability_mode="gmm_esdf_mvp",
        )
        if not phase0 or not phase0.get("success"):
            print(f"[{cfg.name}] Phase0 failed")
            return 1

        layout_path = Path(phase0["layout_path"])
        layout_data = json.loads(layout_path.read_text(encoding="utf-8"))
        if isinstance(layout_data, dict) and "inventory" in layout_data:
            layout_data = layout_data["inventory"]
        print(f"[{cfg.name}] [3/6] Phase0 inventory prepared")

        if not args.keep_existing_steps:
            if exec_dir.exists():
                shutil.rmtree(exec_dir)
            exec_dir.mkdir(parents=True, exist_ok=True)

            clustering = LayerBasedClustering(phase1_json=phase1_json, max_batch_size=args.max_batch_size)
            plan = clustering.build_execution_plan()

            generate_step_files(
                phase1_json=phase1_json,
                prompt1_output=plan["prompt1"],
                prompt2_output=plan["prompt2"],
                out_dir=str(exec_dir),
                inventory_data=layout_data,
            )

            shared_fol = exec_dir / "shared_rules.fol"
            fol_content = _shared_fol_content()

            fol_objects = [
                "l_gripper",
                "table",
                "Table_Left",
                "Table_Center",
                "Table_Right",
                "Table_Back",
                "Table_Front",
            ]
            for item in layout_data:
                logical_id = item.get("logical_id", "")
                if not logical_id:
                    continue
                fol_objects.append(logical_id)
                if logical_id.startswith("rect") or logical_id.startswith("longrect"):
                    fol_objects.append(f"{logical_id}_Left")
                    fol_objects.append(f"{logical_id}_Right")
                    fol_objects.append(f"{logical_id}_Center")

            fol_objs_str = " ".join(sorted(set(fol_objects)))
            fol_content = fol_content.replace(
                "START_STATE {}",
                "START_STATE { (is_gripper l_gripper)\n " + fol_objs_str + "\n}",
            )
            shared_fol.write_text(fol_content, encoding="utf-8")

            for lgp_file in exec_dir.glob("*.lgp"):
                text = lgp_file.read_text(encoding="utf-8")
                text = re.sub(r"fol:\s*<[^>]+>", "fol: <shared_rules.fol>", text)
                text = re.sub(r"genericCollisions:\s*(true|false)", "genericCollisions: false", text)
                text = re.sub(r"coll:\s*\[[^\]]*\]", "coll: []", text)
                lgp_file.write_text(text, encoding="utf-8")

            for fol_file in list(exec_dir.glob("*.fol")):
                if fol_file.name != "shared_rules.fol":
                    fol_file.unlink()

            print(f"[{cfg.name}] [4/6] Step files generated in {exec_dir}")
        else:
            print(f"[{cfg.name}] [4/6] Reusing existing step files in {exec_dir}")

    if args.skip_solver:
        print(f"[{cfg.name}] [5/6] Solver skipped by --skip-solver")
        if args.log:
            log_path = _resolve_log_path(out_dir, args.log)
            _export_from_log(out_dir, log_path, cfg.name)
            print(f"[{cfg.name}] [6/6] Exported from provided log")
        else:
            print(f"[{cfg.name}] [6/6] Done (no export, no --log provided)")
        return 0

    success, stdout = _run_solver(
        exec_dir=exec_dir,
        scene_g=elevated_scene,
        collision_policy=args.collision_policy,
        timeout_s=args.timeout,
    )

    if not success:
        print(f"[{cfg.name}] Solver failed. See: {out_dir / 'solver_run.log'}")
        return 2

    export_trajectory_and_gripper_bundle(
        stdout=stdout,
        output_dir=out_dir,
        traj_filename="traj.txt",
        gripper_filename="gripper.txt",
    )
    print(f"[{cfg.name}] [5/6] Solver success")
    print(f"[{cfg.name}] [6/6] Exported traj.txt and gripper.txt")
    return 0
