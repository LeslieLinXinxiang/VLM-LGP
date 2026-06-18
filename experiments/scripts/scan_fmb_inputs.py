#!/usr/bin/env python3
"""Read-only auditor for FMB input chains.

Checks the full chain:
  1) VLM markdown (`trial_XX.md`)
  2) Scene file (`trial_XX_{nr|r}.g`)
  3) Generated task files (`step_*.lgp` and matching `step_*.fol`)

Reports only two severities:
  - FATAL
  - INFO

Output is written to a timestamped directory under
`experiments/outputs/fmb_input_audit/` by default.
"""

from __future__ import annotations

import argparse
import csv
import json
import re
from collections import Counter, defaultdict
from dataclasses import asdict, dataclass, field
from datetime import datetime
from pathlib import Path
from typing import Any, Iterable


ROOT_DIR = Path(__file__).resolve().parents[2]
VLM_BASE = ROOT_DIR / "experiments/evaluations/VLM/gemini_proposed_method/FMB"
SCENE_BASE = ROOT_DIR / "experiments/scenes/fmb"
LGP_BASE = ROOT_DIR / "experiments/evaluations/LGP/FMB"
DEFAULT_OUT_BASE = ROOT_DIR / "experiments/outputs/fmb_input_audit"


FINAL_JSON_FENCED_RE = re.compile(
    r"## FINAL_JSON_START\s*```(?:json)?\n(.*?)\n```\s*## FINAL_JSON_END",
    re.DOTALL,
)
FINAL_JSON_RAW_RE = re.compile(r"## FINAL_JSON_START\s*(\{.*?\})\s*## FINAL_JSON_END", re.DOTALL)
SCENE_LINE_RE = re.compile(r"^([A-Za-z_][\w]*)\s*\(([^)]*)\)\s*\{(.*)\}\s*$")
LOGICAL_RE = re.compile(r"logical\s*:\s*\{([^}]*)\}", re.IGNORECASE)
TRANSLATION_RE = re.compile(r'Q:\s*"[^"]*t\(([^)]+)\)"', re.IGNORECASE)
SIZE_RE = re.compile(r"size\s*:\s*\[([^\]]+)\]", re.IGNORECASE)
STEP_LGP_RE = re.compile(r"^step_(\d+)_batch_(\d+)\.lgp$")
STEP_FOL_RE = re.compile(r"^step_(\d+)_batch_(\d+)\.fol$")
OBJECT_TOKEN_RE = re.compile(r"\b(?:shape_[A-Za-z0-9_]+|Table_[A-Za-z0-9_]+|base_board|table)\b")

SUPPORT_NAME_EXACT = {"table", "base_board"}
SUPPORT_NAME_PREFIXES = ("Table_",)
TASK_AUX_SUFFIXES = ("_mesh", "_handle", "_marker")
BASE_OBJECT_NAMES = {"base", "table", "support", "background", "scene", "world"}
FMB_MIN_CENTER_DISTANCE = 0.12


@dataclass
class Issue:
    severity: str
    category: str
    trial_tag: str
    stage: str
    message: str
    path: str | None = None
    evidence: dict[str, Any] = field(default_factory=dict)


@dataclass
class TrialAudit:
    trial_tag: str
    mag: str
    scenario: str
    trial_idx: int
    mode: str
    policy: str = ""
    md_path: str | None = None
    scene_path: str | None = None
    lgp_dir: str | None = None
    status: str = "UNKNOWN"
    issues: list[Issue] = field(default_factory=list)
    expected_objects: list[dict[str, Any]] = field(default_factory=list)
    scene_objects: list[dict[str, Any]] = field(default_factory=list)
    lgp_files: list[str] = field(default_factory=list)


@dataclass
class SceneAudit:
    scene_tag: str
    mag: str
    scenario: str
    trial_idx: int
    mode: str
    scene_path: str
    md_exists: bool
    md_path: str | None
    expected_count: int = 0
    actual_count: int = 0
    issues: list[dict[str, Any]] = field(default_factory=list)


def normalize_name(name: str) -> str:
    text = re.sub(r"[^a-zA-Z0-9]+", "_", name.lower()).strip("_")
    return re.sub(r"_+", "_", text)


def parse_float_triplet(raw: str) -> tuple[float, float, float] | None:
    parts = [p for p in raw.replace(",", " ").split() if p]
    if len(parts) < 3:
        return None
    try:
        return float(parts[0]), float(parts[1]), float(parts[2])
    except ValueError:
        return None


def parse_final_json(md_path: Path) -> dict[str, Any]:
    content = md_path.read_text(encoding="utf-8")
    match = FINAL_JSON_FENCED_RE.search(content)
    if not match:
        match = FINAL_JSON_RAW_RE.search(content)
    if not match:
        raise ValueError(f"No FINAL_JSON block in {md_path}")
    return json.loads(match.group(1))


def build_expected_scene_objects(md_json: dict[str, Any], mode: str) -> tuple[list[dict[str, Any]], dict[str, list[str]]]:
    raw_objects = md_json.get("objects", [])
    grouped: dict[str, list[dict[str, Any]]] = defaultdict(list)
    expected: list[dict[str, Any]] = []
    redundancy_factor = 2 if mode == "r" else 1

    for obj in raw_objects:
        if not isinstance(obj, dict):
            continue
        obj_id = obj.get("id")
        obj_name = str(obj.get("object", "")).strip()
        base_name = normalize_name(obj_name)
        if not base_name or base_name in BASE_OBJECT_NAMES:
            continue
        grouped[base_name].append({"id": obj_id, "object": obj_name, "raw": obj})

    families: dict[str, list[str]] = {}
    for base_name, items in grouped.items():
        items_sorted = sorted(items, key=lambda x: (x.get("id", 0), normalize_name(str(x.get("object", "")))))
        expanded_count = len(items_sorted) * redundancy_factor
        names = [f"{base_name}_{idx}" for idx in range(1, expanded_count + 1)]
        families[base_name] = names
        for idx in range(1, expanded_count + 1):
            item = items_sorted[(idx - 1) % len(items_sorted)]
            expected.append(
                {
                    "family": base_name,
                    "index": idx,
                    "expected_name": f"{base_name}_{idx}",
                    "md_id": item.get("id"),
                    "md_object": item.get("object"),
                    "redundancy_factor": redundancy_factor,
                }
            )

    expected.sort(key=lambda x: (x["family"], x["index"], x.get("md_id", 0)))
    return expected, families


def is_task_object(name: str) -> bool:
    if name in SUPPORT_NAME_EXACT:
        return False
    if any(name.startswith(prefix) for prefix in SUPPORT_NAME_PREFIXES):
        return False
    if name.endswith(TASK_AUX_SUFFIXES):
        return False
    return True


def parse_scene_translation(body: str) -> tuple[float, float, float] | None:
    q_match = TRANSLATION_RE.search(body)
    if not q_match:
        return None
    return parse_float_triplet(q_match.group(1).strip())


def parse_scene_size(body: str) -> list[float]:
    m = SIZE_RE.search(body)
    if not m:
        return []
    parts = [p for p in m.group(1).replace(",", " ").split() if p]
    values: list[float] = []
    for p in parts:
        try:
            values.append(float(p))
        except ValueError:
            continue
    return values


def parse_scene_file(scene_path: Path) -> tuple[list[dict[str, Any]], list[dict[str, Any]]]:
    lines = scene_path.read_text(encoding="utf-8").splitlines()
    all_frames: list[dict[str, Any]] = []
    task_objects: list[dict[str, Any]] = []

    for line_no, raw_line in enumerate(lines, start=1):
        line = raw_line.strip()
        if not line or line.startswith("#"):
            continue
        m = SCENE_LINE_RE.match(line)
        if not m:
            continue

        name = m.group(1)
        parent = m.group(2).strip()
        body = m.group(3)
        logical_match = LOGICAL_RE.search(body)
        if not logical_match:
            continue

        logical_text = logical_match.group(1)
        logical_flags = [x.strip() for x in logical_text.split(",") if x.strip()]
        is_object = any(flag == "is_object" for flag in logical_flags)
        is_place = any(flag == "is_place" for flag in logical_flags)
        translation = parse_scene_translation(body)
        size_values = parse_scene_size(body)

        record = {
            "line_no": line_no,
            "name": name,
            "parent": parent,
            "logical_flags": logical_flags,
            "is_object": is_object,
            "is_place": is_place,
            "translation": translation,
            "size": size_values,
            "raw_line": raw_line.rstrip("\n"),
        }
        all_frames.append(record)

        if is_object and is_task_object(name):
            task_objects.append(record)

    return all_frames, task_objects


def compute_safe_distance_issues(task_objects: list[dict[str, Any]], min_center_distance: float = FMB_MIN_CENTER_DISTANCE) -> list[dict[str, Any]]:
    issues: list[dict[str, Any]] = []
    relevant = [obj for obj in task_objects if obj.get("translation")]
    for i in range(len(relevant)):
        a = relevant[i]
        ax, ay, az = a["translation"]
        for j in range(i + 1, len(relevant)):
            b = relevant[j]
            bx, by, bz = b["translation"]
            dx = ax - bx
            dy = ay - by
            center_dist = (dx * dx + dy * dy) ** 0.5
            if center_dist < min_center_distance:
                issues.append(
                    {
                        "category": "scene_safe_distance_violation",
                        "message": "Task objects are closer than the minimum center distance",
                        "evidence": {
                            "object_a": a["name"],
                            "object_b": b["name"],
                            "center_distance": round(center_dist, 4),
                            "min_center_distance": min_center_distance,
                            "delta_xy": [round(dx, 4), round(dy, 4)],
                            "delta_z": round(az - bz, 4),
                        },
                    }
                )
    return issues


def split_family_index(name: str) -> tuple[str, int | None]:
    m = re.match(r"^(.*?)(?:_([0-9]+))$", name)
    if not m:
        return name, None
    family = m.group(1)
    idx = int(m.group(2))
    return family, idx


def parse_lgp_dir(lgp_dir: Path, allowed_object_names: set[str]) -> dict[str, Any]:
    lgp_files = sorted(lgp_dir.glob("step_*_batch_*.lgp"))
    fol_files = sorted(lgp_dir.glob("step_*_batch_*.fol"))

    step_map: dict[int, dict[str, list[Path]]] = defaultdict(lambda: {"lgp": [], "fol": []})
    for path in lgp_files:
        m = STEP_LGP_RE.match(path.name)
        if m:
            step_map[int(m.group(1))]["lgp"].append(path)
    for path in fol_files:
        m = STEP_FOL_RE.match(path.name)
        if m:
            step_map[int(m.group(1))]["fol"].append(path)

    steps = sorted(step_map)
    batch_map: dict[int, list[int]] = {}
    issues: list[dict[str, Any]] = []

    if not steps:
        issues.append({"category": "lgp_missing", "message": f"No step_*.lgp files in {lgp_dir}"})
        return {
            "issues": issues,
            "lgp_files": [str(p) for p in lgp_files],
            "fol_files": [str(p) for p in fol_files],
            "step_map": {},
            "step_count": 0,
        }

    expected_steps = list(range(1, max(steps) + 1))
    if steps != expected_steps:
        missing = [s for s in expected_steps if s not in step_map]
        extra = [s for s in steps if s not in expected_steps]
        if missing:
            issues.append({
                "category": "lgp_step_gap",
                "message": f"Missing step numbers in {lgp_dir}: {missing}",
                "evidence": {"present_steps": steps},
            })
        if extra:
            issues.append({
                "category": "lgp_step_gap",
                "message": f"Unexpected step numbers in {lgp_dir}: {extra}",
                "evidence": {"present_steps": steps},
            })

    for step, files in sorted(step_map.items()):
        lgp_batches = sorted(int(STEP_LGP_RE.match(p.name).group(2)) for p in files["lgp"] if STEP_LGP_RE.match(p.name))
        fol_batches = sorted(int(STEP_FOL_RE.match(p.name).group(2)) for p in files["fol"] if STEP_FOL_RE.match(p.name))
        batch_map[step] = lgp_batches

        if not lgp_batches:
            issues.append({
                "category": "lgp_missing",
                "message": f"Step {step} has no .lgp files in {lgp_dir}",
            })
            continue

        expected_batches = list(range(1, max(lgp_batches) + 1))
        if lgp_batches != expected_batches:
            missing = [b for b in expected_batches if b not in lgp_batches]
            issues.append({
                "category": "lgp_batch_gap",
                "message": f"Missing batch numbers for step {step} in {lgp_dir}: {missing}",
                "evidence": {"present_batches": lgp_batches},
            })

        if fol_batches != lgp_batches:
            issues.append({
                "category": "lgp_fol_mismatch",
                "message": f".lgp/.fol batch mismatch for step {step} in {lgp_dir}",
                "evidence": {"lgp_batches": lgp_batches, "fol_batches": fol_batches},
            })

    for lgp_path in lgp_files:
        text = lgp_path.read_text(encoding="utf-8")
        refs = sorted(set(OBJECT_TOKEN_RE.findall(text)))
        bad_refs = [ref for ref in refs if ref not in allowed_object_names]
        if bad_refs:
            issues.append({
                "category": "lgp_unknown_object",
                "message": f"Unknown object references in {lgp_path.name}",
                "path": str(lgp_path),
                "evidence": {"bad_refs": bad_refs, "all_refs": refs},
            })
        if not refs:
            issues.append({
                "category": "lgp_empty_object_refs",
                "message": f"No object-like references found in {lgp_path.name}",
                "path": str(lgp_path),
            })

    for fol_path in fol_files:
        text = fol_path.read_text(encoding="utf-8")
        header = text.splitlines()[0].strip() if text.splitlines() else ""
        if header.startswith("fol:"):
            m = re.match(r"fol:\s*<([^>]+)>", header)
            if m and Path(m.group(1)).name != fol_path.name:
                issues.append({
                    "category": "fol_header_mismatch",
                    "message": f"FOL header does not match file name in {fol_path.name}",
                    "path": str(fol_path),
                    "evidence": {"header": header},
                })

    return {
        "issues": issues,
        "lgp_files": [str(p) for p in lgp_files],
        "fol_files": [str(p) for p in fol_files],
        "step_map": {str(step): {"lgp_batches": batches, "fol_batches": sorted(int(STEP_FOL_RE.match(p.name).group(2)) for p in step_map[step]["fol"] if STEP_FOL_RE.match(p.name))} for step, batches in batch_map.items()},
        "step_count": len(steps),
    }


def make_trial_tag(mag: str, scenario: str, trial_idx: int, mode: str, policy: str = "") -> str:
    base = f"{mag}/s{scenario}/trial_{trial_idx:02d}_{mode}"
    return f"{base}/{policy}" if policy else base


def add_issue(trial: TrialAudit, severity: str, category: str, stage: str, message: str, path: str | None = None, evidence: dict[str, Any] | None = None) -> None:
    trial.issues.append(
        Issue(
            severity=severity,
            category=category,
            trial_tag=trial.trial_tag,
            stage=stage,
            message=message,
            path=path,
            evidence=evidence or {},
        )
    )


def audit_trial(md_path: Path, scene_path: Path, lgp_dir: Path, mag: str, scenario: str, trial_idx: int, mode: str, policy: str = "") -> TrialAudit:
    trial_tag = make_trial_tag(mag, scenario, trial_idx, mode, policy)
    trial = TrialAudit(
        trial_tag=trial_tag,
        mag=mag,
        scenario=scenario,
        trial_idx=trial_idx,
        mode=mode,
        policy=policy,
        md_path=str(md_path) if md_path.exists() else None,
        scene_path=str(scene_path) if scene_path.exists() else None,
        lgp_dir=str(lgp_dir) if lgp_dir.exists() else None,
    )

    if not md_path.exists():
        add_issue(trial, "FATAL", "missing_md", "md", "Missing VLM markdown file", str(md_path))
        trial.status = "FATAL"
        return trial

    if not scene_path.exists():
        add_issue(trial, "FATAL", "missing_scene", "scene", "Missing scene file", str(scene_path))
    if not lgp_dir.exists():
        add_issue(trial, "FATAL", "missing_lgp_dir", "lgp", "Missing LGP output directory", str(lgp_dir))

    try:
        md_json = parse_final_json(md_path)
    except Exception as exc:
        add_issue(trial, "FATAL", "md_parse_error", "md", f"Failed to parse FINAL_JSON: {exc}", str(md_path))
        trial.status = "FATAL"
        return trial

    expected_objects, families = build_expected_scene_objects(md_json, mode)
    trial.expected_objects = expected_objects

    # MD family continuity.
    for family, names in families.items():
        expected = [f"{family}_{i}" for i in range(1, len(names) + 1)]
        if names != expected:
            add_issue(
                trial,
                "FATAL",
                "md_numbering_gap",
                "md",
                f"Non-contiguous numbering in FINAL_JSON family '{family}'",
                str(md_path),
                {"expected": expected, "actual": names},
            )

    all_frames: list[dict[str, Any]] = []
    task_objects: list[dict[str, Any]] = []
    if scene_path.exists():
        try:
            all_frames, task_objects = parse_scene_file(scene_path)
            trial.scene_objects = task_objects
        except Exception as exc:
            add_issue(trial, "FATAL", "scene_parse_error", "scene", f"Failed to parse scene file: {exc}", str(scene_path))

        expected_names = {item["expected_name"] for item in expected_objects}
        actual_names = {item["name"] for item in task_objects}
        actual_families: dict[str, list[int]] = defaultdict(list)
        for item in task_objects:
            family, idx = split_family_index(item["name"])
            if idx is not None:
                actual_families[family].append(idx)

        missing = sorted(expected_names - actual_names)
        extra = sorted(actual_names - expected_names)
        if missing:
            add_issue(
                trial,
                "FATAL",
                "scene_missing_objects",
                "scene",
                "Scene is missing expected task objects",
                str(scene_path),
                {"missing": missing, "expected": sorted(expected_names), "actual": sorted(actual_names)},
            )
        if extra:
            add_issue(
                trial,
                "FATAL",
                "scene_extra_objects",
                "scene",
                "Scene contains extra task objects not present in FINAL_JSON",
                str(scene_path),
                {"extra": extra, "expected": sorted(expected_names), "actual": sorted(actual_names)},
            )

        for family, indices in sorted(actual_families.items()):
            indices_sorted = sorted(indices)
            expected_indices = list(range(1, len(indices_sorted) + 1))
            if indices_sorted != expected_indices:
                add_issue(
                    trial,
                    "FATAL",
                    "scene_numbering_gap",
                    "scene",
                    f"Non-contiguous numbering in scene family '{family}'",
                    str(scene_path),
                    {"expected": expected_indices, "actual": indices_sorted},
                )

    allowed_names: set[str] = set()
    allowed_names.update(item["expected_name"] for item in expected_objects)
    for item in task_objects:
        allowed_names.add(item["name"])
    # Always allow common table/support frames.
    allowed_names.update(SUPPORT_NAME_EXACT)
    allowed_names.update({"Table_Left", "Table_Right", "Table_Front", "Table_Back", "Table_Center"})
    allowed_names.update({"l_panda_base"})

    if lgp_dir.exists():
        lgp_result = parse_lgp_dir(lgp_dir, allowed_names)
        trial.lgp_files = lgp_result["lgp_files"]

        for raw_issue in lgp_result["issues"]:
            add_issue(
                trial,
                "FATAL",
                raw_issue["category"],
                "lgp",
                raw_issue["message"],
                raw_issue.get("path"),
                raw_issue.get("evidence", {}),
            )

    # Cross-check expected task objects against LGP content.
    if lgp_dir.exists() and trial.lgp_files:
        combined_text = "\n".join(Path(p).read_text(encoding="utf-8") for p in trial.lgp_files if Path(p).exists())
        referenced_expected = [name for name in allowed_names if name in combined_text]
        if not referenced_expected:
            add_issue(
                trial,
                "FATAL",
                "lgp_no_scene_object_reference",
                "lgp",
                "No known scene object references found in task files",
                str(lgp_dir),
            )

    trial.status = "FATAL" if any(issue.severity == "FATAL" for issue in trial.issues) else "OK"
    return trial


def iter_trial_inputs(mags: list[str], scenarios: list[str], trials: list[int], modes: list[str]) -> Iterable[tuple[str, str, int, str, str, Path, Path, Path]]:
    for mag in mags:
        for scenario in scenarios:
            scen_id = f"s{scenario}"
            for trial_idx in trials:
                md_path = VLM_BASE / mag / scenario / f"trial_{trial_idx:02d}.md"
                for mode in modes:
                    scene_path = SCENE_BASE / mag / scen_id / "random_trials" / f"trial_{trial_idx:02d}_{mode}.g"
                    trial_root = LGP_BASE / mag / scen_id / f"trial_{trial_idx:02d}_{mode}"
                    subdirs = sorted([p for p in trial_root.glob("lgp_split_*") if p.is_dir()])
                    if subdirs:
                        for policy_dir in subdirs:
                            yield mag, scenario, trial_idx, mode, policy_dir.name, md_path, scene_path, policy_dir
                    elif (trial_root / "step_1_batch_1.lgp").exists():
                        yield mag, scenario, trial_idx, mode, trial_root.name, md_path, scene_path, trial_root


def ensure_dir(path: Path) -> None:
    path.mkdir(parents=True, exist_ok=True)


def iter_scene_files(mags: list[str], scenarios: list[str], trials: list[int], modes: list[str]) -> Iterable[tuple[str, str, int, str, Path]]:
    for mag in mags:
        for scenario in scenarios:
            scen_id = f"s{scenario}"
            for trial_idx in trials:
                for mode in modes:
                    scene_path = SCENE_BASE / mag / scen_id / "random_trials" / f"trial_{trial_idx:02d}_{mode}.g"
                    yield mag, scenario, trial_idx, mode, scene_path


def audit_scene_inventory(mags: list[str], scenarios: list[str], trials: list[int], modes: list[str]) -> list[SceneAudit]:
    audits: list[SceneAudit] = []
    for mag, scenario, trial_idx, mode, scene_path in iter_scene_files(mags, scenarios, trials, modes):
        scen_id = f"s{scenario}"
        scene_tag = f"{mag}/{scen_id}/trial_{trial_idx:02d}_{mode}"
        md_path = VLM_BASE / mag / scenario / f"trial_{trial_idx:02d}.md"
        issues: list[dict[str, Any]] = []
        expected_objects: list[dict[str, Any]] = []
        task_objects: list[dict[str, Any]] = []

        if not scene_path.exists():
            issues.append({"severity": "FATAL", "category": "missing_scene", "message": "Scene file missing"})

        mode_factor = 2 if mode == "r" else 1
        if md_path.exists():
            try:
                md_json = parse_final_json(md_path)
                expected_objects, _families = build_expected_scene_objects(md_json, mode)
            except Exception as exc:
                issues.append({"severity": "FATAL", "category": "md_parse_error", "message": f"Failed to parse FINAL_JSON: {exc}"})
        else:
            issues.append({"severity": "FATAL", "category": "missing_md", "message": "Matching VLM markdown missing"})

        if scene_path.exists():
            try:
                _all_frames, task_objects = parse_scene_file(scene_path)
            except Exception as exc:
                issues.append({"severity": "FATAL", "category": "scene_parse_error", "message": f"Failed to parse scene file: {exc}"})
                task_objects = []

        expected_names = {item["expected_name"] for item in expected_objects}
        actual_names = {item["name"] for item in task_objects}
        expected_count = len(expected_objects)
        actual_count = len(task_objects)

        if expected_objects and actual_count != expected_count:
            issues.append({
                "severity": "FATAL",
                "category": "scene_count_mismatch",
                "message": "Number of task objects in scene does not match FINAL_JSON expectation",
                "evidence": {"expected_count": expected_count, "actual_count": actual_count},
            })

        missing = sorted(expected_names - actual_names)
        extra = sorted(actual_names - expected_names)
        if missing:
            issues.append({
                "severity": "FATAL",
                "category": "scene_missing_objects",
                "message": "Scene is missing expected task objects",
                "evidence": {"missing": missing, "expected": sorted(expected_names), "actual": sorted(actual_names)},
            })
        if extra:
            issues.append({
                "severity": "FATAL",
                "category": "scene_extra_objects",
                "message": "Scene contains extra task objects not present in FINAL_JSON",
                "evidence": {"extra": extra, "expected": sorted(expected_names), "actual": sorted(actual_names)},
            })

        if task_objects:
            actual_families: dict[str, list[int]] = defaultdict(list)
            for item in task_objects:
                family, idx = split_family_index(item["name"])
                if idx is not None:
                    actual_families[family].append(idx)
            for family, indices in sorted(actual_families.items()):
                indices_sorted = sorted(indices)
                expected_indices = list(range(1, len(indices_sorted) + 1))
                if indices_sorted != expected_indices:
                    issues.append({
                        "severity": "FATAL",
                        "category": "scene_numbering_gap",
                        "message": f"Non-contiguous numbering in scene family '{family}'",
                        "evidence": {"expected": expected_indices, "actual": indices_sorted},
                    })

            issues.extend(compute_safe_distance_issues(task_objects, min_center_distance=FMB_MIN_CENTER_DISTANCE))

        audits.append(
            SceneAudit(
                scene_tag=scene_tag,
                mag=mag,
                scenario=scen_id,
                trial_idx=trial_idx,
                mode=mode,
                scene_path=str(scene_path),
                md_exists=md_path.exists(),
                md_path=str(md_path) if md_path.exists() else None,
                expected_count=expected_count,
                actual_count=actual_count,
                issues=issues,
            )
        )
    return audits


def write_report(output_dir: Path, audits: list[TrialAudit]) -> None:
    ensure_dir(output_dir)
    evidence_dir = output_dir / "evidence"
    logs_dir = output_dir / "logs"
    ensure_dir(evidence_dir)
    ensure_dir(logs_dir)

    issue_rows: list[dict[str, Any]] = []
    for audit in audits:
        for idx, issue in enumerate(audit.issues, start=1):
            issue_dict = asdict(issue)
            issue_rows.append(issue_dict)
            evidence_path = evidence_dir / f"{audit.trial_tag.replace('/', '__')}__{idx:03d}.json"
            evidence_path.write_text(json.dumps(issue_dict, indent=2), encoding="utf-8")

    summary = {
        "totals": {
            "trials": len(audits),
            "fatal_trials": sum(1 for a in audits if any(i.severity == "FATAL" for i in a.issues)),
            "ok_trials": sum(1 for a in audits if not a.issues),
            "fatal_issues": sum(1 for a in issue_rows if a["severity"] == "FATAL"),
            "info_issues": sum(1 for a in issue_rows if a["severity"] == "INFO"),
        },
        "audits": [asdict(a) for a in audits],
        "issues": issue_rows,
    }

    (output_dir / "report.json").write_text(json.dumps(summary, indent=2), encoding="utf-8")

    with (output_dir / "report.csv").open("w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=["severity", "category", "trial_tag", "stage", "path", "message"],
        )
        writer.writeheader()
        for row in issue_rows:
            writer.writerow({
                "severity": row["severity"],
                "category": row["category"],
                "trial_tag": row["trial_tag"],
                "stage": row["stage"],
                "path": row.get("path") or "",
                "message": row["message"],
            })

    md_lines: list[str] = []
    md_lines.append("# FMB Input Audit Report")
    md_lines.append("")
    md_lines.append(f"- Trials scanned: {summary['totals']['trials']}")
    md_lines.append(f"- OK trials: {summary['totals']['ok_trials']}")
    md_lines.append(f"- Fatal trials: {summary['totals']['fatal_trials']}")
    md_lines.append(f"- Fatal issues: {summary['totals']['fatal_issues']}")
    md_lines.append(f"- Info issues: {summary['totals']['info_issues']}")
    md_lines.append("")

    by_category = Counter(row["category"] for row in issue_rows)
    if by_category:
        md_lines.append("## Issue counts by category")
        for cat, count in by_category.most_common():
            md_lines.append(f"- {cat}: {count}")
        md_lines.append("")

    md_lines.append("## Trial-level status")
    md_lines.append("| Trial | Status | Issues |")
    md_lines.append("| --- | --- | ---: |")
    for audit in audits:
        status = "FATAL" if any(i.severity == "FATAL" for i in audit.issues) else "OK"
        md_lines.append(f"| {audit.trial_tag} | {status} | {len(audit.issues)} |")
    md_lines.append("")

    if issue_rows:
        md_lines.append("## Detailed issues")
        for row in issue_rows:
            md_lines.append(f"- **{row['severity']}** [{row['category']}] {row['trial_tag']} — {row['message']}")
            if row.get("path"):
                md_lines.append(f"  - Path: {row['path']}")
            if row.get("evidence"):
                md_lines.append(f"  - Evidence: `{json.dumps(row['evidence'], ensure_ascii=False)}`")
        md_lines.append("")

    (output_dir / "report.md").write_text("\n".join(md_lines), encoding="utf-8")
    (logs_dir / "scan.log").write_text(json.dumps(summary["totals"], indent=2), encoding="utf-8")


def write_scene_inventory_report(output_dir: Path, scene_audits: list[SceneAudit]) -> None:
    if not scene_audits:
        return
    inventory_dir = output_dir / "scene_inventory"
    ensure_dir(inventory_dir)

    totals = {
        "scene_files": len(scene_audits),
        "md_matches": sum(1 for a in scene_audits if a.md_exists),
        "with_any_issue": sum(1 for a in scene_audits if a.issues),
        "fatal_scenes": sum(1 for a in scene_audits if any(i["severity"] == "FATAL" for i in a.issues)),
        "missing_md": sum(1 for a in scene_audits if not a.md_exists),
    }

    issues = []
    for a in scene_audits:
        for issue in a.issues:
            issues.append({"scene_tag": a.scene_tag, "scene_path": a.scene_path, **issue})

    (inventory_dir / "scene_inventory.json").write_text(
        json.dumps({"totals": totals, "audits": [asdict(a) for a in scene_audits], "issues": issues}, indent=2),
        encoding="utf-8",
    )

    with (inventory_dir / "scene_inventory.csv").open("w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=["scene_tag", "scene_path", "md_exists", "expected_count", "actual_count", "issue_count"])
        writer.writeheader()
        for a in scene_audits:
            writer.writerow({
                "scene_tag": a.scene_tag,
                "scene_path": a.scene_path,
                "md_exists": a.md_exists,
                "expected_count": a.expected_count,
                "actual_count": a.actual_count,
                "issue_count": len(a.issues),
            })

    lines = [
        "# FMB Scene Inventory",
        "",
        f"- Scene files scanned: {totals['scene_files']}",
        f"- With matching md: {totals['md_matches']}",
        f"- Fatal scenes: {totals['fatal_scenes']}",
        f"- Scenes with any issue: {totals['with_any_issue']}",
        f"- Missing md: {totals['missing_md']}",
        "",
        "## Coverage notes",
        "- This is a scene-only inventory and does not depend on solver success.",
        "- It checks naming, counts, extra objects, numbering continuity, and safe distance.",
    ]
    (inventory_dir / "scene_inventory.md").write_text("\n".join(lines), encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser(description="Scan FMB input chains read-only.")
    parser.add_argument("--mags", nargs="+", default=["3objs", "4objs", "5objs"], help="Magnitude folders to scan")
    parser.add_argument("--scenarios", nargs="+", default=["001", "002", "003", "004", "005"], help="Scenario folders to scan")
    parser.add_argument("--trials", nargs="+", type=int, default=list(range(1, 11)), help="Trial indices to scan")
    parser.add_argument("--modes", nargs="+", default=["nr", "r"], choices=["nr", "r"], help="Scene/task modes to scan")
    parser.add_argument("--out-dir", type=str, default="", help="Optional output directory override")
    args = parser.parse_args()

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_dir = Path(args.out_dir) if args.out_dir else DEFAULT_OUT_BASE / timestamp
    ensure_dir(output_dir)

    audits: list[TrialAudit] = []
    total = 0
    skipped = 0
    scene_audits = audit_scene_inventory(args.mags, args.scenarios, args.trials, args.modes)

    for mag, scenario, trial_idx, mode, policy, md_path, scene_path, lgp_dir in iter_trial_inputs(args.mags, args.scenarios, args.trials, args.modes):
        total += 1
        scen_id = f"s{scenario}"
        trial_tag = make_trial_tag(mag, scenario, trial_idx, mode, policy)
        print(f"[{total}] {trial_tag}")

        if not md_path.exists() and not scene_path.exists() and not lgp_dir.exists():
            skipped += 1
            print("  [skip] all inputs missing")
            continue

        audit = audit_trial(md_path, scene_path, lgp_dir, mag, scenario, trial_idx, mode, policy=policy)
        audits.append(audit)
        fatal_count = sum(1 for i in audit.issues if i.severity == "FATAL")
        info_count = sum(1 for i in audit.issues if i.severity == "INFO")
        print(f"  status={audit.status} fatal={fatal_count} info={info_count}")

    write_report(output_dir, audits)
    write_scene_inventory_report(output_dir, scene_audits)
    print(f"\nSaved report to: {output_dir}")
    print(f"Trials scanned: {len(audits)} | skipped-empty: {skipped}")
    print(f"Scene inventory scanned: {len(scene_audits)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())