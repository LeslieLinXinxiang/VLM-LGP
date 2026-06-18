# LGP CubeStacking Comparison Batch Test Plan

## 1. 实验目标
利用已通过验证（VLM Phase1 拓扑正确）的测试数据，自动化地将它们转化为 `.fol/.lgp` 执行文件，并分发到三种不同碰撞策略/层级切分的求解器任务中运行，最终收集并横向对比其成功率、运行时间和内存消耗。

## 2. 实验核心逻辑（三种模式对比）
核心在于对同一 `Phase1 JSON` 和同一 `Scene (*.g)` 产出的 `.lgp` 文件施加不同的后处理（Post-processing），随后调用 C++ 求解器执行。

### 模式一：`lgp_monolithic`
- **生成方式**：将所有的 Phase1 Object 图塞进一个 batch 里面（一次性求解）。
- **碰撞策略**：全局碰撞开（`genericCollisions: true`, `coll: []`）。
- **预期特征**：理论上能找到最优全局解，但内存消耗大，耗时最长，规模上升后（6cubes+）失败率陡增。

### 模式二：`lgp_split_manual` (Layer-based default)
- **生成方式**：使用 `test/layer_based_clustering` 算法将任务切分为若干 sequential batches（分段求解）。
- **碰撞策略**：全局碰撞依旧全部开启（`genericCollisions: true`, `coll: []`）。
- **预期特征**：比 monolithic 快，通过降维缩小了每步搜索空间。但因全局碰撞未关，后续步骤极易与已经搭建好的建筑发生不可预见的阻碍导致 IK 无解。

### 模式三：`lgp_split_manual_smart_collision`
- **生成方式**：同样使用 layer-based 算法进行切分（分段求解）。
- **碰撞策略**：关闭全局碰撞（`genericCollisions: false`），但基于几何近邻算法（AABB / 欧氏距离阈值）或直接的层级依赖，向 `.lgp` 的 `coll:` 字段中注入必要的**显式碰撞对**。
- **预期特征**：剔除了与当前动作无关物体的干涉，求解极快且成功率最高。

## 3. 实验数据选取与配对
**数据池**：
- VLM 正确输入池：通过 `experiments/outputs/gemini_proposed_method/accuracy_analysis/cubeStacking/*/accuracy_report.md` 筛选出评测结果为通过的 `trial_*.md`。为控制规模，每个 sample（如 `cube_n04_s01`）仅挑取 **1 个正确的 trial** 作为标准 Phase1 JSON 输入。
- 物理场景池：`experiments/scenes/<n_cubes>cubes/s0<x>/without_redundancy/*_nr.g` 及其对应的 `with_redundancy/*_r.g`（按用户要求，先统一用 `*_nr.g` 跑最小化测试）。

**配对机制**：
1 个正确的 Graph (JSON) $\times$ N 个对应的物理场景文件（同一结构的物体初始摆放位置不同）。
例如：`cube_n04_s01` 选出的标准 `trial_01.md` 的 JSON $\times$ 对应的 10 个 `trial_xx_nr.g` = 10 次求解。

## 4. 目录与文件管理方案 (1:1 保留架构)
执行结果将保存在 `experiments/evaluations/LGP_execution/cubeStacking/` 下。

结构如下：
```text
experiments/evaluations/LGP_execution/cubeStacking/
└── 4cubes/
    └── s01/
        └── nr/                   # Without redundancy 场景测试
            ├── scene_trial_01/   # 对应物理场景文件 01
            │   ├── lgp_monolithic/
            │   │   ├── step_1_batch_1.fol
            │   │   ├── step_1_batch_1.lgp  (已注入对应碰撞设置)
            │   │   ├── solver_stdout.log
            │   │   ├── output_state.g      (若成功)
            │   │   └── trial_meta.json     (关键统计信息)
            │   ├── lgp_split_manual/
            │   └── lgp_split_manual_smart_collision/
            ├── scene_trial_02/
            ...
```

## 5. 关键运行指标记录 (在 `trial_meta.json` 中保存)
必须详细记录，保证后续统计的可追溯性：
- `success`: bool (是否求解成功)
- `runtime_s`: float (花费的总时间)
- `memory_exceeded`: bool (是否因达到 99% 内存被终止)
- `memory_peak_mb`: float (求解过程中的内存峰值)
- `timeout`: bool (是否超出设定的硬时间限制，如 5 分钟)
- `batch_count`: int (本次策略生成的求解批次数)
- `phase1_source`: string (指向生成此任务的原始 trial MD 路径)
- `scene_file`: string (运行使用的物理场景文件路径)
- `collision_mode`: string (global / explicit)
- `explicit_pairs_count`: int (如果是智能碰撞模式，记录启用了多少对碰撞)

## 6. 系统资源监控防崩溃机制
由于 monolithic 容易 OOM 或陷入死循环，将采用双重保险：
1. **进程级 `psutil` 软监控**：启动一个独立 Python 线程，每隔 1 秒检查 `bin/x.exe` 及其子进程的内存使用率。一旦占用系统内存达到 90%，主动发送 `SIGKILL` 掐断任务，并在 `trial_meta.json` 中标记 `memory_exceeded = true`。
2. **时间限制**：`subprocess.run(timeout=300)` 设置 5 分钟硬超时，避免不可解情况下的无限搜索。

## 7. 分步实施路径

### 步骤一：创建并运行最小化验证测试（Current Target）
- 目标：不跑全量，仅针对 `4cubes/s01` 选取一个正确 trial 和它的第一个 `nr` 场景，生成三种模式文件并执行，确认数据链条畅通且监控生效。
- 脚本：编写 `experiments/scripts/run_lgp_minimal_test.py`。
- 操作：自动读取正确 JSON -> 生成 3 种模式 -> 应用不同 collision 后处理 -> 启动带内存监控的 solver -> 保存 log。

### 步骤二：审查最小化测试日志
- 由用户确认生成的 `.lgp` 后处理是否符合预期，`trial_meta.json` 的指标是否够用。

### 步骤三：编写全量批量运行脚本
- 编写 `experiments/scripts/run_lgp_batch_eval.py`。
- 从 accuracy report 自动捞取全部 4-8 cubes 的基准 trial，扫描 scenes 文件夹做笛卡尔积配对，带有进度条地执行全量测试。

### 步骤四：输出汇总与统计绘图
- 编写汇总脚本，读取所有 `trial_meta.json`，导出为 CSV。
- 可视化各策略随物体数量（4->8）上升时，成功率的断崖式下降曲线以及内存占用的飙升对比。