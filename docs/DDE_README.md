# 🚧 DDE-Bootstrap Framework

**DDE-Bootstrap (Documentation-Driven Engineering)** 是一套专为长程、高质量 AI 工程协作所设计的**“强约束、零幻觉”**状态机管理协议。  
它的核心哲学是：**“彻底剥夺大语言模型（LLM）对上下文的记忆权，把唯一的真理之源（Single Source of Truth）强制绑定在本地磁盘的文本系统中。”**

---

## 💡 为什么我们需要 DDE？

在传统的 AI 辅助编程（如 Cursor、Claude 等）中，开发者普遍会面临以下噩梦：
1. **上下文中毒（Context Poisoning）**：聊到第 50 个回合时，AI 已经忘记了你在第 1 个回合定下的红线（比如“不要修改某个核心类”）。
2. **逻辑漂移/幻觉（Hallucinations）**：AI 为了快速迎合你，开始瞎编 API 或者把原来能用的代码改坏。
3. **记忆清零困境**：当你为了防幻觉而开个新窗口时，你要花半小时重新和新 AI 解释“这是个什么项目、之前修复了什么”。

**DDE-Bootstrap 将 AI 的身份从“记忆拥有者”降权为“无状态的计算工具”，通过严酷的【实体文件隔离 + 交互审批死锁】，一劳永逸地解决了大模型的致命痛点。**

---

## 🧱 核心组件：五层强制读取模型 (Five Layer Model)

所有的项目状态不再依靠 AI 的嘴，而是完全沉淀在 `/docs` 目录下的 5 个 Markdown 文件中：

*   **Layer 0: `project_charter.md`（项目宪章）**：规定我们要做什么（Objective）和**绝不做什么（Non-Goals/红线）**。防止 AI 擅自帮你大重构。
*   **Layer 1: `architecture.md`（架构契约）**：规定模块依赖。禁止 AI 引入非法的依赖库。
*   **Layer 2: `dataflow.md` & `module_specs/*.md`（模块说明）**：比代码更早存在的纯文本说明。AI 必须顺着这个契约写代码。
*   **Layer 3: `execution_protocol.md`（执行法规）**：严禁随意写文件、回滚指南。
*   **Layer 4: `roadmap.md`（时间线追踪器）**：接管跨窗口生命周期。保存当前正在做的进度（Active tasks），以及**滚动存留（Rolling Archive）**的最新的 50 个已完成任务，确保新 AI 启动时能精确继承遗志。

---

## 🔒 杀手级特性

### 1. 免疫幻觉的“强制重启”（Bootstrapping）
> 在启动任何新对话时，只要你下令：*"请严格遵守 `docs/DDE_Bootstrap.md`"*, AI 会被协议挟持，不由自主地去读取你的全部 `docs` 目录。
> 10 秒后，一个拥有完美上下文、知道所有红线、清除了上一轮所有垃圾记忆的 AI 就准备就绪了。

### 2. 需求变更拦截阀 (RFC_MODE)
> 聊着聊着你突然想加新功能？协议会**强制打断（Hard Interrupt）** AI 的写代码权限，要求 AI 必须先出一份《需求分析提案》。
> 等旧的架构文档（Layer 0-2）更新后，必须关闭当前窗口，新开窗口重新加载新思想，从而杜绝边聊边改导致的业务逻辑脱轨。

### 3. 两阶段代码提交流转 (Two-Phase Execution)
> **绝不容忍悄悄改代码。**
> *   **Phase 1**：列出【修改原因】【原逻辑】【新效果】【第一性原理审查】。
> *   **Phase 2**：进入强制死锁。只要没收到人类敲出的 `[APPROVED]`，系统就会卡住，不允许操作任何 `*.cpp` 或 `*.py`。

### 4. 收尾强制盖章归档 (Task Completion)
> 做完任务想拍拍屁股走人？不行。
> 只要人类没有输入最高权限指令 `[TASK_COMPLETED]`，AI 就无法结案。收到指令后，AI 会自动把你刚才干的事归档进 `roadmap.md`、补齐 `YYYY-MM-DD HH:MM` 时间戳、更新变动的架构文档，最后再建议你关闭窗口（Close window to prevent poisoning）。

---

## 🚀 极速上手 (Quick Start)

1. 在项目根目录创建 `docs/DDE_Bootstrap.md` 并放入协议全文。
2. 开启任意 AI 客户端（Cursor / Chat 等）。
3. 丢下唯一一行起飞口令：
   > *"请遵守项目下的 `docs/DDE_Bootstrap.md` 协议，开始系统自举（Bootstrap Mechanics），并汇报当前任务进度。"*
4. 看着状态机为你打理一切吧。
