#!/usr/bin/env python3
"""
Pure LLM Baseline Resume Runner
--------------------------------
Scans all cube-stacking scene files and resumes unfinished cases only.

Behavior:
- Uses the same multimodal input contract as run_llm_baseline_pilot.py:
  prompt + target image + scene inventory text.
- Iterates every .g file under experiments/scenes/{mag}/{scenario}/random_trials/.
- Skips cases whose output markdown already exists and contains a raw VLM response.
- Supports optional explicit exclusion list for currently running scenes.

Recommended usage:
- Let the current baseline run finish.
- Start this script in a new terminal to continue the remaining cases.
"""

import argparse
import datetime as dt
import os
import sys
import traceback
from pathlib import Path

from PIL import Image


ROOT_DIR = Path(__file__).resolve().parents[2]
sys.path.append(str(ROOT_DIR))

from core.vlm import VLMClient


MAGNITUDES = ["4cubes", "5cubes", "6cubes", "7cubes", "8cubes"]
SCENARIOS = ["s01", "s02", "s03", "s04", "s05"]
PROMPT_PATH = ROOT_DIR / "prompts/baseline_pure_llm.md"
OUTPUT_ROOT = ROOT_DIR / "experiments/evaluations/VLM/pure_llm_baseline"


def print_banner(msg: str) -> None:
    print("\n" + "=" * 72)
    print(f"  {msg}")
    print("=" * 72 + "\n")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Resume pure LLM baseline and skip completed cases.")
    parser.add_argument("--mags", nargs="*", default=MAGNITUDES, help="Subset of magnitude folders to process.")
    parser.add_argument("--scenarios", nargs="*", default=SCENARIOS, help="Subset of scenario folders to process.")
    parser.add_argument(
        "--exclude-scene",
        action="append",
        default=[],
        help="Relative or absolute scene .g path to skip. Can be repeated.",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Only print what would run; do not call the VLM.",
    )
    return parser.parse_args()


def scene_output_md_path(mag: str, scenario: str, scene_file: Path) -> Path:
    return OUTPUT_ROOT / mag / scenario / f"{scene_file.stem}.md"


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def md_has_completed_response(md_path: Path) -> bool:
    if not md_path.exists():
        return False
    try:
        text = read_text(md_path)
    except Exception:
        return False
    return "## VLM Raw Response (Pure LLM Output)" in text and ("```xml" in text or "> [ERROR]" in text)


def normalize_path_set(paths: list[str]) -> set[str]:
    normalized = set()
    for item in paths:
        p = Path(item)
        if p.is_absolute():
            normalized.add(str(p.resolve()))
        else:
            normalized.add(str((ROOT_DIR / p).resolve()))
    return normalized


def collect_scene_files(mag: str, scenario: str) -> list[Path]:
    trial_dir = ROOT_DIR / "experiments/scenes" / mag / scenario / "random_trials"
    if not trial_dir.exists():
        return []
    return sorted(trial_dir.glob("*.g"))


def save_baseline_md(out_dir: Path, trial_name: str, image_path: Path, scene_path: Path, raw_output, elapsed: float) -> Path:
    out_dir.mkdir(parents=True, exist_ok=True)
    ts = dt.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    fpath = out_dir / f"{trial_name}.md"

    with fpath.open("w", encoding="utf-8") as f:
        f.write(f"# Baseline Trial: {trial_name}\n\n")
        f.write(f"- **Timestamp**: {ts}\n")
        f.write(f"- **Elapsed**: {elapsed:.1f}s\n")
        f.write(f"- **Input Image**: `{os.path.relpath(image_path, ROOT_DIR)}`\n")
        f.write(f"- **Input Scene**: `{os.path.relpath(scene_path, ROOT_DIR)}`\n\n")
        f.write("## VLM Raw Response (Pure LLM Output)\n\n")
        if raw_output:
            f.write("```xml\n")
            f.write(str(raw_output))
            f.write("\n```\n")
        else:
            f.write("> [ERROR] No response received from VLM.\n")

    return fpath


def run_case(client: VLMClient, base_prompt: str, mag: str, scenario: str, scene_path: Path, exclude_set: set[str], dry_run: bool) -> str:
    image_name = f"cube_n{mag.replace('cubes', '').zfill(2)}_{scenario}.png"
    image_path = ROOT_DIR / "experiments/inputs/cubeStacking" / mag / image_name
    if not image_path.exists():
        return f"SKIP missing image: {image_path}"

    abs_scene = str(scene_path.resolve())
    if abs_scene in exclude_set:
        return f"SKIP excluded scene: {scene_path}"

    out_dir = OUTPUT_ROOT / mag / scenario
    out_md = scene_output_md_path(mag, scenario, scene_path)

    if md_has_completed_response(out_md):
        return f"SKIP completed: {os.path.relpath(out_md, ROOT_DIR)}"

    if dry_run:
        return f"DRY-RUN would run: {os.path.relpath(scene_path, ROOT_DIR)} -> {os.path.relpath(out_md, ROOT_DIR)}"

    try:
        with scene_path.open("r", encoding="utf-8") as sf:
            inventory = sf.read()

        scene_block = "\n\n--- \n## SCENE INVENTORY (Input Data)\n```lisp\n" + inventory + "\n```\n---"
        with Image.open(image_path) as img:
            img_pil = img.copy()

        prompt_content = [
            base_prompt,
            "\n--- \n## TARGET IMAGE\n",
            img_pil,
            scene_block,
        ]

        t0 = dt.datetime.now()
        raw_output = client._call_vlm_with_retry(prompt_content, is_json_output=False)
        elapsed = (dt.datetime.now() - t0).total_seconds()
        md_path = save_baseline_md(out_dir, scene_path.stem, image_path, scene_path, raw_output, elapsed)
        return f"DONE {os.path.relpath(md_path, ROOT_DIR)}"

    except Exception:
        err = traceback.format_exc()
        md_path = save_baseline_md(out_dir, scene_path.stem, image_path, scene_path, f"EXCEPTION DURING RESUME RUN:\n{err}", 0.0)
        return f"FAIL {os.path.relpath(md_path, ROOT_DIR)}"


def main() -> int:
    args = parse_args()
    exclude_set = normalize_path_set(args.exclude_scene)

    print_banner("PURE LLM BASELINE RESUME")
    print(f"Prompt   : {os.path.relpath(PROMPT_PATH, ROOT_DIR)}")
    print(f"Output   : {os.path.relpath(OUTPUT_ROOT, ROOT_DIR)}")
    if exclude_set:
        print("Excluded :")
        for item in sorted(exclude_set):
            print(f"  - {item}")
    print()

    client = VLMClient()
    base_prompt = PROMPT_PATH.read_text(encoding="utf-8")

    total = 0
    skipped = 0
    finished = 0
    failed = 0

    for mag in args.mags:
        if mag not in MAGNITUDES:
            print(f"[WARN] Unknown mag ignored: {mag}")
            continue
        for scenario in args.scenarios:
            if scenario not in SCENARIOS:
                print(f"[WARN] Unknown scenario ignored: {scenario}")
                continue

            scene_files = collect_scene_files(mag, scenario)
            if not scene_files:
                print(f"[WARN] No scenes found under {mag}/{scenario}")
                continue

            print_banner(f"{mag} / {scenario}  ({len(scene_files)} scenes)")
            for scene_path in scene_files:
                total += 1
                result = run_case(client, base_prompt, mag, scenario, scene_path, exclude_set, args.dry_run)
                print(result)
                if result.startswith("SKIP"):
                    skipped += 1
                elif result.startswith("DONE"):
                    finished += 1
                else:
                    failed += 1

    print_banner("RESUME SUMMARY")
    print(f"Total scanned : {total}")
    print(f"Skipped       : {skipped}")
    print(f"Finished      : {finished}")
    print(f"Failed        : {failed}")
    return 0


if __name__ == "__main__":
    sys.exit(main())