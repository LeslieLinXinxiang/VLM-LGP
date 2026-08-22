#!/usr/bin/env python3
"""Interactive manual scorer for the VLM-MSGraph baseline (Track 1).

Shows, for each of the 40 trials in grading order (cubeStacking 4..8 cubes, then FMB
3..5 objs): the input image(s) the VLM was given, that trial's ordered_triples
rendered as a readable assembly sequence, and a big green ✓ / red ✗ to mark whether
the sequence matches the picture.

This is a *content* judgement against the image — the complement to
validate_baseline_vlm_msgraph_format.py, which only checks schema compliance and has
no ground truth. Keep the two numbers separate when reporting.

Scoring is written through on every click (score_events.jsonl append + latest_scores
rewrite), so quitting mid-way and resuming with --start-unscored loses nothing.

Controls:
    click ✓ / press c        correct, advance
    click ✗ / press x        wrong, advance
    n / → / space            next            p / ← previous
    u                        jump to next unscored
    o                        open this trial's image(s) in the system viewer
                             (FMB images are ~3800px — the panel downsamples them)
    r                        open the full raw .md in the system viewer
    ↑ ↓ / wheel              scroll text     pageup/pagedown fast    home/end
    q                        save and quit

Usage:
    python3 review_vlm_msgraph_scores.py [--start-unscored] [--start-key KEY]
                                         [--benchmark cubeStacking|FMB]
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
import textwrap
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional

import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
from matplotlib.widgets import Button
from PIL import Image

ROOT = Path(__file__).resolve().parents[2]
OUT_ROOT = ROOT / "experiments/outputs/VLM-MSGraph_baseline/accuracy_analysis"
DEFAULT_INDEX_PATH = OUT_ROOT / "review_index.json"
SCORE_DIR = OUT_ROOT / "manual_review"
LATEST_PATH = SCORE_DIR / "latest_scores.json"
EVENTS_PATH = SCORE_DIR / "score_events.jsonl"
PROGRESS_PATH = SCORE_DIR / "progress.json"

TEXT_WRAP_WIDTH = 92
TEXT_FONT_SIZE = 10.5
VISIBLE_TEXT_LINES = 46
SCROLL_STEP_SMALL = 3
SCROLL_STEP_PAGE = 16
MAX_IMAGE_PX = 1400  # downsample large FMB renders for panel display speed

GREEN = "#16a34a"
RED = "#dc2626"


def _load_json(path: Path, default):
    if not path.exists():
        return default
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except Exception:
        return default


def _append_jsonl(path: Path, obj: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("a", encoding="utf-8") as f:
        f.write(json.dumps(obj, ensure_ascii=False) + "\n")


def _open_externally(paths: List[Path]) -> None:
    existing = [str(p) for p in paths if p.exists()]
    if not existing:
        return
    opener = {"darwin": "open", "win32": "start"}.get(sys.platform, "xdg-open")
    try:
        subprocess.Popen([opener, *existing])
    except Exception as exc:  # pragma: no cover - best effort convenience
        print(f"Could not open externally: {exc}")


def _save_state(latest: Dict[str, dict], records: List[dict], current_index: int) -> None:
    SCORE_DIR.mkdir(parents=True, exist_ok=True)
    LATEST_PATH.write_text(json.dumps(latest, indent=2, ensure_ascii=False), encoding="utf-8")

    total = len(records)
    per_bench: Dict[str, dict] = {}
    for rec in records:
        b = per_bench.setdefault(rec["benchmark"], {"total": 0, "scored": 0})
        b["total"] += 1
        if rec["key"] in latest:
            b["scored"] += 1

    n_scored = sum(1 for rec in records if rec["key"] in latest)
    progress = {
        "total": total,
        "scored": n_scored,
        "remaining": max(0, total - n_scored),
        "ratio": (n_scored / total) if total else 0.0,
        "per_benchmark": per_bench,
        "last_index": current_index,
        "updated_at": datetime.now().isoformat(timespec="seconds"),
    }
    PROGRESS_PATH.write_text(json.dumps(progress, indent=2, ensure_ascii=False), encoding="utf-8")


def _fmt_object(value) -> str:
    if isinstance(value, list):
        return "[" + " + ".join(str(v) for v in value) + "]"
    return str(value)


def format_ordered_triples(rec: dict) -> str:
    """Render ordered_triples as a readable assembly sequence — the thing being graded."""
    ordered = rec.get("ordered_triples") or []
    if not ordered:
        return "  (!!) no ordered_triples could be extracted from this file\n"

    subj_w = max((len(str(t.get("subject", ""))) for t in ordered), default=8)
    subj_w = min(max(subj_w, 8), 28)
    lines = []
    for t in ordered:
        step = t.get("step", "?")
        subj = str(t.get("subject", "?"))
        pred = str(t.get("predicate", "?"))
        obj = _fmt_object(t.get("object"))
        pos = t.get("position")
        pos_txt = f"   @ {pos}" if pos else ""
        lines.append(f"  {str(step):>2}. {subj:<{subj_w}}  --{pred}-->  {obj}{pos_txt}")
    return "\n".join(lines)


def format_raw_triples(rec: dict) -> str:
    raw = rec.get("raw_triples") or []
    if not raw:
        return "  (none extracted)"
    lines = []
    for t in raw:
        src = str(t.get("source", "?")).replace("_narrator", "")
        lines.append(
            f"  [{src:<8}] {t.get('subject')} --{t.get('predicate')}--> {t.get('object')}"
        )
    return "\n".join(lines)


def _wrap_preserving_newlines(text: str, width: int) -> str:
    out: List[str] = []
    for line in text.splitlines():
        if not line:
            out.append("")
            continue
        indent_len = len(line) - len(line.lstrip(" "))
        indent = line[:indent_len]
        content = line[indent_len:]
        chunks = textwrap.wrap(
            content,
            width=max(20, width - indent_len),
            replace_whitespace=False,
            drop_whitespace=False,
            break_long_words=False,
            break_on_hyphens=False,
        )
        out.extend(indent + c for c in chunks) if chunks else out.append(line)
    return "\n".join(out)


@dataclass
class SessionState:
    records: List[dict]
    latest: Dict[str, dict]
    index: int


class ReviewUI:
    def __init__(self, state: SessionState):
        self.state = state
        self.scroll_offset = 0
        self._full_lines: List[str] = []
        self._img_cache: Dict[str, Image.Image] = {}

        self.fig = plt.figure(figsize=(18, 10.5))
        outer = gridspec.GridSpec(
            2, 1, height_ratios=[10, 1.15], hspace=0.06,
            left=0.02, right=0.985, top=0.94, bottom=0.03,
        )
        top = gridspec.GridSpecFromSubplotSpec(1, 2, subplot_spec=outer[0], width_ratios=[1.0, 1.25], wspace=0.05)
        self.gs_image_slot = top[0, 0]
        self.ax_text = self.fig.add_subplot(top[0, 1])
        self.image_axes: List[plt.Axes] = []

        btn = gridspec.GridSpecFromSubplotSpec(
            1, 3, subplot_spec=outer[1], width_ratios=[1, 0.9, 1], wspace=0.12
        )
        self.ax_ok = self.fig.add_subplot(btn[0, 0])
        self.ax_mid = self.fig.add_subplot(btn[0, 1])
        self.ax_bad = self.fig.add_subplot(btn[0, 2])
        self.ax_mid.set_axis_off()

        self.btn_ok = Button(self.ax_ok, "✓", color="#bbf7d0", hovercolor="#4ade80")
        self.btn_bad = Button(self.ax_bad, "✗", color="#fecaca", hovercolor="#f87171")
        for b, col in ((self.btn_ok, GREEN), (self.btn_bad, RED)):
            b.label.set_fontsize(46)
            b.label.set_color(col)
            b.label.set_fontweight("bold")
        self.btn_ok.on_clicked(lambda _e: self._record_score(1, "correct"))
        self.btn_bad.on_clicked(lambda _e: self._record_score(0, "wrong"))

        self.fig.canvas.mpl_connect("key_press_event", self.on_key)
        self.fig.canvas.mpl_connect("scroll_event", self.on_scroll)
        self.render_current()

    # ---------- rendering ----------

    def _load_image(self, path: str) -> Optional[Image.Image]:
        if path in self._img_cache:
            return self._img_cache[path]
        p = Path(path)
        if not p.exists():
            return None
        try:
            img = Image.open(p)
            img.thumbnail((MAX_IMAGE_PX, MAX_IMAGE_PX))
            img = img.convert("RGB")
        except Exception:
            return None
        self._img_cache[path] = img
        return img

    def _render_images(self, rec: dict) -> None:
        for ax in self.image_axes:
            ax.remove()
        self.image_axes = []

        paths = rec.get("image_paths") or []
        n = max(1, len(paths))
        sub = gridspec.GridSpecFromSubplotSpec(n, 1, subplot_spec=self.gs_image_slot, hspace=0.08)
        for i in range(n):
            ax = self.fig.add_subplot(sub[i, 0])
            self.image_axes.append(ax)
            if i < len(paths):
                img = self._load_image(paths[i])
                if img is not None:
                    ax.imshow(img)
                    ax.set_title(Path(paths[i]).name, fontsize=9)
                else:
                    ax.text(0.5, 0.5, f"image missing:\n{paths[i]}", ha="center", va="center", fontsize=9)
            else:
                ax.text(0.5, 0.5, "no input image found", ha="center", va="center", fontsize=11, color=RED)
            ax.axis("off")

    def _body_text(self, rec: dict, score: Optional[dict]) -> str:
        if score:
            mark = "✓ CORRECT" if score["value"] == 1 else "✗ WRONG"
            score_text = f"{mark}   (recorded {score.get('timestamp')})"
        else:
            score_text = "UNSCORED"

        n_scored = sum(1 for r in self.state.records if r["key"] in self.state.latest)
        warn = ""
        if rec.get("parse_mode") != "strict":
            warn = (f"\n  !! FINAL_JSON needed lenient extraction (mode={rec.get('parse_mode')}) — "
                    f"source paste is malformed/truncated.\n"
                    f"     Grade the CONTENT anyway; format compliance is tracked separately.\n")

        ref_block = ""
        if "reference_ordered_triples" in rec:
            note = rec.get("reference_note") or ""
            ref_triples = rec.get("reference_ordered_triples")
            ref_rendered = (format_ordered_triples({"ordered_triples": ref_triples})
                            if ref_triples else "  (no reference — nothing to compare against)")
            ref_block = f"""
REFERENCE (prior trial, for comparison only — grade the CANDIDATE below against the IMAGE, not against this)
{'-' * TEXT_WRAP_WIDTH}
  {note}
{ref_rendered}

CANDIDATE ordered_triples (the one you are scoring) is in the ORDERED_TRIPLES section below.
"""

        head = f"""{rec['key']}
{'=' * TEXT_WRAP_WIDTH}
  benchmark : {rec['benchmark']}      magnitude: {rec['magnitude']}      case: {rec['case_name']}
  anchor    : {rec.get('anchor_object')}
  score     : {score_text}
  progress  : {self.state.index + 1}/{len(self.state.records)} shown   |   {n_scored}/{len(self.state.records)} scored
{warn}
  ✓ / c = correct     ✗ / x = wrong     n,p = nav     u = next unscored
  o = open image(s) full-size     r = open raw .md     ↑↓/wheel = scroll     q = save+quit
{ref_block}
ORDERED_TRIPLES  (assembly sequence being graded)
{'-' * TEXT_WRAP_WIDTH}
{format_ordered_triples(rec)}

RAW_TRIPLES  (stage-1 evidence)
{'-' * TEXT_WRAP_WIDTH}
{format_raw_triples(rec)}

SELF_CHECK_NOTES
{'-' * TEXT_WRAP_WIDTH}
{rec.get('self_check_notes') or '(none)'}
"""
        return head

    def render_current(self) -> None:
        total = len(self.state.records)
        if total == 0:
            raise RuntimeError("No records in index.")
        self.state.index = max(0, min(self.state.index, total - 1))
        rec = self.state.records[self.state.index]
        score = self.state.latest.get(rec["key"])

        self._render_images(rec)

        self.ax_text.clear()
        full = _wrap_preserving_newlines(self._body_text(rec, score), TEXT_WRAP_WIDTH)
        self._full_lines = full.splitlines()
        self.scroll_offset = max(0, min(self.scroll_offset, self._max_scroll_offset()))
        start = self.scroll_offset
        end = min(len(self._full_lines), start + VISIBLE_TEXT_LINES)
        viewport = "\n".join(self._full_lines[start:end])
        if len(self._full_lines) > VISIBLE_TEXT_LINES:
            viewport += f"\n\n[lines {start + 1}-{end} / {len(self._full_lines)}  — scroll for more]"
        self.ax_text.text(
            0.0, 1.0, viewport, ha="left", va="top", fontsize=TEXT_FONT_SIZE,
            family="monospace", linespacing=1.25, transform=self.ax_text.transAxes,
        )
        self.ax_text.set_axis_off()

        colour = {1: GREEN, 0: RED}.get(score["value"]) if score else "#334155"
        self.fig.suptitle(
            f"VLM-MSGraph Baseline — Track 1 Manual Review   [{self.state.index + 1}/{total}]",
            fontsize=16, fontweight="bold", color=colour,
        )
        self.fig.canvas.draw_idle()

    # ---------- interaction ----------

    def _max_scroll_offset(self) -> int:
        return max(0, len(self._full_lines) - VISIBLE_TEXT_LINES)

    def _scroll_text(self, delta: int) -> None:
        if not self._full_lines:
            return
        self.scroll_offset = max(0, min(self.scroll_offset + delta, self._max_scroll_offset()))
        self.render_current()

    def _record_score(self, value: int, label: str) -> None:
        rec = self.state.records[self.state.index]
        event = {
            "timestamp": datetime.now().isoformat(timespec="seconds"),
            "key": rec["key"],
            "label": label,
            "value": int(value),
            "benchmark": rec["benchmark"],
            "magnitude": rec["magnitude"],
            "case_name": rec["case_name"],
            "trial": rec["trial"],
        }
        self.state.latest[rec["key"]] = event
        _append_jsonl(EVENTS_PATH, event)
        _save_state(self.state.latest, self.state.records, self.state.index)
        self._move_next()

    def _move_next(self) -> None:
        if self.state.index < len(self.state.records) - 1:
            self.state.index += 1
        self.scroll_offset = 0
        self.render_current()

    def _move_prev(self) -> None:
        if self.state.index > 0:
            self.state.index -= 1
        self.scroll_offset = 0
        self.render_current()

    def _jump_next_unscored(self) -> None:
        for i in range(self.state.index + 1, len(self.state.records)):
            if self.state.records[i]["key"] not in self.state.latest:
                self.state.index = i
                self.scroll_offset = 0
                self.render_current()
                return
        print("No unscored records after the current one.")

    def on_scroll(self, event) -> None:
        if event.step > 0:
            self._scroll_text(-SCROLL_STEP_SMALL)
        elif event.step < 0:
            self._scroll_text(SCROLL_STEP_SMALL)

    def on_key(self, event) -> None:
        rec = self.state.records[self.state.index]
        if event.key == "c":
            self._record_score(1, "correct")
        elif event.key == "x":
            self._record_score(0, "wrong")
        elif event.key in {"n", "right", " "}:
            self._move_next()
        elif event.key in {"p", "left"}:
            self._move_prev()
        elif event.key == "u":
            self._jump_next_unscored()
        elif event.key == "o":
            _open_externally([Path(p) for p in rec.get("image_paths", [])])
        elif event.key == "r":
            _open_externally([Path(rec["md_path"])])
        elif event.key == "up":
            self._scroll_text(-1)
        elif event.key == "down":
            self._scroll_text(1)
        elif event.key == "pageup":
            self._scroll_text(-SCROLL_STEP_PAGE)
        elif event.key == "pagedown":
            self._scroll_text(SCROLL_STEP_PAGE)
        elif event.key == "home":
            self.scroll_offset = 0
            self.render_current()
        elif event.key == "end":
            self.scroll_offset = self._max_scroll_offset()
            self.render_current()
        elif event.key == "q":
            _save_state(self.state.latest, self.state.records, self.state.index)
            plt.close(self.fig)


def _resolve_start_index(records, latest, start_key, start_unscored) -> int:
    if start_key:
        for i, rec in enumerate(records):
            if rec["key"] == start_key or rec["key"].startswith(start_key):
                return i
    if start_unscored:
        for i, rec in enumerate(records):
            if rec["key"] not in latest:
                return i
    return 0


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--start-key", default=None, help="Start at this review key (prefix match allowed).")
    ap.add_argument("--start-unscored", action="store_true", help="Start at the first unscored record.")
    ap.add_argument("--benchmark", default=None, choices=["cubeStacking", "FMB"],
                    help="Restrict the session to one benchmark.")
    ap.add_argument("--index", default=None,
                    help="Path to a review index file (default: review_index.json). Pass "
                         "review_index_flagged.json (from diff_vlm_msgraph_trial_vs_reference.py) "
                         "to review only the cases that need a second look.")
    args = ap.parse_args()

    index_path = Path(args.index) if args.index else DEFAULT_INDEX_PATH
    if not index_path.exists():
        raise FileNotFoundError(
            f"Missing {index_path}\nRun: python3 experiments/scripts/build_vlm_msgraph_review_index.py"
        )

    records = _load_json(index_path, default=[])
    if args.benchmark:
        records = [r for r in records if r["benchmark"] == args.benchmark]
    if not records:
        raise RuntimeError("No records to review after filtering.")

    SCORE_DIR.mkdir(parents=True, exist_ok=True)
    latest = _load_json(LATEST_PATH, default={})
    start_idx = _resolve_start_index(records, latest, args.start_key, args.start_unscored)
    _save_state(latest, records, start_idx)

    ui = ReviewUI(SessionState(records=records, latest=latest, index=start_idx))
    plt.show()
    _save_state(ui.state.latest, ui.state.records, ui.state.index)
    n = sum(1 for r in records if r["key"] in ui.state.latest)
    print(f"Scored {n}/{len(records)}. Scores: {LATEST_PATH}")
    print("Next: python3 experiments/scripts/analyse_vlm_msgraph_manual_scores.py")


if __name__ == "__main__":
    main()
