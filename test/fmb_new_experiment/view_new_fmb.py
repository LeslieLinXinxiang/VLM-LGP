import os
import time

import robotic as ry

ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
SCENE_FILE = os.path.join(os.path.dirname(__file__), "scene_new_fmb_preview.g")


def run_viewer() -> None:
    if not os.path.exists(SCENE_FILE):
        raise FileNotFoundError(f"Scene file not found: {SCENE_FILE}")

    cfg = ry.Config()
    cfg.addFile(SCENE_FILE)

    print("-" * 68)
    print("FMB new_fmb preview scene loaded.")
    print("Inspect colors, object orientation, and relative positions.")
    print("Close the window or press Ctrl+C in terminal to exit.")
    print("-" * 68)

    cfg.view()
    try:
        while True:
            time.sleep(0.1)
    except KeyboardInterrupt:
        print("Viewer exited.")


if __name__ == "__main__":
    run_viewer()
