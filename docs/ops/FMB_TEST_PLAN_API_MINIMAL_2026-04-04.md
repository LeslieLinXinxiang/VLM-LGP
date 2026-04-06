# FMB 测试方案提案 B：API 最小化接口测试（不接主线）

- 日期：2026-04-04
- 目标：基于现有主线逻辑做最小化离线调用与质量检查，不改主 pipeline。
- 输入主模态：固定视角 sequential 灰度装配图（单一模态）。

## 1. 测试目标

1. 在本地 API 调用链上验证协议可执行性。
2. 复用现有校验逻辑检查 VLM 输出质量。
3. 确认在不接主线的前提下可稳定完成“输入 -> VLM -> 校验”闭环。

## 2. 复用现有逻辑边界

建议复用：

1. `core.vlm.VLMClient` 的多模态 `prompt_content` 组装方式。
2. `pipeline/run_phase1.py` 中的 `validate_plan(...)` 作为质量门。

不做的事：

1. 不改 `execute_phase1()` 主流程。
2. 不改 driver / phase0 / phase2 主线接线。

## 3. 最小化脚本设计

新增一个独立测试脚本（建议路径）：

- `test/fmb_protocol/run_fmb_minimal_api_check.py`

职责：

1. 扫描真实任务图片文件夹并按文件名排序读取图片。
2. 读取 `fewshot_manifest.json`，加载启用的 few-shot。
3. 读取 prompt markdown。
4. 构造 `prompt_content`（顺序与文档一致）。
5. 调用 `VLMClient._call_vlm_with_retry(..., is_json_output=True)`。
6. 将输出交给 Phase0 风格 JSON 结构校验器。
7. 输出结构化测试报告（成功/失败 + 错误明细）。

## 4. 运行前置条件

必须在项目运行时环境下执行：

1. `source /home/leslie/anaconda3/etc/profile.d/conda.sh && conda activate vlm_jazzy`
2. `source scripts/env.sh`

## 5. API 测试输入输出定义

### 5.1 输入

1. `--prompt prompts/phase0_fmb_sequential_binding.md`
2. `--task-folder test/fmb_protocol/task_01/sequence`
3. `--fewshot-manifest test/fmb_protocol/fewshot/fewshot_manifest.json`
4. `--out generated/fmb_protocol_api_output.json`

### 5.2 输出

1. 原始模型输出 JSON 文件。
2. 校验报告 JSON（字段建议）：
   1. `is_valid`
   2. `schema_check`
   3. `object_count_check`
   4. `ordering_check`
   5. `error_list`
   6. `run_meta`（模型名、时间、输入配置）

## 6. 最小测试用例集合

1. Case-1：0-shot（仅任务输入）
2. Case-2：2-shot（推荐最小生产候选）
3. Case-3：3-shot（上限前对照）

每个 case 重复 3 次，比较：

1. 结构合法率
2. 一致性
3. 对象绑定错误数

## 7. 质量判定门槛（建议）

1. 结构合法率 = 100%
2. 3 次重复中至少 2 次输出一致
3. 不允许输出明显的重复对象或跳序对象

若未达标，回退顺序：

1. 先调整 few-shot 选择（不是增加数量）。
2. 再调整 prompt 文本约束。
3. 最后才考虑彩色 fallback。

## 8. 与主线集成前的出口条件

只有满足以下条件才建议接主线：

1. API 最小测试三类 case 全部通过。
2. 失败样本已归档并可解释。
3. 固定了最终 few-shot 组合与 prompt 版本号。

## 9. 产出物

1. `generated/fmb_protocol_api_output.json`
2. `generated/fmb_protocol_api_report.json`
3. 一份固定配置清单（prompt 版本、few-shot id 列表、渲染设置）
