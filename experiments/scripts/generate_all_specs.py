import json
from pathlib import Path

# Precise composition for all 25 scenarios based on user requirements
COMPOSITIONS = {
    "4cubes": {
        "s01": {"cube": 4},
        "s02": {"rectprism": 2, "cube": 2},
        "s03": {"cube": 4},
        "s04": {"long_rectprism": 1, "rectprism": 1, "cube": 2},
        "s05": {"cube": 2, "rectprism": 1, "triangular": 1}
    },
    "5cubes": {
        "s01": {"cube": 4, "rectprism": 1},
        "s02": {"cube": 4, "rectprism": 1},
        "s03": {"cube": 4, "triangular": 1},
        "s04": {"long_rectprism": 1, "rectprism": 2, "cube": 2},
        "s05": {"cube": 3, "rectprism": 1, "triangular": 1}
    },
    "6cubes": {
        "s01": {"rectprism": 5, "triangular": 1},
        "s02": {"cube": 4, "rectprism": 2},
        "s03": {"cube": 4, "rectprism": 2},
        "s04": {"cube": 2, "rectprism": 3, "triangular": 1},
        "s05": {"rectprism": 6}
    },
    "7cubes": {
        "s01": {"cube": 3, "rectprism": 2, "long_rectprism": 1, "triangular": 1},
        "s02": {"cube": 6, "rectprism": 1},
        "s03": {"cube": 3, "long_rectprism": 2, "rectprism": 1, "triangular": 1},
        "s04": {"rectprism": 6, "cube": 1},
        "s05": {"cube": 6, "long_rectprism": 1}
    },
    "8cubes": {
        "s01": {"cube": 2, "rectprism": 4, "long_rectprism": 1, "triangular": 1},
        "s02": {"cube": 2, "rectprism": 5, "triangular": 1},
        "s03": {"cube": 4, "rectprism": 4},
        "s04": {"cube": 6, "long_rectprism": 2},
        "s05": {"rectprism": 8}
    }
}

def generate_specs():
    root = Path("/home/leslie/Projects/VLM_LGP")
    config_dir = root / "experiments/configs"
    config_dir.mkdir(parents=True, exist_ok=True)
    
    for mag, scenarios in COMPOSITIONS.items():
        for s_id, counts in scenarios.items():
            spec = {
                "scenario_id": f"{mag}_{s_id}",
                "image_path": f"experiments/inputs/cubeStacking/{mag}/cube_n{mag[0:2]}_{s_id}.png",
                "counts": counts
            }
            spec_file = config_dir / f"{mag}_{s_id}_target_spec.json"
            spec_file.write_text(json.dumps(spec, indent=2))
            print(f"Created spec: {spec_file.name}")

if __name__ == "__main__":
    generate_specs()
