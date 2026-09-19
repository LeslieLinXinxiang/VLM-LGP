world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, -1.7305e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -5.55112e-17, 5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, -3.81639e-17, -4.16334e-17, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-2.87964e-16, -0.316, -3.49825e-16, 0.707107, 0.707107, -1.07553e-16, 5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-3.74978e-26, 1.53167e-17, 5.28783e-25, 1, 5.55112e-17, 8.32667e-17, 4.57219e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.88624e-16, -5.11743e-17, 0.707107, 0.707107, 0, -1.11022e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.21488e-16, -1.57065e-17, 6.35168e-17, 0.315322, 6.93889e-18, -2.77556e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 2.60028e-16, 0.707107, -0.707107, 5.55112e-17, 0] }
l_panda_joint5(l_panda_joint5_origin): { pose: [2.4683e-16, -2.07224e-16, -2.65496e-17, 1, -2.77556e-17, -8.32667e-17, -1.72432e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [3.5187e-26, -2.78277e-19, -7.12483e-27, 0.707107, 0.707107, -5.55112e-17, -1.38778e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, 0, 6.93889e-17, 0.681638], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -4.16334e-16, 2.49039e-16, 0.707107, 0.707107, -6.93889e-17, -3.46945e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.92294e-16, 2.09617e-16, -1.59681e-16, 1, -2.77556e-17, 0, 4.55407e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [6.93889e-18, -8.73638e-17, 0.107, 1, 0, 0, 6.93889e-18] }
l_panda_joint8(l_panda_joint8_origin): { pose: [8.39145e-17, 9.19763e-17, -2.99038e-15, 1, 0, 0, 6.93889e-18] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 5.55112e-17, -2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, 1.38778e-17, -7.97973e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-1.04083e-17, -5.20417e-17, 0.0584, 1, 0, 0, -2.42861e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-1.04083e-17, -5.20417e-17, 0.0584, 1, 0, 0, -2.42861e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-7.28584e-17, 0.04, -1.42594e-15, 1, 0, 0, -2.42861e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [3.98986e-17, -0.04, 9.29812e-16, 1, 0, 0, -2.42861e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.7915e-17, 7.51223e-17, -2.34783e-16, -1.03344e-13, 0, -2.08167e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 7.10544e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-6.59195e-17, -6.30918e-17, -0.15, 1, 0, 2.77556e-17, 5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [4.71845e-16, 0.02, -0.2, 1, -2.77556e-17, 0, -3.88578e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 2.56739e-16, -5.05238e-17, -7.63278e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -3.05311e-16, 1.52656e-16, -2.77556e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.99458e-16, -2.47692e-16, -0.04, 1, -1.11022e-16, 0, -5.55112e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-4.33681e-18, -1.17224e-17, 0.01, 1, 0, 0, 6.93889e-18], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [9.71445e-17, -1.83623e-16, 0.2105, 2.77556e-17, 0.92388, 0.382683, 6.93889e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -1.11022e-16, -4.16334e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-1.21431e-17, 0.008, 0.045, 1, 0, 0, -2.42861e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [3.29597e-17, -0.008, 0.045, 1, 0, 0, -2.42861e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
rectprism_2(table): { pose: [-1.62119e-09, 0.1, 0.1275, 1, -4.6522e-11, -5.32241e-10, -1.61644e-09], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_2_Left(rectprism_2): { pose: [-0.026, 2.07733e-18, 0.016, 1, 0, -1.78296e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2_Right(rectprism_2): { pose: [0.026, -1.47167e-19, 0.016, 1, 0, -1.78296e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4(table): { pose: [-0.3008, -0.0565, 0.065, 0.491056, -0, -0, -0.871128], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_4_Left(rectprism_4): { pose: [-0.026, 1.21431e-17, 0.016, 1, 0, 0, 5.55112e-17], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4_Right(rectprism_4): { pose: [0.026, -8.67362e-18, 0.016, 1, 0, 0, 5.55112e-17], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1(table): { pose: [-3.76914e-13, 0.1, 0.0665, 1, -3.03684e-12, -1.3741e-13, -3.2015e-13], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1_Left(rectprism_1): { pose: [-0.026, -1.0644e-18, 0.016, 1, 0, -1.09625e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1_Right(rectprism_1): { pose: [0.026, -6.76663e-17, 0.016, 1, 0, -1.09625e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3(table): { pose: [0.3945, 0.15, 0.065, 0.866505, 0, 0, 0.499168], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_3_Left(rectprism_3): { pose: [-0.026, 2.60209e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3_Right(rectprism_3): { pose: [0.026, -2.60209e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
cube_3(table): { pose: [0.4125, -0.0519, 0.065, 0.840377, 0, 0, 0.542002], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [0.026, 0.1, 0.0975, 1, 1.56079e-11, 9.72314e-11, 6.82445e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [-0.3199, 0.0479, 0.065, 0.981644, 0, 0, 0.190723], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [-0.026, 0.1, 0.0975, 1, -3.24055e-12, 2.62704e-12, 1.33779e-12], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }