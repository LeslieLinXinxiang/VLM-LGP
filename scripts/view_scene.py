import sys
import os
import time

root_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
sys.path.insert(0, root_path)

import robotic as ry

def run_viewer():
    if len(sys.argv) > 1:
        g_file = sys.argv[1]
    else:
        g_file = os.path.join(root_path, "generated", "scene_named.g")

    C = ry.Config()
    C.addFile(g_file)

    print("\n-----------------------------------------------------------")
    print(f"Loaded Scene: {g_file}")
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
