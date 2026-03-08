# Layer 4: Project Roadmap & Task Tracker

## 1. Current Active Tasks (Timeline Log)
### [TASK-003] Constraint Cleanup in manipTools.cpp
* **Status**: `[In Progress]`
* **Created**: 2026-03-08 15:47
* **Completed**: N/A
* **Timeline**:
    * *15:47*: Established Rolling Log constraint in DDE protocol. Awaiting start of Phase 1 Proposal for `manipTools.cpp` cleanup.

## 2. Completed Tasks Rolling Archive (Max 50)
> **Rule**: When adding the 51st item, delete the oldest item to prevent context poisoning. Summarize tasks in 1-2 lines.

1. **[TASK-002] Multi-Support Hovering Fix (2026-03-08)**: Replaced absolute Z `getSize()(0)` with relative `FS_positionDiff` and fixed XY alignment in `action_place_on_multi_support`.
2. **[TASK-001] DDE-Bootstrap Setup (2026-03-08)**: Generated Layer 0-4 Documentation-Driven Engineering protocol to prevent hallucination.

## 3. Pending Backlog
- Replace/optimize soft `OT_sos` objectives that conflict with hard `OT_eq` requirements in the manipulation logics.
- Improve KOMO solver execution time for multi-step `LGP_TAMP` batches.
