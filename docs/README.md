# Documentation System (Main Index)

This document defines how project documents are organized, maintained, and archived.

## 1. Purpose
- Keep Layer 0-4 as the single source of truth for engineering decisions.
- Separate operational and historical materials from core architecture docs.
- Reduce context pollution in long-running AI sessions.

## 2. Structure

### 2.1 Core DDE Layers (fixed at `docs/` root)
- `docs/project_charter.md` (Layer 0)
- `docs/architecture.md` (Layer 1)
- `docs/dataflow.md` (Layer 2)
- `docs/module_specs/*.md` (Layer 2 module details)
- `docs/execution_protocol.md` (Layer 3)
- `docs/roadmap.md` (Layer 4)

These paths are stable and should not be moved to subfolders unless DDE bootstrap rules are explicitly updated.

### 2.2 Supplementary Docs (subfolders)
- `docs/ops/`: runtime/environment/network troubleshooting SOPs.
- `docs/decisions/`: decision records and templates (DDR).
- `docs/archive/`: historical handoff notes and one-time migration snapshots.
- `docs/governance/`: optional framework-level governance notes when needed.

Each subfolder should include a local `README.md` describing scope and filing rules.

## 3. Filing Rules
1. Architecture, dataflow, and protocol truth goes to Layer files only.
2. Environment or platform troubleshooting goes to `docs/ops/`.
3. Time-bound handoff notes go to `docs/archive/`.
4. Decision templates and approved decisions go to `docs/decisions/`.
5. Any new doc must be registered in this file under the correct section.
6. DDR template uses dual source:
	- reusable skill template (global skill roots)
	- project-local instance `docs/decisions/DDR_TEMPLATE.md`
	Project workflows use the project-local instance first.

## 4. Lifecycle Rules
1. Active operational SOPs stay in `docs/ops/`.
2. Outdated one-off notes must be moved to `docs/archive/` with date suffixes when useful.
3. Core Layer documents are updated, not duplicated.

## 5. Current Inventory

### Core
- `docs/project_charter.md`
- `docs/architecture.md`
- `docs/dataflow.md`
- `docs/module_specs/`
- `docs/execution_protocol.md`
- `docs/roadmap.md`

### Supplementary
- `docs/ops/README.md`
- `docs/ops/NETWORK_TROUBLESHOOTING_SOP.md`
- `docs/ops/CROSS_DEVICE_SYNC_SOP.md`
- `docs/decisions/README.md`
- `docs/decisions/DDR_TEMPLATE.md`
- `docs/decisions/DDR-20260313-waypoint-gated-constraint-reachability.md`
- `docs/archive/README.md`
- `docs/archive/AI_HANDOFF_PHASE1_GRAPH_20260310.md`
- `docs/governance/README.md`
- `docs/module_specs/README.md`
