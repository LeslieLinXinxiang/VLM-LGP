#!/usr/bin/env python3
"""Build the manual-review index for the VLM-MSGraph baseline (Track 1).

Walks experiments/evaluations/VLM/VLM-MSGraph_baseline/ and emits one record per
trial file, in grading order: cubeStacking (4..8 cubes) first, then FMB (3..5 objs) —
this is the order the reviewer asked to grade in.

Each record carries the parsed ordered_triples so the scorer UI does not have to
re-derive them, plus the input image path(s) the VLM was shown. FMB samples may have
1 or 2 images (all pngs in the sample dir are fed to the VLM, per
run_gemini_proposed_method_fmb_eval.py); cubeStacking has exactly one.

FINAL_JSON extraction is deliberately lenient: it first tries the strict
START/END-delimited block, then falls back to brace matching from FINAL_JSON_START,
then to an ordered_triples-array-only extraction. This is so a trial whose *paste*
was truncated (cube_n06_s02 at time of writing lost the tail of self_check_notes and
its END marker) is still gradeable on content. Format compliance is a separate
number, produced by validate_baseline_vlm_msgraph_format.py — never conflate the two.

Usage:
    python3 build_vlm_msgraph_review_index.py
"""
from __future__ import annotations

import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
EVAL_ROOT = ROOT / "experiments/evaluations/VLM/VLM-MSGraph_baseline"
INPUT_ROOT = ROOT / "experiments/inputs"
OUT_ROOT = ROOT / "experiments/outputs/VLM-MSGraph_baseline/accuracy_analysis"
INDEX_PATH = OUT_ROOT / "review_index.json"

# Grading order: cubeStacking first, then FMB (per reviewer's request).
BENCHMARK_ORDER = ["cubeStacking", "FMB"]


def _magnitude_sort_key(mag: str) -> int:
    m = re.search(r"\d+", mag)
    return int(m.group()) if m else 0


def extract_final_json(text: str):
    """Return (obj, mode) where mode records how much repair was needed:
    'strict' | 'brace_matched' | 'ordered_only' | None (nothing extractable)."""
    m = re.search(r"## FINAL_JSON_START\s*(.*?)\s*## FINAL_JSON_END", text, re.DOTALL)
    if m:
        try:
            return json.loads(m.group(1).strip()), "strict"
        except json.JSONDecodeError:
            pass

    # Fallback 1: brace-match forward from the START marker (handles a missing END
    # marker or trailing prose after the object).
    start = text.find("## FINAL_JSON_START")
    if start >= 0:
        tail = text[start + len("## FINAL_JSON_START"):]
        brace = tail.find("{")
        if brace >= 0:
            depth, in_str, esc = 0, False, False
            for i, ch in enumerate(tail[brace:], start=brace):
                if in_str:
                    if esc:
                        esc = False
                    elif ch == "\\":
                        esc = True
                    elif ch == '"':
                        in_str = False
                    continue
                if ch == '"':
                    in_str = True
                elif ch == "{":
                    depth += 1
                elif ch == "}":
                    depth -= 1
                    if depth == 0:
                        try:
                            return json.loads(tail[brace:i + 1]), "brace_matched"
                        except json.JSONDecodeError:
                            break

    # Fallback 2: pull out just the ordered_triples array — enough to grade content
    # when the object itself is truncated mid-string further down.
    m = re.search(r'"ordered_triples"\s*:\s*(\[.*?\])\s*,\s*"', text, re.DOTALL)
    if not m:
        m = re.search(r'"ordered_triples"\s*:\s*(\[.*?\])\s*\}', text, re.DOTALL)
    if m:
        try:
            ordered = json.loads(m.group(1))
        except json.JSONDecodeError:
            return None, None
        anchor = None
        am = re.search(r'"anchor_object"\s*:\s*"([^"]*)"', text)
        if am:
            anchor = am.group(1)
        raw = []
        rm = re.search(r'"raw_triples"\s*:\s*(\[.*?\])\s*,\s*"ordered_triples"', text, re.DOTALL)
        if rm:
            try:
                raw = json.loads(rm.group(1))
            except json.JSONDecodeError:
                raw = []
        return {
            "anchor_object": anchor,
            "raw_triples": raw,
            "ordered_triples": ordered,
            "self_check_notes": "[TRUNCATED IN SOURCE PASTE]",
        }, "ordered_only"

    return None, None


def _cube_images(magnitude: str, case_name: str) -> list[str]:
    p = INPUT_ROOT / "cubeStacking" / magnitude / f"{case_name}.png"
    return [str(p)] if p.exists() else []


def _fmb_images(magnitude: str, case_name: str) -> list[str]:
    d = INPUT_ROOT / "FMB" / magnitude / case_name
    if not d.is_dir():
        return []
    return [str(p) for p in sorted(d.glob("*.png"))]


def main() -> None:
    records = []
    for benchmark in BENCHMARK_ORDER:
        bench_dir = EVAL_ROOT / benchmark
        if not bench_dir.is_dir():
            print(f"WARNING: missing benchmark dir {bench_dir}")
            continue
        for mag_dir in sorted(
            (d for d in bench_dir.iterdir() if d.is_dir()),
            key=lambda d: _magnitude_sort_key(d.name),
        ):
            for case_dir in sorted(d for d in mag_dir.iterdir() if d.is_dir()):
                for md in sorted(case_dir.glob("trial_*.md")):
                    trial = int(re.search(r"trial_(\d+)", md.stem).group(1))
                    text = md.read_text(encoding="utf-8")
                    obj, mode = extract_final_json(text)
                    images = (
                        _cube_images(mag_dir.name, case_dir.name)
                        if benchmark == "cubeStacking"
                        else _fmb_images(mag_dir.name, case_dir.name)
                    )
                    if not images:
                        print(f"WARNING: no input image found for {benchmark}/{mag_dir.name}/{case_dir.name}")
                    records.append({
                        "key": f"{benchmark}/{mag_dir.name}/{case_dir.name}/trial_{trial:02d}",
                        "benchmark": benchmark,
                        "magnitude": mag_dir.name,
                        "case_name": case_dir.name,
                        "trial": trial,
                        "md_path": str(md),
                        "image_paths": images,
                        "parse_mode": mode,
                        "anchor_object": (obj or {}).get("anchor_object"),
                        "ordered_triples": (obj or {}).get("ordered_triples", []),
                        "raw_triples": (obj or {}).get("raw_triples", []),
                        "self_check_notes": (obj or {}).get("self_check_notes"),
                    })

    OUT_ROOT.mkdir(parents=True, exist_ok=True)
    INDEX_PATH.write_text(json.dumps(records, indent=2, ensure_ascii=False), encoding="utf-8")

    by_mode = {}
    for r in records:
        by_mode[r["parse_mode"]] = by_mode.get(r["parse_mode"], 0) + 1
    print(f"Indexed {len(records)} trials -> {INDEX_PATH}")
    for mode, n in sorted(by_mode.items(), key=lambda kv: str(kv[0])):
        print(f"  FINAL_JSON extraction '{mode}': {n}")
    for r in records:
        if r["parse_mode"] != "strict":
            print(f"  ! {r['key']}: extraction mode = {r['parse_mode']}")
        if not r["ordered_triples"]:
            print(f"  !! {r['key']}: NO ordered_triples extracted — not gradeable")


if __name__ == "__main__":
    main()
