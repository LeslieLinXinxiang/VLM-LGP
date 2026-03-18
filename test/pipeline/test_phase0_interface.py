import argparse
import json
import os
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
sys.path.append(ROOT)

from pipeline.run_phase0 import execute_phase0


REQUIRED_LAYOUT_KEYS = {
    "anon_id",
    "logical_id",
    "shape",
    "object_type",
    "size_signature",
    "color_rgb",
}


def validate_outputs(layout_path: str, scene_named_path: str, reference_scene_path: str) -> bool:
    ok = True

    if not os.path.exists(layout_path):
        print(f"[CHECK] Missing layout: {layout_path}")
        ok = False
    else:
        with open(layout_path, "r") as f:
            layout = json.load(f)
        if not isinstance(layout, list) or not layout:
            print("[CHECK] layout.json is empty or invalid list.")
            ok = False
        else:
            for i, item in enumerate(layout, start=1):
                missing = REQUIRED_LAYOUT_KEYS - set(item.keys())
                if missing:
                    print(f"[CHECK] layout item {i} missing keys: {sorted(missing)}")
                    ok = False

    if not os.path.exists(scene_named_path):
        print(f"[CHECK] Missing scene_named.g: {scene_named_path}")
        ok = False
    else:
        if os.path.exists(reference_scene_path):
            with open(scene_named_path, "r") as f:
                output_scene = f.read()
            with open(reference_scene_path, "r") as f:
                ref_scene = f.read()
            if output_scene != ref_scene:
                print("[CHECK] scene_named.g mismatch with provided reference scene.")
                ok = False

    if ok:
        print("[CHECK] Output validation passed.")
    return ok


def run_mode(mode: str, scene_image: str, scene_named_g: str) -> bool:
    use_vlm = mode == "vlm"
    print("\n" + "=" * 70)
    print(f"[TEST] Running Phase0 mode={mode}")
    print("=" * 70)

    # Note: specs.json is generated internally. We can print it out after step 0 but it's easier to print within the phase0 pipeline.
    # We will print the output layout JSON right after execution.
    print("\n" + "=" * 70)
    print(f"[TEST] Running Phase0 mode={mode}")
    print("=" * 70)

    result = execute_phase0(
        image_path=scene_image,
        scene_named_g_path=scene_named_g,
        use_vlm=use_vlm,
        auto_prepare_from_named_scene=True,
    )

    if not result or not result.get("success"):
        print(f"[TEST] Phase0 mode={mode} failed.")
        return False

    layout_path = result["layout_path"]
    scene_named_path = result["scene_named_path"]

    print(f"[TEST] layout: {layout_path}")
    print(f"[TEST] scene:  {scene_named_path}")
    
    print("\n[VLM OUTPUT] Extracted JSON Layout:")
    if os.path.exists(layout_path):
        with open(layout_path, "r") as f:
            print(json.dumps(json.load(f), indent=2))
    else:
        print("(Layout file missing)")

    return validate_outputs(layout_path, scene_named_path, scene_named_g)


def main():
    parser = argparse.ArgumentParser(description="Phase0 interface test (VLM / RULE modes)")
    parser.add_argument(
        "--scene-image",
        default=os.path.join(ROOT, "generated", "scene_named_view.png"),
        help="Input image for Phase0.",
    )
    parser.add_argument(
        "--scene-named-g",
        default=os.path.join(ROOT, "generated", "scene_named.g"),
        help="Named scene to reverse-build unnamed/specs.",
    )
    parser.add_argument(
        "--mode",
        choices=["rule", "vlm", "both"],
        default="both",
        help="Test mode.",
    )

    args = parser.parse_args()

    if not os.path.exists(args.scene_named_g):
        print(f"[FATAL] scene_named.g not found: {args.scene_named_g}")
        sys.exit(1)

    if not os.path.exists(args.scene_image):
        print(f"[FATAL] scene image not found: {args.scene_image}")
        sys.exit(1)

    all_ok = True
    modes = [args.mode] if args.mode != "both" else ["rule", "vlm"]

    for mode in modes:
        ok = run_mode(mode, args.scene_image, args.scene_named_g)
        all_ok = all_ok and ok

    if all_ok:
        print("\n[RESULT] All selected Phase0 tests passed.")
        sys.exit(0)

    print("\n[RESULT] Some Phase0 tests failed.")
    sys.exit(2)


if __name__ == "__main__":
    main()
