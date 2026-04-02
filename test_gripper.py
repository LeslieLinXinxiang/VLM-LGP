import robotic as ry

C = ry.Config()
C.addFile('generated/scene_named.g')

fl0 = C.getFrame('l_panda_hand_joint')

# Get local vector from hand to finger
flf = C.getFrame('l_panda_finger_joint1')
T_hand = fl0.getTransform()
T_finger = flf.getTransform()
T_rel = T_hand.invert() * T_finger
print('finger 1 relative pos:', T_rel.pos)
