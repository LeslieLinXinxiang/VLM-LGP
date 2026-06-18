world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, 0, 0, 1.78552e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731694, -1.98348e-17, 0, -0.681633], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-1.04083e-16, -0.316, -5.59323e-16, 0.707107, 0.707107, 7.10718e-17, -1.01419e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-1.17827e-17, 6.7608e-17, 1.66116e-16, 1, 4.06169e-17, 3.39664e-17, -3.6136e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, 8.84658e-17, -3.46945e-17, 0.707107, 0.707107, -7.30193e-17, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [6.10028e-26, 3.01721e-27, 8.47033e-22, 0.315346, 2.77556e-17, -8.32667e-17, -0.948977], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -1.72744e-16, 0.707107, -0.707107, 2.3412e-17, -1.09288e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [6.68653e-17, 4.46697e-17, -3.06819e-16, 1, 1.33289e-17, 4.6979e-17, 1.28016e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-1.50006e-17, -3.95188e-17, -2.33534e-17, 0.707107, 0.707107, 5.8037e-17, 1.11022e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731681, 0, -1.249e-16, 0.681647], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -9.02056e-17, -1.05138e-16, 0.707107, 0.707107, -5.55112e-17, -5.55112e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [1.21791e-17, 1.57855e-17, 6.65265e-18, 1, -6.06101e-17, -2.77556e-17, 0.00010441], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [7.63278e-17, 2.24938e-17, 0.107, 1, 1.01644e-20, 5.55112e-17, -6.53333e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.88183e-16, 2.02177e-18, -1.41534e-15, 1, -2.37169e-20, 0, -9.80864e-18] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 4.1674e-18, -2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, 0, 1.17961e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [1.73472e-17, 0, 0.0584, 1, 1.38778e-17, 0, 5.55112e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [1.73472e-17, 0, 0.0584, 1, 1.38778e-17, 0, 5.55112e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [8.50015e-17, 0.04, -6.59195e-16, 1, 1.38778e-17, 0, 5.20417e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [2.42861e-17, -0.04, 2.22045e-16, 1, 0, 0, -5.89806e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.25086e-16, 1.25147e-16, -1.55821e-20, -1.03497e-13, 1.38778e-17, 1.38778e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-9.88792e-17, 5.20318e-17, -0.15, 1, -2.98494e-18, -1.19802e-17, -6.24433e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [5.13478e-16, 0.02, -0.2, 1, -8.32616e-17, -3.78026e-18, 1.11019e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 0, 0, 1.11022e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 2.77556e-17, -2.77556e-17, 0], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-1.35816e-16, -3.57122e-16, -0.04, 1, -1.04083e-16, 4.16334e-17, -9.71445e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [5.29091e-17, 5.04514e-18, 0.01, 1, 1.01644e-20, 5.55112e-17, -6.53333e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.52656e-16, -5.30581e-18, 0.2105, 2.77556e-17, 0.92388, 0.382683, 3.32782e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -1.38778e-17, 6.93889e-18], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [6.93889e-17, 0.008, 0.045, 1, 0, 0, 4.51028e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-9.88792e-17, -0.008, 0.045, 1, 1.38778e-17, 0, 5.55112e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_3_1(table): { pose: [0.45, -0.08, 0.088, 1, 8.36313e-12, 1.84397e-11, 1.86835e-12], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0.005], color: [0.2, 0.2, 0.9], logical: { is_object: True, is_box: True } }
shape_3_1_mesh(shape_3_1): { pose: [2.00264e-16, 0.001, 0.0325, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [0.2, 0.8, 1, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_1.obj", contact: 1, mass: 0.1, inertia: [0.000230943, -2.88191e-22, 5.73441e-22, 0.00016058, -2.55738e-12, 9.9969e-05], logical: { is_object: True, is_box: True } }
shape_3_1_handle(shape_3_1): { pose: [-2.29564e-17, -6.75244e-18, 0.065, 1, 0, -7.04824e-28, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_3_2(table): { pose: [0.45, 1.70538e-08, 0.088, 0.707107, -5.28418e-10, -4.88248e-10, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0.005], color: [0.2, 0.2, 0.9], logical: { is_object: True, is_box: True } }
shape_3_2_mesh(shape_3_2): { pose: [-9.42639e-19, 0.001, 0.0325, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [0.2, 0.8, 1, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_2.obj", contact: 1, mass: 0.1, inertia: [0.000230943, -2.88191e-22, 5.73441e-22, 0.00016058, -2.55738e-12, 9.9969e-05], logical: { is_object: True, is_box: True } }
shape_3_2_handle(shape_3_2): { pose: [2.06795e-25, 2.06005e-17, 0.065, 1, -5.16988e-26, 5.16988e-26, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_3_3(table): { pose: [0.449997, 0.0799851, 0.0879984, 1, 8.86294e-06, -3.01192e-06, 1.33348e-05], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0.005], color: [0.2, 0.2, 0.9], logical: { is_object: True, is_box: True } }
shape_3_3_mesh(shape_3_3): { pose: [-6.51988e-17, 0.001, 0.0325, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [0.2, 0.8, 1, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_3.obj", contact: 1, mass: 0.1, inertia: [0.000230943, -2.88191e-22, 5.73441e-22, 0.00016058, -2.55738e-12, 9.9969e-05], logical: { is_object: True, is_box: True } }
shape_3_3_handle(shape_3_3): { pose: [2.16506e-17, -4.93397e-19, 0.065, 1, 1.67187e-22, 1.00244e-22, 5.55112e-17], shape: marker, size: [0.03], color: [1, 1, 0] }