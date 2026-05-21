import os
import sys
import datetime
from pathlib import Path

# Add project root to sys.path
ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '../..'))
sys.path.append(ROOT_DIR)

from core.vlm import VLMClient

def clean_scene_text(raw_text):
    """Removes the noisy robot definitions to help VLM focus on objects."""
    lines = raw_text.split("\n")
    cleaned = []
    for line in lines:
        if "l_panda" in line or "Prefix:" in line or "Include:" in line or "Edit" in line:
            continue
        cleaned.append(line)
    return "\n".join(cleaned)

def main():
    client = VLMClient()
    prompt_path = "prompts/baseline_pure_llm.md"
    # TARGET: 4cubes s01
    image_path = "experiments/inputs/cubeStacking/4cubes/cube_n04_s01.png"
    scene_path = "experiments/scenes/4cubes/s01/random_trials/trial_01_nr.g"
    
    with open(prompt_path, "r") as f: base = f.read()
    with open(scene_path, "r") as f: scene_raw = f.read()
    
    inventory_cleaned = clean_scene_text(scene_raw)
    
    # EXACT concatenation like magic web-interface
    full_prompt = base + "\n\n### SCENE INVENTORY\n```lisp\n" + inventory_cleaned + "\n```"
    
    print(">>> Executing PURE-LLM (CLEANED INPUT) for n04_s01...")
    t0 = datetime.datetime.now()
    try:
        response = client._call_vlm_with_retry([full_prompt, image_path], is_json_output=False)
        print("\n=== RESPONSE ===\n")
        print(response)
        print("\n=== END ===\n")
    except Exception as e:
        print(f"FAILED: {e}")
    
    elapsed = (datetime.datetime.now() - t0).total_seconds()
    print(f"Time taken: {elapsed:.1f}s")

if __name__ == "__main__":
    main()
