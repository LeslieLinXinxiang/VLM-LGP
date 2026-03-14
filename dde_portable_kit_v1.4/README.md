# DDE Portable Kit v1.4

这个目录是可迁移的 DDE 流程包，目标是给“全新 agent”直接投喂后自动完成流程部署。

## 内容
- `PROMPT_DDE_PORTABLE_AUTODEPLOY_v1.4.md`
  - 主控 Prompt（纯指令型入口）
- `skills/`
  - 全量相关技能源目录（含 `SKILL.md` + 模板/脚本/配置）

## 使用方式
1. 将整个 `dde_portable_kit_v1.4/` 发给目标 agent。
2. 让对方先读取主控 Prompt：
   - `PROMPT_DDE_PORTABLE_AUTODEPLOY_v1.4.md`
3. 对方 agent 按 Prompt 自动部署 `skills/` 到其本机技能根目录。

## 设计原则
- 与具体项目解耦。
- 固定版本：`v1.4`。
- 强约束不降级：`RFC_MODE`、`[APPROVED]`、`[TASK_COMPLETED]`。
- 路径不硬编码，由 agent 自动探测并在必要时询问用户。
