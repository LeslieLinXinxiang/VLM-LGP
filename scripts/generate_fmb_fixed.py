import json, math, random, os
from pathlib import Path

ROOT_DIR = Path(__file__).resolve().parents[1]
CFG_FILE = ROOT_DIR / "experiments/configs/fmb_region_config.json"

def main():
    with open(CFG_FILE, "r") as f:
        cfg = json.load(f)
        
    counts = {
        "shape_1": 0,
        "shape_2": 2,
        "shape_3": 0,
        "shape_4": 1
    }
    
    # Simple naive sampling
    rng = random.Random(42)
    min_dist = 0.18 # Increase distance
    
    sampled = []
    trials = 0
    while len(sampled) < 3 and trials < 10000:
        trials += 1
        region = rng.choice(cfg["regions"]["init_regions"])
        x = rng.uniform(region["x"][0], region["x"][1])
        y = rng.uniform(region["y"][0], region["y"][1])
        
        ok = True
        for prev in sampled:
            if math.hypot(x - prev["x"], y - prev["y"]) < min_dist:
                ok = False
                break
        if ok:
            sampled.append({"x": x, "y": y, "yaw": rng.uniform(-180, 180)})
            
    print(sampled)
main()
