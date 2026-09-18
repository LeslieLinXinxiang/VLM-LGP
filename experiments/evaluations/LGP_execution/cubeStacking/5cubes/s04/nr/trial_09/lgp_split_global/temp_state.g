world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.121843, 0, 0, 0.992549], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 1.11022e-16, -1.11022e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.636071, 1.11022e-16, -1.11022e-16, -0.77163], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-2.91434e-16, -0.316, 7.89253e-17, 0.707107, 0.707107, 0, -4.16334e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [7.136e-17, 5.57358e-18, -7.96515e-16, 0.982853, 2.77556e-17, -5.55112e-17, 0.184391], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.08167e-17, 1.21431e-17, 0.707107, 0.707107, 7.63278e-17, 4.85723e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-8.76703e-17, 6.08216e-17, -5.39879e-17, 0.505843, -5.55112e-17, 5.55112e-17, -0.862626], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -8.32667e-17, 0.707107, -0.707107, 0, -5.55112e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-7.81121e-17, -5.0681e-16, -4.75837e-16, 0.89044, -6.93889e-17, 1.07553e-16, 0.455102], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-9.96214e-17, 5.20919e-18, -5.06655e-17, 0.707107, 0.707107, 1.52656e-16, 1.66533e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [-1.03845e-17, -5.42552e-18, -7.43764e-18, 0.968912, 1.38778e-17, -5.55112e-17, 0.247404], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -2.30285e-16, -7.47422e-17, 0.707107, 0.707107, -3.81639e-17, 1.73472e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-8.74286e-17, -1.21231e-16, -3.95578e-19, 0.121843, 2.60209e-18, 9.54098e-18, -0.992549], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-1.60462e-17, 1.99493e-17, 0.107, 1, -1.30104e-18, -2.60209e-18, 1.17656e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [3.69093e-17, -1.23205e-18, -1.33407e-15, 1, 0, 1.30104e-18, 6.64074e-18] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 4.33681e-19, 3.90313e-18, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 1.30104e-18, -3.36103e-18, 5.07813e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-3.1225e-17, 1.17941e-17, 0.0584, 1, -4.33681e-19, -1.0842e-19, -4.74338e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-3.1225e-17, 1.17941e-17, 0.0584, 1, -4.33681e-19, -1.0842e-19, -4.74338e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [2.70498e-17, 0.04, -5.72838e-16, 1, -4.33681e-19, -1.0842e-19, -4.74338e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [9.24341e-17, -0.04, 1.24153e-16, 1, -4.33681e-19, -1.0842e-19, -4.74338e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.03396e-13, 0, -8.67362e-19, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.77636e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, 0, 0, -1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.21431e-16, 1.00614e-16, -0.15, 1, 2.77556e-17, 5.55112e-17, 1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [-1.66533e-16, 0.02, -0.2, 1, -1.38778e-17, -1.38778e-17, 1.11022e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -1.02349e-16, 0, 5.55112e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -5.55112e-17, 0, -5.55112e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.89803e-17, -9.32414e-17, -0.04, 1, 0, -2.77556e-17, 0], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [3.25261e-19, -1.57209e-17, 0.01, 1, -1.30104e-18, -2.60209e-18, 1.17656e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-3.38271e-17, -1.9082e-17, 0.2105, 2.32019e-17, 0.92388, 0.382683, 5.89806e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, -5.20417e-18], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [4.72712e-17, 0.008, 0.045, 1, -4.33681e-19, -1.0842e-19, -4.74338e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [3.64292e-17, -0.008, 0.045, 1, -4.33681e-19, -1.0842e-19, -4.74338e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
longrect_1(table): { pose: [3.50685e-09, 0.1, 0.0665, 1, -3.78546e-09, 1.39736e-09, 1.34109e-09], joint: rigid, shape: ssBox, size: [0.095, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.6, inertia: [0.00108, 0.005955, 0.005955], logical: { is_object: True, is_box: True, is_place: True } }
longrect_1_Left(longrect_1): { pose: [-0.038, 1.62322e-18, 0.016, 1, 0, -6.07295e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_1_Right(longrect_1): { pose: [0.038, -1.12304e-18, 0.016, 1, 0, -6.07295e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_1_Center(longrect_1): { pose: [1.55096e-25, -6.6888e-18, 0.016, 1, 0, -6.07295e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2(table): { pose: [0.3087, -0.0053, 0.065, 0.160484, 0, 0, 0.987038], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_2_Left(rectprism_2): { pose: [-0.026, -1.73472e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2_Right(rectprism_2): { pose: [0.026, 0, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1(table): { pose: [5.29082e-05, 0.0999499, 0.0965694, 1, 1.12034e-05, 9.51995e-06, -1.09754e-05], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1_Left(rectprism_1): { pose: [-0.026, 2.65386e-19, 0.016, 1, -1.69407e-21, -1.12057e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1_Right(rectprism_1): { pose: [0.026, 4.04384e-18, 0.016, 1, -1.69407e-21, -1.12057e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
cube_1(table): { pose: [-0.4424, 0.1687, 0.065, 0.828891, -0, -0, -0.55941], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [-0.3211, 0.1747, 0.065, 0.577644, -0, -0, -0.816289], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }