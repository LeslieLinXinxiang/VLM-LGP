import robotic as ry
import numpy as np
C = ry.Config()
C.addFile('generated/scene_named.g')
# Find all frames and see which are at the very tip of the arm
for f in C.getFrames():
    if 'panda' in f.name and ('grip' in f.name or 'tcp' in f.name or 'center' in f.name or 'hand' in f.name):
        print(f.name, f.getPosition())
