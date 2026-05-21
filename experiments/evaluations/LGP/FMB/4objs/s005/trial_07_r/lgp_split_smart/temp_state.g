world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.999968, 0, 0, -0.00805507], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.984311, -4.40186e-17, 0, 0.17644], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-4.16334e-17, -0.316, 6.507e-17, 0.707107, 0.707107, -3.38271e-17, -6.85216e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-1.30284e-17, 8.60496e-19, -4.82581e-18, 0.99998, 2.05998e-18, 1.1036e-17, 0.0063492], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.71051e-19, 3.46945e-18, 0.707107, 0.707107, 4.06034e-17, -4.16334e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [0.297707, -2.77556e-17, 5.55112e-17, -0.954657], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 2.06432e-16, 0.707107, -0.707107, 2.91921e-17, -5.38848e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.62422e-16, 2.05078e-16, -4.0517e-17, 0.99996, -5.65954e-17, 3.92219e-17, -0.00891794], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, -3.03577e-17, 2.77556e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.124629, 2.38524e-17, -7.44847e-17, 0.992203], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 3.08291e-19, 8.17799e-19, 0.707107, 0.707107, -2.72044e-17, -1.50124e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.19937e-20, 9.16914e-19, 2.46672e-25, 0.92764, 4.36459e-20, 4.07985e-19, -0.373475], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-1.95313e-17, -1.92669e-17, 0.107, 1, -3.97047e-23, -1.32349e-23, -4.93117e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-1.82759e-23, 5.81796e-24, -5.55112e-16, 1, -1.32349e-23, -6.61744e-24, 6.19942e-18] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-1.8589e-23, 1.8844e-23, 7.12039e-30, 0.92388, 0, -2.64698e-23, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, 2.64698e-23, -8.27252e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-5.18014e-20, -7.60684e-18, 0.0584, 1, 0, 2.64698e-23, 2.82972e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-5.18014e-20, -7.60684e-18, 0.0584, 1, 0, 2.64698e-23, 2.82972e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-1.02539e-16, 0.04, -3.54985e-16, 1, -1.32349e-23, 0, 2.82972e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [1.02539e-16, -0.04, -3.11148e-16, 1, -1.32349e-23, 0, 2.82972e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.20238e-16, 1.11844e-16, 3.07633e-23, -1.035e-13, -2.64698e-23, -1.32349e-23, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-5.55112e-17, 5.42101e-19, -0.15, 1, 2.1684e-19, 2.22439e-17, -1.30104e-18], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [5.55112e-17, 0.02, -0.2, 1, 1.0842e-19, -2.82037e-17, 2.11419e-18], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 3.46945e-18, 2.77556e-17, -4.16334e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 0, 1.38778e-17, -5.55112e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.86159e-17, 2.97769e-18, -0.04, 1, 1.93124e-19, -8.67362e-18, -2.94903e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [1.77494e-17, 1.75092e-17, 0.01, 1, -3.97047e-23, -1.32349e-23, -4.93117e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-1.2542e-17, 1.30577e-17, 0.2105, 2.34327e-17, 0.92388, 0.382683, 5.65713e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, 4.8383e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [9.93377e-17, 0.008, 0.045, 1, 1.32349e-23, 0, 2.82972e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-9.97907e-17, -0.008, 0.045, 1, 1.32349e-23, 0, 2.82972e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, -1.77636e-17, 0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, 1.77636e-17, -0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_2_1(table): { pose: [0.45, -3.35447e-11, 0.0885, 0.707107, 1.14373e-12, 2.03131e-11, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_2_2(table): { pose: [-0.3169, -0.2027, 0.063, -0.535311, 0, -0, -0.844655], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_2.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_4_1(table): { pose: [0.124, -0.2796, 0.0625, 0.970528, 0, 0, 0.24099], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_1_mesh(shape_4_1): { pose: [0, 0, 0.0275, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_1_handle(shape_4_1): { pose: [0, 0, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_2(table): { pose: [0.0719, 0.2702, 0.0625, 0.766829, -0, -0, -0.641851], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_2_mesh(shape_4_2): { pose: [0, 0, 0.0275, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_2_handle(shape_4_2): { pose: [0, 0, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_3(table): { pose: [0.2139, 0.3985, 0.0625, 0.138741, 0, 0, 0.990329], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_3_mesh(shape_4_3): { pose: [0, 0, 0.0275, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_3.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_3_handle(shape_4_3): { pose: [0, 0, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_4(table): { pose: [-0.4477, 0.3459, 0.0625, 0.601048, -0, -0, -0.799213], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_4_mesh(shape_4_4): { pose: [0, 0, 0.0275, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_4.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_4_handle(shape_4_4): { pose: [0, 0, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_5(table): { pose: [-0.0915, -0.3636, 0.0625, 0.102619, 0, 0, 0.994721], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_5_mesh(shape_4_5): { pose: [0, 0, 0.0275, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_5.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_5_handle(shape_4_5): { pose: [0, 0, 0.05, 1, -0, 0, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_6(table): { pose: [0.3519, -0.382, 0.0625, 0.982613, 0, 0, 0.185667], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_6_mesh(shape_4_6): { pose: [0, 0, 0.0275, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_6.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_6_handle(shape_4_6): { pose: [0, 0, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }