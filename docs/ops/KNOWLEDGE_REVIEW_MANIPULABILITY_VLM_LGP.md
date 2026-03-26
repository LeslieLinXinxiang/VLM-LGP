# Knowledge Review: Manipulability in VLM-LGP (Core Theory -> Code -> Pipeline)

## 0) Why this note exists

This note is for **复习回顾**: from manipulability fundamentals, to our concrete implementation in this repo, to how the outputs are inserted into planning decisions.

---

## 1) Core algorithm principle (independent of project)

### 1.1 What manipulability measures

For an $n$-DOF arm, end-effector velocity and joint velocity satisfy:

$$
\dot{x} = J(q)\dot{q}
$$

- $J(q)$: Jacobian at joint state $q$.
- If we constrain $\|\dot{q}\|\le 1$, reachable Cartesian velocities form an ellipsoid.
- Ellipsoid “volume” (or its proxy) is used as dexterity index.

### 1.2 Yoshikawa manipulability

Classical form (full task space):

$$
m(q)=\sqrt{\det\left(JJ^\top\right)}
$$

In this project we use **position Jacobian only** $J_p\in\mathbb{R}^{3\times n}$:

$$
m_{pos}(q)=\sqrt{\det\left(J_pJ_p^\top\right)}
$$

Interpretation:

- larger $m_{pos}$ => locally easier to move end-effector position in many directions;
- near zero => singular / near-singular / poorly conditioned region.

### 1.3 Why IK is needed before scoring

We need a joint state $q$ that reaches a target point $x^*$. We use DLS IK:

$$
\Delta q = J_p^\top \left(J_pJ_p^\top + \lambda^2 I\right)^{-1} e,
\quad e = x^*-x(q)
$$

Then iterative update with limits:

$$
q \leftarrow \mathrm{clamp}(q + \alpha\Delta q, q_{min}, q_{max})
$$

If IK fails, manipulability is marked unknown for that target.

---

## 2) How VLM-LGP applies it concretely

## 2.1 Scope in this repo

Current manipulability implementation is **URDF-only static analysis**:

- no RAI runtime dependency for scoring;
- parse robot from URDF + scene/object poses from `.g`;
- compute object-level rankability and workspace grid maps.

Main implementation files:

- [test/manipulability/urdf_static_manipulability.py](test/manipulability/urdf_static_manipulability.py)
- [test/manipulability/run_static_manipulability_test.py](test/manipulability/run_static_manipulability_test.py)
- [test/manipulability/build_manipulability_grid.py](test/manipulability/build_manipulability_grid.py)
- [test/manipulability/render_manipulability_3d.py](test/manipulability/render_manipulability_3d.py)
- [test/manipulability/render_manipulability_slices.py](test/manipulability/render_manipulability_slices.py)

## 2.2 Object-level ranking path (what we use for decision support)

Pipeline in `compute_static_manipulability_report()`:

1. Load Phase0 artifacts:
   - `generated/phase0_layout.json`
   - `generated/infeasible_objects.json`
2. Derive feasible object set (`derive_feasible`).
3. Parse robot chain from URDF (`load_urdf_chain`).
4. Parse base/object world poses from scene `.g` (`parse_scene_positions`).
5. Parse initial joint seed from `.g` (`parse_initial_q_from_g`).
6. For each feasible object:
   - target = object position + `approach_offset_z`;
   - solve DLS IK (`solve_ik_position_dls`);
   - compute $m_{pos}$ (`yoshikawa_position_score`).
7. Normalize scores by min-max (`normalize_scores`).
8. Apply threshold `tau_m`:
   - `ranked` if score >= `tau_m`;
   - otherwise `unknown`.
9. Same-type sorting with unknown tail (`rank_same_type_with_unknown_tail`).

Key function anchors:

- [test/manipulability/urdf_static_manipulability.py](test/manipulability/urdf_static_manipulability.py#L301) `solve_ik_position_dls()`
- [test/manipulability/urdf_static_manipulability.py](test/manipulability/urdf_static_manipulability.py#L361) `yoshikawa_position_score()`
- [test/manipulability/urdf_static_manipulability.py](test/manipulability/urdf_static_manipulability.py#L606) `compute_static_manipulability_report()`

## 2.3 Workspace-grid path (what we use for field visualization / analysis)

`build_manipulability_grid.py` samples a 3D grid:

- each voxel target runs IK + $m_{pos}$;
- save raw and normalized fields to `npz`;
- metadata in JSON.

Representative outputs:

- [generated/manipulability_grid_meta_envelope.json](generated/manipulability_grid_meta_envelope.json)
- [generated/manipulability_grid_raw_envelope.npz](generated/manipulability_grid_raw_envelope.npz)
- [generated/manipulability_grid_norm_envelope.npz](generated/manipulability_grid_norm_envelope.npz)

Visualization examples:

- [generated/figures/manip_3d_pointcloud_envelope_rb.png](generated/figures/manip_3d_pointcloud_envelope_rb.png)
- [generated/figures/manip_3d_voxel_envelope_rb.png](generated/figures/manip_3d_voxel_envelope_rb.png)
- [generated/figures_hires/manip_slice_xy.png](generated/figures_hires/manip_slice_xy.png)
- [generated/figures_hires/manip_slice_xz.png](generated/figures_hires/manip_slice_xz.png)
- [generated/figures_hires/manip_slice_yz.png](generated/figures_hires/manip_slice_yz.png)

---

## 3) Concrete project example (numbers from this repo)

From [generated/manipulability_grid_meta_envelope.json](generated/manipulability_grid_meta_envelope.json):

- grid size: $38\times 38\times 30 = 43320$ points;
- IK success: 16633;
- valid manipulability scores: 16633;
- run time: 777.2 s.

From [generated/manipulability_franka_envelope_report.json](generated/manipulability_franka_envelope_report.json):

- sampled workspace radius up to ~1.1885 m;
- this report defines practical workspace envelope used to set grid bounds.

Meaning for planning:

- manipulability is used as a **quality prior** over feasible objects/poses;
- not a hard collision/reachability proof alone;
- combines naturally with reachability gate (TASK-019 direction).

---

## 4) Integration path in VLM-LGP architecture

Current state:

1. Object-level scoring pipeline exists and generates auditable reports.
2. Grid-level field generation + visualization exists for analysis.
3. Outputs are in `generated/**` and can be consumed by ordering logic.

Insertion points to remember:

- ranking report generation: [test/manipulability/run_static_manipulability_test.py](test/manipulability/run_static_manipulability_test.py)
- reusable core math and parsing: [test/manipulability/urdf_static_manipulability.py](test/manipulability/urdf_static_manipulability.py)
- roadmap closure context: [docs/roadmap.md](docs/roadmap.md)

---

## 5) Practical command cheatsheet (for recall)

- Object-level static test:
  - `python3 test/manipulability/run_static_manipulability_test.py`
- Build 3D manipulability grid:
  - `python3 test/manipulability/build_manipulability_grid.py`
- Render 3D figures:
  - `python3 test/manipulability/render_manipulability_3d.py`
- Render slice figures:
  - `python3 test/manipulability/render_manipulability_slices.py`

---

## 6) Limitations and next-step understanding

Current method limitations:

- static kinematic metric only (no dynamics/torque margin);
- score depends on IK seed and damping settings;
- normalization is dataset-relative (min-max across current batch/grid).

Recommended future extensions:

1. combine with differentiable reachability field (TASK-019);
2. add robustness terms (clearance, uncertainty, regrasp cost);
3. replace simple min-max with calibrated scoring.

---

## 7) Formula summary card

- Position IK (DLS):

$$
\Delta q = J_p^\top (J_pJ_p^\top + \lambda^2I)^{-1}e
$$

- Position manipulability:

$$
m_{pos}=\sqrt{\det(J_pJ_p^\top)}
$$

- Normalization:

$$
\hat m = \frac{m-\min(m)}{\max(m)-\min(m)+\epsilon}
$$

- Status rule:

$$
\hat m\ge \tau_m \Rightarrow ranked,\quad \hat m<\tau_m \Rightarrow unknown
$$

---

## 8) References (for review)

1. Yoshikawa, T. "Manipulability of Robotic Mechanisms." *The International Journal of Robotics Research*, 4(2), 1985.
2. Wampler, C. W. "Manipulator Inverse Kinematic Solutions Based on Vector Formulations and Damped Least-Squares Methods." *IEEE Transactions on Systems, Man, and Cybernetics*, 16(1), 1986.
3. Nakamura, Y., Hanafusa, H. "Inverse Kinematic Solutions With Singularity Robustness for Robot Manipulator Control." *Journal of Dynamic Systems, Measurement, and Control*, 108(3), 1986.
