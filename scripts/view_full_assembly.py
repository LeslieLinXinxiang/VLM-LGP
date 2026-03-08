import sys
import os
import time

root_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
sys.path.insert(0, root_path)

import robotic as ry

def run_viewer():
    g_file = os.path.join(root_path, "full_assembly_scene.g")

    C = ry.Config()
    C.addFile(g_file)

    print("\n-----------------------------------------------------------")
    print("Full Assembly Scene Loaded.")
    print("Objects: 8 RectPrism | 2 Cylinder | 4 Cube | 1 TriPrism")
    print("Inspect the layout and confirm:")
    print("  - No collisions or penetrations")
    print("  - All objects within robot reach")
    print("  - Grid arrangement looks correct")
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
