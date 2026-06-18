import json, sys, os, shutil
from pathlib import Path
import importlib.util

sys.path.insert(0, str(Path(__file__).parent.parent))

ROOT_DIR = Path("/home/leslie/Projects/VLM_LGP")

# Load the actual LayerBasedClustering from test folder
module_path = ROOT_DIR / "test/layer_based_clustering/run_layer_based_codegen.py"
spec = importlib.util.spec_from_file_location("layer_based_codegen", str(module_path))
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)
LayerBasedClustering = module.LayerBasedClustering

from core.phase2_codegen import generate_step_files

# Step 1: Load Phase0 layout
layout_path = ROOT_DIR / "generated/phase0_layout.json"
with open(layout_path) as f:
    layout = json.load(f)

print(f"Layout: {len(layout)} objects")

# Step 2: Load Phase1 JSON (VLM output)
phase1_json = json.load(open(ROOT_DIR / "experiments/scenes/fmb/best_3objs.json"))

print(f"Phase1: {len(phase1_json['objects'])} objects")

# Step 3: Clustering (CORRECT VERSION)
clustering = LayerBasedClustering(phase1_json=phase1_json, max_batch_size=2)  # This is the key!
p1_out, p2_out = clustering.build_execution_plan()

print(f"\nClustering result: {p1_out['strategies'][0]['batches']}")

# Step 4: Codegen for smart mode
out_dir = ROOT_DIR / "experiments/evaluations/LGP/FMB_codegen_correct"
if out_dir.exists():
    shutil.rmtree(out_dir)
out_dir.mkdir(parents=True)

print(f"\n=== Codegen (smart) ===")
files = generate_step_files(
    phase1_json=phase1_json,
    prompt1_output=p1_out,
    prompt2_output=p2_out,
    out_dir=str(out_dir),
    inventory_data=layout,
    collision_mode="smart",
)

print(f"Generated {len(files)} files:")

# Show LGP terminals
lgp_files = sorted(out_dir.glob("*.lgp"))
for lgp_file in lgp_files:
    content = lgp_file.read_text()
    terminal = content.split("terminal: ")[1].split(" genericCollisions")[0] if "terminal: " in content else "???"
    print(f"  {lgp_file.name}: {terminal}")

