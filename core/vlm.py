# core/vlm.py (V16.0 Architecture: Generic Phase 1 + Inventory Phase 2)
import google.generativeai as genai
import os
import json
import time
import cv2
from PIL import Image
from core.utils import clean_vlm_json_output, load_json

# [CONFIG] Gemini 2.5 Pro (Stable)
MODEL_NAME = 'gemini-3-flash-preview'
GOOGLE_API_KEY = "AIzaSyAZwB5CMwfgzsTXoaA6yVRWpuX_A1jYO7M" # Check your key
genai.configure(api_key=GOOGLE_API_KEY)

class VLMClient:
    def __init__(self):
        try:
            self.model = genai.GenerativeModel(MODEL_NAME)
            print(f"[Core.VLM] Initializing model: {MODEL_NAME}...")
        except Exception as e:
            print(f"[Core.VLM] Error initializing model: {e}")

    def _call_gemini_with_retry(self, prompt_content, is_json_output=True):
        # ... (保持原有的流式输出和重试逻辑不变) ...
        generation_config = genai.types.GenerationConfig(
            max_output_tokens=65536, 
            temperature=0.1
        )
        req_opts = {'timeout': 900} 
        
        for attempt in range(3):
            try:
                # print(f"   >>> [VLM] Requesting (Attempt {attempt+1})...", end="", flush=True)
                response_stream = self.model.generate_content(prompt_content, generation_config=generation_config, stream=True, request_options=req_opts)
                full_text = ""
                for chunk in response_stream:
                    if chunk.text: full_text += chunk.text
                        # print(".", end="", flush=True)
                # print(" Done.")

                if not full_text:
                    print(f"\n[VLM] Warning: Empty response.")
                    time.sleep(2)
                    continue 

                if is_json_output:
                    try:
                        return json.loads(clean_vlm_json_output(full_text))
                    except json.JSONDecodeError:
                        time.sleep(1)
                        continue 
                else:
                    return full_text
            except Exception as e:
                print(f"\n[VLM] API Error: {e}")
                time.sleep(2)
                continue
        raise RuntimeError("VLM call failed.")

    # --- PHASE 0: MATCHING ---
    def match_objects(self, image_bgr, specs_json_path, prompt_path):
        # ... (保持不变) ...
        with open(prompt_path, 'r') as f: template = f.read()
        specs = load_json(specs_json_path)
        img_pil = Image.fromarray(cv2.cvtColor(image_bgr, cv2.COLOR_BGR2RGB))
        prompt_content = [template, "\n--- INPUT DATA ---\n", "1. Scene Image:", img_pil, "2. Specs:", f"```json\n{json.dumps(specs)}\n```"]
        return self._call_gemini_with_retry(prompt_content)

    # --- PHASE 1: PLANNING (GENERIC - NO ID MAPPING) ---
    # [CHANGE] Removed 'mapping_list' argument
    def generate_assembly_plan(self, target_img_path, prompt_path, example_content=None, feedback_context=None):
        with open(prompt_path, 'r') as f:
            template = f.read()
            
        img_pil = Image.open(target_img_path)
        
        # 1. System Instructions
        prompt_content = [template]
        
        # 2. Few-Shot Examples (The "Teaching" Phase)
        if example_content:
            prompt_content.extend(example_content)
        
        # 3. Actual Task Data
        prompt_content.extend([
            "\n--- MISSION START: ACTUAL TASK ---\n",
            "Based on the definitions you have learned, analyze this Target Image:",
            img_pil,
            "Now, output the Assembly Plan JSON:"
        ])
        
        if feedback_context:
            prompt_content.append(f"\n{feedback_context}")
            
        return self._call_gemini_with_retry(prompt_content)
    
    def run_phase1_analyst(self, target_img_path, prompt_path, example_content=None):
        with open(prompt_path, 'r') as f:
            template = f.read()
            
        img_pil = Image.open(target_img_path)
        
        # Construct Prompt
        prompt_content = [template]
        
        # Add Visual In-Context Examples (Teaching Data)
        if example_content:
            prompt_content.extend(example_content)
        
        # Add Test Data
        prompt_content.extend([
            "\n--- START VISUAL ANALYSIS ---\n",
            "Refer to the definitions above. Analyze the following Clean Test Image:",
            img_pil,
            "Output your natural language report:"
        ])
        
        # Force Text Output (is_json_output=False)
        print(f"   >>> [VLM] Running Analyst (Vision -> Text)...")
        return self._call_gemini_with_retry(prompt_content, is_json_output=False)

    # [STEP 2] The Architect: Text Report -> JSON Structure
    def run_phase1_architect(self, analyst_report, prompt_path, feedback_context=None):
        with open(prompt_path, 'r') as f:
            template = f.read()

        # Construct Prompt (Pure Text)
        prompt_content = [
            template,
            "\n--- INPUT FIELD REPORT ---\n",
            f"{analyst_report}\n",
            "\n--- MISSION ---\n",
            "Generate the strict JSON based on the report above."
        ]

        # Inject Feedback if previous JSON failed validation
        if feedback_context:
            prompt_content.append(f"\n[PREVIOUS ERROR & FEEDBACK]:\n{feedback_context}")

        # Force JSON Output (is_json_output=True)
        print(f"   >>> [VLM] Running Architect (Text -> JSON)...")
        return self._call_gemini_with_retry(prompt_content, is_json_output=True)

    # --- PHASE 2: STRATEGY (ALLOCATION AWARE) ---
    def propose_strategies(self, current_img_bgr, initial_img_bgr, node_data, target_graph, inventory_data, prompt_path):
        with open(prompt_path, 'r') as f: template = f.read()
        
        img_init_pil = Image.fromarray(cv2.cvtColor(initial_img_bgr, cv2.COLOR_BGR2RGB))
        
        prompt_content = [
            template,
            "\n--- INPUT DATA ---\n",
            "1. Initial Scene (Ref):", img_init_pil,
            "2. Live Inventory:", f"```json\n{json.dumps(inventory_data, indent=2)}\n```",
            "3. Generic Node Request:", f"```json\n{json.dumps(node_data)}\n```",
            "4. Target Graph:", f"```json\n{json.dumps(target_graph)}\n```"
        ]
        return self._call_gemini_with_retry(prompt_content)

    # --- PHASE 2: COMPILATION (Decider & Coder) ---
    # [CHANGE] Removed target_img_bgr argument
    def decide_and_compile(self, strategy_options, current_img_bgr, initial_img_bgr, node_data, inventory_data, previous_log, prompt_path):
        with open(prompt_path, 'r') as f: template = f.read()
        
        img_curr_pil = Image.fromarray(cv2.cvtColor(current_img_bgr, cv2.COLOR_BGR2RGB))
        img_init_pil = Image.fromarray(cv2.cvtColor(initial_img_bgr, cv2.COLOR_BGR2RGB))

        history_str = previous_log if previous_log else "None (Foundation Layer)"

        prompt_content = [
            template,
            "\n--- INPUT DATA ---\n",
            "1. Strategies & Allocation:", f"```json\n{json.dumps(strategy_options)}\n```", # Pass FULL strategy object
            "2. LIVE INVENTORY (VALID IDs):", f"```json\n{json.dumps(inventory_data)}\n```", # <--- FIX: INJECT INVENTORY
            "3. COMPLETED STEPS (History):", f"```json\n{history_str}\n```", 
            "4. Initial Scene:", img_init_pil,
            "5. Current Scene:", img_curr_pil,
            "6. Generic Node Request:", f"```json\n{json.dumps(node_data)}\n```"
        ]
        return self._call_gemini_with_retry(prompt_content, is_json_output=False)
    
    def run_phase3_analyst(self, reality_img_path, prompt_path, example_content=None):
        """
        Step A: Visual Perception.
        Inputs: Image + Few-Shot Examples.
        Output: Natural Language Report.
        """
        with open(prompt_path, 'r') as f: template = f.read()
        img_pil = Image.open(reality_img_path)
        
        prompt_content = [template]
        
        # Inject In-Context Examples (The "Teaching Data")
        if example_content:
            prompt_content.extend(example_content)
        
        # Inject The "Test Case"
        prompt_content.extend([
            "\n--- INSPECTION START: TEST CASE ---\n",
            "Analyze this Clean Reality Image:",
            img_pil,
            "Output your Visual Inventory and Spatial Status:"
        ])
        
        print(f"   >>> [P3] Analyst scanning reality...")
        return self._call_gemini_with_retry(prompt_content, is_json_output=False)

    def run_phase3_architect(self, inspector_report, prompt_path):
        """
        Step B: Digitization.
        Inputs: Analyst Report.
        Output: Current State JSON.
        """
        with open(prompt_path, 'r') as f: template = f.read()
        
        prompt_content = [
            template,
            "\n--- FIELD REPORT ---\n",
            inspector_report,
            "\n--- MISSION ---\n",
            "Generate the JSON layout."
        ]
        
        print(f"   >>> [P3] Architect digitizing state...")
        return self._call_gemini_with_retry(prompt_content, is_json_output=True)
