import sys
import os
import time

root_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
sys.path.insert(0, root_path)

import robotic as ry

def run_viewer():
    g_file = os.path.join(root_path, "test_2supports_scene.g")

    C = ry.Config()
    C.addFile(g_file)

    print("\n-----------------------------------------------------------")
    print("2-Supports Test Scene Loaded.")
    print("  - cube_L (orange) and cube_R (yellow) side by side in front of arm")
    print("  - RectPrism (blue) to the right, waiting to be placed on top of cubes")
    print("Confirm everything looks correct before running the solver.")
    print("Close window or Ctrl+C to exit.")
    print("-----------------------------------------------------------\n")

    C.view()

    try:
        while True:
            time.sleep(0.1)
    except KeyboardInterrupt:
        pass

if __name__ == "__main__":
    run_viewer()
