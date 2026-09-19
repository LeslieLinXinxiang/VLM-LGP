world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, 0.000100059], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 2.77556e-16, -2.77556e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731775, 1.21431e-17, -1.12757e-16, -0.681546], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-5.75928e-16, -0.316, -9.90674e-16, 0.707107, 0.707107, -7.45931e-17, -1.66533e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [7.88155e-18, 8.42101e-18, -1.10744e-16, 1, 5.55112e-17, -2.77556e-17, 5.26872e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -5.08501e-16, 1.24033e-16, 0.707107, 0.707107, 1.11022e-16, 1.66533e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-7.88526e-18, 1.10749e-16, 3.20219e-17, 0.315249, -4.33681e-18, 8.32667e-17, -0.949009], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 1.72788e-15, 0.707107, -0.707107, 2.91434e-16, 1.66533e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [2.99726e-17, -4.95121e-17, 4.67118e-17, 1, 5.55112e-17, 1.11022e-16, 5.07803e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [9.43825e-22, 2.79385e-17, 6.46745e-21, 0.707107, 0.707107, 4.16334e-17, -8.32667e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.730196, 5.55112e-17, 2.77556e-17, 0.683238], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -6.52256e-16, 6.17072e-16, 0.707107, 0.707107, -3.747e-16, 2.498e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-9.72329e-17, 5.82387e-17, -5.36142e-17, 1, -2.77556e-17, -2.77556e-17, -0.000156351], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [1.11022e-16, -4.14741e-17, 0.107, 1, 0, 4.16334e-17, -1.63064e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.51513e-16, 2.7408e-17, -4.98784e-15, 1, 0, 1.38778e-17, 3.46945e-18] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [3.69931e-24, -6.77626e-21, 1.24298e-25, 0.92388, -5.55112e-17, -2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -5.55112e-17, 2.77556e-17, 2.35922e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-3.46945e-18, -1.73472e-17, 0.0584, 1, 0, 0, -5.55112e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-3.46945e-18, -1.73472e-17, 0.0584, 1, 0, 0, -5.55112e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [5.20417e-18, 0.04, -2.81372e-15, 1, 0, -1.38778e-17, 3.46945e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [1.82146e-17, -0.04, 2.34361e-15, 1, 0, -1.38778e-17, 3.46945e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-8.83545e-17, 1.95512e-17, -2.68079e-17, -1.03348e-13, 1.38778e-17, -6.93889e-18, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.4211e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, -3.33067e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.85615e-16, 1.42568e-16, -0.15, 1, -2.77556e-17, -5.55112e-17, 5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.11022e-16, 0.02, -0.2, 1, 5.55112e-17, 5.55112e-17, -1.66533e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 2.81025e-16, 7.04731e-17, -2.22045e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1.60577e-22, 1.57333e-21, -6.79659e-18, 1, 1.66533e-16, 2.22045e-16, 5.55112e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [3.70417e-16, -1.79948e-16, -0.04, 1, -8.32667e-17, -5.55112e-17, -2.22045e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [4.68375e-17, -5.28803e-18, 0.01, 1, 0, 4.16334e-17, -1.63064e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.80411e-16, -7.1781e-17, 0.2105, 1.38778e-17, 0.92388, 0.382683, 1.38778e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 2.77556e-17, -1.04083e-16], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.5439e-16, 0.008, 0.045, 1, 0, 0, 6.93889e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-3.1225e-17, -0.008, 0.045, 1, 0, 0, 6.93889e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
rectprism_2(table): { pose: [3.41608e-12, 0.1, 0.0665, 1, 3.45339e-12, 4.65981e-12, 2.38094e-12], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_2_Left(rectprism_2): { pose: [-0.026, 1.86684e-17, 0.016, 1, 0, -2.16331e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2_Right(rectprism_2): { pose: [0.026, -1.93571e-17, 0.016, 1, 0, -2.16331e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_11(table): { pose: [0.254, 0.0536, 0.065, 0.897412, -0, -0, -0.441193], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_11_Left(rectprism_11): { pose: [-0.026, -6.93889e-18, 0.016, 1, 0, 0, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_11_Right(rectprism_11): { pose: [0.026, 1.21431e-17, 0.016, 1, 0, 0, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3(table): { pose: [0.08, 0.1, 0.0665002, 1, -1.63852e-07, 3.78884e-08, 9.92516e-09], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_3_Left(rectprism_3): { pose: [-0.026, -1.00346e-18, 0.016, 1, 0, -2.51164e-24, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3_Right(rectprism_3): { pose: [0.026, 6.72621e-17, 0.016, 1, 0, -2.51164e-24, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_12(table): { pose: [0.4113, -0.1315, 0.065, 0.937404, -0, -0, -0.348245], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_12_Left(rectprism_12): { pose: [-0.026, 2.25514e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_12_Right(rectprism_12): { pose: [0.026, -1.21431e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_13(table): { pose: [-0.4022, -0.1428, 0.065, 0.256795, -0, -0, -0.966466], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_13_Left(rectprism_13): { pose: [-0.026, -1.73472e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_13_Right(rectprism_13): { pose: [0.026, 1.73472e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_8(table): { pose: [-0.0800001, 0.100001, 0.0665016, 1, -1.39536e-06, -2.82819e-07, 1.57955e-08], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_8_Left(rectprism_8): { pose: [-0.026, 6.21898e-18, 0.016, 1, 4.23516e-22, 1.24208e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_8_Right(rectprism_8): { pose: [0.026, -7.02634e-18, 0.016, 1, 4.23516e-22, 1.24208e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_5(table): { pose: [-7.4813e-12, 0.1, 0.0965, 1, 3.62601e-12, -9.07391e-12, -5.97882e-12], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_5_Left(rectprism_5): { pose: [-0.026, 5.57639e-18, 0.016, 1, 0, 3.02642e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_5_Right(rectprism_5): { pose: [0.026, -5.30412e-18, 0.016, 1, 0, 3.02642e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1(table): { pose: [-0.08, 0.1, 0.0665, 1, 1.1074e-12, -5.37255e-12, -3.82913e-13], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1_Left(rectprism_1): { pose: [-0.026, 1.2098e-16, 0.016, 1, 0, 5.37664e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1_Right(rectprism_1): { pose: [0.026, 3.65822e-18, 0.016, 1, 0, 5.37664e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_9(table): { pose: [0.498, 0.2251, 0.065, 0.980768, -0, -0, -0.195176], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_9_Left(rectprism_9): { pose: [-0.026, 6.93889e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_9_Right(rectprism_9): { pose: [0.026, 1.38778e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_15(table): { pose: [-0.2617, -0.2313, 0.065, 0.616349, -0, -0, -0.787473], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_15_Left(rectprism_15): { pose: [-0.026, 1.73472e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_15_Right(rectprism_15): { pose: [0.026, -1.73472e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_14(table): { pose: [0.2868, -0.2091, 0.065, 0.403785, -0, -0, -0.914854], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_14_Left(rectprism_14): { pose: [-0.026, -6.93889e-18, 0.016, 1, 0, 0, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_14_Right(rectprism_14): { pose: [0.026, 6.93889e-18, 0.016, 1, 0, 0, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_16(table): { pose: [-0.234, -0.1412, 0.065, 0.977416, -0, -0, -0.211325], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_16_Left(rectprism_16): { pose: [-0.026, 6.93889e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_16_Right(rectprism_16): { pose: [0.026, 3.46945e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_6(table): { pose: [0.08, 0.1, 0.0965002, 1, -1.63852e-07, 3.78887e-08, 9.9268e-09], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_6_Left(rectprism_6): { pose: [-0.026, -1.3892e-17, 0.016, 1, 0, 1.41088e-24, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_6_Right(rectprism_6): { pose: [0.026, 3.85131e-17, 0.016, 1, 0, 1.41088e-24, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4(table): { pose: [-0.08, 0.1, 0.0965, 1, -4.88039e-12, -7.5614e-11, -2.52522e-11], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_4_Left(rectprism_4): { pose: [-0.026, 5.16597e-17, 0.016, 1, 0, 3.59778e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4_Right(rectprism_4): { pose: [0.026, -1.32516e-16, 0.016, 1, 0, 3.59778e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_7(table): { pose: [-0.0800001, 0.100001, 0.0665012, 1, -1.26118e-06, -2.54842e-07, -1.06958e-09], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_7_Left(rectprism_7): { pose: [-0.026, 2.09839e-17, 0.016, 1, -4.93038e-32, 6.0429e-23, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_7_Right(rectprism_7): { pose: [0.026, -2.05351e-17, 0.016, 1, -4.93038e-32, 6.0429e-23, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_10(table): { pose: [0.3853, -0.0085, 0.065, 0.702464, -0, -0, -0.71172], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_10_Left(rectprism_10): { pose: [-0.026, -1.06252e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_10_Right(rectprism_10): { pose: [0.026, 1.0571e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }