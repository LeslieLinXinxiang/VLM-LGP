world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, -2.03511e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, 5.55112e-17, -5.55112e-17, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-6.66134e-16, -0.316, -5.34997e-16, 0.707107, 0.707107, -2.15106e-16, 2.77556e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-5.30927e-26, 1.84408e-17, 7.48699e-25, 1, 5.55112e-17, -8.32667e-17, 1.92697e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -4.19974e-16, -2.29851e-16, 0.707107, 0.707107, 2.22045e-16, 1.66533e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.29342e-16, 9.50377e-17, 7.38046e-17, 0.315323, -7.02563e-17, -5.55112e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 7.53873e-16, 0.707107, -0.707107, 5.55112e-17, 0] }
l_panda_joint5(l_panda_joint5_origin): { pose: [3.73688e-16, -2.34964e-16, -2.39943e-16, 1, 0, 5.55112e-17, 3.67703e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [7.65977e-27, -1.68298e-19, 1.88239e-27, 0.707107, 0.707107, 5.55112e-17, -2.77556e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, -5.55112e-17, 2.77556e-17, 0.681638], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -7.42462e-16, 3.61308e-16, 0.707107, 0.707107, -2.63678e-16, 2.63678e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.43578e-16, 2.19881e-16, -1.33067e-16, 1, -4.16334e-17, -2.77556e-17, 4.08291e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [1.249e-16, -8.3526e-17, 0.107, 1, 1.38778e-17, 2.77556e-17, -9.71445e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.35341e-16, 7.6633e-17, -3.72134e-15, 1, 1.38778e-17, -1.38778e-17, 1.2837e-16] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 0, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, -1.38778e-17, -5.55112e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [4.16334e-17, -3.46945e-18, 0.0584, 1, 0, 0, 6.93889e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [4.16334e-17, -3.46945e-18, 0.0584, 1, 0, 0, 6.93889e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [1.04951e-16, 0.04, -2.48412e-15, 1, 0, 0, 6.93889e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [1.73472e-17, -0.04, 1.59768e-15, 1, 0, 0, 6.93889e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-8.83683e-17, 5.39214e-17, -1.33067e-17, -1.03435e-13, 0, -3.46945e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 8.8818e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.47451e-16, -5.29838e-17, -0.15, 1, 0, 0, 1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [3.19189e-16, 0.02, -0.2, 1, -2.77556e-17, 0, -1.66533e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -1.11022e-16, -3.27646e-16, 1.04083e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [3.66839e-25, 7.76101e-26, 6.93888e-18, 1, 0, -6.93889e-18, 8.32667e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.89792e-16, -1.32566e-16, -0.04, 1, -1.11022e-16, -5.55112e-17, 5.55112e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [4.33681e-17, -6.5415e-18, 0.01, 1, 1.38778e-17, 2.77556e-17, -9.71445e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.80411e-16, -1.50221e-16, 0.2105, 0, 0.92388, 0.382683, 2.77556e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 2.77556e-17, -5.55112e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [9.19403e-17, 0.008, 0.045, 1, 0, 0, 6.93889e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-6.07153e-17, -0.008, 0.045, 1, 0, 0, 6.93889e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
longrect_1(table): { pose: [2.20404e-10, 0.1, 0.0665, 1, 8.66359e-09, -2.02686e-10, 1.9715e-10], joint: rigid, shape: ssBox, size: [0.095, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.6, inertia: [0.00108, 0.005955, 0.005955], logical: { is_object: True, is_box: True, is_place: True } }
longrect_1_Left(longrect_1): { pose: [-0.038, 2.51434e-18, 0.016, 1, 0, 3.95607e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_1_Right(longrect_1): { pose: [0.038, 6.51062e-17, 0.016, 1, 0, 3.95607e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_1_Center(longrect_1): { pose: [3.15039e-26, 6.05468e-18, 0.016, 1, 0, 3.95607e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2(table): { pose: [5.20639e-09, 0.1, 0.1575, 1, 9.23749e-09, 1.10418e-08, 5.48353e-09], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_2_Left(rectprism_2): { pose: [-0.026, -1.7935e-18, 0.016, 1, -1.65436e-24, -2.32249e-24, -8.27181e-25], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2_Right(rectprism_2): { pose: [0.026, -9.32074e-18, 0.016, 1, -1.65436e-24, -2.32249e-24, -8.27181e-25], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1(table): { pose: [1.89858e-10, 0.1, 0.0965, 1, 8.64315e-09, -2.52868e-10, 1.72001e-10], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1_Left(rectprism_1): { pose: [-0.026, -1.87258e-18, 0.016, 1, 0, -8.72744e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1_Right(rectprism_1): { pose: [0.026, -2.57391e-17, 0.016, 1, 0, -8.72744e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
cube_2(table): { pose: [0.026, 0.1, 0.1275, 1, 2.19583e-09, -3.92463e-09, -7.69147e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [-0.026, 0.1, 0.1275, 1, 8.57039e-09, -2.29791e-10, 2.83999e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }