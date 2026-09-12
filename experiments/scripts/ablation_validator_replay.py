#!/usr/bin/env python3
"""
Validator ablation — regeneration replay.

For every historical trial that the validator now rejects, replay the retry step that
would have followed: hand the VLM the same prompt and image plus the validator's
feedback on the stored wrong graph, then check whether the regenerated graph matches
the reference. Repeats each case to average over sampling noise.

The trials the validator accepts on the first pass are unaffected by the retry loop, so
they are reported separately rather than replayed.

Usage:
  python3 experiments/scripts/ablation_validator_replay.py --repeats 5
  python3 experiments/scripts/ablation_validator_replay.py --dry-run    # no API calls
"""
import argparse, datetime, json, re, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))

from pipeline.run_phase1 import validate_plan                      # noqa: E402
from experiments.scripts.analyse_gemini_proposed_method_accuracy import canonicalize_graph  # noqa: E402

EVAL = ROOT / "experiments/evaluations/VLM/gemini_proposed_method"
ANALYSIS = ROOT / "experiments/outputs/gemini_proposed_method/accuracy_analysis"
OUT = ROOT / "experiments/outputs/validator_ablation"

PROMPT = {"cubeStacking": ROOT / "prompts/phase1_graph_planner.md",
          "FMB": ROOT / "prompts/phase1_fmb_graph_planner.md"}


def image_for(bench, mag, case):
    if bench == "cubeStacking":
        return ROOT / f"experiments/inputs/cubeStacking/{mag}/{case}.png"
    d = ROOT / f"experiments/inputs/FMB/{mag}/{case}"
    imgs = sorted(d.glob("*.png"))
    return imgs[0] if imgs else None


def load_graph(md_path):
    if not md_path.exists():
        return None
    m = re.search(r"## FINAL_JSON_START(.*?)## FINAL_JSON_END",
                  md_path.read_text(encoding="utf-8", errors="replace"), re.S)
    if not m:
        return None
    body = re.sub(r"^```(?:json)?|```$", "", m.group(1).strip(), flags=re.M).strip()
    try:
        return json.loads(body)
    except Exception:
        return None


def scored_trials():
    """(bench, magnitude, case, trial_label, gt_label, is_wrong) from the accuracy reports."""
    for bench in ("cubeStacking", "FMB"):
        for rep in sorted((ANALYSIS / bench).glob("*/accuracy_report.md")):
            lines = rep.read_text(encoding="utf-8").splitlines()
            header = next(([c.strip() for c in l.strip().strip("|").split("|")][1:-2]
                           for l in lines if "| Case" in l), None)
            if not header:
                continue
            for line in lines:
                if not line.strip().startswith("|"):
                    continue
                cells = [c.strip() for c in line.strip().strip("|").split("|")]
                if len(cells) < 4 or not cells[-1].startswith("T"):
                    continue
                for label, mark in zip(header, cells[1:-2]):
                    yield bench, rep.parent.name, cells[0], label, cells[-1], mark == "✗"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--repeats", type=int, default=5)
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    rejected, accepted_but_wrong = [], []
    for bench, mag, case, label, gt, wrong in scored_trials():
        if not wrong:
            continue
        base = EVAL / bench / mag / case
        bad = load_graph(base / f"trial_{label[1:]}.md")
        ref = load_graph(base / f"trial_{gt[1:]}.md")
        if bad is None or ref is None:
            continue
        rules = []
        ok, report = validate_plan(bad, [], "fmb" if bench == "FMB" else "cube", collect=rules)
        entry = dict(bench=bench, mag=mag, case=case, trial=label, gt=gt,
                     rules=rules, report=report, bad=bad, ref=ref)
        (accepted_but_wrong if ok else rejected).append(entry)

    print(f"wrong trials: {len(rejected) + len(accepted_but_wrong)}  "
          f"| validator rejects {len(rejected)} | passes {len(accepted_but_wrong)}")
    for e in rejected:
        print(f"  replay  {e['bench']:<13}{e['mag']:<8}{e['case']:<14}{e['trial']}  {e['rules']}")

    if args.dry_run:
        print("\n--dry-run: no API calls made.")
        return

    from core.vlm import VLMClient
    vlm = VLMClient()
    OUT.mkdir(parents=True, exist_ok=True)
    results = []

    for e in rejected:
        img = image_for(e["bench"], e["mag"], e["case"])
        prompt = PROMPT[e["bench"]]
        feedback = ("[SYSTEM FEEDBACK]:\nYour previous answer was rejected.\n"
                    f"Previous answer:\n{json.dumps(e['bad'], indent=1)}\n"
                    f"Fix these errors:\n{e['report']}\nDo not hallucinate.")
        ref_sig = canonicalize_graph(e["ref"])
        fixed = valid = 0
        for k in range(args.repeats):
            try:
                regen = vlm.generate_assembly_plan(str(img), str(prompt),
                                                   example_content=None,
                                                   feedback_context=feedback)
                rules = []
                ok, _ = validate_plan(regen, [], "fmb" if e["bench"] == "FMB" else "cube",
                                      collect=rules)
                match = canonicalize_graph(regen) == ref_sig
                valid += ok
                fixed += match
                print(f"    {e['case']} {e['trial']} rep{k+1}: valid={ok} matches_ref={match}")
            except Exception as exc:                      # noqa: BLE001
                print(f"    {e['case']} {e['trial']} rep{k+1}: ERROR {exc}")
        results.append(dict(bench=e["bench"], mag=e["mag"], case=e["case"], trial=e["trial"],
                            rules=e["rules"], repeats=args.repeats,
                            regen_valid=valid, regen_matches_reference=fixed))

    stamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    path = OUT / f"replay_{stamp}.json"
    path.write_text(json.dumps({
        "repeats": args.repeats,
        "validator_rejected": len(rejected),
        "validator_passed_but_wrong": len(accepted_but_wrong),
        "results": results,
    }, indent=2), encoding="utf-8")
    tot = sum(r["regen_matches_reference"] for r in results)
    den = sum(r["repeats"] for r in results)
    print(f"\nregenerated graphs matching the reference: {tot}/{den}")
    print(f"written: {path}")


if __name__ == "__main__":
    main()
