import json
import sys
from datetime import datetime
from pathlib import Path

try:
    import tkinter as tk
    from tkinter import filedialog
except Exception:
    tk = None
    filedialog = None

ROOT_DIR = Path(__file__).resolve().parents[2]
if str(ROOT_DIR) not in sys.path:
    sys.path.insert(0, str(ROOT_DIR))

from core.utils import clean_vlm_json_output
from core.graph_clustering import BranchAwareLayerCuttingClustering
from core.phase2_codegen import generate_step_files

OUTPUT_ROOT = ROOT_DIR / "test" / "fmb_output_test" / "outputs"


def read_multiline_from_terminal() -> str:
    print("Paste VLM output below. End input with a single line: EOF")
    lines = []
    while True:
        try:
            line = input()
        except EOFError:
            break
        if line.strip() == "EOF":
            break
        lines.append(line)
    text = "\n".join(lines).strip()
    if not text:
        raise RuntimeError("No input provided.")
    return text


def pick_text_file() -> Path:
    if tk is None or filedialog is None:
        raise RuntimeError("tkinter is unavailable for file picker. Use terminal paste mode instead.")

    root = tk.Tk()
    root.withdraw()
    root.attributes("-topmost", True)
    selected = filedialog.askopenfilename(
        title="Select VLM output text file",
        initialdir=str(ROOT_DIR),
        filetypes=[("Text/Markdown", "*.txt *.md *.log *.json"), ("All Files", "*.*")],
    )
    root.destroy()

    if not selected:
        raise RuntimeError("No file selected.")
    return Path(selected)


def read_from_file_path() -> str:
    file_path = pick_text_file()
    return file_path.read_text(encoding="utf-8")


def parse_phase1_json(raw_text: str) -> dict:
    cleaned = clean_vlm_json_output(raw_text)
    try:
        data = json.loads(cleaned)
    except Exception as e:
        raise ValueError(f"Failed to parse JSON after cleanup: {e}\n\nCleaned content:\n{cleaned[:600]}")

    if not isinstance(data, dict):
        raise ValueError("Parsed payload is not a JSON object.")

    if "objects" not in data and not ("V" in data and "E" in data):
        raise ValueError("Phase1 JSON must contain 'objects' or graph 'V'/'E'.")

    return data


def write_json(path: Path, data: dict):
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, ensure_ascii=True)


def create_output_dirs() -> tuple[Path, Path]:
    ts = datetime.now().strftime("%Y_%m_%d_%H_%M_%S")
    run_dir = OUTPUT_ROOT / f"{ts}_pasted_vlm"
    codegen_dir = run_dir / "phase2_codegen"
    codegen_dir.mkdir(parents=True, exist_ok=True)
    return run_dir, codegen_dir


def choose_input_mode() -> str:
    print("\nChoose input mode:")
    print("  1) Paste in terminal")
    print("  2) Pick text file")
    mode = input("Enter 1 or 2: ").strip()
    if mode not in ("1", "2"):
        raise RuntimeError("Invalid mode. Please run again and choose 1 or 2.")
    return mode


def main():
    OUTPUT_ROOT.mkdir(parents=True, exist_ok=True)

    mode = choose_input_mode()
    if mode == "1":
        raw_text = read_multiline_from_terminal()
        source = "terminal_paste"
    else:
        raw_text = read_from_file_path()
        source = "file_picker"

    run_dir, codegen_dir = create_output_dirs()
    (run_dir / "pasted_raw_output.txt").write_text(raw_text, encoding="utf-8")

    phase1_json = parse_phase1_json(raw_text)
    write_json(run_dir / "phase1_graph.json", phase1_json)

    clustering = BranchAwareLayerCuttingClustering(phase1_json)
    p1_out, p2_out = clustering.generate_optimal_strategy()
    write_json(run_dir / "phase2_prompt1_output.json", p1_out)
    write_json(run_dir / "phase2_prompt2_output.json", p2_out)

    generated_files = generate_step_files(
        phase1_json=phase1_json,
        prompt1_output=p1_out,
        prompt2_output=p2_out,
        out_dir=str(codegen_dir),
        inventory_data=None,
    )

    summary = {
        "source": source,
        "output_dir": str(run_dir),
        "codegen_dir": str(codegen_dir),
        "generated_files": [Path(p).name for p in generated_files],
    }
    write_json(run_dir / "execution_summary.json", summary)

    print("\n========== PASTED VLM -> CODEGEN SUMMARY ==========")
    print(f"Source:         {source}")
    print(f"Output Dir:     {run_dir}")
    print(f"Codegen Dir:    {codegen_dir}")
    print(f"Codegen Files:  {len(generated_files)}")
    for p in generated_files:
        print(f"  - {Path(p).name}")
    print("===================================================\n")


if __name__ == "__main__":
    main()
