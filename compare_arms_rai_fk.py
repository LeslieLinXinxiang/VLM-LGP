import robotic as ry
import numpy as np
from scipy.spatial.transform import Rotation as R

C = ry.Config()
C.addFile('generated/scene_named.g')

C.setJointState([0]*7)

tcp_l = C.getFrame('l_panda_finger_joint1').getPosition()
tcp_r = C.getFrame('l_panda_finger_joint2').getPosition()
tcp_center = (tcp_l+tcp_r)/2

# We want local xyz in link0 frame
# link0 is at [0, -0.3, 0.65], rotates 90deg round Z
# local_x = world_y + 0.3
# local_y = -world_x
# local_z = world_z - 0.65

local_x = tcp_center[1] + 0.3
local_y = -tcp_center[0]
local_z = tcp_center[2] - 0.65

print(f"RAI TCP Center Local:  {local_x:.4f}, {local_y:.4f}, {local_z:.4f}")
