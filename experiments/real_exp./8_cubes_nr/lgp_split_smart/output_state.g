world: {  }
base(world): { pose: [0, 0, 0.545], shape: ssBox, size: [1.3, 1, 0.11, 0.02], color: [0.45, 0.45, 0.45], contact: 1 }
table(base): { pose: [0, 0.25, 0.11], shape: ssBox, size: [1, 0.8, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(base): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, -6.03896e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, 1.9082e-17, 3.46945e-18, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-6.80012e-16, -0.316, -5.57291e-16, 0.707107, 0.707107, 1.09288e-16, 1.11022e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-1.57772e-25, 1.84672e-17, 2.22486e-24, 1, 2.77556e-17, -8.32667e-17, 9.66032e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -5.75919e-16, 1.23165e-16, 0.707107, 0.707107, 3.33067e-16, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.29342e-16, 9.50377e-17, 9.56612e-17, 0.315322, 7.63278e-17, -5.55112e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 1.25482e-16, 0.707107, -0.707107, 4.30211e-16, -7.77156e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [4.03681e-16, -2.55477e-16, -1.93232e-16, 1, 2.77556e-17, -5.55112e-17, -2.7771e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [3.82022e-24, -1.38622e-17, -1.94021e-25, 0.707107, 0.707107, 2.22045e-16, 2.35922e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, 0, 4.16334e-17, 0.681639], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -8.39606e-16, 6.44157e-16, 0.707107, 0.707107, -1.52656e-16, -1.11022e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-4.47463e-16, 2.49678e-16, 8.56813e-18, 1, -1.38778e-17, -4.16334e-17, 3.8454e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [4.85723e-17, -1.13407e-16, 0.107, 1, -2.77556e-17, 2.77556e-17, 1.38778e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [7.40004e-17, 1.29652e-16, -4.76693e-15, 1, 1.38778e-17, -1.38778e-17, 1.38778e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [5.63856e-29, 7.27919e-23, 2.00822e-29, 0.92388, 2.77556e-17, -2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, 0, -1.21431e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [4.16334e-17, -2.77556e-17, 0.0584, 1, 0, 0, -3.46945e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [4.16334e-17, -2.77556e-17, 0.0584, 1, 0, 0, -3.46945e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-2.94903e-17, 0.04, -2.75995e-15, 1, 0, 0, -3.46945e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [8.93383e-17, -0.04, 1.84748e-15, 1, 0, 0, -3.46945e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.54708e-16, 5.13669e-17, -3.99202e-17, -1.03438e-13, -2.77556e-17, 6.93889e-18, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.4211e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [2.25514e-17, 1.36199e-16, -0.15, 1, 0, 1.11022e-16, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [9.15934e-16, 0.02, -0.2, 1, 2.77556e-17, 0, -1.66533e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 3.46945e-18, -2.38091e-16, 3.19189e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1.45613e-30, -9.26207e-32, 6.61744e-24, 1, -8.32667e-17, -6.245e-17, -6.66134e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [4.711e-16, 6.60624e-17, -0.04, 1, -1.11022e-16, 0, -3.88578e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [3.1225e-17, 1.34522e-18, 0.01, 1, -2.77556e-17, 2.77556e-17, 1.38778e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [6.93889e-17, -2.5133e-16, 0.2105, 4.16334e-17, 0.92388, 0.382683, 4.16334e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, 4.85723e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.42247e-16, 0.008, 0.045, 1, 0, 0, -3.46945e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.89085e-16, -0.008, 0.045, 1, 0, 0, -3.46945e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
cube_1(table): { pose: [-0.022, 0.1, 0.1275, 1, -8.9456e-11, 9.77723e-11, 1.92664e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [0.022, 0.1, 0.1275, 1, -9.02837e-11, 4.46257e-11, 1.13927e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
rect_2(table): { pose: [6.20916e-12, 0.1, 0.0665, 1, -3.40315e-14, 6.21908e-12, 7.09053e-12], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rect_2_Left(rect_2): { pose: [-0.026, 2.37085e-17, 0.016, 1, 0, 2.28905e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_2_Right(rect_2): { pose: [0.026, 1.87215e-17, 0.016, 1, 0, 2.28905e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_3(table): { pose: [0.08, 0.1, 0.0665, 1, 2.20119e-12, 5.83588e-12, 2.24821e-11], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rect_3_Left(rect_3): { pose: [-0.026, -1.21585e-18, 0.016, 1, 0, 3.24201e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_3_Right(rect_3): { pose: [0.026, -9.92599e-18, 0.016, 1, 0, 3.24201e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_5(table): { pose: [-2.8291e-07, 0.1, 0.1575, 1, -5.93031e-09, -2.07228e-07, -3.69331e-07], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rect_5_Left(rect_5): { pose: [-0.026, 3.55459e-17, 0.016, 1, -1.65435e-24, -4.33074e-23, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_5_Right(rect_5): { pose: [0.026, -1.00364e-16, 0.016, 1, -1.65435e-24, -4.33074e-23, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_1(table): { pose: [-0.08, 0.1, 0.0665, 1, -5.6425e-13, 3.22573e-12, 2.41876e-12], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
cube_1_Left(rect_1): { pose: [-0.026, -2.76245e-17, 0.016, 1, 0, -1.80986e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
cube_1_Right(rect_1): { pose: [0.026, -2.12716e-18, 0.016, 1, 0, -1.80986e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_4(table): { pose: [8.38666e-11, 0.1, 0.0965, 1, -9.02603e-11, 4.48954e-11, 1.14357e-10], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rect_4_Left(rect_4): { pose: [-0.022, 3.14895e-16, 0.016, 1, 0, -1.40154e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_4_Right(rect_4): { pose: [0.022, 1.59019e-17, 0.016, 1, 0, -1.40154e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
tri_1(table): { pose: [-2.81961e-07, 0.1, 0.1825, 1, -5.58925e-09, -2.07226e-07, -3.69331e-07], joint: rigid, shape: mesh, color: [0.9, 0.6, 0.1], mesh: "/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", contact: 1, mass: 0.2, inertia: [3.61846e-05, 3.20675e-05, 5.23466e-05], logical: { is_object: True, is_box: True } }