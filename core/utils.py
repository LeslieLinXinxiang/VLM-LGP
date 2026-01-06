# core/utils.py
import re
import os
import json
from PIL import Image

def load_json(path):
    if not os.path.exists(path): return None
    with open(path, 'r') as f: return json.load(f)

def clean_vlm_json_output(raw_text):
    """
    Robust JSON extractor. Handles list/str inputs gracefully.
    """
    # 1. 强制类型转换: 确保我们处理的是字符串
    if not isinstance(raw_text, str):
        # 如果是 list，尝试取第一个元素或转字符串
        if isinstance(raw_text, list):
            if len(raw_text) > 0:
                raw_text = str(raw_text[0])
            else:
                return "{}"
        else:
            raw_text = str(raw_text)

    content = raw_text.strip()
    
    # 2. 尝试提取 ```json ... ```
    # split() 返回 list，必须取下标 [1] 才能拿到中间的内容
    if "```json" in content:
        try:
            parts = content.split("```json")
            if len(parts) > 1:
                return parts[1].split("```")[0].strip()
        except IndexError:
            pass
            
    # 3. 尝试提取 ``` ... ```
    if "```" in content:
        try:
            parts = content.split("```")
            # 通常结构是: 前言 ``` json内容 ``` 后语
            # 所以我们要取 parts[1]
            if len(parts) >= 2: 
                return parts[1].strip()
        except IndexError:
            pass

    # 4. 如果没有标记，尝试找 { ... }
    # 这是一个兜底策略，防止 VLM 忘了写 markdown 标记
    start = content.find('{')
    end = content.rfind('}')
    if start != -1 and end != -1:
        return content[start:end+1]

    # 5. 最后手段：直接返回原文本 (假设全是JSON)
    return content

def extract_and_save_files_from_xml(xml_string, task_dir):
    """
    Parses XML, saves files to a specific task_dir.
    The filenames (.fol, .lgp) are taken directly from the VLM's <FILE> tag.
    
    Args:
        xml_string: The raw string from VLM containing <FILE> tags.
        task_dir: The specific directory (e.g., 'generated/node_1_run') to save files.
    
    Returns:
        List of absolute paths to the saved .lgp files.
    """
    if not os.path.exists(task_dir):
        os.makedirs(task_dir)
        
    if not isinstance(xml_string, str): xml_string = str(xml_string)
        
    pattern = re.compile(r'<FILE name="([^"]+)">\s*(.*?)\s*</FILE>', re.IGNORECASE | re.DOTALL)
    matches = pattern.findall(xml_string)
    
    saved_lgp_paths = []
    
    if not matches:
        print(f"[Core.Utils] Warning: No <FILE> tags found in VLM output for dir {task_dir}.")
        return saved_lgp_paths

    # Process files directly, no re-indexing needed.
    # VLM should generate names like "step_1_batch_1.fol", etc.
    # We need to link the .lgp to its .fol
    
    fol_map = {} # Maps base filename to content
    lgp_map = {} # Maps base filename to content
    
    for filename, content in matches:
        base_name = os.path.splitext(filename)[0]
        if filename.endswith('.fol'):
            fol_map[base_name] = content.strip()
        elif filename.endswith('.lgp'):
            lgp_map[base_name] = content.strip()

    # Now save them, ensuring .lgp points to the correct .fol
    for base_name, lgp_content_raw in lgp_map.items():
        if base_name in fol_map:
            # --- Save FOL ---
            fol_filename = f"{base_name}.fol"
            fol_path = os.path.join(task_dir, fol_filename)
            with open(fol_path, 'w') as f:
                f.write(fol_map[base_name])

            # --- Save LGP (and correct path) ---
            lgp_filename = f"{base_name}.lgp"
            lgp_path = os.path.join(task_dir, lgp_filename)
            
            # Correct the 'fol:' path to be relative to task_dir
            lgp_content_corrected = re.sub(
                r'fol: <.*?>', 
                f'fol: <{fol_filename}>', 
                lgp_content_raw, 
                flags=re.IGNORECASE
            )
            
            with open(lgp_path, 'w') as f:
                f.write(lgp_content_corrected)
                
            print(f"   -> Saved to {task_dir}: {fol_filename}, {lgp_filename}")
            saved_lgp_paths.append(lgp_path)

    return sorted(saved_lgp_paths) # Return sorted paths

def parse_and_inject(src_g_path, mapping_dict, dst_g_path):
    if not os.path.exists(src_g_path):
        raise FileNotFoundError(f"Source file not found: {src_g_path}")
    with open(src_g_path, 'r') as f: content = f.read()
    print(f"[Core.Utils] Injecting names into scene...")
    sorted_keys = sorted(mapping_dict.keys(), key=len, reverse=True)
    for anon_id in sorted_keys:
        semantic_name = mapping_dict[anon_id]
        if anon_id in content:
            content = content.replace(anon_id, semantic_name)
    os.makedirs(os.path.dirname(dst_g_path), exist_ok=True)
    with open(dst_g_path, 'w') as f: f.write(content)
    print(f"[Core.Utils] Success. New scene saved to: {dst_g_path}")

def extract_mapping_from_layout(layout_list):
    mapping = {}
    for item in layout_list:
        if isinstance(item, dict):
            anon = item.get("anon_id")
            logical = item.get("logical_id")
            if anon and logical: mapping[anon] = logical
    return mapping

def load_incontext_examples(examples_dir):
    """
    Loads PNG/JSON pairs from a directory to create a Few-Shot Learning buffer.
    Returns: A list of mixed media [Text, Image, Text, Image, ...] compatible with VLM.
    """
    if not os.path.exists(examples_dir):
        print(f"[Utils] Warning: In-context directory not found: {examples_dir}")
        return []

    examples_buffer = ["\n--- VISUAL DICTIONARY (GROUND TRUTH DEFINITIONS) ---\n"]
    examples_buffer.append("Study the following examples to understand the EXACT spatial definitions:\n")

    # Get all JSON files and sort them to ensure deterministic order
    files = sorted([f for f in os.listdir(examples_dir) if f.endswith(".json")])
    
    loaded_count = 0
    for js_file in files:
        base_name = os.path.splitext(js_file)[0]
        png_file = base_name + ".png"
        
        js_path = os.path.join(examples_dir, js_file)
        png_path = os.path.join(examples_dir, png_file)
        
        if os.path.exists(png_path):
            # Load Content
            try:
                # 1. Image
                img = Image.open(png_path)
                
                # 2. JSON Text
                with open(js_path, 'r') as f:
                    data = json.load(f)
                # Minimize tokens: Compact JSON string
                json_str = json.dumps(data) 
                
                # 3. Add to Buffer
                examples_buffer.append(f"Example: {base_name.upper()}")
                examples_buffer.append(img)
                examples_buffer.append(f"Definition:\n```json\n{json_str}\n```\n")
                
                loaded_count += 1
            except Exception as e:
                print(f"[Utils] Error loading example {base_name}: {e}")

    print(f"[Utils] Loaded {loaded_count} in-context examples from {examples_dir}")
    return examples_buffer