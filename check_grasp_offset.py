import robotic as ry
import numpy as np

C = ry.Config()
C.addFile('generated/scene_named.g')
C.setJointState([0]*7) # Zero config

# RAI TCP (just between the finger base joints)
flf1 = C.getFrame('l_panda_finger_joint1').getPosition()
flf2 = C.getFrame('l_panda_finger_joint2').getPosition()
tcp_center = (flf1 + flf2) / 2

# Is there any other deeper frame? Let's check collision bodies
print("RAI Hand Joint:", C.getFrame('l_panda_hand_joint').getPosition())
print("RAI Finger Joint Base:", tcp_center)

for f in C.getFrames():
    if 'coll' in f.name and 'panda' in f.name:
        print(f.name, f.getPosition())

