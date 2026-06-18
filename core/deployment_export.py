from __future__ import annotations

import math
import re
from pathlib import Path
from typing import Dict, List, Sequence

TRAJECTORY_BLOCK_RE = re.compile(
    r">>> V-LGP TRAJECTORY START <<<\nDIM: (\d+) (\d+)\n([\s\S]*?)\n>>> V-LGP TRAJECTORY END <<<"
)


def _normalize_21(values: Sequence[float]) -> List[float]:
    row = [float(x) for x in values[:21]]
    if len(row) < 21:
        row.extend([0.0] * (21 - len(row)))
    return row


def parse_trajectory_tasks(stdout: str) -> List[List[List[List[float]]]]:
    """Parse solver stdout into [task][segment][row][values]."""
    tasks: List[List[List[List[float]]]] = []

    for match in TRAJECTORY_BLOCK_RE.finditer(stdout or ""):
        raw_lines = match.group(3).strip().splitlines()
        phased_data: Dict[int, List[List[float]]] = {}

        for line in raw_lines:
            parts = line.split()
            if len(parts) < 8:
                continue

            try:
                time_val = float(parts[0])
                raw_values = [float(x) for x in parts[1:]]
            except ValueError:
                continue

            phase_idx = int(math.floor(time_val - 0.0001))
            if phase_idx < 0:
                phase_idx = 0

            phased_data.setdefault(phase_idx, []).append(raw_values)

        if not phased_data:
            continue

        ordered_segments: List[List[List[float]]] = []
        for idx in range(max(phased_data.keys()) + 1):
            ordered_segments.append(phased_data.get(idx, []))
        tasks.append(ordered_segments)

    return tasks


def export_trajectory_and_gripper_bundle(
    stdout: str,
    output_dir: str | Path,
    traj_filename: str = "traj.txt",
    gripper_filename: str = "gripper.txt",
) -> Dict[str, object]:
    """Export solver stdout into deployment files.

    The trajectory file is written as 21-column rows.
    The gripper file stores 1-based trajectory line indices where the gripper
    toggles. The semantic contract is:
      - default state: open
      - first marker: close
      - second marker: open
      - then alternate
    """
    output_dir = Path(output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    tasks = parse_trajectory_tasks(stdout)
    traj_path = output_dir / traj_filename
    gripper_path = output_dir / gripper_filename

    total_lines = 0
    toggle_lines: List[int] = []

    with traj_path.open("w", encoding="utf-8") as traj_file:
        for task_segments in tasks:
            for segment in task_segments:
                if not segment:
                    continue
                for row in segment:
                    normalized = _normalize_21(row)
                    traj_file.write(" ".join(f"{x:.6f}" for x in normalized) + "\n")
                    total_lines += 1
                toggle_lines.append(total_lines)

    with gripper_path.open("w", encoding="utf-8") as grip_file:
        for line_idx in toggle_lines:
            grip_file.write(f"{line_idx}\n")

    return {
        "output_dir": str(output_dir),
        "trajectory_path": str(traj_path),
        "gripper_path": str(gripper_path),
        "trajectory_line_count": total_lines,
        "toggle_lines": toggle_lines,
        "toggle_semantics": "default_open_then_close_open_alternating",
        "task_count": len(tasks),
        "segment_count": sum(len(task) for task in tasks),
    }
