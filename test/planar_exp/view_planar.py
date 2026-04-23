import sys
import os
import time

root_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '../..'))
sys.path.insert(0, root_path)

import robotic as ry

def run_viewer():
    g_file = os.path.join(root_path, "test", "planar_exp", "planar_scene.g")

    C = ry.Config()
    C.addFile(g_file)

    print("\n-----------------------------------------------------------")
    print("Planar Exp Assembly 1 Scene Loaded.")
    print("Objects: FMB Board + 4 parts")
    print("Inspect the layout and confirm scale and transforms.")
    print("Close the window or press Ctrl+C to exit.")
    print("-----------------------------------------------------------\n")

    C.view()

    try:
        while True:
            time.sleep(0.1)
    except KeyboardInterrupt:
        pass

if __name__ == "__main__":
    run_viewer()
