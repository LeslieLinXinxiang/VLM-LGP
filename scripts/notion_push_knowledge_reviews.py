#!/usr/bin/env python3
import json
import os
import re
import subprocess
from datetime import datetime

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
RUNNER = "/Users/linxinxiang/.agents/skills/notion-rdos/scripts/composio_v3_runner.py"
KB_DB = "c68e2551-adae-8331-994e-01c359821363"
TAGS_DB = "b06e2551-adae-8298-ab15-017991625a1b"
PROJECT_ID = "a2ae2551-adae-82f5-b0cf-016a88b681ef"


def run(tool: str, payload: dict):
    cmd = [
        "python3",
        RUNNER,
        "--tool",
        tool,
        "--payload",
        json.dumps(payload, ensure_ascii=False),
    ]
    out = subprocess.check_output(cmd, stderr=subprocess.STDOUT, text=True)
    m = re.search(r"\{\s*\"successful\"[\s\S]*$", out)
    if not m:
        raise RuntimeError(f"Cannot parse tool output for {tool}:\n{out}")
    resp = json.loads(m.group(0))
    if not resp.get("successful"):
        raise RuntimeError(f"Tool failed {tool}:\n{out}")
    return resp.get("data")


def extract_results(data):
    if isinstance(data, dict):
        if isinstance(data.get("results"), list):
            return data["results"]
        if isinstance(data.get("data"), dict) and isinstance(data["data"].get("results"), list):
            return data["data"]["results"]
    if isinstance(data, list):
        return data
    return []


def find_tag_page_id(name: str):
    data = run("NOTION_SEARCH_NOTION_PAGE", {"query": name})
    for r in extract_results(data):
        parent = r.get("parent", {})
        if parent.get("database_id") != TAGS_DB:
            continue
        title = r.get("properties", {}).get("Tag", {}).get("title", [])
        text = "".join(t.get("plain_text", "") for t in title)
        if text.lower() == name.lower():
            return r.get("id")
    return None


def create_tag(name: str):
    data = run(
        "NOTION_CREATE_NOTION_PAGE",
        {
            "parent_id": TAGS_DB,
            "title": name,
            "markdown": f"# {name}\n",
        },
    )
    return data.get("id")


def ensure_relation_tags(tag_names):
    relation_ids = []
    created = []
    for t in tag_names:
        tag_id = find_tag_page_id(t)
        if not tag_id:
            tag_id = create_tag(t)
            created.append(t)
        relation_ids.append(tag_id)
    return relation_ids, created


def create_kb_page_from_markdown(title: str, markdown_path: str, relation_ids):
    with open(markdown_path, "r", encoding="utf-8") as f:
        markdown = f.read()

    page = run(
        "NOTION_CREATE_NOTION_PAGE",
        {
            "parent_id": KB_DB,
            "title": title,
            "markdown": markdown,
        },
    )
    page_id = page["id"]

    run(
        "NOTION_UPDATE_PAGE",
        {
            "page_id": page_id,
            "data": {
                "Project": [{"id": PROJECT_ID}],
                "relation": [{"id": rid} for rid in relation_ids],
            },
        },
    )

    return page_id, page.get("url")


def main():
    today = datetime.now().strftime("%Y-%m-%d")

    docs = [
        {
            "title": f"[Knowledge Review] Manipulability in VLM-LGP ({today})",
            "path": os.path.join(ROOT, "docs", "ops", "KNOWLEDGE_REVIEW_MANIPULABILITY_VLM_LGP.md"),
            "relation_tags": [
                "knowledge-review",
                "manipulability",
                "robot-kinematics",
                "ik-dls",
                "yoshikawa",
                "phase0",
                "VLM-LGP",
            ],
        },
        {
            "title": f"[Knowledge Review] Graph Clustering in VLM-LGP ({today})",
            "path": os.path.join(ROOT, "docs", "ops", "KNOWLEDGE_REVIEW_GRAPH_CLUSTERING_VLM_LGP.md"),
            "relation_tags": [
                "knowledge-review",
                "graph-clustering",
                "provenance-clustering",
                "execution-pruning",
                "phase2",
                "planning-policy",
                "VLM-LGP",
            ],
        },
    ]

    for doc in docs:
        relation_ids, created = ensure_relation_tags(doc["relation_tags"])
        page_id, page_url = create_kb_page_from_markdown(doc["title"], doc["path"], relation_ids)
        print("TITLE", doc["title"])
        print("PAGE_ID", page_id)
        print("PAGE_URL", page_url)
        print("RELATION_TAG_COUNT", len(relation_ids))
        print("CREATED_TAGS", json.dumps(created, ensure_ascii=False))
        print("---")


if __name__ == "__main__":
    main()
