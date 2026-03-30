# 260326 - Manipulability Closure and Reachability Fusion Note (VLM-LGP)

🎯 1. Core Objective (Objective)
Close the manipulability development track with validated URDF-only implementation, complete 3D/2D visualization checks, and align roadmap status for TASK-018.

🐛 2. Key Findings & Debugging

- Initial 3D figures were hard to interpret because robot base origin was missing and color contrast was weak.
- White regions in YZ slices were caused by NaN/unreachable values being rendered as empty instead of low-score semantics.
- Workspace clipping perception came from undersized sampling bounds; full-range envelope must be derived from Franka URDF joint limits.

🛠️ 3. Actions Taken

- Implemented visualization fixes in:
  - test/manipulability/render_manipulability_3d.py
  - test/manipulability/render_manipulability_slices.py
- Added a workspace-envelope analysis script:
  - test/manipulability/analyze_franka_envelope.py
- Generated and validated Franka envelope report:
  - generated/manipulability_franka_envelope_report.json
- Rebuilt envelope-based grid and final 3D assets:
  - generated/manipulability_grid_meta_envelope.json
  - generated/figures/manip_3d_pointcloud_envelope_rb.png
  - generated/figures/manip_3d_voxel_envelope_rb.png
- Closed roadmap status for TASK-018 in:
  - docs/roadmap.md

📊 4. Results & Validation

- Franka Monte Carlo envelope (120000 samples) gave:
  - r_max ≈ 1.1885 m
  - xyz_min ≈ [-0.852, -1.154, 0.328]
  - xyz_max ≈ [0.854, 0.556, 1.838]
- Envelope-based sampling range was expanded and validated:
  - x in [-0.93, 0.94], y in [-1.24, 0.64], z in [0.24, 1.92]
- New 3D outputs now represent full intended sampling envelope and keep clear red-high / blue-low interpretation.

🚀 5. Next Steps / Backlog

- Keep TASK-019 active and continue differentiable reachability implementation.
- Attention item (must keep): evaluate a unified priority strategy that fuses reachability parameters (TASK-019) with manipulability parameters (TASK-018) for final execution ordering.
