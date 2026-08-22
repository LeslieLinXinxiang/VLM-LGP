#!/usr/bin/env python3
"""
Format validator for prompts/baseline_vlm_msgraph_style_v1.md output.

This checks *schema and rule compliance* only — it has no ground truth and makes no
claim about whether the triples correctly describe the target image. It answers a
narrower, GT-free question: "is this a well-formed instance of what the prompt asked
for?" A sample that fails here is definitely wrong; a sample that passes is merely not
yet known to be wrong.

Schema note: one placement action = one ordered_triples row, always. "object" is a
string for a single-supporter object, or an array of strings for a bridging object
resting on several supporters at once — never split one object's supporters across
multiple rows/step numbers (this was a real, confirmed design bug in an earlier prompt
revision: giving a bridging object "position" on an edge it didn't need one on, because
the rule checked "does this edge's target have other children" instead of "does this
row's *complete* supporter set tie with another row's").

Checks (each tagged with the prompt section it enforces):
  - FINAL_JSON block present and parses                                  [format]
  - Top-level keys: anchor_object, raw_triples, ordered_triples,
    self_check_notes — no more, no less                                  [Sec 5]
  - Every raw_triple has exactly {subject, predicate, object, source},
    source in {relation_narrator, image_narrator}                        [Sec 5]
  - Every ordered_triple has exactly {step, subject, predicate, object}
    plus optional {position}, as real key:value pairs — not a bracket
    tuple copied from REASONING_DRAFT (the single most common failure
    in testing so far); "object" is a string or a non-empty array of
    strings                                                              [Sec 5]
  - "position" values are only left/right/front/back/center — never the
    triple-predicate words above/below/on/adjacent_to                    [Sec 2]
  - ordered_triples 'step' values are unique and sequential 1..N, one
    per row — no repeats (a bridging object gets ONE row with an array
    "object", not one row per supporter)                                 [Sec 3 Action Narrator]
  - Every subject appears as the subject of exactly one ordered_triples
    row — a second row for the same subject is the lateral-relation-to-
    attach_to bug, or a bridging object that should have been merged
    into one row with an array "object"                                  [Sec 3 Action Narrator]
  - Every predicate is in the Section 2 vocabulary                       [Sec 2]
  - ordered_triples predicates are action verbs only (spatial predicates
    like "on"/"above" must have been converted by the Action Narrator)   [Sec 3 Action Narrator]
  - Every 'on' relation recorded in raw_triples for a subject (a
    bridging object may have several) appears in that subject's
    ordered_triples "object" (string or array) — a dropped support
    edge is a content bug                                                [Sec 3 Action Narrator]
  - Executability, checked by supporter-SET ties: group ordered_triples
    rows by their complete "object" set; only rows whose set is shared
    by 2+ rows need "position" (and those values must be pairwise
    distinct within the tied group) — a row with a unique supporter set,
    even a bridging one that partially overlaps another row's, must NOT
    carry "position"                                                     [Sec 3 Action Narrator]
  - anchor_object never appears as a subject in ordered_triples (nothing
    attaches the anchor to anything)                                     [Sec 3 Triple Extractor]
  - Instance naming: if the same object name (post "_<index>" stripping)
    appears with two different indices for what raw_triples imply is one
    physical instance, or a bare type name is used alongside indexed
    variants of the same type, flag it                                   [Sec 1 instance-naming rule]
  - REASONING_DRAFT has all five role headers, in order                  [Sec 3 / Sec 5]

Usage:
    python3 validate_baseline_vlm_msgraph_format.py <file_or_dir> [...]

Each argument may be a single .md/.txt file (one VLM response) or a directory (all
.md/.txt files in it, non-recursive). Prints a per-file PASS/FAIL with reasons, then a
summary count.
"""
import json
import re
import sys
from pathlib import Path

SPATIAL_PREDICATES = {"above", "below", "left", "right", "front", "back", "on", "adjacent_to"}
ACTION_PREDICATES = {"attach_to", "screw", "insert", "wrap", "go_through"}
ALL_PREDICATES = SPATIAL_PREDICATES | ACTION_PREDICATES
# "position" (Sec 2/3) is a qualifier on an ordered_triples entry, not a triple
# predicate, and is NOT the same set as SPATIAL_PREDICATES: "above"/"below"/"on"/
# "adjacent_to" disambiguate nothing among objects sharing a tied supporter set (being
# above/touching the supporter is already implied by the attach_to row itself), so
# they are not valid position values. "center" is the reverse case: valid only as a
# position value, never as a standalone triple predicate.
POSITION_VALUES = {"left", "right", "front", "back", "center"}

REQUIRED_ROLE_HEADERS = [
    "Relation Narrator",
    "Image Narrator",
    "Base Searcher",
    "Action Narrator",
    "Triple Extractor",
]

INSTANCE_SUFFIX_RE = re.compile(r"^(.*)_(\d+)$")


def extract_final_json(text: str):
    m = re.search(r"## FINAL_JSON_START\s*(.*?)\s*## FINAL_JSON_END", text, re.DOTALL)
    if not m:
        return None, "no ## FINAL_JSON_START / ## FINAL_JSON_END block found"
    raw = m.group(1).strip()
    try:
        return json.loads(raw), None
    except json.JSONDecodeError as e:
        return None, f"FINAL_JSON does not parse: {e}"


def check_reasoning_draft(text: str, errors: list):
    if "## REASONING_DRAFT" not in text:
        errors.append("[format] missing '## REASONING_DRAFT' section")
        return
    draft = text.split("## REASONING_DRAFT", 1)[1]
    if "## FINAL_JSON_START" in draft:
        draft = draft.split("## FINAL_JSON_START", 1)[0]
    last_pos = -1
    for role in REQUIRED_ROLE_HEADERS:
        pos = draft.find(role)
        if pos == -1:
            errors.append(f"[Sec 3] REASONING_DRAFT missing role section: '{role}'")
            continue
        if pos < last_pos:
            errors.append(f"[Sec 3] role '{role}' appears out of the mandated order")
        last_pos = pos


def check_top_level_schema(obj, errors: list):
    if not isinstance(obj, dict):
        errors.append("[Sec 5] FINAL_JSON root is not an object")
        return
    expected = {"anchor_object", "raw_triples", "ordered_triples", "self_check_notes"}
    actual = set(obj.keys())
    missing = expected - actual
    extra = actual - expected
    if missing:
        errors.append(f"[Sec 5] FINAL_JSON missing top-level keys: {sorted(missing)}")
    if extra:
        errors.append(f"[Sec 5] FINAL_JSON has unexpected top-level keys: {sorted(extra)}")
    if "anchor_object" in obj and not isinstance(obj["anchor_object"], str):
        errors.append("[Sec 5] 'anchor_object' is not a string")


def object_set(value):
    """Normalize an ordered_triples 'object' field (string or list of strings) into a
    frozenset for set-equality comparisons. Returns None if malformed."""
    if isinstance(value, str):
        return frozenset({value})
    if isinstance(value, list) and value and all(isinstance(v, str) for v in value):
        return frozenset(value)
    return None


def check_triple_list(triples, kind: str, errors: list):
    """kind is 'raw' or 'ordered'; each has a different required key set."""
    if not isinstance(triples, list):
        errors.append(f"[Sec 5] '{kind}_triples' is not a list")
        return []
    required_keys = (
        {"subject", "predicate", "object", "source"} if kind == "raw"
        else {"step", "subject", "predicate", "object"}
    )
    # "position" is optional on ordered_triples entries — required only when this row's
    # complete supporter set ties with another row's (checked in check_position_ties).
    optional_keys = set() if kind == "raw" else {"position"}
    parsed = []
    for i, t in enumerate(triples):
        label = f"{kind}_triples[{i}]"
        if not isinstance(t, dict):
            errors.append(f"[Sec 5] {label} is not an object")
            continue
        actual_keys = set(t.keys())
        missing = required_keys - actual_keys
        extra = actual_keys - required_keys - optional_keys
        if missing:
            errors.append(f"[Sec 5] {label} missing keys {sorted(missing)} (has {sorted(actual_keys)})")
        if extra:
            errors.append(f"[Sec 5] {label} has stray/unexpected keys {sorted(extra)} — "
                           f"likely a mistyped key replacing one of {sorted(required_keys)}")
        if kind == "ordered" and "position" in t and t["position"] not in POSITION_VALUES:
            errors.append(f"[Sec 5] {label} 'position' value '{t['position']}' is not one of "
                           f"the allowed position values {sorted(POSITION_VALUES)}")
        if kind == "ordered" and "object" in t and object_set(t["object"]) is None:
            errors.append(f"[Sec 5] {label} 'object' must be a string or a non-empty array "
                           f"of strings, got {t['object']!r}")
        pred = t.get("predicate")
        if pred is not None and pred not in ALL_PREDICATES:
            errors.append(f"[Sec 2] {label} predicate '{pred}' is outside the allowed vocabulary")
        if kind == "raw":
            src = t.get("source")
            if src is not None and src not in {"relation_narrator", "image_narrator"}:
                errors.append(f"[Sec 5] {label} source '{src}' must be 'relation_narrator' or 'image_narrator'")
        if kind == "ordered":
            if pred is not None and pred in SPATIAL_PREDICATES:
                errors.append(f"[Sec 3] {label} uses spatial predicate '{pred}' — Action Narrator must "
                               f"convert every ordered_triples entry to an action verb")
        parsed.append(t)
    return parsed


def check_step_numbering(ordered, errors: list):
    """One row per placement action: 'step' values must be unique and sequential
    1..N, one per row. A bridging object's several supporters belong in one row's
    array 'object', never spread across several rows/steps (Sec 3, Sec 4 rule 6)."""
    steps = [t.get("step") for t in ordered if isinstance(t, dict) and "step" in t]
    if not steps:
        return
    expected = list(range(1, len(steps) + 1))
    if steps != expected:
        errors.append(f"[Sec 3] ordered_triples 'step' values are {steps}, expected "
                       f"unique sequential {expected} — one row per object, never repeated "
                       f"(a bridging object's supporters belong in one row's array "
                       f"'object', not spread across several rows)")


def check_duplicate_subjects(ordered, errors: list):
    """Every subject must appear as the subject of exactly one ordered_triples row —
    its complete supporter set belongs in that one row's 'object' (string or array).
    A second row for the same subject is either the lateral-relation-to-attach_to bug
    (a left/right/front/back/adjacent_to triple wrongly promoted to its own action
    step) or a bridging object that was incorrectly split across rows instead of
    merged into one row with an array 'object' (Sec 4 rule 6)."""
    subjects = {}
    for i, t in enumerate(ordered):
        if not isinstance(t, dict):
            continue
        s = t.get("subject")
        if s is None:
            continue
        subjects.setdefault(s, []).append((i, t.get("object")))
    for s, occurrences in subjects.items():
        if len(occurrences) > 1:
            objs = [o for _, o in occurrences]
            errors.append(f"[Sec 3] '{s}' appears as subject in {len(occurrences)} separate "
                           f"ordered_triples rows (objects {objs}) — every object gets exactly "
                           f"one row; if all of these are genuine supporters, merge them into "
                           f"one row with an array 'object', otherwise delete the spurious one")


def check_ordered_matches_on_relation(raw, ordered, errors: list):
    """Cross-check ordered_triples against raw_triples' unambiguous support evidence.

    'on' is the one spatial predicate that unambiguously names what an object
    physically rests on — including a genuine bridging object, which may have *several*
    'on' triples (one per real supporter, all belonging in that object's one row as an
    array). Every 'on' object recorded in raw_triples for a subject must appear in that
    subject's ordered_triples row — dropping one (typically because a lateral
    `left`/`right`/`front`/`back`/`adjacent_to` triple got converted to attach_to
    instead, replacing rather than joining the real edge) is a content bug that
    check_duplicate_subjects cannot catch when the wrong edge fully replaces the right
    one rather than sitting alongside it."""
    on_objects_of = {}
    for t in raw:
        if not isinstance(t, dict) or t.get("predicate") != "on":
            continue
        s = t.get("subject")
        on_objects_of.setdefault(s, set()).add(t.get("object"))

    ordered_objects_by_subject = {}
    for t in ordered:
        if not isinstance(t, dict):
            continue
        s = t.get("subject")
        if s is None:
            continue
        os = object_set(t.get("object"))
        if os is not None:
            ordered_objects_by_subject.setdefault(s, set()).update(os)

    for s, on_objs in on_objects_of.items():
        if s not in ordered_objects_by_subject:
            continue  # missing-object case is caught elsewhere (Sec 4 rule 5 territory)
        missing = on_objs - ordered_objects_by_subject[s]
        if missing:
            errors.append(f"[Sec 3] raw_triples records '{s}' on {sorted(on_objs)}, but "
                           f"ordered_triples' row for '{s}' is missing {sorted(missing)} "
                           f"(has {sorted(ordered_objects_by_subject[s])}) — a real supporting "
                           f"relation was dropped, likely replaced by a lateral relation "
                           f"(left/right/front/back/adjacent_to) wrongly converted to attach_to")


def check_position_ties(ordered, errors: list):
    """Executability check, by supporter-SET ties (not by single shared supporter):
    group ordered_triples rows by their *complete* 'object' set. Two different bridging
    rows that merely overlap by one member (e.g. {P,Q} and {Q,R}) are NOT tied — each
    set is already unique and needs no 'position'. Only rows whose supporter set is
    identical to another row's are a genuine tie and need 'position', pairwise distinct
    within that tied group. Confirmed real bug this replaces: an earlier version of this
    check triggered on "does this row's supporter overlap any other row's" instead of
    "is this row's full set duplicated elsewhere", wrongly demanding 'position' on two
    bridging objects whose supporter combinations were already unique (their sets
    differed) — see prompt Section 3's worked examples."""
    by_set = {}
    for i, t in enumerate(ordered):
        if not isinstance(t, dict):
            continue
        os = object_set(t.get("object"))
        if os is None:
            continue
        by_set.setdefault(os, []).append((i, t))

    for supporter_set, entries in by_set.items():
        if len(entries) < 2:
            # Unique supporter set: 'position' must be absent (Sec 4 rule 8).
            i, t = entries[0]
            if t.get("position"):
                errors.append(f"[Sec 3] ordered_triples[{i}] (subject '{t.get('subject')}') "
                               f"has 'position'={t['position']!r} but its supporter set "
                               f"{sorted(supporter_set)} is not tied with any other row — "
                               f"nothing to disambiguate, remove 'position'")
            continue

        missing = [t.get("subject") for i, t in entries if not t.get("position")]
        if missing:
            errors.append(f"[Sec 3] {len(entries)} rows tie on supporter set "
                           f"{sorted(supporter_set)} ({missing} have no 'position') — output "
                           f"is topologically plausible but not executable without it "
                           f"(which one goes where?)")
            continue

        values = [t.get("position") for i, t in entries]
        dupes = {v for v in values if values.count(v) > 1}
        if dupes:
            clash = {v: [t.get("subject") for i, t in entries if t.get("position") == v]
                     for v in dupes}
            errors.append(f"[Sec 3] rows tied on supporter set {sorted(supporter_set)} have "
                           f"duplicate 'position' values: {clash} — two objects cannot occupy "
                           f"the same slot; the one between two others should be 'center'")


def check_anchor_never_subject(obj, ordered, errors: list):
    anchor = obj.get("anchor_object")
    if not isinstance(anchor, str):
        return
    for i, t in enumerate(ordered):
        if isinstance(t, dict) and t.get("subject") == anchor:
            errors.append(f"[Sec 3] anchor_object '{anchor}' appears as subject in "
                           f"ordered_triples[{i}] — the anchor should never need to attach to anything")


def check_instance_naming(raw, ordered, errors: list):
    """Flag a bare type name used alongside indexed instances of the same type, or an
    instance implied to carry two different indices (best-effort heuristic — this can't
    know the true part list quantity, so it only flags internally inconsistent usage)."""
    names = set()
    for t in raw:
        if not isinstance(t, dict):
            continue
        for key in ("subject", "object"):
            v = t.get(key)
            if isinstance(v, str):
                names.add(v)
    for t in ordered:
        if not isinstance(t, dict):
            continue
        v = t.get("subject")
        if isinstance(v, str):
            names.add(v)
        os = object_set(t.get("object"))
        if os is not None:
            names.update(os)

    by_type = {}
    for n in names:
        m = INSTANCE_SUFFIX_RE.match(n)
        base = m.group(1) if m else n
        by_type.setdefault(base, set()).add(n)

    for base, variants in by_type.items():
        has_bare = base in variants
        has_indexed = any(v != base for v in variants)
        if has_bare and has_indexed:
            errors.append(f"[Sec 1] mixed bare and indexed names for type '{base}': "
                           f"{sorted(variants)} — quantity>1 objects must always use the "
                           f"indexed form, never the bare type name")


def validate_file(path: Path):
    text = path.read_text(encoding="utf-8")
    errors = []

    check_reasoning_draft(text, errors)

    obj, parse_err = extract_final_json(text)
    if parse_err:
        errors.append(f"[format] {parse_err}")
        return errors  # nothing further to check without a parsed object

    check_top_level_schema(obj, errors)
    raw = check_triple_list(obj.get("raw_triples", []), "raw", errors)
    ordered = check_triple_list(obj.get("ordered_triples", []), "ordered", errors)
    check_step_numbering(ordered, errors)
    check_duplicate_subjects(ordered, errors)
    check_ordered_matches_on_relation(raw, ordered, errors)
    check_position_ties(ordered, errors)
    check_anchor_never_subject(obj, ordered, errors)
    check_instance_naming(raw, ordered, errors)

    return errors


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)

    files = []
    for arg in sys.argv[1:]:
        p = Path(arg)
        if p.is_dir():
            files.extend(sorted(p.glob("*.md")) + sorted(p.glob("*.txt")))
        elif p.is_file():
            files.append(p)
        else:
            print(f"WARNING: '{arg}' is not a file or directory, skipping")

    if not files:
        print("No files to validate.")
        sys.exit(1)

    n_pass, n_fail, n_warn = 0, 0, 0
    for f in files:
        errors = validate_file(f)
        hard_errors = [e for e in errors if not e.startswith("[WARN]")]
        warnings = [e for e in errors if e.startswith("[WARN]")]
        if hard_errors:
            n_fail += 1
            print(f"\n❌ FAIL  {f}")
            for e in hard_errors:
                print(f"    - {e}")
            for w in warnings:
                print(f"    ! {w}")
        else:
            n_pass += 1
            if warnings:
                n_warn += 1
                print(f"\n⚠️  PASS (with warnings)  {f}")
                for w in warnings:
                    print(f"    ! {w}")
            else:
                print(f"✅ PASS  {f}")

    total = n_pass + n_fail
    rate = (n_pass / total * 100) if total else 0.0
    print(f"\n{'=' * 60}")
    print(f"Format compliance: {n_pass}/{total} ({rate:.1f}%)  ({n_warn} pass-with-warning)")


if __name__ == "__main__":
    main()
