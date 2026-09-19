world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, 6.35539e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -3.33067e-16, 3.33067e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.73173, -7.11237e-17, -9.02056e-17, -0.681594], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-6.66134e-16, -0.316, -5.98692e-16, 0.707107, 0.707107, 2.46331e-16, -1.66533e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [7.86692e-18, 5.45433e-18, -1.10744e-16, 1, 0, -2.77556e-17, 8.09635e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -4.77711e-16, -4.33681e-17, 0.707107, 0.707107, -2.22045e-16, -1.66533e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-7.60554e-22, 3.82666e-21, 3.01815e-17, 0.315327, 7.89299e-17, 8.32667e-17, -0.948983], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 7.09105e-16, 0.707107, -0.707107, 0, -5.55112e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.86853e-16, -7.66537e-17, -1.19959e-16, 1, 2.77556e-17, -2.77556e-17, 3.8192e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-5.99732e-17, 1.48991e-17, -9.3427e-17, 0.707107, 0.707107, 8.32667e-17, -1.11022e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [5.59364e-26, 4.94059e-26, -4.23516e-22, 0.730886, 5.55112e-17, -4.16334e-17, 0.682499], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.1225e-16, 5.85101e-16, 0.707107, 0.707107, 6.93889e-17, -2.77556e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-9.73181e-17, 5.14317e-17, -5.34516e-17, 1, 1.249e-16, -2.77556e-17, -7.4479e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [3.46945e-17, -5.76592e-17, 0.107, 1, 2.77556e-17, -1.38778e-17, -9.36751e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [2.7959e-17, 5.58831e-17, -2.01128e-15, 1, -2.77556e-17, -1.38778e-17, 1.73472e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-2.43279e-17, -3.5434e-20, -1.33613e-17, 0.92388, 2.77556e-17, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -2.77556e-17, -1.38778e-17, -1.80411e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [3.81639e-17, 1.38778e-17, 0.0584, 1, 0, 1.38778e-17, 3.46945e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [3.81639e-17, 1.38778e-17, 0.0584, 1, 0, 1.38778e-17, 3.46945e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [3.46945e-18, 0.04, -9.66241e-16, 1, 0, 0, 0], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [5.55112e-17, -0.04, 5.23886e-16, 1, 0, 0, 0], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.00649e-16, 3.18036e-17, -2.67342e-17, -1.03424e-13, 0, 6.93889e-18, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.06582e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-1.16226e-16, 9.46471e-17, -0.15, 1, 0, -5.55112e-17, -1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [9.71445e-17, 0.02, -0.2, 1, 2.77556e-17, -5.55112e-17, -1.66533e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 1.73472e-17, 4.04082e-16, 1.00614e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 1.11022e-16, -6.93889e-18, -1.94289e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.75824e-16, -3.34686e-16, -0.04, 1, -1.38778e-16, -1.11022e-16, -2.77556e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [2.08167e-17, -6.20796e-18, 0.01, 1, 2.77556e-17, -1.38778e-17, -9.36751e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.66533e-16, -1.02846e-16, 0.2105, 1.38778e-17, 0.92388, 0.382683, 6.93889e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 5.55112e-17, 0], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [7.28584e-17, 0.008, 0.045, 1, 0, 0, 0], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-6.59195e-17, -0.008, 0.045, 1, 0, 0, 0], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
rectprism_5(table): { pose: [0.0399996, 0.0999971, 0.0965104, 1, -3.02035e-06, -3.04387e-06, 8.31254e-07], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_5_Left(rectprism_5): { pose: [-0.026, 1.34637e-17, 0.016, 1, 0, 1.04879e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_5_Right(rectprism_5): { pose: [0.026, -2.55262e-17, 0.016, 1, 0, 1.04879e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4(table): { pose: [-0.0399986, 0.0999781, 0.0965955, 1, -2.38567e-05, -7.99598e-07, -4.87595e-06], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_4_Left(rectprism_4): { pose: [-0.026, 8.57197e-18, 0.016, 1, 0, -4.44997e-23, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4_Right(rectprism_4): { pose: [0.026, -2.39636e-18, 0.016, 1, 0, -4.44997e-23, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_7(table): { pose: [-0.4454, -0.0724, 0.065, 0.613045, 0, 0, 0.790048], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_7_Left(rectprism_7): { pose: [-0.026, 1.9082e-17, 0.016, 1, -0, 0, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_7_Right(rectprism_7): { pose: [0.026, -2.08167e-17, 0.016, 1, -0, 0, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3(table): { pose: [0.08, 0.1, 0.0665, 1, -4.71103e-11, -2.22946e-11, -2.3929e-11], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_3_Left(rectprism_3): { pose: [-0.026, 2.82224e-18, 0.016, 1, 0, 5.96632e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3_Right(rectprism_3): { pose: [0.026, -1.59872e-18, 0.016, 1, 0, 5.96632e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_8(table): { pose: [0.3079, 0.0559, 0.065, 0.160398, 0, 0, 0.987052], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_8_Left(rectprism_8): { pose: [-0.026, -1.73472e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_8_Right(rectprism_8): { pose: [0.026, 1.73472e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_6(table): { pose: [0.4432, -0.0011, 0.065, 0.848787, 0, 0, 0.528735], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_6_Left(rectprism_6): { pose: [-0.026, 5.20417e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_6_Right(rectprism_6): { pose: [0.026, -5.20417e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2(table): { pose: [-1.57829e-10, 0.1, 0.0665, 1, 3.9159e-09, 2.027e-10, -1.38687e-10], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_2_Left(rectprism_2): { pose: [-0.026, -8.10114e-17, 0.016, 1, 0, -2.54681e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2_Right(rectprism_2): { pose: [0.026, 1.62615e-18, 0.016, 1, 0, -2.54681e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_10(table): { pose: [0.3479, -0.0983, 0.065, 0.224016, -0, -0, -0.974585], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_10_Left(rectprism_10): { pose: [-0.026, -5.37764e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_10_Right(rectprism_10): { pose: [0.026, 5.37764e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_9(table): { pose: [-0.3556, -0.002, 0.065, 0.546614, -0, -0, -0.837385], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_9_Left(rectprism_9): { pose: [-0.026, -2.60209e-17, 0.016, 1, 0, 0, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_9_Right(rectprism_9): { pose: [0.026, 2.94903e-17, 0.016, 1, 0, 0, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1(table): { pose: [-0.08, 0.1, 0.0665, 1, 3.46412e-09, 3.57019e-11, 2.27943e-10], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1_Left(rectprism_1): { pose: [-0.026, 1.96686e-18, 0.016, 1, 0, -2.99339e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1_Right(rectprism_1): { pose: [0.026, -1.90349e-17, 0.016, 1, 0, -2.99339e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
triprism_2(table): { pose: [-0.3016, -0.0942, 0.065, 0.468701, -0, -0, -0.883357], joint: rigid, shape: mesh, color: [0.9, 0.6, 0.1], mesh: "/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", contact: 1, mass: 0.2, inertia: [3.61846e-05, 3.20675e-05, 5.23466e-05], logical: { is_object: True, is_box: True } }
triprism_1(table): { pose: [-0.08, 0.1, 0.0615, 1, -3.41951e-10, -4.34049e-10, -1.71607e-11], joint: rigid, shape: mesh, color: [0.9, 0.6, 0.1], mesh: "/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", contact: 1, mass: 0.2, inertia: [3.61846e-05, 3.20675e-05, 5.23466e-05], logical: { is_object: True, is_box: True } }