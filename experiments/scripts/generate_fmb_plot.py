#!/usr/bin/env python3
"""Generate a compact FMB comparison figure in the same style as the reference image.

The figure compares:
- Smart vs Global
- NR vs R
- 3objs / 4objs / 5objs

Statistics exclude scenario-policy-mode groups whose success rate is 0%.
Time statistics are computed on successful trials only.
"""
from __future__ import annotations

import json
from collections import defaultdict
from dataclasses import dataclass
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

ROOT = Path("/home/leslie/Projects/VLM_LGP")
LGP_ROOT = ROOT / "experiments/evaluations/LGP/FMB"
OUT_DIR = ROOT / "experiments/outputs/fmb_plots"
OUT_DIR.mkdir(parents=True, exist_ok=True)

MAGS = ["3objs", "4objs", "5objs"]
POLICIES = ["lgp_split_smart", "lgp_split_global"]
MODES = ["nr", "r"]

LABELS = {
    ("lgp_split_smart", "nr"): ("Smart-NR", "#2ecc71"),
    ("lgp_split_smart", "r"): ("Smart-R", "#27ae60"),
    ("lgp_split_global", "nr"): ("Global-NR", "#e74c3c"),
    ("lgp_split_global", "r"): ("Global-R", "#c0392b"),
}


@dataclass
class ScenarioGroup:
    success: int = 0
    total: int = 0
    runtimes: list[float] = None

    def __post_init__(self):
        if self.runtimes is None:
            self.runtimes = []


def _parse_trial_path(meta_path: Path) -> tuple[str, str, str] | None:
    # .../FMB/<mag>/<scenario>/trial_XX_<mode>/<policy>/trial_meta.json
    try:
        policy = meta_path.parent.name
        trial_dir = meta_path.parent.parent.name
        scenario = meta_path.parent.parent.parent.name
        mag = meta_path.parent.parent.parent.parent.name
        return mag, scenario, trial_dir, policy
    except Exception:
        return None


def _scenario_trial_mode(trial_dir: str) -> str | None:
    if trial_dir.endswith("_nr"):
        return "nr"
    if trial_dir.endswith("_r"):
        return "r"
    return None


def collect_records():
    records = []
    for mag in MAGS:
        mag_dir = LGP_ROOT / mag
        if not mag_dir.exists():
            continue
        for meta_path in mag_dir.glob("*/trial_*/*/trial_meta.json"):
            parsed = _parse_trial_path(meta_path)
            if not parsed:
                continue
            mag_name, scenario, trial_dir, policy = parsed
            mode = _scenario_trial_mode(trial_dir)
            if mag_name not in MAGS or policy not in POLICIES or mode not in MODES:
                continue
            try:
                meta = json.loads(meta_path.read_text())
            except Exception:
                continue
            records.append(
                {
                    "mag": mag_name,
                    "scenario": scenario,
                    "trial_mode": mode,
                    "policy": policy,
                    "success": bool(meta.get("success", False)),
                    "runtime_s": float(meta.get("runtime_s", 0.0)),
                }
            )
    return records


def aggregate(records):
    # First compute per-scenario success rate for each mag/policy/mode.
    scenario_stats = defaultdict(lambda: defaultdict(lambda: ScenarioGroup()))
    for r in records:
        key = (r["scenario"], r["policy"], r["trial_mode"])
        g = scenario_stats[r["mag"]][key]
        g.total += 1
        if r["success"]:
            g.success += 1
            g.runtimes.append(r["runtime_s"])

    # Then aggregate only scenarios whose success rate is > 0.
    agg = defaultdict(lambda: defaultdict(lambda: {"success": 0, "total": 0, "times": [], "excluded_scenarios": 0}))
    for mag in MAGS:
        for (scenario, policy, mode), g in scenario_stats.get(mag, {}).items():
            if g.total == 0:
                continue
            if g.success == 0:
                agg[mag][(policy, mode)]["excluded_scenarios"] += 1
                continue
            agg[mag][(policy, mode)]["success"] += g.success
            agg[mag][(policy, mode)]["total"] += g.total
            agg[mag][(policy, mode)]["times"].extend(g.runtimes)
    return agg, scenario_stats


def main():
    records = collect_records()
    if not records:
        raise SystemExit("No trial_meta.json records found under experiments/evaluations/LGP/FMB")

    agg, scenario_stats = aggregate(records)

    # Pretty console summary.
    print("=" * 100)
    print("FMB Figure Data Summary (0% scenario groups excluded)")
    print("=" * 100)
    for mag in MAGS:
        print(f"\n[{mag}]")
        for policy in POLICIES:
            for mode in MODES:
                d = agg[mag][(policy, mode)]
                rate = 100.0 * d["success"] / d["total"] if d["total"] else 0.0
                mean_t = float(np.mean(d["times"])) if d["times"] else 0.0
                excluded = d["excluded_scenarios"]
                label, _ = LABELS[(policy, mode)]
                print(
                    f"  {label:10s} | success {d['success']:3d}/{d['total']:3d} "
                    f"({rate:6.2f}%) | mean time {mean_t:6.2f}s | excluded scenarios={excluded}"
                )

    plt.style.use("seaborn-v0_8-muted")
    fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(12, 12), constrained_layout=True)

    x = np.arange(len(MAGS))
    width = 0.20

    # Success rate plot.
    for idx, (policy, mode) in enumerate(
        [
            ("lgp_split_smart", "nr"),
            ("lgp_split_smart", "r"),
            ("lgp_split_global", "nr"),
            ("lgp_split_global", "r"),
        ]
    ):
        label, color = LABELS[(policy, mode)]
        rates = []
        for mag in MAGS:
            d = agg[mag][(policy, mode)]
            rate = 100.0 * d["success"] / d["total"] if d["total"] else 0.0
            rates.append(rate)
        ax1.bar(x + (idx - 1.5) * width, rates, width, label=label, color=color)

    ax1.set_ylabel("Success Rate (%)")
    ax1.set_title("FMB Success Rate Comparison")
    ax1.set_xticks(x)
    ax1.set_xticklabels(MAGS)
    ax1.set_ylim(0, 105)
    ax1.legend(ncol=2)
    ax1.grid(axis="y", alpha=0.25)
    ax1.text(
        0.01,
        -0.20,
        "Note: scenario groups with 0% success are excluded from statistics.",
        transform=ax1.transAxes,
        fontsize=9,
        color="#444444",
    )

    # Solving time plot.
    for idx, (policy, mode) in enumerate(
        [
            ("lgp_split_smart", "nr"),
            ("lgp_split_smart", "r"),
            ("lgp_split_global", "nr"),
            ("lgp_split_global", "r"),
        ]
    ):
        label, color = LABELS[(policy, mode)]
        times = []
        for mag in MAGS:
            d = agg[mag][(policy, mode)]
            times.append(float(np.mean(d["times"])) if d["times"] else 0.0)
        ax2.bar(x + (idx - 1.5) * width, times, width, label=label, color=color)

    ax2.set_ylabel("Avg Solving Time (s)")
    ax2.set_title("FMB Solving Time Comparison (Successful Only)")
    ax2.set_xticks(x)
    ax2.set_xticklabels(MAGS)
    ax2.legend(ncol=2)
    ax2.grid(axis="y", alpha=0.25)

    out_png = OUT_DIR / "fmb_success_time_comparison.png"
    out_svg = OUT_DIR / "fmb_success_time_comparison.svg"
    fig.savefig(out_png, dpi=220, bbox_inches="tight")
    fig.savefig(out_svg, bbox_inches="tight")
    print(f"\nSaved: {out_png}")
    print(f"Saved: {out_svg}")


if __name__ == "__main__":
    main()
