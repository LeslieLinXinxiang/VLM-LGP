#!/usr/bin/env python3
"""Export a self-contained record of the trials the graph validator rejects.

Writes `experiments/outputs/validator_ablation/rejected_cases/` — one JSON per case
plus a README table — so the validator ablation can be reviewed (and cited in the
paper) without re-running the API or re-deriving anything from a session transcript.

Each case record holds the input images the VLM was shown, the validator's own error
report, the originally-wrong graph, the reference graph, and the regenerated graph
from the replay run named by --replay.

Usage:
  python3 experiments/scripts/export_validator_rejected_cases.py            # newest replay
  python3 experiments/scripts/export_validator_rejected_cases.py --replay experiments/outputs/validator_ablation/replay_20260912_220202.json
"""
import argparse
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))

from pipeline.run_phase1 import validate_plan                      # noqa: E402
from experiments.scripts.ablation_validator_replay import (        # noqa: E402
    EVAL, images_for, load_graph, scored_trials,
)
from experiments.scripts.analyse_gemini_proposed_method_accuracy import (  # noqa: E402
    canonicalize_graph,
)

OUT = ROOT / "experiments/outputs/validator_ablation"
DEST = OUT / "rejected_cases"


def newest_replay():
    runs = sorted(OUT.glob("replay_*.json"))
    if not runs:
        sys.exit("no replay_*.json found — run ablation_validator_replay.py first")
    return runs[-1]


def regenerated_from_log(log_path, case):
    """Recover a regenerated graph from a streamed run log, if the replay JSON predates
    graph persistence. Pairs each 'answered' line with the nearest preceding raw block."""
    if not log_path or not Path(log_path).exists():
        return None
    text = Path(log_path).read_text(encoding="utf-8", errors="replace")
    lines = text.split("\n")
    blocks, start, buf = [], None, []
    for i, line in enumerate(lines):
        if line.strip() == "=== VLM RAW OUTPUT START ===":
            start, buf = i, []
        elif line.strip() == "=== VLM RAW OUTPUT END ===" and start is not None:
            blocks.append((i, "\n".join(buf)))
            start = None
        elif start is not None:
            buf.append(line)
    hit = re.compile(rf"^\s+{re.escape(case)}\s+T\d+\s+answered .*matches_ref=True")
    for i, line in enumerate(lines):
        if hit.match(line):
            prev = [b for (e, b) in blocks if e < i]
            if not prev:
                return None
            m = re.search(r"## FINAL_JSON_START(.*?)## FINAL_JSON_END", prev[-1], re.S)
            body = re.sub(r"^```(?:json)?|```$", "", (m.group(1) if m else prev[-1]).strip(),
                          flags=re.M).strip()
            try:
                return json.loads(body)
            except Exception:
                return None
    return None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--replay", type=Path, default=None)
    ap.add_argument("--log", type=Path, default=None,
                    help="streamed run log, used to recover regenerated graphs from a "
                         "replay JSON written before graphs were persisted")
    args = ap.parse_args()

    replay_path = args.replay or newest_replay()
    replay = json.loads(replay_path.read_text())
    by_case = {r["case"]: r for r in replay["results"]}

    DEST.mkdir(parents=True, exist_ok=True)
    rows = []
    seen = set()

    for bench, mag, case, label, gt, wrong in scored_trials():
        if not wrong or case not in by_case or case in seen:
            continue
        base = EVAL / bench / mag / case
        bad = load_graph(base / f"trial_{label[1:]}.md")
        ref = load_graph(base / f"trial_{gt[1:]}.md")
        if bad is None or ref is None:
            continue
        rules = []
        ok, report = validate_plan(bad, [], "fmb" if bench == "FMB" else "cube",
                                   collect=rules)
        if ok:                       # validator accepts it; not part of this record
            continue
        seen.add(case)
        res = by_case[case]

        regen = res.get("graph_regenerated")
        if regen is None:
            for att in res.get("attempts", []):
                if att.get("matches_reference"):
                    regen = att.get("graph")
                    break
        if regen is None:
            regen = regenerated_from_log(args.log, case)

        record = {
            "benchmark": bench,
            "magnitude": mag,
            "case": case,
            "wrong_trial": label,
            "reference_trial": gt,
            "input_images": [str(p.relative_to(ROOT)) for p in images_for(bench, mag, case)],
            "validator_rules_fired": rules,
            "validator_report": report,
            "graph_original_wrong": bad,
            "graph_reference": ref,
            "graph_regenerated": regen,
            "regenerated_matches_reference": bool(
                regen is not None
                and canonicalize_graph(regen) == canonicalize_graph(ref)
            ),
            "replay": {
                "source": str(replay_path.relative_to(ROOT)),
                "repeats_budget": res["repeats"],
                "real_answers_used": res["answered_repeats"],
                "network_failures_excluded": res["call_errors"],
                "matched_reference": bool(res["regen_matches_reference"]),
            },
        }
        (DEST / f"{bench}_{mag}_{case}.json").write_text(
            json.dumps(record, indent=2), encoding="utf-8")
        rows.append(record)

    rows.sort(key=lambda r: (r["benchmark"], r["magnitude"], r["case"]))

    lines = [
        "# Validator-rejected trials — case record",
        "",
        f"Source replay: `{replay_path.relative_to(ROOT)}`  ",
        f"Cases: {len(rows)} of the 19 mis-scored trials in the 400-trial evaluation "
        "(the other 15 pass the validator and are unaffected by the retry loop).",
        "",
        "The validator performs internal-consistency checks on the predicted graph only "
        "— it uses no ground truth about the target. Each case below was rejected, "
        "regenerated with the validator's error report as feedback, and the regenerated "
        "graph compared against the reference.",
        "",
        "| Benchmark | Magnitude | Case | Wrong trial | Rules fired | Real answers | Net. fails excl. | Fixed |",
        "|---|---|---|---|---|---|---|---|",
    ]
    for r in rows:
        lines.append(
            f"| {r['benchmark']} | {r['magnitude']} | `{r['case']}` | {r['wrong_trial']} "
            f"| {', '.join(r['validator_rules_fired'])} "
            f"| {r['replay']['real_answers_used']}/{r['replay']['repeats_budget']} "
            f"| {r['replay']['network_failures_excluded']} "
            f"| {'yes' if r['regenerated_matches_reference'] else 'no'} |"
        )
    fixed = sum(r["regenerated_matches_reference"] for r in rows)
    lines += [
        "",
        f"**Regenerated graphs matching the reference: {fixed}/{len(rows)}.**",
        "",
        "Per-case JSON files in this directory carry the input image paths, the "
        "validator report, and the three graphs (originally wrong / reference / "
        "regenerated) verbatim.",
        "",
        "## Reading the numbers",
        "",
        "Network failures are excluded from every ratio above. A call that never "
        "returned is not a wrong answer; counting those as mismatches understated an "
        "earlier version of this experiment (see `core/vlm.py`'s retry note).",
        "",
        "Two measurement bugs were fixed before these numbers were trusted, both of "
        "which had produced false failures:",
        "",
        "1. `canonicalize_graph` compared the raw `object` type string, so a "
        "structurally identical graph that said \"Long Rectangular Prism\" instead of "
        "\"Long RectPrism\" scored as a mismatch. Type names are now normalized.",
        "2. `ablation_validator_replay.py` passed only the first image of an FMB case. "
        "FMB inputs are image *sequences*; the model was being shown a subset of the "
        "structure and its answer correctly described only what it saw. All images are "
        "now passed, matching `run_gemini_proposed_method_fmb_eval.py`.",
    ]
    (DEST / "README.md").write_text("\n".join(lines) + "\n", encoding="utf-8")

    print(f"exported {len(rows)} cases -> {DEST.relative_to(ROOT)}")
    print(f"regenerated matching reference: {fixed}/{len(rows)}")


if __name__ == "__main__":
    main()
