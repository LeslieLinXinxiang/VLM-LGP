# VLM-LGP 初稿详细修改报告（2026-03-23）

## 1. 本轮修改目标

本轮修改不是做局部润色，而是重构整篇稿件的叙事主线，重点解决三个问题：

1. 原稿大量保留了 IEEE 模板残留，导致论文并未形成完整的学术叙事。
2. 原稿中的 clustering 部分依赖自定义的 `BATC` 术语，但算法故事并不清楚，难以向 reviewer 解释“为什么这样分”。
3. 原稿把 branch 识别、batch 生成、求解规模控制混写在一起，导致方法虽然勉强可运行，但论文层面很难讲明白。

本轮修订后的主线改为：

`support graph construction -> multilevel graph partitioning for branch aggregation -> hierarchy-aware batch cutting -> selective native LGP instantiation`

也就是说，先做“结构分支聚合”，再做“执行批次切割”，不再用一个手工规则同时承担两种职责。

---

## 2. 全文层面的核心修改

### 2.1 摘要（Abstract）

### 原稿问题

- 原稿直接写 `Branch-Aware Topological Clustering`，但没有给出足够清楚的算法解释。
- 原稿写了 `Layered Precedence Graph` 和 `shape-aware manipulation primitives`，但正文里没有形成对应展开。
- 原稿最后一句写成 `Experiments demonstrate ...`，但当下草稿并没有完整实验结果支撑这个强 claim。

### 修改动作

- 删除 `BATC` 作为核心算法名词。
- 删除 `Layered Precedence Graph` 与 `shape-aware manipulation primitives` 这两个尚未真正展开的主张。
- 改为描述成熟算法路径：`multilevel graph partitioning + hierarchy-aware batch cutting`。
- 将实验强 claim 降为“representative case shows ...”。

### 为什么这样改

摘要必须做到“每个名词在正文都能接住，每个 claim 都有后文支撑”。原稿最大的问题不是英文不够顺，而是摘要的关键词和正文脱节。现在改成新的两阶段算法之后，摘要、Method、案例分析就能形成闭环。

---

### 2.2 引言（Introduction）

### 原稿问题

- 还保留了 `This demo file ...` 的模板句，属于明显的模板残留。
- 原稿对“为什么需要结构分解”解释不够充分。
- 原稿虽然讲了 native LGP 的优势，但没有明确提出：问题不是 LGP 不好，而是没有一个足够清晰的结构接口。

### 修改动作

- 彻底删除模板句。
- 用 4 个段落重写引言：
  - 任务本质：长时域装配需要结构推理和几何推理协同。
  - 现有问题：纯符号规划需要人工规则，纯语义规划缺乏物理约束。
  - native LGP 的优点与瓶颈：LGP 很强，但不能直接吃完整长时域大图。
  - 我们的解决思路：support graph + graph partitioning + layer-aware cutting。
- 加入简短贡献列表，把论文当前版本真正做的事情说清楚。

### 为什么这样改

引言的工作不是“展示所有术语”，而是把 reviewer 带到一个明确的问题框架里。新引言的目标是把问题重新定义为：

“如何在语义解析与 native LGP 之间插入一个既结构化、又可解释、又 solver-friendly 的分解模块？”

这样后面的 Method 才有必要性。

---

### 2.3 Related Work

### 原稿问题

- 原稿只有一个空标题，没有内容。
- 这会让整篇论文的学术定位缺失。

### 修改动作

- 加入 3 段 related work：
  - symbolic planning / TAMP
  - LGP 及其扩展
  - graph partitioning 作为算法骨架

### 为什么这样改

你现在的新故事不是“我们发明了一个新 clustering 名词”，而是“我们把成熟 graph partitioning 引入 support-graph decomposition”。因此 related work 里必须提前铺垫：

- LGP 为什么重要
- VLM 接口为什么不够
- 为什么 partitioning 是合理的算法选择

---

### 2.4 Preliminaries and Problem Statement

### 原稿问题

- 原稿里这一节有不少内容，但更像背景综述，不像一个正式的问题定义。
- 缺少一个明确的任务目标：最终到底要从 graph 得到什么。

### 修改动作

- 保留对 LGP 瓶颈的解释，但压缩成真正的 problem statement。
- 明确写出：
  - 输入：object-support graph
  - 输出：ordered solver-facing batches
  - 约束：precedence、安全、当前 solver 规模

### 为什么这样改

如果前面不先形式化“输入是什么、输出是什么、约束是什么”，后面的 partitioning 就会显得像一段凭感觉插进来的工程技巧。新版本把这一步变成了正式问题定义。

---

## 3. Method 章节的逐段重构思路

## 3.1 Method Overview

### 原稿问题

- 原稿 overview 只有一个统括段，信息密度太高。
- 旧写法把“graph extraction”和“batch generation”混成一个黑箱。

### 修改动作

- 把 Method 总览改写成五步主线：
  - scene grounding
  - support graph construction
  - multilevel graph partitioning for branch aggregation
  - hierarchy-aware batch cutting
  - selective native LGP instantiation

### 为什么这样改

现在整篇文章最重要的就是把“branch aggregation”和“batch cutting”拆开讲。只要这一步讲清楚，算法故事就会比旧 BATC 清楚很多。

---

## 3.2 Scene Grounding and Feasibility Screening

### 原稿问题

- 这一段本身逻辑不错，但和后面的 graph decomposition 没有形成足够清楚的接口关系。

### 修改动作

- 保留 `scene-order dictionary`
- 保留 `KOMO_wp` reachability screening
- 明确说明：这一步不是在决定 assembly order，而是在提供 grounded inventory 和 solver-consistent feasibility prior

### 为什么这样改

这样可以避免 reviewer 误解“场景预筛选”和“结构分解”是一回事。

---

## 3.3 Support Graph Construction

### 原稿问题

- 原稿 `Object-Support Graph Planning` 这一节中，support graph 的定义是清楚的，但后面直接跳到了旧 BATC 逻辑，中间缺了“这个图的职责是什么”。

### 修改动作

- 把 support graph construction 单独拎出来成一个小节。
- 强调：
  - graph 表示的是“最终结构应该满足什么支持关系”
  - graph 本身不直接等于执行序列

### 为什么这样改

这一步能明显提升术语稳定性。今后 reviewer 会看到：

`support graph` 是结构表示  
`partitioning` 是结构分支聚合  
`batch cutting` 是执行切割

三者职责不会再混。

---

## 3.4 Multilevel Graph Partitioning for Branch Aggregation

### 原稿问题

- 原稿这里直接写 `branch-aware decomposition`，但 branch 是怎么来的，其实是人工规则传播。
- 这种写法最大的问题不是“代码不行”，而是“论文讲不通”。因为 reviewer 会问：
  - 为什么 branch 要这么传播？
  - 为什么 bridge 节点要这么处理？
  - 为什么这是 principled，而不是手工 heuristic？

### 修改动作

- 把旧的 `BATC` 删除为正式算法名词。
- 改为：从 support graph 构造加权辅助图，用成熟的 `multilevel graph partitioning` 做 branch aggregation。
- 加入一个明确的 partition objective：
  - 尽量保留高结构亲和性的边在分区内部
  - 避免无意义切碎结构
  - 控制分区规模

### 为什么这样改

这一步是本轮修改的核心。旧 BATC 最大的问题是“branch 识别”和“execution batching”纠缠在一起。新方案先解决“哪些节点属于同一结构分支”，然后再去谈执行批次。这样才能从算法层面说清楚。

---

## 3.5 Hierarchy-Aware Batch Cutting

### 原稿问题

- 原稿没有明确区分“结构分支”和“执行批次”。
- 旧方法直接从 layer/branch 规则吐出 batches，解释力不足。

### 修改动作

- 新增独立小节 `Hierarchy-Aware Batch Cutting`。
- 明确说明：
  - partitioning 输出的是 branch-level aggregated subgraphs
  - cutting 才输出 solver-facing batches
- 在当前例子上固定写出：
  - `134 | 256 | 789`
  - `134 -> 1 | 34`
  - `256 -> 2 | 56`
  - `789 -> 7 | 8 | 9`
  - 最终全局顺序：`1 | 34 | 2 | 56 | 7 | 8 | 9`

### 为什么这样改

这是让方法“可解释”的关键。现在 reviewer 不再只看到一个黑箱排序结果，而是能看到：

1. 先聚合结构分支  
2. 再沿层级切割执行批次  
3. 最后再做 precedence-consistent global order

这条链条比旧 BATC 好讲得多。

---

## 3.6 Selective Native LGP Instantiation and Solving

### 原稿问题

- 原稿这部分整体质量不错，但前面 decomposition 讲不清楚，导致这部分也显得接口模糊。

### 修改动作

- 保留 selective instantiation 的主逻辑。
- 明确一句：
  - decomposition module 决定“下一批应该实现哪些 support relations”
  - native LGP 决定“这些 relations 在当前几何场景下能否被执行，以及如何执行”

### 为什么这样改

这样就把 graph-level reasoning 和 solver-level reasoning 的职责界限划清楚了。

---

## 4. 当前例子下，新旧算法的差别

### 4.1 旧 BATC 的输出

基于当前仓库中的代表性 support graph，旧规则法输出的是：

`1 | 2 | 34 | 56 | 7 | 8 | 9`

问题不是这个顺序“错”，而是它的解释方式很弱。因为它来自一套混合规则：

- 手工 branch 传播
- layer 计算
- 批次上限约束

这三件事没有在论文里被清楚拆开。

### 4.2 新算法的中间结果

新算法先做 branch aggregation：

`134 | 256 | 789`

这个结果的意义是：

- `134` 是左侧结构分支
- `256` 是右侧结构分支
- `789` 是顶部桥接链

也就是说，算法先恢复结构上的“块”，再决定执行切法。

### 4.3 新算法的最终执行切割

然后做 hierarchy-aware cutting：

- `134 -> 1 | 34`
- `256 -> 2 | 56`
- `789 -> 7 | 8 | 9`

最终全局顺序：

`1 | 34 | 2 | 56 | 7 | 8 | 9`

### 4.4 为什么新算法比 BATC 更好讲

这里的优势不应该写成空泛的“更先进”“更聪明”，而应该写成 4 个具体点：

1. `branch discovery is principled`
   - 分支来自成熟 partitioning，不再来自手工标签传播

2. `batch cutting is interpretable`
   - 每个 branch 先聚合、再按层级切割，顺序更容易解释

3. `algorithm story is cleaner`
   - branch aggregation 和 execution cutting 被明确拆成两步

4. `future extensibility is better`
   - 后续即使 support graph 结构变复杂，branch discovery 仍有统一算法框架

---

## 5. 本轮实际写入稿件的内容

本轮已经把以下内容写入主稿：

- 删除 demo 作者和模板关键词
- 重写 Abstract
- 重写 Introduction
- 补写 Related Work
- 重写 Preliminaries and Problem Statement
- 把 Method 改成：
  - Scene Grounding and Feasibility Screening
  - Support Graph Construction
  - Multilevel Graph Partitioning for Branch Aggregation
  - Hierarchy-Aware Batch Cutting
  - Selective Native LGP Instantiation and Solving
  - Robot Execution
- 在 Experimental Results 里补入代表性案例分析和旧/新分解对照表
- 重写 Conclusion
- 新增 multilevel graph partitioning 参考文献

---

## 6. 仍然需要后续补齐的内容

### 6.1 外部图件仍未同步

当前 `Flowchart.png` 仍然可能保留旧术语。虽然主稿正文已经更新，但图像资产本身若仍显示 `BATC` 或旧 branch-aware 文案，就还需要在后续手动更新。

### 6.2 实验部分仍是“解释型草稿”

当前实验节已经不再是纯占位，但仍以代表性案例和评价口径为主，还没有写入最终 quantitative evidence。因此：

- 摘要中已避免写强实验结论
- 正文中也避免直接声称已得到显著数值提升

### 6.3 算法尚未代码实现

本轮只改论文叙事，不改执行代码。因此仓库里的旧 `graph_clustering.py` 仍然代表老逻辑，当前 paper story 与实际 Python batching 逻辑还没有完全同步。后续如果你要让论文和代码完全一致，需要再开一轮算法实现。

---

## 7. 建议的下一步

如果下一轮继续推进，我建议按这个顺序：

1. 更新 `Flowchart.png` 或替换为新的方法图
2. 把 Python 里的旧 BATC 逻辑替换成新的两阶段实现
3. 补 quantitative evaluation
4. 再做最后一轮 reviewer-facing polish

现在这版的价值在于：论文已经从“一个讲不清楚的自造名词 + 模板残留初稿”，变成了一篇至少在方法逻辑上能够自洽、能够向 reviewer 解释清楚的 draft。
