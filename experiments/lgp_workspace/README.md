# LGP 测试工作空间 (Sandbox)

这个文件夹专门用于 **快速测试 LGP 求解器**。你可以将生成的 `.fol` 和 `.lgp` 文件放在这里独立运行，而不需要关心 VLM 或其他流水线逻辑。

## 目录说明

- `current_test/`: 默认的测试任务文件夹。你可以把 `.fol` 和 `.lgp` 文件丢进这里。
- `quick_solve.py`: 核心执行脚本，调用项目根目录下的 `bin/x.exe`。
- `quick_run_last_stdout.log`: 上一次运行的完整终端输出（包含轨迹数据）。

## 快速开始

1. **准备测试文件**：
   将你需要测试的文件拷贝到 `current_test/` 目录下（例如从 `generated/node_1_run/` 下拷贝）。

2. **执行求解**：
   ```bash
   python3 quick_solve.py
   ```

3. **指定自定义路径**（如果文件不在 `current_test` 下）：
   ```bash
   python3 quick_solve.py --dir path/to/your/task --scene path/to/your/scene.g
   ```

## 核心关注点

- **LGP 语法**：如果求解器报错，通常是 `.fol` 文件中的谓词逻辑或 `.lgp` 中的符号序列有误。
- **轨迹获取**：执行成功后，`quick_run_last_stdout.log` 中会包含物理轨迹。你可以将其拷贝到 `test/run_mujoco_trajectory.py` 中进行仿真验证。

---
*Created by Antigravity on 2026-04-24*
