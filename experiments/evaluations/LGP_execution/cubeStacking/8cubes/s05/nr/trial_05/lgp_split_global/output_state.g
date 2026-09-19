world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, -0.000544438], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.741458, 6.245e-17, -3.46945e-17, -0.670999], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-7.97973e-16, -0.316, -2.40596e-16, 0.707107, 0.707107, -3.29597e-16, 0] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-9.92787e-22, 9.1615e-18, 9.92621e-21, 0.999998, 1.38778e-16, 2.77556e-17, -0.00174695], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -5.83247e-16, -1.52656e-16, 0.707107, 0.707107, 1.11022e-16, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [4.56465e-20, -1.37293e-20, 1.26715e-17, 0.308821, -1.01481e-16, -2.77556e-17, -0.95112], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 6.45209e-16, 0.707107, -0.707107, 2.63678e-16, 3.88578e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [2.61879e-20, 1.14925e-17, -3.43968e-20, 1, 1.66533e-16, -8.32667e-17, 0.000144691], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [1.67058e-21, 6.50516e-19, -1.94699e-21, 0.707107, 0.707107, 1.52656e-16, 2.498e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.690904, 1.11022e-16, -4.16334e-17, 0.722947], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.46945e-16, 7.59104e-16, 0.707107, 0.707107, 4.16334e-16, 5.55112e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [2.32872e-17, -8.70937e-18, 1.50816e-17, 1, -5.55112e-17, 0, -0.000966116], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [2.77556e-17, 9.21572e-18, 0.107, 1, 5.55112e-17, 0, -6.93889e-18] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.58321e-17, 8.11139e-18, -2.63325e-15, 1, 0, 0, -1.38778e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -2.77556e-17, -2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 2.77556e-17, 2.77556e-17, -1.07553e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [6.93889e-18, 1.73472e-17, 0.0584, 1, 2.77556e-17, -1.38778e-17, 0] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [6.93889e-18, 1.73472e-17, 0.0584, 1, 2.77556e-17, -1.38778e-17, 0] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-1.21431e-17, 0.04, -1.46758e-15, 1, 2.77556e-17, -1.38778e-17, 0], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [1.56125e-17, -0.04, 1.46758e-15, 1, 2.77556e-17, -1.38778e-17, 0], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [9.80151e-18, -9.82457e-18, 3.37207e-20, -1.034e-13, -4.16334e-17, -3.46945e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.4211e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.78677e-16, 6.69834e-17, -0.15, 1, -8.32667e-17, 8.32667e-17, -5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [2.77556e-16, 0.02, -0.2, 1, 0, 2.77556e-17, 3.88578e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -1.38778e-16, -1.01915e-17, -1.38778e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [2.15865e-20, -2.8353e-20, -9.47315e-18, 1, -2.22045e-16, 3.1225e-16, 1.94289e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-9.35124e-18, -6.46699e-16, -0.04, 1, -8.32667e-17, 3.88578e-16, 3.88578e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-9.54098e-18, 4.28937e-18, 0.01, 1, 5.55112e-17, 0, -6.93889e-18], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [8.32667e-17, 9.21572e-18, 0.2105, 9.71445e-17, 0.92388, 0.382683, 5.55112e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -5.55112e-17, -2.08167e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.04083e-17, 0.008, 0.045, 1, 2.77556e-17, -1.38778e-17, 0], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [3.1225e-17, -0.008, 0.045, 1, 2.77556e-17, -1.38778e-17, 0], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
rectprism_6(table): { pose: [0.08, 0.1, 0.0965, 1, 1.38331e-09, -1.89648e-09, 7.21874e-10], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_6_Left(rectprism_6): { pose: [-0.026, -1.56041e-17, 0.016, 1, 0, 1.92334e-25, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_6_Right(rectprism_6): { pose: [0.026, 2.10506e-17, 0.016, 1, 0, 1.92334e-25, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4(table): { pose: [-0.08, 0.1, 0.0965, 1, 4.42452e-10, 4.59968e-10, 2.6818e-11], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_4_Left(rectprism_4): { pose: [-0.026, -5.88306e-17, 0.016, 1, 0, -2.13559e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4_Right(rectprism_4): { pose: [0.026, 5.46974e-17, 0.016, 1, 0, -2.13559e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_8(table): { pose: [-0.0800001, 0.100001, 0.0665013, 1, -1.34712e-06, -2.62609e-07, 5.72913e-11], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_8_Left(rectprism_8): { pose: [-0.026, 1.7149e-17, 0.016, 1, 3.08149e-33, 5.09057e-23, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_8_Right(rectprism_8): { pose: [0.026, -4.14305e-18, 0.016, 1, 3.08149e-33, 5.09057e-23, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3(table): { pose: [0.08, 0.1, 0.0665, 1, 2.37749e-09, -1.70652e-09, 9.04363e-10], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_3_Left(rectprism_3): { pose: [-0.026, -6.62802e-17, 0.016, 1, 0, 5.48086e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3_Right(rectprism_3): { pose: [0.026, 2.4294e-18, 0.016, 1, 0, 5.48086e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_7(table): { pose: [-0.08, 0.1, 0.0665, 1, 2.03896e-09, -2.67146e-10, 1.44528e-10], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_7_Left(rectprism_7): { pose: [-0.026, -9.19303e-18, 0.016, 1, 3.7074e-26, 7.15129e-26, 1.38778e-16], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_7_Right(rectprism_7): { pose: [0.026, -1.84041e-19, 0.016, 1, 3.7074e-26, 7.15129e-26, 1.38778e-16], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_5(table): { pose: [4.20032e-11, 0.1, 0.0965, 1, -6.91683e-11, -1.2237e-11, 3.65401e-11], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_5_Left(rectprism_5): { pose: [-0.026, -6.48513e-17, 0.016, 1, 0, -1.64504e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_5_Right(rectprism_5): { pose: [0.026, 2.65072e-18, 0.016, 1, 0, -1.64504e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1(table): { pose: [-0.08, 0.1, 0.0665, 1, 8.52272e-10, 1.46431e-10, 4.03396e-11], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1_Left(rectprism_1): { pose: [-0.026, 1.20857e-16, 0.016, 1, 0, -3.02349e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1_Right(rectprism_1): { pose: [0.026, 2.18719e-18, 0.016, 1, 0, -3.02349e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2(table): { pose: [-3.09423e-13, 0.1, 0.0665, 1, -3.10993e-12, -6.13411e-14, -2.73611e-13], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_2_Left(rectprism_2): { pose: [-0.026, 1.06947e-17, 0.016, 1, 0, 1.50865e-30, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2_Right(rectprism_2): { pose: [0.026, -1.09819e-17, 0.016, 1, 0, 1.50865e-30, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }