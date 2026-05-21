# VLM-LGP Pipeline Execution Guide

本指南详细说明了当前已经完全跑通的各个阶段测试脚本与执行方式。

## 核心前提说明
**截至目前，除了最终的 MuJoCo 动力学仿真外，前置的所有阶段（包含 Reachability Waypoint 过滤、Manipulability 打分排序、VLM 图生成、阶段2 策略分级、LGP TAMP 求解器端到端生成）均已彻底跑通。**

以下是各阶段对应执行的脚本清单（需确保已位于 `vlm_jazzy` 环境并 `source scripts/env.sh`）：

---

### 1. 完整测试运行（包含 VLM 推理）
**目标**：从头启动，调用 VLM 并端到端生成 LGP 轨迹。
- **新主线入口**：`python3 driver_gemini_mainline.py --image generated/phase1_target.png --vlm-backend gemini --gemini-model gemini-3.0-flash --execution-mode docker`
- **阶段 0**：`python3 pipeline/run_phase0.py`（完成 Reachability 测算）
- **阶段 0.5**：`python3 test/manipulability/run_static_manipulability_test.py --layout generated/phase0_layout.json --infeasible generated/infeasible_objects.json --g-file unnamed.g --urdf rai/test/newLGP/rai-robotModels/panda/panda_arm_hand.urdf`
- **阶段 1 (VLM)**：`python3 pipeline/run_phase1.py`（该脚本会弹窗要求选择输入图片，并调用 VLM 接口输出 `phase1_target_graph.json`）
- **阶段 2 (LGP 前置)**：使用测试沙盒脚本或通过 `PYTHONPATH=$PWD python3 pipeline/run_phase2.py` 生成 `.fol` 与 `.lgp` 文件。
- **部署包导出**：新主线会额外输出 `traj.txt` 与 `gripper.txt`，其中 `gripper.txt` 保存的是 1-based 轨迹行号切换点，默认开夹爪，按 close/open 交替。
- **LGP 求解器**：自动拉起或手动执行 `bin/x.exe generated/node_1_run generated/scene/scene_named.g`

### 2. 完整测试运行（不包含 VLM 推理，直接使用已有图缓存）
**目标**：适用于调试下半场，直接消费 `generated/phase1_target_graph.json`。
- 执行完整的测试链即可：
```bash
python3 pipeline/run_phase0.py
python3 test/manipulability/run_static_manipulability_test.py ...（参数同上）
# 跳过 phase1，直接以 Python 脚本方式调用 Phase2：
python3 /tmp/run_phase2_cmd.py
# (或使用 test/integration/ 里的集成测试脚本)
```

---

### 3. 单独测试 VLM 接口
- **脚本**：`python3 pipeline/run_phase1.py`
- **执行过程**：会触发本地弹窗，选择一张 RGB 场景图片后，VLM 被调用。
- **核心输出**：`generated/phase1_target_graph.json`（包含了带有空间支撑关系的 Object & Edges 逻辑图）。

### 4. 单独测试 Reachability (可达性 Hard Gate)
- **脚本**：`python3 pipeline/run_phase0.py`（或底层测试 `python3 test/reachability/run_pick_waypoint_check.py`）
- **核心输出**：
  - `generated/infeasible_objects.json`（因单帧运动学碰撞不可达的黑名单）
  - `generated/phase0_layout.json`（物体的名字与ID绑定）。

### 5. 单独测试 Manipulability (可操作度软排序)
- **脚本**：`python3 test/manipulability/run_static_manipulability_test.py --layout generated/phase0_layout.json --infeasible generated/infeasible_objects.json --g-file unnamed.g --urdf rai/test/newLGP/rai-robotModels/panda/panda_arm_hand.urdf`
- **核心输出**：
  - `generated/feasible_objects_static_test.json`（剔除了原先不可达点后的合法名单）
  - `generated/ordering_score_report_static_test.json`（剩余物体的高低分热力图得分排行）。

### 6. 单独测试 LGP 求解器 (TAMP 搜索与平滑轨迹优化)
- **脚本**：`bin/x.exe <task_dir> <scene.g>`
- **示例**：`bin/x.exe generated/node_1_run generated/scene/scene_named.g`
- **过程**：底层会调用 `Default_LGP_TAMP_Abstraction`，自动匹配对应的 `.fol` 第一级决策和 `.lgp` 运动学骨架，并完成所有的非线性轨迹生成。
- **输出**：带时间戳的 `active_collision_history/report_xxx.json`，以及在运行目录下覆盖更新的 `output_state.g` 最终动力学落定结果。
