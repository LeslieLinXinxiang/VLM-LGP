world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, 0, 0, 8.7088e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731777, -9.82778e-17, 0, -0.681544], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-4.16334e-17, -0.316, -3.80928e-16, 0.707107, 0.707107, 1.20016e-16, -1.20355e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-2.01779e-16, -1.10319e-16, -2.92618e-16, 1, -3.50418e-17, -1.00654e-16, -1.41869e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -6.13991e-18, -1.47451e-16, 0.707107, 0.707107, 1.00523e-16, -5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.21484e-16, -1.5764e-17, 8.53317e-22, 0.31535, 2.77556e-17, 5.55112e-17, -0.948975], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -7.94839e-16, 0.707107, -0.707107, -7.29719e-18, -1.77724e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [4.17656e-16, 1.34491e-16, -9.9362e-16, 1, 6.20147e-17, -8.2395e-17, -5.49268e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, -8.18869e-18, -1.11022e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731596, -2.08167e-17, 2.77556e-17, 0.681738], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -4.16334e-17, -6.58732e-17, 0.707107, 0.707107, 2.77556e-17, -2.77556e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-8.21122e-17, 7.98809e-17, 2.08164e-16, 1, 3.44001e-18, -2.77556e-17, -0.000224835], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-7.63278e-17, -1.04253e-17, 0.107, 1, -4.74338e-20, 0, -9.42358e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [2.12562e-16, 5.44804e-20, -1.40203e-15, 1, 5.42101e-20, 0, -3.86349e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -1.52466e-17, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -1.38778e-17, 2.77556e-17, -6.59195e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-8.67362e-17, 0, 0.0584, 1, 1.38778e-17, -2.77556e-17, -6.93889e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-8.67362e-17, 0, 0.0584, 1, 1.38778e-17, -2.77556e-17, -6.93889e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [3.90313e-17, 0.04, -6.38378e-16, 1, 0, 0, -6.93889e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [1.70003e-16, -0.04, -2.5327e-16, 1, 0, 0, -6.93889e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-9.76331e-17, 4.02976e-16, -1.34966e-16, -1.03331e-13, 0, 0, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-1.68268e-16, -1.73695e-18, -0.15, 1, 8.67362e-19, 7.8564e-17, 1.38752e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [5.41234e-16, 0.02, -0.2, 1, 0, -1.31341e-18, 6.94016e-18], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -5.55112e-17, 5.55112e-17, -2.77556e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -6.93889e-17, 0, 0], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-1.03009e-16, -3.86594e-16, -0.04, 1, 1.249e-16, 2.77556e-17, 1.38778e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [8.67362e-19, 1.55134e-18, 0.01, 1, -4.74338e-20, 0, -9.42358e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-2.77556e-17, -7.84691e-18, 0.2105, 0, 0.92388, 0.382683, 9.11441e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 1.38778e-17, 2.94903e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.77556e-17, 0.008, 0.045, 1, 0, 0, -6.93889e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-9.19403e-17, -0.008, 0.045, 1, 0, 0, -6.93889e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_3_1(table): { pose: [0.45, -0.08, 0.088, 1, -4.66238e-11, 7.25788e-12, -9.30808e-12], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0.005], color: [0.2, 0.2, 0.9], logical: { is_object: True, is_box: True } }
shape_3_1_mesh(shape_3_1): { pose: [7.14995e-18, 0.001, 0.0325, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [0.2, 0.8, 1, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_1.obj", contact: 1, mass: 0.1, inertia: [0.000230943, -2.88191e-22, 5.73441e-22, 0.00016058, -2.55738e-12, 9.9969e-05], logical: { is_object: True, is_box: True } }
shape_3_1_handle(shape_3_1): { pose: [-1.36258e-18, 2.0695e-18, 0.065, 1, 0, -1.47809e-28, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_3_2(table): { pose: [0.45, 1.80415e-10, 0.088, 0.707107, -1.12618e-09, -7.5411e-10, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0.005], color: [0.2, 0.2, 0.9], logical: { is_object: True, is_box: True } }
shape_3_2_mesh(shape_3_2): { pose: [-1.04334e-17, 0.001, 0.0325, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [0.2, 0.8, 1, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_2.obj", contact: 1, mass: 0.1, inertia: [0.000230943, -2.88191e-22, 5.73441e-22, 0.00016058, -2.55738e-12, 9.9969e-05], logical: { is_object: True, is_box: True } }
shape_3_2_handle(shape_3_2): { pose: [7.75482e-26, -2.2418e-17, 0.065, 1, 1.03398e-25, 1.03398e-25, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_3_3(table): { pose: [0.45, 0.08, 0.088, 1, -2.32604e-10, 2.71777e-10, -7.93064e-11], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0.005], color: [0.2, 0.2, 0.9], logical: { is_object: True, is_box: True } }
shape_3_3_mesh(shape_3_3): { pose: [-4.22522e-17, 0.001, 0.0325, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [0.2, 0.8, 1, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_3.obj", contact: 1, mass: 0.1, inertia: [0.000230943, -2.88191e-22, 5.73441e-22, 0.00016058, -2.55738e-12, 9.9969e-05], logical: { is_object: True, is_box: True } }
shape_3_3_handle(shape_3_3): { pose: [5.88831e-18, 2.4066e-20, 0.065, 1, 0, -2.06737e-26, 0], shape: marker, size: [0.03], color: [1, 1, 0] }