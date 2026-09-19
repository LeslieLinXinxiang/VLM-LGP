world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, -9.40437e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, 1.04083e-17, -1.00614e-16, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-1.03043e-15, -0.316, -4.2426e-16, 0.707107, 0.707107, -1.49186e-16, 0] }
l_panda_joint3(l_panda_joint3_origin): { pose: [7.85324e-18, 6.97912e-18, -1.10744e-16, 1, -2.77556e-17, 0, 4.32365e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -4.64569e-16, -4.85723e-17, 0.707107, 0.707107, 5.55112e-17, 5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.21488e-16, -1.57065e-17, 5.25582e-17, 0.315322, -3.98986e-17, 5.55112e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 3.97776e-16, 0.707107, -0.707107, -2.91434e-16, 5.55112e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [4.03681e-16, -2.0904e-16, -1.93232e-16, 1, -8.32667e-17, 5.55112e-17, -4.50586e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-6.23021e-25, 7.04366e-18, 2.53041e-25, 0.707107, 0.707107, 2.77556e-17, 1.52656e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, 0, -2.77556e-17, 0.681638], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -6.38378e-16, 5.30208e-16, 0.707107, 0.707107, -1.66533e-16, 2.35922e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.43578e-16, 1.66335e-16, -1.33067e-16, 1, -4.16334e-17, 1.38778e-17, 4.62367e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [1.249e-16, -7.71893e-17, 0.107, 1, -1.38778e-17, 2.77556e-17, -1.80411e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.0196e-16, 8.43586e-17, -3.48656e-15, 1, -4.16334e-17, -1.38778e-17, -1.38778e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 8.32667e-17, -2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, 2.77556e-17, 5.89806e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [4.16334e-17, 0, 0.0584, 1, 0, 0, -6.93889e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [4.16334e-17, 0, 0.0584, 1, 0, 0, -6.93889e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [2.60209e-18, 0.04, -1.74166e-15, 1, 0, 0, -6.93889e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [8.67362e-18, -0.04, 1.27155e-15, 1, 0, 0, -6.93889e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-9.08215e-17, 5.63747e-17, -1.33067e-17, -1.03435e-13, -2.77556e-17, 6.93889e-18, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.06582e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-4.85723e-17, -6.97903e-17, -0.15, 1, -2.77556e-17, 0, 1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [2.63678e-16, 0.02, -0.2, 1, 2.77556e-17, 0, 1.11022e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 1.249e-16, -3.38813e-16, -1.14492e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1.31422e-31, -5.94323e-32, 1.65436e-24, 1, 0, 6.245e-17, 2.22045e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.32205e-16, -3.9666e-16, -0.04, 1, 0, -5.55112e-17, 8.32667e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [5.63785e-17, -9.98804e-18, 0.01, 1, -1.38778e-17, 2.77556e-17, -1.80411e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.11022e-16, -1.59774e-16, 0.2105, 0, 0.92388, 0.382683, 2.77556e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, -9.71445e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [9.54098e-17, 0.008, 0.045, 1, 0, 0, -6.93889e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-6.41848e-17, -0.008, 0.045, 1, 0, 0, -6.93889e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
cube_4(table): { pose: [0.0260001, 0.0999999, 0.1585, 1, -7.37262e-08, 1.29566e-07, 2.07502e-08], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [-0.0259999, 0.0999999, 0.1585, 1, -8.02766e-08, 1.29985e-07, 2.07558e-08], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [0.026, 0.1, 0.0975, 1, 1.25389e-10, 5.2199e-11, -1.15382e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [-0.026, 0.1, 0.0975, 1, 1.21158e-10, -7.03528e-12, 8.89631e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_2(table): { pose: [8.50665e-08, 0.0999999, 0.1275, 1, -7.38022e-08, 1.30158e-07, 2.10394e-08], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_2_Left(rectprism_2): { pose: [-0.026, 8.39e-17, 0.016, 1, -6.00966e-24, 8.90651e-24, -5.55112e-17], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2_Right(rectprism_2): { pose: [0.026, -1.18567e-16, 0.016, 1, -6.00966e-24, 8.90651e-24, -5.55112e-17], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1(table): { pose: [6.57787e-12, 0.1, 0.0665, 1, 1.87197e-10, 3.80427e-12, -1.01372e-12], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1_Left(rectprism_1): { pose: [-0.026, -9.03425e-17, 0.016, 1, 0, -9.36801e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1_Right(rectprism_1): { pose: [0.026, 4.12799e-18, 0.016, 1, 0, -9.36801e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }