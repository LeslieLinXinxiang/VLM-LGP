---
name: skill-sync-guard
description: |
  【何时触发】：当用户要求创建、修改、重构、审核任何 skill（SKILL.md、templates、scripts）时。
  【核心功能】：定义 Skill 更新治理规则，强制 .copilot 与 .agents 双目录同步更新与一致性校验。
---

# Skill Sync Guard v1.0

## 1. Scope
This rule applies to all skill assets, including:
- `SKILL.md`
- skill templates (e.g., `templates/*.md`)
- helper scripts under a skill folder

Reference roots:
- `/home/leslie/.copilot/skills`
- `/home/leslie/.agents/skills`

## 2. Hard Rule: Dual-Root Sync
For any skill update, the agent MUST treat `.copilot` and `.agents` as a mirrored pair.

Required actions:
1. Locate the target skill in both roots.
2. Apply equivalent updates to both copies.
3. If one copy is missing, create it first, then sync content.
4. Verify final parity (same files, same content intent, same version marker).

No single-root-only update is allowed.

## 3. Update Protocol
1. Read current files in both roots before editing.
2. Produce/update the source content once.
3. Write to both roots.
4. Re-read both files and compare for drift.
5. Report explicit sync result in final response.

## 4. Versioning Rule
Each skill should include a visible version string (e.g., `v1.0`, `v1.1`).
When rules change, increment version in both roots within the same turn.

## 5. Conflict Handling
If `.copilot` and `.agents` already diverge:
1. Do not ignore the divergence.
2. Summarize key differences.
3. Propose a unified target.
4. Apply unified result to both roots.

## 6. Completion Checklist
Before finishing a skill-update task, confirm:
- [ ] `.copilot` copy updated
- [ ] `.agents` copy updated
- [ ] folder structure mirrored
- [ ] version marker aligned
- [ ] no residual drift after final read
