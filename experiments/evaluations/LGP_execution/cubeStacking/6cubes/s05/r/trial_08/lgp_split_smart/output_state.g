world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, -4.11616e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -2.77556e-16, 2.77556e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731818, -5.20417e-17, 1.73472e-17, -0.681501], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-5.6205e-16, -0.316, -8.46094e-16, 0.707107, 0.707107, 3.46945e-17, 1.11022e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-1.32143e-22, 2.25717e-17, 1.85347e-21, 1, -8.32667e-17, 0, -6.92296e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -5.48456e-16, -6.15827e-17, 0.707107, 0.707107, -5.55112e-17, -2.22045e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.29366e-16, 9.4944e-17, 8.16339e-17, 0.315287, 2.05565e-16, 0, -0.948996], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 1.16693e-15, 0.707107, -0.707107, 8.32667e-17, 1.11022e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [4.03757e-16, -1.65316e-16, -1.93024e-16, 1, -1.11022e-16, -5.55112e-17, 6.95872e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [9.64367e-22, 4.68917e-18, -7.1345e-22, 0.707107, 0.707107, 2.35922e-16, 2.91434e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.730947, -5.55112e-17, -8.32667e-17, 0.682434], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -6.17562e-16, 5.04386e-16, 0.707107, 0.707107, -2.08167e-16, -2.77556e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [3.00991e-21, 2.18602e-17, -4.71321e-21, 1, 2.77556e-17, 2.77556e-17, -0.000142482], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [9.71445e-17, 7.71647e-18, 0.107, 1, -4.16334e-17, -2.77556e-17, -4.26742e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [2.95273e-17, 3.90467e-18, -4.03592e-15, 1, 0, 1.38778e-17, 4.16334e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [7.79422e-22, -5.29226e-18, 1.14105e-21, 0.92388, -5.55112e-17, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, 2.77556e-17, 5.55112e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [2.42861e-17, 4.16334e-17, 0.0584, 1, 0, 1.38778e-17, -1.04083e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [2.42861e-17, 4.16334e-17, 0.0584, 1, 0, 1.38778e-17, -1.04083e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-4.25007e-17, 0.04, -2.18228e-15, 1, 0, 0, -1.38778e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [4.33681e-18, -0.04, 2.15626e-15, 1, 0, 0, -1.38778e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.75769e-17, 1.09751e-16, -2.21397e-16, -1.03428e-13, 0, 1.38778e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.06582e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 3.33067e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.66533e-16, 7.7293e-17, -0.15, 1, -8.32667e-17, 0, -1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [4.57967e-16, 0.02, -0.2, 1, -2.77556e-17, 0, 3.33067e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 8.32667e-17, 5.15321e-16, 5.20417e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-9.03274e-22, 2.06715e-21, 1.35864e-17, 1, -2.498e-16, 1.04083e-16, -1.66533e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.52068e-16, -4.20255e-16, -0.04, 1, -5.55112e-17, 5.55112e-17, -2.77556e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-2.1684e-17, -1.5808e-17, 0.01, 1, -4.16334e-17, -2.77556e-17, -4.26742e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.80411e-16, -2.16874e-17, 0.2105, 9.71445e-17, 0.92388, 0.382683, 5.55112e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, -2.77556e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.07553e-16, 0.008, 0.045, 1, 0, 0, -1.38778e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [1.02349e-16, -0.008, 0.045, 1, 0, 0, -1.38778e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
rectprism_9(table): { pose: [-0.3424, 0.0195, 0.065, 0.904492, 0, 0, 0.42649], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_9_Left(rectprism_9): { pose: [-0.026, -1.56125e-17, 0.016, 1, -0, 0, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_9_Right(rectprism_9): { pose: [0.026, 1.56125e-17, 0.016, 1, -0, 0, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3(table): { pose: [0.08, 0.1, 0.0665006, 1, -4.62289e-07, -4.44056e-08, -5.63739e-08], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_3_Left(rectprism_3): { pose: [-0.026, 4.57474e-19, 0.016, 1, -1.57772e-30, 2.9524e-23, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3_Right(rectprism_3): { pose: [0.026, 5.06568e-17, 0.016, 1, -1.57772e-30, 2.9524e-23, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_12(table): { pose: [-0.3276, -0.0855, 0.065, 0.0372542, 0, 0, 0.999306], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_12_Left(rectprism_12): { pose: [-0.026, 4.55365e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_12_Right(rectprism_12): { pose: [0.026, -4.55365e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2(table): { pose: [-3.88666e-13, 0.1, 0.0665, 1, -1.10021e-12, -2.53232e-13, -3.04664e-13], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_2_Left(rectprism_2): { pose: [-0.026, 7.65223e-17, 0.016, 1, 0, 1.05363e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2_Right(rectprism_2): { pose: [0.026, -4.67801e-18, 0.016, 1, 0, 1.05363e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4(table): { pose: [-0.0800006, 0.100001, 0.096503, 1, -5.32256e-06, -5.6827e-07, -1.10103e-06], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_4_Left(rectprism_4): { pose: [-0.026, -6.53581e-17, 0.016, 1, 8.47033e-22, 5.46125e-23, 2.11758e-22], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4_Right(rectprism_4): { pose: [0.026, 2.43053e-17, 0.016, 1, 8.47033e-22, 5.46125e-23, 2.11758e-22], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_5(table): { pose: [-2.88942e-13, 0.1, 0.0965, 1, -1.10033e-12, -1.20242e-13, -2.29458e-13], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_5_Left(rectprism_5): { pose: [-0.026, 4.69183e-19, 0.016, 1, 6.67478e-30, -6.75363e-29, 5.55112e-17], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_5_Right(rectprism_5): { pose: [0.026, -5.69385e-18, 0.016, 1, 6.67478e-30, -6.75363e-29, 5.55112e-17], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_7(table): { pose: [0.3854, 0.041, 0.065, 0.553537, -0, -0, -0.832825], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_7_Left(rectprism_7): { pose: [-0.026, -1.04083e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_7_Right(rectprism_7): { pose: [0.026, 1.38778e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_10(table): { pose: [0.3124, -0.0116, 0.065, 0.958621, 0, 0, 0.284685], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_10_Left(rectprism_10): { pose: [-0.026, 6.93889e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_10_Right(rectprism_10): { pose: [0.026, -1.04083e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_6(table): { pose: [0.0800005, 0.100002, 0.0965034, 1, -3.2811e-06, 4.9093e-07, 8.96106e-08], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_6_Left(rectprism_6): { pose: [-0.026, 3.84775e-17, 0.016, 1, 0, -3.0392e-23, 1.32349e-23], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_6_Right(rectprism_6): { pose: [0.026, -2.1479e-17, 0.016, 1, 0, -3.0392e-23, 1.32349e-23], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_11(table): { pose: [0.3711, -0.0883, 0.065, 0.562444, -0, -0, -0.826835], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_11_Left(rectprism_11): { pose: [-0.026, 1.73472e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_11_Right(rectprism_11): { pose: [0.026, -1.73472e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_8(table): { pose: [-0.4447, -0.0287, 0.065, 0.584816, 0, 0, 0.811166], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_8_Left(rectprism_8): { pose: [-0.026, 1.99493e-17, 0.016, 1, -0, 0, 5.55112e-17], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_8_Right(rectprism_8): { pose: [0.026, -1.9082e-17, 0.016, 1, -0, 0, 5.55112e-17], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1(table): { pose: [-0.08, 0.1, 0.0665, 1, -3.32315e-11, -1.13376e-10, -2.18183e-11], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1_Left(rectprism_1): { pose: [-0.026, 4.43312e-18, 0.016, 1, 0, 5.18015e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1_Right(rectprism_1): { pose: [0.026, 6.05942e-18, 0.016, 1, 0, 5.18015e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }