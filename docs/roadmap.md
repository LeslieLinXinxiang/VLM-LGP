# Layer 4: Project Roadmap & Task Tracker

## 1. Current Active Tasks (Timeline Log)
### [TASK-004] Planar Arrangement Prompt Refinement
* **Status**: `[In Progress]`
* **Created**: 2026-03-09 14:38
* **Completed**: N/A
* **Timeline**:
    * *2026-03-09 14:38*: Shifted focus from 3D pyramid assembly to 2D planar arrangement. Beginning analysis of prompt files.
    * *2026-03-10 15:10*: Completed RFC for Phase 1 `target_graph.json` format. Agreed on a scientific **Adjacency List (Vertices & Edges) DAG st\]
    ructure** to replace string-based slots. Task paused for token context refresh; next steps are execution. See `docs/AI_HANDOFF_PHASE1_GRAPH.md` for continuation instructions.
    * *2026-03-10 15:30*: Session resumed and TASK-004 execution started. Updated `prompts/phase1_graph_planner.md` to the new DAG `graph.vertices + graph.edges` schema and object vocabulary.
    * *2026-03-10 16:07*: Completed isolated Phase1 VLM test in `vlm_jazzy` using `prompts/phase1_graph_planner.md` + `test/image.png`. Output `generated/phase1_target_graph_test.json` passed DAG schema validation. Added runtime/env runbook updates to `docs/execution_protocol.md` and `docs/module_specs/python_scripting_layer.md`.
    * *2026-03-10 18:53*: Migrated Phase1 runtime to on-list DAG flow in executable path: validator now supports `objects/on` with legacy fallback, and added standalone GUI Phase1 I/O test script (`scripts/test_phase1_interface.py`).
    * *2026-03-10 18:53*: Improved VLM robustness: fixed RGBA-to-JPEG upload error in `core/vlm.py`, tuned sampling (`temperature=0.05`, `top_p=0.35`), and enabled marker-based JSON extraction via `## FINAL_JSON_START/## FINAL_JSON_END` in `core/utils.py`.
    * *2026-03-10 19:30*: **Phase0 → Phase1 I/O 闭环成立**。根因分析确认 `incontext_training/orientations` slot-orientation 示例与 Phase1 任务类型完全不匹配，长期作为上下文污染源；已注释掉 `pipelines/run_phase1.py` 中的加载与注入路径（`example_content=None`）。同步在 `prompts/phase1_graph_planner.md` (V66) 新增 Shelf-Check 几何一致性规则：若某对象的 `on` 列表含 3 个及以上 Cube 大小 supporter，则该对象必须分类为 `Rectangular Prism`。独立脚本 `scripts/test_phase1_interface.py` 端到端验证通过（PASS），Phase1 结构图输出稳定落盘。
    * *2026-03-11 13:23*: **当前下一步已切换为 Phase2 + Phase3 联调**。目标是打通 `phase1_target_graph.json -> Phase2 strategy/compile -> Phase3 inspector` 的闭环，优先验证：① Phase2 输入消费 Phase1 on-list DAG 正确；② Phase3 对执行后场景的结构一致性回传可用于下一轮修正；③ 形成最小可复跑联调脚本与验收日志。
    * *2026-03-11 17:22*: **Phase2 Two-Prompt + Python Codegen 单段联调通过**。已完成 `prompt2` 选择协议、`phase2_codegen` 规则注入（VLM只给结论，Python生成 `.fol/.lgp`）、以及 table/rect 左右贴片 terminal 映射；当前待办为将生成脚本交给 LGP solver 完整顺序执行一遍并记录通过/失败日志。
    * *2026-03-11 17:22*: **Phase0 反向构建验证通过（贴片保留）**。以 `generated/scene_named.g` 为输入重跑 `execute_phase0(use_vlm=False, auto_prepare_from_named_scene=True)`，确认 `generated/scene/unnamed.g` 与 `generated/scene/scene_named.g` 均保留 `Table_Left/Right` 与 `Rect_N_Left/Right` 贴片，当前无需修改 Phase0 正则替换函数。
    * *2026-03-11 17:56*: **Phase0 -> Phase2 主链路已基本完成**。已在主流程入口完成 `Phase0`、`Phase1`、`Phase2(gatekeeper + retry loop + codegen)` 串行验证，并支持 `stop_before_solver=True` 在文件输出处停止；当前仅剩最后一步：将完整产物接入 LGP solver 做端到端全链路最终打通与验收记录。

## 2. Completed Tasks Rolling Archive (Max 50)
> **Rule**: When adding the 51st item, delete the oldest item to prevent context poisoning. Summarize tasks in 1-2 lines. All timestamps MUST use `YYYY-MM-DD HH:MM` format.

1. **[TASK-003] Constraint Cleanup in manipTools.cpp (2026-03-09 13:35)**: Removed overlapping soft `OT_sos` constraints in pick and place sequences to prevent solver stalling.
2. **[TASK-002] Multi-Support Hovering Fix (2026-03-08 14:30)**: Replaced absolute Z `getSize()(0)` with relative `FS_positionDiff` and fixed XY alignment in `action_place_on_multi_support`.
2. **[TASK-001] DDE-Bootstrap Setup (2026-03-08 15:22)**: Generated Layer 0-4 Documentation-Driven Engineering protocol to prevent hallucination.

## 3. Pending Backlog
- Replace/optimize soft `OT_sos` objectives that conflict with hard `OT_eq` requirements in the manipulation logics.
- Improve KOMO solver execution time for multi-step `LGP_TAMP` batches.
- **[VLM-LGP] 跑通全链路 VLM + LGP 端到端验证**: 完成 Phase0 -> Phase1 -> Phase2 -> Phase3 全链路打通，沉淀 smoke-test 与验收标准。**进展(2026-03-10)**: 已完成 Phase1 单段 I/O 链路、结构校验、可复跑测试脚本与产物落盘；全链路联调仍待完成。
- **[NEXT STEP][VLM-LGP] 全链路最终打通（最后一步）**: 在当前已完成的 `Phase0 -> Phase2` 基础上，将 `generated/node_1_run` 产物正式接入 LGP solver 完整执行，沉淀最终验收日志（成功记录 + 失败诊断样例）。
- **[VLM-LGP] 引入 MuJoCo 仿真完成调试闭环**: 构建与 generated/scene_named.g 对齐的 MuJoCo 场景，完成完成关键动作（抓取/放置）与仿真状态同步检查，形成可复现实验脚本纳入回归测试，确保联调成功截图。
- **[VLM-LGP] 固定 Gemini 支持地区出口，完成 VLM 调通**: 在代理客户端将节点组固定到 US 节点，加入 Phase0 启动前出口自检逻辑，成功完成 `--mode vlm` 测试。
- **[IN PROGRESS][VLM-LGP] Phase0 脚本注入 Rect_N_Left/Right 贴片命名**: 已在 `generated/scene_named.g` 注入并验证可被 Phase0 反向构建保留（`generated/scene/unnamed.g` 与 `generated/scene/scene_named.g` 已见到贴片）；下一步将把该注入逻辑下沉到 Phase0 自动生成路径，避免手工维护。
- **[IN PROGRESS][VLM-LGP] Phase2 产物交由 LGP solver 完整顺序执行**: 使用 `generated/node_1_run` 与 `generated/phase2_codegen_run` 中按序脚本执行完整求解；当前状态为“前置环节已通过，仅差 solver 最后一跳”。
