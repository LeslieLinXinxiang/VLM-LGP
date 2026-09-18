#!/usr/bin/env python3
"""Full-scale run of the D-VLM baseline prompt (prompts/baseline_d_vlm.md).

Same scope as our own method's evaluation (experiments/evaluations/VLM/
gemini_proposed_method/): cube stacking {4..8}cubes x {s01..s05}, FMB
{3..5}objs x {001..005}, 10 trials each -- 40 cases, 400 calls total.

Ground truth for scoring is the same majority-vote reference already
established for our own method's trials for each case (canonicalize_graph /
choose_reference_trial, unchanged from analyse_gemini_proposed_method_accuracy.py).

Color-in-name is normalized away before scoring (established in the pilot:
the D-VLM schema has no separate color field, and canonicalize_graph already
excludes an independent color field elsewhere, so this keeps that same
exclusion consistent -- see CLAUDE.md pilot writeup). Wrong supporter counts
and wrong position-axis words are NOT normalized -- both are genuine
capability gaps, not prompt-format artifacts (also established in the pilot).

Usage:
    python3 experiments/scripts/run_baseline_d_vlm_full.py
    python3 experiments/scripts/run_baseline_d_vlm_full.py --only cubeStacking
    python3 experiments/scripts/run_baseline_d_vlm_full.py --case FMB/5objs/003
"""
import argparse
import json
import os
import sys
import time
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
INPUT_ROOT = ROOT / "experiments/inputs"
NUM_TRIALS = 10
MAX_RETRIES = 5

COLOR_WORDS = {"green", "red", "blue", "yellow", "orange", "cyan", "purple", "white", "black"}


def strip_color_prefix(raw_block: str) -> str:
    """Drop a leading color-adjective word from each object's "object" field --
    the D-VLM schema has no separate color field, and canonicalize_graph already
    excludes an independent color field elsewhere; this keeps that exclusion
    consistent rather than accidentally re-introducing color as a signal."""
    try:
        parsed = json.loads(raw_block)
    except Exception:
        return raw_block
    if isinstance(parsed, dict) and isinstance(parsed.get("objects"), list):
        for o in parsed["objects"]:
            if isinstance(o, dict) and isinstance(o.get("object"), str):
                words = o["object"].split()
                if len(words) > 1 and words[0].lower() in COLOR_WORDS:
                    o["object"] = " ".join(words[1:])
    return json.dumps(parsed)


def build_cases():
    cases = []
    for n in range(4, 9):
        for s in range(1, 6):
            case_name = f"cube_n{n:02d}_s{s:02d}"
            cases.append({
                "key": f"cubeStacking/{n}cubes/{case_name}",
                "images": [INPUT_ROOT / "cubeStacking" / f"{n}cubes" / f"{case_name}.png"],
                "ref_dir": REF_ROOT / "cubeStacking" / f"{n}cubes" / case_name,
            })
    for n in range(3, 6):
        for s in range(1, 6):
            case_name = f"{s:03d}"
            cases.append({
                "key": f"FMB/{n}objs/{case_name}",
                "images": sorted((INPUT_ROOT / "FMB" / f"{n}objs" / case_name).glob("*.png")),
                "ref_dir": REF_ROOT / "FMB" / f"{n}objs" / case_name,
            })
    return cases


def load_reference(ref_dir: Path):
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


def score_norm(raw_block):
    """normalize_final_block, but with color prefixes stripped first."""
    cleaned = strip_color_prefix(raw_block)
    return normalize_final_block(cleaned)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--only", choices=["cubeStacking", "FMB"], default=None)
    ap.add_argument("--case", default=None, help="Restrict to one case, e.g. FMB/5objs/003")
    ap.add_argument("--trials", type=int, default=NUM_TRIALS)
    args = ap.parse_args()

    cases = build_cases()
    if args.only:
        cases = [c for c in cases if c["key"].startswith(args.only)]
    if args.case:
        cases = [c for c in cases if c["key"] == args.case]
    if not cases:
        raise RuntimeError("No cases matched the given filters.")

    prompt_template = PROMPT_PATH.read_text(encoding="utf-8")
    vlm = VLMClient()

    all_results = {}
    for ci, case in enumerate(cases, 1):
        key = case["key"]
        gt_norm, support, n_ref_trials = load_reference(case["ref_dir"])
        out_dir = OUT_ROOT / key
        out_dir.mkdir(parents=True, exist_ok=True)

        print(f"\n[{ci}/{len(cases)}] === {key} === ref_support={support:.0f}% "
              f"({n_ref_trials} ref trials)", flush=True)

        n_match = n_parsed = n_fail = 0
        for trial in range(1, args.trials + 1):
            out_path = out_dir / f"trial_{trial:02d}.md"
            if out_path.exists() and out_path.stat().st_size > 0:
                raw_output = out_path.read_text(encoding="utf-8")
            else:
                raw_output = None
                for attempt in range(1, MAX_RETRIES + 1):
                    try:
                        raw_output = call_d_vlm(vlm, prompt_template, case["images"])
                        if raw_output:
                            break
                    except Exception as exc:
                        print(f"    trial {trial:02d} attempt {attempt}: "
                              f"{type(exc).__name__}: {exc}", flush=True)
                        time.sleep(3)
                out_path.write_text(raw_output or "(no output)", encoding="utf-8")

            block = extract_final_block_from_md(out_path)
            norm = score_norm(block) if block else None
            if norm is None:
                n_fail += 1
                print(f"  trial {trial:02d}: FAIL (unparseable)", flush=True)
                continue
            n_parsed += 1
            match = gt_norm is not None and norm == gt_norm
            if match:
                n_match += 1
            print(f"  trial {trial:02d}: {'MATCH' if match else 'DIFFER'}", flush=True)

        acc = (n_match / args.trials * 100) if args.trials else 0.0
        all_results[key] = {"n_match": n_match, "n_parsed": n_parsed, "n_fail": n_fail,
                             "acc": acc, "ref_support": support, "n_trials": args.trials}
        print(f"  -> {key}: {n_match}/{args.trials} ({acc:.1f}%)", flush=True)

    summary_path = OUT_ROOT / "full_run_summary.json"
    summary_path.parent.mkdir(parents=True, exist_ok=True)
    summary_path.write_text(json.dumps(all_results, indent=2), encoding="utf-8")

    print("\n" + "=" * 70)
    print("D-VLM baseline FULL run — summary")
    print("=" * 70)
    for bench, mags in [("cubeStacking", range(4, 9)), ("FMB", range(3, 6))]:
        for mag in mags:
            mag_keys = [k for k in all_results if k.startswith(f"{bench}/{mag}{'cubes' if bench=='cubeStacking' else 'objs'}/")]
            if not mag_keys:
                continue
            m = sum(all_results[k]["n_match"] for k in mag_keys)
            t = sum(all_results[k]["n_trials"] for k in mag_keys)
            print(f"  {bench:14s} {mag}{'cubes' if bench=='cubeStacking' else 'objs':5s}  "
                  f"{m:3d}/{t:3d}  ({m/t*100:5.1f}%)")
    total_m = sum(r["n_match"] for r in all_results.values())
    total_t = sum(r["n_trials"] for r in all_results.values())
    print(f"  {'OVERALL':26s} {total_m:3d}/{total_t:3d}  ({total_m/total_t*100:.1f}%)")
    print(f"\nwritten: {summary_path.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
