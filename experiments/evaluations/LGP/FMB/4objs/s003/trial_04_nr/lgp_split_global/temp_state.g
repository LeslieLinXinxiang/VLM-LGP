world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.999799, 0, 0, -0.020037], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -1.73472e-18, 1.73472e-18] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.996614, -1.32273e-17, 3.46945e-18, 0.0822177], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [0, -0.316, -4.2241e-16, 0.707107, 0.707107, -2.25514e-17, 8.67362e-18] }
l_panda_joint3(l_panda_joint3_origin): { pose: [1.58696e-17, -8.3404e-19, -2.22451e-16, 0.999822, -1.76183e-19, -1.92996e-18, 0.018845], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, 1.33492e-17, -5.20417e-18, 0.707107, 0.707107, 1.85128e-17, 2.77556e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [0.282987, -5.55112e-17, -1.11022e-16, -0.959124], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -4.21538e-16, 0.707107, -0.707107, -2.60209e-17, -4.86265e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.67702e-16, 2.82671e-16, -3.1289e-16, 0.999977, 4.74881e-17, 1.57472e-17, -0.00677088], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, -8.67362e-19, 0] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.202942, 1.43115e-17, 6.39679e-17, 0.979191], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 1.81062e-17, -2.02768e-17, 0.707107, 0.707107, -7.18284e-18, -4.83283e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-3.87426e-21, 4.06557e-19, -3.21934e-22, 0.934334, -5.14966e-17, -1.98409e-17, -0.3564], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-1.59784e-17, -1.35424e-17, 0.107, 1, 1.35525e-19, -9.21572e-19, 7.26603e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-9.55771e-18, 1.10135e-17, -5.55123e-16, 1, -5.42101e-20, 0, 1.71492e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-1.14023e-21, 1.25289e-21, -1.34139e-24, 0.92388, -1.02999e-18, -3.25261e-19, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 9.21572e-19, -9.21572e-19, -1.46835e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [1.02593e-17, -1.76657e-17, 0.0584, 1, 1.0842e-19, -1.0842e-19, 7.52094e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [1.02593e-17, -1.76657e-17, 0.0584, 1, 1.0842e-19, -1.0842e-19, 7.52094e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [3.83543e-17, 0.04, -3.49709e-16, 1, 5.42101e-20, -2.71051e-19, 7.52094e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-3.79554e-17, -0.04, 1.27665e-16, 1, -2.1684e-19, 1.0842e-19, 7.52094e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.22573e-16, 1.16916e-16, -3.24677e-20, -1.03398e-13, 9.55453e-19, -3.93023e-19, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [6.59195e-17, -2.05998e-18, -0.15, 1, -3.10353e-18, -2.05655e-17, 2.73219e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [2.22045e-16, 0.02, -0.2, 1, -2.1684e-19, 1.55049e-17, -1.67509e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 1.66967e-16, -6.93889e-18, -6.93889e-18], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 0, -1.38778e-17, -1.38778e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-1.99682e-17, -3.19494e-16, -0.04, 1, 1.11161e-16, 2.42861e-17, -2.68882e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [6.25619e-18, 7.96359e-18, 0.01, 1, 1.35525e-19, -9.21572e-19, 7.26603e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-3.13334e-17, 2.05524e-17, 0.2105, 2.4049e-17, 0.92388, 0.382683, 5.73712e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 5.55112e-17, 1.57291e-16], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.24494e-16, 0.008, 0.045, 1, 0, -1.0842e-19, 7.52095e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.41678e-16, -0.008, 0.045, 1, 1.0842e-19, -1.0842e-19, 7.52094e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_2_1(table): { pose: [0.45, -1.16782e-09, 0.0885, 0.707107, -1.93395e-09, 5.00004e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_4_1(table): { pose: [0.45, 7.82785e-09, 0.0880003, 0.707107, -2.79255e-08, 6.00998e-08, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_1_mesh(shape_4_1): { pose: [-2.06795e-25, 2.23102e-17, 0.0275, 0.707107, 0.707107, -5.26241e-18, 5.55112e-17], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_1_handle(shape_4_1): { pose: [-1.65436e-24, -2.50401e-17, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_3(table): { pose: [-0.4346, 0.1889, 0.0625, 0.732543, -0, -0, -0.680721], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_2_mesh(shape_4_3): { pose: [0, 0, 0.0275, 0.707107, 0.707107, -1.11022e-16, -1.11022e-16], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_2_handle(shape_4_3): { pose: [0, 0, 0.05, 1, 0, 0, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_2(table): { pose: [0.45, -0.08, 0.088, 0.707107, -1.63324e-09, 6.34235e-09, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_3_mesh(shape_4_2): { pose: [-6.68625e-18, -1.12177e-17, 0.0275, 0.707107, 0.707107, 9.38408e-17, 5.55112e-17], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_3.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_3_handle(shape_4_2): { pose: [6.76744e-18, 9.88295e-18, 0.05, 1, 0, -4.1359e-25, 0], shape: marker, size: [0.03], color: [1, 1, 0] }