import json
import math
import os
import re
from typing import Dict, List, Tuple


_ARM_BASE_PATTERN = re.compile(
    r"Edit\s+l_panda_base\b[^\n]*\{\s*Q:\s*\"[^\"]*t\(([^)]+)\)",
    re.IGNORECASE,
)
_TRANSLATION_PATTERN = re.compile(r"Q:\s*\"[^\"]*t\(([^)]+)\)", re.IGNORECASE)
_SHAPE_PATTERN = re.compile(r"shape\s*:\s*([A-Za-z_][\w]*)", re.IGNORECASE)
_COLOR_PATTERN = re.compile(r"color\s*:\s*\[([^\]]+)\]", re.IGNORECASE)
_SIZE_PATTERN = re.compile(r"size\s*:\s*\[([^\]]+)\]", re.IGNORECASE)
_MESH_PATTERN = re.compile(r"mesh\s*:\s*\"([^\"]+)\"", re.IGNORECASE)


def _parse_float_triplet(raw: str) -> Tuple[float, float, float]:
    parts = [p for p in raw.replace(",", " ").split() if p]
    nums = [float(p) for p in parts]
    if len(nums) < 3:
        raise ValueError(f"Expected at least 3 floats, got: {raw}")
    return nums[0], nums[1], nums[2]


def _parse_color(raw: str) -> List[float]:
    parts = [p for p in raw.replace(",", " ").split() if p]
    return [float(p) for p in parts]


def _normalize_shape(shape: str) -> str:
    s = shape.lower()
    if s == "cylinder":
        return "cylinder"
    if s in {"ssbox", "box"}:
        return "box"
    if s == "mesh":
        return "mesh"
    return s


def _parse_size(raw: str) -> List[float]:
    parts = [p for p in raw.replace(",", " ").split() if p]
    return [float(p) for p in parts]


def _is_near(a: float, b: float, eps: float = 1e-5) -> bool:
    return abs(a - b) <= eps


def _to_size_signature(shape: str, raw_size: List[float]) -> List[float]:
    if not raw_size:
        return []

    if shape == "box":
        # ssBox is usually [x y z rounding]
        if len(raw_size) >= 3:
            return [raw_size[0], raw_size[1], raw_size[2]]
        return raw_size

    if shape == "cylinder":
        # cylinder is commonly [height radius]
        if len(raw_size) >= 2:
            h, r = raw_size[0], raw_size[1]
            d = 2.0 * r
            return [d, d, h]
        return raw_size

    # mesh or other shapes
    if len(raw_size) >= 3:
        return [raw_size[0], raw_size[1], raw_size[2]]
    return raw_size


def _classify_object_type(shape: str, logical_id: str, size_signature: List[float], mesh_path: str) -> str:
    if shape == "cylinder":
        return "cylinder"

    if shape == "box":
        if len(size_signature) >= 3:
            x, y, z = size_signature[0], size_signature[1], size_signature[2]
            if _is_near(x, y) and _is_near(y, z):
                return "cube"
        return "rectprism"

    if shape == "mesh":
        mesh_l = (mesh_path or "").lower()
        lid_l = logical_id.lower()
        if "tri" in mesh_l or "prism" in mesh_l or "tri" in lid_l:
            return "triprism"
        return "mesh"

    return shape


def _load_scene_text(scene_path: str) -> str:
    if not os.path.exists(scene_path):
        raise FileNotFoundError(f"Scene file not found: {scene_path}")
    with open(scene_path, "r") as f:
        return f.read()


def _extract_arm_base_xyz(scene_text: str) -> Tuple[float, float, float]:
    m = _ARM_BASE_PATTERN.search(scene_text)
    if not m:
        return (0.0, 0.0, 0.0)
    return _parse_float_triplet(m.group(1))


def _extract_objects(scene_text: str) -> List[Dict]:
    objects = []
    for raw_line in scene_text.splitlines():
        line = raw_line.strip()
        if not line or line.startswith("#"):
            continue
        if "logical" not in line or "is_object" not in line:
            continue

        name_match = re.match(r"^([A-Za-z_][\w]*)\s*\(", line)
        if not name_match:
            continue

        frame_name = name_match.group(1)
        logical_match = re.search(r"logical\s*:\s*\{([^}]*)\}", line, re.IGNORECASE)
        if not logical_match:
            continue

        logical_flags = logical_match.group(1)
        if "is_object" not in logical_flags:
            continue

        trans_match = _TRANSLATION_PATTERN.search(line)
        shape_match = _SHAPE_PATTERN.search(line)
        color_match = _COLOR_PATTERN.search(line)
        size_match = _SIZE_PATTERN.search(line)
        mesh_match = _MESH_PATTERN.search(line)

        if not trans_match or not shape_match or not color_match:
            continue

        x, y, z = _parse_float_triplet(trans_match.group(1))
        color = _parse_color(color_match.group(1))
        raw_size = _parse_size(size_match.group(1)) if size_match else []

        normalized_shape = _normalize_shape(shape_match.group(1))
        size_signature = _to_size_signature(normalized_shape, raw_size)
        mesh_path = mesh_match.group(1) if mesh_match else ""
        object_type = _classify_object_type(normalized_shape, frame_name, size_signature, mesh_path)

        objects.append(
            {
                "logical_id": frame_name,
                "shape": normalized_shape,
                "object_type": object_type,
                "size_signature": size_signature,
                "color_rgb": color[:3],
                "position": [x, y, z],
            }
        )

    return objects


def build_phase0_assets_from_named_scene(
    scene_named_path: str,
    specs_output_path: str,
    unnamed_scene_output_path: str,
) -> Dict:
    """
    Reverse-builds Phase0 assets from a named scene.

    Outputs:
      - specs.json (anon_id, shape, color_rgb)
      - unnamed.g (logical frame names replaced by anon ids)

    Returns:
      {
        "mapping": [{anon_id, logical_id, shape, color_rgb}, ...],
        "arm_base": [x, y, z]
      }
    """
    scene_text = _load_scene_text(scene_named_path)
    arm_base = _extract_arm_base_xyz(scene_text)
    objects = _extract_objects(scene_text)

    if not objects:
        raise ValueError("No object frames with logical:{is_object} found in named scene.")

    def sort_key(obj: Dict):
        x, y, z = obj["position"]
        dx = x - arm_base[0]
        dy = y - arm_base[1]
        dz = z - arm_base[2]
        distance = math.sqrt(dx * dx + dy * dy + dz * dz)
        return (distance, y, x, obj["logical_id"])

    objects_sorted = sorted(objects, key=sort_key)

    mapping = []
    specs = []
    renamed_text = scene_text

    # Replace longer names first to avoid partial replacement collisions.
    replace_pairs = []
    for idx, obj in enumerate(objects_sorted, start=1):
        anon_id = f"obj_{idx:02d}"
        logical_id = obj["logical_id"]
        replace_pairs.append((logical_id, anon_id))

        mapping_item = {
            "anon_id": anon_id,
            "logical_id": logical_id,
            "shape": obj["shape"],
            "object_type": obj["object_type"],
            "size_signature": obj["size_signature"],
            "color_rgb": obj["color_rgb"],
        }
        mapping.append(mapping_item)
        specs.append(
            {
                "anon_id": anon_id,
                "shape": obj["shape"],
                "object_type": obj["object_type"],
                "size_signature": obj["size_signature"],
                "color_rgb": obj["color_rgb"],
            }
        )

    for logical_id, anon_id in sorted(replace_pairs, key=lambda p: len(p[0]), reverse=True):
        pattern = re.compile(rf"\b{re.escape(logical_id)}\b")
        renamed_text = pattern.sub(anon_id, renamed_text)

    os.makedirs(os.path.dirname(specs_output_path), exist_ok=True)
    with open(specs_output_path, "w") as f:
        json.dump(specs, f, indent=2)

    os.makedirs(os.path.dirname(unnamed_scene_output_path), exist_ok=True)
    with open(unnamed_scene_output_path, "w") as f:
        f.write(renamed_text)

    return {"mapping": mapping, "arm_base": list(arm_base)}
