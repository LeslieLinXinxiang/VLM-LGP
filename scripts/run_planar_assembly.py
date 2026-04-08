#!/usr/bin/env python3
"""
run_planar_assembly.py
Calls the solver ONCE with the task directory for planar assembly experiment.
"""
import os, sys, subprocess, glob

ROOT    = os.path.abspath(os.path.dirname(__file__) + "/..")
SOLVER  = os.path.join(ROOT, "bin/x.exe")
RUN_DIR = os.path.join(ROOT, "test/planar_exp/phase2_codegen")
SCENE   = os.path.join(ROOT, "test/planar_exp/planar_scene.g")

lgp_files = sorted(glob.glob(os.path.join(RUN_DIR, "*.lgp")))

if not lgp_files:
    print(f"❌ No .lgp files found in {RUN_DIR}")
    sys.exit(1)

print("=" * 60)
print("  Planar Assembly — Single-Directory Chained Planning")
print(f"  {len(lgp_files)} tasks queued:")
for f in lgp_files:
    print(f"  • {os.path.basename(f)}")
print("=" * 60)

# Temporarily append local libraries to run the solver natively
env = os.environ.copy()
if "LD_LIBRARY_PATH" in env:
    env["LD_LIBRARY_PATH"] = f"{os.path.join(ROOT, 'rai/lib')}:{env['LD_LIBRARY_PATH']}"
else:
    env["LD_LIBRARY_PATH"] = os.path.join(ROOT, "rai/lib")

# Solver handles all .lgp files sequentially
result = subprocess.run([SOLVER, RUN_DIR, SCENE], cwd=ROOT, env=env)

if result.returncode != 0:
    print(f"\n❌ Solver failed (exit {result.returncode})")
    sys.exit(1)

print("\n" + "=" * 60)
print("  ✅ Planar Assembly Complete!")
print("=" * 60)
