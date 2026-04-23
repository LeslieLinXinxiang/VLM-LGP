#!/usr/bin/env python3
import argparse
import math
import re
from pathlib import Path


BLOCK_RE = re.compile(
    r">>> V-LGP TRAJECTORY START <<<\n"
    r"DIM: (\d+) (\d+)\n"
    r"([\s\S]*?)\n"
    r">>> V-LGP TRAJECTORY END <<<"
)


def _phase_id(t_raw: float) -> int:
    pid = int(math.floor(t_raw - 1e-4))
    return pid if pid >= 0 else 0


def _strictify_phase_times(times, eps):
    if not times:
        return []

    start = times[0]
    out = [start]
    for i in range(1, len(times)):
        nxt = times[i]
        if nxt <= out[-1]:
            nxt = out[-1] + eps
        out.append(nxt)

    # Preserve original phase duration when the source had positive span.
    src_span = times[-1] - times[0]
    dst_span = out[-1] - out[0]
    if src_span > 0.0 and dst_span > 0.0:
        scale = src_span / dst_span
        out = [out[0] + (x - out[0]) * scale for x in out]
    return out


def clean_trajectory_text(text: str, eps: float = 1e-3):
    cleaned_blocks = 0
    fixed_points = 0

    def repl(match):
        nonlocal cleaned_blocks, fixed_points
        dim_rows = int(match.group(1))
        dim_cols = int(match.group(2))
        raw_lines = [ln for ln in match.group(3).splitlines() if ln.strip()]

        rows = []
        for line in raw_lines:
            parts = line.split()
            vals = [float(x) for x in parts]
            if len(vals) < 2:
                continue
            rows.append(vals)

        if not rows:
            return match.group(0)

        phases = {}
        phase_order = []
        for idx, vals in enumerate(rows):
            t = vals[0]
            pid = _phase_id(t)
            if pid not in phases:
                phases[pid] = []
                phase_order.append(pid)
            phases[pid].append((idx, t - pid))

        updates = {}
        for pid in phase_order:
            idx_and_t = phases[pid]
            idxs = [it[0] for it in idx_and_t]
            norm_t = [it[1] for it in idx_and_t]
            fixed = _strictify_phase_times(norm_t, eps)
            for i, idx in enumerate(idxs):
                old = rows[idx][0]
                new = pid + fixed[i]
                if new != old:
                    fixed_points += 1
                updates[idx] = new

        out_lines = []
        for i, vals in enumerate(rows):
            vals[0] = updates[i]
            # Keep full numeric precision to avoid reintroducing duplicate timestamps.
            out_lines.append(" ".join(f"{v:.6f}" for v in vals))

        cleaned_blocks += 1
        return (
            ">>> V-LGP TRAJECTORY START <<<\n"
            f"DIM: {dim_rows} {dim_cols}\n"
            + "\n".join(out_lines)
            + "\n>>> V-LGP TRAJECTORY END <<<"
        )

    new_text = BLOCK_RE.sub(repl, text)
    return new_text, cleaned_blocks, fixed_points


def main():
    parser = argparse.ArgumentParser(description="Clean V-LGP trajectory timestamps in log files.")
    parser.add_argument("input", help="Input raw trajectory log path")
    parser.add_argument("-o", "--output", help="Output path (default: <input>.clean.log)")
    parser.add_argument("--in-place", action="store_true", help="Overwrite input file")
    parser.add_argument("--eps", type=float, default=1e-3, help="Minimum dt when fixing duplicates")
    args = parser.parse_args()

    in_path = Path(args.input)
    if not in_path.exists():
        raise FileNotFoundError(f"Input file not found: {in_path}")

    text = in_path.read_text(encoding="utf-8", errors="ignore")
    new_text, cleaned_blocks, fixed_points = clean_trajectory_text(text, eps=args.eps)

    if args.in_place:
        out_path = in_path
    elif args.output:
        out_path = Path(args.output)
    else:
        out_path = in_path.with_suffix(in_path.suffix + ".clean")

    out_path.write_text(new_text, encoding="utf-8")

    print(f"[clean_trajectory_log] input:  {in_path}")
    print(f"[clean_trajectory_log] output: {out_path}")
    print(f"[clean_trajectory_log] blocks cleaned: {cleaned_blocks}")
    print(f"[clean_trajectory_log] timestamp fixes: {fixed_points}")


if __name__ == "__main__":
    main()
