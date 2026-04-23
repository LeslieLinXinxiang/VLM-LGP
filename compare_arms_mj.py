import xml.etree.ElementTree as ET
import numpy as np
from scipy.spatial.transform import Rotation as R

tree = ET.parse('simulation/mujoco_ros2_control_examples/panda_resources/panda_mujoco/franka_emika_panda/panda.xml')
root = tree.getroot()

def get_pos(node):
    return np.array([float(x) for x in (node.get('pos') or "0 0 0").split()])

def get_quat(node):
    q = [float(x) for x in (node.get('quat') or "1 0 0 0").split()]
    # mujoco quats are w, x, y, z
    # scipy expects x, y, z, w
    return R.from_quat([q[1], q[2], q[3], q[0]])

# Chain definition (name -> parent)
nodes = {}
for body in root.find('worldbody').iter('body'):
    name = body.get('name')
    nodes[name] = body

# Simple forward kinematics to find TCP given zero joints
def get_global_transform(node_name):
    if node_name == 'world':
        return np.array([0,0,0]), R.identity()
    
    node = nodes.get(node_name)
    if node is None:
        return np.array([0,0,0]), R.identity()
        
    pos = get_pos(node)
    quat = get_quat(node)
    
    parent_name = None
    for p in root.find('worldbody').iter('body'):
        for c in p.findall('body'):
            if c.get('name') == node_name:
                parent_name = p.get('name')
                break
    
    if parent_name is None:
        parent_pos = np.array([0,0,0])
        parent_quat = R.identity()
    else:
        parent_pos, parent_quat = get_global_transform(parent_name)
        
    global_pos = parent_pos + parent_quat.apply(pos)
    global_quat = parent_quat * quat
    
    return global_pos, global_quat

pos1, _ = get_global_transform('left_finger')
pos2, _ = get_global_transform('right_finger')
print(f"MJ Left Finger Global:  {pos1}")
print(f"MJ Right Finger Global: {pos2}")
print(f"MJ TCP Global:          {(pos1+pos2)/2}")
