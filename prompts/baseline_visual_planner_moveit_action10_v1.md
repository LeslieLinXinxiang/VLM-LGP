# MISSION: ROBOTIC BLOCK ASSEMBLY (MOVEIT ACTION-10 BASELINE)

You are given one combined image:
- left: Object List (Legend)
- right: target structure

Infer object identities, assembly order, and generate **action-level waypoint plans** that can be consumed by a MoveIt-style executor.

---

## 1. ROBOTIC SYSTEM PARAMETERS

### Arm and World Coordinate System (CRITICAL)
- **World Origin (0,0,0)**: The robot's base is exactly at the world origin `[0, 0, 0]`.
- The robot base is mounted directly on the table surface. Therefore, the table surface is effectively at `Z ≈ 0`.
- All object positions parsed from the SCENE block's `t(x y z)` are **ALREADY absolute coordinates** in the robot's base frame.
- **DO NOT** add any table height offset to the `z` coordinates. If an object's `z` is `0.065`, then its absolute grasp height is exactly `0.065` meters.

### Arm Configuration
- Initial TCP position (retract pose):
  - TCP xyz:[0.0977, 0.0000, 1.3128] m
- Preferred grasp/place orientation: tool Z axis points downward.
- Gripper state is controlled by **separate events** (not mixed into waypoint numeric columns).

### Action Definition
Each object operation has two actions:
- `pick` action
- `place` action
For every action, output exactly **10 waypoints**.

---

## 2. SCENE GEOMETRY

Table layer anchor regions (approximate regions in robot base frame):
- table_left:[-0.08, 0.35, 0.051, 0, 0, 0]
- table_center:[ 0.00, 0.35, 0.051, 0, 0, 0]
- table_right:[ 0.08, 0.35, 0.051, 0, 0, 0]

Workspace bounds (gripper TCP):
- X: [-0.20, 0.20] m
- Y:[-0.05, 0.35] m
- Z:[0.04, 0.40] m

---

## 3. HARD CONSTRAINTS

- Use object ids exactly from SCENE (e.g., `obj_01`, `obj_02`).
- Orientation format must be unit quaternion `[qx qy qz qw]`.
- Each action (`pick` or `place`) must have **exactly 10 waypoints**.
- Waypoints must be smooth and physically feasible (no large jumps).
- Gripper control must be output as separate events: `open` or `close`.
- Do not output explanations.

---

## 4. GRASP ORIENTATION CALCULATION (CRITICAL)

When parsing an object's rotation from the SCENE block `d(angle ax ay az)` (e.g., `d(90 0 0 1)` means 90 degrees around Z-axis):
1. Convert the angle to radians: `θ = angle * π / 180`.
2. The default downward grasp quaternion is `[0, 1, 0, 0]`.
3. To align the gripper with the object's yaw, use this exact formula:
   `qx = -sin(θ / 2)`
   `qy = cos(θ / 2)`
   `qz = 0.0000`
   `qw = 0.0000`
4. For the **`pick`** action, use this calculated `[qx qy qz qw]` for all 10 waypoints.
5. For the **`place`** action, assuming you want to align the object with the world axes (0 degree yaw), smoothly use the default `[0.0000 1.0000 0.0000 0.0000]` for all place waypoints.

---

## 5. OUTPUT FORMAT (STRICT)

Output only in the following plain-text block format.

For each action, output:
1) One action header line: `ACTION <index> <pick|place> <object_id>`
2) Exactly 10 waypoint lines: `x y z qx qy qz qw t` (4 decimal places)
3) One gripper event line: `GRIPPER <open|close> <time_s>`

Rules:
- `t` for 10 waypoints must be strictly increasing.
- `GRIPPER` event time must equal the last waypoint time of that action.
- No JSON, no markdown, no commentary.

---

## 6. ACTION TRAJECTORY SHAPE (10-POINT TEMPLATE)

- pick action (10 points): wp0-wp2 (pre-grasp above obj), wp3-wp7 (descend), wp8-wp9 (hold). End: `close`.
- place action (10 points): wp0-wp2 (lift/transit), wp3-wp7 (descend to target), wp8-wp9 (hold). End: `open`.

---

## 7. WEB TEST COPY-PASTE ORDER (STRICT)

When testing in web UI, paste in this exact order:
1) Full prompt text
2) SCENE block
3) Image upload
(Add one line after SCENE block: `IMAGE UPLOADED`)