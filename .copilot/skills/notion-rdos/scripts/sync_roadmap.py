import json
import subprocess
import argparse

def get_block_text(block_id):
    result = subprocess.run(
        ["composio", "tools", "execute", "NOTION_FETCH_BLOCK_CONTENTS", "-d", json.dumps({"block_id": block_id})],
        capture_output=True, text=True
    )
    if result.returncode != 0:
        return ""
    
    try:
        data = result.stdout
        data = data[data.find("{"):]
        j = json.loads(data)
        blocks = j.get("data", {}).get("results", [])
        text = ""
        for b in blocks:
            b_type = b.get("type", "")
            if b_type in b:
                for rt in b[b_type].get("rich_text", []):
                    text += rt.get("plain_text", "")
                text += ", "
        # Simplify the trailing commas and make it one line summary
        text = text.strip(", ")
        return text
    except Exception as e:
        return ""

def main():
    parser = argparse.ArgumentParser(description="Sync Notion Action Center To-Dos into Roadmap format")
    parser.add_argument("--db-id", default="31ee2551-adae-8128-a1e2-e79947b98a3c", help="Action Center DB ID")
    parser.add_argument("--project-id", default="31ee2551-adae-81de-8926-c6dd763ee0ef", help="VLM-LGP Project ID")
    args = parser.parse_args()

    result = subprocess.run(
        ["composio", "tools", "execute", "NOTION_QUERY_DATABASE", "-d", json.dumps({"database_id": args.db_id})],
        capture_output=True, text=True
    )

    if result.returncode != 0:
        print("Failed to query Notion DB.")
        return

    try:
        data = result.stdout
        data = data[data.find("{"):]
        j = json.loads(data)
        
        tasks_found = []
        for page in j.get("data", {}).get("results", []):
            props = page.get("properties", {})
            status = props.get("Status", {}).get("select", {}).get("name", "")
            if status != "To Do":
                continue  # Only pull To Do items
            
            # Check project relation
            relations = props.get("Project", {}).get("relation", [])
            rel_ids = [r.get("id") for r in relations]
            if args.project_id not in rel_ids:
                continue

            title_prop = props.get("Task Name", {}).get("title", [])
            title = title_prop[0].get("plain_text", "Untitled") if title_prop else "Untitled"
            
            page_id = page.get("id")
            content_summary = get_block_text(page_id)
            
            tasks_found.append(f"- **{title}**: {content_summary}")

        if not tasks_found:
            print("No new 'To Do' tasks found for this project in Notion.")
        else:
            print("--- COPY BELOW TO roadmap.md PENDING BACKLOG ---")
            for t in tasks_found:
                print(t)
            print("--------------------------------------------------")

    except Exception as e:
        print(f"Error parsing database output: {e}")

if __name__ == "__main__":
    main()
