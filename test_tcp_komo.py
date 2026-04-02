import robotic as ry
import numpy as np
C = ry.Config()
C.addFile('generated/scene_named.g')

fl0 = C.getFrame('l_panda_hand_joint')
T_hand = fl0.getPosition()

flf1 = C.getFrame('l_panda_finger_joint1')
flf2 = C.getFrame('l_panda_finger_joint2')
T_f1 = flf1.getPosition()
T_f2 = flf2.getPosition()

print(f"RAI hand_joint: {T_hand}")
print(f"RAI finger1:    {T_f1}")
print(f"RAI finger2:    {T_f2}")
print(f"RAI TCP Center: {(T_f1 + T_f2)/2}")
print(f"RAI Dist Hand->TCP Z: {np.linalg.norm((T_f1 + T_f2)/2 - T_hand)}")
