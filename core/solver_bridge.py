# core/solver_bridge.py
import os
import subprocess
import sys

class SolverBridge:
    def __init__(self, executable_path=None):
        if executable_path is None:
            # 动态获取当前文件的父目录的父目录，即项目根目录
            base_path = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
            self.executable_path = os.path.join(base_path, "bin/x.exe")
        else:
            self.executable_path = executable_path

    def run(self, exec_dir, input_g_file):
        # 构造命令
        command = [self.executable_path, os.path.abspath(exec_dir), os.path.abspath(input_g_file)]
        print(f"[SolverBridge] Calling: {' '.join(command)}")
        print("-" * 50) 
        
        output_state_file = os.path.join(exec_dir, "output_state.g")
        
        # [V-LGP ADDITION] 用于存储完整的终端输出，供后续解析轨迹
        full_stdout = ""
        
        try:
            process = subprocess.Popen(
                command, 
                cwd=os.path.dirname(self.executable_path),
                stdin=subprocess.PIPE, 
                stdout=subprocess.PIPE, 
                stderr=subprocess.STDOUT, 
                text=True,
                bufsize=1
            )
            
            if process.stdin:
                process.stdin.close()

            # 实时输出循环
            for line in process.stdout:
                # 1. 依然在终端实时打印，让你看到进度
                print(f"[Solver] {line.strip()}", flush=True)
                # 2. [V-LGP ADDITION] 将这一行存入变量
                full_stdout += line

            process.wait()
            return_code = process.returncode
            
            print("-" * 50) 

            if return_code == 0:
                print("[SolverBridge] -> SUCCESS.")
                if os.path.exists(output_state_file):
                    # [V-LGP CHANGE] 返回 3 个值
                    return True, output_state_file, full_stdout
                else:
                    print("[SolverBridge] Error: Process finished but 'output_state.g' was not found.")
                    return False, None, full_stdout
            else:
                print(f"[SolverBridge] -> FAILURE (Exit Code {return_code})")
                return False, None, full_stdout

        except Exception as e:
            print(f"[SolverBridge] Execution Exception: {e}")
            return False, None, ""