world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.656878, 0, 0, -0.753997], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -5.55112e-17, 5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.657827, -5.55112e-17, 0, -0.753169], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-4.85723e-17, -0.316, -7.1858e-17, 0.707107, 0.707107, -5.55112e-17, -2.56739e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-2.2448e-17, 9.07205e-18, -1.65347e-16, 0.672378, -7.97973e-17, 1.22298e-16, 0.740208], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -1.04083e-17, 7.15573e-18, 0.707107, 0.707107, -6.93889e-18, 1.38778e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.73183e-17, -3.76858e-18, -3.14359e-18, 0.376146, 2.77556e-17, 7.63278e-17, -0.92656], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 3.18105e-16, 0.707107, -0.707107, 1.38778e-17, 8.32667e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [8.99699e-17, 4.06834e-18, -3.48367e-16, 0.647693, 5.55112e-17, -6.93889e-17, 0.761901], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [1.73686e-19, -4.08667e-18, 5.6051e-18, 0.707107, 0.707107, 1.11022e-16, 2.22045e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.720861, 5.55112e-17, 1.11022e-16, 0.693079], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 1.86916e-16, -1.07957e-16, 0.707107, 0.707107, 6.33174e-17, 2.80592e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-6.06837e-17, -4.50588e-17, 1.11531e-16, 0.720242, -1.75641e-17, -1.0777e-16, -0.693723], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [2.47469e-17, 6.72205e-18, 0.107, 1, 2.1684e-19, -2.1684e-19, 2.83925e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-5.44457e-18, -5.19128e-18, -1.22124e-15, 1, 1.0842e-19, 2.1684e-19, 2.83925e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-3.87353e-18, 5.7569e-18, -4.66281e-20, 0.92388, -1.0842e-19, 1.16552e-18, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 2.71051e-20, -7.58942e-19, 1.81788e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [5.63785e-18, 8.13694e-17, 0.0584, 1, 4.33681e-19, 5.14996e-19, 1.52545e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [5.63785e-18, 8.13694e-17, 0.0584, 1, 4.33681e-19, 5.14996e-19, 1.52545e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-3.69677e-17, 0.04, -6.96329e-16, 1, 4.87891e-19, 4.87891e-19, 1.52546e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [2.5501e-17, -0.04, 2.52185e-16, 1, 4.33681e-19, 5.14996e-19, 1.52544e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.26801e-16, 2.1404e-16, -2.78302e-18, -1.03235e-13, 0, -4.33681e-19, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [4.51028e-17, 5.89806e-17, -0.15, 1, -1.27936e-17, -1.26635e-16, 8.1532e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [4.96998e-16, 0.02, -0.2, 1, 0, 1.249e-16, 2.22045e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 6.21248e-17, 1.66533e-16, -6.93889e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 0, -2.77556e-17, 1.11022e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-9.48024e-17, -1.50203e-16, -0.04, 1, 1.80411e-16, -8.32667e-17, 8.32667e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [1.27902e-17, 5.09575e-18, 0.01, 1, 2.1684e-19, -2.1684e-19, 2.83925e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-1.2902e-17, 1.51788e-18, 0.2105, 2.32832e-17, 0.92388, 0.382683, 5.65411e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -1.11022e-16, -1.51355e-16], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.0795e-16, 0.008, 0.045, 1, 4.87891e-19, 4.60786e-19, 1.52547e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-2.3061e-16, -0.008, 0.045, 1, 4.87891e-19, 5.14996e-19, 1.52545e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_2_1(table): { pose: [0.509, 1.19621e-08, 0.0885, 0.707107, -1.00541e-08, 4.72187e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_2_2(table): { pose: [0.389, 1.85262e-09, 0.0885, 0.707107, -2.95399e-09, 2.81382e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 1, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_2.obj", contact: 1, mass: 0.1, inertia: [2.18118e-05, 0.00035027, 0.00035027], logical: { is_object: True, is_box: True } }
shape_4_1(table): { pose: [0.45, -1.46868e-09, 0.088, 0.707107, -1.63911e-09, 1.81603e-09, -0.707107], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_1_mesh(shape_4_1): { pose: [3.23117e-26, -8.80276e-18, 0.0275, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_1_handle(shape_4_1): { pose: [-9.85508e-26, -8.65613e-19, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_4_2(table): { pose: [-0.1553, 0.1631, 0.0625, 0.443306, 0, 0, 0.89637], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0], color: [1, 0.5, 0.2], logical: { is_object: True } }
shape_4_2_mesh(shape_4_2): { pose: [0, 0, 0.0275, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [1, 0.5, 0.2, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj", contact: 1, mass: 0.1, inertia: [0.000205608, 0.000175411, 6.1141e-05], logical: { is_object: True, is_box: True } }
shape_4_2_handle(shape_4_2): { pose: [0, 0, 0.05], shape: marker, size: [0.03], color: [1, 1, 0] }