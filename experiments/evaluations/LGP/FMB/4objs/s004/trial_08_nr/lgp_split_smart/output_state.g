world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, 0, 0, 5.51425e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 1.04083e-17, -1.04083e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731736, -1.84604e-17, 0, -0.681588], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-1.00614e-16, -0.316, -2.98115e-16, 0.707107, 0.707107, -6.19046e-17, -1.36228e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [1.57373e-17, -1.14114e-16, -2.21485e-16, 1, 3.38813e-21, 1.62286e-16, 8.67362e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.69435e-17, -1.53523e-16, 0.707107, 0.707107, 5.39363e-17, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.21486e-16, -1.57373e-17, -1.72459e-21, 0.315319, 8.32667e-17, 5.55112e-17, -0.948986], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -4.91177e-16, 0.707107, -0.707107, 1.10997e-16, -7.63481e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.6382e-16, 8.51147e-17, -5.66894e-16, 1, -1.37364e-16, 9.9792e-17, -3.01387e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-5.6224e-18, 1.68823e-18, -8.7591e-18, 0.707107, 0.707107, -2.98918e-17, 5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731648, -1.31839e-16, 4.16334e-17, 0.681683], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -1.31839e-16, -5.92692e-17, 0.707107, 0.707107, -2.77556e-17, 2.77556e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [1.82679e-17, 3.8408e-17, 9.9802e-18, 1, 4.69104e-17, 2.77556e-17, -2.87217e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [4.16334e-17, 1.412e-17, 0.107, 1, -3.38813e-20, 0, 4.84189e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.2085e-16, -2.22539e-19, -1.9581e-15, 1, -1.01644e-20, 0, -7.10576e-18] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -2.14469e-18, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -1.38778e-17, 2.77556e-17, 6.245e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [1.73472e-17, 6.245e-17, 0.0584, 1, 0, 2.77556e-17, 3.46945e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [1.73472e-17, 6.245e-17, 0.0584, 1, 0, 2.77556e-17, 3.46945e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [3.98986e-17, 0.04, -1.42421e-15, 1, 1.38778e-17, -5.55112e-17, 0], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [3.55618e-17, -0.04, 9.54098e-16, 1, 1.38778e-17, -5.55112e-17, 0], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-4.05974e-16, 4.5758e-16, 1.99686e-17, -1.03376e-13, 6.93889e-18, 1.38778e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-2.04697e-16, 3.47167e-18, -0.15, 1, 1.73557e-18, 5.8426e-18, 1.38761e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [4.30211e-16, 0.02, -0.2, 1, 6.93773e-18, -1.92572e-17, -6.93889e-18], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -1.66533e-16, -5.55112e-17, -1.11022e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -1.38778e-17, 2.77556e-17, -2.77556e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-1.71579e-17, -4.13539e-16, -0.04, 1, -1.83881e-16, -4.16334e-17, 2.77556e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [5.89806e-17, 1.36181e-17, 0.01, 1, -3.38813e-20, 0, 4.84189e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-5.55112e-17, 9.65618e-20, 0.2105, 1.38778e-17, 0.92388, 0.382683, 6.59712e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -6.93889e-17, 6.93889e-18], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [4.61436e-16, 0.008, 0.045, 1, -1.38778e-17, 0, 0], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-5.10009e-16, -0.008, 0.045, 1, -1.38778e-17, 0, 0], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_2_1(table): { pose: [0.509, -1.47063e-11, 0.0885, 0.707107, -2.60508e-11, 1.8071e-11, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_2_2(table): { pose: [0.389, -3.65453e-11, 0.0885, 0.707107, 1.98756e-11, 4.51678e-11, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_2.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_4_2(table): { pose: [0.45, 0.08, 0.0880001, 0.707107, -1.19191e-08, 1.60416e-08, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_1_mesh(shape_4_2): { pose: [-3.522e-18, 1.78102e-17, 0.0275, 0.707107, 0.707107, -1.19293e-16, -2.22045e-16], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_1_handle(shape_4_2): { pose: [1.16607e-18, 2.22892e-17, 0.05, 1, -1.65436e-24, -1.65436e-24, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_1(table): { pose: [0.45, -0.08, 0.0880001, 0.707107, -1.26754e-08, 1.11522e-08, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_2_mesh(shape_4_1): { pose: [8.66391e-19, 2.47712e-17, 0.0275, 0.707107, 0.707107, -6.08151e-17, 5.55112e-17], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_2_handle(shape_4_1): { pose: [2.83687e-18, 1.47598e-17, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }