#!/usr/bin/env python3
"""
VLM Evaluation Script (Simplified)
------------------------------------
For each image in experiments/inputs/cubeStacking/:
  - Call VLM (Phase 1 only)
  - Save raw output as trial_N.md
  - Mirror input folder structure exactly under experiments/evaluations/VLM/proposed_method/
"""
import os
import sys
import json
import datetime
import traceback
from pathlib import Path

# Add project root to sys.path
ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '../..'))
sys.path.append(ROOT_DIR)

from pipeline.run_phase1 import execute_phase1

# ── Config ────────────────────────────────────────────────────────────────────
INPUT_ROOT  = os.path.join(ROOT_DIR, "experiments/inputs/cubeStacking")
# REDIRECT to V2 folder as requested
OUTPUT_ROOT = os.path.join(ROOT_DIR, "experiments/evaluations/VLM/proposed_method/cubeStacking/5cubes/proposed_method_V2")
TRIALS      = 10
# ─────────────────────────────────────────────────────────────────────────────


def print_banner(msg):
    print("\n" + "=" * 60)
    print(f"  {msg}")
    print("=" * 60 + "\n")


def collect_images(root):
    """Return sorted list of all .png paths under root."""
    images = []
    for dirpath, _, filenames in os.walk(root):
        for fname in sorted(filenames):
            if fname.lower().endswith(".png"):
                images.append(os.path.join(dirpath, fname))
    return sorted(images)


def get_output_dir(image_abs_path):
    """Mirror the input structure under OUTPUT_ROOT.
    e.g. .../cubeStacking/5cubes/cube_n05_s02.png
      -> OUTPUT_ROOT/cube_n05_s02/
    """
    rel = os.path.relpath(image_abs_path, INPUT_ROOT)  # 5cubes/cube_n05_s02.png
    p   = Path(rel)
    # Just use the stem for the final folder name inside V2
    out = os.path.join(OUTPUT_ROOT, p.stem)
    return out


def save_trial_md(out_dir, trial_n, image_path, success, raw_output, elapsed):
    """Write a single trial_N.md file."""
    os.makedirs(out_dir, exist_ok=True)
    ts     = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    status = "✅ PASS" if success else "❌ FAIL"
    fpath  = os.path.join(out_dir, f"trial_{trial_n:02d}.md")
    with open(fpath, "w", encoding="utf-8") as f:
        f.write(f"# Trial {trial_n:02d} — {p_name(image_path)}\n\n")
        f.write(f"- **Status**: {status}\n")
        f.write(f"- **Timestamp**: {ts}\n")
        f.write(f"- **Elapsed**: {elapsed:.1f}s\n")
        f.write(f"- **Image**: `{image_path}`\n\n")
        f.write("## VLM Raw Output\n\n")
        f.write("```json\n")
        if isinstance(raw_output, (dict, list)):
            f.write(json.dumps(raw_output, indent=2, ensure_ascii=False))
        else:
            f.write(str(raw_output) if raw_output else "(empty)")
        f.write("\n```\n")
    return fpath


def p_name(p):
    return Path(p).stem


def main():
    images = collect_images(INPUT_ROOT)
    # FILTER: Only s02, s03, s05 for 5cubes
    v2_targets = ["cube_n05_s02", "cube_n05_s03", "cube_n05_s05"]
    images = [img for img in images if p_name(img) in v2_targets]
    
    total  = len(images)
    print_banner(f"VLM EVALUATION — LONG RECTPRISM TARGETED RUN\n"
                 f"Images: {total}  |  Trials: {TRIALS}  |  Total calls: {total * TRIALS}")
    print(f"Input Root : {INPUT_ROOT}")
    print(f"Output Root: {OUTPUT_ROOT}\n")

    grand_ok = grand_fail = 0

    for img_idx, img_path in enumerate(images, 1):
        out_dir = get_output_dir(img_path)
        rel     = os.path.relpath(img_path, ROOT_DIR)
        print_banner(f"[{img_idx}/{total}] {rel}")

        img_ok = img_fail = 0
        for trial in range(1, TRIALS + 1):
            t0 = datetime.datetime.now()
            print(f"  → Trial {trial:02d}/{TRIALS} ... ", end="", flush=True)

            # ── Temporary output path for the JSON the pipeline writes ────────
            tmp_json = os.path.join(out_dir, f".tmp_trial_{trial:02d}.json")
            os.makedirs(out_dir, exist_ok=True)
            raw_output = None
            success    = False
            
            # Use the length_rank_test prompt for ALL these filtered images
            custom_prompt = os.path.join(ROOT_DIR, "prompts/phase1_graph_planner_length_rank_test.md")
            
            try:
                ok, json_path = execute_phase1(
                    target_img_path=img_path,
                    output_json_path=tmp_json,
                    prompt_path=custom_prompt
                )
                if ok and json_path and os.path.exists(json_path):
                    with open(json_path, "r", encoding="utf-8") as jf:
                        raw_output = json.load(jf)
                    success = True
                else:
                    raw_output = "(Phase1 returned failure)"
            except Exception as e:
                raw_output = f"EXCEPTION: {traceback.format_exc()}"

            elapsed = (datetime.datetime.now() - t0).total_seconds()
            md_path = save_trial_md(out_dir, trial, img_path, success, raw_output, elapsed)

            # Clean up temp json
            if os.path.exists(tmp_json):
                os.remove(tmp_json)

            status_str = "OK" if success else "FAIL"
            print(f"{status_str}  ({elapsed:.0f}s)  → {os.path.basename(md_path)}")

            if success: img_ok  += 1
            else:       img_fail += 1

        grand_ok   += img_ok
        grand_fail += img_fail
        print(f"  Summary: {img_ok}/{TRIALS} passed\n")

    print_banner(
        f"EVALUATION COMPLETE\n"
        f"Total Pass: {grand_ok} / {total * TRIALS}\n"
        f"Total Fail: {grand_fail} / {total * TRIALS}\n"
        f"Results at: {OUTPUT_ROOT}"
    )


if __name__ == "__main__":
    main()
