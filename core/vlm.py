import os
import json
import time
import cv2
import base64
from io import BytesIO
from PIL import Image
from core.utils import clean_vlm_json_output, load_json

try:
    from openai import OpenAI
except ImportError:
    OpenAI = None

try:
    import google.generativeai as genai
except ImportError:
    genai = None

# [CONFIG] Gemini vs Qwen
MODEL_NAME = os.getenv("VLM_MODEL_NAME", "qwen3-vl-plus-2025-12-19")
VLM_TEMPERATURE = float(os.getenv("VLM_TEMPERATURE", "0.05"))
VLM_TOP_P = float(os.getenv("VLM_TOP_P", "0.35"))
VLM_PRINT_RAW_OUTPUT = os.getenv("VLM_PRINT_RAW_OUTPUT", "1") == "1"
VLM_SAVE_RAW_OUTPUT = os.getenv("VLM_SAVE_RAW_OUTPUT", "0") == "1"
VLM_RAW_OUTPUT_PATH = os.getenv("VLM_RAW_OUTPUT_PATH", "generated/phase1_raw_output.txt")

class VLMClient:
    def __init__(self):
        self.client_type = None
        self.model = None
        self.openai_client = None
        try:
            qwen_key = os.getenv("QWEN_API_KEY")
            openai_key = os.getenv("OPENAI_API_KEY")
            gemini_key = os.getenv("GOOGLE_API_KEY") or os.getenv("GEMINI_API_KEY")

            if qwen_key or openai_key or "qwen" in MODEL_NAME.lower():
                if not OpenAI:
                    raise RuntimeError("openai package not installed. Run 'pip install openai'.")
                api_key = qwen_key or openai_key
                if not api_key:
                    raise RuntimeError("Missing QWEN_API_KEY or OPENAI_API_KEY")
                base_url = os.getenv("OPENAI_BASE_URL", "https://dashscope.aliyuncs.com/compatible-mode/v1")
                self.openai_client = OpenAI(api_key=api_key, base_url=base_url)
                self.client_type = "openai"
                print(f"[Core.VLM] Initializing OpenAI/Qwen client for: {MODEL_NAME}...")
            elif gemini_key:
                genai.configure(api_key=gemini_key)
                self.model = genai.GenerativeModel(MODEL_NAME)
                self.client_type = "gemini"
                print(f"[Core.VLM] Initializing Gemini model: {MODEL_NAME}...")
            else:
                print("[Core.VLM] Missing API keys for VLM.")
        except Exception as e:
            print(f"[Core.VLM] Error initializing model: {e}")

    def _call_gemini_with_retry(self, prompt_content, is_json_output=True):
        if not self.client_type:
            raise RuntimeError("VLM client is not initialized.")

        for attempt in range(3):
            try:
                if self.client_type == "openai":
                    messages_content = []
                    for item in prompt_content:
                        if isinstance(item, str):
                            messages_content.append({"type": "text", "text": item})
                        elif isinstance(item, Image.Image):
                            # OpenAI image_url path expects JPEG/PNG bytes. Convert alpha modes to RGB for JPEG safety.
                            image_for_upload = item
                            if image_for_upload.mode in ("RGBA", "LA"):
                                alpha = image_for_upload.getchannel("A")
                                bg = Image.new("RGB", image_for_upload.size, (255, 255, 255))
                                bg.paste(image_for_upload.convert("RGBA"), mask=alpha)
                                image_for_upload = bg
                            elif image_for_upload.mode == "P":
                                image_for_upload = image_for_upload.convert("RGBA").convert("RGB")
                            elif image_for_upload.mode != "RGB":
                                image_for_upload = image_for_upload.convert("RGB")

                            buffered = BytesIO()
                            image_for_upload.save(buffered, format="JPEG")
                            img_str = base64.b64encode(buffered.getvalue()).decode("utf-8")
                            messages_content.append({
                                "type": "image_url",
                                "image_url": {"url": f"data:image/jpeg;base64,{img_str}"}
                            })
                    response = self.openai_client.chat.completions.create(
                        model=MODEL_NAME,
                        messages=[{"role": "user", "content": messages_content}],
                        temperature=VLM_TEMPERATURE,
                        top_p=VLM_TOP_P,
                        stream=False
                    )
                    full_text = response.choices[0].message.content
                elif self.client_type == "gemini":
                    generation_config = genai.types.GenerationConfig(
                        max_output_tokens=65536, 
                        temperature=VLM_TEMPERATURE,
                        top_p=VLM_TOP_P
                    )
                    req_opts = {'timeout': 900} 
                    response_stream = self.model.generate_content(prompt_content, generation_config=generation_config, stream=True, request_options=req_opts)
                    full_text = ""
                    for chunk in response_stream:
                        if chunk.text: full_text += chunk.text
                
                if not full_text:
                    print(f"\n[VLM] Warning: Empty response.")
                    time.sleep(2)
                    continue 

                if VLM_PRINT_RAW_OUTPUT:
                    print("\n=== VLM RAW OUTPUT START ===")
                    print(full_text)
                    print("=== VLM RAW OUTPUT END ===\n")

                if VLM_SAVE_RAW_OUTPUT:
                    try:
                        root_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
                        save_path = os.path.join(root_dir, VLM_RAW_OUTPUT_PATH)
                        os.makedirs(os.path.dirname(save_path), exist_ok=True)
                        with open(save_path, "w", encoding="utf-8") as f:
                            f.write(full_text)
                    except Exception as save_err:
                        print(f"[VLM] Warning: failed to save raw output: {save_err}")

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

    # --- PHASE 2 (NEW): Graph-first strategist / selector JSON APIs ---
    def phase2_generate_strategies(self, phase1_json, prompt_path, rejection_feedback=None):
        with open(prompt_path, "r", encoding="utf-8") as f:
            template = f.read()

        payload = {"phase1_json": phase1_json}
        if rejection_feedback:
            payload["rejection_feedback"] = rejection_feedback

        prompt_content = [
            template,
            "\n--- INPUT DATA ---\n",
            json.dumps(payload, ensure_ascii=True),
        ]
        return self._call_gemini_with_retry(prompt_content, is_json_output=True)

    def phase2_select_strategy(self, phase1_json, prompt1_output, prompt_path, rejection_feedback=None):
        with open(prompt_path, "r", encoding="utf-8") as f:
            template = f.read()

        payload = {
            "phase1_json": phase1_json,
            "strategies": prompt1_output.get("strategies", prompt1_output.get("candidates", [])),
        }
        if rejection_feedback:
            payload["rejection_feedback"] = rejection_feedback

        prompt_content = [
            template,
            "\n--- INPUT DATA ---\n",
            json.dumps(payload, ensure_ascii=True),
        ]
        return self._call_gemini_with_retry(prompt_content, is_json_output=True)
