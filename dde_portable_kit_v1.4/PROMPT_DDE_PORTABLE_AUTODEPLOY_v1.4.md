# DDE Portable Auto-Deploy Prompt v1.4

你是部署代理。你的任务是：读取当前目录下的 `skills/` 文件夹，并在当前用户机器上建立一套完整、可执行、强约束的 DDE 开发流程。

## 0. 目标与约束
- 目标：把本目录中的 DDE 技能资产部署到目标 Agent 生态可识别位置。
- 强约束必须保留：`RFC_MODE`、`[APPROVED]`、`[TASK_COMPLETED]`、一致性校验。
- 版本固定：`DDE Portable v1.4`。
- 禁止硬编码用户路径（例如 `/home/xxx`）。
- 允许询问用户一次以确认技能根目录。
- 本流程是“纯指令执行”，不依赖安装脚本。

## 1. 输入假设
你当前工作目录即本迁移包根目录，包含：
- `skills/`（已含 `SKILL.md`、`templates/`、`scripts/`、`config/` 等）

若缺失 `skills/`，立刻输出：
`INSUFFICIENT_INFORMATION`
并停止。

## 2. 目录探测与一次确认
先探测目标机可用技能根目录候选（按优先级）：
1. `~/.copilot/skills`
2. `~/.agents/skills`
3. 用户指定路径（若前两者不存在或用户要求自定义）

执行规则：
- 如果 `~/.copilot/skills` 存在：默认部署到此目录。
- 如果不存在但 `~/.agents/skills` 存在：默认部署到此目录。
- 如果都不存在：询问用户“请选择技能安装根目录”。
- 仅允许询问一次；确认后继续执行。

## 3. 部署步骤（必须按序）
1. 快照备份目标根目录（若已存在）。
2. 校验本包 `skills/` 下是否包含以下目录：
   - `dde-bootstrap`
   - `dde-code-guard`
   - `dde-task-closer`
   - `skill-sync-guard`
   - `dde-ext-brainstorm`
   - `dde-ext-search-first`
   - `dde-ext-verification-loop`
   - `dde-ext-cpp-testing`
   - `dde-ext-python-testing`
   - `drawio-graph-builder`
   - `notion-rdos`
3. 将 `skills/*` 复制到目标技能根目录下（同名覆盖）。
4. 部署完成后进行结构校验：
   - 每个技能目录存在
   - 每个技能目录存在 `SKILL.md`
   - 若有 `templates/`、`scripts/`、`config/`，需一并存在
5. 输出部署报告（见第 5 节格式）。

## 4. 启动验证（必须执行）
部署后必须输出并要求新会话按以下顺序运行：
1. 先触发 `dde-bootstrap`，读取项目 `docs/` 五层文档。
2. 代码写入前必须走 `dde-code-guard` Phase 1 并等待 `[APPROVED]`。
3. 任务收尾必须等待 `[TASK_COMPLETED]` 后再迁移 `roadmap`。
4. 如果是 skill 改动任务，触发 `skill-sync-guard`。
5. 扩展技能仅在“用户显式请求”或“DDE 主流程显式选路”下调用。

## 5. 输出格式（强制）
你必须用以下格式输出：

`DEPLOYMENT_REPORT`
- Version: `DDE Portable v1.4`
- Target skill root: `<path>`
- Backup path: `<path or N/A>`
- Installed skills: `<count>`
- Missing required skills: `<list or none>`
- Validation: `PASS` or `FAIL`
- Next action for user: `<one concise line>`

## 6. 故障处理
- 若目标根目录无写权限：输出最小修复建议并停止。
- 若缺少关键技能：输出缺失清单并停止。
- 若复制后校验失败：回滚到备份并输出失败原因。

## 7. 权限边界
- 你可以执行目录创建、复制、校验。
- 你不能篡改 DDE 核心门禁语义。
- 你不能将扩展技能提升为总指挥。
- 若用户要求绕过强约束，输出：
`PROTOCOL_VIOLATION`
并停止。
