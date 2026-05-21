#!/usr/bin/env python3
"""
TASK-029: Quick validation test for Prompt 1 (image-only visual planner)
Run once to check if the PDDL Plan Skeleton output is sensible.

Usage:
    source /home/leslie/anaconda3/etc/profile.d/conda.sh && conda activate vlm_jazzy
    source scripts/env.sh
    python experiments/scripts/test_prompt1_visual_planner.py
"""
import sys
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))

from core.vlm import VLMClient

PROMPT = """# MISSION: IMAGE-ONLY ROBOTIC ASSEMBLY PLANNER

You are a Robotic Assembly Compiler. Your goal is to generate a step-by-step assembly sequence based ONLY on the provided image.

## HARD PRINCIPLE
1. The provided image is the ONLY source of truth.
2. You do NOT have a scene file. You must detect objects and their counts visually.
3. You must plan from the BOTTOM of the structure up to the TOP.

---

## 1. REQUIRED REASONING ORDER (Inside <REASONING_DRAFT>)

Follow this sequence strictly:

### Step 1: Visual Stock Audit
List every object you see in the scene by color, shape, and initial position.
- Example: "1 red cube (left), 1 long blue rectangular prism (bottom), 1 green triangular prism (top)."

### Step 2: Layer Extraction (Bottom to Top)
Define which objects belong to which layer:
- Layer 1: Resting directly on the table.
- Layer 2: Resting on objects from Layer 1.
- ... and so on.

### Step 3: Support Logic (Plumb-line check)
For each object in Layer N, identify its supporter(s) in Layer N-1.
- If it spans across multiple blocks, it is a "bridge" and has multiple supporters.

---

## 2. OBJECT NAMING CONVENTION
Because you don't have object IDs, you must name objects by their visual identity:
`[color/length]-[type]-[relative-position]`
- Examples: `red-cube-left`, `long-blue-prism-bottom`, `green-triangle-top`.

---

## 3. OUTPUT CONTRACT

Output exactly in this XML structure:

<REASONING_DRAFT>
[Your concise reasoning following the 3-step order above]
</REASONING_DRAFT>

<ACTION_PLAN>
STEP 1: PICK [object-name], PLACE ON [table-center/table-left/table-right]
STEP 2: PICK [object-name], PLACE ON [target-object-name]
... (Add steps as needed)
</ACTION_PLAN>

---

## 4. FINAL SELF-CHECK
1. Did I list ALL objects in the audit?
2. Is the sequence strictly bottom-to-top?
3. Does every PICK have a matching PLACE?
4. For bridges, did I mention all supporters in the reasoning?
"""

def test_prompt1(image_path: str, output_path: str = None):
    client = VLMClient()
    image_file = Path(image_path)

    if not image_file.exists():
        print(f"[ERROR] Image not found: {image_path}")
        return

    print(f"[PROMPT1_TEST] Testing with image: {image_path}")
    print(f"[PROMPT1_TEST] Calling VLM...")

    try:
        response = client._call_gemini_with_retry(
            [PROMPT, image_file],
            is_json_output=False
        )

        print("\n" + "="*60)
        print("VLM RAW RESPONSE:")
        print("="*60)
        print(response)
        print("="*60 + "\n")

        # Save output
        if output_path is None:
            output_path = ROOT / "experiments/outputs/baseline_rm_v2/prompt1_test.md"
        Path(output_path).parent.mkdir(parents=True, exist_ok=True)

        md_content = f"# Prompt 1 Test Run\n\n"
        md_content += f"**Image**: `{image_path}`\n\n"
        md_content += f"## VLM Output\n\n{response}\n"
        Path(output_path).write_text(md_content, encoding='utf-8')
        print(f"[PROMPT1_TEST] Output saved to: {output_path}")

    except Exception as e:
        print(f"[ERROR] VLM call failed: {e}")
        import traceback
        traceback.print_exc()


if __name__ == "__main__":
    test_image = str(ROOT / "experiments/inputs/cubeStacking/4cubes/cube_n04_s01.png")
    test_prompt1(test_image)
