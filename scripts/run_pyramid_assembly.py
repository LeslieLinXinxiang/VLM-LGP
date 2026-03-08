#!/usr/bin/env python3
"""
run_pyramid_assembly.py
Calls the solver ONCE with the task directory — the solver internally
iterates all .lgp files alphabetically in one pass.

Run:
    cd /home/leslie/Projects/VLM_LGP
    python3 scripts/run_pyramid_assembly.py
"""
import os, sys, subprocess, glob

ROOT    = os.path.abspath(os.path.dirname(__file__) + "/..")
SOLVER  = os.path.join(ROOT, "bin/x.exe")
RUN_DIR = os.path.join(ROOT, "generated", "pyramid_assembly_run")

lgp_files = sorted(glob.glob(os.path.join(RUN_DIR, "*.lgp")))

if not lgp_files:
    print(f"❌ No .lgp files found in {RUN_DIR}")
    sys.exit(1)

scene = os.path.join(RUN_DIR, "scene_named.g")

print("=" * 60)
print("  Pyramid Assembly — Single-Directory Chained Planning")
print(f"  {len(lgp_files)} batches queued")
print("=" * 60)
for f in lgp_files:
    print(f"  • {os.path.basename(f)}")
print("=" * 60)

# Solver handles all .lgp files internally in one call
result = subprocess.run([SOLVER, RUN_DIR, scene], cwd=ROOT)

if result.returncode != 0:
    print(f"\n❌ Solver failed (exit {result.returncode})")
    sys.exit(1)

print("\n" + "=" * 60)
print("  ✅ Pyramid Assembly Complete!")
print("=" * 60)
