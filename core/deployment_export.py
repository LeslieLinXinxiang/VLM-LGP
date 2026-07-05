from __future__ import annotations

import math
import re
from pathlib import Path
from typing import Dict, List, Sequence
import numpy as np

TRAJECTORY_BLOCK_RE = re.compile(
    r">>> V-LGP TRAJECTORY START <<<\nDIM: (\d+) (\d+)\n([\s\S]*?)\n>>> V-LGP TRAJECTORY END <<<"
)


def _normalize_21(values: Sequence[float]) -> List[float]:
    row = [float(x) for x in values[:21]]
    if len(row) < 21:
        row.extend([0.0] * (21 - len(row)))
    return row


def _quintic_blend(row0: List[float], row1: List[float], num_frames: int, dt: float = 0.001) -> List[List[float]]:
    q0, v0, a0 = np.array(row0[0:7]), np.array(row0[7:14]), np.array(row0[14:21])
    q1, v1, a1 = np.array(row1[0:7]), np.zeros(7), np.zeros(7)
    
    T = num_frames * dt
    A = np.array([
        [1, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 0, 0],
        [0, 0, 2, 0, 0, 0],
        [1, T, T**2, T**3, T**4, T**5],
        [0, 1, 2*T, 3*T**2, 4*T**3, 5*T**4],
        [0, 0, 2, 6*T, 12*T**2, 20*T**3]
    ])
    
    blended_joints = []
    for j in range(7):
        B = np.array([q0[j], v0[j], a0[j], q1[j], v1[j], a1[j]])
        C = np.linalg.solve(A, B)
        
        joint_traj = []
        for i in range(1, num_frames + 1):
            t = i * dt
            q_t = C[0] + C[1]*t + C[2]*t**2 + C[3]*t**3 + C[4]*t**4 + C[5]*t**5
            v_t = C[1] + 2*C[2]*t + 3*C[3]*t**2 + 4*C[4]*t**3 + 5*C[5]*t**4
            a_t = 2*C[2] + 6*C[3]*t + 12*C[4]*t**2 + 20*C[5]*t**3
            joint_traj.append((q_t, v_t, a_t))
        blended_joints.append(joint_traj)
        
    result = []
    for i in range(num_frames):
        row = []
        for j in range(7): row.append(blended_joints[j][i][0])
        for j in range(7): row.append(blended_joints[j][i][1])
        for j in range(7): row.append(blended_joints[j][i][2])
        result.append(row)
    return result


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
    pause_frames: int = 1000,
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
                
                # We will blend the last 100 frames to smooth velocity to 0
                blend_frames = min(100, len(segment) - 1)
                if blend_frames > 0:
                    base_rows = segment[:-blend_frames]
                    tail_rows = segment[-blend_frames:]
                    
                    # Normalize base rows and write them
                    for row in base_rows:
                        normalized = _normalize_21(row)
                        traj_file.write(" ".join(f"{x:.6f}" for x in normalized) + "\n")
                        total_lines += 1
                        
                    # Generate quintic blend for the tail
                    row0 = _normalize_21(base_rows[-1] if base_rows else segment[0])
                    row1 = _normalize_21(segment[-1])
                    blended_tail = _quintic_blend(row0, row1, blend_frames)
                    
                    for row in blended_tail:
                        traj_file.write(" ".join(f"{x:.6f}" for x in row) + "\n")
                        total_lines += 1
                        
                    normalized = blended_tail[-1]
                else:
                    normalized = None
                    for row in segment:
                        normalized = _normalize_21(row)
                        traj_file.write(" ".join(f"{x:.6f}" for x in normalized) + "\n")
                        total_lines += 1
                
                toggle_lines.append(total_lines)

                # Insert static pause frames so the arm waits for the gripper
                if normalized is not None and pause_frames > 0:
                    pause_row = list(normalized)
                    # Force velocity and acceleration to 0
                    for i in range(7, 21):
                        pause_row[i] = 0.0
                    pause_str = " ".join(f"{x:.6f}" for x in pause_row) + "\n"
                    for _ in range(pause_frames):
                        traj_file.write(pause_str)
                        total_lines += 1

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
