world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, -3.30211e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 5.55112e-17, -5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, 6.93889e-18, 1.16226e-16, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-6.66134e-16, -0.316, -7.74298e-16, 0.707107, 0.707107, 3.88578e-16, 0] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-1.90857e-27, 4.08553e-18, 2.69141e-26, 1, -5.55112e-17, 2.77556e-17, 6.4594e-10], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -5.72094e-16, 1.99493e-17, 0.707107, 0.707107, -5.55112e-17, -1.11022e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-1.69245e-27, -1.35188e-26, 2.05214e-18, 0.315322, 6.67869e-17, -2.77556e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 8.35584e-16, 0.707107, -0.707107, 2.08167e-16, 3.88578e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.12551e-25, -2.44503e-17, 1.16972e-25, 1, -1.38778e-16, -2.77556e-17, 2.39759e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-1.20088e-28, -6.25701e-19, 2.99341e-27, 0.707107, 0.707107, 2.63678e-16, 1.38778e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, -5.55112e-17, 5.55112e-17, 0.681638], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -4.02456e-16, 8.7248e-16, 0.707107, 0.707107, -2.35922e-16, 2.63678e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [4.87156e-17, -2.41081e-17, 2.66135e-17, 1, 2.77556e-17, 8.32667e-17, 3.89422e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [6.245e-17, -8.24053e-18, 0.107, 1, 0, 1.38778e-17, 3.7817e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-2.25389e-17, 1.15246e-17, -2.79552e-15, 1, -1.38778e-17, 1.38778e-17, 3.7817e-16] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-2.35897e-28, -3.01042e-22, 1.59511e-31, 0.92388, 0, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, 2.77556e-17, 1.04083e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [1.73472e-17, 1.38778e-17, 0.0584, 1, 0, 0, 6.93889e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [1.73472e-17, 1.38778e-17, 0.0584, 1, 0, 0, 6.93889e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [5.55112e-17, 0.04, -1.76942e-15, 1, 0, 0, 6.93889e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-6.245e-17, -0.04, 1.76942e-15, 1, 0, 0, 6.93889e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-6.14331e-17, -7.46105e-18, -2.66135e-17, -1.03428e-13, -1.38778e-17, 0, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.4211e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-1.52656e-16, 6.37081e-17, -0.15, 1, -8.32667e-17, -2.77556e-17, -2.77556e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [4.30211e-16, 0.02, -0.2, 1, 5.55112e-17, -2.77556e-17, 2.22045e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 1.63064e-16, 3.56703e-16, 9.02056e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-6.28847e-26, -6.5355e-26, -1.36609e-17, 1, 1.38778e-16, 1.38778e-17, 1.38778e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.43197e-16, -5.74987e-16, -0.04, 1, -1.66533e-16, -1.11022e-16, 2.498e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [3.03577e-17, -7.69923e-18, 0.01, 1, 0, 1.38778e-17, 3.7817e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [8.32667e-17, -2.11092e-17, 0.2105, 4.16334e-17, 0.92388, 0.382683, 2.77556e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, -3.46945e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [9.19403e-17, 0.008, 0.045, 1, 0, 0, 6.93889e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-5.0307e-17, -0.008, 0.045, 1, 0, 0, 6.93889e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
cube_2(table): { pose: [0.026, 0.1, 0.1275, 1, -2.03642e-09, 1.74389e-10, 5.8748e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [-0.026, 0.1, 0.1275, 1, -2.01339e-09, -8.47794e-11, -4.73003e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_4(table): { pose: [-6.08621e-10, 0.1, 0.0965, 1, -2.10611e-09, -1.8891e-10, -5.39006e-10], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_4_Left(rectprism_4): { pose: [-0.026, 1.73952e-17, 0.016, 1, 0, 4.39963e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4_Right(rectprism_4): { pose: [0.026, -1.79606e-17, 0.016, 1, 0, 4.39963e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3(table): { pose: [0.08, 0.1, 0.0665, 1, 5.24218e-09, -1.11322e-09, 1.40763e-10], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_3_Left(rectprism_3): { pose: [-0.026, 4.52738e-18, 0.016, 1, 0, -9.36517e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3_Right(rectprism_3): { pose: [0.026, -1.57415e-18, 0.016, 1, 0, -9.36517e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1(table): { pose: [-0.08, 0.1, 0.0665, 1, 3.44056e-09, 1.2876e-09, -2.29279e-10], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1_Left(rectprism_1): { pose: [-0.026, -4.40625e-21, 0.016, 1, 0, 7.95467e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1_Right(rectprism_1): { pose: [0.026, 6.23445e-18, 0.016, 1, 0, 7.95467e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2(table): { pose: [6.44482e-11, 0.1, 0.0665, 1, 6.65176e-10, -1.20911e-11, 5.92965e-11], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_2_Left(rectprism_2): { pose: [-0.026, -1.2324e-17, 0.016, 1, 0, 4.39269e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2_Right(rectprism_2): { pose: [0.026, 1.21389e-16, 0.016, 1, 0, 4.39269e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_5(table): { pose: [7.56116e-07, 0.0999998, 0.1575, 1, 2.26198e-09, 1.79269e-06, 6.26184e-07], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_5_Left(rectprism_5): { pose: [-0.026, 2.73465e-16, 0.016, 1, 0, -9.8638e-24, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_5_Right(rectprism_5): { pose: [0.026, -2.36352e-16, 0.016, 1, 0, -9.8638e-24, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
triprism_1(table): { pose: [7.56122e-07, 0.0999998, 0.1825, 1, 2.25828e-09, 1.79267e-06, 6.26182e-07], joint: rigid, shape: mesh, color: [0.9, 0.6, 0.1], mesh: "/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", contact: 1, mass: 0.2, inertia: [3.61846e-05, 3.20675e-05, 5.23466e-05], logical: { is_object: True, is_box: True } }