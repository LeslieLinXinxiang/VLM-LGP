# Reachability-filtering ablation — naive-rule analysis

Scene: `test/scenes/scene_reachability_ablation.g` (15 objects, ground truth from `bin/pick_waypoint_check.exe`).

| Naive order | Object | Distance from base (m) | KOMO ground truth |
|---|---|---|---|
| 1 | rect_7 | 0.424 | feasible |
| 2 | rect_5 | 0.500 | feasible |
| 3 | cube_4 | 0.541 | feasible |
| 4 | rect_8 | 0.541 | feasible |
| 5 | cube_2 | 0.583 | feasible |
| 6 | rect_3 | 0.583 | feasible |
| 7 | cube_3 | 0.602 | feasible |
| 8 | rect_6 | 0.602 | feasible |
| 9 | cube_1 | 0.671 | feasible |
| 10 | rect_1 | 0.671 | feasible |
| 11 | rect_4 | 0.673 | feasible |
| 12 | rect_2 | 0.750 | feasible |
| 13 | far_3 | 1.092 | infeasible |
| 14 | far_2 | 1.414 | infeasible |
| 15 | far_1 | 1.492 | infeasible |

**Naive rule (nearest-to-farthest, no reachability check) would select an unreachable object 3/15 = 20.0% of the time.** With reachability filtering, this is 0% by construction (S_r excludes exactly this set) — not reported as the headline number since it is trivially true.
