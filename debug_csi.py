import os
import sys
import google.generativeai as genai

# 1. 打印 utils.py 的真实内容，看看它到底长什么样
print("\n" + "="*40)
print(">>> [CSI] INSPECTING core/utils.py ...")
print("="*40)
try:
    with open("core/utils.py", "r") as f:
        lines = f.readlines()
        # 打印 clean_vlm_json_output 函数附近的代码
        found = False
        for i, line in enumerate(lines):
            if "def clean_vlm_json_output" in line:
                found = True
            if found and i < len(lines):
                print(f"{i+1}: {line.strip()}")
                if "return" in line and found and i > 5: # 打印几行后停止
                    pass
except Exception as e:
    print(f"Error reading utils.py: {e}")

# 2. 打印 vlm.py 的真实内容
print("\n" + "="*40)
print(">>> [CSI] INSPECTING core/vlm.py ...")
print("="*40)
try:
    with open("core/vlm.py", "r") as f:
        lines = f.readlines()
        for i, line in enumerate(lines):
            # 检查 _call_gemini_with_retry 的实现
            if "def _call_gemini_with_retry" in line:
                print(f"{i+1}: {line.strip()}")
                # 打印接下来 10 行
                for j in range(1, 10):
                    if i+j < len(lines):
                        print(f"{i+1+j}: {lines[i+j].strip()}")
                break
except Exception as e:
    print(f"Error reading vlm.py: {e}")

# 3. 现场测试 Gemini API 返回类型
print("\n" + "="*40)
print(">>> [CSI] TESTING GEMINI RETURN TYPE ...")
print("="*40)

# 这一段必须和 core/vlm.py 里的配置完全一致
GOOGLE_API_KEY = "AIzaSyARsSHUFi9oG3II1R-tLr6mnhdy6rZk_cQ"
MODEL_NAME = 'gemini-3-pro-preview' # 或者是 gemini-3-pro-preview

try:
    genai.configure(api_key=GOOGLE_API_KEY)
    model = genai.GenerativeModel(MODEL_NAME)
    print(f"Sending test prompt to {MODEL_NAME}...")
    response = model.generate_content("Output strictly this JSON: {\"test\": \"ok\"}")
    
    print(f"\n[ANALYSIS RESULT]")
    print(f"response object type: {type(response)}")
    print(f"response.text type: {type(response.text)}")
    print(f"response.text value: {repr(response.text)}")
    
    if isinstance(response.text, str):
        print(">>> VERDICT: API returns STRING. (Normal)")
    else:
        print(">>> VERDICT: API returns SOMETHING ELSE. (Abnormal)")

except Exception as e:
    print(f"API Test Failed: {e}")