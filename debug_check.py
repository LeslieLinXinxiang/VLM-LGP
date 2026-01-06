print(">>> [1] Python starts...")

try:
    print(">>> [2] Importing os & sys...")
    import os
    import sys
    print("    Success.")
except Exception as e:
    print(f"    FAIL: {e}")

try:
    print(">>> [3] Importing google.generativeai...")
    import google.generativeai as genai
    print("    Success.")
except Exception as e:
    print(f"    FAIL: {e}")

try:
    print(">>> [4] Importing robotic (RAI)...")
    import robotic as ry
    print("    Success.")
except Exception as e:
    print(f"    FAIL: {e}")

try:
    print(">>> [5] Importing local modules...")
    # 手动添加 core 路径
    sys.path.append(os.path.abspath("."))
    from core.vision import SimCamera
    from core.vlm import VLMClient
    print("    Success.")
except Exception as e:
    print(f"    FAIL: {e}")

print(">>> [6] Debug Check Complete.")