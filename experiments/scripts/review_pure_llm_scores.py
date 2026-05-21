#!/usr/bin/env python3
"""Interactive manual scorer for pure LLM baseline outputs."""
from __future__ import annotations

import argparse
import json
import textwrap
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional

import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
from PIL import Image

ROOT = Path(__file__).resolve().parents[2]
OUT_ROOT = ROOT / "experiments/outputs/pure_llm_baseline/accuracy_analysis/cubeStacking"
INDEX_PATH = OUT_ROOT / "review_index.json"
SCORE_DIR = OUT_ROOT / "manual_review"
LATEST_PATH = SCORE_DIR / "latest_scores.json"
EVENTS_PATH = SCORE_DIR / "score_events.jsonl"
PROGRESS_PATH = SCORE_DIR / "progress.json"

RAW_WRAP_WIDTH = 108
MAX_RAW_CHARS = 12000
TEXT_FONT_SIZE = 11
TITLE_FONT_SIZE = 18
VISIBLE_TEXT_LINES = 48
SCROLL_STEP_SMALL = 3
SCROLL_STEP_PAGE = 18


def _load_json(path: Path, default):
    if not path.exists():
        return default
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except Exception:
        return default


def _append_jsonl(path: Path, obj: dict) -> None:
    with path.open("a", encoding="utf-8") as f:
        f.write(json.dumps(obj, ensure_ascii=False) + "\n")


def _read_raw_response(md_path: Path) -> str:
    try:
        text = md_path.read_text(encoding="utf-8")
    except Exception as exc:
        return f"[Failed to read markdown] {exc}"

    marker = "## VLM Raw Response"
    idx = text.find(marker)
    if idx < 0:
        return text[:4000]

    block = text[idx + len(marker):].strip()
    if block.startswith("```xml"):
        block = block[6:]
    if block.startswith("```"):
        block = block[3:]
    if block.endswith("```"):
        block = block[:-3]
    return block.strip()


def _save_state(latest: Dict[str, dict], current_index: int, total: int) -> None:
    SCORE_DIR.mkdir(parents=True, exist_ok=True)
    LATEST_PATH.write_text(json.dumps(latest, indent=2, ensure_ascii=False), encoding="utf-8")

    n_scored = len(latest)
    progress = {
        "total": total,
        "scored": n_scored,
        "remaining": max(0, total - n_scored),
        "ratio": (n_scored / total) if total else 0.0,
        "last_index": current_index,
        "updated_at": datetime.now().isoformat(timespec="seconds"),
    }
    PROGRESS_PATH.write_text(json.dumps(progress, indent=2, ensure_ascii=False), encoding="utf-8")


def _wrap_preserving_newlines(text: str, width: int) -> str:
    """Wrap long lines but keep original line boundaries and empty lines."""
    wrapped_lines: List[str] = []
    for line in text.splitlines():
        if not line:
            wrapped_lines.append("")
            continue

        indent_len = len(line) - len(line.lstrip(" "))
        indent = line[:indent_len]
        content = line[indent_len:]
        effective_width = max(20, width - indent_len)
        chunks = textwrap.wrap(
            content,
            width=effective_width,
            replace_whitespace=False,
            drop_whitespace=False,
            break_long_words=False,
            break_on_hyphens=False,
        )
        if not chunks:
            wrapped_lines.append(line)
            continue

        wrapped_lines.extend(indent + chunk for chunk in chunks)

    return "\n".join(wrapped_lines)


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
        self.fig = plt.figure(figsize=(17, 10))
        gs = gridspec.GridSpec(1, 2, width_ratios=[1.1, 1.4], wspace=0.08)
        self.ax_image = self.fig.add_subplot(gs[0, 0])
        self.ax_text = self.fig.add_subplot(gs[0, 1])
        self.fig.canvas.mpl_connect("key_press_event", self.on_key)
        self.fig.canvas.mpl_connect("scroll_event", self.on_scroll)
        self.render_current()

    def _format_meta(self, rec: dict, score: Optional[dict]) -> str:
        score_text = "UNSCORED"
        if score:
            score_text = f"{score.get('label')} ({score.get('value')}) @ {score.get('timestamp')}"

        header = [
            f"Key: {rec['key']}",
            f"Case: {rec['case_name']}  |  Variant: {rec['variant']}  |  Trial: {rec['trial']:02d}",
            f"Magnitude: {rec['magnitude']}  |  Scenario: {rec['scenario']}",
            f"Image: {rec['image_path']}",
            f"Scene: {rec['scene_path']}",
            f"Current score: {score_text}",
            "",
            "Hotkeys:",
            "  c = Correct(1) and next",
            "  x = Wrong(0) and next",
            "  n / right = next",
            "  p / left  = previous",
            "  u = jump to next unscored",
            "  up/down = scroll text",
            "  pageup/pagedown = fast scroll",
            "  home/end = top/bottom",
            "  mouse wheel = scroll text",
            "  q = save and quit",
            "",
            "Raw response:",
        ]
        return "\n".join(header)

    def _max_scroll_offset(self) -> int:
        return max(0, len(self._full_lines) - VISIBLE_TEXT_LINES)

    def _clamp_scroll(self) -> None:
        self.scroll_offset = max(0, min(self.scroll_offset, self._max_scroll_offset()))

    def _scroll_text(self, delta: int) -> None:
        if not self._full_lines:
            return
        self.scroll_offset += delta
        self._clamp_scroll()
        self.render_current()

    def render_current(self) -> None:
        total = len(self.state.records)
        if total == 0:
            raise RuntimeError("No records found in index.")

        self.state.index = max(0, min(self.state.index, total - 1))
        rec = self.state.records[self.state.index]
        score = self.state.latest.get(rec["key"])

        self.ax_image.clear()
        self.ax_text.clear()

        img_path = Path(rec["image_path"])
        if img_path.exists():
            try:
                img = Image.open(img_path)
                self.ax_image.imshow(img)
                self.ax_image.set_title(f"Target Image ({self.state.index + 1}/{total})")
            except Exception as exc:
                self.ax_image.text(0.5, 0.5, f"Image load failed:\n{exc}", ha="center", va="center")
        else:
            self.ax_image.text(0.5, 0.5, "Image missing", ha="center", va="center")
        self.ax_image.axis("off")

        meta_text = self._format_meta(rec, score)
        raw_text = _read_raw_response(Path(rec["md_path"]))
        wrapped = _wrap_preserving_newlines(raw_text[:MAX_RAW_CHARS], width=RAW_WRAP_WIDTH)
        full_text = meta_text + "\n" + wrapped

        self._full_lines = full_text.splitlines()
        self._clamp_scroll()
        start = self.scroll_offset
        end = min(len(self._full_lines), start + VISIBLE_TEXT_LINES)
        viewport_lines = self._full_lines[start:end]
        scroll_info = f"\n\n[Scroll {start + 1}-{end} / {len(self._full_lines)} lines]"
        viewport_text = "\n".join(viewport_lines) + scroll_info

        self.ax_text.text(
            0.01,
            0.99,
            viewport_text,
            ha="left",
            va="top",
            fontsize=TEXT_FONT_SIZE,
            family="monospace",
            linespacing=1.2,
            transform=self.ax_text.transAxes,
        )
        self.ax_text.set_axis_off()

        self.fig.suptitle("Pure LLM Manual Review", fontsize=TITLE_FONT_SIZE, fontweight="bold")
        self.fig.canvas.draw_idle()

    def _record_score(self, value: int, label: str) -> None:
        rec = self.state.records[self.state.index]
        event = {
            "timestamp": datetime.now().isoformat(timespec="seconds"),
            "key": rec["key"],
            "label": label,
            "value": int(value),
            "magnitude": rec["magnitude"],
            "scenario": rec["scenario"],
            "case_name": rec["case_name"],
            "variant": rec["variant"],
            "trial": rec["trial"],
        }

        self.state.latest[rec["key"]] = event
        _append_jsonl(EVENTS_PATH, event)
        _save_state(self.state.latest, self.state.index, len(self.state.records))
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

    def on_scroll(self, event) -> None:
        # Positive step is wheel-up in matplotlib; map to upward scroll (smaller offset).
        if event.step > 0:
            self._scroll_text(-SCROLL_STEP_SMALL)
        elif event.step < 0:
            self._scroll_text(SCROLL_STEP_SMALL)

    def on_key(self, event) -> None:
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
            _save_state(self.state.latest, self.state.index, len(self.state.records))
            plt.close(self.fig)


def _resolve_start_index(records: List[dict], latest: Dict[str, dict], start_key: Optional[str], start_unscored: bool) -> int:
    if start_key:
        for i, rec in enumerate(records):
            if rec["key"] == start_key:
                return i

    if start_unscored:
        for i, rec in enumerate(records):
            if rec["key"] not in latest:
                return i

    return 0


def main() -> None:
    parser = argparse.ArgumentParser(description="Manual scorer for pure LLM baseline outputs.")
    parser.add_argument("--start-key", default=None, help="Start from a specific review key.")
    parser.add_argument("--start-unscored", action="store_true", help="Start from first unscored record.")
    args = parser.parse_args()

    if not INDEX_PATH.exists():
        raise FileNotFoundError(
            f"Missing index at {INDEX_PATH}. Run build_pure_llm_review_index.py first."
        )

    records = _load_json(INDEX_PATH, default=[])
    SCORE_DIR.mkdir(parents=True, exist_ok=True)
    latest = _load_json(LATEST_PATH, default={})

    start_idx = _resolve_start_index(records, latest, args.start_key, args.start_unscored)
    _save_state(latest, start_idx, len(records))

    ui = ReviewUI(SessionState(records=records, latest=latest, index=start_idx))
    plt.show()


if __name__ == "__main__":
    main()
