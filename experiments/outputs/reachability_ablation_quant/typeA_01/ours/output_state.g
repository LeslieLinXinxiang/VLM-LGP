world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.96, 0.89, 0.72], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, 2.04677e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -1.11022e-16, 5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731689, 1.8735e-16, 7.11237e-17, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-4.996e-16, -0.316, -2.40312e-16, 0.707107, 0.707107, -3.98986e-17, -2.22045e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-7.85339e-18, 1.66374e-17, 1.10744e-16, 1, -8.32667e-17, -5.55112e-17, 2.76103e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.46335e-16, -7.02563e-17, 0.707107, 0.707107, 5.55112e-17, -5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.29342e-16, 9.50374e-17, 9.42864e-17, 0.315322, 6.245e-17, 5.55112e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 3.83087e-16, 0.707107, -0.707107, 6.93889e-17, -1.11022e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [5.60532e-16, -2.32393e-16, -3.59914e-16, 1, 5.55112e-17, -2.77556e-17, -1.4197e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [8.65788e-25, -1.71389e-17, -1.15677e-24, 0.707107, 0.707107, -3.33067e-16, -1.80411e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, 5.55112e-17, 2.77556e-17, 0.681638], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -4.3715e-16, 1.27186e-16, 0.707107, 0.707107, 1.52656e-16, -4.16334e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-3.4101e-16, 2.49707e-16, -1.86294e-16, 1, 4.16334e-17, 4.16334e-17, 3.17844e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [8.32667e-17, -9.97519e-17, 0.107, 1, -1.38778e-17, 2.77556e-17, 3.46945e-18] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.71495e-17, 1.02315e-16, -2.52081e-15, 1, 0, -2.77556e-17, 0] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 0, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -2.77556e-17, 4.16334e-17, -2.5327e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [4.85723e-17, -1.73472e-17, 0.0584, 1, 0, -1.38778e-17, -2.42861e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [4.85723e-17, -1.73472e-17, 0.0584, 1, 0, -1.38778e-17, -2.42861e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-3.29597e-17, 0.04, -1.42941e-15, 1, 0, 0, -2.08167e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [1.03216e-16, -0.04, 5.16948e-16, 1, 0, 0, -2.08167e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.20312e-16, 5.14174e-17, -2.66134e-17, -1.03407e-13, -2.77556e-17, -2.77556e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 5.32908e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-1.17961e-16, -1.2379e-16, -0.15, 1, -5.55112e-17, 2.77556e-17, 1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [2.22045e-16, 0.02, -0.2, 1, 0, 2.77556e-17, 0], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -4.16334e-17, 2.60209e-17, -1.2837e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-5.02785e-26, 1.53399e-25, -2.27278e-18, 1, 1.66533e-16, -4.16334e-17, -2.22045e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.40686e-16, -2.86694e-16, -0.04, 1, 5.55112e-17, 5.55112e-17, 0], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [5.55112e-17, -6.76251e-18, 0.01, 1, -1.38778e-17, 2.77556e-17, 3.46945e-18], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [6.93889e-17, -1.98127e-16, 0.2105, 2.77556e-17, 0.92388, 0.382683, 4.16334e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -2.77556e-17, 4.16334e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [7.80626e-17, 0.008, 0.045, 1, 0, 0, -2.08167e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-6.76542e-17, -0.008, 0.045, 1, 0, 0, -2.08167e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
cube_1(table): { pose: [-0.08, 0.1, 0.0665, 1, -1.25179e-09, -5.58995e-10, 5.3355e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [2.50209e-11, 0.1, 0.0665, 1, -8.69494e-11, 1.67942e-11, 1.9765e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [0.08, 0.1, 0.0665, 1, -9.03537e-11, -7.09725e-11, -2.36972e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [-0.2598, -0.15, 0.065], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
filler_1(table): { pose: [-0.2338, -0.165, 0.065], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }