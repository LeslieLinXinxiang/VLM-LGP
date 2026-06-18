world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, 0, 0, -5.01742e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 3.46945e-18, 6.93889e-18] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731719, -3.12536e-17, 5.55112e-17, -0.681607], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-4.51028e-17, -0.316, -4.20473e-16, 0.707107, 0.707107, -2.36267e-17, 9.93843e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [3.9316e-18, -4.03512e-17, -5.53722e-17, 1, -2.78335e-18, -5.37854e-17, -4.99688e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, 3.95787e-18, -4.59702e-17, 0.707107, 0.707107, 4.61751e-18, 5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-9.06705e-27, 8.4785e-27, -8.47033e-22, 0.315321, -8.32667e-17, 2.77556e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -6.57679e-18, 0.707107, -0.707107, -1.31309e-16, 5.59218e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [2.53756e-16, 5.99762e-17, -4.26764e-16, 1, -3.54024e-17, -7.67722e-17, 2.10276e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-2.87606e-27, -4.23516e-22, 6.10943e-27, 0.707107, 0.707107, -4.29984e-17, 5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731672, 0, 2.77556e-17, 0.681657], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -9.02056e-17, -3.29811e-17, 0.707107, 0.707107, -8.32667e-17, -5.55112e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [4.39752e-22, 3.16155e-17, -2.46399e-22, 1, -3.43048e-18, 2.77556e-17, -1.18451e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [5.55112e-17, -1.43123e-17, 0.107, 1, 2.17264e-19, -2.77556e-17, -1.19443e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-1.31531e-17, -5.77832e-18, -2.03129e-15, 1, 2.16629e-19, 0, -8.41601e-18] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-5.92682e-23, 6.05967e-18, -4.72267e-23, 0.92388, -4.97992e-18, -2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -4.16334e-17, 5.55112e-17, 1.04083e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [3.1225e-17, 5.20417e-17, 0.0584, 1, 1.38778e-17, 0, 1.04083e-16] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [3.1225e-17, 5.20417e-17, 0.0584, 1, 1.38778e-17, 0, 1.04083e-16] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-5.37764e-17, 0.04, -1.21951e-15, 1, 1.38778e-17, -2.77556e-17, -1.73472e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [1.93422e-16, -0.04, 8.01442e-16, 1, 1.38778e-17, 0, -7.28584e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.92572e-16, 5.46446e-16, -1.54954e-16, -1.03282e-13, 6.93889e-18, 0, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.78677e-16, 5.34128e-18, -0.15, 1, -8.67277e-18, -1.01978e-16, 2.08158e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [4.16334e-16, 0.02, -0.2, 1, -4.34846e-19, -4.74452e-17, -4.34104e-19], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -2.22045e-16, 2.77556e-17, 0], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 9.71445e-17, -2.77556e-17, 8.32667e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.17786e-17, -4.0332e-16, -0.04, 1, -1.17961e-16, -2.77556e-17, -5.55112e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [2.60209e-17, -1.57486e-17, 0.01, 1, 2.17264e-19, -2.77556e-17, -1.19443e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.38778e-17, 6.5032e-18, 0.2105, 4.16334e-17, 0.92388, 0.382683, 8.47221e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 2.22045e-16, 9.36751e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [3.22659e-16, 0.008, 0.045, 1, 1.38778e-17, 0, 3.81639e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-2.5327e-16, -0.008, 0.045, 1, 0, -2.77556e-17, 3.81639e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_2_1(table): { pose: [0.509, 1.22992e-11, 0.0885, 0.707107, -7.14947e-11, -3.364e-11, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_2_2(table): { pose: [0.389, 1.4215e-10, 0.0885, 0.707107, -3.92984e-10, 6.6786e-10, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_2.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_4_1(table): { pose: [0.45, 1.1569e-10, 0.088, 0.707107, -1.37985e-10, -1.38453e-10, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_1_mesh(shape_4_1): { pose: [-4.6852e-26, -6.73469e-18, 0.0275, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_1_handle(shape_4_1): { pose: [5.16988e-26, 7.94099e-18, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_2(table): { pose: [0.45, 4.69512e-09, 0.088, 0.707107, -1.4922e-08, -2.43297e-10, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_2_mesh(shape_4_2): { pose: [-9.30578e-25, 1.18865e-17, 0.0275, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_2_handle(shape_4_2): { pose: [-3.10193e-24, 1.15189e-17, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }