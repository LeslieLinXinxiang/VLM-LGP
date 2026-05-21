world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, -4.32738e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731681, -2.08167e-17, -7.45931e-17, -0.681648], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-4.47559e-16, -0.316, -5.00197e-16, 0.707107, 0.707107, 1.17961e-16, 1.11022e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-9.93936e-25, 1.62407e-17, 1.40207e-23, 1, 2.77556e-17, 2.77556e-17, -5.53742e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.79469e-16, -1.06685e-16, 0.707107, 0.707107, 5.55112e-17, -1.11022e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.29339e-16, 9.50429e-17, 5.89559e-17, 0.315321, -1.30972e-16, 2.77556e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 4.41809e-16, 0.707107, -0.707107, 2.08167e-16, 3.33067e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [3.73683e-16, -2.02606e-16, -2.3995e-16, 1, 8.32667e-17, -5.55112e-17, -1.08626e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-5.99876e-17, -3.08968e-18, -9.34208e-17, 0.707107, 0.707107, 2.22045e-16, 2.77556e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [-8.44197e-30, -2.62892e-30, -3.30872e-24, 0.731699, -1.66533e-16, 1.38778e-17, 0.681628], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.26128e-16, 3.3443e-16, 0.707107, 0.707107, 1.249e-16, 0] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.94863e-16, 1.60041e-16, -1.06452e-16, 1, 5.55112e-17, -5.55112e-17, 3.27737e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [1.45717e-16, -6.55087e-17, 0.107, 1, 2.77556e-17, 0, -2.15106e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [6.58483e-17, 5.23561e-17, -2.4942e-15, 1, 0, 0, -1.04083e-16] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -2.77556e-17, 2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 2.77556e-17, -1.38778e-17, -1.21431e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [5.89806e-17, 2.77556e-17, 0.0584, 1, 0, 0, -5.89806e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [5.89806e-17, 2.77556e-17, 0.0584, 1, 0, 0, -5.89806e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [1.99493e-17, 0.04, -1.44849e-15, 1, 0, 0, 0], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [2.86229e-17, -0.04, 1.0044e-15, 1, 0, 0, 0], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-6.38355e-17, 2.9389e-17, -1.33064e-17, -1.03438e-13, -2.77556e-17, -2.08167e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 7.10544e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.66533e-16, 3.16373e-18, -0.15, 1, -2.77556e-17, -2.77556e-17, 5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.94289e-16, 0.02, -0.2, 1, -5.55112e-17, 0, 1.66533e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -3.1225e-17, 1.51463e-16, 3.1225e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-2.62375e-24, -5.50181e-24, -6.92449e-18, 1, -1.38778e-16, 1.31839e-16, -2.77556e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.4481e-16, -3.24529e-16, -0.04, 1, 8.32667e-17, 0, 1.38778e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-2.08167e-17, -8.68194e-18, 0.01, 1, 2.77556e-17, 0, -2.15106e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.94289e-16, -1.12198e-16, 0.2105, 1.38778e-17, 0.92388, 0.382683, 5.55112e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -2.77556e-17, -1.38778e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [6.76542e-17, 0.008, 0.045, 1, 0, 0, 0], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-8.50015e-17, -0.008, 0.045, 1, 0, 0, 0], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Work_Center(table): { pose: [0.4, 0, 0.051], shape: ssBox, size: [0.04, 0.04, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Init_Center(table): { pose: [-0.36, 0, 0.051], shape: ssBox, size: [0.04, 0.04, 0.001, 0.0005], color: [1, 1, 0, 0], logical: { is_place: True } }
cube_3(table): { pose: [0.05, 0.1, 0.0665, 1, -7.18959e-10, -1.38766e-10, -2.42483e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [9.79531e-11, 0.1, 0.0965, 1, -6.45165e-11, -6.78157e-11, 9.29026e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [-0.05, 0.1, 0.0665, 1, -6.82067e-10, -2.35977e-10, -1.16044e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [4.06136e-13, 0.1, 0.0665, 1, -3.35413e-12, 1.62277e-13, 3.4492e-13], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
Table_Left(table): { pose: [-0.05, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.05, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }