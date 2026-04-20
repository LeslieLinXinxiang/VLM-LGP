# Layer-Based Clustering Minimal Test (Pipeline-Compatible)

## 目标

在 `test/` 下提供一个最小化、可执行、可复现实验：

1. 输入沿用当前 pipeline Phase1 格式（`objects + edges`，兼容 `V/E`）；
2. 输出保持与当前 Phase2 消费端一致（`prompt1/prompt2` schema）；
3. 生成完整执行计划与策略追踪；
4. 直接调用现有 codegen 生成 `.fol/.lgp` 可执行文件；
5. 自动输出详细报告（包含算法逻辑、输入输出格式、运行结果）。

## 文件

- `run_layer_based_codegen.py`：主测试脚本。

## 运行方式

在项目根目录，先进入项目运行环境后执行：

- 默认输入：`generated/phase1_target_graph.json`
- 默认输出：`generated/layer_based_policy_run`

参数：

- `--input`：Phase1 图 JSON 路径。
- `--out-dir`：输出目录。
- `--node-id`：执行节点 ID（写入计划元信息）。
- `--max-batch-size`：每批最大对象数（默认 2）。

## 核心逻辑（最小实现）

1. 解析支持图（support DAG）。
2. 计算拓扑层级（layer）。
3. 基于 table-root 推导 provenance 集合（source-priority）。
4. 每轮只处理当前可执行集合中的最小层（same-layer block）。
5. 按 provenance 分支键分组（同源优先，合流为 merge 分支）。
6. 分支内按 left-to-right 排序（优先读 `position`，缺失时用 provenance root 序回退）。
7. 按 `max_batch_size` 切分 chunk（默认 2）。
8. 导出 Prompt1/Prompt2 + execution plan + policy trace。
9. 调用 `core.phase2_codegen.generate_step_files()` 产出 `step_*.fol/.lgp`。

## 产物说明

脚本会在 `--out-dir` 下生成：

- `execution_plan.json`：完整执行顺序/批次/层级块。
- `policy_trace.json`：逐批次策略轨迹。
- `phase2_strategy_policy.json`：`prompt1/prompt2` 标准输出。
- `layer_based_metadata.json`：层、roots、provenance、分支赋值等元数据。
- `step_*.fol/.lgp`：求解器可执行任务文件。
- `layer_based_test_report.md`：详细实验报告（含输入输出 schema 与运行摘要）。

## 兼容性说明

- 输出 schema 与现有 pipeline 下游（`phase2_codegen`）兼容。
- 该测试为隔离实验，不改动主 pipeline 默认算法。
