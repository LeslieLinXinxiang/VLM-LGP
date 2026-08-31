world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.999978, 0, 0, -0.00662362], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.996533, 5.47522e-18, 0, 0.0832034], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-6.245e-17, -0.316, -5.09788e-16, 0.707107, 0.707107, 9.28077e-17, 6.15827e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [2.31527e-17, -1.37636e-18, -2.21269e-16, 0.999981, -5.47929e-17, -6.08694e-18, 0.00619571], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, 3.55415e-18, -1.21431e-17, 0.707107, 0.707107, 4.82334e-17, -6.93889e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [0.283591, 6.93889e-18, 5.55112e-17, -0.958945], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 6.13333e-16, 0.707107, -0.707107, 4.21213e-17, -7.36444e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [4.29145e-16, 6.05257e-16, -5.47321e-16, 0.999997, 5.96311e-17, 2.51162e-17, -0.00258717], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, 3.59955e-17, 2.77556e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.202828, -2.66714e-17, -1.10941e-16, 0.979214], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 4.00045e-17, -4.42334e-19, 0.707107, 0.707107, -2.71135e-17, -3.77155e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.77389e-21, 4.76691e-19, 2.59126e-25, 0.924589, 5.14026e-17, 2.11519e-17, -0.380965], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-1.86031e-17, -1.85296e-17, 0.107, 1, -2.83227e-21, -2.11758e-22, 1.18071e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [2.79995e-21, -1.768e-22, -1.77636e-15, 1, -2.64698e-23, -3.17637e-22, 7.04913e-18] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 1.48231e-21, 3.97047e-22, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 3.70577e-21, 2.64698e-23, -1.78583e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [1.03967e-18, 7.95717e-17, 0.0584, 1, -3.83812e-21, -7.94093e-23, 1.54484e-16] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [1.03967e-18, 7.95717e-17, 0.0584, 1, -3.83812e-21, -7.94093e-23, 1.54484e-16] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-8.31623e-17, 0.04, -1.07361e-15, 1, 3.86459e-21, -3.70577e-22, -1.78583e-16], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [8.31624e-17, -0.04, 4.07472e-16, 1, -3.70577e-21, 5.82335e-22, 1.54484e-16], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-3.56298e-16, 3.33066e-16, 5.41462e-22, -1.03485e-13, -1.27055e-21, 3.91753e-21, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, 0, -0, 1.73472e-18], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.04083e-16, -1.46367e-18, -0.15, 1, 1.23328e-18, 3.18595e-17, 3.36103e-18], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [3.88578e-16, 0.02, -0.2, 1, -3.79471e-19, -5.77549e-18, 3.34747e-18], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 1.73472e-18, 3.46945e-17, 1.11022e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 0, -1.38778e-17, -8.32667e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [6.21327e-18, -1.84852e-16, -0.04, 1, -5.54364e-17, 6.17995e-18, -4.04407e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [5.63163e-18, 5.57184e-18, 0.01, 1, -2.83227e-21, -2.11758e-22, 1.18071e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-1.25671e-17, 1.2885e-17, 0.2105, 2.34301e-17, 0.92388, 0.382683, 5.65739e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 2.22045e-16, -2.07142e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [3.36961e-16, 0.008, 0.045, 1, -3.54695e-21, 3.70577e-22, 1.54484e-16], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-3.3543e-16, -0.008, 0.045, 1, -2.93815e-21, 8.20563e-22, 1.54484e-16], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_2_2(table): { pose: [0.389, 7.10448e-11, 0.0885, 0.707107, -3.01295e-09, 3.35106e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_2_1(table): { pose: [0.509, 5.83673e-10, 0.0885, 0.707107, -1.03453e-09, 1.3455e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_2.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_4_2(table): { pose: [0.2058, 0.3904, 0.0625, 0.00925011, 0, 0, 0.999957], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_1_mesh(shape_4_2): { pose: [0, 0, 0.0275, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_1_handle(shape_4_2): { pose: [0, 0, 0.05, 1, -0, 0, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_1(table): { pose: [0.45, -1.4308e-11, 0.088, 0.707107, -2.41485e-10, 1.6947e-10, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_2_mesh(shape_4_1): { pose: [-3.63507e-27, -1.18662e-17, 0.0275, 0.707107, 0.707107, -6.69256e-17, 0], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_2_handle(shape_4_1): { pose: [4.03897e-27, 2.38434e-17, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }