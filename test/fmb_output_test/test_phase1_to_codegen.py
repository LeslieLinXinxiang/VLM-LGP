import json
import os
import shutil
import sys
from datetime import datetime
from pathlib import Path

try:
    import tkinter as tk
    from tkinter import filedialog
except Exception:
    tk = None
    filedialog = None

from PIL import Image


ROOT_DIR = Path(__file__).resolve().parents[2]
if str(ROOT_DIR) not in sys.path:
    sys.path.insert(0, str(ROOT_DIR))

from core.utils import clean_vlm_json_output
from core.graph_clustering import BranchAwareLayerCuttingClustering
from core.phase2_codegen import generate_step_files


DEFAULT_CONFIG = {
    "prompt_path": "prompts/phase1_fmb_graph_planner.md",
    "default_images_root": "test/fmb_guiding_input/images",
    "output_root": "test/fmb_output_test/outputs",
    "force_qwen_backend": True,
    "qwen_model_name": "qwen3.5-flash",
    "min_required_images": 3,
}


def load_config() -> dict:
    cfg_path = Path(__file__).resolve().parent / "config.json"
    cfg = dict(DEFAULT_CONFIG)
    if cfg_path.exists():
        with open(cfg_path, "r", encoding="utf-8") as f:
            user_cfg = json.load(f)
        cfg.update(user_cfg)
    return cfg


def pick_case_folder(initial_dir: Path) -> Path:
    if tk is None or filedialog is None:
        raise RuntimeError("tkinter is unavailable. Please provide GUI support for folder picking.")
    root = tk.Tk()
    root.withdraw()
    root.attributes("-topmost", True)
    selected = filedialog.askdirectory(title="Select test image folder", initialdir=str(initial_dir))
    root.destroy()
    if not selected:
        raise RuntimeError("No folder selected.")
    return Path(selected)


def list_pngs(folder: Path):
    return sorted([p for p in folder.iterdir() if p.is_file() and p.suffix.lower() == ".png"])


def resolve_image_folder(selected: Path) -> Path:
    direct = list_pngs(selected)
    if direct:
        return selected

    subdirs = [d for d in selected.iterdir() if d.is_dir()]
    candidates = []
    for d in subdirs:
        imgs = list_pngs(d)
        if imgs:
            candidates.append((len(imgs), d))
    if not candidates:
        raise RuntimeError(f"No PNG images found in '{selected}' or one-level subdirectories.")

    candidates.sort(key=lambda x: (-x[0], str(x[1])))
    return candidates[0][1]


def sort_images(images):
    def key_fn(p: Path):
        stem = p.stem
        return (0, int(stem)) if stem.isdigit() else (1, stem)

    return sorted(images, key=key_fn)


def load_images(image_paths):
    pil_images = []
    for p in image_paths:
        img = Image.open(p)
        pil_images.append(img)
    return pil_images


def extract_json_payload(vlm_output) -> dict:
    if isinstance(vlm_output, dict):
        return vlm_output

    if not isinstance(vlm_output, str):
        vlm_output = str(vlm_output)

    cleaned = clean_vlm_json_output(vlm_output)
    try:
        return json.loads(cleaned)
    except Exception as e:
        raise ValueError(f"Failed to parse VLM JSON output: {e}")


def ensure_qwen(cfg: dict):
    if cfg.get("force_qwen_backend", True):
        os.environ["VLM_BACKEND"] = "qwen"
    if cfg.get("qwen_model_name") and not os.getenv("QWEN_MODEL_NAME"):
        os.environ["QWEN_MODEL_NAME"] = cfg["qwen_model_name"]



def call_vlm(prompt_text: str, pil_images):
    # Import after env override so backend/model resolve correctly.
    from core.vlm import VLMClient

    client = VLMClient()
    content = [prompt_text] + pil_images
    output = client._call_vlm_with_retry(content, is_json_output=True)
    return client, output


def prepare_output_dirs(cfg: dict, case_name: str):
    ts = datetime.now().strftime("%Y_%m_%d_%H_%M_%S")
    out_root = ROOT_DIR / cfg["output_root"]
    run_dir = out_root / f"{ts}_{case_name}"
    images_dir = run_dir / "images"
    codegen_dir = run_dir / "phase2_codegen"
    run_dir.mkdir(parents=True, exist_ok=True)
    images_dir.mkdir(parents=True, exist_ok=True)
    codegen_dir.mkdir(parents=True, exist_ok=True)
    return run_dir, images_dir, codegen_dir


def write_json(path: Path, data: dict):
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, ensure_ascii=True)


def main():
    cfg = load_config()

    prompt_path = ROOT_DIR / cfg["prompt_path"]
    if not prompt_path.exists():
        raise FileNotFoundError(f"Prompt not found: {prompt_path}")

    default_images_root = ROOT_DIR / cfg["default_images_root"]
    if not default_images_root.exists():
        raise FileNotFoundError(f"Image root not found: {default_images_root}")

    selected = pick_case_folder(default_images_root)
    image_folder = resolve_image_folder(selected)
    image_paths = sort_images(list_pngs(image_folder))

    min_required = int(cfg.get("min_required_images", 3))
    if len(image_paths) < min_required:
        raise RuntimeError(
            f"Need at least {min_required} images, found {len(image_paths)} in '{image_folder}'."
        )

    case_name = image_folder.name
    run_dir, images_dir, codegen_dir = prepare_output_dirs(cfg, case_name)

    for p in image_paths:
        shutil.copy2(p, images_dir / p.name)

    prompt_text = prompt_path.read_text(encoding="utf-8")
    pil_images = load_images(image_paths)

    ensure_qwen(cfg)
    client, vlm_output = call_vlm(prompt_text, pil_images)

    if isinstance(vlm_output, dict):
        raw_text = json.dumps(vlm_output, indent=2, ensure_ascii=True)
    else:
        raw_text = str(vlm_output)
    (run_dir / "phase1_raw_output.txt").write_text(raw_text, encoding="utf-8")

    phase1_json = extract_json_payload(vlm_output)
    write_json(run_dir / "phase1_graph.json", phase1_json)

    if not isinstance(phase1_json, dict) or ("objects" not in phase1_json and "V" not in phase1_json):
        raise ValueError("Phase1 output missing expected graph schema ('objects' or 'V/E').")

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
        "case_folder_selected": str(selected),
        "image_folder_used": str(image_folder),
        "image_count": len(image_paths),
        "backend": getattr(client, "backend", "unknown"),
        "model": getattr(client, "model", os.getenv("QWEN_MODEL_NAME", "unknown")),
        "output_dir": str(run_dir),
        "codegen_dir": str(codegen_dir),
        "generated_files": [str(Path(p).name) for p in generated_files],
    }
    write_json(run_dir / "execution_summary.json", summary)

    print("\n========== FMB OUTPUT TEST SUMMARY ==========")
    print(f"Selected Folder: {selected}")
    print(f"Image Folder:    {image_folder}")
    print(f"Images:          {len(image_paths)}")
    print(f"VLM Backend:     {summary['backend']}")
    print(f"VLM Model:       {summary['model']}")
    print(f"Output Dir:      {run_dir}")
    print(f"Codegen Files:   {len(generated_files)}")
    print("=============================================\n")


if __name__ == "__main__":
    main()
