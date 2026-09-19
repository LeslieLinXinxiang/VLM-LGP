world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, -1.98163e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, 2.77556e-17, -3.98986e-17, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [2.84495e-16, -0.316, -6.55235e-16, 0.707107, 0.707107, -2.06432e-16, 5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-2.02169e-25, 7.21145e-18, 2.85093e-24, 1, 0, -5.55112e-17, -1.25625e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.86664e-16, -3.46945e-18, 0.707107, 0.707107, 5.55112e-17, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.29342e-16, 9.50377e-17, 6.93028e-17, 0.315322, 2.60209e-18, 1.38778e-16, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 3.0558e-16, 0.707107, -0.707107, -3.46945e-16, -4.996e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [6.5051e-16, -2.96285e-16, -2.19782e-16, 1, -2.77556e-17, -2.77556e-17, 2.57657e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-2.63013e-25, -6.79944e-18, 3.29e-24, 0.707107, 0.707107, 2.77556e-17, 4.16334e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, 5.55112e-17, -5.55112e-17, 0.681638], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.88578e-16, 2.29668e-16, 0.707107, 0.707107, -1.66533e-16, 5.55112e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.43578e-16, 2.05204e-16, -1.33067e-16, 1, 0, -1.38778e-17, 2.75908e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [4.85723e-17, -8.15176e-17, 0.107, 1, 0, -2.77556e-17, 1.249e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [5.5955e-17, 1.3891e-16, -4.27075e-15, 1, 0, 0, -9.71445e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [1.36548e-29, 1.32349e-23, -9.63664e-31, 0.92388, 0, 2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 2.77556e-17, -5.55112e-17, -7.28584e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [5.55112e-17, -3.46945e-18, 0.0584, 1, 0, -1.38778e-17, -3.46945e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [5.55112e-17, -3.46945e-18, 0.0584, 1, 0, -1.38778e-17, -3.46945e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-5.37764e-17, 0.04, -2.20483e-15, 1, 0, 0, 0], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [6.15827e-17, -0.04, 1.73472e-15, 1, 0, 0, 0], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.52255e-16, 4.89137e-17, -3.99202e-17, -1.03438e-13, 0, -2.77556e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.24346e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-5.20417e-18, -4.5295e-17, -0.15, 1, -5.55112e-17, 1.94289e-16, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.26288e-15, 0.02, -0.2, 1, -2.77556e-17, 2.77556e-17, 2.77556e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -2.46331e-16, 1.61329e-16, 7.28584e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-1.56989e-25, -5.91145e-24, -1.22172e-17, 1, 0, -6.245e-17, -8.32667e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.21864e-16, -3.19006e-16, -0.04, 1, 1.38778e-16, 0, -2.77556e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [5.0307e-17, -2.09435e-17, 0.01, 1, 0, -2.77556e-17, 1.249e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [2.22045e-16, -2.08224e-16, 0.2105, -1.38778e-17, 0.92388, 0.382683, 8.32667e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -8.32667e-17, -4.85723e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.37657e-16, 0.008, 0.045, 1, 0, 0, 0], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.33574e-16, -0.008, 0.045, 1, 0, 0, 0], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
rectprism_5(table): { pose: [0.0518469, 0.0598199, 0.0404265, 0.998004, 0.0602571, -0.00779904, 0.0172218], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_5_Left(rectprism_5): { pose: [-0.026, -2.9924e-17, 0.016, 1, 0, 4.33681e-19, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_5_Right(rectprism_5): { pose: [0.026, 1.25767e-17, 0.016, 1, 0, 4.33681e-19, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1(table): { pose: [-0.08, 0.1, 0.0665, 1, -1.2961e-09, -8.77918e-10, -7.61515e-10], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1_Left(rectprism_1): { pose: [-0.026, 8.99876e-19, 0.016, 1, 0, 3.31811e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1_Right(rectprism_1): { pose: [0.026, 9.48672e-18, 0.016, 1, 0, 3.31811e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_6(table): { pose: [-0.08, 0.1, 0.0665, 1, -1.50953e-09, -9.33419e-09, 2.32294e-09], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_6_Left(rectprism_6): { pose: [-0.026, -2.47745e-17, 0.016, 1, 0, 3.85878e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_6_Right(rectprism_6): { pose: [0.026, 6.79721e-18, 0.016, 1, 0, 3.85878e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4(table): { pose: [-0.0400087, 0.0999926, 0.0965374, 1, -1.34161e-05, -2.08994e-06, -2.35421e-06], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_4_Left(rectprism_4): { pose: [-0.026, 1.40259e-17, 0.016, 1, 1.69407e-21, 1.28601e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4_Right(rectprism_4): { pose: [0.026, -1.81418e-17, 0.016, 1, 1.69407e-21, 1.28601e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2(table): { pose: [7.58485e-10, 0.1, 0.0665, 1, -1.04419e-09, -2.41231e-10, 6.13952e-10], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_2_Left(rectprism_2): { pose: [-0.026, -2.82853e-18, 0.016, 1, 0, 1.34366e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2_Right(rectprism_2): { pose: [0.026, -3.04037e-18, 0.016, 1, 0, 1.34366e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3(table): { pose: [0.08, 0.1, 0.0665, 1, -6.19714e-12, -2.49404e-11, -4.2962e-11], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_3_Left(rectprism_3): { pose: [-0.026, -1.42443e-17, 0.016, 1, 0, -7.68637e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3_Right(rectprism_3): { pose: [0.026, 7.99709e-17, 0.016, 1, 0, -7.68637e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
cube_1(table): { pose: [-0.08, 0.1, 0.0965, 1, -5.18998e-09, -9.10853e-09, 2.56782e-09], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }