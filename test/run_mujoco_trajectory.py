#!/usr/bin/env python3
import os
import sys
import time
import tkinter as tk
from tkinter import filedialog

# Add project root to sys.path
ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
sys.path.append(ROOT_DIR)

from core.ros2_bridge import ExecutionManager

def select_trajectory_file():
    root = tk.Tk()
    root.withdraw()
    print("\n>>> [UI] Please select a V-LGP Trajectory Log file (*.log)...")
    file_path = filedialog.askopenfilename(
        initialdir=os.path.join(ROOT_DIR, "generated"),
        title="Select Trajectory Log",
        filetypes=[("Log Files", "*.log"), ("Text Files", "*.txt"), ("All Files", "*.*")]
    )
    root.destroy()
    return file_path

def main():
    print("="*60)
    print("  V-LGP MuJoCo Universal Trajectory Executor")
    print("="*60)

    # 1. Initialize ROS 2 environment for Host-Docker communication
    # Ensure consistency with global SOP
    os.environ["ROS_DOMAIN_ID"] = "0"
    os.environ["RMW_IMPLEMENTATION"] = "rmw_cyclonedds_cpp"
    
    print(f"[Init] ROS_DOMAIN_ID: {os.environ['ROS_DOMAIN_ID']}")
    print(f"[Init] RMW_IMPLEMENTATION: {os.environ['RMW_IMPLEMENTATION']}")

    # 2. Select File
    log_path = select_trajectory_file()
    if not log_path or not os.path.exists(log_path):
        print("❌ Error: No file selected or file does not exist. Exiting.")
        return

    print(f"📖 Loading: {os.path.basename(log_path)}")
    with open(log_path, 'r') as f:
        content = f.read()

    # 3. Initialize Execution Manager
    try:
        manager = ExecutionManager()
    except Exception as e:
        print(f"❌ Error initializing ExecutionManager: {e}")
        print("💡 Tip: Make sure the 'vlm_sim' Docker is running and CycloneDDS is active.")
        return

    # 4. Prompt for Homing
    ans = input("\n📝 Home robot before execution? [y/N]: ").lower()
    if ans == 'y':
        manager.home_robot()

    # 5. Execute
    print(f"\n🚀 Starting execution of {os.path.basename(log_path)}...")
    success = manager.execute_trajectory_string(content, node_id=os.path.basename(log_path))

    if success:
        print("\n✅ Execution Complete!")
    else:
        print("\n⚠️ Execution finished with warnings/errors.")

    print("="*60)

if __name__ == "__main__":
    main()
