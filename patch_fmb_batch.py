import re
path = 'experiments/scripts/run_fmb_batch_eval.py'
text = open(path).read()

new_run_one = """def run_one(vlm_md, scene_g, trial_work_dir, timeout_s, max_mem_mb):
    trial_work_dir.mkdir(parents=True, exist_ok=True)
    
    smart_done = (trial_work_dir / "lgp_split_smart" / "output_state.g").exists()
    global_done = (trial_work_dir / "lgp_split_global" / "output_state.g").exists()
    if smart_done and global_done:
        return [{"success": True, "cached": True}] * 2

    # Phase 0
    phase0 = execute_phase0(
        use_vlm=False,
        unnamed_g_path=str(scene_g),
        auto_prepare_from_named_scene=False,
        reachability_mode="gmm_esdf_mvp",
    )
    if not phase0 or not phase0.get("success"):
        return [{"success": False, "error": "phase0_failed", "runtime_s": 0}]

    scene_ready = Path(phase0["scene_named_path"])
    layout = phase0["layout"]

    # Phase 1 JSON
    phase1_json = _extract_json_from_md(vlm_md)

    # Clustering + codegen
    clustering = LayerBasedClustering(phase1_json=phase1_json, max_batch_size=2)
    plan = clustering.build_execution_plan()
    
    results = []

    for lgp_mode in ["lgp_split_smart", "lgp_split_global"]:
        mode_dir = trial_work_dir / lgp_mode
        if (mode_dir / "output_state.g").exists():
            print(f"  - {lgp_mode} already done, skipping.")
            results.append({"success": True, "cached": True, "mode": lgp_mode})
            continue

        if mode_dir.exists():
            shutil.rmtree(mode_dir)
        mode_dir.mkdir(parents=True, exist_ok=True)

        policy = "active_runtime" if lgp_mode == "lgp_split_smart" else "follow_lgp"
        coll_mode = "smart" if lgp_mode == "lgp_split_smart" else "global"

        generate_step_files(
            phase1_json=phase1_json,
            prompt1_output=plan["prompt1"],
            prompt2_output=plan["prompt2"],
            out_dir=str(mode_dir),
            inventory_data=layout,
            collision_mode=coll_mode,
        )

        print(f"  - Running {lgp_mode} (policy={policy})...")
        solver_res = _run_solver(exec_dir=mode_dir, scene_g=scene_ready, timeout_s=timeout_s, max_mem_mb=max_mem_mb, collision_policy=policy)
        (mode_dir / "solver_stdout.log").write_text(solver_res.pop("stdout"), encoding="utf-8")
        solver_res["mode"] = lgp_mode
        results.append(solver_res)

    return results
"""

# Replace run_one
text = re.sub(r'def run_one\(.*?def main\(\):', new_run_one + '\n\ndef main():', text, flags=re.DOTALL)

# In main(), change out_dir to trial_work_dir and handle results
main_replacement = """                    trial_work_dir = out_base / mag / scen_id / f"trial_{trial_idx:02d}_{mode}"

                    if args.skip_existing and (trial_work_dir / "lgp_split_smart" / "output_state.g").exists() and (trial_work_dir / "lgp_split_global" / "output_state.g").exists():
                        print(f"  [CACHED] {mag}/{scen_id}/trial_{trial_idx:02d}_{mode}")
                        skip += 1
                        continue

                    total += 1
                    tag = f"{mag}/{scen_id}/trial_{trial_idx:02d}_{mode}"
                    print(f"\n[{total}] Running: {tag}")

                    try:
                        res_list = run_one(vlm_md, scene_g, trial_work_dir, timeout_s=args.timeout_s, max_mem_mb=args.max_mem_mb)
                    except Exception as e:
                        res_list = [{"success": False, "error": str(e), "runtime_s": 0}]

                    for res in res_list:
                        ok = res.get("success", False)
                        if ok:
                            success += 1
                        else:
                            fail += 1

                        status = "✓" if ok else "✗"
                        print(f"  {status} [{res.get('mode', 'unk')}] success={ok} runtime={res.get('runtime_s', 0):.1f}s "
                              f"mem={res.get('memory_peak_mb', 0):.0f}MB "
                              f"timeout={res.get('timeout', False)} oom={res.get('memory_exceeded', False)}")

                        if not res.get("cached", False):
                            # Save per-trial meta
                            meta = {"tag": tag, "vlm_md": str(vlm_md), "scene_g": str(scene_g), **res}
                            mode_sub = res.get('mode', 'unk')
                            if mode_sub != 'unk':
                                (trial_work_dir / mode_sub / "trial_meta.json").write_text(json.dumps(meta, indent=2), encoding="utf-8")
                            results_log.append(meta)
"""

text = re.sub(r'                    out_dir =.*?results_log\.append\(meta\)', main_replacement, text, flags=re.DOTALL)

with open(path, 'w') as f:
    f.write(text)
