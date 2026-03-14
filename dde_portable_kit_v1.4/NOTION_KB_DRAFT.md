# DDE Portable Kit v1.4: One-Prompt Multi-Agent Deployment Framework

## Summary
This package provides a project-agnostic, instruction-only deployment workflow for DDE.
A fresh agent can read one markdown prompt and install a full constrained DDE process on its local workspace.

## Included Assets
- Bootstrap and governance skills
- Code write gate skill (`[APPROVED]`)
- Task closure gate skill (`[TASK_COMPLETED]`)
- Optional subordinate extensions (search, verification, cpp/python testing)
- Auxiliary workflow skills (drawio, notion)
- Prompt entrypoint for auto deployment

## Guarantees
- DDE remains the command authority
- Extension skills cannot bypass gates
- Fixed version deployment (`v1.4`)
- No hardcoded user paths

## Deliverables
- `dde_portable_kit_v1.4.zip`
- Prompt file: `PROMPT_DDE_PORTABLE_AUTODEPLOY_v1.4.md`
- Skills payload: `skills/*`
