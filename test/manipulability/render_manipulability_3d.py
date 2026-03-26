import argparse
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

from urdf_static_manipulability import parse_scene_positions


def _scatter_plot(ax, X, Y, Z, score, title, cmap, base_origin=None):
    valid = np.isfinite(score)
    xv = X[valid]
    yv = Y[valid]
    zv = Z[valid]
    sv = score[valid]
    p = ax.scatter(xv, yv, zv, c=sv, s=9, marker="o", cmap=cmap, alpha=0.92, linewidths=0)

    if base_origin is not None:
        bx, by, bz = base_origin
        ax.scatter([bx], [by], [bz], c="black", s=120, marker="*", label="robot base origin")
        ax.text(bx, by, bz, "  base", color="black", fontsize=9)

    ax.set_title(title)
    ax.set_xlabel("x (m)")
    ax.set_ylabel("y (m)")
    ax.set_zlabel("z (m)")
    ax.set_box_aspect((float(np.ptp(X)), float(np.ptp(Y)), float(np.ptp(Z))))
    ax.view_init(elev=25, azim=35)
    if base_origin is not None:
        ax.legend(loc="upper left", fontsize=8)
    return p


def _voxel_plot(ax, X, Y, Z, score, threshold, title, cmap, base_origin=None):
    valid = np.isfinite(score)
    occ = valid & (score >= threshold)

    if not np.any(occ):
        ax.set_title(f"{title} (empty)")
        return None

    # 使用“体素样式”散点（方块 marker）直接在世界坐标渲染。
    # 原 `ax.voxels(occ)` 默认索引坐标，不直观对应米制空间。
    xv = X[occ]
    yv = Y[occ]
    zv = Z[occ]
    sv = score[occ]
    p = ax.scatter(xv, yv, zv, c=sv, cmap=cmap, s=22, marker="s", alpha=0.9, linewidths=0)

    if base_origin is not None:
        bx, by, bz = base_origin
        ax.scatter([bx], [by], [bz], c="black", s=120, marker="*", label="robot base origin")
        ax.text(bx, by, bz, "  base", color="black", fontsize=9)

    ax.set_title(f"{title} (t={threshold:.2f})")
    ax.set_xlabel("x (m)")
    ax.set_ylabel("y (m)")
    ax.set_zlabel("z (m)")
    ax.set_box_aspect((float(np.ptp(X)), float(np.ptp(Y)), float(np.ptp(Z))))
    ax.view_init(elev=25, azim=35)
    if base_origin is not None:
        ax.legend(loc="upper left", fontsize=8)
    return p


def main():
    root = Path(__file__).resolve().parents[2]

    parser = argparse.ArgumentParser(description="Render 3D manipulability point-cloud and voxel views")
    parser.add_argument("--npz", default=str(root / "generated" / "manipulability_grid_norm.npz"))
    parser.add_argument("--g-file", default=str(root / "unnamed.g"))
    parser.add_argument("--voxel-threshold", type=float, default=0.15)
    parser.add_argument("--cmap", default="RdYlBu_r", help="Colormap (recommended: RdYlBu_r, coolwarm)")
    parser.add_argument("--out-pointcloud", default=str(root / "generated" / "figures" / "manip_3d_pointcloud.png"))
    parser.add_argument("--out-voxel", default=str(root / "generated" / "figures" / "manip_3d_voxel.png"))
    args = parser.parse_args()

    data = np.load(args.npz)
    X = data["X"]
    Y = data["Y"]
    Z = data["Z"]
    score = data["score_norm"]
    base_T_world, _ = parse_scene_positions(args.g_file)
    base_origin = base_T_world[:3, 3].tolist()

    out_pc = Path(args.out_pointcloud)
    out_vox = Path(args.out_voxel)
    out_pc.parent.mkdir(parents=True, exist_ok=True)

    fig = plt.figure(figsize=(8, 7), dpi=220)
    ax = fig.add_subplot(111, projection="3d")
    p = _scatter_plot(
        ax,
        X,
        Y,
        Z,
        score,
        "3D Manipulability Point Cloud",
        cmap=args.cmap,
        base_origin=base_origin,
    )
    cbar = fig.colorbar(p, ax=ax, shrink=0.7, pad=0.08)
    cbar.set_label("Normalized manipulability (blue low -> red high)")
    plt.tight_layout()
    fig.savefig(out_pc, bbox_inches="tight")
    plt.close(fig)

    fig2 = plt.figure(figsize=(8, 7), dpi=220)
    ax2 = fig2.add_subplot(111, projection="3d")
    p2 = _voxel_plot(
        ax2,
        X,
        Y,
        Z,
        score,
        args.voxel_threshold,
        "3D Manipulability Voxels",
        cmap=args.cmap,
        base_origin=base_origin,
    )
    if p2 is not None:
        cbar2 = fig2.colorbar(p2, ax=ax2, shrink=0.7, pad=0.08)
        cbar2.set_label("Normalized manipulability (blue low -> red high)")
    plt.tight_layout()
    fig2.savefig(out_vox, bbox_inches="tight")
    plt.close(fig2)

    print("[RENDER3D] done")
    print(f"[RENDER3D] pointcloud: {out_pc}")
    print(f"[RENDER3D] voxel:      {out_vox}")


if __name__ == "__main__":
    main()
