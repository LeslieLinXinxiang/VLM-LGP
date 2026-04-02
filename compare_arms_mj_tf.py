import xml.etree.ElementTree as ET
import numpy as np

tree = ET.parse('simulation/mujoco_ros2_control_examples/panda_resources/panda_mujoco/franka_emika_panda/panda.xml')
root = tree.getroot()

def get_pos(node):
    return np.array([float(x) for x in (node.get('pos') or "0 0 0").split()])

for mesh in root.find('worldbody').findall('.//body[@name="hand"]'):
    print("hand pos", get_pos(mesh))
    for finger in mesh.findall('body'):
        print(finger.get('name'), get_pos(finger))
        
        # Look for geoms inside fingers
        for geom in finger.findall('geom'):
            print("  geom pos:", geom.get('pos'), "class:", geom.get('class'))

