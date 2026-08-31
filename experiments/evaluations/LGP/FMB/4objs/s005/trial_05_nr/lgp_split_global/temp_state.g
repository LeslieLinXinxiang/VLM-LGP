world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.999991, 0, 0, -0.00423361], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -7.37257e-18, 7.37257e-18] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.996603, 3.51553e-17, 0, 0.0823569], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-6.93889e-17, -0.316, -4.91546e-16, 0.707107, 0.707107, 1.95156e-17, 9.97466e-18] }
l_panda_joint3(l_panda_joint3_origin): { pose: [6.84814e-18, -3.74913e-19, 1.13961e-18, 0.999992, 2.5411e-19, -2.06691e-17, 0.0040542], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, 1.36474e-17, -1.73472e-17, 0.707107, 0.707107, 3.52637e-17, -3.46945e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [0.283189, 2.77556e-17, 1.11022e-16, -0.959064], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 2.81079e-16, 0.707107, -0.707107, -3.06016e-17, -9.45966e-18] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.66471e-16, 2.30124e-16, -3.13931e-16, 0.999998, 5.68122e-17, 3.03476e-17, -0.00220041], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, -4.98733e-17, 0] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.203319, 7.58942e-18, -4.88975e-17, 0.979113], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -5.09948e-17, 6.89671e-18, 0.707107, 0.707107, -9.98618e-17, 3.91194e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-9.67209e-22, 2.71049e-19, 1.14131e-22, 0.921253, 1.53148e-16, 6.49437e-17, -0.388964], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [7.11508e-19, -6.08508e-18, 0.107, 1, -2.03288e-20, 1.35525e-19, -1.26308e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-1.04299e-17, 9.77916e-18, -1.44328e-15, 1, 6.77626e-21, -2.71051e-20, -1.26308e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [1.94926e-20, -1.8834e-20, -1.14131e-23, 0.92388, -4.06576e-20, -5.42101e-20, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 2.71051e-20, 2.71051e-20, 1.63798e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-2.21245e-18, -1.14976e-17, 0.0584, 1, 2.71051e-20, -2.71051e-20, -2.73499e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-2.21245e-18, -1.14976e-17, 0.0584, 1, 2.71051e-20, -2.71051e-20, -2.73499e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-5.77952e-17, 0.04, -7.92606e-16, 1, 2.71051e-20, 0, -2.73499e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [5.76094e-17, -0.04, 3.48517e-16, 1, -2.71051e-20, 2.71051e-20, -2.73499e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.87487e-16, 2.72657e-16, 7.7801e-20, -1.03253e-13, -5.42101e-20, -5.42101e-20, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.00614e-16, -1.13841e-18, -0.15, 1, 3.5965e-18, 3.54792e-17, -8.13152e-20], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [3.88578e-16, 0.02, -0.2, 1, -6.91179e-18, -5.1654e-17, 7.31836e-18], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 0, 0, 6.93889e-18], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 0, 0, 2.77556e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-1.94996e-17, -2.40351e-16, -0.04, 1, 1.66603e-16, -1.00397e-16, -3.48029e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-8.36869e-18, -1.2629e-17, 0.01, 1, -2.03288e-20, 1.35525e-19, -1.26308e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-2.24701e-17, -1.27326e-17, 0.2105, 2.34359e-17, 0.92388, 0.382683, 5.65456e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -5.55112e-17, -8.43577e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.77637e-16, 0.008, 0.045, 1, 0, 2.71051e-20, -2.73499e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-2.80158e-16, -0.008, 0.045, 1, 2.71051e-20, -2.71051e-20, -2.73499e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_2_1(table): { pose: [0.45, -3.59962e-10, 0.0885, 0.707107, -4.67583e-09, 2.52398e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_4_2(table): { pose: [0.45, -2.59757e-09, 0.0880003, 0.707107, -3.6433e-08, 4.81403e-08, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_1_mesh(shape_4_2): { pose: [9.82277e-25, 1.24207e-17, 0.0275, 0.707107, 0.707107, 6.26501e-17, 1.11022e-16], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_1_handle(shape_4_2): { pose: [1.13737e-24, 2.39714e-18, 0.05, 1, 0, -3.30872e-24, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_3(table): { pose: [-0.273, -0.3286, 0.0625, 0.907814, -0, -0, -0.419373], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_2_mesh(shape_4_3): { pose: [0, 0, 0.0275, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_2_handle(shape_4_3): { pose: [0, 0, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_1(table): { pose: [0.45, -0.08, 0.088, 0.707107, 7.33776e-10, 1.40739e-09, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_3_mesh(shape_4_1): { pose: [3.10427e-18, 4.71686e-18, 0.0275, 0.707107, 0.707107, -3.37659e-17, 0], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_3.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_3_handle(shape_4_1): { pose: [-1.92557e-18, -1.16098e-17, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }