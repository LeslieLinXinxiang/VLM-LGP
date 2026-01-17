import robotic as ry
import sys
import os

# 1. Load Scene
scene_file = "test.g"
if len(sys.argv) > 1: scene_file = sys.argv[1]

print(f">>> Loading {scene_file}...")
C = ry.Config()
C.addFile(scene_file)

print("="*50)
print("   CAMERA TUNING MODE (Prof. MIT)")
print("="*50)
print("1. use Mouse [Right: Pan, Left: Rotate, Wheel: Zoom]")
print("2. Adjust view to your desired angle.")
print("3. Press [ENTER] in the window.")
print("4. Watch the TERMINAL output below.")
print("5. Copy the numbers to your script.")
print("="*50)

# [Key Trick] Passing a message string enables the info overlay
# The 'True' makes it blocking. When you press Enter, it unblocks and often dumps info.
C.view(True, "Adjust Camera -> Press ENTER to print Pose")

# Modern RAI bindings sometimes require explicit query after unblocking
# Let's try to get the viewer pose if available, or rely on stdout
try:
    # 获取 Viewer 对象
    viewer = C.view() # Re-call to get context? No.
    # RAI C++ 这里的逻辑通常是直接打印到 cout
    print("\n>>> If you didn't see coordinates above, check if RAI printed lines starting with 'X=<...>'")
except:
    pass