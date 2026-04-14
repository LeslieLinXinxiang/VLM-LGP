import math
import os
from typing import Dict, List, Tuple

ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
ASSET_DIR = os.path.join(ROOT_DIR, "assets", "fmb", "new_fmb")


def _read_vertices(obj_path: str) -> List[Tuple[float, float, float]]:
    vertices: List[Tuple[float, float, float]] = []
    with open(obj_path, "r", encoding="utf-8") as f:
        for line in f:
            if not line.startswith("v "):
                continue
            parts = line.split()
            if len(parts) < 4:
                continue
            vertices.append((float(parts[1]), float(parts[2]), float(parts[3])))
    return vertices


def _read_mtl_and_usemtl(obj_path: str) -> Tuple[str, bool]:
    mtllib = ""
    has_usemtl = False
    with open(obj_path, "r", encoding="utf-8") as f:
        for line in f:
            if line.startswith("mtllib ") and not mtllib:
                mtllib = line.split(maxsplit=1)[1].strip()
            elif line.startswith("usemtl "):
                has_usemtl = True
    return mtllib, has_usemtl


def _bbox_center(vertices: List[Tuple[float, float, float]]) -> Tuple[float, float, float]:
    xs = [v[0] for v in vertices]
    ys = [v[1] for v in vertices]
    zs = [v[2] for v in vertices]
    return ((min(xs) + max(xs)) / 2.0, (min(ys) + max(ys)) / 2.0, (min(zs) + max(zs)) / 2.0)


def _mean_center(vertices: List[Tuple[float, float, float]]) -> Tuple[float, float, float]:
    n = float(len(vertices))
    sx = sum(v[0] for v in vertices)
    sy = sum(v[1] for v in vertices)
    sz = sum(v[2] for v in vertices)
    return (sx / n, sy / n, sz / n)


def _norm3(v: Tuple[float, float, float]) -> float:
    return math.sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2])


def audit_assets() -> None:
    if not os.path.isdir(ASSET_DIR):
        raise FileNotFoundError(f"Asset directory not found: {ASSET_DIR}")

    obj_files = sorted(f for f in os.listdir(ASSET_DIR) if f.endswith(".obj"))
    print(f"[INFO] auditing {len(obj_files)} OBJ files in {ASSET_DIR}")
    print(
        "name,mtl_ref,mtl_exists,usemtl,bbox_center,mean_center,bbox_offset_norm,mean_offset_norm"
    )

    for name in obj_files:
        obj_path = os.path.join(ASSET_DIR, name)
        mtllib, has_usemtl = _read_mtl_and_usemtl(obj_path)
        mtl_exists = bool(mtllib) and os.path.exists(os.path.join(ASSET_DIR, mtllib))

        vertices = _read_vertices(obj_path)
        if not vertices:
            print(f"{name},{mtllib},{mtl_exists},{has_usemtl},NO_VERTICES")
            continue

        bc = _bbox_center(vertices)
        mc = _mean_center(vertices)

        print(
            f"{name},{mtllib},{mtl_exists},{has_usemtl},"
            f"({bc[0]:.6f} {bc[1]:.6f} {bc[2]:.6f}),"
            f"({mc[0]:.6f} {mc[1]:.6f} {mc[2]:.6f}),"
            f"{_norm3(bc):.6f},{_norm3(mc):.6f}"
        )


if __name__ == "__main__":
    audit_assets()
