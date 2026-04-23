import xml.etree.ElementTree as ET
tree = ET.parse('simulation/mujoco_ros2_control_examples/panda_resources/panda_mujoco/franka_emika_panda/panda.xml')
for d in tree.findall('.//default'):
    if d.get('class') == 'fingertip_pad':
        g = d.find('geom')
        print('fingertip_pad default pos:', g.get('pos'))
