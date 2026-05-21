#!/usr/bin/env python3
"""
Gemini proposed method evaluation script for FMB.

- Uses phase1_fmb_graph_planner_single_image.md prompt
- Outputs to experiments/evaluations/VLM/gemini_proposed_method/FMB/
- Supports --start-trial and --trials for partial runs
- Skips existing trial files to avoid overwriting
"""
import argparse
import os
import sys
import datetime
import traceback
from pathlib import Path
from PIL import Image

# Force Gemini backend for this evaluation
os.environ["VLM_BACKEND"] = "gemini"
os.environ["GOOGLE_API_KEY"] = os.getenv("GEMINI_API_KEY", os.getenv("GOOGLE_API_KEY", ""))

# Add project root to sys.path
ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "../.."))
sys.path.append(ROOT_DIR)

from core.vlm import VLMClient

# ── Config ────────────────────────────────────────────────────────────────────
INPUT_ROOT = os.path.join(ROOT_DIR, "experiments/inputs/FMB")
OUTPUT_ROOT = os.path.join(ROOT_DIR, "experiments/evaluations/VLM/gemini_proposed_method/FMB")
CUSTOM_PROMPT = os.path.join(ROOT_DIR, "prompts/phase1_fmb_graph_planner.md")
TRIALS = 10  # Default: 10 trials
MAX_RETRIES_PER_TRIAL = 5
# ─────────────────────────────────────────────────────────────────────────────


def print_banner(msg):
    print("\n" + "=" * 60)
    print(f"  {msg}")
    print("=" * 60 + "\n")


def collect_samples(root):
    """
    Return list of all FMB sample images in deterministic order.
    Structure scanned in this order:
      - categories sorted (e.g., 3objs,4objs,5objs)
      - sample dirs sorted (001,002,...)
      - image files sorted within each sample
    Returns list of tuples: (category_dir, sample_dir, list_of_image_paths)
    """
    samples = []
    if not os.path.isdir(root):
        return samples

    for category_dir in sorted(os.listdir(root)):
        category_path = os.path.join(root, category_dir)
        if not os.path.isdir(category_path):
            continue

        for sample_dir in sorted(os.listdir(category_path)):
            sample_path = os.path.join(category_path, sample_dir)
            if not os.path.isdir(sample_path):
                continue

            # Append all PNGs in this sample directory in sorted order
            pngs = [f for f in sorted(os.listdir(sample_path)) if f.lower().endswith('.png')]
            if pngs:
                img_paths = [os.path.join(sample_path, fname) for fname in pngs]
                samples.append((category_dir, sample_dir, img_paths))

    return samples


def get_output_dir(category, sample_id):
    """Create output directory path."""
    return os.path.join(OUTPUT_ROOT, category, sample_id)


def save_trial_md(out_dir, trial_n, image_paths, has_output, raw_output, elapsed, retry_count=0):
    """Write a single trial_N.md file. Save raw output as-is."""
    os.makedirs(out_dir, exist_ok=True)
    ts = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    status = "✅ PASS" if has_output else "❌ FAIL"
    fpath = os.path.join(out_dir, f"trial_{trial_n:02d}.md")

    with open(fpath, "w", encoding="utf-8") as f:
        f.write(f"# Trial {trial_n:02d}\n\n")
        f.write(f"- **Status**: {status}\n")
        f.write(f"- **Timestamp**: {ts}\n")
        f.write(f"- **Elapsed**: {elapsed:.1f}s\n")
        f.write(f"- **Retries**: {retry_count}\n")
        f.write(f"- **Images**: {len(image_paths)}\n")
        for p in image_paths:
            rel_img = os.path.relpath(p, ROOT_DIR)
            f.write(f"  - `/{rel_img}`\n")
        f.write("\n## VLM Raw Output\n\n")
        f.write(raw_output if raw_output else "(No output captured)\n")
    return fpath


def parse_args():
    parser = argparse.ArgumentParser(description="Gemini proposed method FMB evaluation")
    parser.add_argument("--start-trial", type=int, default=1, help="Starting trial number (inclusive)")
    parser.add_argument("--trials", type=int, default=TRIALS, help="Number of trials to run per sample")
    parser.add_argument("--quick", action="store_true", help="Run only first sample (quick test)")
    return parser.parse_args()


def main():
    args = parse_args()
    start_trial = max(1, args.start_trial)
    trials_to_run = max(1, args.trials)
    trial_numbers = list(range(start_trial, start_trial + trials_to_run))

    if not os.path.exists(CUSTOM_PROMPT):
        print(f"Error: Prompt not found at {CUSTOM_PROMPT}")
        return

    samples = collect_samples(INPUT_ROOT)
    if args.quick and samples:
        samples = samples[:1]  # Only first sample for quick test
    
    total = len(samples)

    print_banner(
        f"VLM EVALUATION — GEMINI PROPOSED METHOD (FMB)\n"
        f"Samples: {total}  |  Trials: {trial_numbers[0]}-{trial_numbers[-1]} ({len(trial_numbers)})  |  Total calls: {total * len(trial_numbers)}"
    )
    print(f"Input Root : {INPUT_ROOT}")
    print(f"Output Root: {OUTPUT_ROOT}")
    print(f"Prompt     : {os.path.relpath(CUSTOM_PROMPT, ROOT_DIR)}\n")

    vlm = VLMClient()
    grand_ok = grand_fail = 0
    grand_skipped = 0

    for sid, (category, sample_id, img_paths) in enumerate(samples, 1):
        out_dir = get_output_dir(category, sample_id)
        print_banner(f"[{sid}/{total}] {category}/{sample_id} ({len(img_paths)} images)")

        img_ok = img_fail = img_skipped = 0
        for trial in trial_numbers:
            md_path = os.path.join(out_dir, f"trial_{trial:02d}.md")
            if os.path.exists(md_path):
                print(f"  → Trial {trial:02d}/{len(trial_numbers)} ... SKIP existing {os.path.basename(md_path)}")
                img_skipped += 1
                continue

            print(f"  → Trial {trial:02d}/{len(trial_numbers)} ... ", end="", flush=True)

            os.makedirs(out_dir, exist_ok=True)
            raw_output = None
            has_output = False
            retry_count = 0

            for attempt in range(MAX_RETRIES_PER_TRIAL):
                t0 = datetime.datetime.now()
                try:
                    with open(CUSTOM_PROMPT, "r", encoding="utf-8") as f:
                        template = f.read()

                    prompt_content = [
                        template,
                        "\n--- MISSION START: ACTUAL TASK ---\n",
                        "Analyze this Sequence of FMB Assembly Images in order:\n"
                    ]
                    
                    for idx, ipath in enumerate(img_paths):
                        prompt_content.append(f"Step {idx + 1} Image:")
                        prompt_content.append(Image.open(ipath))
                        
                    prompt_content.append("\nNow, output the Topological Graph for the final assembled state:")
                    raw_output = vlm._call_vlm_with_retry(prompt_content, is_json_output=False)
                    if raw_output:
                        has_output = True
                        break
                    retry_count = attempt + 1
                except Exception:
                    if attempt < MAX_RETRIES_PER_TRIAL - 1:
                        print(f"[retry {attempt + 1}] ", end="", flush=True)
                        retry_count = attempt + 1
                    else:
                        raw_output = f"[EXCEPTION after {MAX_RETRIES_PER_TRIAL} retries]\n{traceback.format_exc()}"
                        retry_count = MAX_RETRIES_PER_TRIAL
                        break

            elapsed = (datetime.datetime.now() - t0).total_seconds()
            md_path = save_trial_md(out_dir, trial, img_paths, has_output, raw_output, elapsed, retry_count)

            status_str = "OK" if has_output else "FAIL"
            print(f"{status_str}  ({elapsed:.0f}s)  → {os.path.basename(md_path)}")

            if has_output:
                img_ok += 1
            else:
                img_fail += 1

        grand_ok += img_ok
        grand_fail += img_fail
        grand_skipped += img_skipped
        print(f"  Summary: {img_ok}/{len(trial_numbers)} passed, {img_skipped} skipped\n")

    print_banner(
        f"EVALUATION COMPLETE\n"
        f"Total Pass: {grand_ok} / {total * len(trial_numbers)}\n"
        f"Total Fail: {grand_fail} / {total * len(trial_numbers)}\n"
        f"Total Skipped: {grand_skipped}\n"
        f"Results at: {OUTPUT_ROOT}"
    )


if __name__ == "__main__":
    main()
