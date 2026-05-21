#!/usr/bin/env python3
import os
import sys
import argparse
from pathlib import Path

# Add project root to sys.path
ROOT_DIR = Path(__file__).resolve().parents[2]
sys.path.append(str(ROOT_DIR))

from core.solver_bridge import SolverBridge

def main():
    parser = argparse.ArgumentParser(description="Quick LGP Solver Runner for Sandbox Testing")
    parser.add_argument("--dir", default="current_test", help="Directory containing .fol and .lgp files")
    parser.add_argument("--scene", default="current_test/scene_named.g", help="Path to the initial .g scene file")
    args = parser.parse_args()

    # Resolve paths
    workspace_dir = Path(__file__).resolve().parent
    exec_dir = workspace_dir / args.dir
    scene_path = (workspace_dir / args.scene).resolve()

    print("="*60)
    print("      V-LGP Quick Solver (Sandbox Mode)")
    print("="*60)
    print(f"[Config] Workspace: {workspace_dir}")
    print(f"[Config] Task Dir:  {exec_dir}")
    print(f"[Config] Scene:     {scene_path}")
    print("-" * 60)

    if not exec_dir.exists():
        print(f"❌ Error: Task directory '{exec_dir}' not found.")
        return

    if not scene_path.exists():
        print(f"❌ Error: Scene file '{scene_path}' not found.")
        return

    # Count LGP files
    lgp_files = list(exec_dir.glob("*.lgp"))
    if not lgp_files:
        print(f"⚠️ Warning: No .lgp files found in {exec_dir}. Solver might have nothing to do.")
    else:
        print(f"📂 Found {len(lgp_files)} LGP subtask(s).")

    # Initialize Solver
    solver = SolverBridge()
    
    print("\n🚀 Starting Solver...")
    success, output_g, stdout = solver.run(str(exec_dir), str(scene_path))

    if success:
        print("\n✅ SOLVE SUCCESS!")
        print(f"🔗 Result State: {output_g}")
    else:
        print("\n❌ SOLVE FAILED.")
    
    # Save a local log for this quick run
    log_file = workspace_dir / "quick_run_last_stdout.log"
    with open(log_file, "w") as f:
        f.write(stdout or "No output.")
    print(f"📝 Full output saved to: {log_file}")
    print("="*60)

if __name__ == "__main__":
    main()
