#!/usr/bin/env python3
"""
Gemini proposed method accuracy analysis — FMB.

Same methodology as analyse_gemini_proposed_method_accuracy.py (cube stacking):
reads trial markdown files under experiments/evaluations/VLM/gemini_proposed_method/FMB,
extracts FINAL_JSON blocks (with FINAL_PDDL as fallback), selects a reference trial per
case as the answer with the highest support rate among that case's valid trials, and
writes accuracy reports plus a cross-magnitude summary under
experiments/outputs/gemini_proposed_method/accuracy_analysis/FMB.

Only difference from the cube script: FMB trial files are numbered trial_01..trial_10
(cube's are trial_02..trial_11) and the magnitude directories are 3objs/4objs/5objs.
"""
import json
import re
import textwrap
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
EVAL_ROOT = ROOT / "experiments/evaluations/VLM/gemini_proposed_method/FMB"
OUTPUT_ROOT = ROOT / "experiments/outputs/gemini_proposed_method/accuracy_analysis/FMB"
START_TRIAL = 1  # Trials start from 01
NUM_TRIALS = 10  # Run 10 trials
TRIALS = list(range(START_TRIAL, START_TRIAL + NUM_TRIALS))  # [1, 2, ..., 10]


# ── Helpers ──────────────────────────────────────────────────────────────────

def extract_final_block_from_md(md_path: Path):
    """Pull the FINAL_JSON block out of a trial markdown file, with FINAL_PDDL fallback."""
    try:
        text = md_path.read_text(encoding="utf-8")
        m = re.search(r"## FINAL_JSON_START\s*(.*?)\s*## FINAL_JSON_END", text, re.DOTALL)
        if not m:
            m = re.search(r"## FINAL_PDDL_START\s*(.*?)\s*## FINAL_PDDL_END", text, re.DOTALL)
        if not m:
            return None
        block = m.group(1).strip()
        return block if block else None
    except Exception:
        return None


def canonicalize_graph(parsed):
    """
    Build an id-numbering-independent signature for an {"objects": [...]} support
    graph. The VLM assigns "id" by whatever order it scans objects in, which is not
    semantically meaningful — two trials that agree on every object's type/color and
    its supporter set/positions, but enumerate the objects in a different order (and
    therefore give them different ids), describe the *same* graph and must compare
    equal. Comparing raw JSON text (as the previous normalize_final_block did) treats
    such id permutations as distinct answers, which can fragment a correct majority
    across several differently-numbered variants and let a genuinely wrong minority
    (e.g. one that always lists objects in the same fixed, incomplete order) win the
    "highest support rate" GT vote by accident. See FMB 3objs/004 for a real instance
    of this: 7/10 trials had the correct 3-object graph split into 3 different id
    orderings (2+3+2), while 3/10 trials that all omitted the same object produced
    identical text and briefly outvoted every individual correct variant.

    Resolves each object's signature recursively from its supporters (id 0 = base),
    memoized, with each object's own edge set sorted so multi-supporter ordering
    doesn't matter either. Returns a hashable tuple, or None if the graph is
    malformed (missing base, dangling supporter reference, reference cycle, ...).
    """
    if not isinstance(parsed, dict) or "objects" not in parsed:
        return None
    objects = parsed["objects"]
    if not isinstance(objects, list) or not objects:
        return None

    id_to_obj = {}
    for o in objects:
        if not isinstance(o, dict) or "id" not in o:
            return None
        id_to_obj[o["id"]] = o
    if 0 not in id_to_obj:
        return None

    sig_cache = {0: "BASE"}

    def resolve(oid, visiting):
        if oid in sig_cache:
            return sig_cache[oid]
        if oid in visiting or oid not in id_to_obj:
            return None
        visiting = visiting | {oid}
        o = id_to_obj[oid]
        edges = o.get("edges", [])
        if not isinstance(edges, list):
            return None
        # Position on a multi-supporter (bridging) edge is dropped from the signature.
        # Verified empirically against the real downstream consumer
        # (core.graph_clustering.KMeansBranchClustering): the supporter *set* alone
        # already pins the object's location once it bridges >1 support — including or
        # omitting a left/right label on those edges only perturbs a k-means feature
        # used for solver batch-grouping (confirmed by running both FMB 4objs/004 and
        # 5objs/005 variants through generate_optimal_strategy(): batch counts differed,
        # e.g. [[1,2],[3,4]] vs [[1,2],[3],[4]]). But batch grouping is a solver
        # efficiency choice, not a feasibility criterion — _build_dependency_safe_batches
        # enforces precedence gating regardless of raw cluster assignment, so every
        # grouping still builds lower supports before upper ones. Since the supporter
        # set (which *is* compared) is what actually determines build order and physical
        # feasibility, a bridging edge's position label carries no scored information.
        # Single-supporter edges are unaffected: there position is the only thing that
        # distinguishes e.g. "front" from "back" placement on an otherwise-identical
        # supporter, so it stays part of the signature.
        is_multi_support = len(edges) > 1
        edge_sigs = []
        for e in edges:
            if not isinstance(e, dict) or "supporter" not in e:
                return None
            supp_sig = resolve(e["supporter"], visiting)
            if supp_sig is None:
                return None
            pos = None if is_multi_support else e.get("position")
            edge_sigs.append((str(supp_sig), pos))
        edge_sigs.sort(key=lambda x: (x[0], str(x[1])))
        # Color is deliberately excluded from the signature: it exists in the schema
        # only to let the VLM tell apart two simultaneously-present same-type objects
        # in its own reasoning, not as a scored attribute. Two trials that place the
        # same type of object in the same structural position (same supporters, same
        # position label) describe the same graph even if they name its color
        # differently (e.g. "purple" vs "magenta" for one RGB(255,52,255) swatch,
        # confirmed by pixel sampling on FMB 3objs/005 — both names are for the same
        # object, neither is more "right"). Placement, not color-naming, is what this
        # metric scores.
        sig = (o.get("object"), tuple(edge_sigs))
        sig_cache[oid] = sig
        return sig

    all_sigs = []
    for oid in id_to_obj:
        if oid == 0:
            continue
        sig = resolve(oid, frozenset())
        if sig is None:
            return None
        all_sigs.append(sig)

    return tuple(sorted(all_sigs, key=str))


def normalize_final_block(block: str):
    """Normalize a FINAL block for stable equality comparison."""
    if not isinstance(block, str):
        return None
    stripped = block.strip()

    # Prefer JSON normalization when the block looks like JSON.
    if stripped.startswith("{") or stripped.startswith("["):
        try:
            parsed = json.loads(stripped)
        except Exception:
            parsed = None
        if parsed is not None:
            canon = canonicalize_graph(parsed)
            if canon is not None:
                return ("CANON",) + canon
            # Malformed graph (missing base, dangling ref, ...): fall back to raw
            # JSON text so it still registers as a distinct answer instead of being
            # silently dropped.
            return json.dumps(parsed, sort_keys=True, ensure_ascii=False, separators=(",", ":"))

    lines = []
    for line in block.splitlines():
        cleaned = " ".join(line.strip().split())
        if cleaned:
            lines.append(cleaned)
    if not lines:
        return None
    return tuple(lines)


# ── Analysis ─────────────────────────────────────────────────────────────────

def load_case_trials(case_dir: Path):
    trials = []
    for t in TRIALS:
        md = case_dir / f"trial_{t:02d}.md"
        if not md.exists():
            trials.append((t, None, None))
            continue
        raw_block = extract_final_block_from_md(md)
        norm_block = normalize_final_block(raw_block) if raw_block else None
        trials.append((t, raw_block, norm_block))
    return trials


def choose_reference_trial(trials):
    """Select reference answer: pick the answer with highest support rate.
    If multiple candidates exist at same high support, pick the one whose first trial appears earliest.
    """
    valid_trials = [(t, raw, norm) for t, raw, norm in trials if norm is not None]
    if not valid_trials:
        return None, None, {}

    freq = defaultdict(int)
    first_occurrence = {}  # Track first trial number for each answer
    for t, raw, norm in valid_trials:
        freq[norm] += 1
        if norm not in first_occurrence:
            first_occurrence[norm] = t

    total_valid = len(valid_trials)

    # Find the answer with the highest support rate
    best_norm = None
    best_acc = 0
    best_trial = None

    for norm_block in freq:
        acc = freq[norm_block] / total_valid * 100
        # Prefer answer with higher support; if equal, prefer earlier trial
        if acc > best_acc or (acc == best_acc and (best_trial is None or first_occurrence[norm_block] < best_trial)):
            best_acc = acc
            best_norm = norm_block
            best_trial = first_occurrence[norm_block]

    if best_norm is None:
        t, raw, norm = valid_trials[0]
        return t, norm, freq

    return best_trial, best_norm, freq


def analyse_case(case_dir: Path):
    trials = load_case_trials(case_dir)
    gt_trial, gt_norm, freq = choose_reference_trial(trials)

    results = {}
    for t, raw_block, norm_block in trials:
        if norm_block is None:
            results[t] = None
            continue
        if gt_trial is not None and t == gt_trial:
            results[t] = True
            continue
        results[t] = gt_norm is not None and norm_block == gt_norm

    n_valid = sum(1 for v in results.values() if v is not None)
    n_correct = sum(1 for v in results.values() if v is True)
    acc = (n_correct / n_valid * 100) if n_valid else 0.0
    return results, acc, gt_trial, n_valid, freq


def fmt_trial_row(results, gt_trial):
    cells = []
    for t in TRIALS:
        v = results.get(t)
        if v is None:
            cells.append("—")
        elif t == gt_trial:
            cells.append("GT")
        elif v:
            cells.append("✓")
        else:
            cells.append("✗")
    return cells


# ── Output ────────────────────────────────────────────────────────────────────

def build_magnitude_table(mag_dir: Path):
    mag_name = mag_dir.name
    cases = sorted([d for d in mag_dir.iterdir() if d.is_dir()])
    if not cases:
        return None, []

    header = ["Case"] + [f"T{t:02d}" for t in TRIALS] + ["Accuracy", "GT"]
    rows = [header]
    summary_list = []

    for case_dir in cases:
        name = case_dir.name
        trial_results, acc, gt_trial, n_valid, _ = analyse_case(case_dir)
        cells = fmt_trial_row(trial_results, gt_trial)
        gt_label = f"T{gt_trial:02d}" if gt_trial is not None else "N/A"
        rows.append([name] + cells + [f"{acc:.0f}%", gt_label])
        summary_list.append({"case": name, "acc": acc, "magnitude": mag_name, "gt_trial": gt_trial, "n_valid": n_valid})

    return rows, summary_list


def rows_to_md_table(rows):
    if not rows:
        return ""
    widths = [max(len(str(r[c])) for r in rows) for c in range(len(rows[0]))]
    lines = []
    for i, row in enumerate(rows):
        line = "| " + " | ".join(str(cell).ljust(widths[j]) for j, cell in enumerate(row)) + " |"
        lines.append(line)
        if i == 0:
            sep = "| " + " | ".join("-" * widths[j] for j in range(len(row))) + " |"
            lines.append(sep)
    return "\n".join(lines)


# ── Main ─────────────────────────────────────────────────────────────────────

def main():
    OUTPUT_ROOT.mkdir(parents=True, exist_ok=True)
    magnitudes = sorted([d for d in EVAL_ROOT.iterdir() if d.is_dir()])

    all_summaries = []

    for mag_dir in magnitudes:
        mag_name = mag_dir.name
        print(f"Processing {mag_name} ...")

        rows, summary_list = build_magnitude_table(mag_dir)
        if not rows:
            continue

        all_summaries.extend(summary_list)

        out_dir = OUTPUT_ROOT / mag_name
        out_dir.mkdir(parents=True, exist_ok=True)
        table_md = rows_to_md_table(rows)

        avg_acc = sum(s["acc"] for s in summary_list) / len(summary_list) if summary_list else 0
        md_content = textwrap.dedent(f"""\
            # Accuracy Report — {mag_name}

            > Ground truth: selected by finding the answer with the highest support rate.
            > ✓ = matches GT graph topology | ✗ = different | GT = ground truth trial | — = missing

            {table_md}

            **Average Accuracy: {avg_acc:.1f}%**
        """)
        (out_dir / "accuracy_report.md").write_text(md_content, encoding="utf-8")
        print(f"  → {out_dir}/accuracy_report.md  (avg {avg_acc:.1f}%)")

    mag_groups = defaultdict(list)
    for s in all_summaries:
        mag_groups[s["magnitude"]].append(s["acc"])

    comp_rows = [["Magnitude", "Cases", "Avg Accuracy", "Min", "Max"]]
    for mag in sorted(mag_groups.keys()):
        accs = mag_groups[mag]
        comp_rows.append([
            mag,
            str(len(accs)),
            f"{sum(accs)/len(accs):.1f}%",
            f"{min(accs):.0f}%",
            f"{max(accs):.0f}%",
        ])

    comp_table = rows_to_md_table(comp_rows)
    overall_avg = sum(s["acc"] for s in all_summaries) / len(all_summaries) if all_summaries else 0
    comp_md = textwrap.dedent(f"""\
        # Cross-Magnitude Accuracy Comparison — Gemini Proposed Method (FMB)

        > Each case's accuracy = % of valid trials whose FINAL_JSON block matches the selected reference trial.

        {comp_table}

        **Overall Average Accuracy: {overall_avg:.1f}%**

        ---

        ## Notes
        - Reference answer selection:
          - Find the answer with the highest support rate across all trials.
          - If multiple answers have equal high support, pick the one whose first trial appears earliest.
        - Trial range analyzed: `trial_01.md` → `trial_10.md`.
        - Graph comparison is id-numbering-independent (`canonicalize_graph`): two
          trials that agree on every object's type/color/supporter-set/position but
          assign different sequential `id`s (an artifact of scan order, not a real
          structural difference) are treated as the same answer. An earlier version
          of this script compared raw JSON text instead, which could fragment a
          correct majority across multiple id-orderings and let a wrong minority win
          the GT vote by coincidence — this happened for `3objs/004` (see git history
          of this file / accuracy_report.md for that case).
        - Color is not scored: two trials describing the same object at the same
          structural position (same supporters, same position label) count as the
          same answer regardless of what color name each used (e.g. "purple" vs
          "magenta" for one RGB(255,52,255) swatch — verified by pixel sampling on
          `3objs/005`). Color only exists in the schema so the VLM can tell apart
          simultaneously-present same-type objects in its own reasoning; it is not a
          placement fact.
        - Position on a multi-supporter (bridging) edge is not scored: verified
          empirically against the real downstream consumer
          (`core.graph_clustering.KMeansBranchClustering`) that including vs. omitting
          a left/right label on a bridging edge only perturbs solver batch-grouping
          (batch *count* can differ), never build precedence or physical feasibility —
          `_build_dependency_safe_batches` enforces dependency-safe ordering regardless
          of raw cluster assignment. Affected `4objs/004` and `5objs/005`.
        - Single-supporter position (e.g. front/back on an object resting directly on
          base) is still scored: it is the only thing distinguishing otherwise-identical
          placements. One case (`5objs/003`) was investigated as a possible GT
          mis-selection (majority omits position on an edge that looked off-center) but
          pixel-measurement of the source image showed the disputed object's centerline
          sits within 0.2% of the base's centerline — the majority's "omit" is correct
          per the prompt's own centering rule, not a bug. Left unchanged at 70%.
    """)
    (OUTPUT_ROOT / "cross_magnitude_comparison.md").write_text(comp_md, encoding="utf-8")
    print(f"\n→ Cross-magnitude table: {OUTPUT_ROOT}/cross_magnitude_comparison.md")
    print(f"→ Overall avg accuracy: {overall_avg:.1f}%")


if __name__ == "__main__":
    main()
