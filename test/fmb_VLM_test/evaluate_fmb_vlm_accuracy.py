import csv
import json
import re
from pathlib import Path


ROOT_DIR = Path(__file__).resolve().parents[2]
TEST_DIR = Path(__file__).resolve().parent
OUTPUT_DIR = TEST_DIR / "outputs"

FINAL_JSON_PATTERN = re.compile(
    r"(?:^|\n)\s*(?:#+\s*|\*+\s*)?FINAL_JSON_START(?:\s*\*+)?\s*(\{.*?\})\s*(?:#+\s*|\*+\s*)?FINAL_JSON_END(?:\s*\*+)?(?=\s*(?:\n|$))",
    re.DOTALL,
)
FINAL_JSON_SPAN_PATTERN = re.compile(
    r"(?:^|\n)\s*(?:#+\s*|\*+\s*)?FINAL_JSON_START(?:\s*\*+)?\s*.*?\s*(?:#+\s*|\*+\s*)?FINAL_JSON_END(?:\s*\*+)?(?=\s*(?:\n|$))",
    re.DOTALL,
)
SAMPLE_SEPARATOR_PATTERN = re.compile(r"(?m)^\s*---\s*$")

GOLD_ANSWERS = [
    {
        "name": "task_bridge_left_right",
        "data": {
            "objects": [
                {"id": 0, "object": "base", "edges": []},
                {
                    "id": 1,
                    "object": "Shape 1",
                    "color": "red",
                    "edges": [{"supporter": 0, "position": "left"}],
                },
                {
                    "id": 2,
                    "object": "Shape 1",
                    "color": "yellow",
                    "edges": [{"supporter": 0, "position": "right"}],
                },
                {
                    "id": 3,
                    "object": "Shape 2",
                    "color": "green",
                    "edges": [{"supporter": 1}, {"supporter": 2}],
                },
                {
                    "id": 4,
                    "object": "Shape 3",
                    "color": "blue",
                    "edges": [{"supporter": 3}],
                },
            ]
        },
    },
    {
        "name": "task_hpair_front_back",
        "data": {
            "objects": [
                {"id": 0, "object": "base", "edges": []},
                {
                    "id": 1,
                    "object": "Shape 2",
                    "color": "green",
                    "edges": [{"supporter": 0, "position": "front"}],
                },
                {
                    "id": 2,
                    "object": "Shape 2",
                    "color": "red",
                    "edges": [{"supporter": 0, "position": "back"}],
                },
                {
                    "id": 3,
                    "object": "Shape 4",
                    "color": "blue",
                    "edges": [
                        {"supporter": 1, "position": "left"},
                        {"supporter": 2, "position": "left"},
                    ],
                },
                {
                    "id": 4,
                    "object": "Shape 4",
                    "color": "yellow",
                    "edges": [
                        {"supporter": 1, "position": "right"},
                        {"supporter": 2, "position": "right"},
                    ],
                },
            ]
        },
    },
]


def extract_json_blocks(raw_text: str) -> list[str]:
    return [match.group(1).strip() for match in FINAL_JSON_PATTERN.finditer(raw_text)]


def split_samples(raw_text: str) -> tuple[list[str], str]:
    if SAMPLE_SEPARATOR_PATTERN.search(raw_text):
        chunks = [chunk.strip() for chunk in SAMPLE_SEPARATOR_PATTERN.split(raw_text) if chunk.strip()]
        return chunks, "explicit_separator"

    legacy_chunks = [match.group(0).strip() for match in FINAL_JSON_SPAN_PATTERN.finditer(raw_text)]
    legacy_chunks = [chunk for chunk in legacy_chunks if chunk]
    if legacy_chunks:
        return legacy_chunks, "legacy_final_json_block"

    content = raw_text.strip()
    if not content:
        return [], "empty_file"
    return [content], "single_blob_fallback"


def canonical_edge(edge: dict) -> dict:
    if not isinstance(edge, dict):
        raise ValueError(f"Edge is not an object: {edge!r}")

    if "supporter" not in edge:
        raise ValueError(f"Edge missing 'supporter': {edge!r}")

    canonical = {"supporter": edge["supporter"]}
    if "position" in edge:
        canonical["position"] = edge["position"]
    return canonical


def canonical_object(obj: dict) -> dict:
    if not isinstance(obj, dict):
        raise ValueError(f"Object is not a JSON object: {obj!r}")
    if "id" not in obj:
        raise ValueError(f"Object missing 'id': {obj!r}")
    if "object" not in obj:
        raise ValueError(f"Object missing 'object': {obj!r}")

    canonical = {
        "id": obj["id"],
        "object": obj["object"],
        "edges": [],
    }

    if "color" in obj:
        canonical["color"] = obj["color"]

    raw_edges = obj.get("edges", [])
    if not isinstance(raw_edges, list):
        raise ValueError(f"'edges' must be a list: {obj!r}")

    canonical_edges = [canonical_edge(edge) for edge in raw_edges]
    canonical["edges"] = sorted(
        canonical_edges,
        key=lambda item: (
            item["supporter"],
            0 if "position" not in item else 1,
            item.get("position", ""),
        ),
    )
    return canonical


def normalize_phase1_json(data: dict) -> dict:
    if not isinstance(data, dict):
        raise ValueError("JSON root must be an object.")
    if "objects" not in data:
        raise ValueError("JSON root missing 'objects'.")
    if not isinstance(data["objects"], list):
        raise ValueError("'objects' must be a list.")

    canonical_objects = [canonical_object(obj) for obj in data["objects"]]
    canonical_objects.sort(key=lambda item: item["id"])
    return {"objects": canonical_objects}


def parse_candidate_block(block_text: str) -> dict:
    try:
        data = json.loads(block_text)
    except json.JSONDecodeError as exc:
        raise ValueError(f"Invalid JSON: {exc}") from exc
    return normalize_phase1_json(data)


def match_gold_answer(candidate: dict, normalized_golds: list[dict]) -> dict | None:
    for gold in normalized_golds:
        if candidate == gold["normalized"]:
            return {
                "matched_gold_name": gold["name"],
                "matched_gold_index": gold["index"],
            }
    return None


def evaluate_model_file(txt_path: Path, normalized_golds: list[dict]) -> tuple[dict, list[dict]]:
    raw_text = txt_path.read_text(encoding="utf-8")
    samples, sample_split_mode = split_samples(raw_text)
    detailed_rows = []
    correct_count = 0
    wrong_count = 0
    format_error_count = 0

    for index, sample_text in enumerate(samples, start=1):
        row = {
            "model_name": txt_path.stem,
            "source_file": txt_path.name,
            "sample_index": index,
            "sample_split_mode": sample_split_mode,
        }
        try:
            blocks = extract_json_blocks(sample_text)
            if len(blocks) != 1:
                if len(blocks) == 0:
                    raise ValueError("Sample does not contain any valid FINAL_JSON_START/FINAL_JSON_END block.")
                raise ValueError(f"Sample contains {len(blocks)} FINAL_JSON blocks; expected exactly 1.")

            normalized_candidate = parse_candidate_block(blocks[0])
            matched_gold = match_gold_answer(normalized_candidate, normalized_golds)
            row["status"] = "correct" if matched_gold else "wrong"
            row["reason"] = ""
            row["normalized_candidate"] = normalized_candidate
            row["extraction_type"] = "final_json_marker"
            row["matched_gold_name"] = matched_gold["matched_gold_name"] if matched_gold else None
            row["matched_gold_index"] = matched_gold["matched_gold_index"] if matched_gold else None
            if row["status"] == "correct":
                correct_count += 1
            else:
                wrong_count += 1
        except Exception as exc:
            row["status"] = "format_error"
            row["reason"] = str(exc)
            row["normalized_candidate"] = None
            row["extraction_type"] = None
            row["matched_gold_name"] = None
            row["matched_gold_index"] = None
            format_error_count += 1
        detailed_rows.append(row)

    if not samples:
        detailed_rows.append(
            {
                "model_name": txt_path.stem,
                "source_file": txt_path.name,
                "sample_index": None,
                "sample_split_mode": sample_split_mode,
                "status": "format_error",
                "reason": "No sample content found.",
                "normalized_candidate": None,
                "extraction_type": None,
                "matched_gold_name": None,
                "matched_gold_index": None,
            }
        )
        format_error_count = 1

    total_count = len(samples)
    accuracy = 0.0 if total_count == 0 else correct_count / total_count
    summary = {
        "model_name": txt_path.stem,
        "source_file": txt_path.name,
        "sample_split_mode": sample_split_mode,
        "total_samples": total_count,
        "correct_samples": correct_count,
        "wrong_samples": wrong_count,
        "format_error_samples": format_error_count,
        "accuracy": accuracy,
    }
    return summary, detailed_rows


def ensure_output_dir() -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)


def write_json(path: Path, payload) -> None:
    with open(path, "w", encoding="utf-8") as file:
        json.dump(payload, file, indent=2, ensure_ascii=False)


def write_csv(path: Path, summaries: list[dict]) -> None:
    with open(path, "w", encoding="utf-8", newline="") as file:
        writer = csv.writer(file)
        writer.writerow(["model_name", "source_file", "correct_samples", "total_samples", "accuracy_percent"])
        for item in summaries:
            writer.writerow(
                [
                    item["model_name"],
                    item["source_file"],
                    item["correct_samples"],
                    item["total_samples"],
                    f"{item['accuracy'] * 100:.2f}",
                ]
            )


def svg_escape(text: str) -> str:
    return (
        text.replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;")
        .replace('"', "&quot;")
    )


def render_svg_bar_chart(summaries: list[dict], out_path: Path) -> None:
    width = 1200
    height = 720
    margin_left = 90
    margin_right = 40
    margin_top = 80
    margin_bottom = 160
    plot_width = width - margin_left - margin_right
    plot_height = height - margin_top - margin_bottom

    bar_count = max(len(summaries), 1)
    slot_width = plot_width / bar_count
    bar_width = min(96, slot_width * 0.58)

    lines = [
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" viewBox="0 0 {width} {height}">',
        '<rect width="100%" height="100%" fill="#f7f4ea"/>',
        '<text x="90" y="42" font-size="28" font-family="Helvetica, Arial, sans-serif" fill="#1f2937">FMB VLM Accuracy</text>',
        '<text x="90" y="68" font-size="14" font-family="Helvetica, Arial, sans-serif" fill="#6b7280">Accuracy is computed from extracted FINAL_JSON blocks only.</text>',
    ]

    for tick in range(0, 101, 20):
        y = margin_top + plot_height - (tick / 100.0) * plot_height
        lines.append(
            f'<line x1="{margin_left}" y1="{y:.2f}" x2="{width - margin_right}" y2="{y:.2f}" stroke="#d6d3d1" stroke-width="1"/>'
        )
        lines.append(
            f'<text x="{margin_left - 14}" y="{y + 5:.2f}" text-anchor="end" font-size="12" font-family="Helvetica, Arial, sans-serif" fill="#6b7280">{tick}%</text>'
        )

    axis_bottom = margin_top + plot_height
    lines.append(
        f'<line x1="{margin_left}" y1="{axis_bottom}" x2="{width - margin_right}" y2="{axis_bottom}" stroke="#44403c" stroke-width="2"/>'
    )
    lines.append(
        f'<line x1="{margin_left}" y1="{margin_top}" x2="{margin_left}" y2="{axis_bottom}" stroke="#44403c" stroke-width="2"/>'
    )

    palette = ["#0f766e", "#2563eb", "#d97706", "#dc2626", "#7c3aed", "#0891b2"]
    for index, item in enumerate(summaries):
        center_x = margin_left + slot_width * index + slot_width / 2.0
        bar_height = plot_height * item["accuracy"]
        bar_x = center_x - bar_width / 2.0
        bar_y = axis_bottom - bar_height
        color = palette[index % len(palette)]
        accuracy_percent = item["accuracy"] * 100.0
        label = svg_escape(item["model_name"])
        count_label = f'{item["correct_samples"]}/{item["total_samples"]}'

        lines.append(
            f'<rect x="{bar_x:.2f}" y="{bar_y:.2f}" width="{bar_width:.2f}" height="{bar_height:.2f}" rx="8" fill="{color}"/>'
        )
        lines.append(
            f'<text x="{center_x:.2f}" y="{max(bar_y - 12, margin_top - 8):.2f}" text-anchor="middle" font-size="13" font-family="Helvetica, Arial, sans-serif" fill="#111827">{accuracy_percent:.1f}%</text>'
        )
        lines.append(
            f'<text x="{center_x:.2f}" y="{max(bar_y - 28, margin_top - 24):.2f}" text-anchor="middle" font-size="12" font-family="Helvetica, Arial, sans-serif" fill="#6b7280">{count_label}</text>'
        )
        lines.append(
            f'<text x="{center_x:.2f}" y="{axis_bottom + 26:.2f}" text-anchor="end" font-size="12" font-family="Helvetica, Arial, sans-serif" fill="#374151" transform="rotate(-30 {center_x:.2f} {axis_bottom + 26:.2f})">{label}</text>'
        )

    lines.append(
        f'<text x="{margin_left - 56}" y="{margin_top - 14}" font-size="13" font-family="Helvetica, Arial, sans-serif" fill="#374151" transform="rotate(-90 {margin_left - 56} {margin_top - 14})">Accuracy</text>'
    )
    lines.append(
        f'<text x="{margin_left + plot_width / 2:.2f}" y="{height - 34}" text-anchor="middle" font-size="13" font-family="Helvetica, Arial, sans-serif" fill="#374151">Models</text>'
    )
    lines.append("</svg>")

    out_path.write_text("\n".join(lines), encoding="utf-8")


def build_console_lines(summaries: list[dict], outputs: dict[str, Path]) -> list[str]:
    lines = [
        "",
        "========== FMB VLM ACCURACY SUMMARY ==========",
    ]
    for item in summaries:
        lines.append(
            f"{item['model_name']}: {item['correct_samples']}/{item['total_samples']} "
            f"({item['accuracy'] * 100:.2f}%)"
        )
    lines.extend(
        [
            "----------------------------------------------",
            f"JSON Summary: {outputs['json']}",
            f"CSV Summary:  {outputs['csv']}",
            f"Detail JSON:  {outputs['detail']}",
            f"SVG Chart:    {outputs['svg']}",
            "==============================================",
            "",
        ]
    )
    return lines


def main() -> None:
    ensure_output_dir()
    normalized_golds = [
        {
            "index": index,
            "name": item["name"],
            "normalized": normalize_phase1_json(item["data"]),
        }
        for index, item in enumerate(GOLD_ANSWERS, start=1)
    ]
    txt_files = sorted(path for path in TEST_DIR.glob("*.txt") if path.is_file())

    summaries = []
    details = []
    for txt_path in txt_files:
        summary, rows = evaluate_model_file(txt_path, normalized_golds)
        summaries.append(summary)
        details.extend(rows)

    summaries.sort(key=lambda item: (-item["accuracy"], -item["correct_samples"], item["model_name"]))

    summary_payload = {
        "gold_answers": [
            {
                "index": item["index"],
                "name": item["name"],
                "data": item["normalized"],
            }
            for item in normalized_golds
        ],
        "models": summaries,
        "model_count": len(summaries),
    }

    output_paths = {
        "json": OUTPUT_DIR / "accuracy_summary.json",
        "csv": OUTPUT_DIR / "accuracy_summary.csv",
        "detail": OUTPUT_DIR / "detailed_results.json",
        "svg": OUTPUT_DIR / "accuracy_bar_chart.svg",
    }
    write_json(output_paths["json"], summary_payload)
    write_json(output_paths["detail"], details)
    write_csv(output_paths["csv"], summaries)
    render_svg_bar_chart(summaries, output_paths["svg"])

    for line in build_console_lines(summaries, output_paths):
        print(line)


if __name__ == "__main__":
    main()
