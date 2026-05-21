#!/usr/bin/env python3
"""
Gemini Baseline MoveIt evaluation script.

- Uses baseline_visual_planner_moveit_action10_v1.md prompt
- Reads both the image and the 4 scene files (trial_01_nr.g, trial_01_r.g, trial_02_nr.g, trial_02_r.g)
- Outputs to experiments/evaluations/VLM/gemini_baseline/cubeStacking/
- Supports --start-trial and --trials for partial runs
- Skips existing trial files to avoid overwriting
"""
import argparse
import os
import sys
import glob
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
SCENE_ROOT = os.path.join(ROOT_DIR, "experiments/scenes/4cubes/s01/random_trials")
OUTPUT_ROOT = os.path.join(ROOT_DIR, "experiments/evaluations/VLM/gemini_baseline/cubeStacking")
CUSTOM_PROMPT = os.path.join(ROOT_DIR, "prompts/baseline_visual_planner_moveit_action10_v1.md")
TRIALS_PER_SCENE = 4  # Default: run 4 trials (1 for each scene type)
MAX_RETRIES_PER_TRIAL = 5

SCENE_TYPES = ["trial_01_nr.g", "trial_01_r.g", "trial_02_nr.g", "trial_02_r.g"]
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

def get_output_dir(image_abs_path, scene_name):
    """Mirror the input structure under OUTPUT_ROOT, adding scene dir."""
    rel = os.path.relpath(image_abs_path, INPUT_ROOT)
    p = Path(rel)
    return os.path.join(OUTPUT_ROOT, p.parent, p.stem, scene_name.replace('.g', ''))

def save_trial_md(out_dir, trial_n, image_path, scene_path, has_output, raw_output, elapsed, retry_count=0):
    """Write a single trial_N.md file. Save raw output as-is."""
    os.makedirs(out_dir, exist_ok=True)
    ts = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    status = "✅ PASS" if has_output else "❌ FAIL"
    fpath = os.path.join(out_dir, f"trial_{trial_n:02d}.md")

    rel_img = os.path.relpath(image_path, ROOT_DIR)
    rel_scene = os.path.relpath(scene_path, ROOT_DIR) if scene_path else "N/A"

    with open(fpath, "w", encoding="utf-8") as f:
        f.write(f"# Trial {trial_n:02d} — {Path(image_path).stem} — {Path(scene_path).stem if scene_path else 'N/A'}\n\n")
        f.write(f"- **Status**: {status}\n")
        f.write(f"- **Timestamp**: {ts}\n")
        f.write(f"- **Elapsed**: {elapsed:.1f}s\n")
        f.write(f"- **Retries**: {retry_count}\n")
        f.write(f"- **Image**: `/{rel_img}`\n")
        f.write(f"- **Scene**: `/{rel_scene}`\n\n")
        f.write("## VLM Raw Output\n\n")
        f.write(raw_output if raw_output else "(No output captured)\n")
    return fpath

def parse_args():
    parser = argparse.ArgumentParser(description="Gemini Baseline MoveIt evaluation")
    parser.add_argument("--start-trial", type=int, default=1, help="Starting trial number (inclusive)")
    parser.add_argument("--trials", type=int, default=1, help="Number of repetitions per scene")
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
    total_calls = total * len(SCENE_TYPES) * len(trial_numbers)

    print_banner(
        f"VLM EVALUATION — GEMINI BASELINE MOVEIT\n"
        f"Images: {total}  |  Scenes: {len(SCENE_TYPES)}  |  Reps: {len(trial_numbers)}  |  Total calls: {total_calls}"
    )
    print(f"Input Root : {INPUT_ROOT}")
    print(f"Output Root: {OUTPUT_ROOT}")
    print(f"Prompt     : {os.path.relpath(CUSTOM_PROMPT, ROOT_DIR)}\n")

    vlm = VLMClient()
    grand_ok = grand_fail = grand_skipped = 0

    for img_idx, img_path in enumerate(images, 1):
        rel = os.path.relpath(img_path, ROOT_DIR)
        print_banner(f"[{img_idx}/{total}] Image: {rel}")

        # Find the correct scene folder based on image structure (e.g. 4cubes/s01)
        # Note: This is an approximation. If your scenes are strictly in one folder, we'll use that.
        # But we'll try to match the folder structure if possible.
        img_rel_dir = os.path.relpath(os.path.dirname(img_path), INPUT_ROOT)
        scene_dir = os.path.join(ROOT_DIR, "experiments/scenes", img_rel_dir, "random_trials")
        if not os.path.exists(scene_dir):
            print(f"Warning: Scene dir {scene_dir} not found. Falling back to default.")
            scene_dir = SCENE_ROOT

        for scene_name in SCENE_TYPES:
            scene_path = os.path.join(scene_dir, scene_name)
            if not os.path.exists(scene_path):
                 print(f"  ⚠️ Scene not found: {scene_path}. Skipping.")
                 continue

            out_dir = get_output_dir(img_path, scene_name)
            
            for trial in trial_numbers:
                md_path = os.path.join(out_dir, f"trial_{trial:02d}.md")
                if os.path.exists(md_path):
                    print(f"  → Scene {scene_name} | Trial {trial:02d} ... SKIP existing")
                    grand_skipped += 1
                    continue

                print(f"  → Scene {scene_name} | Trial {trial:02d} ... ", end="", flush=True)

                os.makedirs(out_dir, exist_ok=True)
                raw_output = None
                has_output = False
                retry_count = 0

                for attempt in range(MAX_RETRIES_PER_TRIAL):
                    t0 = datetime.datetime.now()
                    try:
                        with open(CUSTOM_PROMPT, "r", encoding="utf-8") as f:
                            template = f.read()
                        
                        with open(scene_path, "r", encoding="utf-8") as f:
                            scene_content = f.read()

                        img_pil = Image.open(img_path)
                        
                        # Assembly logic following the web prompt order: Prompt -> Scene -> Image
                        prompt_content = [
                            template,
                            "\n-----BEGIN SCENE-----\n",
                            scene_content,
                            "\n-----END SCENE-----\n",
                            img_pil,
                            "\nIMAGE UPLOADED\n"
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
                md_path = save_trial_md(out_dir, trial, img_path, scene_path, has_output, raw_output, elapsed, retry_count)

                status_str = "OK" if has_output else "FAIL"
                print(f"{status_str}  ({elapsed:.0f}s)")

                if has_output:
                    grand_ok += 1
                else:
                    grand_fail += 1

    print_banner(
        f"EVALUATION COMPLETE\n"
        f"Total Pass: {grand_ok}\n"
        f"Total Fail: {grand_fail}\n"
        f"Total Skipped: {grand_skipped}\n"
        f"Results at: {OUTPUT_ROOT}"
    )

if __name__ == "__main__":
    main()
