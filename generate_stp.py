import cadquery as cq

# --- 物理参数 (单位：mm，来自 .g 文件) ---
# base3: size:[.25 .25 .02 .002]
base_full = (250.0, 250.0, 20.0)
base_radius = 2.0

# base3_handle: size:[.04 .04 .04 .002]
handle_full = (40.0, 40.0, 40.0)
handle_radius = 2.0

# 相对位置 Q: "t(0 0 .03)"
handle_offset_z = 30.0

# --- 建模逻辑 ---
# 1. 创建底座并添加倒角
base = (
    cq.Workplane("XY")
    .box(*base_full)
    .edges()
    .fillet(base_radius)
)

# 2. 创建手柄并添加倒角
handle = (
    cq.Workplane("XY")
    .workplane(offset=handle_offset_z)
    .box(*handle_full)
    .edges()
    .fillet(handle_radius)
)

# 3. 物理布尔合并
final_model = base.union(handle)

# --- 导出 ---
cq.exporters.export(final_model, "base3_final.step")
print(">>> SUCCESS: base3_final.step generated with RAI (.g) parameters.")