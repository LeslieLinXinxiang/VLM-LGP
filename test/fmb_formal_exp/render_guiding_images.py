import argparse
import os
import sys

import cv2
import robotic as ry

try:
    import tkinter as tk
    from tkinter import filedialog
except Exception:
    tk = None
    filedialog = None


ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
sys.path.insert(0, ROOT_DIR)


CAM_NAME = "manual_camera_frame"
DEFAULT_FOCAL_LENGTH = 1.732
DEFAULT_WIDTH = 1920
DEFAULT_HEIGHT = 1920
DEFAULT_Z_NEAR = 0.1
DEFAULT_Z_FAR = 100.0

# 先给一版默认相机位姿，后续直接改这里即可。
DEFAULT_VIEWS = [
    {
        "name": "view_01",
        "pos": [0.709, 0.407, 1.17],
        "quat": [0.1270, -0.291, -0.869, 0.379],
    },
]


def _pick_scene_files():
    if tk is None or filedialog is None:
        return []

    root = tk.Tk()
    root.withdraw()
    root.attributes("-topmost", True)
    paths = filedialog.askopenfilenames(
        title="Select one or more RAI scene files",
        initialdir=os.path.join(ROOT_DIR, "test"),
        filetypes=[("RAI Scene", "*.g"), ("All Files", "*.*")],
    )
    root.destroy()
    return list(paths)


def _load_scene(scene_file):
    if not os.path.exists(scene_file):
        raise FileNotFoundError(f"Scene file not found: {scene_file}")

    C = ry.Config()
    C.addFile(scene_file)
    return C


def _build_intrinsics(width, height, focal_length, z_near, z_far):
    return (
        f"focalLength:{focal_length}, width:{width}, height:{height}, "
        f"zRange:[{z_near}, {z_far}]"
    )


def _ensure_camera(C, view_cfg, cam_intrinsics):
    cam = C.getFrame(CAM_NAME)
    if not cam:
        cam = C.addFrame(CAM_NAME, "world", cam_intrinsics)

    cam.setPosition(view_cfg["pos"])
    cam.setQuaternion(view_cfg["quat"])
    return cam


def capture_scene(scene_file, out_dir, views, cam_intrinsics):
    scene_basename = os.path.splitext(os.path.basename(scene_file))[0]
    scene_parent = os.path.basename(os.path.dirname(scene_file))
    if not scene_parent:
        scene_parent = scene_basename
    scene_out_dir = os.path.join(out_dir, scene_parent)
    os.makedirs(scene_out_dir, exist_ok=True)

    C = _load_scene(scene_file)
    saved_paths = []

    for idx, view_cfg in enumerate(views, start=1):
        cam = _ensure_camera(C, view_cfg, cam_intrinsics)
        camera_view = ry.CameraView(C)
        camera_view.setCamera(cam)

        rgb, _ = camera_view.computeImageAndDepth(C)
        if rgb is None or rgb.size == 0:
            raise RuntimeError(f"Render failed for {scene_file} / {view_cfg['name']}")

        bgr = cv2.cvtColor(rgb, cv2.COLOR_RGB2BGR)
        if len(views) == 1:
            file_name = f"{scene_basename}.png"
        else:
            file_name = f"{scene_basename}_{view_cfg['name']}.png"
        save_path = os.path.join(scene_out_dir, file_name)
        os.makedirs(os.path.dirname(save_path), exist_ok=True)
        if not cv2.imwrite(save_path, bgr):
            raise RuntimeError(f"Failed to write image: {save_path}")

        saved_paths.append(save_path)
        print(f"[OK] {save_path}")

    return saved_paths


def parse_args():
    parser = argparse.ArgumentParser(
        description="Render sequential guiding images from RAI .g scene files"
    )
    parser.add_argument(
        "scenes",
        nargs="*",
        help="Optional scene files. If omitted, a file picker will open.",
    )
    parser.add_argument(
        "--out-dir",
        default=os.path.join(ROOT_DIR, "test", "fmb_formal_exp", "images"),
        help="Output directory for rendered PNGs.",
    )
    parser.add_argument(
        "--camera-pos",
        nargs=3,
        type=float,
        metavar=("X", "Y", "Z"),
        help="Override camera position for single-view rendering.",
    )
    parser.add_argument(
        "--camera-quat",
        nargs=4,
        type=float,
        metavar=("Q0", "Q1", "Q2", "Q3"),
        help="Override camera quaternion for single-view rendering.",
    )
    parser.add_argument(
        "--view-name",
        default="view_01",
        help="View name used when --camera-pos/--camera-quat are provided.",
    )
    parser.add_argument(
        "--width",
        type=int,
        default=DEFAULT_WIDTH,
        help="Render width in pixels for this script only.",
    )
    parser.add_argument(
        "--height",
        type=int,
        default=DEFAULT_HEIGHT,
        help="Render height in pixels for this script only.",
    )
    parser.add_argument(
        "--focal-length",
        type=float,
        default=DEFAULT_FOCAL_LENGTH,
        help="Camera focal length for this script only.",
    )
    parser.add_argument(
        "--z-near",
        type=float,
        default=DEFAULT_Z_NEAR,
        help="Near depth range limit for this script only.",
    )
    parser.add_argument(
        "--z-far",
        type=float,
        default=DEFAULT_Z_FAR,
        help="Far depth range limit for this script only.",
    )
    parser.add_argument(
        "--no-picker",
        action="store_true",
        help="Disable file picker fallback.",
    )
    return parser.parse_args()


def main():
    args = parse_args()
    scenes = list(args.scenes)

    if args.width <= 0 or args.height <= 0:
        print("[FATAL] --width and --height must be positive integers.")
        return 2
    if args.z_near <= 0 or args.z_far <= args.z_near:
        print("[FATAL] zRange must satisfy 0 < --z-near < --z-far.")
        return 2

    if (args.camera_pos is None) != (args.camera_quat is None):
        print("[FATAL] --camera-pos and --camera-quat must be provided together.")
        return 2

    if not scenes and not args.no_picker:
        scenes = _pick_scene_files()

    if not scenes:
        print("[FATAL] No scene files selected.")
        return 1

    if args.camera_pos is not None:
        views = [
            {
                "name": args.view_name,
                "pos": list(args.camera_pos),
                "quat": list(args.camera_quat),
            }
        ]
    else:
        views = DEFAULT_VIEWS

    cam_intrinsics = _build_intrinsics(
        width=args.width,
        height=args.height,
        focal_length=args.focal_length,
        z_near=args.z_near,
        z_far=args.z_far,
    )
    print(f"[Camera] Intrinsics: {cam_intrinsics}")

    os.makedirs(args.out_dir, exist_ok=True)

    for scene_file in scenes:
        print(f"[Render] {scene_file}")
        capture_scene(scene_file, args.out_dir, views, cam_intrinsics)

    print(f"[DONE] Images saved under: {args.out_dir}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())