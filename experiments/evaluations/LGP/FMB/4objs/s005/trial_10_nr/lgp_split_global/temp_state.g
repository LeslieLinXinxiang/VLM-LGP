world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.999651, 0, 0, 0.0263987], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.9966, -5.11743e-17, 1.38778e-17, 0.0823952], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-9.02056e-17, -0.316, -3.1532e-16, 0.707107, 0.707107, -6.93889e-17, -3.1225e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [2.2751e-17, -1.33697e-19, -2.21313e-16, 0.999694, 1.09938e-16, 2.14066e-17, -0.0247499], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, 1.40811e-17, 6.07153e-17, 0.707107, 0.707107, -4.71628e-18, -6.93889e-18] }
l_panda_joint4(l_panda_joint4_origin): { pose: [1.12015e-21, 3.7591e-21, -4.33663e-19, 0.283326, 1.38778e-17, 5.55112e-17, -0.959024], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -1.8258e-16, 0.707107, -0.707107, -7.97973e-17, 1.32815e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.0132e-16, 7.45971e-17, -4.46667e-17, 0.999946, 6.02816e-17, 3.22321e-17, 0.0103514], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [5.05879e-17, -2.4033e-17, -2.19793e-17, 0.707107, 0.707107, -1.47451e-17, 0] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.203543, -1.25767e-17, -7.32921e-17, 0.979066], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 3.61226e-17, -2.49736e-17, 0.707107, 0.707107, 1.29969e-17, 4.15182e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.69959e-20, -1.13151e-18, 1.39831e-22, 0.911403, 5.04894e-17, 2.32629e-17, -0.411515], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-6.31251e-19, 2.03288e-19, 0.107, 1, 5.0822e-21, 0, -3.87876e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-7.67587e-20, -8.64478e-20, -8.88178e-16, 1, 1.18585e-20, 1.35525e-20, 7.22347e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-5.01508e-21, 4.55706e-21, -8.3731e-25, 0.92388, -2.28964e-21, 8.97326e-21, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 8.41739e-21, 1.98259e-20, -2.92731e-18], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [1.14942e-18, -1.92243e-17, 0.0584, 1, -2.64698e-22, -6.4851e-21, -2.92731e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [1.14942e-18, -1.92243e-17, 0.0584, 1, -2.64698e-22, -6.4851e-21, -2.92731e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [3.59825e-17, 0.04, -3.0203e-16, 1, -3.62636e-21, 7.49095e-21, -2.92731e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-3.58961e-17, -0.04, -3.64104e-16, 1, -2.72639e-21, 6.61744e-21, -2.92731e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.46958e-16, 1.04118e-16, -3.19732e-20, -1.03365e-13, 0, 0, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.17961e-16, 1.0842e-18, -0.15, 1, 2.43945e-19, 6.40272e-18, -3.03577e-18], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [2.35922e-16, 0.02, -0.2, 1, -3.46945e-18, -4.98614e-17, 2.49366e-18], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -1.30104e-18, -1.38778e-17, 0], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 2.77556e-16, -2.77556e-17, 9.71445e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-1.04013e-17, -1.64937e-16, -0.04, 1, 5.58229e-17, 4.33681e-18, 4.0766e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [1.92896e-17, 1.39866e-17, 0.01, 1, 5.0822e-21, 0, -3.87876e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-3.98293e-17, 5.66496e-18, 0.2105, 2.3439e-17, 0.92388, 0.382683, 5.65729e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -1.66533e-16, 1.42098e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.55913e-16, 0.008, 0.045, 1, 2.19699e-21, -6.06158e-21, -2.92731e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.68615e-16, -0.008, 0.045, 1, 2.22346e-21, -6.93508e-21, -2.92731e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_2_1(table): { pose: [0.45, 6.48193e-10, 0.0885, 0.707107, -2.1717e-09, 1.2093e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_4_2(table): { pose: [0.45, -4.14054e-08, 0.0880003, 0.707107, -6.16058e-09, 9.39006e-08, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_1_mesh(shape_4_2): { pose: [-3.30872e-24, 1.60997e-18, 0.0275, 0.707107, 0.707107, -3.00249e-17, -5.55112e-17], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_1_handle(shape_4_2): { pose: [-4.96308e-24, -1.22122e-17, 0.05, 1, 0, 3.30872e-24, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_1(table): { pose: [0.45, -0.08, 0.088, 0.707107, 2.79281e-10, 1.29373e-11, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_2_mesh(shape_4_1): { pose: [-3.68632e-18, 1.04878e-17, 0.0275, 0.707107, 0.707107, 9.06617e-18, 5.55112e-17], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_2_handle(shape_4_1): { pose: [-4.17917e-18, 1.40223e-17, 0.05, 1, -1.61559e-27, 2.58494e-26, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_3(table): { pose: [0.087, -0.4467, 0.0625, 0.209448, 0, 0, 0.97782], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_3_mesh(shape_4_3): { pose: [0, 0, 0.0275, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_3.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_3_handle(shape_4_3): { pose: [0, 0, 0.05, 1, -0, 0, 0], shape: marker, size: [0.03], color: [1, 1, 0] }