# 260330 实验日报 - Native LGP 达到性与可操作度耦合优化 (VLM-LGP)

## 🎯 1. 核心目标 (Objective)
完成 TASK-021：将原生 LGP Waypoint 达到性（Hard Gate）与雅可比可操作度（Soft Ranking）进行深度耦合，打通从场景解析到 TAMP 求解的全链路，并优化求解效率。

## 💡 2. 技术路线演进：为什么从 GMM+ESDF 切换回当前方案？
在之前的 TASK-019 中，我们探索了基于 **GMM（高斯混合模型）+ ESDF（欧几里得符号距离场）** 的连续达到性场。

**切换原因分析：**
1. **运动学一致性 (Kinematic Consistency)**：GMM+ESDF 方案主要基于几何统计和空间距离，虽能提供连续梯度，但无法完全捕捉机械臂复杂的关节限位与自撞细节。
2. **硬门控需求 (Hard Gate Requirement)**：在 LGP 实际求解前，我们需要一个绝对可靠的“二值化”过滤器。原生 LGP Waypoint Check 直接调用底层的 **FCL (Flexible Collision Library) + libccd**，能提供与最终 TAMP 求解器 100% 一致的碰撞事实。
3. **分层架构优化**：
   - **底层 (Native LGP)**：负责“能不能抓到”的物理真值（Hard Gate）。
   - **中层 (Manipulability)**：负责“哪种姿态更好、更灵活”的质量评估（Soft Ranking）。
   - **上层 (VLM/Graph)**：负责“先抓哪一个”的逻辑时序。
   这种分层架构比单一的势场模型在复杂装配任务中更具鲁棒性。

## 🛠️ 3. 今日任务汇总 (Actions Taken)
- **达到性门控集成**：在 `pipeline/run_phase0.py` 中启用 `legacy_checker` 模式，生成 `infeasible_objects.json` 黑名单。
- **可操作度耦合**：修改 `run_static_manipulability_test.py`，使其自动摄入黑名单并对剩余物体进行灵活性排序。
- **计算性能突破 (15x Speedup)**：
  - 识别出机器人内部（如指尖与掌心、腕部相邻连杆）存在大量冗余碰撞检查。
  - 在 `bin/main.cpp` 中引入 **碰撞对白名单 (Whitelist)**，硬编码忽略 6 对内部固定连接。
  - 实验结果：单步求解时间从 **40.5s 骤降至 2.7s**，效率提升约 15 倍。
- **数据管理升级**：
  - 建立了 `active_collision_history` 归档机制，自动按时间戳保存每次求解的碰撞报告，便于后续对照实验。
- **全链路打通**：
  - 验证了从 `unnamed.g` -> Phase 0 -> Phase 1 -> Phase 2 -> LGP Solver 的端到端闭环。

## 📊 4. 核心算法与逻辑总结 (Core Logic)
1. **Hard Gate (达到性检测)**：利用 `pick_waypoint_check` 进行单帧 IK 与碰撞查询。
2. **Soft Ranking (可操作性评分)**：计算目标点处的 Manipulability Index (Jacobian 奇异值乘积)，评分越高代表避障余量越大。
3. **Execution Strategy**：基于层级支撑关系图（Support Graph）的分批次（Batched）求解，确保物理稳定性和时序逻辑。

## 🚀 5. 后续计划 (Next Steps)
- **MuJoCo 动力学验证**：将 LGP 生成的平滑轨迹投入 MuJoCo 仿真，验证物理落定稳定性。
- **对照组实验**：利用新开发的归档机制，对比“全局碰撞”与“动态显式碰撞”在更复杂场景下的成功率与耗时。
