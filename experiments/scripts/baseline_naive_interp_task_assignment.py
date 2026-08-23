#!/usr/bin/env python3
"""
Track 2 (VLM-MSGraph naive-interpolation baseline) — Phase 1.2: task-assignment extractor.

Reuses (does not reimplement) the exact pipeline our own method's batch evaluator already
uses to go from a raw scene `.g` file to an ordered pick-place action sequence, minus the
actual KOMO/LGP solve:

  execute_phase0()   # obj_01 -> cube_1/rectprism_1/... renaming + layout
      -> LayerBasedClustering(phase1_json).build_execution_plan()  # batching/ordering
      -> generate_step_files(...)                    # writes step_N_batch_M.{fol,lgp}
      -> parse each .lgp's `terminal: " (on <To> <Obj>) "` line, in filename order

`phase1_json` is the VLM semantic output for this scenario's ground-truth trial, read from
`experiments/evaluations/VLM/gemini_proposed_method/...` (Track 1 data), with the GT trial
number picked via the same `_extract_gt_trial()` logic as `run_lgp_batch_eval.py`.

Physics-aware reordering is left at its DEFAULT (enabled) - an earlier version of this script
passed `disable_physics_reordering=True` to skip it as an unnecessary KOMO-adjacent step, but
that reordering pass is also where `core/phase0_parser.py`'s object naming gets the FULL-WORD
type prefixes ("rectprism_N", "triprism_N") that `phase1_json` actually references; the
non-reordering default path abbreviates them ("rect_N", "tri_N"). Cube-only scenes never
exposed the mismatch (cube's prefix is "cube" either way), but ~88% of a first full batch run
failed with `KeyError: 'rectprism_1'` etc. the moment a scenario included non-cube/cylinder/
mesh shapes. `run_lgp_batch_eval.py` (the pipeline whose already-solved output this module was
validated against) never passed `disable_physics_reordering` either, i.e. always ran with
reordering on - so enabling it here isn't adding new behavior, it's matching what actually
produced the ground truth this whole module is built to reproduce.
"""
from __future__ import annotations

import importlib.util
import json
import re
import shutil
import sys
from pathlib import Path
from typing import Dict, List, Tuple

ROOT_DIR = Path(__file__).resolve().parents[2]
if str(ROOT_DIR) not in sys.path:
    sys.path.insert(0, str(ROOT_DIR))

from core.phase2_codegen import generate_step_files  # noqa: E402
from pipeline.run_phase0 import execute_phase0  # noqa: E402


def _load_layer_based_clustering_class():
    module_path = ROOT_DIR / "test" / "layer_based_clustering" / "run_layer_based_codegen.py"
    spec = importlib.util.spec_from_file_location("layer_based_codegen", str(module_path))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module.LayerBasedClustering


LayerBasedClustering = _load_layer_based_clustering_class()

_TERMINAL_PATTERN = re.compile(r'terminal\s*:\s*"\s*\(on\s+([^)]+)\)\s*"')
_STEP_FILE_SORT = re.compile(r"step_(\d+)_batch_(\d+)\.lgp$")


def _extract_final_json_from_md(md_path: Path) -> Dict:
    content = md_path.read_text(encoding="utf-8")
    fenced = re.search(r"## FINAL_JSON_START\s*```(?:json)?\n(.*?)\n```\s*## FINAL_JSON_END", content, re.DOTALL)
    if fenced:
        return json.loads(fenced.group(1))
    raw = re.search(r"## FINAL_JSON_START\s*(\{.*?\})\s*## FINAL_JSON_END", content, re.DOTALL)
    if raw:
        return json.loads(raw.group(1))
    raise ValueError(f"No FINAL_JSON block found: {md_path}")


def _extract_gt_trial(accuracy_md: Path, case_name: str) -> str:
    """Reads the `| Case | T01 | ... | GT |` markdown table and returns the GT trial number
    for `case_name`. Matches on the parsed FIRST CELL, not a raw substring search - table
    column widths (and therefore inter-pipe padding) vary between reports, e.g. cube-stacking's
    `cube_n04_s01` needs no padding but FMB's short `001` gets padded to `| 001  |` (two
    spaces), which a fixed `f"| {case_name} |"` substring silently never matches."""
    text = accuracy_md.read_text(encoding="utf-8")
    for line in text.splitlines():
        if "|" not in line:
            continue
        cells = [c.strip() for c in line.split("|") if c.strip()]
        if len(cells) < 2 or cells[0] != case_name:
            continue
        gt_cell = cells[-1]
        m = re.match(r"T(\d{2})", gt_cell)
        if m:
            return m.group(1)
    raise ValueError(f"GT trial not found for {case_name} in {accuracy_md}")


def _step_sort_key(path: Path) -> Tuple[int, int]:
    m = _STEP_FILE_SORT.search(path.name)
    if not m:
        return (10**9, 10**9)
    return (int(m.group(1)), int(m.group(2)))


def extract_action_sequence(
    scene_g_path: Path,
    phase1_json: Dict,
    work_dir: Path,
    max_batch_size: int = 2,
    collision_mode: str = "smart",
) -> List[Tuple[str, List[str]]]:
    """Returns an ordered [(obj, [to1, to2, ...]), ...] list, one entry per
    `terminal: (on To1 [To2 ...] Obj)` line, in step/batch filename order (= the order our own
    method would execute them in). Usually one `to` (place on a named slot or another single
    object), but KOMO's `stableOnMulti` terminals name 2+ supports for a bridging/spanning
    placement (e.g. `(on cube_1 cube_2 rectprism_2)` = rectprism_2 spans both cubes) - about a
    third of all terminals across the cube-stacking dataset are multi-support or reference a
    named sub-frame on another object (e.g. `rectprism_1_Left`) rather than a bare object/slot,
    so both must be handled, not just the single-plain-target case."""
    clustering = LayerBasedClustering(phase1_json=phase1_json, max_batch_size=max_batch_size)
    cluster_res = clustering.build_execution_plan()
    p1, p2 = cluster_res["prompt1"], cluster_res["prompt2"]

    phase0_res = execute_phase0(
        use_vlm=False,
        unnamed_g_path=str(scene_g_path),
        auto_prepare_from_named_scene=False,
        reachability_mode="gmm_esdf_mvp",
    )
    if not phase0_res or not phase0_res.get("success"):
        raise RuntimeError(f"execute_phase0 failed for {scene_g_path}")

    # execute_phase0()'s RULE_DIRECT_G path writes to a HARDCODED shared location
    # (generated/scene/scene_named.g - not controllable via any of its path parameters), so
    # running this concurrently with another process also calling execute_phase0 (e.g. a
    # batch job for a different benchmark) is a real race: the other process can overwrite
    # this file before we're done reading it, silently handing back a WRONG scene (seen in
    # practice - an FMB diagnostic picked up cube-stacking's scene mid-run). Copy it out to a
    # private, work_dir-scoped path immediately, narrowing the race window to essentially zero.
    if work_dir.exists():
        shutil.rmtree(work_dir)
    work_dir.mkdir(parents=True, exist_ok=True)
    shared_scene_named_path = Path(phase0_res["scene_named_path"])
    scene_named_path = work_dir / "scene_named.g"
    shutil.copy2(shared_scene_named_path, scene_named_path)
    inventory = phase0_res["layout"]

    generate_step_files(
        phase1_json=phase1_json,
        prompt1_output=p1,
        prompt2_output=p2,
        out_dir=str(work_dir),
        inventory_data=inventory,
        collision_mode=collision_mode,
    )

    step_files = sorted(work_dir.glob("step_*.lgp"), key=_step_sort_key)
    sequence: List[Tuple[str, List[str]]] = []
    for sf in step_files:
        text = sf.read_text(encoding="utf-8")
        m = _TERMINAL_PATTERN.search(text)
        if not m:
            continue
        tokens = m.group(1).split()
        if len(tokens) < 2:
            continue
        obj, to_frames = tokens[-1], tokens[:-1]
        sequence.append((obj, to_frames))

    return sequence, scene_named_path


if __name__ == "__main__":
    mag = "4cubes"
    s_idx = 1
    t_idx = 1
    mode = "nr"
    case_name = f"cube_n{int(mag.replace('cubes','')):02d}_s{s_idx:02d}"
    s_folder = f"s{s_idx:02d}"

    scene_g = ROOT_DIR / "experiments" / "scenes" / mag / s_folder / "random_trials" / f"trial_{t_idx:02d}_{mode}.g"
    acc_report = ROOT_DIR / "experiments" / "outputs" / "gemini_proposed_method" / "accuracy_analysis" / "cubeStacking" / mag / "accuracy_report.md"
    gt_trial_num = _extract_gt_trial(acc_report, case_name)
    vlm_md = ROOT_DIR / "experiments" / "evaluations" / "VLM" / "gemini_proposed_method" / "cubeStacking" / mag / case_name / f"trial_{gt_trial_num}.md"
    phase1_json = _extract_final_json_from_md(vlm_md)

    work_dir = ROOT_DIR / "experiments" / "evaluations" / "Baseline_execution" / "_phase1_validation" / case_name / mode / f"trial_{t_idx:02d}"

    print(f"case_name={case_name} gt_trial_num=T{gt_trial_num} scene={scene_g}")
    sequence, scene_named_path = extract_action_sequence(scene_g, phase1_json, work_dir)

    print(f"scene_named_path={scene_named_path}")
    print("action sequence (obj -> to):")
    for obj, to in sequence:
        print(f"  {obj} -> {to}")

    expected = [("cube_1", ["Table_Left"]), ("cube_2", ["Table_Center"]), ("cube_3", ["Table_Right"]), ("cube_4", ["cube_2"])]
    actual = sequence
    assert actual == expected, f"MISMATCH vs known-good LGP_execution trial:\n  expected={expected}\n  actual={actual}"
    print("\nself-check PASSED: reproduces the same action sequence as the known-solved "
          "4cubes/s01/nr/trial_01 (lgp_split_smart) LGP_execution output.")
