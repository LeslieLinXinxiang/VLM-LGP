world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, -0.000176534], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731677, 1.04083e-17, -4.51028e-17, -0.681651], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [1.38778e-16, -0.316, -8.07745e-16, 0.707107, 0.707107, -2.25514e-17, 0] }
l_panda_joint3(l_panda_joint3_origin): { pose: [7.84944e-18, 5.73126e-18, -1.10742e-16, 1, -2.77556e-17, -8.32667e-17, 0.000192518], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.78599e-16, -2.41127e-16, 0.707107, 0.707107, -2.22045e-16, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.21503e-16, -1.57131e-17, 3.9461e-17, 0.315209, 1.42247e-16, -1.11022e-16, -0.949022], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 5.07718e-16, 0.707107, -0.707107, -5.55112e-17, 5.55112e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.86924e-16, -1.11154e-16, -1.19926e-16, 1, 2.77556e-17, 5.55112e-17, 0.000193049], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-2.99867e-17, 3.0053e-17, -4.67191e-17, 0.707107, 0.707107, 1.38778e-17, 1.66533e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.73168, -5.55112e-17, -8.32667e-17, 0.681648], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.05311e-16, 4.18886e-16, 0.707107, 0.707107, 9.71445e-17, -4.16334e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.46154e-16, 9.22038e-17, -7.98045e-17, 1, 2.77556e-17, 4.16334e-17, -0.000193179], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [1.11022e-16, -2.32663e-17, 0.107, 1, -4.16334e-17, 1.38778e-17, 1.73472e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [7.72047e-18, 2.2149e-17, -2.27272e-15, 1, 1.38778e-17, 0, 2.08167e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-6.11779e-21, 1.96241e-17, 2.12185e-21, 0.92388, 2.77556e-17, -2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, 0, 1.17961e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [6.93889e-17, 1.73472e-17, 0.0584] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [6.93889e-17, 1.73472e-17, 0.0584] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-2.60209e-17, 0.04, -1.51094e-15], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [7.89299e-17, -0.04, 1.06859e-15], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.44873e-16, 7.59037e-17, -2.65879e-17, -1.0349e-13, 0, -6.93889e-18, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.06582e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-3.07046e-16, 2.91014e-16, -0.15, 1, 8.32667e-17, -5.55112e-17, -1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.47105e-15, 0.02, -0.2, 1, 1.11022e-16, -2.22045e-16, 2.22045e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -3.46945e-17, -3.03577e-18, -1.249e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -5.55112e-17, -9.71445e-17, 1.11022e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [6.25818e-17, -4.73391e-16, -0.04, 1, -2.77556e-17, 0, 8.32667e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [4.33681e-17, -1.28283e-18, 0.01, 1, -4.16334e-17, 1.38778e-17, 1.73472e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.11022e-16, -7.56976e-17, 0.2105, 8.32667e-17, 0.92388, 0.382683, 1.38778e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 1.11022e-16, 1.04083e-16], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.1684e-16, 0.008, 0.045], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.45717e-16, -0.008, 0.045], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
rectprism_3(table): { pose: [0.08, 0.1, 0.0665, 1, 2.47236e-12, -2.68333e-12, -3.61226e-12], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_3_Left(rectprism_3): { pose: [-0.026, 1.04675e-17, 0.016, 1, 0, 1.58543e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3_Right(rectprism_3): { pose: [0.026, -1.39641e-17, 0.016, 1, 0, 1.58543e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4(table): { pose: [-0.0403052, 0.100184, 0.098269, 1, -9.46804e-05, -0.000544857, -9.62979e-05], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_4_Left(rectprism_4): { pose: [-0.026, 1.86453e-17, 0.016, 1, -4.06774e-20, -2.99919e-20, -4.06576e-20], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4_Right(rectprism_4): { pose: [0.026, -2.19225e-17, 0.016, 1, -4.06774e-20, -2.99919e-20, -4.06576e-20], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2(table): { pose: [-2.34528e-13, 0.1, 0.0665, 1, -4.25194e-14, -1.28714e-13, -2.16966e-13], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_2_Left(rectprism_2): { pose: [-0.026, -1.88107e-19, 0.016, 1, 0, 1.13688e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2_Right(rectprism_2): { pose: [0.026, -1.00708e-18, 0.016, 1, 0, 1.13688e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1(table): { pose: [-0.08, 0.1, 0.0665, 1, -7.87776e-12, -9.84427e-11, -1.25498e-10], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1_Left(rectprism_1): { pose: [-0.026, -3.36608e-18, 0.016, 1, 0, -5.72858e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1_Right(rectprism_1): { pose: [0.026, 6.75635e-18, 0.016, 1, 0, -5.72858e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_5(table): { pose: [0.0400007, 0.0999998, 0.0965007, 1, -1.40615e-07, 4.04331e-07, 7.33356e-07], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_5_Left(rectprism_5): { pose: [-0.026, 1.42593e-17, 0.016, 1, 6.09894e-23, -8.56612e-23, 1.11022e-16], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_5_Right(rectprism_5): { pose: [0.026, -5.49381e-17, 0.016, 1, 6.09894e-23, -8.56612e-23, 1.11022e-16], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
triprism_1(table): { pose: [-0.08, 0.1, 0.0615, 1, -5.99245e-10, -1.50007e-09, -2.95064e-10], joint: rigid, shape: mesh, color: [0.9, 0.6, 0.1], mesh: "/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", contact: 1, mass: 0.2, inertia: [3.61846e-05, 3.20675e-05, 5.23466e-05], logical: { is_object: True, is_box: True } }