world: {  }
table_base(world): { pose: [0, 0, 0.6], shape: marker, size: [0.05] }
table(table_base): { pose: [0, 0, -0.05], shape: ssBox, size: [2, 1.5, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_box: True, is_place: True }, friction: 0.1 }
l_panda_base(table): { pose: [-0.4, -0.2, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.968912, 0, 0, -0.247404], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [0, -0.316, 0, 0.707107, 0.707107, 0, 0] }
l_panda_joint3(l_panda_joint3_origin): { joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, 0, 0, 0.707107, 0.707107, 0, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [0.540302, 0, 0, -0.841471], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 0, 0.707107, -0.707107, 0, 0] }
l_panda_joint5(l_panda_joint5_origin): { joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, 0, 0] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.540302, 0, 0, 0.841471], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 0, 0, 0.707107, 0.707107, 0, 0] }
l_panda_joint7(l_panda_joint7_origin): { pose: [0.968912, 0, 0, -0.247404], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [0, 0, 0.107] }
l_panda_joint8(l_panda_joint8_origin): {  }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 0, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [0, 0, 0.0584] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [0, 0, 0.0584] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [0, 0.04, 0], joint: transY, limits: [0, 0.04], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-0, -0.04, -0], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.03412e-13, 0, 0, 1], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [0, 0.02, -0.2], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [0, 0, -0.04], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [0, 0, 0.01], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-2.57788e-17, 0, 0.2105, 2.34326e-17, 0.92388, 0.382683, 5.65713e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, 0], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [0, 0.008, 0.045], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [0, -0.008, 0.045], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_base(table): { pose: [0.4, -0.2, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
r_panda_link0(r_panda_base): { shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
r_panda_joint1_origin(r_panda_link0): { pose: [0, 0, 0.333] }
r_panda_joint1(r_panda_joint1_origin): { joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint2_origin(r_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
r_panda_joint2(r_panda_joint2_origin): { pose: [0.968912, 0, 0, -0.247404], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint3_origin(r_panda_joint2): { pose: [0, -0.316, 0, 0.707107, 0.707107, 0, 0] }
r_panda_joint3(r_panda_joint3_origin): { joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint4_origin(r_panda_joint3): { pose: [0.0825, 0, 0, 0.707107, 0.707107, 0, 0] }
r_panda_joint4(r_panda_joint4_origin): { pose: [0.540302, 0, 0, -0.841471], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint5_origin(r_panda_joint4): { pose: [-0.0825, 0.384, 0, 0.707107, -0.707107, 0, 0] }
r_panda_joint5(r_panda_joint5_origin): { joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
r_panda_joint6_origin(r_panda_joint5): { pose: [0.707107, 0.707107, 0, 0] }
r_panda_joint6(r_panda_joint6_origin): { pose: [0.540302, 0, 0, 0.841471], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
r_panda_joint7_origin(r_panda_joint6): { pose: [0.088, 0, 0, 0.707107, 0.707107, 0, 0] }
r_panda_joint7(r_panda_joint7_origin): { pose: [0.968912, 0, 0, -0.247404], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
r_panda_joint8_origin(r_panda_joint7): { pose: [0, 0, 0.107] }
r_panda_joint8(r_panda_joint8_origin): {  }
r_panda_hand_joint_origin(r_panda_joint8): { pose: [0.92388, 0, 0, -0.382683] }
r_panda_hand_joint(r_panda_hand_joint_origin): { shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
r_panda_finger_joint1_origin(r_panda_hand_joint): { pose: [0, 0, 0.0584] }
r_panda_finger_joint2_origin(r_panda_hand_joint): { pose: [0, 0, 0.0584] }
r_panda_finger_joint1(r_panda_finger_joint1_origin): { pose: [0, 0.04, 0], joint: transY, limits: [0, 0.04], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
r_panda_finger_joint2(r_panda_finger_joint2_origin): { pose: [-0, -0.04, -0], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "r_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
r_panda_rightfinger_0(r_panda_finger_joint2): { pose: [-1.03412e-13, 0, 0, 1], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
r_panda_coll0(r_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll1(r_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll3(r_panda_joint3): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll5(r_panda_joint5): { pose: [0, 0.02, -0.2], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll2(r_panda_joint2): { shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll4(r_panda_joint4): { shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll6(r_panda_joint6): { pose: [0, 0, -0.04], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll7(r_panda_joint7): { pose: [0, 0, 0.01], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
r_gripper(r_panda_joint7): { pose: [-2.57788e-17, 0, 0.2105, 2.34326e-17, 0.92388, 0.382683, 5.65713e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
r_palm(r_panda_hand_joint): { pose: [0.707107, 0.707107, 0, 0], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
r_finger1(r_panda_finger_joint1): { pose: [0, 0.008, 0.045], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
r_finger2(r_panda_finger_joint2): { pose: [0, -0.008, 0.045], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
trayR(table_base): { pose: [0.1, 0.4, 0], shape: ssBox, size: [0.15, 0.07, 0.01, 0.005], color: [0.6, 0, 0], logical: { is_box: True, is_place: True } }
trayG(table_base): { pose: [0.7, 0.1, 0], shape: ssBox, size: [0.07, 0.07, 0.01, 0.005], color: [0, 0.6, 0], logical: { is_box: True, is_place: True } }
trayB(table_base): { pose: [-0.6, 0.3, 0], shape: ssBox, size: [0.07, 0.07, 0.01, 0.005], color: [0, 0, 0.6], logical: { is_box: True, is_place: True } }
objR(table): { pose: [-0.8, 0.1, 0.1], joint: rigid, shape: ssBox, size: [0.06, 0.06, 0.1, 0.005], color: [0.7, 0, 0], contact: 1, logical: { is_object: True } }
objG(table): { pose: [-0.6, 0.2, 0.1], joint: rigid, shape: ssBox, size: [0.06, 0.06, 0.1, 0.005], color: [0, 0.7, 0], contact: 1, logical: { is_object: True } }
objB(trayG): { pose: [-0, 0, 0.055], joint: rigid, shape: ssBox, size: [0.06, 0.06, 0.1, 0.005], color: [0, 0, 0.7], contact: 1, logical: { is_object: True } }
pickPose_l_gripper_objG_1(l_gripper): {  }
pickPose_r_gripper_objG_2(r_gripper): {  }
placePose_trayG_objG_3(placePose_trayG_objG_3_origin): {  }
placePose_trayG_objG_3_origin(trayG): { pose: [0, 0, 0.055] }