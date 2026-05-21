#!/usr/bin/env python3
"""
Gemini proposed method evaluation script.

- Uses phase1_graph_planner_length_rank_test.md prompt
- Outputs to experiments/evaluations/VLM/gemini_proposed_method/cubeStacking/
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
INPUT_ROOT = os.path.join(ROOT_DIR, "experiments/inputs/cubeStacking")
OUTPUT_ROOT = os.path.join(ROOT_DIR, "experiments/evaluations/VLM/gemini_proposed_method/cubeStacking")
CUSTOM_PROMPT = os.path.join(ROOT_DIR, "prompts/phase1_graph_planner_length_rank_test.md")
TRIALS = 10  # Default: 10 trials
MAX_RETRIES_PER_TRIAL = 5
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
    """Mirror the input structure under OUTPUT_ROOT."""
    rel = os.path.relpath(image_abs_path, INPUT_ROOT)
    p = Path(rel)
    return os.path.join(OUTPUT_ROOT, p.parent, p.stem)


def save_trial_md(out_dir, trial_n, image_path, has_output, raw_output, elapsed, retry_count=0):
    """Write a single trial_N.md file. Save raw output as-is."""
    os.makedirs(out_dir, exist_ok=True)
    ts = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    status = "✅ PASS" if has_output else "❌ FAIL"
    fpath = os.path.join(out_dir, f"trial_{trial_n:02d}.md")

    rel_img = os.path.relpath(image_path, ROOT_DIR)

    with open(fpath, "w", encoding="utf-8") as f:
        f.write(f"# Trial {trial_n:02d} — {Path(image_path).stem}\n\n")
        f.write(f"- **Status**: {status}\n")
        f.write(f"- **Timestamp**: {ts}\n")
        f.write(f"- **Elapsed**: {elapsed:.1f}s\n")
        f.write(f"- **Retries**: {retry_count}\n")
        f.write(f"- **Image**: `/{rel_img}`\n\n")
        f.write("## VLM Raw Output\n\n")
        f.write(raw_output if raw_output else "(No output captured)\n")
    return fpath


def parse_args():
    parser = argparse.ArgumentParser(description="Gemini proposed method evaluation")
    parser.add_argument("--start-trial", type=int, default=1, help="Starting trial number (inclusive)")
    parser.add_argument("--trials", type=int, default=TRIALS, help="Number of trials to run per image")
    return parser.parse_args()


def main():
    args = parse_args()
    start_trial = max(1, args.start_trial)
    trials_to_run = max(1, args.trials)
    trial_numbers = list(range(start_trial, start_trial + trials_to_run))

    if not os.path.exists(CUSTOM_PROMPT):
        print(f"Error: Prompt not found at {CUSTOM_PROMPT}")
        return

    images = collect_images(INPUT_ROOT)
    total = len(images)

    print_banner(
        f"VLM EVALUATION — GEMINI PROPOSED METHOD\n"
        f"Images: {total}  |  Trials: {trial_numbers[0]}-{trial_numbers[-1]} ({len(trial_numbers)})  |  Total calls: {total * len(trial_numbers)}"
    )
    print(f"Input Root : {INPUT_ROOT}")
    print(f"Output Root: {OUTPUT_ROOT}")
    print(f"Prompt     : {os.path.relpath(CUSTOM_PROMPT, ROOT_DIR)}\n")

    vlm = VLMClient()
    grand_ok = grand_fail = 0
    grand_skipped = 0

    for img_idx, img_path in enumerate(images, 1):
        out_dir = get_output_dir(img_path)
        rel = os.path.relpath(img_path, ROOT_DIR)
        print_banner(f"[{img_idx}/{total}] {rel}")

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

                    img_pil = Image.open(img_path)
                    prompt_content = [
                        template,
                        "\n--- MISSION START: ACTUAL TASK ---\n",
                        "Analyze this Target Image:",
                        img_pil,
                        "Now, output the Assembly Plan:",
                    ]
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
            md_path = save_trial_md(out_dir, trial, img_path, has_output, raw_output, elapsed, retry_count)

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
