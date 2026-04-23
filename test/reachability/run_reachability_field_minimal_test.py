import argparse
import json
from pathlib import Path

from pipeline.run_phase0 import execute_phase0


def _default_paths(repo_root: Path):
    return {
        "unnamed": repo_root / "unnamed.g",
        "layout": repo_root / "generated" / "phase0_layout.json",
        "infeasible": repo_root / "generated" / "infeasible_objects.json",
        "score": repo_root / "generated" / "reachability_score_report.json",
    }


def main():
    repo_root = Path(__file__).resolve().parents[2]
    defaults = _default_paths(repo_root)

    parser = argparse.ArgumentParser(description="TASK-019 minimal reachability field smoke run")
    parser.add_argument("--unnamed-g", default=str(defaults["unnamed"]))
    parser.add_argument("--layout-out", default=str(defaults["layout"]))
    parser.add_argument("--infeasible-out", default=str(defaults["infeasible"]))
    parser.add_argument("--score-out", default=str(defaults["score"]))
    parser.add_argument("--alpha", type=float, default=0.6)
    parser.add_argument("--beta", type=float, default=0.4)
    parser.add_argument("--tau-r", type=float, default=0.45)
    parser.add_argument("--seed", type=int, default=42)
    parser.add_argument("--disable-komo-gate", action="store_true")
    args = parser.parse_args()

    result = execute_phase0(
        use_vlm=False,
        unnamed_g_path=args.unnamed_g,
        layout_output_path=args.layout_out,
        infeasible_output_path=args.infeasible_out,
        reachability_mode="gmm_esdf_mvp",
        reachability_score_output_path=args.score_out,
        reachability_alpha=args.alpha,
        reachability_beta=args.beta,
        reachability_tau_r=args.tau_r,
        reachability_seed=args.seed,
        use_komo_policy_gate=not args.disable_komo_gate,
    )

    if not result or not result.get("success"):
        raise SystemExit("[TASK019_MIN_TEST] execute_phase0 failed")

    score_path = Path(args.score_out)
    if not score_path.exists():
        raise SystemExit(f"[TASK019_MIN_TEST] missing score report: {score_path}")

    report = json.loads(score_path.read_text(encoding="utf-8"))
    objs = report.get("objects", [])
    feasible = sum(1 for o in objs if o.get("decision") == "feasible")
    infeasible = sum(1 for o in objs if o.get("decision") != "feasible")

    print("[TASK019_MIN_TEST] done")
    print(f"[TASK019_MIN_TEST] score report: {score_path}")
    print(f"[TASK019_MIN_TEST] objects: total={len(objs)} feasible={feasible} infeasible={infeasible}")


if __name__ == "__main__":
    main()
