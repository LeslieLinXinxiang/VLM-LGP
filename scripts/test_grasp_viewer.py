import sys
import os
import robotic as ry
import time

root_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))

def run_viewer():
    g_file = os.path.join(root_path, "test_grasp_scene.g")
    
    C = ry.Config()
    C.addFile(g_file)
    
    print("\n-----------------------------------------------------------")
    print("Test Grasp Scene Loaded.")
    print("Please inspect the relative positions of the Panda Arm, Cube, and TriPrism.")
    print("Make sure there are no unintended collisions.")
    print("Press SPACE or close the window to continue.")
    print("-----------------------------------------------------------\n")
    
    C.view()
    
    try:
        while True:
            time.sleep(0.1)
    except KeyboardInterrupt:
        pass

if __name__ == "__main__":
    run_viewer()
