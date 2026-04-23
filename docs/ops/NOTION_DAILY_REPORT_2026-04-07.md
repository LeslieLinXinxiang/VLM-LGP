# 260407 实验日报 - FMB Input-to-Codegen 最小化链路闭环 (VLM-LGP)

## 🎯 1. 核心目标 (Objective)
在不改动主线 pipeline 的前提下，完成 FMB 输入图到 Phase1/Graph/Codegen 的最小化验证闭环，并将资产与提示词输入协议稳定到可复现实验状态。

## 🛠️ 2. 今日完成事项 (Actions Taken)
- **输入侧脚本落地（test-only）**
	- 新增 `test/fmb_guiding_input/render_guiding_images.py`：支持从 `.g` 场景直接渲染 guiding images，按场景文件夹/文件名规则输出。
	- 新增 `test/fmb_guiding_input/tune_camera_pose.py`：交互式调参并支持回车打印可复制相机位姿。
- **FMB 资产修复与验证**
	- 排查 assembly2/assembly3 白图问题，定位为 OBJ 几何退化（零几何）。
	- 通过 STEP 重导并进行单位修正（mm->m）恢复几何；随后执行 bbox-center 对齐，修复 assembly3 坐标偏移。
	- 产出并验证对应场景：`test/planar_exp/planar_scene_assembly2obj.g`、`test/planar_exp/planar_scene_assembly3obj.g`。
- **最小化输出链路验证（不改主线）**
	- 新增 `test/fmb_output_test/test_phase1_to_codegen.py`：图片->Qwen->Phase1 JSON->Graph Clustering->Codegen。
	- 修复 VLM 响应兼容性问题：支持 dict/str 双返回，避免 JSON 二次解析报错。
	- 新增 `test/fmb_output_test/test_paste_vlm_output_to_codegen.py`：支持终端粘贴或文件输入 VLM 输出，正则提取 `FINAL_JSON` 后离线生成执行文件。

## 📌 3. 关键决策与约束 (Decisions)
- 本轮严格遵守“**仅在 test 目录新增脚本，不改主线业务代码**”。
- Phase2 路径使用 **graph clustering**，不走策略候选 VLM。
- 最小化测试暂不接 reachability/manipulability，先保证语义链路稳定可复现。

## 📊 4. 阶段结果 (Outcome)
- FMB 输入图构建链路已可稳定复用。
- assembly2/assembly3 资产已从“白图/偏移不可用”恢复到“可渲染、可进入后续测试”。
- 在线（API）与离线（粘贴）两种输出验证链路都已可运行，便于后续 prompt 迭代与回归测试。

## ⚠️ 5. 风险与待办 (Risks / Open Items)
- `core/phase2_codegen.py` 仍保留 `id=0 -> table` 的映射行为；若后续需要 `base` 直出，需要在主线单独评审后改动。
- 抓取/放置 frame 的统一规范尚未完全收敛，仍需在资产层和场景层明确优先级。

## 🚀 6. 下一步计划 (Next Steps)
1. 优先推进 FMB 物体抓取/放置 frame 统一策略：优先 OBJ 级别规范化（底面/中心），`.g` 子 frame 偏置仅作 fallback。
2. 在固定 prompt 协议下，对 assembly2/assembly3 执行多轮 VLM 输出稳定性对比。
3. 在 symbol 规则确认后，执行至少 1 次从 Phase1 到 LGP solver 的整链路求解验证。
