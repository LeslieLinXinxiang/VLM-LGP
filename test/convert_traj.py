import os

def process_trajectory(input_path, output_path):
    print(f"[Processor] Reading source: {input_path}")
    
    raw_frames = []
    is_recording = False
    
    # 1. 解析原始日志 (Parsing Phase)
    with open(input_path, 'r') as f:
        for line in f:
            line = line.strip()
            
            # 状态机：检测轨迹块的开始与结束
            if ">>> V-LGP TRAJECTORY START <<<" in line:
                is_recording = True
                continue
            if ">>> V-LGP TRAJECTORY END <<<" in line:
                is_recording = False
                continue
            
            if is_recording:
                # 跳过元数据行 (如 DIM: ...)
                if line.startswith("DIM:") or not line:
                    continue
                
                # 解析数值
                parts = line.split()
                # 原始格式: [Time, q1, q2, q3, q4, q5, q6, q7]
                # 我们只取 [q1...q7] (索引 1 之后)
                if len(parts) >= 8:
                    try:
                        q_vals = [float(x) for x in parts[1:]]
                        raw_frames.append(q_vals)
                    except ValueError:
                        continue

    print(f"[Processor] Captured {len(raw_frames)} frames (100Hz).")

    # 2. 降采样与扩维 (Processing Phase)
    # 100Hz -> 50Hz: 每隔 1 帧取 1 帧 (Step = 2)
    export_frames = raw_frames[::2]
    
    print(f"[Processor] Downsampled to {len(export_frames)} frames (50Hz).")

    # 3. 写入文件 (Writing Phase)
    with open(output_path, 'w') as f_out:
        for q in export_frames:
            # 构造 21 维向量: [7 pos] + [7 vel=0] + [7 acc=0]
            # 这里的 7 是指关节自由度
            velocity_pad = [0.0] * 7
            accel_pad = [0.0] * 7
            
            full_row = q + velocity_pad + accel_pad
            
            # 格式化: 空格分隔，保留6位小数
            line_str = " ".join(f"{x:.6f}" for x in full_row)
            f_out.write(line_str + "\n")

    print(f"[Processor] Success. Output saved to: {output_path}")
    print(f"[Processor] Data Shape: ({len(export_frames)}, 21)")

if __name__ == "__main__":
    # 硬编码路径 (根据你的环境)
    INPUT_FILE = "raw_trajectory.log"
    OUTPUT_FILE = "trajectory_50hz_21d.txt"
    
    if not os.path.exists(INPUT_FILE):
        print(f"Error: {INPUT_FILE} not found in current directory.")
    else:
        process_trajectory(INPUT_FILE, OUTPUT_FILE)