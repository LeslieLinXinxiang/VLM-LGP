#!/usr/bin/env python3
import argparse
import datetime as dt
import json
import os
import re
import subprocess
import sys
from pathlib import Path
from typing import Dict, List, Set, Tuple

TAGS_HUB_DB_ID = "b06e2551-adae-8298-ab15-017991625a1b"
SOURCE_DBS = {
    "knowledge_base": "c68e2551-adae-8331-994e-01c359821363",
    "action_center": "4c1e2551-adae-83aa-bfa0-81f4ea233ecc",
    "experiments_logs": "151e2551-adae-8222-82bb-819a130415bb",
}
ANSI_RE = re.compile(r"\x1b\[[0-9;]*m")


def run_composio_tool(slug: str, payload: dict) -> dict:
    cmd = ["composio", "tools", "execute", slug, "-d", json.dumps(payload)]
    proc = subprocess.run(cmd, capture_output=True, text=True)
    raw = ANSI_RE.sub("", proc.stdout or "")
    idx = raw.find("{")
    if idx == -1:
        raise RuntimeError(f"No JSON response from {slug}: {(proc.stderr or raw)[:400]}")

    data = json.loads(raw[idx:])
    if not data.get("successful", False):
        raise RuntimeError(f"{slug} failed: {data.get('data')}")
    return data.get("data", {})


def query_all_rows(database_id: str) -> List[dict]:
    rows: List[dict] = []
    cursor = None

    while True:
        payload = {"database_id": database_id, "page_size": 100}
        if cursor:
            payload["start_cursor"] = cursor

        data = run_composio_tool("NOTION_QUERY_DATABASE", payload)
        batch = data.get("results", [])
        rows.extend(batch)

        if not data.get("has_more"):
            break
        cursor = data.get("next_cursor")
        if not cursor:
            break

    return rows


def collect_relation_page_ids() -> Set[str]:
    ids: Set[str] = set()

    for name, db_id in SOURCE_DBS.items():
        rows = query_all_rows(db_id)
        for row in rows:
            props = row.get("properties", {})
            rel_prop = props.get("relation", {})
            rel_items = rel_prop.get("relation", []) if isinstance(rel_prop, dict) else []
            for item in rel_items:
                page_id = item.get("id")
                if page_id:
                    ids.add(page_id)

    return ids


def collect_tag_page_ids_from_search() -> Set[str]:
    ids: Set[str] = set()
    cursor = None

    while True:
        payload = {
            "query": "",
            "filter_property": "object",
            "filter_value": "page",
            "page_size": 100,
        }
        if cursor:
            payload["start_cursor"] = cursor

        data = run_composio_tool("NOTION_SEARCH_NOTION_PAGE", payload)
        for page in data.get("results", []):
            parent = page.get("parent", {})
            if parent.get("type") == "database_id" and parent.get("database_id") == TAGS_HUB_DB_ID:
                page_id = page.get("id")
                if page_id:
                    ids.add(page_id)

        if not data.get("has_more"):
            break
        cursor = data.get("next_cursor")
        if not cursor:
            break

    return ids


def extract_tag_name(page: dict) -> str:
    props = page.get("properties", {})
    tag_prop = props.get("Tag", {})
    if tag_prop.get("type") != "title":
        return ""

    title_parts = tag_prop.get("title", [])
    name = "".join(part.get("plain_text", "") for part in title_parts if isinstance(part, dict)).strip()
    return name


def build_tag_map(page_ids: Set[str]) -> Tuple[Dict[str, str], List[str]]:
    tag_map: Dict[str, str] = {}
    failed: List[str] = []

    for page_id in sorted(page_ids):
        try:
            page = run_composio_tool("NOTION_RETRIEVE_PAGE", {"page_id": page_id})
            parent = page.get("parent", {})
            if parent.get("type") != "database_id" or parent.get("database_id") != TAGS_HUB_DB_ID:
                # Skip non-tag pages that might have been linked by mistake.
                continue

            tag_name = extract_tag_name(page)
            if not tag_name:
                failed.append(f"{page_id}:missing_tag_title")
                continue

            tag_map[tag_name] = page_id
        except Exception as exc:
            failed.append(f"{page_id}:{exc}")

    return tag_map, failed


def load_existing_cache(path: Path) -> dict:
    if not path.exists():
        return {"meta": {}, "tags": {}}

    try:
        with path.open("r", encoding="utf-8") as f:
            return json.load(f)
    except Exception:
        return {"meta": {}, "tags": {}}


def write_cache(path: Path, tag_map: Dict[str, str]) -> None:
    payload = {
        "meta": {
            "version": 1,
            "workspace": "Research Space",
            "tags_hub_database_id": TAGS_HUB_DB_ID,
            "updated_at": dt.datetime.now(dt.UTC).replace(microsecond=0).isoformat().replace("+00:00", "Z"),
            "source": "refresh_tag_cache_script",
        },
        "tags": {k: tag_map[k] for k in sorted(tag_map.keys(), key=lambda s: s.lower())},
    }

    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8") as f:
        json.dump(payload, f, ensure_ascii=False, indent=2)
        f.write("\n")


def main() -> int:
    parser = argparse.ArgumentParser(description="Rebuild notion-rdos tags cache from current Notion relations.")
    parser.add_argument(
        "--cache-path",
        default=str(Path(__file__).resolve().parents[1] / "config" / "tags_cache.json"),
        help="Path to tags_cache.json to update.",
    )
    args = parser.parse_args()

    cache_path = Path(args.cache_path)
    old_cache = load_existing_cache(cache_path)
    old_tags = old_cache.get("tags", {}) if isinstance(old_cache, dict) else {}

    relation_page_ids = collect_relation_page_ids()
    search_page_ids = collect_tag_page_ids_from_search()
    all_page_ids = relation_page_ids | search_page_ids
    new_tags, failed_items = build_tag_map(all_page_ids)

    write_cache(cache_path, new_tags)

    old_names = set(old_tags.keys())
    new_names = set(new_tags.keys())
    added = sorted(new_names - old_names)
    removed = sorted(old_names - new_names)

    print("refresh_tag_cache completed")
    print(f"cache_path: {cache_path}")
    print(f"total_tags: {len(new_tags)}")
    print(f"added_tags: {len(added)}")
    print(f"removed_tags: {len(removed)}")
    print(f"failed_items: {len(failed_items)}")

    if added:
        print("added_list:")
        for name in added:
            print(f"  + {name}")
    if removed:
        print("removed_list:")
        for name in removed:
            print(f"  - {name}")
    if failed_items:
        print("failed_list:")
        for item in failed_items:
            print(f"  ! {item}")

    return 0


if __name__ == "__main__":
    sys.exit(main())
