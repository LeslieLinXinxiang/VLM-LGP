world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, 0, 0, 2.79993e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 1.38778e-17, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731701, 6.81521e-17, -5.55112e-17, -0.681626], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [0, -0.316, -6.20477e-16, 0.707107, 0.707107, 6.05036e-18, 2.17632e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-8.76406e-25, -2.21139e-18, 1.23524e-23, 1, 7.84571e-17, -2.02804e-17, -1.50946e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -9.54087e-18, -1.56125e-16, 0.707107, 0.707107, -5.75169e-17, -5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [0.315329, -1.66533e-16, 1.94289e-16, -0.948982], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -9.90424e-17, 0.707107, -0.707107, -2.09027e-17, -7.10195e-18] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.56855e-16, 3.22644e-17, -1.66679e-16, 1, -1.05879e-21, 6.22079e-17, -5.28187e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [1.87443e-18, -1.34119e-17, 2.91944e-18, 0.707107, 0.707107, 8.22874e-18, -5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731679, 2.77556e-17, -6.93889e-17, 0.681649], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 1.38778e-17, -6.35526e-19, 0.707107, 0.707107, -2.77556e-17, -2.77556e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [6.08937e-18, 1.99282e-17, 3.32664e-18, 1, -4.34839e-17, 0, -1.95067e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [9.71445e-17, -3.98946e-17, 0.107, 1, -1.69407e-21, 0, 3.84939e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [3.88113e-17, 2.10332e-17, -1.74993e-15, 1, 8.47033e-22, 0, 3.84319e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [2.43572e-17, 1.18464e-17, 1.33068e-17, 0.92388, 5.25838e-18, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [-7.48709e-23, 7.48648e-23, -4.41651e-28, 1, 0, 0, -1.56125e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-4.85723e-17, 2.08167e-17, 0.0584, 1, -1.38778e-17, 0, 1.31839e-16] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-4.85723e-17, 2.08167e-17, 0.0584, 1, -1.38778e-17, 0, 1.31839e-16] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [1.47451e-17, 0.04, -1.13277e-15, 1, 0, 0, 7.28584e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-3.20924e-17, -0.04, 1.10675e-15, 1, 0, 0, -3.81639e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.18964e-16, 1.36177e-16, 6.65269e-18, -1.03417e-13, 1.38778e-17, -1.38778e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-1.21431e-16, -7.8067e-18, -0.15, 1, 1.38776e-17, 5.10552e-17, 2.7756e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [5.96745e-16, 0.02, -0.2, 1, -6.93889e-18, -4.56926e-17, -2.86229e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 1.38778e-16, 8.32667e-17, 0], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 0, 0, 8.32667e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-2.4284e-17, -2.93886e-16, -0.04, 1, -2.35922e-16, 0, -2.77556e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [2.25514e-17, 2.87311e-17, 0.01, 1, -1.69407e-21, 0, 3.84939e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [8.32667e-17, -4.68337e-17, 0.2105, 2.77556e-17, 0.92388, 0.382683, 4.46729e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 2.77556e-17, 1.21431e-16], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.56125e-16, 0.008, 0.045, 1, 0, 2.77556e-17, 1.38778e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-4.68375e-17, -0.008, 0.045, 1, 0, 0, 7.63278e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_3_1(table): { pose: [0.45, -0.08, 0.088, 1, -1.72998e-12, -6.92641e-14, -3.12562e-13], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0.005], color: [0.2, 0.2, 0.9], logical: { is_object: True, is_box: True } }
shape_3_1_mesh(shape_3_1): { pose: [-8.73809e-18, 0.001, 0.0325, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [0.2, 0.8, 1, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_1.obj", contact: 1, mass: 0.1, inertia: [0.000230943, -2.88191e-22, 5.73441e-22, 0.00016058, -2.55738e-12, 9.9969e-05], logical: { is_object: True, is_box: True } }
shape_3_1_handle(shape_3_1): { pose: [1.15265e-17, 6.02921e-18, 0.065, 1, 0, -3.43189e-30, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_3_2(table): { pose: [0.45, 1.52797e-10, 0.088, 0.707107, 2.55766e-10, 1.27788e-10, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0.005], color: [0.2, 0.2, 0.9], logical: { is_object: True, is_box: True } }
shape_3_2_mesh(shape_3_2): { pose: [-7.32593e-18, 0.001, 0.0325, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [0.2, 0.8, 1, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_2.obj", contact: 1, mass: 0.1, inertia: [0.000230943, -2.88191e-22, 5.73441e-22, 0.00016058, -2.55738e-12, 9.9969e-05], logical: { is_object: True, is_box: True } }
shape_3_2_handle(shape_3_2): { pose: [-1.9387e-26, -2.53627e-17, 0.065, 1, 2.58494e-26, -2.58494e-26, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_3_3(table): { pose: [0.45, 0.0800001, 0.0880003, 1, 9.00949e-08, 1.60824e-07, -6.31873e-09], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0.005], color: [0.2, 0.2, 0.9], logical: { is_object: True, is_box: True } }
shape_3_3_mesh(shape_3_3): { pose: [6.77902e-17, 0.001, 0.0325, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [0.2, 0.8, 1, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_3.obj", contact: 1, mass: 0.1, inertia: [0.000230943, -2.88191e-22, 5.73441e-22, 0.00016058, -2.55738e-12, 9.9969e-05], logical: { is_object: True, is_box: True } }
shape_3_3_handle(shape_3_3): { pose: [-1.79607e-18, 4.17232e-18, 0.065, 1, 0, -9.34152e-24, 0], shape: marker, size: [0.03], color: [1, 1, 0] }