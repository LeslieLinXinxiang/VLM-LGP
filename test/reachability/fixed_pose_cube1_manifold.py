#!/usr/bin/env python3
"""
Fixed-6D grasp prototype on Panda (7-DOF): visualize the remaining 1D redundancy.

Mathematical prototype used in this script:
1) Fixed grasp pose constraints at the target object frame (cube_1):
   p_gripper - p_obj = 0
   z_gripper = z_obj
   x_gripper dot y_obj = 1

2) With 7 arm joints and 6 end-effector constraints, local solution set is 1D.
   We parameterize by psi := q7 and solve:

     q*(psi) = arg min ||f(q) - f*||^2  s.t. q7 = psi, joint limits

3) Continuation-like tracing:
   Sweep psi on a grid, warm-start each solve with previous feasible q*(psi).

Outputs:
- fig1_joint_manifold.png: q_i vs psi
- fig2_residuals.png: position/orientation residuals vs psi
- fig3_workspace_trace.png: elbow/wrist/gripper 3D traces vs psi
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import robotic as ry


def solve_for_psi(
    C: ry.Config,
    psi: float,
    gripper: str,
    obj: str,
    seed_q: np.ndarray,
    damping: float,
    stop_evals: int,
) -> tuple[bool, np.ndarray, dict]:
    C.setJointState(seed_q)

    komo = ry.KOMO()
    komo.setTiming(1.0, 1, 1.0, 0)
    komo.setConfig(C, False)
    komo.addControlObjective([], 0, 1e-2)
    komo.addObjective([], ry.FS.jointLimits, [], ry.OT.ineq, [1e0])

    # Fixed translation in object frame: gripper center on cube center.
    komo.addObjective(
        [1.0],
        ry.FS.positionRel,
        [gripper, obj],
        ry.OT.eq,
        np.eye(3) * 1e2,
        np.array([0.0, 0.0, 0.0]),
    )

    # Fixed orientation pattern from current action_pick convention.
    komo.addObjective([1.0], ry.FS.vectorZDiff, [gripper, obj], ry.OT.eq, [1e2])
    komo.addObjective(
        [1.0],
        ry.FS.scalarProductXY,
        [gripper, obj],
        ry.OT.eq,
        [1e2],
        [1.0],
    )

    # Parameterize the manifold by q7 = psi.
    komo.addObjective(
        [1.0],
        ry.FS.qItself,
        ["l_panda_joint7"],
        ry.OT.eq,
        [1e3],
        [float(psi)],
    )

    solver = ry.NLP_Solver()
    solver.setProblem(komo.nlp())
    solver.setOptions(
        damping=float(damping),
        stopTolerance=1e-3,
        stopInners=20,
        stopEvals=int(stop_evals),
        verbose=0,
    )
    ret = solver.solve()

    if not ret.feasible:
        return False, seed_q.copy(), {}

    path = komo.getPath()
    q = np.asarray(path[-1], dtype=float)
    C.setJointState(q)

    f_obj = C.getFrame(obj)
    f_gr = C.getFrame(gripper)
    f_elbow = C.getFrame("l_panda_joint4")
    f_wrist = C.getFrame("l_panda_hand_joint")

    p_obj = np.asarray(f_obj.getPosition(), dtype=float)
    p_gr = np.asarray(f_gr.getPosition(), dtype=float)

    R_obj = np.asarray(f_obj.getRotationMatrix(), dtype=float)
    R_gr = np.asarray(f_gr.getRotationMatrix(), dtype=float)

    # Desired orientation implied by (z_gr=z_obj) and (x_gr dot y_obj = 1).
    R_des = np.column_stack((R_obj[:, 1], -R_obj[:, 0], R_obj[:, 2]))
    R_err = R_gr @ R_des.T
    c = np.clip((np.trace(R_err) - 1.0) * 0.5, -1.0, 1.0)
    angle_err_deg = float(np.degrees(np.arccos(c)))

    metrics = {
        "q": q.tolist(),
        "q7": float(q[6]),
        "pos_err_m": float(np.linalg.norm(p_gr - p_obj)),
        "ori_err_deg": angle_err_deg,
        "elbow": np.asarray(f_elbow.getPosition(), dtype=float).tolist(),
        "wrist": np.asarray(f_wrist.getPosition(), dtype=float).tolist(),
        "gripper": p_gr.tolist(),
        "obj": p_obj.tolist(),
    }
    return True, q, metrics


def plot_joint_manifold(psi: np.ndarray, q_mat: np.ndarray, out_path: Path) -> None:
    fig, ax = plt.subplots(figsize=(10, 5.5))
    for j in range(7):
        ax.plot(psi, q_mat[:, j], linewidth=1.8, label=f"q{j+1}")
    ax.set_xlabel("psi (requested q7) [rad]")
    ax.set_ylabel("joint angle [rad]")
    ax.set_title("Fixed 6D Grasp -> 1D Redundancy Manifold")
    ax.grid(True, alpha=0.3)
    ax.legend(ncol=4, fontsize=9)
    fig.tight_layout()
    fig.savefig(out_path, dpi=180)
    plt.close(fig)


def plot_residuals(psi: np.ndarray, pos_err_m: np.ndarray, ori_err_deg: np.ndarray, out_path: Path) -> None:
    fig, ax1 = plt.subplots(figsize=(10, 5.5))
    ax1.plot(psi, pos_err_m * 1e3, color="tab:blue", linewidth=1.8)
    ax1.set_xlabel("psi (requested q7) [rad]")
    ax1.set_ylabel("position residual [mm]", color="tab:blue")
    ax1.tick_params(axis="y", labelcolor="tab:blue")
    ax1.grid(True, alpha=0.3)

    ax2 = ax1.twinx()
    ax2.plot(psi, ori_err_deg, color="tab:red", linewidth=1.8)
    ax2.set_ylabel("orientation residual [deg]", color="tab:red")
    ax2.tick_params(axis="y", labelcolor="tab:red")

    ax1.set_title("Constraint Residuals Along 1D Manifold")
    fig.tight_layout()
    fig.savefig(out_path, dpi=180)
    plt.close(fig)


def plot_workspace_trace(
    elbow: np.ndarray,
    wrist: np.ndarray,
    gripper: np.ndarray,
    obj: np.ndarray,
    out_path: Path,
) -> None:
    fig = plt.figure(figsize=(8, 7))
    ax = fig.add_subplot(111, projection="3d")

    ax.plot(elbow[:, 0], elbow[:, 1], elbow[:, 2], linewidth=1.8, label="elbow (joint4)")
    ax.plot(wrist[:, 0], wrist[:, 1], wrist[:, 2], linewidth=1.8, label="wrist (hand_joint)")
    ax.plot(gripper[:, 0], gripper[:, 1], gripper[:, 2], linewidth=2.4, label="gripper")

    ax.scatter([obj[0]], [obj[1]], [obj[2]], s=60, marker="*", label="cube_1 center")

    ax.set_xlabel("X [m]")
    ax.set_ylabel("Y [m]")
    ax.set_zlabel("Z [m]")
    ax.set_title("Workspace Traces While Holding Fixed Grasp Pose")
    ax.legend(loc="upper left", fontsize=8)

    xyz = np.vstack([elbow, wrist, gripper, obj.reshape(1, 3)])
    mins = xyz.min(axis=0)
    maxs = xyz.max(axis=0)
    center = 0.5 * (mins + maxs)
    radius = 0.5 * np.max(maxs - mins) + 1e-3
    ax.set_xlim(center[0] - radius, center[0] + radius)
    ax.set_ylim(center[1] - radius, center[1] + radius)
    ax.set_zlim(center[2] - radius, center[2] + radius)

    fig.tight_layout()
    fig.savefig(out_path, dpi=180)
    plt.close(fig)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--scene", default="generated/scene/scene_named.g")
    parser.add_argument("--object", default="cube_1")
    parser.add_argument("--gripper", default="l_gripper")
    parser.add_argument("--psi-min", type=float, default=-2.7)
    parser.add_argument("--psi-max", type=float, default=2.7)
    parser.add_argument("--num", type=int, default=81)
    parser.add_argument("--damping", type=float, default=1e-1)
    parser.add_argument("--stop-evals", type=int, default=200)
    parser.add_argument(
        "--out-dir",
        default="generated/reachability_debug/cube1_fixed_pose",
    )
    args = parser.parse_args()

    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    C = ry.Config()
    C.addFile(args.scene)

    psi_grid = np.linspace(args.psi_min, args.psi_max, args.num)
    seed = np.asarray(C.getJointState(), dtype=float)

    q_solutions = []
    elbow_pts, wrist_pts, grip_pts = [], [], []
    pos_errs, ori_errs, feasible_psis = [], [], []

    for psi in psi_grid:
        ok, q_sol, m = solve_for_psi(
            C,
            float(psi),
            args.gripper,
            args.object,
            seed,
            args.damping,
            args.stop_evals,
        )
        if not ok:
            continue

        seed = q_sol.copy()
        feasible_psis.append(float(psi))
        q_solutions.append(m["q"])
        pos_errs.append(m["pos_err_m"])
        ori_errs.append(m["ori_err_deg"])
        elbow_pts.append(m["elbow"])
        wrist_pts.append(m["wrist"])
        grip_pts.append(m["gripper"])

    if not feasible_psis:
        raise RuntimeError("No feasible solution found on the psi grid. Try a narrower psi range.")

    feasible_psis = np.asarray(feasible_psis, dtype=float)
    q_mat = np.asarray(q_solutions, dtype=float)
    pos_errs = np.asarray(pos_errs, dtype=float)
    ori_errs = np.asarray(ori_errs, dtype=float)
    elbow_pts = np.asarray(elbow_pts, dtype=float)
    wrist_pts = np.asarray(wrist_pts, dtype=float)
    grip_pts = np.asarray(grip_pts, dtype=float)

    obj_p = np.asarray(C.getFrame(args.object).getPosition(), dtype=float)

    fig1 = out_dir / "fig1_joint_manifold.png"
    fig2 = out_dir / "fig2_residuals.png"
    fig3 = out_dir / "fig3_workspace_trace.png"

    plot_joint_manifold(feasible_psis, q_mat, fig1)
    plot_residuals(feasible_psis, pos_errs, ori_errs, fig2)
    plot_workspace_trace(elbow_pts, wrist_pts, grip_pts, obj_p, fig3)

    summary = {
        "scene": args.scene,
        "object": args.object,
        "gripper": args.gripper,
        "psi_scan": {
            "min": args.psi_min,
            "max": args.psi_max,
            "num": args.num,
            "feasible_count": int(feasible_psis.size),
            "feasible_min": float(feasible_psis.min()),
            "feasible_max": float(feasible_psis.max()),
        },
        "residual_stats": {
            "pos_err_mm_max": float((pos_errs * 1e3).max()),
            "pos_err_mm_mean": float((pos_errs * 1e3).mean()),
            "ori_err_deg_max": float(ori_errs.max()),
            "ori_err_deg_mean": float(ori_errs.mean()),
        },
        "outputs": {
            "joint_manifold": str(fig1),
            "residuals": str(fig2),
            "workspace_trace": str(fig3),
        },
    }
    (out_dir / "summary.json").write_text(json.dumps(summary, indent=2), encoding="utf-8")

    print(json.dumps(summary, indent=2))


if __name__ == "__main__":
    main()
