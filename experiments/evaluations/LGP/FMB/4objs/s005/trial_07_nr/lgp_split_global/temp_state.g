world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.999773, 0, 0, -0.021291], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.993544, 3.33934e-17, 0, 0.113446], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [1.11022e-16, -0.316, -1.07402e-16, 0.707107, 0.707107, -1.21431e-17, 6.93889e-18] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-6.35814e-17, -1.57521e-19, 2.13199e-16, 0.999987, 1.10155e-16, 1.21295e-17, -0.00500607], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, 1.08149e-17, 9.71445e-17, 0.707107, 0.707107, -1.68051e-17, -1.38778e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [0.265389, 1.38778e-17, 0, -0.964141], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -5.47631e-16, 0.707107, -0.707107, -6.72205e-18, -2.61835e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.36383e-18, 2.77175e-17, -5.02325e-19, 0.999993, -1.73472e-18, 1.76047e-17, 0.00370914], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [5.2382e-17, -1.02223e-17, -1.67709e-17, 0.707107, 0.707107, 6.245e-17, -4.16334e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.14938, -3.46945e-18, 9.62772e-17, 0.98878], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -5.1608e-17, -1.86637e-17, 0.707107, 0.707107, 5.55112e-17, 7.37257e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [0.928108, -5.10117e-17, -2.08167e-17, -0.37231], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-1.74557e-17, -1.2902e-17, 0.107, 1, 8.67362e-19, 8.67362e-19, 2.1125e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [4.00172e-18, 3.8225e-18, -5.55084e-16, 1, 0, -8.67362e-19, 2.11199e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -4.33681e-19, -8.67362e-19, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 4.33681e-19, 8.67362e-19, -4.07579e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-9.93908e-18, -2.12504e-17, 0.0584, 1, -8.67362e-19, 4.33681e-19, 3.65122e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-9.93908e-18, -2.12504e-17, 0.0584, 1, -8.67362e-19, 4.33681e-19, 3.65122e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [2.81921e-17, 0.04, -4.1487e-16, 1, -4.33681e-19, -1.30104e-18, 3.65122e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-2.81414e-17, -0.04, 1.9288e-16, 1, -4.33681e-19, -1.30104e-18, 3.65122e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.39615e-16, 1.22836e-16, 1.19244e-18, -1.03549e-13, 8.67362e-19, -8.67362e-19, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [6.93889e-17, 3.79471e-19, -0.15, 1, 4.33681e-19, 1.32137e-17, -2.42861e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [2.28983e-16, 0.02, -0.2, 1, 8.67362e-19, 1.0571e-18, 8.34836e-18], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 0, -1.38778e-17, 1.38778e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 0, 2.77556e-17, 2.77556e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-2.68296e-17, -1.44853e-16, -0.04, 1, 3.25261e-18, 0, 1.07553e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-1.86754e-17, -1.96647e-17, 0.01, 1, 8.67362e-19, 8.67362e-19, 2.1125e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [6.72205e-18, 3.03577e-17, 0.2105, 2.24159e-17, 0.92388, 0.382683, 5.72052e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 5.55112e-17, 1.97325e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.5491e-16, 0.008, 0.045, 1, 8.67362e-19, 4.33681e-19, 3.65173e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.37934e-16, -0.008, 0.045, 1, 8.67362e-19, 4.33681e-19, 3.65173e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_2_1(table): { pose: [0.45, 1.67015e-09, 0.0885, 0.707107, -2.1216e-09, -4.48559e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_4_1(table): { pose: [0.45, -0.08, 0.088, 0.707107, -3.68388e-11, -1.76056e-10, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_1_mesh(shape_4_1): { pose: [-6.55775e-18, -3.371e-18, 0.0275, 0.707107, 0.707107, 1.71609e-17, 5.55112e-17], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_1_handle(shape_4_1): { pose: [6.92985e-19, 1.40568e-17, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_2(table): { pose: [0.45, -4.82074e-09, 0.0880003, 0.707107, -3.49645e-08, 8.2073e-08, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_2_mesh(shape_4_2): { pose: [2.27475e-24, 5.83376e-19, 0.0275, 0.707107, 0.707107, 3.12817e-18, 0], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_2_handle(shape_4_2): { pose: [-3.30872e-24, -1.40787e-17, 0.05, 1, 0, 3.30872e-24, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_3(table): { pose: [-0.1161, 0.3869, 0.0625, 0.996659, -0, -0, -0.0816776], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_3_mesh(shape_4_3): { pose: [0, 0, 0.0275, 0.707107, 0.707107, -1.38778e-17, -1.38778e-17], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_3.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_3_handle(shape_4_3): { pose: [0, 0, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }