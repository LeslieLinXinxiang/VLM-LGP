import robotic as ry
import numpy as np

C = ry.Config()
C.addFile('generated/scene_named.g')

flf1 = C.getFrame('l_panda_finger_joint1').getPosition()
flf2 = C.getFrame('l_panda_finger_joint2').getPosition()

tcp_pos = (flf1 + flf2) / 2
print('TCP (midpoint of fingers) in world:', tcp_pos)

obj = C.getFrame('rect_1').getPosition()
print('Obj (rect_1) in world:', obj)
