world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.995241, 0, 0, -0.0974457], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 1.38778e-17, -1.38778e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.995902, -4.43439e-17, -1.51788e-17, 0.0904396], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [1.04083e-16, -0.316, -2.63395e-16, 0.707107, 0.707107, 2.77556e-17, 0] }
l_panda_joint3(l_panda_joint3_origin): { pose: [3.3097e-19, -1.70178e-18, 6.06117e-20, 0.99996, -1.14492e-16, 8.34836e-18, 0.00899727], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, 2.51399e-18, -8.67362e-18, 0.707107, 0.707107, -4.29344e-17, 2.77556e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [0.294661, 5.42101e-18, -1.11022e-16, -0.955602], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -7.1991e-17, 0.707107, -0.707107, 5.72459e-17, -6.15827e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.17949e-16, 8.96742e-17, -5.19457e-17, 0.999992, 1.04083e-17, -5.65954e-17, -0.00400721], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [2.14871e-18, 1.36773e-17, -9.5221e-19, 0.707107, 0.707107, 0, 2.77556e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.207044, -6.93889e-18, -6.245e-17, 0.978332], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 4.44217e-17, -4.54806e-18, 0.707107, 0.707107, -4.24152e-18, 3.28763e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.35025e-18, -1.36773e-17, -9.61972e-23, 0.88802, -1.00009e-16, -4.74381e-17, -0.459805], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-1.12383e-17, -3.23863e-18, 0.107, 1, -6.35275e-21, -2.5411e-20, -2.54484e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [9.81359e-18, -9.80494e-18, -7.77156e-16, 1, -1.34466e-20, -1.82112e-20, -2.54484e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -6.05099e-20, -3.03344e-20, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 4.04458e-20, 5.76512e-20, -3.34103e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [6.30854e-18, 5.67739e-17, 0.0584, 1, -1.37643e-20, -2.3664e-20, -3.34103e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [6.30854e-18, 5.67739e-17, 0.0584, 1, -1.37643e-20, -2.3664e-20, -3.34103e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-2.30845e-17, 0.04, -4.42683e-16, 1, -3.4146e-20, -1.68348e-20, -3.34103e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [2.3083e-17, -0.04, 2.20638e-16, 1, 3.33519e-20, 1.60936e-20, -3.34103e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.52652e-16, 1.66537e-16, 2.43062e-21, -1.03395e-13, 2.11758e-21, 2.71051e-20, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [6.59195e-17, 1.46367e-18, -0.15, 1, 3.46945e-18, -2.25514e-17, -1.38778e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [9.71445e-17, 0.02, -0.2, 1, 6.93889e-18, 7.15573e-18, 1.43115e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -2.05998e-18, 2.9924e-17, 4.0766e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 0, 0, -9.02056e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.19237e-17, -9.50466e-18, -0.04, 1, 1.30104e-18, -2.77556e-17, 1.38778e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-3.25145e-18, -3.97106e-18, 0.01, 1, -6.35275e-21, -2.5411e-20, -2.54484e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.23188e-18, 1.94441e-17, 0.2105, 2.34542e-17, 0.92388, 0.382683, 5.6576e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -5.55112e-17, -8.54068e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.64214e-16, 0.008, 0.045, 1, -2.68933e-20, 3.97047e-21, -3.34103e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.59622e-16, -0.008, 0.045, 1, -2.71051e-20, 7.67624e-21, -3.34103e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_2_2(table): { pose: [0.389, 1.52304e-11, 0.0885, 0.707107, -2.94257e-09, 4.8278e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_2_1(table): { pose: [0.509, -3.72625e-08, 0.0885002, 0.707107, -2.04186e-08, 3.53264e-08, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_2.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_4_3(table): { pose: [0.3086, -0.3934, 0.0625, 0.985645, -0, -0, -0.168833], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_1_mesh(shape_4_3): { pose: [0, 0, 0.0275, 0.707107, 0.707107, -1.38778e-17, 0], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_1_handle(shape_4_3): { pose: [0, 0, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_2(table): { pose: [-0.1766, 0.4097, 0.0625, 0.0507672, 0, 0, 0.998711], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_2_mesh(shape_4_2): { pose: [0, 0, 0.0275, 0.707107, 0.707107, 0, -6.93889e-18], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_2_handle(shape_4_2): { pose: [0, 0, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_1(table): { pose: [0.45, -0.08, 0.088, 0.707107, 1.16371e-11, 8.11425e-11, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_3_mesh(shape_4_1): { pose: [-1.241e-18, -8.26423e-18, 0.0275, 0.707107, 0.707107, -6.92017e-18, 5.55112e-17], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_3.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_3_handle(shape_4_1): { pose: [4.05172e-18, 2.02994e-17, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }