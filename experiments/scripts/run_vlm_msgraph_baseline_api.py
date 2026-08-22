#!/usr/bin/env python3
"""Run prompts/baseline_vlm_msgraph_style_v1.md against Gemini for all 40 Track 1
tasks and write raw completions to trial_NN.md (same format as a manual paste).

Task list is derived from the same 40 (benchmark, magnitude, case) cells the manual
round used — cubeStacking {4..8}cubes x 5 scenarios, FMB {3..5}objs x 5 samples — read
from experiments/configs/*_target_spec.json, which is also what the manual round's
part counts were cross-checked against (see FMB/4objs/005 anchor-naming discussion:
that config's counts don't even include the anchor, matching the image's own Object
List legend not labeling it either).

PART_LIST name mapping (config key -> exact string handed to the VLM) was reverse-
verified against real trial_01.md outputs already reviewed as correct — see
cube_n06_s02 ("4 Cubes, 2 RectPrisms"), cube_n04_s04 ("Long RectPrism"), cube_n05_s05
("TriPrism"), and the FMB "Shape 2_1"/"Shape 4_1" indexed-instance naming. Do not
change these strings without re-checking against the image legends; the prompt
(Sec 1) requires the part list name be used exactly as given.

Each output is retried (LLM call retry is inside core.vlm.VLMClient; on top of that,
this script retries up to --max-retries times) until it round-trips through the same
validate_baseline_vlm_msgraph_format.validate_file() check used everywhere else in
this pipeline — so a saved trial file's format-compliance status is known at save
time, not discovered later.

Usage:
    python3 run_vlm_msgraph_baseline_api.py --trial 2
    python3 run_vlm_msgraph_baseline_api.py --trial 2 --only cubeStacking
    python3 run_vlm_msgraph_baseline_api.py --trial 2 --overwrite
    python3 run_vlm_msgraph_baseline_api.py --trial 2 --case cubeStacking/8cubes/cube_n08_s05
"""
from __future__ import annotations

import argparse
import glob
import json
import os
import sys
import tempfile
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
sys.path.insert(0, str(Path(__file__).resolve().parent))

os.environ.setdefault("VLM_BACKEND", "gemini")

from core.vlm import VLMClient  # noqa: E402
from validate_baseline_vlm_msgraph_format import validate_file  # noqa: E402
from PIL import Image  # noqa: E402

PROMPT_PATH = ROOT / "prompts/baseline_vlm_msgraph_style_v1.md"
EVAL_ROOT = ROOT / "experiments/evaluations/VLM/VLM-MSGraph_baseline"
INPUT_ROOT = ROOT / "experiments/inputs"
CONFIG_ROOT = ROOT / "experiments/configs"

# Reverse-verified against real, already-reviewed trial_01.md text — see module
# docstring. Do not derive this programmatically from the config key string.
CUBE_KEY_TO_NAME = {
    "cube": "Cube",
    "rectprism": "RectPrism",
    "long_rectprism": "Long RectPrism",
    "triangular": "TriPrism",
}
FMB_KEY_TO_NAME = {
    "shape_2": "Shape 2",
    "shape_3": "Shape 3",
    "shape_4": "Shape 4",
}

MAX_RETRIES_DEFAULT = 4


def build_part_list(counts: dict, key_to_name: dict) -> str:
    lines = ["PART_LIST:"]
    for key in sorted(counts, key=lambda k: key_to_name.get(k, k)):
        name = key_to_name.get(key)
        if name is None:
            raise KeyError(f"No display-name mapping for part-list key '{key}' — "
                            f"add it to CUBE_KEY_TO_NAME/FMB_KEY_TO_NAME after checking "
                            f"the image's own Object List legend.")
        lines.append(f"- {name}: {counts[key]}")
    return "\n".join(lines)


def collect_tasks() -> list[dict]:
    tasks = []

    for cfg in sorted(CONFIG_ROOT.glob("[0-9]cubes_s0[0-9]_target_spec.json")):
        spec = json.loads(cfg.read_text())
        sid = spec["scenario_id"]  # e.g. "4cubes_s01"
        magnitude, s = sid.split("_")
        n = int(magnitude.replace("cubes", ""))
        k = int(s.replace("s", ""))
        case_name = f"cube_n{n:02d}_s{k:02d}"
        image = INPUT_ROOT / "cubeStacking" / magnitude / f"{case_name}.png"
        tasks.append({
            "benchmark": "cubeStacking",
            "magnitude": magnitude,
            "case_name": case_name,
            "images": [image],
            "part_list": build_part_list(spec["counts"], CUBE_KEY_TO_NAME),
        })

    for cfg in sorted(CONFIG_ROOT.glob("fmb_*objs_s0*_target_spec.json")):
        spec = json.loads(cfg.read_text())
        stem = cfg.stem.replace("_target_spec", "")  # fmb_4objs_s001
        _, magnitude, s = stem.split("_")
        k = int(s.replace("s", ""))
        case_name = f"{k:03d}"
        case_dir = INPUT_ROOT / "FMB" / magnitude / case_name
        images = sorted(case_dir.glob("*.png"))
        tasks.append({
            "benchmark": "FMB",
            "magnitude": magnitude,
            "case_name": case_name,
            "images": images,
            "part_list": build_part_list(spec["counts"], FMB_KEY_TO_NAME),
        })

    def sort_key(t):
        bench_order = {"cubeStacking": 0, "FMB": 1}
        import re
        mag_n = int(re.search(r"\d+", t["magnitude"]).group())
        return (bench_order[t["benchmark"]], mag_n, t["case_name"])

    tasks.sort(key=sort_key)
    return tasks


def call_vlm(client: VLMClient, prompt_template: str, part_list: str, images: list[Path]) -> str:
    prompt_content = [prompt_template, "\n\n" + part_list + "\n"]
    for img_path in images:
        prompt_content.append(Image.open(img_path))
    return client._call_gemini_with_retry(prompt_content, is_json_output=False)


def validate_text(text: str) -> list[str]:
    with tempfile.NamedTemporaryFile("w", suffix=".md", delete=False, encoding="utf-8") as f:
        f.write(text)
        tmp_path = Path(f.name)
    try:
        return validate_file(tmp_path)
    finally:
        tmp_path.unlink(missing_ok=True)


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--trial", type=int, required=True, help="Trial number to (re)generate, e.g. 2.")
    ap.add_argument("--only", choices=["cubeStacking", "FMB"], default=None)
    ap.add_argument("--case", default=None, help="Restrict to one case, e.g. cubeStacking/8cubes/cube_n08_s05")
    ap.add_argument("--overwrite", action="store_true", help="Regenerate even if the trial file already has content.")
    ap.add_argument("--max-retries", type=int, default=MAX_RETRIES_DEFAULT,
                    help="Retries if the saved output fails format validation.")
    args = ap.parse_args()

    tasks = collect_tasks()
    if args.only:
        tasks = [t for t in tasks if t["benchmark"] == args.only]
    if args.case:
        tasks = [t for t in tasks if f"{t['benchmark']}/{t['magnitude']}/{t['case_name']}" == args.case]
    if not tasks:
        raise RuntimeError("No tasks matched the given filters.")

    prompt_template = PROMPT_PATH.read_text(encoding="utf-8")
    client = VLMClient()

    n_ok = n_fail = n_skip = 0
    for i, task in enumerate(tasks, 1):
        key = f"{task['benchmark']}/{task['magnitude']}/{task['case_name']}"
        out_dir = EVAL_ROOT / task["benchmark"] / task["magnitude"] / task["case_name"]
        out_path = out_dir / f"trial_{args.trial:02d}.md"

        if out_path.exists() and out_path.stat().st_size > 0 and not args.overwrite:
            print(f"[{i}/{len(tasks)}] SKIP (already has content) {key}")
            n_skip += 1
            continue

        if not task["images"] or not all(p.exists() for p in task["images"]):
            print(f"[{i}/{len(tasks)}] FAIL (missing input image) {key}")
            n_fail += 1
            continue

        print(f"[{i}/{len(tasks)}] {key}  ({len(task['images'])} image(s), "
              f"part_list: {task['part_list'].splitlines()[1:]})")

        last_text, last_errors = "", ["never attempted"]
        t0 = time.time()
        for attempt in range(1, args.max_retries + 1):
            try:
                text = call_vlm(client, prompt_template, task["part_list"], task["images"])
            except Exception as exc:
                print(f"    attempt {attempt}: API call raised {type(exc).__name__}: {exc}")
                time.sleep(3)
                continue
            errors = validate_text(text)
            last_text, last_errors = text, errors
            if not errors:
                break
            print(f"    attempt {attempt}: format-invalid ({len(errors)} issue(s)), retrying — "
                  f"{errors[0]}")

        elapsed = time.time() - t0
        out_dir.mkdir(parents=True, exist_ok=True)
        out_path.write_text(last_text, encoding="utf-8")

        if not last_errors:
            print(f"    OK  ({elapsed:.1f}s) -> {out_path.relative_to(ROOT)}")
            n_ok += 1
        else:
            print(f"    SAVED WITH FORMAT ERRORS after {args.max_retries} attempts "
                  f"({elapsed:.1f}s) -> {out_path.relative_to(ROOT)}")
            for e in last_errors:
                print(f"      - {e}")
            n_fail += 1

    print("\n" + "=" * 60)
    print(f"Done. trial_{args.trial:02d}: {n_ok} ok, {n_fail} saved-with-errors, {n_skip} skipped "
          f"(of {len(tasks)} tasks)")
    print("Next: python3 experiments/scripts/build_vlm_msgraph_review_index.py")


if __name__ == "__main__":
    main()
