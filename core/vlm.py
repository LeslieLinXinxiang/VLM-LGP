import os
import json
import time
import cv2
import base64
from PIL import Image
from io import BytesIO
from core.utils import clean_vlm_json_output, load_json

import httpx
import httpx
from dotenv import load_dotenv

try:
    import google.genai as genai
    from google.genai import types as genai_types
    HAS_GEMINI = True
except ImportError:
    HAS_GEMINI = False

# Load .env from project root
_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
load_dotenv(os.path.join(_ROOT, ".env"), override=False)

# ============================================================================
# Backend Switch — set VLM_BACKEND=qwen or VLM_BACKEND=gemini in .env
# ============================================================================
VLM_BACKEND = os.getenv("VLM_BACKEND", "qwen")

QWEN_API_KEY = os.getenv("QWEN_API_KEY", "")
QWEN_MODEL   = os.getenv("QWEN_MODEL_NAME", "qwen3.5-flash")
QWEN_PROXY   = os.getenv("QWEN_PROXY_URL") or None

GEMINI_API_KEY = os.getenv("GEMINI_API_KEY", "")
GEMINI_MODEL   = os.getenv("GEMINI_MODEL_NAME", "gemini-3-flash-preview")
GEMINI_PROXY   = os.getenv("GEMINI_PROXY_URL") or None

# Active config — resolved at import time; rest of file uses these unchanged
API_KEY    = QWEN_API_KEY   if VLM_BACKEND == "qwen" else GEMINI_API_KEY
MODEL_NAME = QWEN_MODEL     if VLM_BACKEND == "qwen" else GEMINI_MODEL
PROXY_URL  = QWEN_PROXY     if VLM_BACKEND == "qwen" else GEMINI_PROXY
# ============================================================================

# ============================================================================
VLM_TEMPERATURE = 0.0
VLM_TOP_P = 0.35
VLM_PRINT_RAW_OUTPUT = True
VLM_SAVE_RAW_OUTPUT = False
VLM_RAW_OUTPUT_PATH = "generated/phase1_raw_output.txt"

class VLMClient:
    def __init__(self):
        self.backend = VLM_BACKEND
        if self.backend == "gemini":
            if not HAS_GEMINI:
                raise ImportError("VLM_BACKEND='gemini' requested, but 'google-genai' is not installed.")
            _http = httpx.Client(proxy=PROXY_URL)
            self.client = genai.Client(api_key=API_KEY, http_options={"httpx_client": _http})
            self.model = MODEL_NAME
            print(f"[Core.VLM] Initialized Gemini: {self.model} (proxy={PROXY_URL})")
        elif self.backend == "qwen":
            self.http_client = httpx.Client(trust_env=False)
            self.model = MODEL_NAME
            print(f"[Core.VLM] Initialized Qwen: {self.model}")
    
    def _image_to_base64(self, image_bgr):
        _, buffer = cv2.imencode('.jpg', image_bgr)
        return base64.b64encode(buffer).decode('utf-8')

    def _to_jpeg_safe_rgb(self, img: Image.Image) -> Image.Image:
        """Convert arbitrary PIL modes to JPEG-safe RGB."""
        if img.mode == "RGB":
            return img

        # Preserve visual content for images with alpha by compositing on white.
        if img.mode in ("RGBA", "LA"):
            alpha = img.getchannel("A")
            base = Image.new("RGB", img.size, (255, 255, 255))
            base.paste(img.convert("RGBA"), mask=alpha)
            return base

        # Paletted PNGs may carry transparency via info dict.
        if img.mode == "P" and "transparency" in img.info:
            rgba = img.convert("RGBA")
            alpha = rgba.getchannel("A")
            base = Image.new("RGB", rgba.size, (255, 255, 255))
            base.paste(rgba, mask=alpha)
            return base

        return img.convert("RGB")

    def _prepare_qwen_messages(self, prompt_text, images_list=None):
        content = []
        if prompt_text:
            content.append({"type": "text", "text": prompt_text})
        if images_list:
            for img in images_list:
                if isinstance(img, Image.Image):
                    img = self._to_jpeg_safe_rgb(img)
                    buf = BytesIO()
                    img.save(buf, format="JPEG")
                    b64 = base64.b64encode(buf.getvalue()).decode("utf-8")
                    content.append({"type": "image_url", "image_url": {"url": f"data:image/jpeg;base64,{b64}"}})
                elif isinstance(img, str):
                    content.append({"type": "image_url", "image_url": {"url": f"data:image/jpeg;base64,{img}"}})
        return content
    
    def _call_vlm_with_retry(self, prompt_content, is_json_output=True):
        """
        统一的 VLM 调用接口，根据 backend 分发到不同实现
        prompt_content 是列表，可包含：文本、PIL Image 等
        """
        if self.backend == "gemini":
            return self._call_gemini_with_retry(prompt_content, is_json_output)
        elif self.backend == "qwen":
            return self._call_qwen_with_retry(prompt_content, is_json_output)
    
    def _call_qwen_with_retry(self, prompt_content, is_json_output=True):
        QWEN_URL = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions"
        for attempt in range(3):
            try:
                text_parts, images = [], []
                for item in prompt_content:
                    if isinstance(item, str):
                        text_parts.append(item)
                    elif isinstance(item, Image.Image):
                        images.append(item)

                payload = {
                    "model": self.model,
                    "messages": [{"role": "user", "content": self._prepare_qwen_messages("\n".join(text_parts), images or None)}],
                    "temperature": VLM_TEMPERATURE,
                    "top_p": VLM_TOP_P,
                    "max_tokens": 65536,
                }
                headers = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
                response = self.http_client.post(QWEN_URL, json=payload, headers=headers, timeout=120)
                response.raise_for_status()

                choices = response.json().get("choices", [])
                full_text = choices[0].get("message", {}).get("content", "") if choices else ""
                if isinstance(full_text, list):
                    full_text = "\n".join(x.get("text", "") for x in full_text if isinstance(x, dict))

                if not full_text:
                    time.sleep(2); continue

                if VLM_PRINT_RAW_OUTPUT:
                    print("\n=== VLM RAW OUTPUT START ==="); print(full_text); print("=== VLM RAW OUTPUT END ===\n")
                if VLM_SAVE_RAW_OUTPUT:
                    try:
                        save_path = os.path.join(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")), VLM_RAW_OUTPUT_PATH)
                        os.makedirs(os.path.dirname(save_path), exist_ok=True)
                        open(save_path, "w", encoding="utf-8").write(full_text)
                    except Exception as e:
                        print(f"[VLM] Warning: failed to save raw output: {e}")

                if is_json_output:
                    try:
                        return json.loads(clean_vlm_json_output(full_text))
                    except json.JSONDecodeError:
                        time.sleep(1); continue
                else:
                    return full_text

            except httpx.HTTPStatusError as e:
                code = e.response.status_code if e.response is not None else "?"
                print(f"\n[VLM] Qwen API Error: HTTP {code} - {(e.response.text if e.response else '')[:200]}")
                time.sleep(2)
            except Exception as e:
                print(f"\n[VLM] Qwen API Error: {e}")
                time.sleep(2)
        raise RuntimeError("VLM call failed.")

    def _call_gemini_with_retry(self, prompt_content, is_json_output=True):
        """Call Gemini API with retry logic"""
        if not HAS_GEMINI:
            raise ImportError("'google-genai' is not installed, cannot call Gemini API.")
        for attempt in range(3):
            try:
                config = genai_types.GenerateContentConfig(
                    max_output_tokens=65536,
                    temperature=VLM_TEMPERATURE,
                    top_p=VLM_TOP_P,
                )
                response = self.client.models.generate_content(
                    model=self.model,
                    contents=prompt_content,
                    config=config,
                )
                full_text = response.text
                
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
        return self._call_vlm_with_retry(prompt_content)

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
            
        return self._call_vlm_with_retry(prompt_content)
    
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
        return self._call_vlm_with_retry(prompt_content, is_json_output=False)

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
        return self._call_vlm_with_retry(prompt_content, is_json_output=True)

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
        return self._call_vlm_with_retry(prompt_content)

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
        return self._call_vlm_with_retry(prompt_content, is_json_output=False)
    
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
        return self._call_vlm_with_retry(prompt_content, is_json_output=False)

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
        return self._call_vlm_with_retry(prompt_content, is_json_output=True)

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
        return self._call_vlm_with_retry(prompt_content, is_json_output=True)

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
        return self._call_vlm_with_retry(prompt_content, is_json_output=True)
