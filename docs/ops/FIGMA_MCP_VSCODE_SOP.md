# Figma MCP in VS Code — Write-Enabled SOP

This SOP standardizes how to use Figma with MCP in this workspace, with **write operations via `figma-console`**.

## 1. Scope

- Applies to figure editing/generation tasks executed from VS Code chat/agent.
- Targets local Figma Desktop + Desktop Bridge workflow.
- Covers startup checks, connection validation, and common recovery steps.

## 2. Preconditions

1. Figma Desktop is running and target file is open.
2. Figma is in **Design Mode** (not Dev Mode).
3. **Figma Desktop Bridge** plugin is opened as a floating window and remains open.
4. Node.js + `npx` are available locally.

## 3. Workspace MCP Configuration

Use workspace config at `.vscode/mcp.json` (already added in this repo).

Key points:

- Use `servers` (VS Code format), not legacy `mcpServers`.
- Keep both transport endpoints:
  - `http://127.0.0.1:3845/mcp`
  - `http://127.0.0.1:3845/sse`
- For `mcp-remote`, include `-y` in args to avoid interactive `npx` blocking.
- Do not hardcode PAT in git-tracked files; use `${input:figma_pat}`.

## 4. Startup Procedure (VS Code)

1. Reload window once after MCP config changes.
2. Run `MCP: List Servers` and confirm servers can start:
   - `figma`
   - `figma-dev-mode-mcp-server`
   - `figma-console`
3. Accept trust prompts.
4. On first `figma-console` start, provide Figma PAT when prompted.

## 5. Runtime Validation

Healthy state checklist:

- `figma-console` reports active WebSocket/Desktop Bridge connection.
- Current file name is detected correctly.
- Agent can enumerate Figma tools and run read + write actions.

## 6. Troubleshooting

### A) Read-only behavior

Symptoms: write operations fail or silently no-op.

Actions:

1. Switch to Design Mode.
2. Re-open Desktop Bridge from Plugins → Development.
3. Keep plugin window open while issuing edit commands.

### B) MCP server starts but cannot connect to file

Symptoms: server running, but no active file/session.

Actions:

1. Close/reopen Desktop Bridge plugin.
2. Re-run MCP server start from VS Code.
3. If needed, reload VS Code window once.

### C) `mcp-remote` appears stuck

Root cause: interactive package prompt from `npx`.

Action:

- Ensure `mcp-remote` args include `-y`.

### D) PAT/token errors

Actions:

1. Re-enter PAT when prompted.
2. Revoke leaked/old token and generate a new one.
3. Store token only through secure prompt input or local secret manager.

## 7. Security Notes

- Never commit real PAT values.
- If a token was shared in chat/logs, revoke it immediately.
- Prefer workspace or user `mcp.json` inputs over plaintext env in repository files.
