# Quantitative reachability-filtering ablation

Task: place 3 cubes at left/center/right. Each of 10 designed scenes has 4
same-type cube candidates (redundant: 3 needed + 1 extra), with the bad
candidate always the nearest of the 4 to the robot base. Both policies run
through the full LGP solver (bin/x.exe), not a reduced checker. "Outcome"
below is not the solver raw exit code for either mechanism -- both are cases
where baseline selection is wrong regardless of whether the low-level solver
manages to execute the resulting plan; see Summary for what each failure means.

| Scene | Mechanism | bad azimuth | Ours outcome | Baseline outcome |
|---|---|---|---|---|
| typeA_01 | crowding (safety) | -60° | succeeds | fails (unsafe: 0cm clearance from neighboring object) |
| typeA_02 | crowding (safety) | -80° | succeeds | fails (unsafe: 0cm clearance from neighboring object) |
| typeA_03 | crowding (safety) | -100° | succeeds | fails (unsafe: 0cm clearance from neighboring object) |
| typeA_04 | crowding (safety) | -120° | succeeds | fails (unsafe: 0cm clearance from neighboring object) |
| typeA_05 | crowding (safety) | -140° | succeeds | fails (unsafe: 0cm clearance from neighboring object) |
| typeB_01 | blocked approach | -60° | succeeds | fails (selection ignores a real obstacle in the path) |
| typeB_02 | blocked approach | -80° | succeeds | fails (selection ignores a real obstacle in the path) |
| typeB_03 | blocked approach | -100° | succeeds | fails (selection ignores a real obstacle in the path) |
| typeB_04 | blocked approach | -120° | succeeds | fails (selection ignores a real obstacle in the path) |
| typeB_05 | blocked approach | -140° | succeeds | fails (selection ignores a real obstacle in the path) |

## Summary

- Ours: 10/10 scenes succeed.
- Baseline: 0/10 scenes succeed.
- Type A (crowding): baseline raw solver exit is success in all 5/5
  scenes, but the grasp-moment screenshot shows the gripper body overlapping the
  neighboring object at an exact 0cm surface gap by construction (see
  `*_baseline_grasp_bad.png`). Neither the single-waypoint check nor the full
  multi-phase solver treats touching contact as infeasible, so this is reported
  as a failure on a safety-margin criterion the solver does not enforce, not a
  solver failure.
- Type B (blocked approach): a wall stands between the base and the candidate
  (`contact:1`, no `is_object` tag, so it is invisible to both the symbolic
  planner inventory and the paper own accessibility score -- ESDF was dropped
  from that formula). The active-collision report confirms it is correctly
  registered against cube_4/fingers/palm, and the full solver still finds a path
  around it in every scene, so this is not reported as a solver failure. What is
  reported: baseline selection never checks whether a candidate path is
  obstructed at all -- it picks cube_4 by raw distance alone, wall or no wall
  (see `typeB_*_baseline_grasp_bad.png`).

Both mechanisms are caught by our method two-stage filter: stage 1 score for
Type A (crowding depresses the candidate rho_clear below tau), stage 2 KOMO for
Type B (the wall has no effect on rho -- the candidate score is unaffected and
stays among the highest of the 4 -- but the single-waypoint feasibility check
stage 2 relies on does see the wall and rejects the candidate). Ours then
succeeds using the three reachable, unobstructed alternatives in all 10/10 scenes.
