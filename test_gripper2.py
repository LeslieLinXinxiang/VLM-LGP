import robotic as ry
import numpy as np

C = ry.Config()
C.addFile('generated/scene_named.g')

pos1 = C.getFrame('l_panda_hand_joint').getPosition()
pos2 = C.getFrame('l_panda_finger_joint1').getPosition()

print('hand_joint  :', pos1)
print('finger_joint:', pos2)
print('distance    :', np.linalg.norm(pos2 - pos1))

tcp = C.getFrame('l_panda_tcp')
if tcp:
    print('TCP pos:', tcp.getPosition())
