world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.998506, 0, 0, 0.05465], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, -6.93889e-18] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.984139, -8.23994e-17, 1.38778e-17, 0.177401], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-1.38778e-17, -0.316, -6.90377e-17, 0.707107, 0.707107, -3.46945e-17, -6.245e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [1.16572e-17, -4.49765e-18, -2.32615e-16, 0.999069, -2.60209e-18, -3.60768e-17, -0.0431328], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, 2.81893e-18, -9.71445e-17, 0.707107, 0.707107, 2.86229e-17, -4.16334e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.81309e-20, -6.61062e-20, 1.73324e-18, 0.298354, 0, 0, -0.954455], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 2.22045e-16, 0.707107, -0.707107, -1.30104e-17, -1.45283e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [2.53911e-16, 3.89306e-16, -3.06358e-16, 0.998174, -8.67362e-19, 6.7085e-18, 0.0604041], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [5.35438e-17, -4.91315e-18, -1.37991e-17, 0.707107, 0.707107, -3.46945e-18, 2.77556e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [7.4339e-20, -1.9158e-20, -8.63958e-19, 0.125779, -6.93889e-18, -5.55112e-17, 0.992058], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 4.66517e-17, -9.66234e-20, 0.707107, 0.707107, -4.09757e-18, 2.60939e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-7.59163e-19, -8.54374e-18, 2.73259e-24, 0.904508, 1.52227e-16, 6.94127e-17, -0.426456], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-8.10812e-18, -8.22432e-18, 0.107, 1, -1.05879e-22, 0, 3.29749e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [5.72633e-22, 4.04353e-22, -5.55112e-16, 1, 5.29396e-23, 0, -2.25363e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [1.88498e-23, -1.85832e-23, 8.43276e-30, 0.92388, 5.29396e-23, -1.05879e-22, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, 0, 4.76807e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-1.68718e-19, 2.36824e-17, 0.0584, 1, 0, 0, 4.76807e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-1.68718e-19, 2.36824e-17, 0.0584, 1, 0, 0, 4.76807e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-4.27964e-17, 0.04, -1.75284e-16, 1, 0, 0, 4.76807e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [4.27965e-17, -0.04, -2.68805e-16, 1, 0, 0, 4.76807e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-6.49579e-17, 5.505e-17, 4.84279e-23, -1.03481e-13, 0, -2.64698e-23, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [2.77556e-17, 4.33681e-18, -0.15, 1, -2.1684e-18, 2.13317e-17, -3.46945e-18], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [6.245e-17, 0.02, -0.2, 1, 0, -2.71051e-18, 1.7022e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 5.55112e-17, 0, -2.77556e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 5.55112e-17, -6.93889e-18, -1.38778e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.09789e-17, 2.7577e-18, -0.04, 1, 6.50521e-19, -1.38778e-17, 1.38778e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-1.82405e-17, -1.85021e-17, 0.01, 1, -1.05879e-22, 0, 3.29749e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-1.9008e-17, 6.86814e-18, 0.2105, 2.34327e-17, 0.92388, 0.382683, 5.65713e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 1.11022e-16, 1.01829e-16], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [5.65934e-17, 0.008, 0.045, 1, 0, 0, 4.76807e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-5.64248e-17, -0.008, 0.045, 1, 0, 0, 4.76807e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, -1.77636e-17, 0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, 1.77636e-17, -0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_2_1(table): { pose: [0.45, -9.38899e-12, 0.0885, 0.707107, -7.17972e-11, -1.38774e-11, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_2_2(table): { pose: [0.3858, -0.4184, 0.063, 0.728969, -0, 0, -0.684547], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_2.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
cube_4(table): { pose: [0.1664, 0.4331, 0.0625, 0.807578, -0, -0, -0.58976], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_1_mesh(cube_4): { pose: [0, 0, 0.0275, 0.707107, 0.707107, -5.55112e-17, 0], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_1_handle(cube_4): { pose: [0, 0, 0.06, 1, 0, 0, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
cube_1(table): { pose: [-0.1556, -0.2153, 0.0625, 0.48885, -0, -0, -0.872368], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_2_mesh(cube_1): { pose: [0, 0, 0.0275, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_2_handle(cube_1): { pose: [0, 0, 0.06], shape: marker, size: [0.03], color: [1, 1, 0] }
cube_2(table): { pose: [0.0794, 0.3082, 0.0625, 0.332573, -0, -0, -0.943078], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_3_mesh(cube_2): { pose: [0, 0, 0.0275, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_3.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_3_handle(cube_2): { pose: [0, 0, 0.06], shape: marker, size: [0.03], color: [1, 1, 0] }
cube_3(table): { pose: [0.2268, -0.2859, 0.0625, 0.648784, -0, -0, -0.760972], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_4_mesh(cube_3): { pose: [0, 0, 0.0275, 0.707107, 0.707107, 5.55112e-17, 0], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_4.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_4_handle(cube_3): { pose: [0, 0, 0.06], shape: marker, size: [0.03], color: [1, 1, 0] }