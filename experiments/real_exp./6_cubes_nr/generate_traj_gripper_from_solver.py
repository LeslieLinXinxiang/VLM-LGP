#!/usr/bin/env python3
"""Local entrypoint for rebuilding traj.txt and gripper.txt in 6_cubes_nr.

Run from anywhere:
  python3 experiments/real_exp./6_cubes_nr/generate_traj_gripper_from_solver.py
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path


def _parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Rebuild 6_cubes_nr traj/gripper from solver log")
    parser.add_argument(
        "--log",
        default="solver_run_6cubes_nr.log",
        help="Solver log path containing TRAJECTORY blocks.",
    )
    parser.add_argument(
        "--output-dir",
        default=None,
        help="Output directory. Defaults to this dataset directory.",
    )
    return parser.parse_args()


def main() -> int:
    root_dir = Path(__file__).resolve().parents[3]
    sys.path.insert(0, str(root_dir))

    from core.deployment_export import export_trajectory_and_gripper_bundle

    args = _parse_args()
    log_path = Path(args.log)
    if not log_path.is_absolute():
        log_path = (root_dir / log_path).resolve()

    output_dir = Path(args.output_dir) if args.output_dir else Path(__file__).resolve().parent
    if not output_dir.is_absolute():
        output_dir = (root_dir / output_dir).resolve()

    if not log_path.exists():
        raise FileNotFoundError(f"Solver log not found: {log_path}")

    stdout = log_path.read_text(encoding="utf-8")
    result = export_trajectory_and_gripper_bundle(stdout=stdout, output_dir=output_dir)

    print("[6_cubes_nr] Rebuild complete")
    print(f"  log: {log_path}")
    print(f"  output: {output_dir}")
    print(f"  traj.txt lines: {result['trajectory_line_count']}")
    print(f"  gripper.txt toggles: {len(result['toggle_lines'])}")
    print(f"  toggle lines: {', '.join(map(str, result['toggle_lines']))}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
