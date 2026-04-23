import robotic as ry
import numpy as np

C = ry.Config()
C.addFile('generated/scene_named.g')

# Let's set the arm to a typical picking pose reaching the right side
# For example, [0, 0.5, 0, -2.0, 0, 2.5, 0.785]
C.setJointState([0, 0.5, 0, -2.0, 0, 2.5, 0.785])

grip = C.getFrame('l_gripper').getPosition()
print("RAI l_gripper: ", grip)

import xml.etree.ElementTree as ET
from scipy.spatial.transform import Rotation as R
# Re-do MuJoCo FK with joints
tree = ET.parse('simulation/mujoco_ros2_control_examples/panda_resources/panda_mujoco/franka_emika_panda/panda.xml')
root = tree.getroot()

def get_pos(node):
    return np.array([float(x) for x in (node.get('pos') or "0 0 0").split()])

def get_quat(node):
    q = [float(x) for x in (node.get('quat') or "1 0 0 0").split()]
    return R.from_quat([q[1], q[2], q[3], q[0]])

def get_axis(joint):
    return np.array([float(x) for x in (joint.get('axis') or "0 0 1").split()])

nodes = {}
joints = {}
for body in root.find('worldbody').iter('body'):
    name = body.get('name')
    nodes[name] = body
    if body.find('joint') is not None:
        joints[name] = body.find('joint')

# MuJoCo base is at origin, but LGP base is at [0, -0.3, 0.65], rotated 90deg Z
# MuJoCo coordinates are robot-local. Let's do FK strictly in MJ frame.
def evaluate_fk(q, node_name='left_finger'):
    q_dict = {
        'link1': q[0], 'link2': q[1], 'link3': q[2], 'link4': q[3],
        'link5': q[4], 'link6': q[5], 'link7': q[6]
    }
    
    def walk(name):
        if name == 'world':
            return np.array([0,0,0]), R.identity()
        node = nodes.get(name)
        pos = get_pos(node)
        quat = get_quat(node)
        
        # apply joint rotation
        joint = joints.get(name)
        if joint is not None:
            axis = get_axis(joint)
            angle = q_dict.get(name, 0.0)
            j_quat = R.from_rotvec(axis * angle)
            quat = quat * j_quat
            
        parent_name = None
        for p in root.find('worldbody').iter('body'):
            for c in p.findall('body'):
                if c.get('name') == name:
                    parent_name = p.get('name')
                    break
        
        if parent_name is None:
            parent_pos, parent_quat = np.array([0,0,0]), R.identity()
        else:
            parent_pos, parent_quat = walk(parent_name)
            
        ret_pos = parent_pos + parent_quat.apply(pos)
        ret_quat = parent_quat * quat
        return ret_pos, ret_quat
        
    pos, quat = walk(node_name)
    return pos, quat

# Calculate MJ TCP in robot local frame
pos_f, rot_f = evaluate_fk([0, 0.5, 0, -2.0, 0, 2.5, 0.785], 'left_finger')
mj_tcp = pos_f + rot_f.apply(np.array([0, 0.004, 0.045]))

print("MJ Fingertip local:", mj_tcp)

# Transform RAI world TCP to robot local
rai_tcp = grip
local_x = rai_tcp[1] + 0.3
local_y = -rai_tcp[0]
local_z = rai_tcp[2] - 0.65

print(f"RAI TCP local     : [{local_x:.8f} {local_y:.8f} {local_z:.8f}]")
diff = mj_tcp - np.array([local_x, local_y, local_z])
print(f"Diff local        : {diff} (Error norm: {np.linalg.norm(diff)})")

