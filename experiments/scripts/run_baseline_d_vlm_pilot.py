#!/usr/bin/env python3
"""Minimal pilot for the D-VLM baseline prompt (prompts/baseline_d_vlm.md).

Per the commit that added the prompt: cube stacking 4&8 cubes, FMB 3&5 objects,
one structure each (s01 / case 001), 10 trials each. Ground truth for scoring is
the same majority-vote reference already established for our own method's trials
under experiments/evaluations/VLM/gemini_proposed_method/ for these exact four
cases (canonicalize_graph / choose_reference_trial, reused unchanged from
experiments/scripts/analyse_gemini_proposed_method_accuracy.py).

Usage:
    python3 experiments/scripts/run_baseline_d_vlm_pilot.py
"""
import os
import re
import sys
import time
import traceback
from pathlib import Path

os.environ.setdefault("VLM_BACKEND", "gemini")

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
sys.path.insert(0, str(Path(__file__).resolve().parent))

from PIL import Image  # noqa: E402
from core.vlm import VLMClient  # noqa: E402
from analyse_gemini_proposed_method_accuracy import (  # noqa: E402
    canonicalize_graph, normalize_final_block, choose_reference_trial,
    extract_final_block_from_md,
)

PROMPT_PATH = ROOT / "prompts/baseline_d_vlm.md"
OUT_ROOT = ROOT / "experiments/evaluations/VLM/D-VLM_baseline"
REF_ROOT = ROOT / "experiments/evaluations/VLM/gemini_proposed_method"
NUM_TRIALS = 10
MAX_RETRIES = 5

CASES = [
    {"key": "cubeStacking/4cubes/cube_n04_s01",
     "images": [ROOT / "experiments/inputs/cubeStacking/4cubes/cube_n04_s01.png"],
     "ref_dir": REF_ROOT / "cubeStacking/4cubes/cube_n04_s01"},
    {"key": "cubeStacking/8cubes/cube_n08_s01",
     "images": [ROOT / "experiments/inputs/cubeStacking/8cubes/cube_n08_s01.png"],
     "ref_dir": REF_ROOT / "cubeStacking/8cubes/cube_n08_s01"},
    {"key": "FMB/3objs/001",
     "images": sorted((ROOT / "experiments/inputs/FMB/3objs/001").glob("*.png")),
     "ref_dir": REF_ROOT / "FMB/3objs/001"},
    {"key": "FMB/5objs/001",
     "images": sorted((ROOT / "experiments/inputs/FMB/5objs/001").glob("*.png")),
     "ref_dir": REF_ROOT / "FMB/5objs/001"},
]


def load_reference(ref_dir: Path):
    """Majority-vote reference from the existing 10 gemini_proposed_method trials
    for this case -- same methodology already used to score our own method."""
    trials = []
    for md in sorted(ref_dir.glob("trial_*.md")):
        raw = extract_final_block_from_md(md)
        norm = normalize_final_block(raw) if raw else None
        trials.append((md.name, raw, norm))
    gt_trial, gt_norm, freq = choose_reference_trial(trials)
    total_valid = sum(freq.values())
    support = freq.get(gt_norm, 0) / total_valid * 100 if total_valid else 0.0
    return gt_norm, support, len(trials)


def call_d_vlm(vlm, prompt_template, images):
    prompt_content = [prompt_template]
    for idx, ipath in enumerate(images):
        if len(images) > 1:
            prompt_content.append(f"Step {idx + 1} Image:")
        prompt_content.append(Image.open(ipath))
    return vlm._call_vlm_with_retry(prompt_content, is_json_output=False)


def main():
    prompt_template = PROMPT_PATH.read_text(encoding="utf-8")
    vlm = VLMClient()

    results = {}
    for case in CASES:
        key = case["key"]
        gt_norm, support, n_ref_trials = load_reference(case["ref_dir"])
        print(f"\n=== {key} === reference from {n_ref_trials} existing trials, "
              f"support={support:.0f}%, ref_valid={gt_norm is not None}")

        out_dir = OUT_ROOT / key
        out_dir.mkdir(parents=True, exist_ok=True)

        n_match = n_parsed = n_fail = 0
        for trial in range(1, NUM_TRIALS + 1):
            out_path = out_dir / f"trial_{trial:02d}.md"
            print(f"  trial {trial:02d}/{NUM_TRIALS} ... ", end="", flush=True)

            raw_output = None
            t0 = time.time()
            for attempt in range(1, MAX_RETRIES + 1):
                try:
                    raw_output = call_d_vlm(vlm, prompt_template, case["images"])
                    if raw_output:
                        break
                except Exception as exc:
                    print(f"[retry {attempt}: {type(exc).__name__}] ", end="", flush=True)
                    time.sleep(3)
            elapsed = time.time() - t0

            out_path.write_text(raw_output or "(no output)", encoding="utf-8")

            block = extract_final_block_from_md(out_path)
            norm = normalize_final_block(block) if block else None
            if norm is None:
                n_fail += 1
                print(f"FAIL (no parseable FINAL_JSON) ({elapsed:.1f}s)")
                continue
            n_parsed += 1
            match = gt_norm is not None and norm == gt_norm
            if match:
                n_match += 1
            print(f"{'MATCH' if match else 'DIFFER'} ({elapsed:.1f}s)")

        acc = (n_match / NUM_TRIALS * 100) if NUM_TRIALS else 0.0
        results[key] = {"n_match": n_match, "n_parsed": n_parsed, "n_fail": n_fail,
                         "acc": acc, "ref_support": support}
        print(f"  -> {key}: {n_match}/{NUM_TRIALS} match reference "
              f"({acc:.1f}%), {n_parsed}/{NUM_TRIALS} parsed, {n_fail}/{NUM_TRIALS} unparseable")

    print("\n" + "=" * 60)
    print("D-VLM baseline pilot — summary")
    print("=" * 60)
    total_match = sum(r["n_match"] for r in results.values())
    total_trials = NUM_TRIALS * len(results)
    for key, r in results.items():
        print(f"  {key:30s} {r['n_match']:2d}/{NUM_TRIALS}  ({r['acc']:5.1f}%)  "
              f"ref_support={r['ref_support']:.0f}%")
    print(f"  {'OVERALL':30s} {total_match:2d}/{total_trials}  "
          f"({total_match / total_trials * 100:.1f}%)")


if __name__ == "__main__":
    main()
