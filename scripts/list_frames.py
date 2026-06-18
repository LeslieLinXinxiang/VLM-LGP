#!/usr/bin/env python3
"""
List all frames in the panda model to find the correct TCP frame name.
"""

import sys
sys.path.insert(0, '/home/leslie/Projects/VLM_LGP')

try:
    import robotic as ry
except ImportError:
    print("ERROR: robotic (RAI) module not found.")
    sys.exit(1)

# Create config from scene file
C = ry.Config()
C.addFile('/home/leslie/Projects/VLM_LGP/test/planar_exp/planar_scene.g')

print("All frames in the configuration:")
print("-" * 60)
frames = C.getFrameNames()
for i, fname in enumerate(frames):
    print(f"{i:3d}. {fname}")

print()
print("Looking for gripper/end-effector frames:")
print("-" * 60)
for fname in frames:
    if any(kw in fname.lower() for kw in ['hand', 'gripper', 'ee', 'tool', 'tcp', 'panda_link8']):
        print(f"  -> {fname}")
