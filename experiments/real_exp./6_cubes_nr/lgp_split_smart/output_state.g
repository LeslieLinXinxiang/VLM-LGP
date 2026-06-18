world: {  }
base(world): { pose: [0, 0, 0.545], shape: ssBox, size: [1.3, 1, 0.11, 0.02], color: [0.45, 0.45, 0.45], contact: 1 }
table(base): { pose: [0, 0.25, 0.11], shape: ssBox, size: [1, 0.8, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(base): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, 7.84165e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, -6.93889e-18, 1.04083e-17, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-5.89806e-16, -0.316, -2.83635e-16, 0.707107, 0.707107, 2.77556e-17, 2.77556e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [1.88489e-25, 1.69907e-17, -2.65802e-24, 1, -1.11022e-16, -2.77556e-17, -2.95858e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -4.50922e-16, -6.59195e-17, 0.707107, 0.707107, 0, 5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.29342e-16, 9.50378e-17, 5.34229e-17, 0.315322, -3.46945e-17, 2.77556e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -3.94413e-16, 0.707107, -0.707107, 6.93889e-17, -2.22045e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [4.33674e-16, -2.00575e-16, -1.46521e-16, 1, 0, -5.55112e-17, 2.864e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [2.61787e-24, 1.38203e-17, 1.33446e-24, 0.707107, 0.707107, 5.55112e-17, -4.16334e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, 5.55112e-17, 5.55112e-17, 0.681639], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -6.38378e-16, 4.3999e-16, 0.707107, 0.707107, 2.91434e-16, -5.41234e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.46147e-16, 1.02224e-16, -7.98405e-17, 1, -4.16334e-17, 2.77556e-17, 3.63952e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [7.63278e-17, -3.78866e-17, 0.107, 1, -1.38778e-17, 0, -1.21431e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.23608e-16, 3.89505e-17, -2.71568e-15, 1, -1.38778e-17, -1.38778e-17, 1.04083e-16] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -2.77556e-17, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, 1.38778e-17, -2.77556e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [6.93889e-17, 3.81639e-17, 0.0584, 1, 0, 0, -3.1225e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [6.93889e-17, 3.81639e-17, 0.0584, 1, 0, 0, -3.1225e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [6.93889e-18, 0.04, -1.4138e-15, 1, 0, 0, 2.77556e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [3.46945e-18, -0.04, 9.45424e-16, 1, 0, 0, 2.77556e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-6.62889e-17, 3.18419e-17, -1.33068e-17, -1.03407e-13, -1.38778e-17, -2.77556e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.06582e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [2.77556e-17, -3.68068e-17, -0.15, 1, -2.22045e-16, -8.32667e-17, 3.88578e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [9.15934e-16, 0.02, -0.2, 1, 5.55112e-17, 2.77556e-17, 0], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 3.19189e-16, -2.30068e-16, 2.56739e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-2.28687e-25, -1.67104e-25, 1.73061e-18, 1, -3.05311e-16, -1.31839e-16, -2.22045e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.52844e-16, -4.36295e-16, -0.04, 1, -2.77556e-16, 2.77556e-16, -1.38778e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [1.21431e-17, -2.73617e-17, 0.01, 1, -1.38778e-17, 0, -1.21431e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [2.08167e-16, -8.58424e-17, 0.2105, 1.38778e-17, 0.92388, 0.382683, 1.38778e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -2.77556e-17, -2.77556e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-1.38778e-17, 0.008, 0.045, 1, 0, 0, 2.77556e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-3.29597e-17, -0.008, 0.045, 1, 0, 0, 2.77556e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
rect_2(table): { pose: [-4.54924e-11, 0.1, 0.0665, 1, 5.04175e-13, -2.40915e-11, -5.38086e-11], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rect_1_Left(rect_2): { pose: [-0.026, -3.05323e-16, 0.016, 1, 0, -1.17527e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_1_Right(rect_2): { pose: [0.026, -1.25229e-17, 0.016, 1, 0, -1.17527e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_3(table): { pose: [0.08, 0.1, 0.0665, 1, -4.44656e-14, -9.46928e-14, -1.1181e-13], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rect_2_Left(rect_3): { pose: [-0.026, 2.56986e-16, 0.016, 1, 1.05438e-30, 1.18793e-30, -5.55112e-17], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_2_Right(rect_3): { pose: [0.026, 5.83985e-18, 0.016, 1, 1.05438e-30, 1.18793e-30, -5.55112e-17], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_6(table): { pose: [0.08, 0.1, 0.0965, 1, 3.70055e-13, 1.19272e-12, 2.41766e-14], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rect_3_Left(rect_6): { pose: [-0.026, -1.68849e-18, 0.016, 1, 0, 6.09425e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_3_Right(rect_6): { pose: [0.026, 9.29692e-17, 0.016, 1, 0, 6.09425e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_5(table): { pose: [-1.04068e-08, 0.0999999, 0.0965001, 1, -4.71001e-08, 7.31149e-09, -1.93923e-08], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rect_4_Left(rect_5): { pose: [-0.026, 2.37796e-17, 0.016, 1, 1.98523e-23, -2.70582e-25, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_4_Right(rect_5): { pose: [0.026, -7.90501e-17, 0.016, 1, 1.98523e-23, -2.70582e-25, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_1(table): { pose: [-0.08, 0.1, 0.0665, 1, -4.50685e-12, 4.74225e-11, 3.02381e-11], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rect_5_Left(rect_1): { pose: [-0.026, -3.06455e-16, 0.016, 1, 0, -5.75067e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_5_Right(rect_1): { pose: [0.026, -2.90705e-17, 0.016, 1, 0, -5.75067e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_4(table): { pose: [-0.08, 0.1, 0.0965, 1, -8.41442e-12, 6.06908e-11, 5.3705e-11], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rect_6_Left(rect_4): { pose: [-0.026, 1.94692e-16, 0.016, 1, 0, 2.6823e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_6_Right(rect_4): { pose: [0.026, 1.81507e-17, 0.016, 1, 0, 2.6823e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }