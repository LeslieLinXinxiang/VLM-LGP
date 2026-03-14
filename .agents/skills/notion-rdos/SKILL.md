---
name: notion-rdos
description: "Interact with Leslie's Notion Global R&D OS. Use for: writing daily logs (日报), creating knowledge base documents, adding Action Center todos, linking KB pages to daily reports, and in-session progress sync to existing daily report/todo pages when explicitly requested. Covers DB routing, auto-fill vs must-confirm protocol, content templates, composio API execution. DO NOT USE FOR: general coding tasks; bulk editing unrelated historical pages. TRIGGER PHRASES: 日报, 知识库, KB文档, Action Center todo, 写入 Notion, Notion 归档, 实验记录, 总结今天, 同步进展, 更新todo进展."
argument-hint: "daily-report | kb-doc | todo | link-kb-to-log | progress-sync"
---

# Notion R&D OS — Interaction Skill

Skill Version: v1.4

## Infrastructure

| Database | ID |
|---|---|
| 🎯 Projects Hub | `6e1e2551-adae-837c-ae1e-81a32360f6fe` |
| ⚡ Action Center | `4c1e2551-adae-83aa-bfa0-81f4ea233ecc` |
| 🔬 Experiments & Logs | `151e2551-adae-8222-82bb-819a130415bb` |
| 🧠 Knowledge Base | `c68e2551-adae-8331-994e-01c359821363` |
| #️⃣ Tags Hub | `b06e2551-adae-8298-ab15-017991625a1b` |

**Known Project Relations:**
- VLM-LGP: `a2ae2551-adae-82f5-b0cf-016a88b681ef`

**Tag Cache File:**
- `/home/leslie/.copilot/skills/notion-rdos/config/tags_cache.json`
- `/home/leslie/.agents/skills/notion-rdos/config/tags_cache.json` (mirror)

---

## Execution Protocol

Before ANY Notion write, evaluate each field:

### A. Auto-fill (decide silently, mention in final response)

| Field | Allowed Values |
|---|---|
| `Experiment Type` | Setup, Debug, Benchmark, Ablation, Prompt, Scene, Real Robot |
| `relation` (tag links) | Resolve from Tags Hub via cache-first + live fallback |

Tag decision principles:
- Always infer tags from title + body content (not title-only).
- Prefer existing tags from Tags Hub.
- Multiple tags are allowed (multi-relation).
- If a candidate tag is missing in both cache and Notion live lookup, ask user before creating new tag.

### B. Must-Confirm (deduce from context, then HALT and ask)

- `Title` / `Task Name`
- `Project` (relation ID)
- `Content` / Markdown body outline
- `New tag creation` when any candidate tag is not found in Tags Hub

**Action:** Output deduced values to the user, then say:
> 请确认以上信息（标题/关联项目/正文大纲，以及是否创建新标签）是否准确？确认后我将写入 Notion。

**Only execute after explicit user confirmation ("Yes" / "确认").** Do not execute speculatively.

Exception for progress-sync:
- If user explicitly asks to "update/sync progress" for existing daily report/todo in current session, do not re-confirm title/project/content when target pages are unambiguous.
- Ask clarification only when target page identity is ambiguous.

### C. Timestamp Acquisition SOP (Unified)
For any write that includes `Date`, `Due Date`, daily-report day key, or roadmap-like timestamp fields:
1. Fetch current local time first from terminal:
    - `date '+%Y-%m-%d %H:%M %z'`
2. Then derive required format explicitly:
    - Date-only fields: `date '+%Y-%m-%d'`
    - Roadmap-style timestamp fields: `YYYY-MM-DD HH:MM` (from step 1; drop timezone)
3. If user explicitly provides timestamp/date, use user-provided value as source of truth.
4. Never guess minute-level time.

### D. Runtime / Schema Preflight (Mandatory on First DB Touch in a Session)

Before the first write to any Notion database in the current session:
1. Use `python3`, never `python`, for all subprocess wrappers in terminal execution.
2. Run exactly one schema preflight for that target DB:
    - preferred: `NOTION_FETCH_DATABASE`
    - fallback: `NOTION_FETCH_ROW` on a known row from that DB
3. Cache the real property names and valid options in-session and reuse them.
4. Do not assume generic fields such as `Experiment Type` exist unless the live schema confirms them.
5. For title extraction during local filtering, detect the property whose `type == "title"`; do not hardcode `Task Name` / `Experiment` unless already confirmed by schema.

---

## Tag Resolution Protocol (Cache-First + Live Fallback)

Use this protocol for KB / Daily Report / Action Center tag linking.

### Why this design
- Avoid full Tags Hub scan every run.
- Still catches user-added tags quickly (even if added 1 hour ago).
- Keeps token/API usage low by only live-checking cache misses.

### Step-by-step
1. Load `tags_cache.json` into map: `tag_name -> tag_page_id`.
2. Extract candidate tags from full content (title + body + strong keywords).
3. For each candidate:
- Cache hit: use cached `tag_page_id`.
- Cache miss: run live exact lookup with `NOTION_SEARCH_NOTION_PAGE` and verify page parent is Tags Hub.
4. If live lookup finds tag page:
- Append to resolved set.
- Upsert this mapping into cache file.
5. If live lookup still misses:
- Add to `new_tag_candidates`.
- Ask user whether to create each missing tag.
6. Only after user confirms, create missing tag pages and write final `relation`.

### Important API limitation
`NOTION_QUERY_DATABASE` / `NOTION_FETCH_DATABASE` may fail for Tags Hub because this DB uses multiple data sources in current Notion API version. For tag resolution, prefer:
- `NOTION_SEARCH_NOTION_PAGE` (page search)
- `NOTION_RETRIEVE_PAGE` (verify page properties and parent DB)

### Cache refresh policy
- No TTL-based forced full scan.
- Default: lazy live resolve on cache miss.
- Full rebuild only when user explicitly requests: `refresh tag cache`.

### Refresh Tag Cache (Explicit Command)
Trigger phrases:
- `refresh tag cache`
- `rebuild tag cache`
- `重建标签缓存`

Command:
- `python /home/leslie/.copilot/skills/notion-rdos/scripts/refresh_tag_cache.py`
- Mirror path: `python /home/leslie/.agents/skills/notion-rdos/scripts/refresh_tag_cache.py`

Execution steps:
1. Read all pages linked from KB/Action Center/Experiments `relation` fields and collect unique tag page IDs.
2. For each tag page ID, call `NOTION_RETRIEVE_PAGE` and extract `Tag` title as canonical tag name.
3. Rebuild `tags_cache.json` as:
    - `meta.updated_at` = current timestamp
    - `tags` = full `tag_name -> tag_page_id` mapping
4. Keep cache sorted by tag name for stable diffs.
5. Report summary to user:
    - total tags
    - added tags
    - removed tags
    - renamed tags (if detectable)

Failure fallback:
- If a page is unreadable, skip and include it in `failed_items` report.
- Do not block normal writes; keep old cache until rebuild succeeds.

---

## Workflow 1 — Daily Report (Experiments & Logs)

**Target DB:** `151e2551-adae-8222-82bb-819a130415bb`

**Title format:** `YYMMDD - [Core Topic in English]`
Example: `260309 - Phase0 Interface Refinement and VLM Agent Debugging (VLM-LGP)`

**Required properties:**
- `Date`: today's date in `YYYY-MM-DD`
- `Project`: relation to project page ID
- `relation`: resolved tag page IDs from Tag Resolution Protocol

**Optional properties (only if confirmed by live schema):**
- `Experiment Type`: auto-selected when this property actually exists in the target DB
- `Result`: set when the outcome is clearly positive / negative / inconclusive

**Markdown body template:**
Read from `templates/daily_report.md` relative to this SKILL.md location.
**Must-Follow Rule:** You MUST NOT modify the structure, headings, or emojis of the template. Only fill in the bullet points and brackets.
⚠️ **CRITICAL: The entire content (bullet points, summaries, etc.) and title of the daily report MUST be written in English.**

---

## Workflow 2 — Knowledge Base Document

**Target DB:** `c68e2551-adae-8331-994e-01c359821363`

**Required properties:**
- `Project`: relation to project page ID
- `relation`: resolved tag page IDs from Tag Resolution Protocol
- `Tags` (legacy multi-select): optional compatibility field; do not treat as source of truth

**Steps:**
1. Confirm Title and outline with user (Must-Confirm)
2. Create the page with `NOTION_CREATE_NOTION_PAGE`
3. If additional code/content blocks needed, use `NOTION_APPEND_CODE_BLOCKS` and `NOTION_APPEND_TEXT_BLOCKS` for blocks > 2000 chars (split each `rich_text.content` at <=1990 chars)
4. Resolve tags using Tag Resolution Protocol
5. `NOTION_UPDATE_PAGE` to write `Project` and `relation`
6. Retrieve the page `url` from API response

---

## Workflow 3 — Action Center Todo

**Target DB:** `4c1e2551-adae-83aa-bfa0-81f4ea233ecc`

**Required properties:**
- `Status`: MUST be exactly `To Do`
- `Due Date`: leave empty unless user explicitly provides a deadline
- `Project`: relation to project page ID
- `relation`: resolved tag page IDs from Tag Resolution Protocol

**Steps:**
1. Confirm Task Name and Project with user (Must-Confirm)
2. Execute single `NOTION_CREATE_NOTION_PAGE` call per todo item
3. Resolve tags from title/body context
4. `NOTION_UPDATE_PAGE` to set `Status`, `Project`, `relation`, optional `Due Date`

### 3.1 Status Scope & Move Rules (Action Center)

When user asks to "check current todos" or "sync todo status", ALWAYS inspect these three columns together:
- `To Do`
- `In Progress`
- `Blocked`

`Done` should be read as reference when needed (to avoid duplicate move or duplicate completion).

Supported explicit status moves:
- `To Do -> In Progress`
- `In Progress -> Done`
- `Blocked -> In Progress`
- `To Do/In Progress/Blocked -> Done`

If user gives an ambiguous instruction like "move this to done" without clear task identity, ask for disambiguation first.

---

## Workflow 4 — Multi-Task: KB Doc + Daily Report (Linked)

When user requests both a document and a daily report in the same session:

1. **Execute KB doc first** (Workflow 2) -> get `url` from response
2. **Execute daily report** (Workflow 1) -> embed the KB doc URL in body, under section 3 (Actions Taken) or a dedicated "知识库归档" heading

---

## Workflow 5 — In-Session Progress Sync (Daily + Existing Todo)

Use this workflow when user asks to update progress mid-task (e.g., "更新日报和todo进展", "把这个闭环写到日报和todo里").

Goal:
- Append one concise progress block to today's daily report page.
- Append one concise progress block to an existing Action Center todo page.
- Optionally update `relation` when user provides new tag signals in this update.

Token-saving execution order (mandatory):
1. Run ONE `NOTION_QUERY_DATABASE` snapshot for Action Center; filter locally by Project + (`To Do|In Progress|Blocked`) and match target todo title keywords.
2. Resolve today's daily report page with at most one query/search.
3. Append blocks with `NOTION_APPEND_TEXT_BLOCKS`.
4. If new tag signals appear, run Tag Resolution Protocol and patch `relation` once.
5. Do not do post-write re-query unless user asks.

Append block shape (only supported block types):
- `heading_2`
- `paragraph`
- `bulleted_list_item`

Do not use unsupported block types in this tool wrapper (for example `divider`).

Append API note:
- `NOTION_APPEND_TEXT_BLOCKS` uses `block_id`, not `page_id`. For page-level appends, pass the page id as `block_id`.

---

## API Execution Standard

**Tools:**
- `NOTION_CREATE_NOTION_PAGE` — creates a page (title + markdown content only; never use `NOTION_INSERT_ROW`)
- `NOTION_UPDATE_PAGE` — sets DB properties (Status, Due Date, Project, relation, etc.) after creation
- `NOTION_APPEND_TEXT_BLOCKS` — append headings, paragraphs, bullets
- `NOTION_APPEND_CODE_BLOCKS` — append code blocks (split at <=1990 chars per `rich_text.content`)
- `NOTION_QUERY_DATABASE` — fetch rows (status board snapshots, project filtering)
- `NOTION_SEARCH_NOTION_PAGE` — tag live lookup and title-based discovery
- `NOTION_RETRIEVE_PAGE` — validate tag page parent/properties

> ⚠️ **CRITICAL:** `NOTION_CREATE_NOTION_PAGE` does NOT have a `data` or `properties` parameter. It only accepts `parent_id`, `title`, `markdown`, `icon`, `cover`. All DB properties must be set via separate `NOTION_UPDATE_PAGE`.

**Always use Python subprocess** to avoid JSON escaping issues.

Execution notes:
- Use `python3` in shell examples and automation snippets.
- `NOTION_QUERY_DATABASE` rows are returned under `data.results`.
- Strip ANSI color codes before JSON parsing.
- For large query payloads, parse locally first and only print filtered matches instead of dumping the full response.

```python
import json, subprocess, re

create_payload = {
    "parent_id": "<DATABASE_ID>",
    "title": "<PAGE_TITLE>",
    "markdown": "<MARKDOWN_CONTENT>"
}
result = subprocess.run(
    ["composio", "tools", "execute", "NOTION_CREATE_NOTION_PAGE", "-d", json.dumps(create_payload)],
    capture_output=True, text=True
)
clean = re.sub(r'\x1b\[[0-9;]*m', '', result.stdout)
data = json.loads(clean[clean.find('{'):])
page_id = data["data"]["id"]

update_payload = {
    "page_id": page_id,
    "properties": {
        "Project": {"relation": [{"id": "<PROJECT_PAGE_ID>"}]},
        "relation": {"relation": [{"id": "<TAG_PAGE_ID_1>"}, {"id": "<TAG_PAGE_ID_2>"}]}
    }
}
subprocess.run(
    ["composio", "tools", "execute", "NOTION_UPDATE_PAGE", "-d", json.dumps(update_payload)],
    capture_output=True, text=True
)
```

### API Efficiency Rule (Critical)

To avoid repeated API probing and redundant calls:
1. Cache-first for tags; live lookup only for cache misses.
2. For Action Center check/update, do ONE `NOTION_QUERY_DATABASE` snapshot first.
3. Resolve target page IDs locally before write.
4. Perform only necessary `NOTION_UPDATE_PAGE` calls (one per actual change batch).
5. Do not re-query after each single update unless user explicitly asks.

Default execution order:
- Query once -> local filter/map -> resolve tags -> ask clarification if ambiguous -> batch updates -> final summary.

Fast debug path when a write fails:
1. Inspect the error for the exact missing or invalid property / field.
2. If the error is schema-related, run one `NOTION_FETCH_DATABASE` or `NOTION_FETCH_ROW` and patch the payload instead of retrying blindly.
3. If the error is append-related, verify whether the tool expects `block_id` rather than `page_id`.
4. Retry once with the corrected payload and record the schema delta back into this skill if it is a reusable pattern.

---

## Quality Checklist

Before finalizing any Notion write:

- [ ] Correct DB ID for the content type
- [ ] Title matches expected format (YYMMDD - topic for daily reports)
- [ ] Must-confirm fields explicitly approved by user
- [ ] Tag Resolution Protocol applied (cache-first + live fallback)
- [ ] Missing tags confirmed by user before creation
- [ ] `relation` updated with final tag page IDs
- [ ] For linked workflows: KB doc created BEFORE daily report
- [ ] Code/text blocks split at <=1990 chars per `rich_text.content`
- [ ] No duplicate pages when writing by date/title

---

## Workflow 6 — Sync Action Center to Roadmap

**Target DB:** `4c1e2551-adae-83aa-bfa0-81f4ea233ecc` (Action Center)

**Steps:**
1. AI agents execute the automated Python script in the `scripts` subdirectory.
2. `sync_roadmap.py` queries Action Center items for the active project across `To Do`, `In Progress`, and `Blocked`.
3. Extracted details are summarized and recommended as backlog tasks for `docs/roadmap.md`.

**Execution Details:**
Use `python /home/leslie/.copilot/skills/notion-rdos/scripts/sync_roadmap.py --project-id <PROJECT_PAGE_ID>`.
