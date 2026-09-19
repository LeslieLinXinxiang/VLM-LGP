world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, -7.57953e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -5.55112e-17, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, 1.38778e-17, 8.67362e-18, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-2.74086e-16, -0.316, -6.90432e-16, 0.707107, 0.707107, -1.37043e-16, 5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-9.02683e-27, 8.41832e-18, 1.27294e-25, 1, 8.32667e-17, 0, 5.62881e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -4.8953e-16, -1.46584e-16, 0.707107, 0.707107, -5.55112e-17, -5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-4.75495e-25, -7.05917e-25, 4.66843e-17, 0.315322, -1.73472e-18, -2.77556e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 9.80141e-16, 0.707107, -0.707107, -9.71445e-17, -2.22045e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.86844e-16, -1.04427e-16, -1.19972e-16, 1, -8.32667e-17, -2.77556e-17, 7.45846e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [3.93008e-26, -1.71428e-17, 1.03174e-25, 0.707107, 0.707107, 1.52656e-16, 2.77556e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, 1.66533e-16, 0, 0.681638], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -4.3715e-16, 3.95575e-16, 0.707107, 0.707107, 6.93889e-17, 1.249e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-9.74312e-17, 6.27725e-17, -5.3227e-17, 1, 2.77556e-17, -6.93889e-17, 4.22484e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [4.85723e-17, -3.87387e-18, 0.107, 1, -1.38778e-17, 2.77556e-17, 3.98986e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.08417e-17, 1.29804e-17, -3.0303e-15, 1, -5.55112e-17, -1.38778e-17, 4.85723e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [6.33636e-29, 7.44463e-23, 1.3855e-31, 0.92388, 2.77556e-17, -5.55112e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -5.55112e-17, -2.77556e-17, 4.85723e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [6.93889e-18, -3.46945e-18, 0.0584, 1, 2.77556e-17, -1.38778e-17, 0] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [6.93889e-18, -3.46945e-18, 0.0584, 1, 2.77556e-17, -1.38778e-17, 0] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [9.97466e-17, 0.04, -1.75901e-15, 1, 0, 0, 0], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-8.67362e-19, -0.04, 1.34268e-15, 1, 0, 0, 0], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.71729e-17, 1.71729e-17, 4.51982e-26, -1.03379e-13, -1.38778e-17, 0, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 8.8818e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-5.0307e-17, 3.85993e-18, -0.15, 1, -5.55112e-17, -2.77556e-17, -2.22045e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [2.498e-16, 0.02, -0.2, 1, 5.55112e-17, -2.77556e-17, -5.55112e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 9.36751e-17, 1.97108e-16, -1.11022e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1.67927e-26, 5.87275e-27, 9.75781e-19, 1, -5.55112e-17, -2.98372e-16, -2.22045e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.50628e-16, -2.60581e-16, -0.04, 1, -2.77556e-17, 0, 8.32667e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-3.46945e-18, 5.40446e-18, 0.01, 1, -1.38778e-17, 2.77556e-17, 3.98986e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.52656e-16, -8.2593e-18, 0.2105, 4.16334e-17, 0.92388, 0.382683, 4.16334e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -5.55112e-17, 1.38778e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [7.45931e-17, 0.008, 0.045, 1, 0, 0, 0], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.73472e-18, -0.008, 0.045, 1, 0, 0, 0], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
cube_2(table): { pose: [0.08, 0.1, 0.0665, 1, 8.07716e-10, -1.6857e-09, -1.447e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [1.01728e-07, 0.1, 0.1265, 1, -1.67101e-09, 7.58317e-08, 9.00899e-08], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [-0.08, 0.1, 0.0665, 1, -1.02199e-09, -1.23906e-10, -3.83435e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1(table): { pose: [1.01615e-07, 0.1, 0.0965, 1, -1.60554e-09, 7.58259e-08, 8.99995e-08], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1_Left(rectprism_1): { pose: [-0.026, -1.07813e-17, 0.016, 1, 0, 1.69673e-24, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1_Right(rectprism_1): { pose: [0.026, 2.68584e-17, 0.016, 1, 0, 1.69673e-24, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
triprism_1(table): { pose: [1.03195e-07, 0.1, 0.1515, 1, -1.7573e-09, 7.61599e-08, 9.01787e-08], joint: rigid, shape: mesh, color: [0.9, 0.6, 0.1], mesh: "/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", contact: 1, mass: 0.2, inertia: [3.61846e-05, 3.20675e-05, 5.23466e-05], logical: { is_object: True, is_box: True } }