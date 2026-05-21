# 6_cubes_nr 数据集生成完整流程

## 📋 任务总结

基于扰动的物体位置重新运行Solver，并根据轨迹结构正确生成夹爪开合时刻。

## 🔄 执行流程

### 1️⃣ 物体位置扰动
- **输入**：原始scene_named.g + perturbations
  - 位置变化：±1.5cm（厘米级）
  - 姿态旋转：±15°（Z轴）
- **输出**：experiments/real_exp./6_cubes_nr/scene_named.g

### 2️⃣ Solver重新运行
```bash
./bin/x.exe generated/6cubes_run_s01/node_1_run/ \
  experiments/real_exp./6_cubes_nr/scene_named.g
```
- **输出**：solver_run_6cubes_nr.log (13,304行)
- **包含**：7个任务（tasks），每个任务2个segment（除最后一个为1个）

### 3️⃣ 轨迹和夹爪生成
根据 **core/deployment_export.py** 逻辑：

```
轨迹块（TRAJECTORY START/END）
  ↓
按时间戳整数部分分segment
  ↓
每个非空segment = 一个动作（pick/place/...)
  ↓
记录每个segment的最后一行号 → toggle_lines
  ↓
gripper.txt 写入toggle_lines（1-based）
```

## 📊 数据集结构

| 文件 | 行数/条目 | 描述 |
|------|---------|------|
| **traj.txt** | 13,000 | 轨迹数据（21列：7关节+14传感值） |
| **gripper.txt** | 13 | 夹爪toggle点（轨迹行号） |
| **scene_named.g** | ~90 | 扰动后的场景定义 |

## 🤖 夹爪开合协议

### 语义定义
```
状态机：
  默认 → OPEN (0.04)
    ↓
  [Toggle 1 @ line 1001]  → CLOSE (0.0)
    ↓
  [Toggle 2 @ line 2000]  → OPEN (0.04)
    ↓
  [Toggle 3 @ line 3001]  → CLOSE (0.0)
    ↓ ... 交替继续
```

### Toggle 点对应的动作
```
Task 0 → Segment 0 [lines 1-1001]    → Pick object 1
Task 0 → Segment 1 [lines 1002-2000] → Place object 1
Task 1 → Segment 0 [lines 2001-3001] → Pick object 2
Task 1 → Segment 1 [lines 3002-4000] → Place object 2
...
Task 6 → Segment 0 [lines 12001-13000] → Final segment

共7个任务，13个toggle点
```

每个toggle点表示该动作**完成时刻**，此时执行夹爪状态切换。

## 🔍 关键代码位置

### 轨迹解析 (core/trajectory_parser.py)
```python
# 按时间戳整数部分分segment
phase_idx = int(math.floor(t_raw - 0.0001))
```
- t = 0.0~0.999 → phase 0
- t = 1.0~1.999 → phase 1
- t = 2.0~2.999 → phase 2

### 夹爪生成逻辑 (core/deployment_export.py)
```python
# 每个非空segment完成时记录当前行号
for segment in task_segments:
    for row in segment:
        total_lines += 1
    toggle_lines.append(total_lines)  # ← 记录segment末尾
```

### 本地重建脚本
```python
python3 experiments/real_exp./6_cubes_nr/generate_traj_gripper_from_solver.py \
  --log solver_run_6cubes_nr.log
```

## 📈 对比：旧 vs 新

| 方面 | 旧方法 | 新方法 |
|------|------|------|
| **Gripper时间点** | 固定间隔（~1000ms） | 按轨迹segment结束帧 |
| **语义对应** | 启发式猜测 | 直接对应动作边界 |
| **数据来源** | 手工设定 | Solver输出解析 |
| **准确性** | 假设性 | ✅ 真实对应 |

**新方法优势**：
- 首次toggle（line 1001）= 第一个pick的完成时刻
- 第二个toggle (line 2000) = 第一个place的完成时刻
- 完全追踪轨迹的逻辑结构

## 📂 输出文件详情

### experiments/real_exp./6_cubes_nr/
```
├── traj.txt （2.5M）
│   └─ 13000行，每行21列（浮点数）
│      首行: -0.008619 -1.483971 0.000846 -2.477782 ...
│      末行: 0.000001 -1.499935 -0.000001 -2.499989 ...
│
├── gripper.txt （69B）
│   └─ 13行，每行1个toggle点（1-based轨迹行号）
│      1001, 2000, 3001, 4000, 5001, 6000, 7001, 8000, 
│      9001, 10000, 11001, 12000, 13000
│
├── scene_named.g （7.5K）
│   └─ 扰动后的object positions
│      rectprism_1: t(0.296 -0.086 0.066) d(3.0 0 0 1)
│      rectprism_2: t(0.290 -0.010 0.063) d(11.0 0 0 1)
│      ... (所有object都有位置和姿态改变)
│
└── solver_run_6cubes_nr.log （采用的源日志）
    └─ 完整的Solver输出，包含TRAJECTORY块
```

## 🔧 复现步骤

1. **修改scene_named.g**（已完成）
   ```bash
   # 随机扰动object位置和姿态
   python3 scripts/generate_6cubes_nr_dataset.py
   ```

2. **重新运行Solver**（已完成）
   ```bash
   ./bin/x.exe generated/6cubes_run_s01/node_1_run/ \
     experiments/real_exp./6_cubes_nr/scene_named.g \
     > solver_run_6cubes_nr.log
   ```

3. **生成轨迹和夹爪**（已完成）
   ```bash
  # 按deployment_export逻辑解析segment，并输出到本目录
  python3 experiments/real_exp./6_cubes_nr/generate_traj_gripper_from_solver.py \
    --log solver_run_6cubes_nr.log
   ```

## ✅ 验证清单

- ✅ 物体位置扰动（±1.5cm）
- ✅ 姿态随机旋转（±15°）
- ✅ Solver新轨迹生成（13,000行）
- ✅ Segment结构解析（7 tasks，13 toggles）
- ✅ Gripper文件对应segment末尾
- ✅ 完整数据集保存到 experiments/real_exp./6_cubes_nr/

## 🎯 下一步

该数据集可用于：
1. **Docker仿真验证**：执行轨迹和夹爪命令序列
2. **性能对标**：与旧数据集比较轨迹质量
3. **数据增强**：生成多个扰动版本形成数据集

## 📚 参考文献

- `core/deployment_export.py` - 轨迹导出逻辑
- `core/trajectory_parser.py` - 轨迹解析（segment分界）
- `core/zmq_bridge.py` - ZMQ通信接口
- `driver_gemini_mainline.py` - 完整执行流程
