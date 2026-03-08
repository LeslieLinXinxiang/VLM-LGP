import os
import math

# ==========================================
# PROF. MIT'S DEPLOYMENT CONVERTER V2.0
# ==========================================

def parse_raw_log(input_path):
    """
    读取 raw_trajectory.log，根据整数时间戳进行逻辑切片。
    返回: list of segments, 每个 segment 是一个 list of frames (rows)
    """
    print(f"[Prof. MIT] 1. Parsing Source: {input_path}")
    
    if not os.path.exists(input_path):
        print("❌ Error: Input file not found.")
        return []

    atomic_segments = []
    current_atomic_seg = []
    last_integer_time = 0
    is_recording = False
    
    line_count = 0
    
    with open(input_path, 'r') as f:
        for line in f:
            line = line.strip()
            
            # --- 块检测 ---
            if ">>> V-LGP TRAJECTORY START <<<" in line:
                is_recording = True
                current_atomic_seg = []
                last_integer_time = 0
                continue
            
            if ">>> V-LGP TRAJECTORY END <<<" in line:
                is_recording = False
                if current_atomic_seg:
                    atomic_segments.append(current_atomic_seg)
                continue
            
            if is_recording:
                if line.startswith("DIM:") or not line: continue
                parts = line.split()
                
                # 兼容性检查: 
                # 如果 C++ 只输出了 pos (8列: Time + 7 Pos)
                # 如果 C++ 输出了 full (22列: Time + 7P + 7V + 7A)
                if len(parts) >= 8:
                    time_val = float(parts[0])
                    
                    # 获取该行的所有数值数据 (排除第一列 Time)
                    # 这里的 values 可能长 7 (只含Pos) 也可能长 21 (含PVA)
                    raw_values = [float(x) for x in parts[1:]] 
                    
                    # --- 核心切分逻辑 (保留原味) ---
                    # 1000Hz 下，0.999 -> 1.000，判定阈值 0.99 依然有效
                    if time_val > last_integer_time + 0.99: 
                        if current_atomic_seg:
                            atomic_segments.append(current_atomic_seg)
                        current_atomic_seg = []
                        last_integer_time = round(time_val) 
                        
                    current_atomic_seg.append(raw_values)
                    line_count += 1

    print(f"   -> Read {line_count} frames total.")
    print(f"   -> Sliced into {len(atomic_segments)} ATOMIC phases.")
    return atomic_segments

def write_deployment_file(segments, output_path, use_real_dynamics):
    """
    将切片后的数据写入 Leeds 格式。
    use_real_dynamics: True (保留解析值), False (填0)
    """
    print(f"[Prof. MIT] 2. Generating Output: {output_path}")
    print(f"   -> Mode: {'REAL DYNAMICS' if use_real_dynamics else 'ZERO PADDING'}")

    total_atoms = len(segments)
    
    with open(output_path, 'w') as f_out:
        for p_idx, segment in enumerate(segments):
            
            # --- A. 1000Hz 保持 (不降采样) ---
            # 直接使用原始 segment
            
            if not segment: continue

            # --- B. 写入 21 维数据 ---
            for row in segment:
                # row 的长度可能是 7 (Old C++) 或 21 (New C++)
                
                pos = row[0:7] # 前7位一定是位置
                
                if use_real_dynamics:
                    # 如果源数据里有速度/加速度 (长度>=21)，则使用
                    if len(row) >= 21:
                        vel = row[7:14]
                        acc = row[14:21]
                    else:
                        # 如果源数据只有位置，Real 模式也没法造，只能填0并警告
                        vel = [0.0] * 7
                        acc = [0.0] * 7
                else:
                    # ZERO 模式：强制填 0
                    vel = [0.0] * 7
                    acc = [0.0] * 7
                
                # 拼接 21 维
                full_vector = pos + vel + acc
                
                # 格式化: 6位小数，空格分隔
                line_str = " ".join(f"{x:.6f}" for x in full_vector)
                f_out.write(line_str + "\n")

            # --- C. 夹爪与 Homing 逻辑 ---
            is_last_segment = (p_idx == total_atoms - 1)
            is_homing = is_last_segment and (total_atoms > 2)
            
            gripper_val = -1
            action_desc = ""

            if is_homing:
                gripper_val = 1 # Force Open
                action_desc = "HOMING (Open)"
            elif p_idx % 2 == 0:
                gripper_val = 0 # Pick -> Close
                action_desc = "PICK (Close)"
            else:
                gripper_val = 1 # Place -> Open
                action_desc = "PLACE (Open)"
            
            # 换行写入 Bool 整数
            f_out.write(f"{gripper_val}\n")
            
            # 打印调试信息
            # 计算时长: 1000Hz 下，帧数/1000 = 秒数
            duration = len(segment) / 1000.0 
            print(f"   Phase {p_idx}: {len(segment)} frames (~{duration:.2f}s) -> {action_desc}")

    print(f"✅ Saved: {output_path}\n")

if __name__ == "__main__":
    # [Prof. MIT FIX] 使用正确的相对路径或绝对路径
    # 既然你在根目录运行，文件在 test 文件夹里，就必须加上 "test/"
    INPUT_FILE = "raw_trajectory.log" 
    
    # 输出文件也建议放在 test 目录下，保持整洁
    OUTPUT_ZEROS = "deploy_1khz_ZEROS.txt"
    OUTPUT_REAL = "deploy_1khz_REAL.txt"
    
    # 1. 解析
    segments = parse_raw_log(INPUT_FILE)
    
    if segments:
        # 2. 输出版本 A: 补 0
        write_deployment_file(segments, OUTPUT_ZEROS, use_real_dynamics=False)
        
        # 3. 输出版本 B: 真实值
        write_deployment_file(segments, OUTPUT_REAL, use_real_dynamics=True)
    else:
        print("❌ Transformation failed due to empty or missing log.")