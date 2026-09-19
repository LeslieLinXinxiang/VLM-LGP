world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, 2.4433e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731689, 2.60209e-17, -2.77556e-17, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-1.14492e-16, -0.316, -1.04609e-15, 0.707107, 0.707107, 6.41848e-17, 1.11022e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [4.89737e-26, 1.41682e-17, -6.90608e-25, 1, 0, 2.77556e-17, -6.62642e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.78241e-16, 1.24033e-16, 0.707107, 0.707107, -5.55112e-17, 5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.29342e-16, 9.50376e-17, 6.43879e-17, 0.315322, 2.1684e-17, -2.77556e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 1.51749e-15, 0.707107, -0.707107, -1.249e-16, 3.33067e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [4.03681e-16, -2.13389e-16, -1.93232e-16, 1, 2.77556e-17, -2.77556e-17, 1.17031e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-7.10986e-27, -4.5581e-20, 1.74098e-27, 0.707107, 0.707107, -5.55112e-17, -1.249e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, 0, -8.32667e-17, 0.681638], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -8.25728e-16, 3.79098e-16, 0.707107, 0.707107, 8.32667e-17, 3.60822e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.94863e-16, 1.63436e-16, -1.06454e-16, 1, 9.71445e-17, 4.16334e-17, 5.17835e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [1.04083e-16, -8.98859e-17, 0.107, 1, 1.38778e-17, 4.16334e-17, -6.59195e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.29025e-16, 8.4085e-17, -4.23083e-15, 1, 1.38778e-17, -1.38778e-17, -6.93889e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 5.55112e-17, 2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 5.55112e-17, -4.16334e-17, 1.45717e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [6.245e-17, 1.38778e-17, 0.0584, 1, -2.77556e-17, 2.77556e-17, -2.08167e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [6.245e-17, 1.38778e-17, 0.0584, 1, -2.77556e-17, 2.77556e-17, -2.08167e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [1.17094e-16, 0.04, -2.46678e-15, 1, 0, 0, -2.42861e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [3.64292e-17, -0.04, 1.60635e-15, 1, 0, 0, -2.42861e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.08045e-16, 3.91512e-17, -2.66135e-17, -1.03403e-13, 0, -2.77556e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 8.8818e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-7.97973e-17, -3.94019e-17, -0.15, 1, -2.77556e-17, 0, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [5.13478e-16, 0.02, -0.2, 1, 1.11022e-16, 2.77556e-17, 0], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 2.77556e-17, 1.661e-16, 1.80411e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 1.11022e-16, 9.02056e-17, 1.38778e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [4.11042e-16, 1.23645e-16, -0.04, 1, -8.32667e-17, -5.55112e-17, 1.66533e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-3.98986e-17, -7.50769e-18, 0.01, 1, 1.38778e-17, 4.16334e-17, -6.59195e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [6.93889e-17, -1.71031e-16, 0.2105, -2.77556e-17, 0.92388, 0.382683, 4.16334e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 2.77556e-17, -6.93889e-18], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.19696e-16, 0.008, 0.045, 1, 0, 0, -2.42861e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-6.59195e-17, -0.008, 0.045, 1, 0, 0, -2.42861e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
longrect_2(table): { pose: [-0.4016, 0.0313, 0.065, 0.895595, 0, 0, 0.44487], joint: rigid, shape: ssBox, size: [0.095, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.6, inertia: [0.00108, 0.005955, 0.005955], logical: { is_object: True, is_box: True, is_place: True } }
longrect_2_Left(longrect_2): { pose: [-0.038, -3.46945e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_2_Right(longrect_2): { pose: [0.038, 6.93889e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_2_Center(longrect_2): { pose: [0, 0, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_1(table): { pose: [-1.389e-08, 0.1, 0.0665003, 1, -3.28871e-07, 2.19154e-08, -1.41729e-08], joint: rigid, shape: ssBox, size: [0.095, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.6, inertia: [0.00108, 0.005955, 0.005955], logical: { is_object: True, is_box: True, is_place: True } }
longrect_1_Left(longrect_1): { pose: [-0.038, 4.13584e-18, 0.016, 1, 0, -1.38362e-24, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_1_Right(longrect_1): { pose: [0.038, 6.33982e-17, 0.016, 1, 0, -1.38362e-24, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_1_Center(longrect_1): { pose: [-1.75776e-23, 6.01143e-18, 0.016, 1, 0, -1.38362e-24, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3(table): { pose: [-0.3343, -0.0423, 0.065, 0.619505, -0, -0, -0.784993], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_3_Left(rectprism_3): { pose: [-0.026, -2.42861e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3_Right(rectprism_3): { pose: [0.026, 2.25514e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1(table): { pose: [-1.38882e-08, 0.1, 0.0965003, 1, -3.28872e-07, 2.19064e-08, -1.4172e-08], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1_Left(rectprism_1): { pose: [-0.026, -1.36796e-17, 0.016, 1, 0, 5.33637e-25, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1_Right(rectprism_1): { pose: [0.026, -5.32164e-17, 0.016, 1, 0, 5.33637e-25, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2(table): { pose: [-1.71661e-07, 0.0999989, 0.157503, 1, -1.16684e-06, 8.42993e-07, -2.71262e-07], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_2_Left(rectprism_2): { pose: [-0.026, -1.54521e-18, 0.016, 1, 0, -1.18796e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2_Right(rectprism_2): { pose: [0.026, -7.71951e-19, 0.016, 1, 0, -1.18796e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4(table): { pose: [0.3056, -0.0711, 0.065, 0.988938, 0, 0, 0.148327], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_4_Left(rectprism_4): { pose: [-0.026, -6.93889e-18, 0.016, 1, -0, 0, -1.38778e-16], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4_Right(rectprism_4): { pose: [0.026, 6.93889e-18, 0.016, 1, -0, 0, -1.38778e-16], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
cube_4(table): { pose: [0.3055, 0.0177, 0.065, 0.816994, 0, 0, 0.576646], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [0.026, 0.1, 0.1275, 1, -3.34103e-07, 2.1658e-08, -1.42179e-08], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [-0.4261, -0.092, 0.065, 0.540093, 0, 0, 0.841605], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [-0.026, 0.1, 0.1275, 1, -3.3384e-07, 2.25813e-08, -1.37683e-08], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }