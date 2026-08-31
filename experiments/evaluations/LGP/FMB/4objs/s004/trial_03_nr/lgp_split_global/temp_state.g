world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.670086, 0, 0, -0.742284], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 1.11022e-16, -5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.746625, 1.11022e-16, -5.55112e-17, -0.665245], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [1.73472e-16, -0.316, -1.19669e-17, 0.707107, 0.707107, -1.66533e-16, -4.72712e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [5.10026e-17, 2.45757e-17, -4.40957e-16, 0.622354, 5.89806e-17, 1.04083e-17, 0.782736], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -1.04083e-17, 1.25767e-17, 0.707107, 0.707107, -4.51028e-17, -4.85723e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.6974e-17, -2.8115e-18, -5.90535e-18, 0.277596, -2.77556e-17, -2.77556e-17, -0.960698], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 1.66533e-16, 0.707107, -0.707107, 9.71445e-17, -5.55112e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [4.72715e-17, 3.80698e-17, -1.42161e-16, 0.647968, 5.55112e-17, -5.55112e-17, 0.761668], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-2.87412e-18, -6.06861e-18, 1.21451e-17, 0.707107, 0.707107, -5.55112e-17, -5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.617018, -1.249e-16, -8.32667e-17, 0.786949], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 1.32706e-16, -1.23159e-16, 0.707107, 0.707107, 3.98986e-17, 4.33681e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.49603e-17, -1.21372e-17, -2.129e-19, 0.521089, 4.33681e-18, 2.94903e-17, -0.853502], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [1.66967e-17, 1.73472e-17, 0.107, 1, -1.73472e-18, -1.73472e-18, 3.53098e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [2.8039e-17, 2.84304e-17, -1.10959e-15, 1, 0, -3.46945e-18, -9.10459e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [2.22039e-17, 5.26946e-17, 2.08482e-18, 0.92388, -3.46945e-18, 3.46945e-18, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -8.67362e-19, 1.73472e-18, 8.19657e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [2.1684e-19, 2.25514e-17, 0.0584, 1, 0, -8.67362e-19, 2.64545e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [2.1684e-19, 2.25514e-17, 0.0584, 1, 0, -8.67362e-19, 2.64545e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-2.53026e-17, 0.04, -6.61797e-16, 1, 0, -8.67362e-19, 2.64545e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [1.96952e-17, -0.04, 2.17925e-16, 1, 0, -8.67362e-19, 2.64545e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.09884e-16, 1.94201e-16, 9.29733e-18, -1.03454e-13, -3.46945e-18, 0, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [0, 9.36751e-17, -0.15, 1, -5.0307e-17, 4.85723e-17, -3.46945e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [3.26128e-16, 0.02, -0.2, 1, -1.11022e-16, 5.55112e-17, -1.11022e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -4.85723e-17, -1.66533e-16, -7.11237e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 0, 4.16334e-17, 0], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-3.8069e-17, -2.55872e-17, -0.04, 1, -2.77556e-17, 2.77556e-17, 8.32667e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-6.91179e-18, -1.74014e-17, 0.01, 1, -1.73472e-18, -1.73472e-18, 3.53098e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-1.69136e-17, 8.67362e-18, 0.2105, 2.40693e-17, 0.92388, 0.382683, 5.95227e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 1.11022e-16, 8.67362e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.2302e-16, 0.008, 0.045, 1, 0, -8.67362e-19, 2.64545e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-2.18358e-16, -0.008, 0.045, 1, 0, -8.67362e-19, 2.64545e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_2_1(table): { pose: [0.509, 2.07531e-09, 0.0885, 0.707107, -2.48296e-09, 1.20405e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_2_2(table): { pose: [0.389, 1.6054e-11, 0.0885, 0.707107, -7.41575e-10, 1.14172e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_2.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_4_2(table): { pose: [-0.4193, -0.2546, 0.0625, 0.46229, 0, 0, 0.886729], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_1_mesh(shape_4_2): { pose: [0, 0, 0.0275, 0.707107, 0.707107, 5.55112e-17, 0], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_1_handle(shape_4_2): { pose: [0, 0, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_1(table): { pose: [0.449999, -0.0799993, 0.088001, 0.707107, 7.28831e-07, -7.30475e-07, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_2_mesh(shape_4_1): { pose: [-1.59099e-18, 2.76593e-17, 0.0275, 0.707107, 0.707107, 2.82937e-17, 0], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_2_handle(shape_4_1): { pose: [3.41541e-18, -1.02679e-17, 0.05, 1, 0, 1.05879e-22, 0], shape: marker, size: [0.03], color: [1, 1, 0] }