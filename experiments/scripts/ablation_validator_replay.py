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


def images_for(bench, mag, case):
    """All input images for one case, in the order the VLM must see them.

    An FMB case is a *sequence*: 001.png places the first layer of objects,
    002.png adds the next, and the graph describes the final assembled state.
    Passing only the first image (as an earlier version of this script did) shows
    the model a strict subset of the structure, and its answer then correctly
    describes only the objects it was given — which scores as a wrong graph
    against a reference built from the whole sequence. Mirrors the image handling
    in run_gemini_proposed_method_fmb_eval.py, which is what produced the stored
    trials this ablation replays.
    """
    if bench == "cubeStacking":
        return [ROOT / f"experiments/inputs/cubeStacking/{mag}/{case}.png"]
    d = ROOT / f"experiments/inputs/FMB/{mag}/{case}"
    return sorted(d.glob("*.png"))


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
    ap.add_argument("--only", type=str, default=None,
                     help="Comma-separated case names to replay (e.g. '001,005'); "
                          "default replays every validator-rejected case.")
    ap.add_argument("--stop-on-match", action="store_true",
                     help="End a case as soon as one regenerated graph matches the "
                          "reference. Cheaper, but yields a single observation per case "
                          "rather than a rate; the default collects --repeats real "
                          "answers for every case.")
    args = ap.parse_args()
    only = set(args.only.split(",")) if args.only else None

    rejected, accepted_but_wrong = [], []
    for bench, mag, case, label, gt, wrong in scored_trials():
        if not wrong:
            continue
        if only is not None and case not in only:
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
    from concurrent.futures import ThreadPoolExecutor, as_completed
    from PIL import Image
    from core.utils import clean_vlm_json_output
    OUT.mkdir(parents=True, exist_ok=True)

    def _generate(vlm, bench, imgs, prompt_path, feedback):
        """Regenerate one graph, presenting the images the way the original run did.

        Cube stacking is a single image and goes through generate_assembly_plan
        unchanged. FMB is a sequence and is assembled here to match
        run_gemini_proposed_method_fmb_eval.py — same "Step N Image:" labelling and
        same closing instruction — so the replay differs from the stored trial only
        by the appended validator feedback.
        """
        if bench != "FMB":
            return vlm.generate_assembly_plan(str(imgs[0]), str(prompt_path),
                                              example_content=None,
                                              feedback_context=feedback)
        template = Path(prompt_path).read_text(encoding="utf-8")
        content = [template,
                   "\n--- MISSION START: ACTUAL TASK ---\n",
                   "Analyze this Sequence of FMB Assembly Images in order:\n"]
        for idx, ipath in enumerate(imgs):
            content.append(f"Step {idx + 1} Image:")
            content.append(Image.open(ipath))
        content.append("\nNow, output the Topological Graph for the final assembled state:")
        if feedback:
            content.append(f"\n{feedback}")
        raw = vlm._call_vlm_with_retry(content, is_json_output=False)
        m = re.search(r"## FINAL_JSON_START(.*?)## FINAL_JSON_END", raw or "", re.S)
        return json.loads(clean_vlm_json_output(m.group(1) if m else raw))

    # Network failures (core.vlm's RemoteProtocolError retries exhausted) do not
    # count against the accuracy denominator at all — they're not an answer, right
    # or wrong. Each case is sampled until args.repeats *real* answers have been
    # collected, so the result is a rate (k/N) rather than a single observation;
    # --stop-on-match ends a case as soon as one answer matches, which is cheaper
    # but only shows that a fix is reachable, not how often. A generous raw-attempt
    # cap guards against a connection so broken that real answers never accumulate.
    MAX_RAW_ATTEMPTS = max(20, args.repeats * 8)

    def _run_case(e):
        imgs = images_for(e["bench"], e["mag"], e["case"])
        prompt = PROMPT[e["bench"]]
        feedback = ("[SYSTEM FEEDBACK]:\nYour previous answer was rejected.\n"
                    f"Previous answer:\n{json.dumps(e['bad'], indent=1)}\n"
                    f"Fix these errors:\n{e['report']}")
        ref_sig = canonicalize_graph(e["ref"])
        vlm = VLMClient()
        answered = valid_count = call_errors = raw_attempts = match_count = 0
        matched = False
        attempts_log = []
        while (answered < args.repeats
               and not (matched and args.stop_on_match)
               and raw_attempts < MAX_RAW_ATTEMPTS):
            raw_attempts += 1
            try:
                regen = _generate(vlm, e["bench"], imgs, prompt, feedback)
                rules = []
                ok, _ = validate_plan(regen, [], "fmb" if e["bench"] == "FMB" else "cube",
                                      collect=rules)
                match = canonicalize_graph(regen) == ref_sig
                answered += 1
                valid_count += int(ok)
                # Keep the regenerated graph itself, not just the verdict — the whole
                # point of this ablation is being able to read what the model produced.
                attempts_log.append({"answer_index": answered, "valid": ok,
                                     "rules_fired": rules, "matches_reference": match,
                                     "graph": regen})
                match_count += int(match)
                print(f"    {e['case']} {e['trial']} answered {answered}/{args.repeats}: "
                      f"valid={ok} matches_ref={match} "
                      f"(running {match_count}/{answered})", flush=True)
                if match:
                    matched = True
            except Exception as exc:                      # noqa: BLE001
                call_errors += 1
                attempts_log.append({"answer_index": None, "call_error": str(exc)})
                print(f"    {e['case']} {e['trial']} CALL_ERROR (raw attempt {raw_attempts}): {exc}",
                      flush=True)
        return dict(bench=e["bench"], mag=e["mag"], case=e["case"], trial=e["trial"],
                    rules=e["rules"], repeats=args.repeats,
                    regen_valid=valid_count,
                    regen_matches_reference=match_count,
                    ever_matched=int(matched),
                    call_errors=call_errors, answered_repeats=answered,
                    raw_attempts=raw_attempts,
                    stopped_early_on_match=bool(matched and args.stop_on_match),
                    hit_raw_attempt_cap=(answered < args.repeats
                                         and not (matched and args.stop_on_match)),
                    input_images=[str(p.relative_to(ROOT)) for p in imgs],
                    validator_report=e["report"],
                    graph_original_wrong=e["bad"],
                    graph_reference=e["ref"],
                    attempts=attempts_log)

    results = []
    with ThreadPoolExecutor(max_workers=len(rejected)) as pool:
        futures = [pool.submit(_run_case, e) for e in rejected]
        for fut in as_completed(futures):
            results.append(fut.result())
    results.sort(key=lambda r: (r["bench"], r["mag"], r["case"]))

    stamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    path = OUT / f"replay_{stamp}.json"
    total_match = sum(r["regen_matches_reference"] for r in results)
    total_answered = sum(r["answered_repeats"] for r in results)
    total_errors = sum(r["call_errors"] for r in results)
    ever = sum(r["ever_matched"] for r in results)
    path.write_text(json.dumps({
        "repeats": args.repeats,
        "stop_on_match": args.stop_on_match,
        "validator_rejected": len(rejected),
        "validator_passed_but_wrong": len(accepted_but_wrong),
        "totals": {
            "answers": total_answered,
            "matching_reference": total_match,
            "cases_ever_matched": ever,
            "cases": len(results),
            "network_failures_excluded": total_errors,
        },
        "results": results,
    }, indent=2), encoding="utf-8")

    print("\nper case (answers matching the reference):")
    for r in results:
        print(f"  {r['bench']:<13}{r['case']:<14}{r['trial']}  "
              f"{r['regen_matches_reference']}/{r['answered_repeats']}"
              f"   net-fails excluded: {r['call_errors']}")
    print(f"\nanswers matching the reference: {total_match}/{total_answered}")
    print(f"cases fixed at least once:      {ever}/{len(results)}")
    print(f"network failures excluded:      {total_errors}")
    for r in results:
        if r["hit_raw_attempt_cap"]:
            print(f"  WARNING: {r['case']} {r['trial']} hit the raw-attempt cap "
                  f"({r['raw_attempts']}) before reaching {args.repeats} real answers "
                  f"({r['answered_repeats']} obtained) — network reliability, not accuracy.")
    print(f"written: {path}")


if __name__ == "__main__":
    main()
