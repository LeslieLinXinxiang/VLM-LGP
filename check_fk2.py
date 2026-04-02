import robotic as ry
import numpy as np

C = ry.Config()
C.addFile('generated/scene_named.g')
# Force joints to 0
C.setJointState([0]*7)

hand = C.getFrame('l_panda_hand_joint')
f1 = C.getFrame('l_panda_finger_joint1')
f2_geom = C.getFrame('l_panda_rightfinger_0')

print('Hand pos (world):', hand.getPosition())
print('Finger Base pos (world):', f1.getPosition())
print('Right finger geom pos:', f2_geom.getPosition())
