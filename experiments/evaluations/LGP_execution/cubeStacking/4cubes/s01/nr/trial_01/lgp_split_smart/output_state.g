world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, 5.71036e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -5.55112e-17, 1.66533e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, 1.31839e-16, 1.9082e-17, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-1.8735e-16, -0.316, -2.26371e-16, 0.707107, 0.707107, -3.46945e-18, -1.66533e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [2.47662e-27, 3.06568e-18, -3.49245e-26, 1, 5.55112e-17, 1.11022e-16, -4.53734e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.96412e-16, 7.28584e-17, 0.707107, 0.707107, 1.66533e-16, -1.66533e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.05002e-26, -2.82504e-26, -2.47982e-18, 0.315322, -1.34441e-16, -5.55112e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 7.29849e-16, 0.707107, -0.707107, 2.35922e-16, 5.55112e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-7.24852e-26, -5.39293e-18, -2.25384e-26, 1, -2.77556e-17, -2.77556e-17, 1.20553e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [4.03949e-25, 1.07572e-17, 4.49571e-26, 0.707107, 0.707107, -8.32667e-17, 8.32667e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, 5.55112e-17, 2.77556e-17, 0.681638], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -5.75928e-16, 3.38194e-16, 0.707107, 0.707107, -4.16334e-17, 2.08167e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.46147e-16, 1.05783e-16, -7.98405e-17, 1, -5.55112e-17, -6.93889e-17, 3.1853e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [4.16334e-17, -4.61033e-17, 0.107, 1, 0, 0, 1.73472e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-6.22318e-17, 3.75064e-17, -3.07022e-15, 1, -1.38778e-17, 1.38778e-17, 0] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-9.49452e-29, -1.5065e-22, 5.59843e-30, 0.92388, -2.77556e-17, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 2.77556e-17, 2.77556e-17, 5.20417e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [4.85723e-17, 3.46945e-17, 0.0584, 1, -2.77556e-17, -1.38778e-17, -1.73472e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [4.85723e-17, 3.46945e-17, 0.0584, 1, -2.77556e-17, -1.38778e-17, -1.73472e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [3.1225e-17, 0.04, -1.81105e-15, 1, 0, 1.38778e-17, -1.04083e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [2.60209e-17, -0.04, 1.3687e-15, 1, 0, 1.38778e-17, -1.04083e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-7.61527e-17, 7.25858e-18, -2.66135e-17, -1.03396e-13, -1.38778e-17, -2.77556e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 7.10544e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-9.36751e-17, 1.05096e-16, -0.15, 1, 0, 8.32667e-17, 3.33067e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [3.46945e-16, 0.02, -0.2, 1, -2.77556e-17, 0, -1.11022e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -5.20417e-17, 1.24683e-17, -3.81639e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -5.55112e-17, 2.498e-16, -2.22045e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.4075e-16, -2.65168e-16, -0.04, 1, 1.11022e-16, 0, 1.66533e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-1.12757e-17, -8.71272e-18, 0.01, 1, 0, 0, 1.73472e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [6.93889e-17, -7.33056e-17, 0.2105, 2.77556e-17, 0.92388, 0.382683, 1.38778e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 2.77556e-17, 4.16334e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [8.32667e-17, 0.008, 0.045, 1, 0, 0, -1.38778e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.04083e-17, -0.008, 0.045, 1, 0, 0, -1.38778e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
cube_3(table): { pose: [0.08, 0.1, 0.0665, 1, 1.74435e-12, 1.00384e-12, 1.0357e-12], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [1.00767e-10, 0.1, 0.0965, 1, 6.52446e-12, 1.94709e-10, 8.35605e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [-0.08, 0.1, 0.0665, 1, -4.80206e-10, -2.69171e-10, -1.48951e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [-1.32156e-13, 0.1, 0.0665, 1, -3.02657e-12, 1.85965e-12, -3.16945e-13], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }