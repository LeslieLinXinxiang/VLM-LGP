# Roadmap Guard SOP (Deterministic Governance)

## Goal

Avoid fragile direct edits on docs/roadmap.md by enforcing machine checks and scripted state transitions.

## Components

- Validator and state-transition tool: `~/.copilot/skills/roadmap-guard/scripts/roadmap_guard.py`
- Local commit gate: [.githooks/pre-commit](../../.githooks/pre-commit)
- Hook setup command: `git config core.hooksPath .githooks`

## Enforced Rules

1. A task with `Status=[Completed]` cannot stay in Active section.
2. The same `TASK-ID` cannot exist in both Active and Completed sections.
3. Archive timestamps must follow `YYYY-MM-DD HH:MM`.
4. Roadmap section order must be Active -> Completed -> Pending.

## Setup

1. Install git hook once:
   - `chmod +x .githooks/pre-commit`
   - `git config core.hooksPath .githooks`
2. Optional manual check:
   - `python3 ~/.copilot/skills/roadmap-guard/scripts/roadmap_guard.py validate docs/roadmap.md`

## Safe Task Closure Workflow

Use scripted close operation instead of manual block move:

`python3 ~/.copilot/skills/roadmap-guard/scripts/roadmap_guard.py close --task-id TASK-018 --completed-at "2026-03-26 12:43" --summary "Completed URDF-only static manipulability implementation and verification; follow-up note retained for reachability+manipulability fusion."`

The command will:

- remove the target task block from Active section,
- prepend one summary line into Completed archive,
- renumber archive indices,
- re-validate the whole roadmap.

## Notes

- This is a guardrail, not a replacement for project-level review.
- Keep summaries concise (1-2 lines), per roadmap policy.
