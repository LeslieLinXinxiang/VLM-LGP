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

# Correct Import: VLMClient from core.vlm
from core.vlm import VLMClient

# --- CONFIG ---
# Magnitude levels 4 to 8
MAGNITUDES = ["4cubes", "5cubes", "6cubes", "7cubes", "8cubes"]
SCENARIOS = ["s01", "s02", "s03", "s04", "s05"]
OUTPUT_ROOT = os.path.join(ROOT_DIR, "experiments/evaluations/VLM/pure_llm_baseline")
PROMPT_PATH = os.path.join(ROOT_DIR, "prompts/baseline_pure_llm.md")

def save_baseline_md(out_dir, trial_name, image_path, scene_path, raw_output, elapsed):
    """Saves a professional markdown log for the baseline trial."""
    os.makedirs(out_dir, exist_ok=True)
    ts = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    fpath = os.path.join(out_dir, f"{trial_name}.md")
    
    with open(fpath, "w", encoding="utf-8") as f:
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

def main():
    print(f"\n>>> STARTING PURE-LLM ROBUST QUICK EVAL (Total 25 cases) <<<\n")
    
    # Initialize the client once
    client = VLMClient()
    
    with open(PROMPT_PATH, "r") as pf:
        base_prompt = pf.read()

    for mag in MAGNITUDES:
        mag_num = mag.replace("cubes", "").zfill(2)
        for s_id in SCENARIOS:
            image_name = f"cube_n{mag_num}_{s_id}.png"
            image_path = os.path.join(ROOT_DIR, "experiments/inputs/cubeStacking", mag, image_name)
            
            # Select trial_01_nr as the visual representative
            trial_name = "trial_01_nr"
            scene_path = os.path.join(ROOT_DIR, "experiments/scenes", mag, s_id, "random_trials", f"{trial_name}.g")
            
            if not os.path.exists(scene_path) or not os.path.exists(image_path):
                print(f"Skipping {mag}/{s_id}: assets not found.")
                continue

            out_dir = os.path.join(OUTPUT_ROOT, mag, s_id)
            print(f"Processing {mag} | {s_id} ... ", end="", flush=True)
            t0 = datetime.datetime.now()
            
            try:
                with open(scene_path, "r") as sf:
                    inventory = sf.read()
                
                # Construct multimodal prompt: instructions + image + scene inventory
                scene_block = "\n\n--- \n## SCENE INVENTORY (Input Data)\n```lisp\n" + inventory + "\n```\n---"
                with Image.open(image_path) as img:
                    img_pil = img.copy()
                prompt_content = [
                    base_prompt,
                    "\n--- \n## TARGET IMAGE\n",
                    img_pil,
                    scene_block,
                ]
                
                # Direct call to VLM without JSON enforcement
                raw_output = client._call_vlm_with_retry(prompt_content, is_json_output=False)
                
            except Exception:
                raw_output = f"EXCEPTION DURING PILOT RUN:\n{traceback.format_exc()}"
            
            elapsed = (datetime.datetime.now() - t0).total_seconds()
            md_path = save_baseline_md(out_dir, trial_name, image_path, scene_path, raw_output, elapsed)
            print(f"DONE. Saved to -> {os.path.relpath(md_path, ROOT_DIR)}")

    print(f"\n>>> EVALUATION FINISHED <<<\n")

if __name__ == "__main__":
    main()
