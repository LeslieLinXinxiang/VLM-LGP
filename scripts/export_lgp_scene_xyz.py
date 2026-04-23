#!/usr/bin/env python3
import argparse
import csv
import json
import re
from pathlib import Path


POSE_RE = re.compile(r"\bpose\s*:\s*\[([^\]]+)\]")
Q_T_RE = re.compile(r"\bQ\s*:\s*\"[^\"]*?t\(([^)]+)\)")
FRAME_RE = re.compile(r"^\s*([A-Za-z0-9_]+)\s*\([^)]*\)\s*(?::)?\s*\{(.*)$")


def _parse_xyz_from_token(token: str):
    vals = [float(x) for x in token.replace(",", " ").split()]
    if len(vals) < 3:
        raise ValueError(f"cannot parse xyz from token: {token}")
    return vals[0], vals[1], vals[2]


def _extract_xyz_from_attrs(attrs: str):
    m_pose = POSE_RE.search(attrs)
    if m_pose:
        return _parse_xyz_from_token(m_pose.group(1))

    m_q = Q_T_RE.search(attrs)
    if m_q:
        return _parse_xyz_from_token(m_q.group(1))

    return None


def parse_g_scene(g_path: Path, only_is_object: bool):
    rows = []
    for i, line in enumerate(g_path.read_text(encoding="utf-8", errors="ignore").splitlines(), start=1):
        m = FRAME_RE.match(line)
        if not m:
            continue

        name = m.group(1)
        attrs = m.group(2)

        if only_is_object and "is_object" not in attrs:
            continue

        xyz = _extract_xyz_from_attrs(attrs)
        if xyz is None:
            continue

        rows.append(
            {
                "name": name,
                "x": float(xyz[0]),
                "y": float(xyz[1]),
                "z": float(xyz[2]),
                "line": i,
            }
        )
    return rows


def _default_g_path(repo_root: Path):
    cands = [
        repo_root / "generated" / "node_1_run" / "output_state.g",
        repo_root / "generated" / "scene" / "scene_named.g",
        repo_root / "generated" / "scene_named.g",
    ]
    for p in cands:
        if p.exists():
            return p
    return cands[0]


def main():
    repo_root = Path(__file__).resolve().parents[1]

    ap = argparse.ArgumentParser(description="Export object xyz from LGP .g scene files (output_state.g / scene_named.g).")
    ap.add_argument("--g-file", default="", help="Path to .g file. If omitted, auto-select from generated paths.")
    ap.add_argument("--all-frames", action="store_true", help="Export all frames with xyz (default: only logical is_object)")
    ap.add_argument("--json-out", default="", help="Optional output JSON path")
    ap.add_argument("--csv-out", default="", help="Optional output CSV path")
    args = ap.parse_args()

    g_path = Path(args.g_file) if args.g_file else _default_g_path(repo_root)
    if not g_path.exists():
        raise FileNotFoundError(f".g file not found: {g_path}")

    only_is_object = not args.all_frames
    rows = parse_g_scene(g_path, only_is_object=only_is_object)

    print("=== LGP Scene XYZ Export ===")
    print(f"source: {g_path}")
    print(f"filter: {'is_object only' if only_is_object else 'all frames'}")
    print(f"count:  {len(rows)}")

    if rows:
        print("\nname                 x          y          z")
        print("------------------------------------------------")
        for r in rows:
            print(f"{r['name'][:20]:20s} {r['x']:>+9.4f} {r['y']:>+9.4f} {r['z']:>+9.4f}")

    if args.json_out:
        out = Path(args.json_out)
        out.write_text(json.dumps({"source": str(g_path), "rows": rows}, indent=2), encoding="utf-8")
        print(f"\njson saved: {out}")

    if args.csv_out:
        out = Path(args.csv_out)
        with out.open("w", newline="", encoding="utf-8") as f:
            w = csv.DictWriter(f, fieldnames=["name", "x", "y", "z", "line"])
            w.writeheader()
            w.writerows(rows)
        print(f"csv saved:  {out}")


if __name__ == "__main__":
    main()
