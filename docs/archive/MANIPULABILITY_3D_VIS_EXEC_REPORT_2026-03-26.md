# Manipulability 3D 可视化执行报告（2026-03-26）

## 1. 目标

本报告给出可直接实施的路线：

1. 生成 Franka 的 3D manipulability 体素场（与具体物体解耦）。
2. 生成点云着色版本（观察稀疏结构与边界）。
3. 产出可用于论文的高质量图（3D 总览 + 2D 热力图切片）。

当前算法基础文件：

- [test/manipulability/urdf_static_manipulability.py](test/manipulability/urdf_static_manipulability.py)
- [test/manipulability/run_static_manipulability_test.py](test/manipulability/run_static_manipulability_test.py)

## 2. 结论（论文图决策）

1. 论文主视觉建议用“热力图表达”的 3D 能力场。
2. 仅放一个 3D 截图不够，建议至少再配两张切片热力图。
3. 最推荐版式：
   - 3D 体素/点云着色总览
   - XY 切片热力图
   - XZ（或 YZ）切片热力图

## 3. 维度说明

本方法对工作空间点 $(x,y,z)$ 逐点评分，得到的是 3D 标量场 $m(x,y,z)$。

因此：

- 计算本质是 3D。
- 2D 图只是 3D 场的切片。

“球形”只在理想对称情况下近似成立。实际 Franka 受关节限位与构型影响，通常不是球。

## 4. 执行方案

### 阶段 A：生成 3D 网格数据

建议工作空间初值：

- x: [-0.55, 0.55]
- y: [-0.35, 0.55]
- z: [0.60, 1.05]

建议网格密度两档：

- 快速预览：26 x 22 x 18
- 论文导出：48 x 40 x 28

逐点评分流程：

1. 位置 IK（DLS）。
2. IK 成功则计算 Yoshikawa 分数。
3. IK 失败记 NaN。

建议输出文件：

- generated/manipulability_grid_raw.npz
- generated/manipulability_grid_norm.npz

建议字段：

- X, Y, Z
- score_raw
- score_norm
- ik_success_mask

### 阶段 B：3D 渲染

推荐同时导出两类 3D 图：

1. 点云着色图（成功点按 score_norm 着色）。
2. 体素图（阈值或分层体素）。

固定视角参数（保证论文复现）：

- azimuth: 35°
- elevation: 25°
- zoom/distance: 固定常量

建议输出：

- generated/figures/manip_3d_pointcloud.png
- generated/figures/manip_3d_voxel.png

### 阶段 C：2D 切片热力图

建议切片：

- XY at z = z_mid
- XZ at y = y_mid
- YZ at x = x_mid

建议输出：

- generated/figures/manip_slice_xy.png
- generated/figures/manip_slice_xz.png
- generated/figures/manip_slice_yz.png

## 5. 论文美学规范（让热力图“好看”）

1. 颜色图统一使用 viridis 或 magma，不用 rainbow。
2. 所有图颜色条统一 [0,1]，避免误导比较。
3. 切片图加等值线（0.2/0.4/0.6/0.8）。
4. 统一字体、单位（m）、线宽与白底风格。
5. 3D 图固定同一视角，切片图固定同一坐标范围。

## 6. 建议的论文版式

建议四宫格：

1. 3D 体素着色（总览）
2. 3D 点云着色（结构细节）
3. XY 热力图切片
4. XZ 热力图切片

图注建议强调：

- 颜色代表归一化 manipulability。
- 空白/灰区代表 IK 失败或不可达。
- 该场是机器人能力先验，与具体物体无关。

## 7. 风险与规避

1. 只放 3D 截图，遮挡严重。
   - 规避：补切片图。
2. 色图不统一，跨图不可比。
   - 规避：固定 colormap 与 colorbar 范围。
3. 采样过稀导致伪空洞。
   - 规避：先粗网格，再高分辨率复算。

## 8. 下一步实现清单

1. 新增网格生成脚本：test/manipulability/build_manipulability_grid.py
2. 新增 3D 渲染脚本：test/manipulability/render_manipulability_3d.py
3. 新增切片渲染脚本：test/manipulability/render_manipulability_slices.py
4. 输出目录固定：generated/figures/
5. 将视角、阈值、色图写入同一配置 JSON（保证可复现）

## 9. 对你问题的直接回答

1. 论文是否应该用热力图形式？
   - 是，建议 3D 着色总览 + 2D 热力图切片。

1. 渲染 3D 后截图一个视角可以吗？
   - 可以，但不建议只放一张。至少再配 1 到 2 张切片图。

1. 现在是 3D 还是平面？
   - 计算是 3D；平面图仅是 3D 场切片。
