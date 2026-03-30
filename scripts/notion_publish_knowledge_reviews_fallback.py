#!/usr/bin/env python3
import json
import os
import re
import subprocess
from datetime import datetime

RUNNER = "/Users/linxinxiang/.agents/skills/notion-rdos/scripts/composio_v3_runner.py"
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
KB_DB = "c68e2551-adae-8331-994e-01c359821363"
PROJECT_ID = "a2ae2551-adae-82f5-b0cf-016a88b681ef"


def call(tool: str, payload: dict):
    cmd = ["python3", RUNNER, "--tool", tool, "--payload", json.dumps(payload, ensure_ascii=False)]
    out = subprocess.check_output(cmd, stderr=subprocess.STDOUT, text=True)
    m = re.search(r"\{\s*\"successful\"[\s\S]*$", out)
    if not m:
        raise RuntimeError(f"Cannot parse response for {tool}:\n{out}")
    resp = json.loads(m.group(0))
    return resp, out


def extract_results(data):
    if isinstance(data, dict):
        if isinstance(data.get("results"), list):
            return data["results"]
        if isinstance(data.get("data"), dict) and isinstance(data["data"].get("results"), list):
            return data["data"]["results"]
    if isinstance(data, list):
        return data
    return []


def page_title(page: dict) -> str:
    props = page.get("properties", {})
    for key, val in props.items():
        if val.get("type") == "title":
            arr = val.get("title", [])
            return "".join(x.get("plain_text", "") for x in arr)
    return ""


def search_kb_pages(query: str):
    resp, _ = call("NOTION_SEARCH_NOTION_PAGE", {"query": query})
    if not resp.get("successful"):
        return []
    return [
        p for p in extract_results(resp.get("data", {}))
        if p.get("parent", {}).get("database_id") == KB_DB
    ]


def ensure_relation_tag_page(tag_name: str) -> str:
    title = f"[REL-TAG] {tag_name}"
    pages = search_kb_pages(title)
    for p in pages:
        if page_title(p).strip() == title:
            return p["id"]

    resp, out = call(
        "NOTION_CREATE_NOTION_PAGE",
        {
            "parent_id": KB_DB,
            "title": title,
            "markdown": f"# {title}\n\nrelation-tag helper page for KB docs.\n",
        },
    )
    if not resp.get("successful"):
        raise RuntimeError(f"create tag page failed: {out}")
    return resp["data"]["id"]


def create_doc_page(title: str, markdown_path: str) -> dict:
    with open(markdown_path, "r", encoding="utf-8") as f:
        md = f.read()
    resp, out = call(
        "NOTION_CREATE_NOTION_PAGE",
        {
            "parent_id": KB_DB,
            "title": title,
            "markdown": md,
        },
    )
    if not resp.get("successful"):
        raise RuntimeError(f"create doc page failed: {out}")
    return resp["data"]


def update_project_and_relations(page_id: str, relation_ids: list):
    payload_data = {
        "page_id": page_id,
        "data": {
            "Project": [{"id": PROJECT_ID}],
            "relation": [{"id": rid} for rid in relation_ids],
        },
    }
    resp, out = call("NOTION_UPDATE_PAGE", payload_data)
    if resp.get("successful"):
        return

    payload_props = {
        "page_id": page_id,
        "properties": {
            "Project": {"relation": [{"id": PROJECT_ID}]},
            "relation": {"relation": [{"id": rid} for rid in relation_ids]},
        },
    }
    resp2, out2 = call("NOTION_UPDATE_PAGE", payload_props)
    if not resp2.get("successful"):
        raise RuntimeError(f"update page failed:\n{out}\n---\n{out2}")


def main():
    today = datetime.now().strftime("%Y-%m-%d")

    manip_tags = [
        "knowledge-review",
        "manipulability",
        "robot-kinematics",
        "ik-dls",
        "yoshikawa",
        "phase0",
        "VLM-LGP",
    ]
    graph_tags = [
        "knowledge-review",
        "graph-clustering",
        "provenance-clustering",
        "execution-pruning",
        "phase2",
        "planning-policy",
        "VLM-LGP",
    ]

    manip_rel_ids = [ensure_relation_tag_page(t) for t in manip_tags]
    graph_rel_ids = [ensure_relation_tag_page(t) for t in graph_tags]

    manip_page = create_doc_page(
        f"[Knowledge Review] Manipulability in VLM-LGP ({today})",
        os.path.join(ROOT, "docs", "ops", "KNOWLEDGE_REVIEW_MANIPULABILITY_VLM_LGP.md"),
    )
    update_project_and_relations(manip_page["id"], manip_rel_ids)

    graph_page = create_doc_page(
        f"[Knowledge Review] Graph Clustering in VLM-LGP ({today})",
        os.path.join(ROOT, "docs", "ops", "KNOWLEDGE_REVIEW_GRAPH_CLUSTERING_VLM_LGP.md"),
    )
    update_project_and_relations(graph_page["id"], graph_rel_ids)

    print("MANIP_PAGE_ID", manip_page["id"])
    print("MANIP_PAGE_URL", manip_page.get("url"))
    print("GRAPH_PAGE_ID", graph_page["id"])
    print("GRAPH_PAGE_URL", graph_page.get("url"))
    print("MANIP_RELATION_COUNT", len(manip_rel_ids))
    print("GRAPH_RELATION_COUNT", len(graph_rel_ids))


if __name__ == "__main__":
    main()
