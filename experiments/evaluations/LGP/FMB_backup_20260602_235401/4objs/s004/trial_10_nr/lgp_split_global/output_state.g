world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, 0, 0, -1.93447e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 2.11758e-22, -2.11758e-22] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731773, -4.68557e-17, 0, -0.681548], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [1.35308e-16, -0.316, -3.75982e-16, 0.707107, 0.707107, 1.01138e-16, 4.96711e-18] }
l_panda_joint3(l_panda_joint3_origin): { pose: [1.57616e-17, -1.14644e-16, -2.21485e-16, 1, -2.78875e-18, -7.34404e-17, 9.09988e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, 2.0733e-18, -3.29597e-17, 0.707107, 0.707107, 6.34059e-17, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.25425e-16, 3.96096e-17, -4.07257e-22, 0.315319, -2.77556e-17, -2.77556e-17, -0.948986], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -8.1768e-16, 0.707107, -0.707107, 2.22503e-17, -1.65017e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [3.80737e-16, 7.87679e-17, -6.40083e-16, 1, -8.86416e-17, 6.47199e-17, -3.65125e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, 2.71229e-17, 0] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731631, -3.46945e-17, 2.77556e-17, 0.681701], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 4.16334e-17, -5.84691e-17, 0.707107, 0.707107, -2.77556e-17, -2.77556e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [2.43591e-17, 6.36188e-17, 1.3305e-17, 1, -5.37888e-17, 0, -5.76159e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-8.32667e-17, -1.89668e-17, 0.107, 1, -1.0842e-19, 2.77556e-17, -1.4862e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [2.70066e-16, -2.92769e-18, -1.62354e-15, 1, -5.0822e-21, 0, -1.48553e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -1.0183e-17, 2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 1.38778e-17, -2.77556e-17, 1.70003e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-6.93889e-17, -3.46945e-17, 0.0584, 1, 1.38778e-17, 0, -1.17961e-16] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-6.93889e-17, -3.46945e-17, 0.0584, 1, 1.38778e-17, 0, -1.17961e-16] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [9.28077e-17, 0.04, -8.84709e-16, 1, -1.38778e-17, 0, 2.18575e-16], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [8.1532e-17, -0.04, -4.16334e-17, 1, 0, 0, -2.28983e-16], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.4597e-16, 5.34203e-16, -1.4165e-16, -1.03487e-13, -2.77556e-17, 1.38778e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-1.64799e-16, 1.73549e-18, -0.15, 1, -1.0842e-18, -2.24102e-17, 1.73462e-18], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [6.38378e-16, 0.02, -0.2, 1, -3.25049e-19, 1.12475e-17, 2.968e-18], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 0, -2.77556e-17, 5.55112e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 3.05311e-16, -2.77556e-17, 1.11022e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [9.90125e-17, -1.32e-17, -0.04, 1, -1.76942e-16, 0, -2.77556e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [3.20924e-17, 1.68763e-17, 0.01, 1, -1.0842e-19, 2.77556e-17, -1.4862e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-1.52656e-16, -7.57586e-18, 0.2105, 1.38778e-17, 0.92388, 0.382683, -1.31138e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 5.55112e-17, -4.85723e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.51535e-16, 0.008, 0.045, 1, 1.38778e-17, 0, -1.76942e-16], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-2.65413e-16, -0.008, 0.045, 1, -1.38778e-17, 0, -4.85723e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_2_1(table): { pose: [0.509, -7.60256e-10, 0.0885, 0.707107, -1.23383e-09, 1.81679e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_2_2(table): { pose: [0.389, 6.74778e-12, 0.0885, 0.707107, -4.50838e-10, 5.07953e-11, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_2.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_4_1(table): { pose: [0.45, -2.64982e-10, 0.088, 0.707107, 6.45053e-10, 1.6567e-10, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_1_mesh(shape_4_1): { pose: [1.35709e-25, -2.46002e-17, 0.0275, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_1_handle(shape_4_1): { pose: [-1.22785e-25, -9.4023e-18, 0.05, 1, 0, 5.16988e-26, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_2(table): { pose: [0.449999, -6.03386e-07, 0.0880003, 0.707107, -5.21238e-07, 3.77109e-07, -0.707106], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_2_mesh(shape_4_2): { pose: [-1.38966e-22, 1.16529e-17, 0.0275, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_2_handle(shape_4_2): { pose: [-9.92617e-24, 1.1094e-17, 0.05, 1, 1.05879e-22, 1.58819e-22, -1.66533e-16], shape: marker, size: [0.03], color: [1, 1, 0] }