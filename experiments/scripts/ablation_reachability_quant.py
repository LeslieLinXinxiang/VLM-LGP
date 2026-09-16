#!/usr/bin/env python3
"""Quantitative reachability-filtering ablation: 10 designed scenes, full LGP execution.

Task: place 3 cubes at left/center/right on the table (the same flat 3-object graph
used throughout cube stacking). Each scene has 4 same-type cube candidates -- 3 "good"
ones and 1 "bad" one -- so the mode is redundant by construction: our method has a
genuine alternative to fall back on when it filters the bad candidate, whereas a
non-redundant scene would just make the task impossible either way.

The bad candidate is always the nearest of the 4 to the robot base, so a naive
nearest-first baseline picks it before any good candidate. Two independent physical
mechanisms make it bad, matched to the two filtering stages:

  Type A (5 scenes) -- crowding. The bad cube sits next to a same-radius, differently
  typed filler object (never a candidate for the graph's Cube role, so it cannot itself
  be selected and cannot depress a good candidate's own score by proximity). This lowers
  only the bad cube's rho_clear. Confirmed empirically: two objects this close remain
  KOMO-feasible under the single-waypoint check (it only tests the terminal pose, not
  the approach path), so this is a safety-margin filter, not a KOMO-correctness one --
  matches how core/phase0_parser.py's stage 1 is described in the paper.

  Type B (5 scenes) -- the robot's own close-in azimuthal blind spot, confirmed by
  direct sweep (see CLAUDE.md, 2026-09-15): roughly 105-210 degrees behind the base at
  r=0.15m, narrowing to nothing by r=0.25m. This is real robot kinematics, not an
  obstacle and not a bug. rho does not reference the base position at all (Eq. 9-10 in
  the paper are purely inter-object), so a dead-zone object scores identically to a
  freely reachable one -- stage 1 cannot distinguish it even in principle. Only stage 2
  (a real KOMO solve) catches it.

For each scene, both "ours" (stage-1 score + stage-2 KOMO, survivors only) and
"baseline" (nearest-3-of-4, no filtering) are run through the same full LGP solver
(bin/x.exe), not the reduced single-object checker, so success/failure is a real
execution result.

Writes experiments/outputs/reachability_ablation_quant/{summary.json,summary.md} and
renders per-scene screenshots into experiments/outputs/reachability_ablation_quant/renders/.
"""
import importlib.util
import json
import math
import re
import select
import shutil
import subprocess
import sys
import time
from pathlib import Path

import psutil

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))

import core.phase2_codegen as p2_codegen                                   # noqa: E402
from core.phase2_codegen import generate_step_files                        # noqa: E402
from core.reachability_field import compute_paper_accessibility_scores     # noqa: E402


def _load_layer_based_clustering_class():
    module_path = ROOT / "test" / "layer_based_clustering" / "run_layer_based_codegen.py"
    spec = importlib.util.spec_from_file_location("layer_based_codegen", str(module_path))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module.LayerBasedClustering


LayerBasedClustering = _load_layer_based_clustering_class()

_MANIP_DIR = ROOT / "test" / "manipulability"
sys.path.insert(0, str(_MANIP_DIR))
from urdf_static_manipulability import (                                   # noqa: E402
    load_urdf_chain, parse_scene_positions, parse_initial_q_from_g,
    solve_ik_position_dls, fk_and_jacobian_position, yoshikawa_position_score,
)

URDF_PATH = ROOT / "rai" / "test" / "newLGP" / "rai-robotModels" / "panda" / "panda_arm_hand.urdf"
_CHAIN = None


def _get_chain():
    global _CHAIN
    if _CHAIN is None:
        _CHAIN = load_urdf_chain(urdf_path=str(URDF_PATH), base_link="panda_link0", ee_link="panda_hand")
    return _CHAIN


def manipulability_scores(scene_path, cube_names, approach_offset_z=0.08):
    """Yoshikawa position-manipulability score per candidate, via DLS IK on the URDF chain --
    the same mechanism the real pipeline uses to rank same-type candidates
    (reachability_score * manipulability_score, pipeline/run_phase0.py:220-227)."""
    chain = _get_chain()
    base_T_world, obj_pos = parse_scene_positions(str(scene_path))
    q0 = parse_initial_q_from_g(str(scene_path), chain.active_joint_names)
    scores = {}
    for name in cube_names:
        pos = obj_pos.get(name)
        if pos is None:
            scores[name] = None
            continue
        target = pos.copy()
        target[2] += approach_offset_z
        ok, q_sol, _ = solve_ik_position_dls(chain, target, q0=q0, base_T_world=base_T_world)
        if not ok:
            scores[name] = None
            continue
        _, Jp = fk_and_jacobian_position(chain, q_sol, base_T_world=base_T_world)
        score, _ = yoshikawa_position_score(Jp)
        scores[name] = score
    return scores


SCENES_DIR = ROOT / "experiments/scenes/reachability_ablation_quant"
OUT_DIR = ROOT / "experiments/outputs/reachability_ablation_quant"
RENDER_DIR = OUT_DIR / "renders"

HEADER = (ROOT / "experiments/scenes/reachability_ablation/scene_A_crowding.g").read_text().split("# ===")[0]
SLOTS = (
    '\nTable_Left   (table) { Q:"t(-0.08  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }\n'
    'Table_Center (table) { Q:"t( 0.00  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }\n'
    'Table_Right  (table) { Q:"t( 0.08  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }\n'
)
GOOD_POS = [(0.40, 0.0), (0.45, 30.0), (0.50, -30.0)]
BASE_XY = (0.0, -0.3)

PHASE1_JSON = {
    "objects": [
        {"id": 0, "object": "table", "edges": []},
        {"id": 1, "object": "Cube", "edges": [{"supporter": 0, "position": "left"}]},
        {"id": 2, "object": "Cube", "edges": [{"supporter": 0, "position": "center"}]},
        {"id": 3, "object": "Cube", "edges": [{"supporter": 0, "position": "right"}]},
    ]
}

TAU_RHO = 1.4  # separates ~0.97 (crowded) from ~1.9+ (clear) with margin either side


def _cube_line(name, x, y, color):
    return f'{name} (table) {{ Q:"t({x:.4f} {y:.4f} .065)", joint:rigid, shape:ssBox, size:[.03 .03 .03 .001], color:{color}, contact:1, mass:.2, logical:{{ is_object, is_box, is_place }} }}\n'


def build_type_a(seed_idx, bad_r, bad_az, good_jitter):
    """Crowding: filler touches the bad cube on the base-facing side (confirmed by
    render inspection to give the clearest gripper/neighbor overlap at the grasp pose),
    isolated in its own location away from the 3 good cubes so none of their own scores
    are depressed by proximity -- only cube_4's rho_clear drops."""
    lines = [HEADER, SLOTS, f"\n# === Type A ablation scene {seed_idx} (crowding, 0cm gap, inward face) ===\n"]
    goods = []
    for i, (r, az) in enumerate(GOOD_POS, start=1):
        r2, az2 = r + good_jitter[i - 1][0], az + good_jitter[i - 1][1]
        rad = math.radians(az2)
        x, y = r2 * math.sin(rad), BASE_XY[1] + r2 * math.cos(rad)
        lines.append(_cube_line(f"cube_{i}", x, y, "[1 1 1]"))
        goods.append((f"cube_{i}", x, y))
    rad = math.radians(bad_az)
    bx, by = bad_r * math.sin(rad), BASE_XY[1] + bad_r * math.cos(rad)
    lines.append(_cube_line("cube_4", bx, by, "[1 1 1]"))
    radial_unit = (math.sin(rad), math.cos(rad))
    fx, fy = bx - 0.03 * radial_unit[0], by - 0.03 * radial_unit[1]
    lines.append(_cube_line("filler_1", fx, fy, "[1 1 1]"))
    path = SCENES_DIR / f"typeA_{seed_idx:02d}.g"
    path.write_text("".join(lines))
    return path, {"cube_4": (bx, by), "filler_1": (fx, fy), **{g[0]: (g[1], g[2]) for g in goods}}


def _obstacle_line(name, x, y, bad_az, offset=0.01, width=0.20, thickness=0.02, height=0.15):
    """A single wall standing upright between the base and the object at (x, y), facing
    the approach direction -- no overhead lip (tried first, rejected as visually odd: a
    slab connected to a short wall reads as a floating ceiling with a stub, not a wall).
    A pure wall only reliably blocks the grasp once it's large enough, and close enough,
    that the arm's redundant DOF cannot route around it. First sweep at bad_r=0.30 needed
    h=0.9/w=0.6 even at a 5cm offset -- generous slack lets the arm detour around anything
    smaller. Two knobs shrink it: closing the offset to near-zero (touching the object),
    and moving the object farther from the base so the arm has less spare reach to spend
    on a detour. At bad_r=0.35 (still comfortably under the good candidates' 0.40m, so it
    stays the nearest of the 4) and offset~0.005, h=0.15/w=0.20 is the smallest size still
    reliable across all 5 production azimuths (-60/-80/-100/-120/-140) -- h=0.10 or w<=0.15
    let at least one azimuth through. No `is_object` flag -- invisible to the symbolic
    planner's inventory and to the paper's own accessibility score (ESDF was dropped, see
    CLAUDE.md); only KOMO's own collision constraint sees it. Same contact:1/no-is_object
    pattern as the existing `big_overhead_obstacle` in
    test/scenes/scene_dual_lr_with_big_overhead_obstacle.g, just rotated upright and
    placed radially instead of overhead."""
    rad = math.radians(bad_az)
    radial = (math.sin(rad), math.cos(rad))
    wx, wy = x - offset * radial[0], y - offset * radial[1]
    table_z = 0.065 - 0.015  # table surface in table-local z
    wz = table_z + height / 2.0
    return (f'{name} (table) {{ Q:"t({wx:.4f} {wy:.4f} {wz:.4f}) d({-bad_az:.1f} 0 0 1)", '
            f'joint:rigid, shape:ssBox, size:[{width} {thickness} {height} .002], '
            f'color:[.55 .55 .55 .85], contact:1, mass:1.0, logical:{{ is_place }} }}\n')


def build_type_b(seed_idx, bad_r, bad_az, good_jitter):
    """Blocked approach: cube_4 sits at an ordinary, reachable position (same scale as the
    good candidates, nearest to the base by construction like Type A), but a low overhead
    panel blocks the only grasp approach. Replaces the earlier "dead zone" design, which
    turned out to require either interpenetrating the base's own collision capsule (the
    r=0.13-0.18 sweep) or placing the candidate farther from the base than the good ones
    (r>=0.90), which broke the "baseline picks it because it's nearest" premise."""
    lines = [HEADER, SLOTS, f"\n# === Type B ablation scene {seed_idx} (blocked approach) ===\n"]
    goods = []
    for i, (r, az) in enumerate(GOOD_POS, start=1):
        r2, az2 = r + good_jitter[i - 1][0], az + good_jitter[i - 1][1]
        rad = math.radians(az2)
        x, y = r2 * math.sin(rad), BASE_XY[1] + r2 * math.cos(rad)
        lines.append(_cube_line(f"cube_{i}", x, y, "[1 1 1]"))
        goods.append((f"cube_{i}", x, y))
    rad = math.radians(bad_az)
    bx, by = bad_r * math.sin(rad), BASE_XY[1] + bad_r * math.cos(rad)
    lines.append(_cube_line("cube_4", bx, by, "[1 1 1]"))
    lines.append(_obstacle_line("obstacle_1", bx, by, bad_az))
    path = SCENES_DIR / f"typeB_{seed_idx:02d}.g"
    path.write_text("".join(lines))
    return path, {"cube_4": (bx, by), **{g[0]: (g[1], g[2]) for g in goods}}


def komo_feasible(scene_path, obj_name):
    exe = ROOT / "bin" / "pick_waypoint_check.exe"
    report = ROOT / "generated" / f"pwc_{obj_name}.json"
    cmd = [str(exe), str(scene_path), "--gripper", "l_gripper", "--object", obj_name, "--json", str(report)]
    subprocess.run(cmd, cwd=str(ROOT), capture_output=True, text=True)
    if not report.exists():
        return None
    d = json.loads(report.read_text())
    return (d.get("results", {}).get(obj_name) or {}).get("status") == "feasible"


def select_ours(scene_path, positions):
    """Stage 1 (paper score) then stage 2 (KOMO), over the 4 cube candidates only."""
    cube_names = [k for k in positions if k.startswith("cube_")]
    layout = [{"anon_id": k, "logical_id": k, "object_type": "cube"} for k in positions]
    scored = compute_paper_accessibility_scores(str(scene_path), layout)
    rho = {o["logical_id"]: o["rho"] for o in scored["objects"]}
    stage1_survivors = [c for c in cube_names if rho[c] >= TAU_RHO]
    survivors = [c for c in stage1_survivors if komo_feasible(scene_path, c)]
    return survivors, rho


def select_baseline(positions):
    cube_names = [k for k in positions if k.startswith("cube_")]
    dist = {c: math.hypot(positions[c][0] - BASE_XY[0], positions[c][1] - BASE_XY[1]) for c in cube_names}
    ranked = sorted(cube_names, key=lambda c: dist[c])
    return ranked[:3], dist


def run_full_lgp(scene_path, inventory, exec_dir, timeout_s=120, max_mem_mb=16000):
    exec_dir.mkdir(parents=True, exist_ok=True)
    for f in exec_dir.glob("*"):
        if f.suffix in (".fol", ".lgp"):
            f.unlink()
    cluster = LayerBasedClustering(phase1_json=PHASE1_JSON, max_batch_size=2)
    cluster_res = cluster.build_execution_plan()
    generate_step_files(phase1_json=PHASE1_JSON, prompt1_output=cluster_res["prompt1"],
                        prompt2_output=cluster_res["prompt2"], out_dir=str(exec_dir),
                        inventory_data=[{"logical_id": x} for x in inventory],
                        collision_mode="smart", combine_terminals=False)

    solver = ROOT / "bin" / "x.exe"
    cmd = [str(solver), str(exec_dir.resolve()), str(scene_path.resolve()), "--collision-policy=active_runtime"]
    start = time.time()
    proc = subprocess.Popen(cmd, cwd=str(ROOT / "bin"), stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, bufsize=1)
    peak_mb, mem_exceeded, timed_out = 0.0, False, False
    try:
        ps_proc = psutil.Process(proc.pid)
        last_check = 0.0
        while proc.poll() is None:
            elapsed = time.time() - start
            if elapsed > timeout_s:
                timed_out = True
                proc.kill()
                break
            now = time.time()
            if now - last_check > 1.0:
                last_check = now
                try:
                    rss = ps_proc.memory_info().rss
                    for c in ps_proc.children(recursive=True):
                        try:
                            rss += c.memory_info().rss
                        except psutil.Error:
                            pass
                    peak_mb = max(peak_mb, rss / (1024.0 * 1024.0))
                    if peak_mb >= max_mem_mb:
                        mem_exceeded = True
                        proc.kill()
                        break
                except psutil.Error:
                    pass
            if proc.stdout is not None:
                ready, _, _ = select.select([proc.stdout], [], [], 0.3)
                if ready:
                    proc.stdout.readline()
    finally:
        try:
            proc.kill()
        except Exception:
            pass
    rc = proc.returncode if proc.returncode is not None else -9
    runtime = time.time() - start
    output_state = exec_dir / "output_state.g"
    success = (rc == 0) and output_state.exists() and not mem_exceeded and not timed_out
    return {"success": success, "runtime_s": runtime, "exit_code": rc, "timeout": timed_out,
            "memory_exceeded": mem_exceeded, "memory_peak_mb": round(peak_mb, 2),
            "output_state_exists": output_state.exists(), "output_state_path": str(output_state)}


def render(scene_path, out_png, obj_for_grasp=None, cam=None):
    # render_grasp.exe takes 6 camera args (cx cy cz lx ly lz); render_scene.exe takes 7
    # (the same six plus a height scalar). Passing only 6 to render_scene.exe falls short
    # of its `argc >= 10` check and it silently falls back to the default camera --
    # already bit us once during the A/B pilot renders.
    exe = ROOT / "bin" / ("render_grasp.exe" if obj_for_grasp else "render_scene.exe")
    out_dir = out_png.parent / (out_png.stem + "_raw")
    out_dir.mkdir(parents=True, exist_ok=True)
    cam = list(cam) if cam else [0.9, -0.6, 1.6, 0.0, 0.15, 0.70]
    if obj_for_grasp:
        cam_args = cam[:6]
        cmd = [str(exe), str(scene_path), obj_for_grasp, str(out_dir) + "/", *[str(c) for c in cam_args]]
    else:
        cam_args = cam[:6] + [cam[6] if len(cam) > 6 else 1.0]
        cmd = [str(exe), str(scene_path), str(out_dir) + "/", *[str(c) for c in cam_args]]
    env = dict(__import__("os").environ, DISPLAY=":1")
    subprocess.run(cmd, cwd=str(ROOT / "bin"), env=env, capture_output=True, text=True, timeout=120)
    png = out_dir / "0000.png"
    if png.exists():
        shutil.copy(png, out_png)
        return True
    return False


if __name__ == "__main__":
    print("module loaded OK")
