world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, 0, 0, 1.78129e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 2.64698e-23, -2.64698e-23] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731692, 2.64026e-17, -5.55112e-17, -0.681636], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [1.73472e-17, -0.316, -2.69118e-16, 0.707107, 0.707107, 1.46046e-16, 8.51846e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [7.85427e-18, -6.46738e-17, -1.10744e-16, 1, 2.7787e-18, -5.24521e-18, -8.44625e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.29597e-17, 5.11743e-17, 0.707107, 0.707107, -6.75354e-17, 1.11022e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [0.315319, 1.38778e-16, 0, -0.948986], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -3.38849e-16, 0.707107, -0.707107, -1.48656e-16, 1.48888e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.93739e-16, 5.92214e-17, -5.20206e-16, 1, -1.10738e-16, -2.53005e-17, 4.49298e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-1.49962e-17, -1.63928e-17, -2.33557e-17, 0.707107, 0.707107, -5.63938e-17, 0] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.73169, 1.38778e-17, 2.77556e-17, 0.681638], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -6.245e-17, -1.61689e-17, 0.707107, 0.707107, -5.55112e-17, -8.32667e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-6.08952e-18, 1.23807e-17, -3.32669e-18, 1, -6.7515e-17, 2.77556e-17, 4.43147e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [6.93889e-17, 6.93864e-17, 0.107, 1, 2.16703e-18, 0, -1.12758e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.60561e-16, 2.66367e-17, -1.6834e-15, 1, 2.16893e-18, 0, -2.90564e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 9.44971e-18, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -1.38778e-17, 0, 2.42861e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-6.93889e-18, 6.93889e-18, 0.0584, 1, 1.38778e-17, 0, -2.77556e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-6.93889e-18, 6.93889e-18, 0.0584, 1, 1.38778e-17, 0, -2.77556e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [1.64799e-17, 0.04, -1.03216e-15, 1, 0, 0, -8.67362e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-3.90313e-17, -0.04, 1.00614e-15, 1, 0, 0, 2.42861e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.68028e-16, 5.21921e-16, -1.54951e-16, -1.03296e-13, 0, 1.38778e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-6.245e-17, 2.08167e-17, -0.15, 1, 1.32349e-23, 5.47062e-17, -2.77556e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.80411e-16, 0.02, -0.2, 1, 5.42059e-18, 2.96249e-17, 1.36614e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -3.33067e-16, 1.11022e-16, 5.55112e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [4.70852e-24, 2.85381e-24, -1.43633e-17, 1, 4.16334e-17, -5.55112e-17, 1.11022e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-1.48904e-17, -9.76192e-17, -0.04, 1, 1.04083e-16, -4.16334e-17, -2.77556e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [2.94903e-17, 2.80798e-17, 0.01, 1, 2.16703e-18, 0, -1.12758e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [9.71445e-17, 8.84662e-17, 0.2105, 2.77556e-17, 0.92388, 0.382683, 8.11407e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -6.93889e-17, 4.33681e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [3.03577e-16, 0.008, 0.045, 1, 1.38778e-17, 2.77556e-17, -1.38778e-16], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-3.46945e-16, -0.008, 0.045, 1, 1.38778e-17, 0, -3.1225e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_2_1(table): { pose: [0.509, -8.09954e-10, 0.0885, 0.707107, 1.91352e-10, 5.92985e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_2_2(table): { pose: [0.389, -1.23345e-09, 0.0885, 0.707107, -4.79896e-09, 5.28801e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_2.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_4_1(table): { pose: [0.45, -9.66744e-11, 0.088, 0.707107, -4.13826e-09, 2.60433e-09, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_1_mesh(shape_4_1): { pose: [-2.97268e-25, 4.96909e-19, 0.0275, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_1_handle(shape_4_1): { pose: [1.03398e-25, -9.18947e-18, 0.05, 1, 4.1359e-25, -8.27181e-25, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_2(table): { pose: [0.449946, 7.65317e-05, 0.0879799, 0.707056, 3.47913e-06, -5.88456e-05, -0.707158], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_2_mesh(shape_4_2): { pose: [-1.60936e-20, -7.9799e-18, 0.0275, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_2_handle(shape_4_2): { pose: [-9.31736e-21, -9.45119e-18, 0.05, 1, 0, 1.27055e-21, 0], shape: marker, size: [0.03], color: [1, 1, 0] }