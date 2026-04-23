import xml.etree.ElementTree as ET

# Load MuJoCo panda.xml
tree = ET.parse('simulation/mujoco_ros2_control_examples/panda_resources/panda_mujoco/franka_emika_panda/panda.xml')
root = tree.getroot()

def get_pos(node):
    return node.get('pos') or "0 0 0"

def get_quat(node):
    return node.get('quat') or "1 0 0 0"

worldbody = root.find('worldbody')
for body in worldbody.iter('body'):
    name = body.get('name')
    if name and ('link' in name or 'hand' in name or 'finger' in name):
        pos = get_pos(body)
        quat = get_quat(body)
        print(f"MJ {name:15s} pos={pos:25s} quat={quat}")
