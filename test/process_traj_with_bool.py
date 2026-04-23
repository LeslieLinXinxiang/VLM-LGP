import os
import math

def process_split_trajectory(input_path, output_path):
    print(f"[Prof. MIT] Analyzing Source for SPLIT: {input_path}")
    
    if not os.path.exists(input_path):
        print("❌ Error: Input file not found.")
        return

    # 全局原子段列表
    atomic_segments = []
    
    # 临时缓冲区
    current_atomic_seg = []
    last_integer_time = 0
    
    is_recording = False
    
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
                # 保存最后一段
                if current_atomic_seg:
                    atomic_segments.append(current_atomic_seg)
                continue
            
            if is_recording:
                if line.startswith("DIM:") or not line: continue
                parts = line.split()
                if len(parts) >= 8:
                    time_val = float(parts[0])
                    q_vals = parts[1:8] # 7 joints
                    
                    # --- 核心切分逻辑 ---
                    # 如果时间跨过了整数 (例如从 0.99 变成 1.01)，说明一个 Phase 结束了
                    # 我们容忍一点误差，比如 > last + 0.99
                    if time_val > last_integer_time + 0.99: # 简单的整数检测
                        # 保存上一段
                        if current_atomic_seg:
                            atomic_segments.append(current_atomic_seg)
                        # 开启新一段
                        current_atomic_seg = []
                        last_integer_time = round(time_val) # 更新基准线 (1.0, 2.0...)
                        
                    current_atomic_seg.append(q_vals)

    total_atoms = len(atomic_segments)
    print(f"[Prof. MIT] Sliced into {total_atoms} ATOMIC phases (Pick or Place actions).")

    # --- 写入文件 ---
    with open(output_path, 'w') as f_out:
        
        for p_idx, segment in enumerate(atomic_segments):
            
            # A. 降采样 (100Hz -> 50Hz)
            downsampled_seg = segment[::2]
            
            # 如果降采样后为空（极短片段），跳过
            if not downsampled_seg: continue

            # B. 写入数据
            zeros_padding = " 0.000000" * 14
            for row in downsampled_seg:
                f_out.write(" ".join(row) + zeros_padding + "\n")
            
            # C. 逻辑判断 (现在是对原子段进行判断，完全符合 test_bridge 逻辑)
            is_last_segment = (p_idx == total_atoms - 1)
            
            # 只有最后一段是 Homing，前提是段数足够多
            is_homing = is_last_segment and (total_atoms > 2)
            
            gripper_val = -1
            action_name = "?"

            if is_homing:
                gripper_val = 1
                action_name = "FORCE OPEN (Homing)"
            elif p_idx % 2 == 0:
                # 0, 2, 4... 是 Pick 过程 -> 结尾闭合
                gripper_val = 0
                action_name = "CLOSE (Pick)"
            else:
                # 1, 3, 5... 是 Place 过程 -> 结尾张开
                gripper_val = 1
                action_name = "OPEN (Place)"
            
            # D. 写入布尔值
            f_out.write(f"{gripper_val}\n")
            
            print(f"   -> Atomic Seg {p_idx}: {len(downsampled_seg)} frames. End Action: {action_name}")

    print(f"[Prof. MIT] Export Complete: {output_path}")

if __name__ == "__main__":
    INPUT_FILE = os.path.join(SCRIPT_DIR, "raw_trajectory.log")
    OUTPUT = "trajectory_50hz_21d_bool.txt"
    process_split_trajectory(INPUT, OUTPUT)