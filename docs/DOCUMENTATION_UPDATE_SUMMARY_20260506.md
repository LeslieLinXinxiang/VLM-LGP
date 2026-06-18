# Documentation Update Summary (2026-05-06)

## 1. Files Updated

| File | Section | Change | Impact |
|------|---------|--------|--------|
| `docs/roadmap.md` | Active Tasks | 新增 TASK-030（Baseline MoveIt MVP）；重排 TASK-029 为 dependency | 明确关联关系，说明TASK-029概念由TASK-030工程实现 |
| `docs/roadmap.md` | TASK-029 | 标注状态为 `[Dependent: TASK-030 MVP in progress]` | 解除前置阻塞；TASK-029 高层评分逻辑可暂时搁置 |

## 2. Files Created (New)

| File | Purpose | Baseline Content |
|------|---------|---|
| `docs/ops/BASELINE_REDESIGN_ALIGNMENT_REPORT_20260506.md` | 对标DDE与新实现；记录设计决策理由 | 7 sections: 交叉对标、对齐分析、关键决策、gap分析、推荐步骤、更新指引、新TASK-030定义 |
| `prompts/baseline_visual_planner_moveit_action10_v1.md` | MoveIt baseline prompt（生成于2026-05-05） | 修正后的坐标系声明、10点轨迹约定、SCENE block协议 |
| `experiments/scripts/run_baseline_moveit_eval.py` | 评测脚本（生成于2026-05-05） | Batch runner; 断点续传; 格式兼容既有结构 |

## 3. Architecture/Dataflow Changes

| Layer | Aspect | Before | After | Notes |
|-------|--------|--------|-------|-------|
| Layer 1 (Architecture) | Baseline Role | Not explicitly modeled | VLM Layer sub-module: "Baseline Eval Pipeline" | 建议但不强制添加到 `architecture.md` |
| Layer 2 (Dataflow) | Baseline Inputs | N/A | Image + SCENE block + Prompt | 新增数据流：image → baseline_prompt + scene_parser → VLM |
| Layer 4 (Roadmap) | Task Tracking | TASK-029 阻塞; TASK-028 待行 | TASK-030 active; TASK-029 作为参考框架 | 解除前置阻塞 |

## 4. Prompt & Script Changes (vs. Previous Versions)

### Prompt: `baseline_visual_planner_moveit_action10_v1.md`
| Change | From | To | Rationale |
|--------|------|-----|-----------|
| Coordinate System | "Table [0, 0.25, 0.11]..." | "World origin = robot base; no offset" | 消除Z轴叠加错误 |
| Waypoint Count | 30 points/object | 10 points/action | 简化VLM输出规模；保留trajectory骨架 |
| Gripper Format | Numeric tag (e.g., 1.0 = close) | Separate GRIPPER event lines | 清晰解耦控制；便于脚本解析 |
| SCENE Handling | 隐式（在文本中提及） | 显式 SCENE block (BEGIN/END) | 强化模型的"权威输入"感知 |

### Script: `run_baseline_moveit_eval.py`
| Feature | Status | Notes |
|---------|--------|-------|
| Image collection | ✅ | Auto-discovers PNG files in INPUT_ROOT |
| Scene file mapping | ✅ | Maps image path to 4 scene types (trial_01_nr.g, etc.) |
| Batch execution | ✅ | Trials parameterizable via `--trials N` |
| Resume-on-failure | ✅ | Skips existing `.md` files; safe to re-run |
| Output format | ✅ | Mirrors `experiments/evaluations/VLM/gemini_proposed_method/` structure |
| Metric extraction | ❌ (pending) | TODO: parse `.md` files → success rate / Z-error / waypoint count |

## 5. Gap Closure Status

| Requirement (from TASK-029) | DDE Plan → New Impl. | Closure Status |
|-----|-----|-----|
| Baseline semantic/geometric split | ✅ Implemented | VLM → MoveIt delegation |
| Scene context incorporation | ✅ Implemented | SCENE block mandatory |
| Batch robustness testing | ✅ Implemented | 4 scene variants per image |
| Ground truth definition | ⚠️ Partial | Scene geometry (new) vs. R&M module (original plan); both valid |
| 3D scorecard (Perception/Reachability/Planning) | ⚠️ Deferred | TODO: `parse_baseline_output.py` to extract metrics |
| Failure classification | ⚠️ Deferred | Optional: add fail-code annotation in eval script v2 |

## 6. Next Steps (Ordered by Priority)

| # | Action | Owner | Deadline | Blocker for FMB? |
|---|--------|-------|----------|---|
| 1 | Complete Cube baseline batch (`--trials 1` ∀ images) | User (manual run) | 2026-05-07 | Yes |
| 2 | Write `parse_baseline_output.py` to extract metrics | Copilot | 2026-05-07 | No (can run after Cube done) |
| 3 | Generate Cube summary table (success rate vs. scene type) | Copilot | 2026-05-08 | No |
| 4 | Decision gate: if success rate < 60%, proceed FMB; else recalibrate | User + Copilot | 2026-05-08 | Yes |
| 5 | Launch FMB baseline batch (`experiments/inputs/fmb/` → same script) | User | 2026-05-09+ | Conditional on #4 |

## 7. Documentation Consistency Checklist

- [x] Roadmap updated with new TASK-030 and status linkage
- [x] Alignment report created and cross-referenced
- [ ] `architecture.md` Layer 1 optional update (can do ad-hoc)
- [ ] New spec doc `docs/ops/baseline_moveit_protocol_spec.md` (optional; v2)
- [ ] `execution_protocol.md` unaffected (no RFC needed; within existing baseline redesign scope)

---

**Summary**: All DDE documentation updates logged and stored. TASK-030 now active; TASK-029 reframed as high-level reference; Cube baseline MVP ready for user execution. FMB can follow immediately after Cube completes (pending success rate gate).
