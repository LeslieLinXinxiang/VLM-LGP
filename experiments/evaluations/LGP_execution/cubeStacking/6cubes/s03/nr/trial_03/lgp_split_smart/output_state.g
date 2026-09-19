world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, -9.02326e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 1.11022e-16, -1.11022e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731849, 1.04083e-17, 4.33681e-17, -0.681467], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-7.94503e-16, -0.316, -5.1203e-16, 0.707107, 0.707107, 1.11022e-16, 5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [1.85472e-23, -1.44334e-18, -2.59812e-22, 1, 1.38778e-16, 0, -7.46826e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -5.39079e-16, -2.34188e-17, 0.707107, 0.707107, -5.55112e-17, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-9.75003e-22, 1.08194e-21, -6.01055e-18, 0.315292, 2.25514e-17, 5.55112e-17, -0.948995], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 8.88626e-16, 0.707107, -0.707107, 2.91434e-16, -5.55112e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.5694e-16, 2.00952e-18, -1.66599e-16, 1, 1.11022e-16, 2.77556e-17, 5.14358e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [9.23645e-23, 2.83925e-18, -6.85088e-22, 0.707107, 0.707107, -1.38778e-17, -9.71445e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731527, 5.55112e-17, 2.77556e-17, 0.681812], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -5.48173e-16, 5.46013e-16, 0.707107, 0.707107, -1.38778e-17, -1.249e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-9.74138e-17, 8.65128e-17, -5.32254e-17, 1, 8.32667e-17, 1.38778e-17, -0.000118448], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [7.63278e-17, -6.14683e-17, 0.107, 1, 2.77556e-17, 2.77556e-17, -4.05925e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [3.76836e-17, 5.96885e-17, -3.77457e-15, 1, -1.38778e-17, -1.38778e-17, 2.15106e-16] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 0, 2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, -2.77556e-17, 7.63278e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [3.1225e-17, 0, 0.0584, 1, 0, -1.38778e-17, 2.42861e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [3.1225e-17, 0, 0.0584, 1, 0, -1.38778e-17, 2.42861e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [1.47451e-17, 0.04, -2.2482e-15, 1, 0, 0, 2.77556e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [7.80626e-18, -0.04, 1.77809e-15, 1, 0, 0, 2.77556e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-9.5779e-17, 2.68828e-17, -2.66149e-17, -1.03351e-13, 1.38778e-17, -3.46945e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.06582e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-1.2837e-16, 1.09815e-16, -0.15, 1, 2.77556e-17, 0, -2.77556e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [3.88578e-16, 0.02, -0.2, 1, 5.55112e-17, 2.77556e-17, -5.55112e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 7.63278e-17, 1.65341e-16, 2.08167e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 1.66533e-16, 9.02056e-17, -1.94289e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.7895e-16, -2.49446e-16, -0.04, 1, 3.88578e-16, 5.55112e-17, -1.66533e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-3.55618e-17, -7.67089e-18, 0.01, 1, 2.77556e-17, 2.77556e-17, -4.05925e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.249e-16, -1.08053e-16, 0.2105, 0, 0.92388, 0.382683, -1.38778e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -2.77556e-17, -7.63278e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.71738e-16, 0.008, 0.045, 1, 0, 0, 2.77556e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-6.76542e-17, -0.008, 0.045, 1, 0, 0, 2.77556e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
cube_2(table): { pose: [0.026, 0.1, 0.0975, 1, 2.58014e-10, 7.69624e-11, -1.27019e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [-0.026, 0.1, 0.0975, 1, 3.10583e-10, 1.11116e-10, 3.68778e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [0.0259996, 0.1, 0.1585, 1, -3.35326e-07, -6.36873e-08, -3.02221e-07], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [-0.026, 0.1, 0.1585, 1, 2.18811e-10, -3.85249e-09, -4.07564e-09], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1(table): { pose: [-7.2679e-13, 0.1, 0.0665, 1, 3.15145e-10, 2.33646e-11, -1.56939e-11], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1_Left(rectprism_1): { pose: [-0.026, 1.2935e-17, 0.016, 1, 0, 9.38622e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1_Right(rectprism_1): { pose: [0.026, -1.96765e-18, 0.016, 1, 0, 9.38622e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2(table): { pose: [-4.34866e-09, 0.1, 0.1275, 1, 2.90988e-10, -3.81115e-09, -3.95363e-09], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_2_Left(rectprism_2): { pose: [-0.026, -5.2738e-17, 0.016, 1, 0, -3.7407e-25, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2_Right(rectprism_2): { pose: [0.026, 3.02776e-19, 0.016, 1, 0, -3.7407e-25, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }