import json, sys, Path
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent.parent))

from core.phase2_codegen import generate_step_files
from core.graph_clustering import BranchAwareClustering

# Load Phase 1 JSON (VLM output)
with open("experiments/scenes/fmb/best_3objs.json", "r") as f:
    phase1_json = json.load(f)

# Create base layout from scene
layout = [
    {"id": 0, "object": "table"},
    {"id": 1, "object": "shape_2", "color": "green"},
    {"id": 2, "object": "shape_2", "color": "red"},
    {"id": 3, "object": "shape_4", "color": "blue"}
]

# Clustering
print("=== Clustering ===")
clustering = BranchAwareClustering(phase1_json=phase1_json, max_batch_size=99)
plan = clustering.build_execution_plan()
print(f"Prompt1 strategies: {len(plan['prompt1']['strategies'])}")
print(f"Selected: {plan['prompt2']['selected']}")
print(json.dumps(plan["prompt1"]["strategies"], indent=2))

# Codegen
print("\n=== Codegen (Global) ===")
generate_step_files(
    phase1_json=phase1_json,
    prompt1_output=plan["prompt1"],
    prompt2_output=plan["prompt2"],
    out_dir="experiments/evaluations/LGP/FMB_test_codegen_global",
    inventory_data=layout,
    collision_mode="global",
)

print("\n=== Codegen (Smart) ===")
generate_step_files(
    phase1_json=phase1_json,
    prompt1_output=plan["prompt1"],
    prompt2_output=plan["prompt2"],
    out_dir="experiments/evaluations/LGP/FMB_test_codegen_smart",
    inventory_data=layout,
    collision_mode="smart",
)
