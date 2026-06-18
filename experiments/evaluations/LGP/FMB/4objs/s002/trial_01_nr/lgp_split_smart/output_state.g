world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, 0, 0, -1.11449e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, -7.97778e-17, -5.55112e-17, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [5.89806e-17, -0.316, -6.14969e-16, 0.707107, 0.707107, 5.08506e-17, -2.40797e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-2.09709e-16, -1.10379e-16, -1.81823e-16, 1, 8.4012e-17, -2.96036e-17, 6.48405e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, 3.37458e-18, -9.97466e-17, 0.707107, 0.707107, 3.55104e-18, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [0.315322, -2.77556e-17, 0, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -9.9565e-16, 0.707107, -0.707107, -9.53795e-17, 6.13988e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [3.50582e-16, 7.75015e-17, -6.86891e-16, 1, 6.20224e-17, 5.93738e-18, 1.98014e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-3.20442e-26, 1.73471e-18, -1.90735e-26, 0.707107, 0.707107, -1.4425e-16, 5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, 1.11022e-16, 2.77556e-17, 0.681638], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -8.32667e-17, -2.51602e-17, 0.707107, 0.707107, 0, 8.32667e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [6.08945e-18, 4.06952e-17, 3.32669e-18, 1, -1.37337e-17, 2.77556e-17, 4.04312e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [5.55112e-17, 2.05991e-18, 0.107, 1, 8.13019e-20, -2.77556e-17, 7.88964e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.6059e-16, 7.25699e-19, -1.6834e-15, 1, 1.35512e-19, 0, 2.33852e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -5.91786e-18, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -2.77556e-17, 2.77556e-17, -2.60209e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [0, 3.46945e-18, 0.0584, 1, 0, 2.77556e-17, -2.42861e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [0, 3.46945e-18, 0.0584, 1, 0, 2.77556e-17, -2.42861e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [6.245e-17, 0.04, -1.00094e-15, 1, 0, 0, -7.97973e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [3.64292e-17, -0.04, 5.51642e-16, 1, 0, -2.77556e-17, 3.1225e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-3.29888e-16, 3.8156e-16, 1.99601e-17, -1.03226e-13, -6.93889e-18, 1.38778e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-1.43982e-16, 1.68051e-18, -0.15, 1, -2.45978e-18, 4.09805e-17, -1.44199e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [5.68989e-16, 0.02, -0.2, 1, 8.67361e-19, -4.25953e-18, 1.00831e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 5.55112e-17, 1.66533e-16, -8.32667e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [3.89143e-26, 1.90736e-26, 1.73472e-18, 1, 2.77556e-17, -5.55112e-17, 0], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-4.81294e-17, -3.37606e-16, -0.04, 1, -1.38778e-17, -5.55112e-17, 6.93889e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-4.33681e-18, -8.47372e-18, 0.01, 1, 8.13019e-20, -2.77556e-17, 7.88964e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [6.93889e-17, -6.66796e-18, 0.2105, 2.77556e-17, 0.92388, 0.382683, 4.9245e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -1.66533e-16, -4.16334e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.48065e-16, 0.008, 0.045, 1, 0, -2.77556e-17, -7.97973e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-2.89699e-16, -0.008, 0.045, 1, 0, 2.77556e-17, -7.97973e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_2_1(table): { pose: [0.509, 4.48523e-13, 0.0885, 0.707107, -4.71368e-13, -4.34325e-13, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_2_2(table): { pose: [0.45, -3.94405e-10, 0.0885001, 0.707107, -1.00009e-08, 1.02602e-08, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_2.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_2_3(table): { pose: [0.389, 5.88563e-10, 0.0885, 0.707107, -3.04095e-09, 3.82223e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_3.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_4_1(table): { pose: [0.45, -1.6637e-08, 0.0880004, 0.707107, -5.06065e-08, 7.02968e-08, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_1_mesh(shape_4_1): { pose: [-3.72231e-24, 2.94105e-18, 0.0275, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_1_handle(shape_4_1): { pose: [-8.27181e-25, -1.9885e-17, 0.05, 1, 0, -6.61744e-24, 0], shape: marker, size: [0.03], color: [1, 1, 0] }