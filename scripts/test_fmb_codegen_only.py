import json, sys, os, shutil
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent.parent))

from core.phase2_codegen import generate_step_files
from core.graph_clustering import BranchAwareClustering

ROOT_DIR = Path("/home/leslie/Projects/VLM_LGP")

# Step 1: Load Phase0 layout
layout_path = ROOT_DIR / "generated/phase0_layout.json"
with open(layout_path) as f:
    layout = json.load(f)

print(f"Layout: {len(layout)} objects")
print(json.dumps(layout[:2], indent=2))

# Step 2: Load Phase1 JSON (VLM output)
phase1_json = json.load(open(ROOT_DIR / "experiments/scenes/fmb/best_3objs.json"))

print(f"\nPhase1: {len(phase1_json['objects'])} objects")

# Step 3: Clustering
clustering = BranchAwareClustering(phase1_json=phase1_json)
p1_out, p2_out = clustering.generate_optimal_strategy()

print(f"\nClustering result: {p1_out['strategies'][0]['batches']}")

# Step 4: Codegen for both modes
for collision_mode in ["global", "smart"]:
    out_dir = ROOT_DIR / f"experiments/evaluations/LGP/FMB_codegen_test_{collision_mode}"
    if out_dir.exists():
        shutil.rmtree(out_dir)
    out_dir.mkdir(parents=True)
    
    print(f"\n=== Codegen ({collision_mode}) ===")
    files = generate_step_files(
        phase1_json=phase1_json,
        prompt1_output=p1_out,
        prompt2_output=p2_out,
        out_dir=str(out_dir),
        inventory_data=layout,
        collision_mode=collision_mode,
    )
    
    print(f"Generated {len(files)} files:")
    for f in files:
        print(f"  - {Path(f).name}")
    
    # Show LGP terminals
    for lgp_file in sorted(out_dir.glob("*.lgp")):
        content = lgp_file.read_text()
        terminal = content.split("terminal: ")[1].split(" genericCollisions")[0] if "terminal: " in content else "???"
        print(f"  {lgp_file.name}: {terminal}")

