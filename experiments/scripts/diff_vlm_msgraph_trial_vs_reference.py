#!/usr/bin/env python3
"""Auto-compare a new trial's ordered_triples against a prior trial already manually
graded, and split the new trial into auto-confirmed matches vs. cases needing human
re-review.

Per the reviewer's instruction (2026-08-18): "以我上一轮的评估为标准答案,只看
ordered_triples,那里是唯一有用的输出...把评估是错的拉出来给我" — i.e. trial_01's
human judgement is ground truth; only ordered_triples matters (it is what the arm
actually executes); pull out the ones the new trial gets wrong (or can't be verified
against) for a second manual pass, and don't re-review ones that trivially match.

A case is handled one of three ways:
  - REFERENCE_INVALID: trial_01 itself was scored wrong (or never scored) for this
    case, so it is not valid ground truth. --candidate is queued for full manual
    review regardless of its content (no shortcut possible).
  - AUTO_MATCH: trial_01 was scored correct AND --candidate's ordered_triples is
    *exactly* equal to trial_01's, as an ordered sequence of
    (subject, predicate, frozenset(object), position) tuples — i.e. same content in
    the same order, ignoring only the literal 'step' integer and JSON formatting.
    Recorded as correct (value=1) with label 'auto_match_trial01', no human review
    needed.
  - DIVERGES: trial_01 was correct but --candidate's sequence differs in any way
    (added/removed/reordered row, changed predicate/object-set/position). Queued for
    manual review — a different sequence might still be a *valid* alternative
    ordering, or might be a genuine regression; only a human looking at the image can
    tell which.

This is deliberately strict (order-sensitive, exact-match-or-flag) rather than a fuzzy
diff: silently auto-approving a superficially-similar-but-different sequence would
undermine the whole point of having a human check trial_02 at all.

Outputs:
  - Merges AUTO_MATCH entries into manual_review/latest_scores.json (same schema the
    GUI writes, so downstream analyse/visualize scripts need no changes).
  - Writes review_index_flagged.json: the subset of --candidate's records that still
    need a human look (REFERENCE_INVALID + DIVERGES), each carrying an added
    'reference_ordered_triples' / 'reference_note' field for side-by-side display.
    Pass this path to review_vlm_msgraph_scores.py via --index to review only these.

Usage:
    python3 experiments/scripts/build_vlm_msgraph_review_index.py   # refresh index first
    python3 diff_vlm_msgraph_trial_vs_reference.py --reference 1 --candidate 2
"""
from __future__ import annotations

import argparse
import json
from datetime import datetime
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT_ROOT = ROOT / "experiments/outputs/VLM-MSGraph_baseline/accuracy_analysis"
INDEX_PATH = OUT_ROOT / "review_index.json"
LATEST_PATH = OUT_ROOT / "manual_review/latest_scores.json"
FLAGGED_INDEX_PATH = OUT_ROOT / "review_index_flagged.json"


def normalize_sequence(ordered):
    """Order-sensitive canonical form: list of (subject, predicate, object-set,
    position) tuples. Two sequences compare equal only if content AND order match —
    see module docstring for why this is intentionally strict."""
    seq = []
    for t in ordered or []:
        if not isinstance(t, dict):
            continue
        obj = t.get("object")
        if isinstance(obj, list):
            obj_set = frozenset(obj)
        elif isinstance(obj, str):
            obj_set = frozenset([obj])
        else:
            obj_set = frozenset()
        seq.append((t.get("subject"), t.get("predicate"), obj_set, t.get("position")))
    return tuple(seq)


def describe_diff(ref_seq, cand_seq) -> str:
    ref_by_subj = {r[0]: r for r in ref_seq}
    cand_by_subj = {c[0]: c for c in cand_seq}
    notes = []
    if [r[0] for r in ref_seq] != [c[0] for c in cand_seq]:
        notes.append(f"subject order differs: ref={[r[0] for r in ref_seq]} "
                     f"cand={[c[0] for c in cand_seq]}")
    for subj in ref_by_subj.keys() | cand_by_subj.keys():
        r, c = ref_by_subj.get(subj), cand_by_subj.get(subj)
        if r is None:
            notes.append(f"'{subj}' added in candidate: {c}")
        elif c is None:
            notes.append(f"'{subj}' missing from candidate (present in reference): {r}")
        elif r != c:
            notes.append(f"'{subj}' changed: ref={r} -> cand={c}")
    return "; ".join(notes) if notes else "(sequences equal — should not reach here)"


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--reference", type=int, default=1, help="Trial number treated as ground truth (default 1).")
    ap.add_argument("--candidate", type=int, required=True, help="Trial number being auto-checked, e.g. 2.")
    args = ap.parse_args()

    if not INDEX_PATH.exists():
        raise FileNotFoundError(
            f"Missing {INDEX_PATH}\nRun: python3 experiments/scripts/build_vlm_msgraph_review_index.py"
        )
    records = json.loads(INDEX_PATH.read_text(encoding="utf-8"))
    latest = json.loads(LATEST_PATH.read_text(encoding="utf-8")) if LATEST_PATH.exists() else {}

    by_case = {}
    for r in records:
        cell = (r["benchmark"], r["magnitude"], r["case_name"])
        by_case.setdefault(cell, {})[r["trial"]] = r

    n_auto = n_ref_invalid = n_diverges = n_missing_candidate = 0
    flagged = []
    report_lines = []

    for cell, by_trial in sorted(by_case.items()):
        ref_rec = by_trial.get(args.reference)
        cand_rec = by_trial.get(args.candidate)
        bench, mag, case = cell
        cell_key = f"{bench}/{mag}/{case}"

        if cand_rec is None:
            n_missing_candidate += 1
            report_lines.append(f"  ?? {cell_key}: trial_{args.candidate:02d} not found in index (not run yet?)")
            continue

        ref_key = ref_rec["key"] if ref_rec else None
        ref_score = latest.get(ref_key) if ref_key else None
        cand_key = cand_rec["key"]

        if ref_rec is None or ref_score is None or int(ref_score.get("value", 0)) != 1:
            n_ref_invalid += 1
            reason = ("no trial_%02d record" % args.reference if ref_rec is None else
                      "trial_%02d unscored" % args.reference if ref_score is None else
                      "trial_%02d scored WRONG" % args.reference)
            flagged.append({
                **cand_rec,
                "reference_ordered_triples": (ref_rec or {}).get("ordered_triples"),
                "reference_note": f"NO VALID REFERENCE ({reason}) — full manual review, nothing to auto-check against.",
            })
            report_lines.append(f"  [ref-invalid] {cell_key}: {reason}")
            continue

        ref_seq = normalize_sequence(ref_rec.get("ordered_triples"))
        cand_seq = normalize_sequence(cand_rec.get("ordered_triples"))

        if ref_seq == cand_seq:
            n_auto += 1
            event = {
                "timestamp": datetime.now().isoformat(timespec="seconds"),
                "key": cand_key,
                "label": "auto_match_trial%02d" % args.reference,
                "value": 1,
                "benchmark": cand_rec["benchmark"],
                "magnitude": cand_rec["magnitude"],
                "case_name": cand_rec["case_name"],
                "trial": cand_rec["trial"],
            }
            latest[cand_key] = event
            report_lines.append(f"  [auto-match] {cell_key}")
        else:
            n_diverges += 1
            flagged.append({
                **cand_rec,
                "reference_ordered_triples": ref_rec.get("ordered_triples"),
                "reference_note": f"DIFFERS from trial_{args.reference:02d} (verified correct) — review needed.",
            })
            diff_desc = describe_diff(ref_seq, cand_seq)
            report_lines.append(f"  [diverges]   {cell_key}: {diff_desc}")

    LATEST_PATH.parent.mkdir(parents=True, exist_ok=True)
    LATEST_PATH.write_text(json.dumps(latest, indent=2, ensure_ascii=False), encoding="utf-8")
    FLAGGED_INDEX_PATH.write_text(json.dumps(flagged, indent=2, ensure_ascii=False), encoding="utf-8")

    total = n_auto + n_ref_invalid + n_diverges + n_missing_candidate
    print(f"trial_{args.reference:02d} (reference) vs trial_{args.candidate:02d} (candidate) — {total} cases\n")
    print("\n".join(report_lines))
    print(f"\n{'=' * 60}")
    print(f"AUTO_MATCH (no review needed, recorded correct): {n_auto}")
    print(f"REFERENCE_INVALID (no trial_{args.reference:02d} baseline to check against): {n_ref_invalid}")
    print(f"DIVERGES (trial_{args.reference:02d} was correct, trial_{args.candidate:02d} differs): {n_diverges}")
    if n_missing_candidate:
        print(f"MISSING candidate trial: {n_missing_candidate}")
    print(f"\nFlagged for manual review: {len(flagged)} -> {FLAGGED_INDEX_PATH}")
    print(f"Auto-match scores merged into: {LATEST_PATH}")
    print(f"\nNext: python3 experiments/scripts/review_vlm_msgraph_scores.py "
          f"--index {FLAGGED_INDEX_PATH.relative_to(ROOT)} --start-unscored")


if __name__ == "__main__":
    main()
