# Manipulability Unit Test Plan (Static, URDF-only)

## 1. Scope

Target module:

- [test/manipulability/urdf_static_manipulability.py](test/manipulability/urdf_static_manipulability.py)

Non-scope:

- RAI runtime,
- Phase0 mainline execution,
- dynamic manipulability.

---

## 2. Test Targets

1. URDF chain extraction
   - `load_urdf_chain(...)`
2. Kinematics
   - `fk_and_jacobian_position(...)`
3. IK
   - `solve_ik_position_dls(...)`
4. Score pipeline
   - `yoshikawa_position_score(...)`
   - `normalize_scores(...)`
5. Data pipeline
   - `derive_feasible(...)`
   - `parse_scene_positions(...)`
6. Ranking policy
   - `rank_same_type_with_unknown_tail(...)`

---

## 3. Required Test Files

- [generated/phase0_layout.json](generated/phase0_layout.json)
- [generated/infeasible_objects.json](generated/infeasible_objects.json)
- [unnamed.g](unnamed.g)
- [rai/test/newLGP/rai-robotModels/panda/panda_arm_hand.urdf](rai/test/newLGP/rai-robotModels/panda/panda_arm_hand.urdf)

---

## 4. Test Cases

## 4.1 Functional

1. `test_urdf_chain_has_7_active_joints`
   - Expect active joints = panda_joint1..panda_joint7.

2. `test_parse_scene_positions_has_obj_entries`
   - Expect at least all `obj_01..obj_15` positions are parsed.

3. `test_feasible_derivation_from_existing_outputs`
   - With current infeasible map, feasible count should equal layout count when infeasible is empty.

4. `test_ik_converges_for_nominal_target`
   - Pick a known object and target z-offset; expect IK converges with finite error.

5. `test_yoshikawa_score_is_finite_for_nominal_pose`
   - Expect score finite and non-negative.

6. `test_ranking_unknown_tail_policy`
   - Synthetic rows with mixed status: all `ranked` must appear before all `unknown` in each type group.

## 4.2 Stability / Reproducibility

1. `test_reproducible_report_order`
   - Same input run twice, same ordering for `(object_type, logical_id)` sequence.

## 4.3 Edge Cases

1. `test_missing_object_pose_marks_unknown`
   - Remove one object in temporary g text, expect `missing_object_pose_in_g` reason.

1. `test_invalid_jacobian_marks_unknown`
   - Inject invalid Jacobian in isolated unit call, expect `None` score + reason.

---

## 5. Integration Smoke Test

Entry script:

- [test/manipulability/run_static_manipulability_test.py](test/manipulability/run_static_manipulability_test.py)

Pass criteria:

1. Script exits successfully.
2. Report generated at [generated/ordering_score_report_static_test.json](generated/ordering_score_report_static_test.json).
3. Feasible snapshot generated at [generated/feasible_objects_static_test.json](generated/feasible_objects_static_test.json).
4. Output includes both counts and status breakdown.

---

## 6. Proposed Next-step Pytest File

- [test/manipulability/test_static_manipulability.py](test/manipulability/test_static_manipulability.py)

This file is recommended as next iteration after smoke run is confirmed.
