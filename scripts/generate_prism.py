import os


def create_triangular_prism(filepath, base_w=0.040, depth=0.035, height=0.020, origin_offset_z=-0.002):
    # 原点相对几何中心上移 2mm, 尺寸 40mm (X) * 35mm (Y) * 20mm (Z)

    hw = base_w / 2.0
    hd = depth / 2.0
    
    # 基准几何仍以中心对称，但整体向下平移 2mm，以实现“原点上抬 2mm”
    z_bottom = -height / 2.0 + origin_offset_z
    z_top = height / 2.0 + origin_offset_z

    # 顶点: (x, y, z)
    # y正方向为前(Front)，y负方向为后(Back)
    vertices = [
        (-hw, hd, z_bottom),  # 1. 底部左前
        (hw, hd, z_bottom),   # 2. 底部右前
        (-hw, -hd, z_bottom), # 3. 底部左后
        (hw, -hd, z_bottom),  # 4. 底部右后
        (0.0, hd, z_top),     # 5. 顶部中央前
        (0.0, -hd, z_top)     # 6. 顶部中央后
    ]
    
    # 面 (顶点索引从 1 开始)
    # 按照逆时针顺序(Counter-Clockwise)定义，使法线向外，修复剔除错觉
    faces = [
        # 底面 (朝下 -Z)
        (1, 4, 3),
        (1, 2, 4),
        # 前三角面 (朝前 +Y)
        (1, 5, 2),
        # 后三角面 (朝后 -Y)
        (3, 4, 6),
        # 左斜面 (朝左前上 -X, +Z)
        (1, 3, 6),
        (1, 6, 5),
        # 右斜面 (朝右前上 +X, +Z)
        (4, 2, 5),
        (4, 5, 6)
    ]
    
    os.makedirs(os.path.dirname(filepath), exist_ok=True)
    with open(filepath, 'w') as f:
        f.write("# Triangular Prism (Ramp/Roof shape)\n")
        f.write(f"# base_width={base_w}, depth={depth}, height={height}, origin_offset_z={origin_offset_z}\n")
        for v in vertices:
            f.write(f"v {v[0]:.6f} {v[1]:.6f} {v[2]:.6f}\n")
        for face in faces:
            f.write(f"f {face[0]} {face[1]} {face[2]}\n")

if __name__ == "__main__":
    out_dir = "/home/leslie/Projects/VLM_LGP/generated"
    out_path = os.path.join(out_dir, "triangular_prism.obj")
    print(f"Generating obj at: {out_path}")
    create_triangular_prism(out_path)
    print("Done.")
