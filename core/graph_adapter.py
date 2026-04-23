import json


def _extract_supporters(obj):
    """Return normalized supporter edges for a single object entry."""
    edges = obj.get("edges")
    if isinstance(edges, list):
        result = []
        for edge in edges:
            if not isinstance(edge, dict):
                continue
            supporter = edge.get("supporter")
            if isinstance(supporter, int):
                normalized = {"supporter": supporter}
                if "position" in edge and isinstance(edge.get("position"), str):
                    normalized["position"] = edge["position"]
                result.append(normalized)
        return result

    # Backward compatibility: on-list format
    on_list = obj.get("on")
    if isinstance(on_list, list):
        result = []
        for supporter in on_list:
            if supporter == "table":
                result.append({"supporter": 0})
            elif isinstance(supporter, int):
                result.append({"supporter": supporter})
        return result

    return []


def build_graph_from_phase1(plan_json):
    """
    Convert Phase1 JSON into a mathematical directed graph G=(V,E).

    Input schema (current):
      {"objects": [{"id": int, "object": str, "edges": [{"supporter": int, "position"?: str}]}]}

    Output schema:
      {
        "format": "G=(V,E)",
        "V": [{"id": int, "object": str}],
        "E": [{"from": int, "to": int, "position"?: str}],
        "meta": {"vertex_count": int, "edge_count": int}
      }
    """
    if not isinstance(plan_json, dict):
        raise ValueError("Phase1 payload must be a JSON object.")

    objects = plan_json.get("objects")
    if not isinstance(objects, list) or not objects:
        raise ValueError("Phase1 payload must contain a non-empty 'objects' array.")

    vertices = []
    edges = []

    for obj in objects:
        if not isinstance(obj, dict):
            continue
        obj_id = obj.get("id")
        obj_name = obj.get("object")
        if not isinstance(obj_id, int) or not isinstance(obj_name, str):
            continue

        vertices.append({"id": obj_id, "object": obj_name})

        if obj_id == 0:
            continue

        for supporter_edge in _extract_supporters(obj):
            graph_edge = {"from": supporter_edge["supporter"], "to": obj_id}
            if "position" in supporter_edge:
                graph_edge["position"] = supporter_edge["position"]
            edges.append(graph_edge)

    graph = {
        "format": "G=(V,E)",
        "V": sorted(vertices, key=lambda v: v["id"]),
        "E": sorted(edges, key=lambda e: (e["to"], e["from"])),
        "meta": {
            "vertex_count": len(vertices),
            "edge_count": len(edges),
        },
    }

    return graph


def graph_to_pretty_json(graph):
    return json.dumps(graph, indent=2, ensure_ascii=True)