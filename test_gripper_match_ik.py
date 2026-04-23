import robotic as ry
import numpy as np

C = ry.Config()
C.addFile('generated/scene_named.g')
C.setJointState([0]*7)

hand = C.getFrame('l_panda_hand_joint').getPosition()
grip = C.getFrame('l_gripper').getPosition()

print("RAI hand_joint: ", hand)
print("RAI l_gripper:  ", grip)
print("RAI tcp offset Z: ", np.linalg.norm(hand - grip))

import xml.etree.ElementTree as ET
from scipy.spatial.transform import Rotation as R

tree = ET.parse('simulation/mujoco_ros2_control_examples/panda_resources/panda_mujoco/franka_emika_panda/panda.xml')
root = tree.getroot()

def get_global(name):
    # Dummy function assuming everything straight
    if name == 'hand': return np.array([0, 0, 0.107])
    if name == 'left_finger': return np.array([0, 0, 0.107+0.0584])

print("MJ left_finger (no pad): ", 0.107+0.0584)
print("MJ fingertip pad (tip):  ", 0.107+0.0584+0.045)
