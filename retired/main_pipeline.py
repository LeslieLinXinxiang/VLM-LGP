import os
import sys
import glob
import re
import subprocess
import google.generativeai as genai
from PIL import Image

# ================= 配置区域 =================
GOOGLE_API_KEY = "AIzaSyARsSHUFi9oG3II1R-tLr6mnhdy6rZk_cQ"   # Key stays same

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
PROMPTS_DIR = os.path.join(BASE_DIR, "prompts")
ICL_DIR = os.path.join(BASE_DIR, "incontext_training") 
BIN_DIR = os.path.join(BASE_DIR, "bin") 
EXECUTABLE_NAME = "x.exe" 

genai.configure(api_key=GOOGLE_API_KEY)
MODEL_NAME = 'gemini-3-pro-preview' # Updated to latest stable model recommended

# ================= 辅助函数 =================
def read_text(path):
    if not os.path.exists(path):
        print(f"[Error] File not found: {path}")
        sys.exit(1)
    with open(path, 'r', encoding='utf-8') as f:
        return f.read()

def save_text(content, path):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)

def load_image(path):
    if not os.path.exists(path):
        print(f"[Error] Image not found: {path}")
        sys.exit(1)
    return Image.open(path)

def determine_output_dir(image_path):
    # Try to extract scene name from filename (e.g., "test_1_Manual.png")
    filename = os.path.basename(image_path)
    # Simple logic: create a folder named after the image file (minus extension)
    folder_name = os.path.splitext(filename)[0]
    return os.path.join(BASE_DIR, "test_results", folder_name)

# ================= 核心逻辑 =================

class VLMPipeline:
    def __init__(self, test_image_path):
        self.test_image_path = test_image_path
        self.output_dir = determine_output_dir(test_image_path)
        self.model = genai.GenerativeModel(MODEL_NAME)
        self.chat_history = [] 

    def load_icl_module(self, subfolder_name, header_text):
        """加载特定子文件夹下的图片资源和JSON数据"""
        module_path = os.path.join(ICL_DIR, subfolder_name)
        content_block = []
        if not os.path.exists(module_path):
            return content_block

        content_block.append(f"\n\n{header_text}\n")

        # Load JSONs (Metadata)
        json_paths = sorted(glob.glob(os.path.join(module_path, "*.json")))
        if json_paths:
            content_block.append("\n**REFERENCE DATA (JSON Metadata):**\n")
            for jp in json_paths:
                file_name = os.path.basename(jp)
                json_text = read_text(jp)
                print(f"   [Loaded JSON]: {subfolder_name}/{file_name}")
                content_block.append(f"```json\n// File: {file_name}\n{json_text}\n```\n")

        # Load Images
        img_paths = sorted(glob.glob(os.path.join(module_path, "*.png")) + 
                           glob.glob(os.path.join(module_path, "*.jpg")))
        if img_paths:
            content_block.append("\n**VISUAL REFERENCE:**\n")
            for p in img_paths:
                content_block.append(load_image(p))
                print(f"   [Loaded Image]: {subfolder_name}/{os.path.basename(p)}")
        
        return content_block

    def step_1_reasoning(self):
        print(f"\n>>> [Phase 1] Analyzing Assembly Manual...")

        # 1. Load Prompts
        sys_prompt = read_text(os.path.join(PROMPTS_DIR, "system_prompt.md"))
        icl_text_guide = read_text(os.path.join(PROMPTS_DIR, "incontext_training_prompt.txt"))

        input_content = [
            "## System Role & Objective\n", sys_prompt,
            "\n\n## Knowledge Base (Visual Dictionary)\n", icl_text_guide
        ]

        # 2. Load Only Essential Modules (Components & Zones)
        # [MODIFIED] Removed 'spatial_guide' and 'training_scenes' as requested
        input_content.extend(self.load_icl_module("components", "### Module A: Object Component Library"))
        input_content.extend(self.load_icl_module("initial_scene", "### Module B: Global Scene Layout & Zones"))
        
        # 3. Load The Manual (Test Image)
        test_img = load_image(self.test_image_path)
        input_content.extend([
            "\n\n## Current Mission: Assembly Manual Analysis\n",
            "The image below is the Assembly Manual. Analyze the sequence 1..N. Identify objects added in each step. Generate 3 variants of the plan, then output the best one split into phases (max 2 objects per phase).",
            test_img
        ])

        # 4. API Call
        try:
            print("   [Gemini] Thinking...")
            response = self.model.generate_content(input_content)
            reasoning_output = response.text
        except Exception as e:
            print(f"\n[Fatal Error] Phase 1 API Call Failed: {e}")
            sys.exit(1)
        
        self.chat_history.append({"role": "user", "parts": input_content})
        self.chat_history.append({"role": "model", "parts": [reasoning_output]})
        
        print(f"\n--- AI Assembly Plan ---\n{reasoning_output}...\n(Output truncated for brevity)\n---------------------------")
        return reasoning_output

    def step_2_generation(self):
        print(f"\n>>> [Phase 2] Generating Symbolic Code (.fol)...")
        # Ensure output_prompt.md is also simplified if it contained spatial references
        # For now, we assume it focuses on syntax
        output_prompt = read_text(os.path.join(PROMPTS_DIR, "output_prompt.md"))
        
        chat = self.model.start_chat(history=self.chat_history)
        try:
            response = chat.send_message(output_prompt)
            return response.text
        except Exception as e:
            print(f"[Error] {e}")
            sys.exit(1)

    def step_3_extraction(self, raw_response):
        print(f"\n>>> [Phase 3] Extracting Files to {self.output_dir}...")
        if os.path.exists(self.output_dir):
            # Clean old files
            for f in glob.glob(os.path.join(self.output_dir, "step_*.*")): os.remove(f)
        else:
            os.makedirs(self.output_dir)

        # Regex to find <FILE name="..."> content </FILE>
        xml_pattern = re.compile(r'<FILE name="([^"]+)">\s*(.*?)\s*</FILE>', re.IGNORECASE | re.DOTALL)
        matches = xml_pattern.findall(raw_response)
        
        count = 0
        if matches:
            for filename, content in matches:
                # Clean markdown code blocks if present inside XML
                clean_content = content.replace("```lgp", "").replace("```fol", "").replace("```", "").strip()
                save_text(clean_content, os.path.join(self.output_dir, filename))
                print(f"   [Saved]: {filename}")
                count += 1
        else:
            print("[Warning] No XML <FILE> tags found. Checking for markdown blocks...")
            # Fallback logic if AI forgets XML
            blocks = re.findall(r'```(?:fol|lgp)\n(.*?)```', raw_response, re.DOTALL)
            for i, blk in enumerate(blocks):
                fname = f"step_{i+1}.fol"
                save_text(blk.strip(), os.path.join(self.output_dir, fname))
                print(f"   [Saved (Fallback)]: {fname}")
                count += 1
                
        return count > 0

    def step_4_execution(self):
        # Execution logic assumes C++ solver reads all step_*.fol files in the dir
        print(f"\n>>> [Phase 4] Executing Solver...")
        # Check if C++ binary exists
        exe_path = os.path.join(BIN_DIR, EXECUTABLE_NAME)
        # Note: In Windows/WSL environments, execution might differ.
        # This assumes standard subprocess call.
        if not os.path.exists(exe_path):
             print(f"[Error] Solver not found at {exe_path}")
             return

        cmd = [f"./{EXECUTABLE_NAME}", os.path.abspath(self.output_dir)]
        try:
            subprocess.run(cmd, cwd=BIN_DIR)
        except Exception as e:
            print(f"[Execution Error] {e}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python main_pipeline.py <generated_manual_image.png>")
        sys.exit(1)
    
    pipeline = VLMPipeline(sys.argv[1])
    pipeline.step_1_reasoning()
    if pipeline.step_3_extraction(pipeline.step_2_generation()):
        pipeline.step_4_execution()