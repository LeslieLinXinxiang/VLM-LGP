import argparse
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

from urdf_static_manipulability import parse_scene_positions


def _slice_xy(X, Y, Z, S, iz):
    return X[:, :, iz], Y[:, :, iz], S[:, :, iz], float(np.nanmean(Z[:, :, iz]))


def _slice_xz(X, Y, Z, S, iy):
    return X[:, iy, :], Z[:, iy, :], S[:, iy, :], float(np.nanmean(Y[:, iy, :]))


def _slice_yz(X, Y, Z, S, ix):
    return Y[ix, :, :], Z[ix, :, :], S[ix, :, :], float(np.nanmean(X[ix, :, :]))


def _plot_slice(A, B, V, xlabel, ylabel, title, out_path, cmap, gamma, base_xy):
    V_vis = np.array(V, copy=True)
    valid = np.isfinite(V_vis)
    if gamma > 0 and abs(gamma - 1.0) > 1e-6:
        V_vis[valid] = np.power(np.clip(V_vis[valid], 0.0, 1.0), gamma)

    # 不可达区域（NaN）按“最低可抓取性”映射为 0.0，显示为深蓝而非白色留空。
    V_plot = np.nan_to_num(V_vis, nan=0.0, posinf=0.0, neginf=0.0)
    cmap_obj = plt.get_cmap(cmap).copy()
    cmap_obj.set_bad("#001a66")

    fig, ax = plt.subplots(figsize=(6.6, 5.2), dpi=240)
    im = ax.pcolormesh(A, B, V_plot, shading="gouraud", cmap=cmap_obj, vmin=0.0, vmax=1.0)
    cs = ax.contour(A, B, V_plot, levels=[0.2, 0.4, 0.6, 0.8], colors="black", linewidths=0.55)
    ax.clabel(cs, inline=True, fontsize=8, fmt="%.1f")

    if base_xy is not None:
        bx, by = base_xy
        ax.scatter([bx], [by], c="black", marker="*", s=110, label="robot base origin")
        ax.legend(loc="upper right", fontsize=8)

    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.set_title(title)
    cbar = fig.colorbar(im, ax=ax, fraction=0.046, pad=0.04)
    cbar.set_label("Normalized manipulability (blue low -> red high)")
    fig.tight_layout()
    fig.savefig(out_path, bbox_inches="tight")
    plt.close(fig)


def main():
    root = Path(__file__).resolve().parents[2]

    parser = argparse.ArgumentParser(description="Render manipulability heatmap slices")
    parser.add_argument("--npz", default=str(root / "generated" / "manipulability_grid_norm.npz"))
    parser.add_argument("--g-file", default=str(root / "unnamed.g"))
    parser.add_argument("--cmap", default="RdYlBu_r", help="Recommended: RdYlBu_r / coolwarm")
    parser.add_argument("--gamma", type=float, default=1.3, help="Contrast shaping (>1.0 emphasizes high-score regions)")
    parser.add_argument("--out-dir", default=str(root / "generated" / "figures"))
    args = parser.parse_args()

    data = np.load(args.npz)
    X = data["X"]
    Y = data["Y"]
    Z = data["Z"]
    S = data["score_norm"]
    base_T_world, _ = parse_scene_positions(args.g_file)
    bx, by, bz = base_T_world[:3, 3].tolist()

    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    iz = Z.shape[2] // 2
    iy = Y.shape[1] // 2
    ix = X.shape[0] // 2

    A, B, V, z0 = _slice_xy(X, Y, Z, S, iz)
    _plot_slice(
        A,
        B,
        V,
        "x (m)",
        "y (m)",
        f"XY slice @ z={z0:.3f} m",
        out_dir / "manip_slice_xy.png",
        cmap=args.cmap,
        gamma=args.gamma,
        base_xy=(bx, by),
    )

    A, B, V, y0 = _slice_xz(X, Y, Z, S, iy)
    _plot_slice(
        A,
        B,
        V,
        "x (m)",
        "z (m)",
        f"XZ slice @ y={y0:.3f} m",
        out_dir / "manip_slice_xz.png",
        cmap=args.cmap,
        gamma=args.gamma,
        base_xy=(bx, bz),
    )

    A, B, V, x0 = _slice_yz(X, Y, Z, S, ix)
    _plot_slice(
        A,
        B,
        V,
        "y (m)",
        "z (m)",
        f"YZ slice @ x={x0:.3f} m",
        out_dir / "manip_slice_yz.png",
        cmap=args.cmap,
        gamma=args.gamma,
        base_xy=(by, bz),
    )

    print("[SLICE] done")
    print(f"[SLICE] out dir: {out_dir}")


if __name__ == "__main__":
    main()
