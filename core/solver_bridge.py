# core/solver_bridge.py
import os
import subprocess
import sys

class SolverBridge:
    def __init__(self, executable_path):
        self.executable_path = executable_path
        if not os.path.exists(self.executable_path):
            raise FileNotFoundError(f"Solver not found: {self.executable_path}")

    def run(self, exec_dir, input_g_file):
        # Construct the command
        command = [self.executable_path, os.path.abspath(exec_dir), os.path.abspath(input_g_file)]
        print(f"[SolverBridge] Calling: {' '.join(command)}")
        print("-" * 50) # Visual separator
        
        output_state_file = os.path.join(exec_dir, "output_state.g")
        
        try:
            # Popen with pipe for stdout, merging stderr into stdout
            # bufsize=1 means line-buffered
            process = subprocess.Popen(
                command, 
                cwd=os.path.dirname(self.executable_path),
                stdin=subprocess.PIPE, 
                stdout=subprocess.PIPE, 
                stderr=subprocess.STDOUT, 
                text=True,
                bufsize=1
            )
            
            # Close stdin immediately to prevent hanging if solver waits for input
            if process.stdin:
                process.stdin.close()

            # Real-time output loop
            # This iterates line by line as the C++ program outputs them
            for line in process.stdout:
                # We strip the newline from the line because print adds one
                print(f"[Solver] {line.strip()}", flush=True)

            # Wait for the process to finish and get return code
            process.wait()
            return_code = process.returncode
            
            print("-" * 50) # End separator

            if return_code == 0:
                print("[SolverBridge] -> SUCCESS.")
                if os.path.exists(output_state_file):
                    return True, output_state_file
                else:
                    print("[SolverBridge] Error: Process finished but 'output_state.g' was not found.")
                    return False, None
            else:
                print(f"[SolverBridge] -> FAILURE (Exit Code {return_code})")
                return False, None

        except Exception as e:
            print(f"[SolverBridge] Execution Exception: {e}")
            return False, None