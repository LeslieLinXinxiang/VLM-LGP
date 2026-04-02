import robotic as ry
C = ry.Config()
C.addFile('generated/scene_named.g')
C.setJointState([0]*7)

print("RAI link7:", C.getFrame('l_panda_joint7').getPosition())
print("RAI hand:", C.getFrame('l_panda_hand_joint').getPosition())
print("Diff:", C.getFrame('l_panda_hand_joint').getPosition() - C.getFrame('l_panda_joint7').getPosition())
