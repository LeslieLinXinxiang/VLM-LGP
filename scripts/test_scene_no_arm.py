import sys
import os
import robotic as ry

root_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))

def run_interactive_view():
    g_file = os.path.join(root_path, "test_scene.g")
    print(f"Loading scene: {g_file}")
    
    C = ry.Config()
    C.addFile(g_file)
    
    print("\n-----------------------------------------------------------")
    print("3D Viewer opened.")
    print("Please use your mouse to drag, rotate, and zoom the scene.")
    print("When you are done checking the parameters, PRESS SPACE BAR with the window focused to exit.")
    print("-----------------------------------------------------------\n")
    # Use C.view() for interactive viewing in modern robotic versions
    C.view()
    
    import time
    try:
        while True:
            time.sleep(0.1)
    except KeyboardInterrupt:
        print("\nViewer exited.")

if __name__ == "__main__":
    run_interactive_view()
