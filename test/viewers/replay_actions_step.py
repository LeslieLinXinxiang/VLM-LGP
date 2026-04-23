#!/usr/bin/env python3
import argparse
import os
import re
import sys
import time
from typing import Dict, List, Optional, Tuple

PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
if PROJECT_ROOT not in sys.path:
    sys.path.insert(0, PROJECT_ROOT)

import robotic as ry

from core.trajectory_parser import TrajectoryParser
from core.utils import load_json


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Step replay V-LGP trajectories: SPACE advances one frame, q quits."
    )
    parser.add_argument("--scene", required=True, help="Path to .g scene file")
    parser.add_argument(
        "--traj-log",
        default="",
        help="Path to raw solver stdout/log containing V-LGP TRAJECTORY blocks",
    )
    parser.add_argument(
        "--fps",
        type=float,
        default=20.0,
        help="Sampling FPS used to generate interpolated frames (step mode still waits for SPACE)",
    )
    parser.add_argument(
        "--time-scale",
        type=float,
        default=1.0,
        help="Time scale passed into trajectory parser (1.0 keeps original timing)",
    )
    parser.add_argument(
        "--task-index",
        type=int,
        default=0,
        help="Which parsed task to replay (0-based)",
    )
    parser.add_argument(
        "--report-json",
        default="",
        help="Optional pick waypoint report json for object feasibility lookup",
    )
    parser.add_argument(
        "--object",
        default="",
        help="Optional object name for infeasible/feasible reporting and log filtering",
    )
    return parser.parse_args()


def read_text(path: str) -> str:
    with open(path, "r", encoding="utf-8") as f:
        return f.read()


def extract_trajectory_blocks(stdout_text: str) -> List[Tuple[int, str]]:
    pattern = (
        r">>> V-LGP TRAJECTORY START <<<\n"
        r"DIM: (\d+) (\d+)\n"
        r"([\s\S]*?)\n"
        r">>> V-LGP TRAJECTORY END <<<"
    )
    out: List[Tuple[int, str]] = []
    for m in re.finditer(pattern, stdout_text):
        out.append((m.start(), m.group(0)))
    return out


def extract_object_entries(stdout_text: str) -> List[Dict[str, object]]:
    """
    Parse checker trajectory log entries in order:
    [OBJECT] <name> action=<a> status=<s>
    followed by either trajectory block or no-trajectory marker.
    """
    object_pat = re.compile(r"^\[OBJECT\]\s+(\S+)\s+action=(\S+)\s+status=(\S+)$", re.MULTILINE)
    no_traj_pat = re.compile(r"^\[TRAJ\]\s+no trajectory generated$", re.MULTILINE)
    block_pat = re.compile(
        r">>> V-LGP TRAJECTORY START <<<\n"
        r"DIM: (\d+) (\d+)\n"
        r"([\s\S]*?)\n"
        r">>> V-LGP TRAJECTORY END <<<"
    )

    entries: List[Dict[str, object]] = []
    for m in object_pat.finditer(stdout_text):
        obj_name, action, status = m.group(1), m.group(2), m.group(3)
        cursor = m.end()
        tail = stdout_text[cursor:]

        block_m = block_pat.search(tail)
        no_traj_m = no_traj_pat.search(tail)

        entry: Dict[str, object] = {
            "name": obj_name,
            "action": action,
            "status": status,
            "blocks": [],
            "has_traj": False,
        }

        if block_m is not None and (no_traj_m is None or block_m.start() < no_traj_m.start()):
            entry["blocks"] = [block_m.group(0)]
            entry["has_traj"] = True

        entries.append(entry)

    return entries


def filter_blocks_for_object(stdout_text: str, obj_name: str) -> List[str]:
    if not obj_name:
        return [b for _, b in extract_trajectory_blocks(stdout_text)]

    selected: List[str] = []
    for start_idx, block in extract_trajectory_blocks(stdout_text):
        # Heuristic: object names usually appear shortly before trajectory dump.
        prefix_window = stdout_text[max(0, start_idx - 800) : start_idx]
        if obj_name in prefix_window:
            selected.append(block)
    return selected


def parse_tasks_from_blocks(blocks: List[str], time_scale: float) -> List[List[List[Dict[str, List[float]]]]]:
    tasks: List[List[List[Dict[str, List[float]]]]] = []
    for b in blocks:
        parsed = TrajectoryParser.parse_all(b, time_scale=time_scale)
        if parsed:
            tasks.extend(parsed)
    return tasks


def parse_object_tasks(stdout_text: str, time_scale: float, obj_filter: str = "") -> List[Dict[str, object]]:
    entries = extract_object_entries(stdout_text)
    out: List[Dict[str, object]] = []
    for e in entries:
        name = str(e.get("name", ""))
        if obj_filter and name != obj_filter:
            continue

        blocks = e.get("blocks", [])
        tasks = parse_tasks_from_blocks(blocks if isinstance(blocks, list) else [], time_scale=time_scale)
        segments: List[List[Dict[str, List[float]]]] = tasks[0] if tasks else []

        out.append(
            {
                "name": name,
                "action": str(e.get("action", "unknown")),
                "status": str(e.get("status", "unknown")),
                "segments": segments,
                "has_traj": bool(e.get("has_traj", False)) and len(segments) > 0,
            }
        )
    return out


def get_object_status(report_json: str, obj_name: str) -> Optional[str]:
    if not report_json or not obj_name:
        return None
    if not os.path.exists(report_json):
        return None
    data = load_json(report_json)
    if not isinstance(data, dict):
        return None
    results = data.get("results", {})
    if not isinstance(results, dict):
        return None
    obj_entry = results.get(obj_name, {})
    if not isinstance(obj_entry, dict):
        return None
    return obj_entry.get("status")


def sample_segment(segment: List[Dict[str, List[float]]], fps: float) -> List[List[float]]:
    if not segment:
        return []
    if len(segment) == 1:
        return [segment[0]["q"]]

    frames: List[List[float]] = []
    dt = 1.0 / max(1.0, fps)

    for i in range(len(segment) - 1):
        p0 = segment[i]
        p1 = segment[i + 1]
        t0, q0 = float(p0["time"]), p0["q"]
        t1, q1 = float(p1["time"]), p1["q"]

        if t1 <= t0:
            continue

        steps = max(1, int((t1 - t0) / dt))
        for s in range(steps):
            alpha = float(s) / float(steps)
            q = [q0[k] * (1.0 - alpha) + q1[k] * alpha for k in range(len(q0))]
            frames.append(q)

    frames.append(segment[-1]["q"])
    return frames


def replay_actions(scene_path: str, objects_data: List[Dict[str, object]], fps: float) -> None:
    C = ry.Config()
    C.addFile(scene_path)

    total_objects = len(objects_data)
    frame_queue: List[Dict[str, object]] = []

    for entry in objects_data:
        obj_name = str(entry.get("name", "unknown"))
        obj_action = str(entry.get("action", "unknown"))
        obj_status = str(entry.get("status", "unknown"))
        segments = entry.get("segments", [])
        if not isinstance(segments, list):
            continue

        for segment in segments:
            frames = sample_segment(segment, fps=fps)
            for q in frames:
                frame_queue.append(
                    {
                        "q": q,
                        "name": obj_name,
                        "action": obj_action,
                        "status": obj_status,
                    }
                )

    print(f"[replay] loaded scene: {scene_path}")
    print(f"[replay] objects in log: {total_objects}")
    print(f"[replay] total frames in queue: {len(frame_queue)}")
    print("[replay] controls: SPACE next frame, q quit")

    if not frame_queue:
        print("[replay] no frames available")
        while True:
            key = C.view(False, "No frames to replay. Press q to quit.")
            if key == ord("q"):
                return
            time.sleep(0.05)

    current = -1
    while True:
        if current < 0:
            msg = "Replay ready. Press SPACE for first frame, q to quit."
        else:
            item = frame_queue[current]
            msg = (
                f"Frame {current + 1}/{len(frame_queue)} | "
                f"{item['name']} ({item['action']}/{item['status']}) | "
                "SPACE next frame, q quit"
            )

        # Blocking wait for a real key press in the render window.
        key = C.view(True, msg)
        if key == ord("q"):
            return
        if key != 32:
            continue

        if current + 1 >= len(frame_queue):
            break

        current += 1
        item = frame_queue[current]
        q = item["q"]
        if isinstance(q, list):
            C.setJointState(q)

    print("[replay] done")
    while True:
        key = C.view(True, "Replay finished. Press q to quit.")
        if key == ord("q"):
            return


def main() -> int:
    args = parse_args()

    scene_path = args.scene
    if not os.path.isabs(scene_path):
        scene_path = os.path.join(PROJECT_ROOT, scene_path)
    if not os.path.exists(scene_path):
        print(f"[error] scene not found: {scene_path}")
        return 1

    obj_status = get_object_status(args.report_json, args.object)
    if obj_status:
        print(f"[status] object='{args.object}' report_status='{obj_status}'")

    if not args.traj_log:
        if obj_status == "infeasible":
            print("[info] object is infeasible and no trajectory log provided -> no action to render")
            return 0
        print("[error] --traj-log is required for replay")
        return 2

    traj_log = args.traj_log
    if not os.path.isabs(traj_log):
        traj_log = os.path.join(PROJECT_ROOT, traj_log)
    if not os.path.exists(traj_log):
        print(f"[error] trajectory log not found: {traj_log}")
        return 3

    stdout_text = read_text(traj_log)
    objects_data = parse_object_tasks(stdout_text, time_scale=args.time_scale, obj_filter=args.object)

    # Fallback for legacy logs without [OBJECT] headers.
    if not objects_data:
        blocks = filter_blocks_for_object(stdout_text, args.object)
        tasks = parse_tasks_from_blocks(blocks, time_scale=args.time_scale)
        if not tasks:
            if obj_status == "infeasible":
                print(
                    "[info] report says infeasible and no trajectory block matched this object -> "
                    "no action generated, skip rendering"
                )
                return 0
            print("[error] no trajectory blocks parsed for replay")
            return 4
        if args.task_index < 0 or args.task_index >= len(tasks):
            print(f"[error] task-index out of range: {args.task_index}, available=[0,{len(tasks)-1}]")
            return 5
        objects_data = [
            {
                "name": args.object if args.object else f"task_{args.task_index}",
                "action": "legacy",
                "status": obj_status if obj_status else "unknown",
                "segments": tasks[args.task_index],
                "has_traj": True,
            }
        ]

    if obj_status == "infeasible":
        print(
            "[info] report says infeasible but trajectory block exists in log -> "
            "rendering available motion blocks for inspection"
        )

    replay_actions(scene_path, objects_data, fps=args.fps)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
