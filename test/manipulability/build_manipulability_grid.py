import argparse
import json
import time
from pathlib import Path

import numpy as np

from urdf_static_manipulability import (
    fk_and_jacobian_position,
    load_urdf_chain,
    parse_initial_q_from_g,
    parse_scene_positions,
    solve_ik_position_dls,
    yoshikawa_position_score,
)


def _normalize_scores(raw: np.ndarray) -> np.ndarray:
    out = np.full_like(raw, np.nan, dtype=float)
    valid = np.isfinite(raw)
    if not np.any(valid):
        return out
    vmin = np.nanmin(raw)
    vmax = np.nanmax(raw)
    denom = max(vmax - vmin, 1e-12)
    out[valid] = (raw[valid] - vmin) / denom
    return out


def main():
    root = Path(__file__).resolve().parents[2]

    parser = argparse.ArgumentParser(description="Build 3D manipulability grid (URDF-only)")
    parser.add_argument("--g-file", default=str(root / "unnamed.g"))
    parser.add_argument(
        "--urdf",
        default=str(root / "rai" / "test" / "newLGP" / "rai-robotModels" / "panda" / "panda_arm_hand.urdf"),
    )
    parser.add_argument("--base-link", default="panda_link0")
    parser.add_argument("--ee-link", default="panda_hand")

    parser.add_argument("--x-min", type=float, default=-0.55)
    parser.add_argument("--x-max", type=float, default=0.55)
    parser.add_argument("--y-min", type=float, default=-0.35)
    parser.add_argument("--y-max", type=float, default=0.55)
    parser.add_argument("--z-min", type=float, default=0.60)
    parser.add_argument("--z-max", type=float, default=1.05)

    parser.add_argument("--nx", type=int, default=24)
    parser.add_argument("--ny", type=int, default=20)
    parser.add_argument("--nz", type=int, default=14)

    parser.add_argument("--ik-max-iter", type=int, default=120)
    parser.add_argument("--ik-tol", type=float, default=1e-4)
    parser.add_argument("--ik-damping", type=float, default=1e-2)
    parser.add_argument("--ik-step-scale", type=float, default=0.8)

    parser.add_argument("--out-raw", default=str(root / "generated" / "manipulability_grid_raw.npz"))
    parser.add_argument("--out-norm", default=str(root / "generated" / "manipulability_grid_norm.npz"))
    parser.add_argument("--out-meta", default=str(root / "generated" / "manipulability_grid_meta.json"))
    args = parser.parse_args()

    t0 = time.time()
    chain = load_urdf_chain(args.urdf, base_link=args.base_link, ee_link=args.ee_link)
    base_T_world, _ = parse_scene_positions(args.g_file)
    q0 = parse_initial_q_from_g(args.g_file, chain.active_joint_names)

    xs = np.linspace(args.x_min, args.x_max, args.nx)
    ys = np.linspace(args.y_min, args.y_max, args.ny)
    zs = np.linspace(args.z_min, args.z_max, args.nz)
    X, Y, Z = np.meshgrid(xs, ys, zs, indexing="ij")

    shape = X.shape
    score_raw = np.full(shape, np.nan, dtype=float)
    ik_success = np.zeros(shape, dtype=bool)
    ik_error = np.full(shape, np.nan, dtype=float)

    total = args.nx * args.ny * args.nz
    done = 0

    for ix in range(args.nx):
        for iy in range(args.ny):
            for iz in range(args.nz):
                target = np.array([xs[ix], ys[iy], zs[iz]], dtype=float)
                ok, q_sol, err = solve_ik_position_dls(
                    chain,
                    target,
                    q0=q0,
                    base_T_world=base_T_world,
                    max_iter=args.ik_max_iter,
                    tol=args.ik_tol,
                    damping=args.ik_damping,
                    step_scale=args.ik_step_scale,
                )
                ik_error[ix, iy, iz] = err
                if ok:
                    _, Jp = fk_and_jacobian_position(chain, q_sol, base_T_world=base_T_world)
                    score, reason = yoshikawa_position_score(Jp)
                    if score is not None and reason == "ok":
                        score_raw[ix, iy, iz] = score
                        ik_success[ix, iy, iz] = True
                done += 1
        print(f"[GRID] progress: {done}/{total} ({100.0 * done / total:.1f}%)")

    score_norm = _normalize_scores(score_raw)

    out_raw = Path(args.out_raw)
    out_norm = Path(args.out_norm)
    out_meta = Path(args.out_meta)
    out_raw.parent.mkdir(parents=True, exist_ok=True)

    np.savez_compressed(
        out_raw,
        X=X,
        Y=Y,
        Z=Z,
        score_raw=score_raw,
        ik_success_mask=ik_success,
        ik_error=ik_error,
    )
    np.savez_compressed(
        out_norm,
        X=X,
        Y=Y,
        Z=Z,
        score_norm=score_norm,
        ik_success_mask=ik_success,
        ik_error=ik_error,
    )

    meta = {
        "grid": {
            "nx": args.nx,
            "ny": args.ny,
            "nz": args.nz,
            "x": [args.x_min, args.x_max],
            "y": [args.y_min, args.y_max],
            "z": [args.z_min, args.z_max],
        },
        "ik": {
            "max_iter": args.ik_max_iter,
            "tol": args.ik_tol,
            "damping": args.ik_damping,
            "step_scale": args.ik_step_scale,
        },
        "counts": {
            "total": int(total),
            "ik_success": int(np.count_nonzero(ik_success)),
            "valid_score": int(np.count_nonzero(np.isfinite(score_raw))),
        },
        "timing_sec": round(time.time() - t0, 3),
        "outputs": {
            "raw": str(out_raw),
            "norm": str(out_norm),
        },
    }
    out_meta.write_text(json.dumps(meta, indent=2), encoding="utf-8")

    print("[GRID] done")
    print(f"[GRID] raw:  {out_raw}")
    print(f"[GRID] norm: {out_norm}")
    print(f"[GRID] meta: {out_meta}")
    print(f"[GRID] timing: {meta['timing_sec']} sec")


if __name__ == "__main__":
    main()
