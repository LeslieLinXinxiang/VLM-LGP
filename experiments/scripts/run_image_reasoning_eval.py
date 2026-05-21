#!/usr/bin/env python3
"""
Image Reasoning Evaluation Script
------------------------------------
For each image in experiments/inputs/cubeStacking/:
  - Call VLM with prompts/baseline_visual_planner_v2.md (Stage 1 only)
  - Save raw output as trial_N.md
  - Mirror input folder structure under experiments/evaluations/VLM/image_reasoning/
"""
import os
import sys
import json
import datetime
import traceback
from pathlib import Path
from PIL import Image

# Add project root to sys.path
ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '../..'))
sys.path.append(ROOT_DIR)

from core.vlm import VLMClient

# ── Config ────────────────────────────────────────────────────────────────────
INPUT_ROOT    = os.path.join(ROOT_DIR, "experiments/inputs/cubeStacking")
OUTPUT_ROOT   = os.path.join(ROOT_DIR, "experiments/evaluations/VLM/image_reasoning/cubeStacking")
CUSTOM_PROMPT = os.path.join(ROOT_DIR, "prompts/baseline_visual_planner_v2.md")
TRIALS        = 10  # Match proposed_method standard
MAX_RETRIES_PER_TRIAL = 3  # Retry if no output (timeout/API error)
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
    e.g. .../cubeStacking/4cubes/cube_n04_s01.png
      -> OUTPUT_ROOT/4cubes/cube_n04_s01/
    """
    rel = os.path.relpath(image_abs_path, INPUT_ROOT)  # e.g. 4cubes/cube_n04_s01.png
    p   = Path(rel)
    # Mirror subfolders (4cubes/...) then use filename stem as terminal folder
    out = os.path.join(OUTPUT_ROOT, p.parent, p.stem)
    return out

def save_trial_md(out_dir, trial_n, image_path, has_output, raw_output, elapsed, retry_count=0):
    """Write a single trial_N.md file. Save any output format as-is."""
    os.makedirs(out_dir, exist_ok=True)
    ts     = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    status = "✅ PASS" if has_output else "❌ FAIL"
    fpath  = os.path.join(out_dir, f"trial_{trial_n:02d}.md")
    
    # Extract relative path for display
    rel_img = os.path.relpath(image_path, ROOT_DIR)
    
    with open(fpath, "w", encoding="utf-8") as f:
        f.write(f"# Trial {trial_n:02d} — {Path(image_path).stem}\n\n")
        f.write(f"- **Status**: {status}\n")
        f.write(f"- **Timestamp**: {ts}\n")
        f.write(f"- **Elapsed**: {elapsed:.1f}s\n")
        f.write(f"- **Retries**: {retry_count}\n")
        f.write(f"- **Image**: `/{rel_img}`\n\n")
        f.write("## VLM Raw Output\n\n")
        if raw_output:
            f.write(raw_output)
        else:
            f.write("(No output captured)\n")
    return fpath

def main():
    if not os.path.exists(CUSTOM_PROMPT):
        print(f"Error: Prompt not found at {CUSTOM_PROMPT}")
        return

    images = collect_images(INPUT_ROOT)
    total  = len(images)
    
    print_banner(f"VLM EVALUATION — IMAGE REASONING RUN\n"
                 f"Images: {total}  |  Trials: {TRIALS}  |  Total calls: {total * TRIALS}")
    print(f"Input Root : {INPUT_ROOT}")
    print(f"Output Root: {OUTPUT_ROOT}")
    print(f"Prompt     : {os.path.relpath(CUSTOM_PROMPT, ROOT_DIR)}\n")

    vlm = VLMClient()
    grand_ok = grand_fail = 0

    for img_idx, img_path in enumerate(images, 1):
        out_dir = get_output_dir(img_path)
        rel     = os.path.relpath(img_path, ROOT_DIR)
        print_banner(f"[{img_idx}/{total}] {rel}")

        img_ok = img_fail = 0
        for trial in range(1, TRIALS + 1):
            print(f"  → Trial {trial:02d}/{TRIALS} ... ", end="", flush=True)
            
            os.makedirs(out_dir, exist_ok=True)
            raw_output = None
            has_output = False
            retry_count = 0
            
            # Retry loop: only retry if no output (timeout/API error)
            for attempt in range(MAX_RETRIES_PER_TRIAL):
                t0 = datetime.datetime.now()
                try:
                    # Direct VLM call (text mode, not JSON)
                    # We pass is_json_output=False to get raw text output without JSON parsing
                    with open(CUSTOM_PROMPT, 'r') as f:
                        template = f.read()
                    
                    img_pil = Image.open(img_path)
                    prompt_content = [
                        template,
                        "\n--- MISSION START: ACTUAL TASK ---\n",
                        "Analyze this Target Image:",
                        img_pil,
                        "Now, output the Assembly Plan:"
                    ]
                    raw_output = vlm._call_vlm_with_retry(prompt_content, is_json_output=False)
                    # If we got any output (even if it's not JSON), consider it a success
                    if raw_output:
                        has_output = True
                        break  # Exit retry loop, move to next trial
                    else:
                        # No output, will retry
                        retry_count = attempt + 1
                except Exception as e:
                    # API error, timeout, etc. — retry
                    if attempt < MAX_RETRIES_PER_TRIAL - 1:
                        print(f"[retry {attempt + 1}] ", end="", flush=True)
                        retry_count = attempt + 1
                    else:
                        # All retries exhausted
                        raw_output = f"[EXCEPTION after {MAX_RETRIES_PER_TRIAL} retries]\n{traceback.format_exc()}"
                        retry_count = MAX_RETRIES_PER_TRIAL
                        break
            
            elapsed = (datetime.datetime.now() - t0).total_seconds()
            md_path = save_trial_md(out_dir, trial, img_path, has_output, raw_output, elapsed, retry_count)

            status_str = "OK" if has_output else "FAIL"
            print(f"{status_str}  ({elapsed:.0f}s)  → {os.path.basename(md_path)}")

            if has_output: img_ok  += 1
            else:          img_fail += 1

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
