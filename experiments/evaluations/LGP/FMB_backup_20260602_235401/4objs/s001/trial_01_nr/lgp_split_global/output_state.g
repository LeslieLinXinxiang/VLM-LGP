world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, 0, 0, -1.05585e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -1.05879e-22, 1.05879e-22] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731666, 1.12476e-17, 0, -0.681664], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [7.28584e-17, -0.316, -5.14968e-16, 0.707107, 0.707107, 9.51711e-17, 8.34277e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-2.13644e-16, -4.50254e-17, -1.26437e-16, 1, 4.06154e-17, 1.04863e-16, 6.87655e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.69462e-20, -1.1189e-16, 0.707107, 0.707107, -4.53164e-17, -5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [0.315323, 0, 2.77556e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -2.98905e-16, 0.707107, -0.707107, -3.04309e-17, 2.52747e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [2.83684e-16, 5.20712e-17, -3.80095e-16, 1, 3.9918e-17, -8.45747e-17, -2.72087e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, -5.53723e-17, 5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731706, -6.93889e-18, 1.38778e-17, 0.681621], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.46945e-17, -2.96534e-17, 0.707107, 0.707107, 8.32667e-17, 2.77556e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [1.82682e-17, 1.73074e-17, 9.98046e-18, 1, -5.37856e-17, 0, 1.58023e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-6.93889e-18, -4.6627e-18, 0.107, 1, 2.1684e-19, 0, -1.05776e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [4.19862e-17, -2.96122e-18, -1.49519e-15, 1, -1.0842e-19, 0, 5.24493e-18] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -9.25172e-18, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -1.38778e-17, 0, -6.245e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [2.77556e-17, 2.42861e-17, 0.0584, 1, -1.38778e-17, 0, 1.11022e-16] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [2.77556e-17, 2.42861e-17, 0.0584, 1, -1.38778e-17, 0, 1.11022e-16] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [9.36751e-17, 0.04, -9.38485e-16, 1, 0, 0, -5.89806e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [3.81639e-17, -0.04, 5.15213e-16, 1, 1.38778e-17, 2.77556e-17, 5.20417e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.99237e-16, 3.33705e-16, 1.33084e-17, -1.0356e-13, -2.77556e-17, 0, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, 0, -0, 2.11758e-22], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-8.1532e-17, 1.95189e-18, -0.15, 1, -1.95159e-18, -1.4506e-17, 2.60224e-18], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [4.30211e-16, 0.02, -0.2, 1, 1.51778e-18, -3.71774e-17, 1.78936e-18], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -1.66533e-16, -5.55112e-17, 1.38778e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 3.747e-16, -2.77556e-17, 8.32667e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [4.51283e-18, -1.14663e-16, -0.04, 1, 1.73472e-17, 6.93889e-17, 6.93889e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [1.73472e-17, -8.22386e-18, 0.01, 1, 2.1684e-19, 0, -1.05776e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.11022e-16, 2.29804e-17, 0.2105, 1.38778e-17, 0.92388, 0.382683, 3.71636e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 2.35922e-16, -2.25514e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.15106e-16, 0.008, 0.045, 1, 1.38778e-17, 0, 1.11022e-16], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-2.37657e-16, -0.008, 0.045, 1, -1.38778e-17, -2.77556e-17, 1.00614e-16], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_2_1(table): { pose: [0.509, -1.52042e-09, 0.0885, 0.707107, -1.06002e-09, 3.19597e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_2_2(table): { pose: [0.389, -2.91996e-10, 0.0885, 0.707107, -2.8762e-09, 2.34213e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_2.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_4_1(table): { pose: [0.45, -2.87198e-11, 0.088, 0.707107, 3.42979e-11, 5.26505e-11, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_1_mesh(shape_4_1): { pose: [1.5752e-26, 1.39682e-17, 0.0275, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_1_handle(shape_4_1): { pose: [-1.53481e-26, 1.53038e-17, 0.05, 1, -1.29247e-26, 1.29247e-26, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_2(table): { pose: [0.45, 9.49731e-11, 0.088, 0.707107, -6.32016e-10, 1.37439e-10, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_2_mesh(shape_4_2): { pose: [-6.46235e-26, 1.7475e-17, 0.0275, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_2_handle(shape_4_2): { pose: [3.87741e-26, -2.37384e-17, 0.05, 1, -1.29247e-26, 5.16988e-26, 0], shape: marker, size: [0.03], color: [1, 1, 0] }