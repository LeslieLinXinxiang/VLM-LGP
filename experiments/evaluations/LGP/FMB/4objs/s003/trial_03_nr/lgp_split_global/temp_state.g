world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.999272, 0, 0, -0.0381584], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -1.04083e-17, 1.04083e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.998617, -7.58942e-17, -1.73472e-18, 0.0525756], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-9.02056e-17, -0.316, -2.90639e-16, 0.707107, 0.707107, -2.08167e-17, -4.16334e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [1.64355e-17, -5.29168e-19, -2.21544e-16, 0.999617, -5.46438e-17, -6.87791e-19, 0.0276795], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, 1.30036e-17, 2.42861e-17, 0.707107, 0.707107, -9.56808e-18, 2.08167e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-1.37984e-17, -1.45301e-18, 2.95218e-19, 0.253773, -2.42861e-17, -5.55112e-17, -0.967264], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -3.92481e-17, 0.707107, -0.707107, 1.36474e-17, 1.18002e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [2.25398e-16, 3.55807e-16, -3.37126e-16, 0.999985, -5.32885e-17, -1.69559e-17, -0.00553346], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, 5.72459e-17, -2.77556e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.200431, -3.05745e-17, -4.10371e-17, 0.979708], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -4.42897e-17, -1.33966e-17, 0.707107, 0.707107, -5.68122e-17, -2.71051e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [0.926725, 5.15843e-17, 2.0383e-17, -0.375739], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [1.60462e-17, 1.41217e-17, 0.107, 1, -1.0842e-19, 4.33681e-19, 7.06409e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [2.58886e-18, 3.17406e-18, -8.88171e-16, 1, 1.0842e-19, 0, 1.51292e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -1.0842e-19, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -4.33681e-19, 2.1684e-19, -3.25676e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [5.27193e-18, 4.33681e-18, 0.0584, 1, -2.1684e-19, 0, 7.84547e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [5.27193e-18, 4.33681e-18, 0.0584, 1, -2.1684e-19, 0, 7.84547e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-1.09185e-17, 0.04, -5.05021e-16, 1, 0, 2.1684e-19, -8.80787e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [1.24461e-17, -0.04, 6.09322e-17, 1, 0, -6.50521e-19, 1.89477e-16], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.8467e-16, 1.71416e-16, 5.03196e-19, -1.03395e-13, 3.25261e-19, 1.0842e-19, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [3.46945e-17, -1.95156e-18, -0.15, 1, -1.0842e-19, -3.02221e-18, -3.46945e-18], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.66533e-16, 0.02, -0.2, 1, -3.68629e-18, -1.02872e-18, -1.68051e-18], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -1.08095e-16, 2.51535e-17, -6.07153e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -1.66533e-16, 9.71445e-17, 2.77556e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-1.46955e-18, -1.2282e-16, -0.04, 1, 1.10714e-16, 5.63785e-18, -5.85469e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [2.39202e-18, 4.33003e-18, 0.01, 1, -1.0842e-19, 4.33681e-19, 7.06409e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-9.21572e-18, 8.61941e-18, 0.2105, 2.32223e-17, 0.92388, 0.382683, 5.54883e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 5.55112e-17, 8.76035e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.73743e-16, 0.008, 0.045, 1, -2.1684e-19, -2.1684e-19, 1.89477e-16], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.77809e-16, -0.008, 0.045, 1, 0, 4.33681e-19, 1.89477e-16], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_2_1(table): { pose: [0.45, -2.75242e-11, 0.0885, 0.707107, -8.18231e-09, 8.28002e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_4_2(table): { pose: [0.45, -0.08, 0.088, 0.707107, -7.67201e-11, 2.07342e-10, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_1_mesh(shape_4_2): { pose: [-6.16475e-18, 2.11133e-17, 0.0275, 0.707107, 0.707107, 5.62831e-17, -5.55112e-17], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_1_handle(shape_4_2): { pose: [1.40753e-18, -7.03048e-18, 0.05, 1, 0, -1.29247e-26, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_1(table): { pose: [0.45, 1.35705e-08, 0.0880001, 0.707107, -1.43659e-08, 3.16965e-08, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_2_mesh(shape_4_1): { pose: [-1.03398e-24, -1.56793e-17, 0.0275, 0.707107, 0.707107, -1.2381e-16, 0], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_2_handle(shape_4_1): { pose: [1.24077e-24, 1.69104e-17, 0.05, 1, 0, -1.65436e-24, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_3(table): { pose: [-0.4199, 0.2143, 0.0625, 0.930161, 0, 0, 0.367151], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_3_mesh(shape_4_3): { pose: [0, 0, 0.0275, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_3.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_3_handle(shape_4_3): { pose: [0, 0, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }