import json
import math
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

import numpy as np


root = Path(__file__).resolve().parents[2]
sys.path.append(str(root / "test" / "manipulability"))

from urdf_static_manipulability import (  # noqa: E402
    fk_and_jacobian_position,
    load_urdf_chain,
    parse_scene_positions,
)


def main() -> None:
    urdf = root / "rai" / "test" / "newLGP" / "rai-robotModels" / "panda" / "panda_arm_hand.urdf"
    gfile = root / "unnamed.g"

    xml_root = ET.parse(urdf).getroot()
    revolute = []
    for j in xml_root.findall("joint"):
        if j.get("type") in ("revolute", "continuous") and j.find("limit") is not None:
            lim = j.find("limit")
            lo = float(lim.get("lower")) if lim.get("lower") is not None else -math.pi
            hi = float(lim.get("upper")) if lim.get("upper") is not None else math.pi
            revolute.append((j.get("name"), lo, hi))

    chain = load_urdf_chain(str(urdf), base_link="panda_link0", ee_link="panda_hand")
    base_T_world, _ = parse_scene_positions(str(gfile))

    rng = np.random.default_rng(42)
    n_samples = 120000
    qmin = chain.q_lower
    qmax = chain.q_upper
    pts = np.empty((n_samples, 3), dtype=float)

    for i in range(n_samples):
        q = rng.uniform(qmin, qmax)
        p, _ = fk_and_jacobian_position(chain, q, base_T_world=base_T_world)
        pts[i] = p

    base = base_T_world[:3, 3]
    rel = pts - base[None, :]
    r = np.linalg.norm(rel, axis=1)

    summary = {
        "urdf": str(urdf),
        "joint_limits": [
            {
                "joint": n,
                "lower_rad": lo,
                "upper_rad": hi,
                "lower_deg": float(np.degrees(lo)),
                "upper_deg": float(np.degrees(hi)),
            }
            for (n, lo, hi) in revolute
        ],
        "base_origin_world": base.tolist(),
        "workspace_mc": {
            "samples": n_samples,
            "r_max_m": float(np.max(r)),
            "r_p999_m": float(np.quantile(r, 0.999)),
            "xyz_min_world_m": pts.min(axis=0).tolist(),
            "xyz_max_world_m": pts.max(axis=0).tolist(),
        },
    }

    out = root / "generated" / "manipulability_franka_envelope_report.json"
    out.write_text(json.dumps(summary, indent=2), encoding="utf-8")

    print(json.dumps(summary["workspace_mc"], indent=2))
    print(f"saved: {out}")


if __name__ == "__main__":
    main()
