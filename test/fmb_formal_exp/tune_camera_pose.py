import argparse
import os
import sys

import robotic as ry

try:
    import tkinter as tk
    from tkinter import filedialog
except Exception:
    tk = None
    filedialog = None


ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
sys.path.insert(0, ROOT_DIR)


DEFAULT_SCENE_DIR = os.path.join(ROOT_DIR, "test")


def _pick_scene_files():
    if tk is None or filedialog is None:
        return []

    root = tk.Tk()
    root.withdraw()
    root.attributes("-topmost", True)
    paths = filedialog.askopenfilenames(
        title="Select one or more RAI scene files",
        initialdir=DEFAULT_SCENE_DIR,
        filetypes=[("RAI Scene", "*.g"), ("All Files", "*.*")],
    )
    root.destroy()
    return list(paths)


def _format_list(values):
    return "[" + ", ".join(f"{v:.6f}" for v in values) + "]"


def _print_copy_block(scene_file, pose7, view_name):
    pos = pose7[:3]
    quat = pose7[3:]

    pos_txt = " ".join(f"{v:.6f}" for v in pos)
    quat_txt = " ".join(f"{v:.6f}" for v in quat)

    print("\n" + "=" * 72)
    print(f"[SCENE] {scene_file}")
    print("[CAMERA_POSE]")
    print(f"pos:  {_format_list(pos)}")
    print(f"quat: {_format_list(quat)}")
    print("\n[PASTE_TO_DEFAULT_VIEWS]")
    print("{")
    print(f"    \"name\": \"{view_name}\",")
    print(f"    \"pos\": {_format_list(pos)},")
    print(f"    \"quat\": {_format_list(quat)},")
    print("},")
    print("\n[CLI_FOR_RENDER_GUIDING_IMAGES]")
    print(
        "python3 test/fmb_guiding_input/render_guiding_images.py "
        f"\"{scene_file}\" --camera-pos {pos_txt} --camera-quat {quat_txt} "
        f"--view-name {view_name} --no-picker"
    )
    print("=" * 72)


def tune_one_scene(scene_file, view_name):
    if not os.path.exists(scene_file):
        raise FileNotFoundError(f"Scene file not found: {scene_file}")

    C = ry.Config()
    C.addFile(scene_file)

    msg = (
        "Adjust camera with mouse, then press ENTER.\\n"
        "Terminal will print copy-ready camera parameters."
    )
    C.view(True, msg)

    viewer = C.get_viewer()
    pose7 = list(viewer.getCamera_pose())
    _print_copy_block(scene_file, pose7, view_name)


def parse_args():
    parser = argparse.ArgumentParser(
        description="Interactive camera pose tuner for RAI scenes"
    )
    parser.add_argument(
        "scenes",
        nargs="*",
        help="Optional scene files. If omitted, a file picker will open.",
    )
    parser.add_argument(
        "--no-picker",
        action="store_true",
        help="Disable file picker fallback.",
    )
    parser.add_argument(
        "--view-name",
        default="view_01",
        help="View name used in the printed copy block.",
    )
    return parser.parse_args()


def main():
    args = parse_args()
    scenes = list(args.scenes)

    if not scenes and not args.no_picker:
        scenes = _pick_scene_files()

    if not scenes:
        print("[FATAL] No scene files selected.")
        return 1

    for scene_file in scenes:
        tune_one_scene(scene_file, args.view_name)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
