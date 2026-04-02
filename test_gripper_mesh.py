import robotic as ry
C = ry.Config()
C.addFile('generated/scene_named.g')
# Check mesh details of grasping components
f = C.getFrame('l_panda_finger_joint1')
print("finger1 shape:", f.info())
