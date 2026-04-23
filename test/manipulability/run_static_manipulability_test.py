import argparse
import json
from pathlib import Path

from urdf_static_manipulability import compute_static_manipulability_report, derive_feasible, load_infeasible, load_phase0_layout


def _default_paths(repo_root: Path):
    return {
        "layout": repo_root / "generated" / "phase0_layout.json",
        "infeasible": repo_root / "generated" / "infeasible_objects.json",
        "g": repo_root / "unnamed.g",
        "urdf": repo_root / "rai" / "test" / "newLGP" / "rai-robotModels" / "panda" / "panda_arm_hand.urdf",
        "out_report": repo_root / "generated" / "ordering_score_report_static_test.json",
        "out_feasible": repo_root / "generated" / "feasible_objects_static_test.json",
    }


def main():
    repo_root = Path(__file__).resolve().parents[2]
    defaults = _default_paths(repo_root)

    parser = argparse.ArgumentParser(description="Static manipulability test (URDF-only, no RAI)")
    parser.add_argument("--layout", default=str(defaults["layout"]))
    parser.add_argument("--infeasible", default=str(defaults["infeasible"]))
    parser.add_argument("--g-file", default=str(defaults["g"]))
    parser.add_argument("--urdf", default=str(defaults["urdf"]))
    parser.add_argument("--tau-m", type=float, default=0.08)
    parser.add_argument("--approach-offset-z", type=float, default=0.08)
    parser.add_argument("--base-link", default="panda_link0")
    parser.add_argument("--ee-link", default="panda_hand")
    parser.add_argument("--out-report", default=str(defaults["out_report"]))
    parser.add_argument("--out-feasible", default=str(defaults["out_feasible"]))
    args = parser.parse_args()

    layout = load_phase0_layout(args.layout)
    infeasible = load_infeasible(args.infeasible)
    feasible = derive_feasible(layout, infeasible)

    out_feasible = Path(args.out_feasible)
    out_feasible.parent.mkdir(parents=True, exist_ok=True)
    out_feasible.write_text(json.dumps(feasible, indent=2), encoding="utf-8")

    report = compute_static_manipulability_report(
        layout_path=args.layout,
        infeasible_path=args.infeasible,
        g_path=args.g_file,
        urdf_path=args.urdf,
        tau_m=args.tau_m,
        approach_offset_z=args.approach_offset_z,
        base_link=args.base_link,
        ee_link=args.ee_link,
    )

    out_report = Path(args.out_report)
    out_report.parent.mkdir(parents=True, exist_ok=True)
    out_report.write_text(json.dumps(report, indent=2), encoding="utf-8")

    objs = report.get("objects", [])
    ranked = sum(1 for o in objs if o.get("status") == "ranked")
    unknown = sum(1 for o in objs if o.get("status") == "unknown")
    print("[STATIC_MANIP_TEST] done")
    print(f"[STATIC_MANIP_TEST] output report: {out_report}")
    print(f"[STATIC_MANIP_TEST] output feasible: {out_feasible}")
    print(f"[STATIC_MANIP_TEST] counts: total={len(objs)} ranked={ranked} unknown={unknown}")


if __name__ == "__main__":
    main()
