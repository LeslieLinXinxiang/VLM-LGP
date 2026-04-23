import robotic as ry
import numpy as np

C = ry.Config()
C.addFile('generated/scene_named.g')
# Z-axis length of the finger bounding box
f = C.getFrame('l_panda_finger_joint1')
print(f.name, 'shape info:', f.getSize())
