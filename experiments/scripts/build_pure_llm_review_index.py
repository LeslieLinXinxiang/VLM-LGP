#!/usr/bin/env python3
"""Build review index for manual scoring of pure LLM baseline outputs."""
from __future__ import annotations

import argparse
import json
import re
from dataclasses import dataclass, asdict
from pathlib import Path
from typing import List, Optional

ROOT = Path(__file__).resolve().parents[2]
EVAL_ROOT = ROOT / "experiments/evaluations/VLM/pure_llm_baseline"
OUT_ROOT = ROOT / "experiments/outputs/pure_llm_baseline/accuracy_analysis/cubeStacking"
OUT_INDEX_JSON = OUT_ROOT / "review_index.json"
OUT_INDEX_JSONL = OUT_ROOT / "review_index.jsonl"

RE_IMAGE = re.compile(r"\*\*Input Image\*\*:\s*`([^`]+)`")
RE_SCENE = re.compile(r"\*\*Input Scene\*\*:\s*`([^`]+)`")
RE_RAW_BLOCK = re.compile(r"##\s+VLM Raw Response.*?```(?:xml)?\s*(.*?)\s*```", re.DOTALL)
RE_TRIAL = re.compile(r"trial_(\d{2})_(nr|r)\.md$")
RE_CASE = re.compile(r"cube_n\d{2}_s\d{2}")


@dataclass
class ReviewRecord:
    key: str
    magnitude: str
    scenario: str
    case_name: str
    trial: int
    variant: str
    md_path: str
    image_path: str
    scene_path: str
    raw_response_excerpt: str


def _extract(text: str, pattern: re.Pattern[str]) -> Optional[str]:
    m = pattern.search(text)
    return m.group(1).strip() if m else None


def _scene_to_case_name(scene_path: str) -> str:
    m = RE_CASE.search(scene_path)
    if m:
        return m.group(0)
    # fallback from folder naming
    parts = Path(scene_path).parts
    try:
        mag = next(p for p in parts if p.endswith("cubes"))
        scen = next(p for p in parts if re.fullmatch(r"s\d{2}", p))
        n = int(mag.replace("cubes", ""))
        return f"cube_n{n:02d}_{scen}"
    except StopIteration:
        return "unknown_case"


def _read_record(md_path: Path) -> Optional[ReviewRecord]:
    trial_m = RE_TRIAL.search(md_path.name)
    if not trial_m:
        return None
    trial = int(trial_m.group(1))
    variant = trial_m.group(2)

    try:
        text = md_path.read_text(encoding="utf-8")
    except Exception:
        return None

    image_rel = _extract(text, RE_IMAGE) or ""
    scene_rel = _extract(text, RE_SCENE) or ""
    raw_block = _extract(text, RE_RAW_BLOCK) or ""
    raw_excerpt = re.sub(r"\s+", " ", raw_block).strip()[:700]

    image_abs = (ROOT / image_rel).resolve() if image_rel else Path("")
    scene_abs = (ROOT / scene_rel).resolve() if scene_rel else Path("")

    try:
        magnitude = md_path.relative_to(EVAL_ROOT).parts[0]
        scenario = md_path.relative_to(EVAL_ROOT).parts[1]
    except Exception:
        magnitude = "unknown"
        scenario = "unknown"

    case_name = _scene_to_case_name(scene_rel)
    key = f"{magnitude}/{scenario}/trial_{trial:02d}_{variant}"

    return ReviewRecord(
        key=key,
        magnitude=magnitude,
        scenario=scenario,
        case_name=case_name,
        trial=trial,
        variant=variant,
        md_path=str(md_path),
        image_path=str(image_abs),
        scene_path=str(scene_abs),
        raw_response_excerpt=raw_excerpt,
    )


def build_index() -> List[ReviewRecord]:
    records: List[ReviewRecord] = []
    md_files = sorted(EVAL_ROOT.glob("*cubes/s*/trial_*_*.md"))
    for md_path in md_files:
        rec = _read_record(md_path)
        if rec:
            records.append(rec)

    records.sort(key=lambda r: (r.magnitude, r.scenario, r.trial, 0 if r.variant == "nr" else 1))
    return records


def save_index(records: List[ReviewRecord]) -> None:
    OUT_ROOT.mkdir(parents=True, exist_ok=True)
    payload = [asdict(r) for r in records]
    OUT_INDEX_JSON.write_text(json.dumps(payload, indent=2, ensure_ascii=False), encoding="utf-8")

    with OUT_INDEX_JSONL.open("w", encoding="utf-8") as f:
        for rec in payload:
            f.write(json.dumps(rec, ensure_ascii=False) + "\n")


def main() -> None:
    parser = argparse.ArgumentParser(description="Build review index for pure LLM baseline markdown outputs.")
    parser.parse_args()

    records = build_index()
    save_index(records)

    print(f"Index records: {len(records)}")
    print(f"Saved JSON:  {OUT_INDEX_JSON}")
    print(f"Saved JSONL: {OUT_INDEX_JSONL}")


if __name__ == "__main__":
    main()
