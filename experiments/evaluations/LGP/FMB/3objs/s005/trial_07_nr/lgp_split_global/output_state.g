world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, 0, 0, -1.45582e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -2.11758e-22, 2.11758e-22] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731686, -6.5607e-17, -5.55112e-17, -0.681641], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-2.42861e-17, -0.316, -3.58079e-16, 0.707107, 0.707107, -2.15937e-17, -1.59131e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-2.05783e-16, -1.02498e-16, -2.37194e-16, 1, 7.84554e-17, -1.96055e-17, -1.92388e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, 1.30178e-18, -9.19403e-17, 0.707107, 0.707107, 1.89422e-17, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-3.92629e-18, 5.53721e-17, -1.40901e-22, 0.315321, 2.77556e-17, 0, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -8.13535e-16, 0.707107, -0.707107, 4.72085e-17, -5.7306e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [4.47443e-16, 9.64149e-17, -9.46998e-16, 1, -4.87142e-17, 3.9574e-17, 2.99415e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [5.62376e-18, 3.11615e-17, 8.75814e-18, 0.707107, 0.707107, -1.29361e-16, 5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731691, 4.85723e-17, 6.93889e-17, 0.681637], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 0, -6.41668e-17, 0.707107, 0.707107, 2.77556e-17, 0] }
l_panda_joint7(l_panda_joint7_origin): { pose: [2.58425e-22, 5.628e-17, -1.37279e-22, 1, -1.00703e-16, 0, 1.4218e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-2.77556e-17, 2.21166e-17, 0.107, 1, -1.73472e-18, 0, -2.58649e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.84946e-16, -3.26685e-17, -1.67009e-15, 1, -1.73451e-18, 0, -2.5892e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [1.5745e-27, 2.11758e-22, -5.16523e-28, 0.92388, -8.15544e-18, -2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -2.77556e-17, 5.55112e-17, 1.45717e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [0, 3.1225e-17, 0.0584, 1, 1.38778e-17, 0, -1.38778e-16] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [0, 3.1225e-17, 0.0584, 1, 1.38778e-17, 0, -1.38778e-16] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [1.31839e-16, 0.04, -1.2889e-15, 1, -1.38778e-17, 0, 1.45717e-16], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [1.249e-16, -0.04, 4.3715e-16, 1, 1.38778e-17, 2.77556e-17, -2.498e-16], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-3.06078e-16, 5.42751e-16, -1.61597e-16, -1.03566e-13, -4.16334e-17, 1.38778e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-1.17961e-16, 9.26442e-23, -0.15, 1, 6.93868e-18, 9.56931e-18, -1.38776e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [5.96745e-16, 0.02, -0.2, 1, 3.46983e-18, -1.24101e-16, 6.93905e-18], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 0, -2.77556e-17, -5.55112e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -9.71445e-17, 2.77556e-17, 5.55112e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-5.31067e-17, -4.42138e-16, -0.04, 1, -4.51028e-17, 6.93889e-17, 2.77556e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [2.42861e-17, 8.6189e-18, 0.01, 1, -1.73472e-18, 0, -2.58649e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-8.32667e-17, 3.46928e-17, 0.2105, 2.77556e-17, 0.92388, 0.382683, 7.88271e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 8.32667e-17, -1.14492e-16], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.61943e-16, 0.008, 0.045, 1, 1.38778e-17, 0, -1.38778e-16], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-3.48679e-16, -0.008, 0.045, 1, -1.38778e-17, 0, -1.31839e-16], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_2_1(table): { pose: [0.449996, -0.000222539, 0.20305, 0.707106, 0.707108, 0.000171909, 0.000149783], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_3_2(table): { pose: [0.45035, 0.0799213, 0.087668, 0.707326, -0.000398331, 0.000113736, -0.706888], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0.005], color: [0.2, 0.2, 0.9], logical: { is_object: True, is_box: True } }
shape_3_1_mesh(shape_3_2): { pose: [8.84302e-19, 0.001, 0.0325, 0.707107, 0.707107, 9.73343e-17, -5.55112e-17], joint: rigid, shape: mesh, color: [0.2, 0.8, 1, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_1.obj", contact: 1, mass: 0.1, inertia: [0.000230943, -2.88191e-22, 5.73441e-22, 0.00016058, -2.55738e-12, 9.9969e-05], logical: { is_object: True, is_box: True } }
shape_3_1_handle(shape_3_2): { pose: [-6.48488e-18, -1.7991e-17, 0.065], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_3_1(table): { pose: [0.45, -0.08, 0.088, 0.707107, -3.51175e-09, 7.16985e-09, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0.005], color: [0.2, 0.2, 0.9], logical: { is_object: True, is_box: True } }
shape_3_2_mesh(shape_3_1): { pose: [1.68004e-17, 0.001, 0.0325, 0.707107, 0.707107, 8.41204e-17, -5.55112e-17], joint: rigid, shape: mesh, color: [0.2, 0.8, 1, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_2.obj", contact: 1, mass: 0.1, inertia: [0.000230943, -2.88191e-22, 5.73441e-22, 0.00016058, -2.55738e-12, 9.9969e-05], logical: { is_object: True, is_box: True } }
shape_3_2_handle(shape_3_1): { pose: [6.355e-18, 1.46459e-17, 0.065, 1, 0, 2.06795e-24, 0], shape: marker, size: [0.03], color: [1, 1, 0] }