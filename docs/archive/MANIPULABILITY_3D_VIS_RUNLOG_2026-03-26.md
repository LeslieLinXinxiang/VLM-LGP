# Manipulability 3D 可视化运行记录（2026-03-26）

## 1. 机器与环境评估

本次在 macOS（MacBook M2, 8GB 内存）执行。

运行时检测结果：

- Python: 3.13.5
- CPU 逻辑核心数: 8
- 内存: 8.0 GB
- numpy: 2.1.3
- matplotlib: 3.10.0

结论：

- 8GB 可运行当前“粗网格 + 多图导出”流程。
- 不建议一开始就用超高分辨率（例如 > 80x60x40），会显著拉长 IK 采样时间。

## 2. 已执行脚本

1. 网格生成：
   - [test/manipulability/build_manipulability_grid.py](test/manipulability/build_manipulability_grid.py)
2. 3D 渲染：
   - [test/manipulability/render_manipulability_3d.py](test/manipulability/render_manipulability_3d.py)
3. 切片热力图：
   - [test/manipulability/render_manipulability_slices.py](test/manipulability/render_manipulability_slices.py)

## 3. 网格统计结果

来自 [generated/manipulability_grid_meta.json](generated/manipulability_grid_meta.json)：

- 网格大小: 24 x 20 x 14（总点数 6720）
- IK 成功点: 5816
- 有效分数点: 5816
- 计算耗时: 41.857 秒

说明：

- 该速度对 M2 8GB 是可接受的，支持参数调优与多次重渲染。

## 4. 生成的可视化文件

已生成以下 7 张图：

- [generated/figures/manip_3d_pointcloud.png](generated/figures/manip_3d_pointcloud.png)
- [generated/figures/manip_3d_voxel.png](generated/figures/manip_3d_voxel.png)
- [generated/figures/manip_3d_pointcloud_t030.png](generated/figures/manip_3d_pointcloud_t030.png)
- [generated/figures/manip_3d_voxel_t030.png](generated/figures/manip_3d_voxel_t030.png)
- [generated/figures/manip_slice_xy.png](generated/figures/manip_slice_xy.png)
- [generated/figures/manip_slice_xz.png](generated/figures/manip_slice_xz.png)
- [generated/figures/manip_slice_yz.png](generated/figures/manip_slice_yz.png)

## 5. 论文图建议（基于本次输出）

推荐优先挑选：

1. `manip_3d_voxel_t030.png`（结构更干净）
2. `manip_slice_xy.png`（主切片）
3. `manip_slice_xz.png`（补充切片）

若版面允许，再加：

- `manip_3d_pointcloud.png`（展示连续分布细节）

## 6. 下一轮参数建议（8GB 友好）

1. 论文精细版：
   - 先试 36 x 30 x 22
2. 若耗时可接受再升：
   - 48 x 40 x 28
3. 每次升分辨率都保留固定视角与固定色条 [0,1]，便于跨图比较。
