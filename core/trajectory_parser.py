import re
import math

class TrajectoryParser:
    @staticmethod
    def parse_all(stdout, time_scale=1.0):
        """
        解析所有轨迹块，并支持时间缩放（慢放）。
        
        Args:
            stdout (str): C++ 程序的完整输出
            time_scale (float): 时间倍率。1.0=原速, 3.0=慢放3倍
            
        Returns:
            List[List[dict]]: 返回一个任务列表，每个任务包含多个时间段(Segments)。
            结构: [ Task1_Segments, Task2_Segments, ... ]
        """
        # 使用 finditer 查找所有出现的轨迹块
        pattern = r">>> V-LGP TRAJECTORY START <<<\nDIM: (\d+) (\d+)\n([\s\S]*?)\n>>> V-LGP TRAJECTORY END <<<"
        matches = re.finditer(pattern, stdout)
        
        all_tasks = []

        for match_idx, match in enumerate(matches):
            raw_lines = match.group(3).strip().split('\n')
            
            # 字典用于暂存当前任务的分段: { 0: [...], 1: [...] }
            phased_data = {} 

            for line in raw_lines:
                vals = [float(x) for x in line.split()]
                if len(vals) < 8: continue
                
                t_raw = vals[0]
                
                # --- 逻辑核心：分段与变速 ---
                
                # 1. 确定阶段 (Phase)
                # t=0.xx -> Phase 0, t=1.xx -> Phase 1
                phase_idx = int(math.floor(t_raw - 0.0001)) 
                if phase_idx < 0: phase_idx = 0
                
                if phase_idx not in phased_data:
                    phased_data[phase_idx] = []
                
                # 2. 时间归一化 (让每段都从 0 开始)
                t_normalized = t_raw - float(phase_idx)
                if t_normalized < 0: t_normalized = 0.0
                
                # 3. [关键修改] 应用时间缩放 (慢放)
                t_scaled = t_normalized * time_scale
                
                # 提取关节角
                q_values = vals[1:8]
                
                phased_data[phase_idx].append({'time': t_scaled, 'q': q_values})

            # 将当前任务的字典转换为有序列表
            sorted_segments = []
            max_phase = max(phased_data.keys()) if phased_data else -1
            for i in range(max_phase + 1):
                if i in phased_data:
                    sorted_segments.append(phased_data[i])
                else:
                    sorted_segments.append([]) # 空占位
            
            if sorted_segments:
                all_tasks.append(sorted_segments)

        return all_tasks