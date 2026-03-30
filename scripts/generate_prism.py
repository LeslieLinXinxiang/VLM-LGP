import os

def create_triangular_prism(filepath, base_w=0.040, depth=0.035, height=0.020):
    # 底面向下放在桌子上, 尺寸 40mm (X) * 35mm (Y)
    # 顶部高度为 20mm (Z)
    
    hw = base_w / 2.0
    hd = depth / 2.0
    
    # 几何中心此时下移到底面 (底部z=0), 满足用户要求
    z_bottom = 0.0
    z_top = height

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
        f.write(f"# base_width={base_w}, depth={depth}, height={height}\n")
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
