#!/usr/bin/env python3
import argparse
import json
import os
import subprocess
import sys

PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))


def main():
    parser = argparse.ArgumentParser(description="Run pick-waypoint-only reachability checker")
    parser.add_argument(
        "--scene",
        default=os.path.join(PROJECT_ROOT, "test", "scenes", "scene_named.g"),
        help="Path to input scene .g file",
    )
    parser.add_argument(
        "--object",
        default="",
        help="Optional object name to test only one target",
    )
    parser.add_argument(
        "--json",
        default=os.path.join(PROJECT_ROOT, "generated", "pick_waypoint_report.json"),
        help="Path to JSON report output",
    )
    parser.add_argument(
        "--traj-log",
        default=os.path.join(PROJECT_ROOT, "generated", "pick_waypoint_trajectory.log"),
        help="Path to trajectory log output",
    )
    parser.add_argument(
        "--gripper",
        default="l_gripper",
        help="Gripper frame name",
    )
    args = parser.parse_args()

    exe = os.path.join(PROJECT_ROOT, "bin", "pick_waypoint_check.exe")
    if not os.path.exists(exe):
        print("[ERROR] missing binary:", exe)
        print("[HINT] run: make -C bin pick-waypoint")
        return 2

    cmd = [
        exe,
        args.scene,
        "--gripper",
        args.gripper,
        "--json",
        args.json,
        "--traj-log",
        args.traj_log,
    ]
    if args.object:
        cmd.extend(["--object", args.object])

    print("[RUN]", " ".join(cmd))
    ret = subprocess.run(cmd, cwd=PROJECT_ROOT, check=False)
    if ret.returncode != 0:
        print(f"[ERROR] checker failed with code {ret.returncode}")
        return ret.returncode

    if not os.path.exists(args.json):
        print("[ERROR] report not found:", args.json)
        return 3

    report = json.load(open(args.json, "r", encoding="utf-8"))
    print("[SUMMARY]", json.dumps(report.get("summary", {}), ensure_ascii=False))
    if os.path.exists(args.traj_log):
        print("[TRAJ_LOG]", args.traj_log)
    else:
        print("[WARN] trajectory log not found:", args.traj_log)
    return 0


if __name__ == "__main__":
    sys.exit(main())
