#!/usr/bin/env python3
"""Generate traj.txt and gripper.txt from solver stdout.

This is a thin wrapper around core.deployment_export.export_trajectory_and_gripper_bundle.
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path


def _parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Generate traj/gripper from solver log")
    parser.add_argument(
        "--log",
        default="solver_run_6cubes_nr.log",
        help="Solver log path containing TRAJECTORY blocks",
    )
    parser.add_argument(
        "--output-dir",
        default="experiments/real_exp./6_cubes_nr",
        help="Directory to write traj.txt and gripper.txt",
    )
    return parser.parse_args()


def main() -> int:
    args = _parse_args()
    project_root = Path(__file__).resolve().parents[1]
    sys.path.insert(0, str(project_root))

    from core.deployment_export import export_trajectory_and_gripper_bundle

    log_path = Path(args.log)
    if not log_path.is_absolute():
        log_path = (project_root / log_path).resolve()

    output_dir = Path(args.output_dir)
    if not output_dir.is_absolute():
        output_dir = (project_root / output_dir).resolve()

    if not log_path.exists():
        raise FileNotFoundError(f"Solver log not found: {log_path}")

    stdout = log_path.read_text(encoding="utf-8")
    result = export_trajectory_and_gripper_bundle(stdout=stdout, output_dir=output_dir)

    print("[GripperGen] Done")
    print(f"  log: {log_path}")
    print(f"  output_dir: {output_dir}")
    print(f"  traj lines: {result['trajectory_line_count']}")
    print(f"  gripper toggles: {len(result['toggle_lines'])}")
    print(f"  toggle semantics: {result['toggle_semantics']}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
