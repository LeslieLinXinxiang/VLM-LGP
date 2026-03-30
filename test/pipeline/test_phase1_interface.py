import json
import os
import sys
import shutil
import argparse

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
sys.path.append(ROOT)

from pipeline.run_phase1 import execute_phase1, validate_plan
from core.utils import load_json


def main():
    parser = argparse.ArgumentParser(description="Standalone Phase1 GUI I/O test")
    parser.add_argument(
        "--save-as",
        default=None,
        help="Optional path to copy final JSON output (avoid overwrite across runs).",
    )
    args = parser.parse_args()

    print("=" * 70)
    print("[TEST] Phase1 Interface I/O Test (GUI image selection)")
    print("=" * 70)

    success, output_path = execute_phase1()
    if not success or not output_path:
        print("[RESULT] Phase1 failed or cancelled.")
        sys.exit(2)

    plan_json = load_json(output_path)
    if not plan_json:
        print(f"[RESULT] Output file is missing or invalid JSON: {output_path}")
        sys.exit(3)

    is_valid, report = validate_plan(plan_json, valid_inventory_list=[])
    print(f"[RESULT] Output file: {output_path}")
    print(f"[RESULT] Validation: {'PASS' if is_valid else 'FAIL'}")

    if args.save_as:
        save_path = os.path.abspath(args.save_as)
        os.makedirs(os.path.dirname(save_path), exist_ok=True)
        shutil.copy(output_path, save_path)
        print(f"[RESULT] Copied output to: {save_path}")

    if "objects" in plan_json and isinstance(plan_json.get("objects"), list):
        print(f"[RESULT] Object count: {len(plan_json['objects'])}")

    if not is_valid:
        print("[DETAIL] Validation Report:")
        print(report)
        sys.exit(4)

    # Print compact output summary for quick manual inspection.
    print("[DETAIL] JSON Preview:")
    print(json.dumps(plan_json, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
