world: {  }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, 0, 0, -1.37914e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -8.67363e-19, -8.6736e-19] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, -8.47507e-17, 0, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-8.67362e-17, -0.316, -1.75975e-16, 0.707107, 0.707107, 1.03617e-16, -8.0483e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-3.92664e-18, 3.42219e-17, 5.53721e-17, 1, 4.33952e-17, -8.71101e-17, 2.24459e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -7.45375e-20, 6.59195e-17, 0.707107, 0.707107, 3.62625e-17, -1.11022e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [0.315322, -1.38778e-16, 8.32667e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -8.50232e-17, 0.707107, -0.707107, -1.23295e-16, 1.27514e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [9.68654e-17, 2.5467e-17, -2.60104e-16, 1, 6.20224e-17, -6.99513e-17, -2.58256e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, 7.20803e-18, -1.11022e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, 6.93889e-17, 2.77556e-17, 0.681638], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -1.38778e-17, -1.11688e-17, 0.707107, 0.707107, -2.77556e-17, 0] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-6.08945e-18, 1.11943e-17, -3.32668e-18, 1, 1.71657e-16, 0, 8.55211e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [6.93889e-17, -3.00518e-18, 0.107, 1, 5.29396e-23, 2.77556e-17, -5.33433e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [6.36048e-17, -1.10795e-20, -7.24308e-16, 1, 8.47033e-22, 0, 2.16826e-18] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -4.97171e-18, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -1.38778e-17, 0, 2.08167e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [2.77556e-17, 1.04083e-17, 0.0584, 1, 0, 0, 2.42861e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [2.77556e-17, 1.04083e-17, 0.0584, 1, 0, 0, 2.42861e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [6.50521e-17, 0.04, -2.55004e-16, 1, 0, 0, 2.42861e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-4.59702e-17, -0.04, 2.61943e-16, 1, 0, 0, 2.42861e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.08273e-17, 3.80511e-17, 6.65337e-18, -1.03414e-13, -6.93889e-18, 0, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-1.30104e-16, -2.16841e-19, -0.15, 1, -1.55853e-19, 9.23498e-17, 1.73472e-18], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [2.35922e-16, 0.02, -0.2, 1, 1.0842e-19, 6.0019e-17, 2.98156e-19], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 1.11022e-16, 8.32667e-17, -8.32667e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 1.38778e-17, -5.55112e-17, 1.11022e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-4.02605e-17, -5.96246e-17, -0.04, 1, 0, 0, 0], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [2.94903e-17, -7.26973e-18, 0.01, 1, 5.29396e-23, 2.77556e-17, -5.33433e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.38778e-16, 5.29194e-18, 0.2105, 2.77556e-17, 0.92388, 0.382683, -4.45793e-18], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -1.38778e-17, 1.04083e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [5.0307e-17, 0.008, 0.045, 1, 0, 0, 2.42861e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [3.29597e-17, -0.008, 0.045, 1, 0, 0, 2.42861e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", contact: 1, mass: 0.5, inertia: [0.00292522, 0.00535543, 0.00279145], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.707107, 0.707107, -0, 0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.06, 0, 0, 0.707107, 0.707107, -0, 0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.06, 0, 0, 0.707107, 0.707107, -0, 0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1], logical: { is_place: True } }
shape_1_1(table): { pose: [0.4, -0.3, 0.0625], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [0.2, 0.2, 1], logical: { is_object: True, is_box: True } }
shape_1_1_mesh(shape_1_1): { pose: [0, 0.001, 0.0275, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [1, 0.2, 0.2, 0.5], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_1_1.obj", contact: 1, mass: 0.1, inertia: [8.37458e-05, 0.000232628, 0.000282221], logical: { is_object: True, is_box: True } }
shape_1_1_handle(shape_1_1): { pose: [-0.045, 0, 0.045], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_1_2(table): { pose: [0.6, -0.2, 0.0625], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [0.2, 0.2, 1], logical: { is_object: True, is_box: True } }
shape_1_2_mesh(shape_1_2): { pose: [0, 0.001, 0.0275, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.2, 0.2, 1, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_1_2.obj", contact: 1, mass: 0.1, inertia: [8.37458e-05, 0.000232628, 0.000282221], logical: { is_object: True, is_box: True } }
shape_1_2_handle(shape_1_2): { pose: [-0.045, 0, 0.045], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_2_1(table): { pose: [0.3, 0.2, 0.063, 0.707107, -0, -0, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_3_1(table): { pose: [0.45, 1.03316e-10, 0.0880001, 1, 2.67334e-09, 1.43072e-08, -7.73906e-12], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0.005], color: [0.2, 0.2, 0.9], logical: { is_object: True, is_box: True } }
shape_3_1_mesh(shape_3_1): { pose: [9.19175e-19, 0.001, 0.0325, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [0.2, 0.8, 1, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_1.obj", contact: 1, mass: 0.1, inertia: [0.000230943, -2.88191e-22, 5.73441e-22, 0.00016058, -2.55738e-12, 9.9969e-05], logical: { is_object: True, is_box: True } }
shape_3_1_handle(shape_3_1): { pose: [-1.6991e-17, -1.55096e-25, 0.065, 1, -4.1359e-25, 3.02821e-25, 1.61559e-27], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_1(table): { pose: [0.5, 0.4, 0.0625], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_1_mesh(shape_4_1): { pose: [0, 0, 0.0275, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_1_handle(shape_4_1): { pose: [0, 0, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }
cam_overview(table): { pose: [0.45, 0, 0.85, 6.12323e-17, 1, 0, 0], shape: camera, size: [] }