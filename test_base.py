import robotic as ry
import math

C = ry.Config()
C.addFile('generated/scene_named.g')

fl0 = C.getFrame('l_panda_base')
print('base pos', fl0.getPosition(), 'quat', fl0.getQuaternion())

fl0_link0 = C.getFrame('l_panda_link0')
print('link0 pos', fl0_link0.getPosition(), 'quat', fl0_link0.getQuaternion())
