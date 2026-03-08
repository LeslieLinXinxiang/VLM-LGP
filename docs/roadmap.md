# Project Roadmap and Task Tracking (Layer 4)

## 1. Completed Tasks (Historical Log)
- **[2026-03-08] Git Versioning Integration**: Established `dev/pyramid-constraints` branch, implemented SSH connection to GitHub, and provided git workflow guidance.
- **[2026-03-08] Multi-Support Hovering Fix**: Analyzed and overhauled `manipTools.cpp` `action_place_on_multi_support`. Replaced buggy absolute Z dimension logic using `getSize()(0)` with relative `FS_positionDiff` constraint. Fixed XY alignment. Verified with the 5-layer pyramid script.
- **[2026-03-08] DDE-Bootstrap Setup**: Designed and generated the Documentation-Driven Engineering (Layer 0-4) strict protocols to prevent AI hallucination and enforce rigid physical state tracking. 

## 2. Active In-Progress Task
- **Constraint Cleanup (Proposal Phase)**: Analyze the old constraints inside `manipTools.cpp` to remove conflicting or redundant rules that are causing slow optimization and solve times. 

## 3. Pending Backlog
- Replace/optimize soft `OT_sos` objectives that conflict with hard `OT_eq` requirements in the manipulation logics.
- Improve KOMO solver execution time for multi-step `LGP_TAMP` batches.
