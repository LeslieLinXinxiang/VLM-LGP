import os
import re
import base64
import json
import argparse
from pathlib import Path
from datetime import datetime
import time

# --- MOCK VLM API CALL (To be replaced by actual client in user env) ---
# Assuming a function called query_vlm(prompt, image_path) exists or using standard requests

def encode_image(image_path):
    with open(image_path, "rb") as image_file:
        return base64.b64encode(image_file.read()).decode('utf-8')

def run_trial(mag, scenario, trial_file, prompt_template, output_dir):
    """Executes a single LLM baseline trial."""
    root = Path("/home/leslie/Projects/VLM_LGP")
    
    # 1. Resolve Target Image
    # Target images are in experiments/inputs/cubeStacking/{mag}/cube_n{XX}_{sXX}.png
    s_idx = scenario[1:] # e.g., "01" from "s01"
    mag_num = mag.replace("cubes", "") # e.g., "4" from "4cubes"
    image_path = root / f"experiments/inputs/cubeStacking/{mag}/cube_n{mag_num.zfill(2)}_{scenario}.png"
    
    if not image_path.exists():
        print(f"Error: Image not found at {image_path}")
        return

    # 2. Load Inventory
    with open(trial_file, "r") as f:
        inventory_text = f.read()

    # 3. Assemble Prompt
    full_prompt = prompt_template + f"\n\n--- \n## SCENE INVENTORY (Input Data)\n```lisp\n{inventory_text}\n```\n---"
    
    print(f"Running: {trial_file.name} for {scenario}...")
    
    # 4. Invoke VLM (Simulated call - user needs to confirm the exact command/package)
    # In this environment, I'll use a placeholder or the actual client if configured.
    # For now, I will create the structure and the MD file, with a "PENDING" block if I cannot call API.
    
    # --- Actual API Logic Placeholder ---
    # response = vlm_client.chat(model="gemini-3.1-pro", prompt=full_prompt, images=[image_path])
    # raw_output = response.text
    raw_output = "[SIMULATED VLM OUTPUT - Logic pending vlm_client confirmation]"
    
    # 5. Save Result
    trial_name = trial_file.stem # trial_01_nr
    out_md = output_dir / f"{trial_name}.md"
    out_md.parent.mkdir(parents=True, exist_ok=True)
    
    with open(out_md, "w") as f:
        f.write(f"# Evaluation Result: {trial_name}\n")
        f.write(f"- **Scene**: {mag}/{scenario}\n")
        f.write(f"- **Timestamp**: {datetime.now().isoformat()}\n\n")
        f.write(f"## RAW OUTPUT\n```xml\n{raw_output}\n```\n")

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--mag", type=str, default="4cubes", help="e.g. 4cubes")
    parser.add_argument("--limit", type=int, default=5, help="Limit trials per scenario for pilot")
    args = parser.parse_args()

    root = Path("/home/leslie/Projects/VLM_LGP")
    prompt_path = root / "prompts/baseline_pure_llm.md"
    with open(prompt_path, "r") as f:
        prompt_template = f.read()

    scene_root = root / f"experiments/scenes/{args.mag}"
    output_root = root / "experiments/evaluations/VLM/pure_llm_baseline" / args.mag

    for s_dir in sorted(scene_root.iterdir()):
        if not s_dir.is_dir(): continue
        scenario = s_dir.name # e.g. s01
        
        trial_dir = s_dir / "random_trials"
        if not trial_dir.exists(): continue
        
        count = 0
        for trial_file in sorted(trial_dir.glob("*.g")):
            if count >= args.limit: break
            
            run_trial(args.mag, scenario, trial_file, prompt_template, output_root / scenario)
            count += 1

if __name__ == "__main__":
    main()
