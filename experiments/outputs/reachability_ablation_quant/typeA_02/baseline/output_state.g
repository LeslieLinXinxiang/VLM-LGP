world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.96, 0.89, 0.72], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, 9.15029e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -1.66533e-16, 1.66533e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731683, -7.28584e-17, -9.02056e-17, -0.681646], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-1.52656e-16, -0.316, -1.13554e-16, 0.707107, 0.707107, -1.9082e-17, -5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [4.36804e-25, 3.37511e-18, -6.16118e-24, 1, 2.77556e-17, -2.77556e-17, 2.57805e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.31645e-16, -5.29091e-17, 0.707107, 0.707107, -5.55112e-17, 2.22045e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.67192e-22, 9.22807e-23, 5.05516e-17, 0.315328, -8.67362e-19, -5.55112e-17, -0.948983], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 2.41339e-16, 0.707107, -0.707107, -4.16334e-17, -1.66533e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [4.03676e-16, -1.68192e-16, -1.93244e-16, 1, -2.77556e-17, -1.11022e-16, -2.84271e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [2.87436e-23, -3.25621e-18, -1.50624e-23, 0.707107, 0.707107, -2.22045e-16, -1.38778e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731743, -5.55112e-17, 0, 0.681581], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -2.63678e-16, 2.00697e-16, 0.707107, 0.707107, 9.71445e-17, -1.11022e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.43596e-16, 1.97169e-16, -1.33034e-16, 1, -6.93889e-17, -2.77556e-17, 8.62758e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [0, -9.14957e-17, 0.107, 1, 2.77556e-17, 2.77556e-17, 4.16334e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.05278e-16, 9.55343e-17, -2.21951e-15, 1, -1.38778e-17, -1.38778e-17, 3.46945e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 0, -2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -5.55112e-17, 2.77556e-17, 6.59195e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-1.73472e-17, -7.63278e-17, 0.0584, 1, -2.77556e-17, 0, 3.46945e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-1.73472e-17, -7.63278e-17, 0.0584, 1, -2.77556e-17, 0, 3.46945e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [3.1225e-17, 0.04, -1.4537e-15, 1, 0, 0, 6.93889e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [4.0766e-17, -0.04, 5.39499e-16, 1, 0, 0, 6.93889e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.22767e-16, 5.38701e-17, -2.66061e-17, -1.03431e-13, 0, -2.77556e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 5.32908e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-1.04083e-17, -6.62472e-17, -0.15, 1, -8.32667e-17, -5.55112e-17, 1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [2.91434e-16, 0.02, -0.2, 1, -2.77556e-17, -5.55112e-17, -5.55112e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -2.77556e-17, -8.5652e-18, -1.73472e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-7.1392e-24, 1.05108e-23, -2.27225e-18, 1, 2.22045e-16, -9.02056e-17, -2.22045e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [8.49657e-17, -3.7801e-16, -0.04, 1, 2.77556e-17, 5.55112e-17, 2.77556e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [5.72459e-17, -7.99499e-18, 0.01, 1, 2.77556e-17, 2.77556e-17, 4.16334e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [9.71445e-17, -1.96791e-16, 0.2105, -2.77556e-17, 0.92388, 0.382683, 0], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 5.55112e-17, -6.93889e-18], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.40513e-16, 0.008, 0.045, 1, 0, 0, 6.93889e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.23165e-16, -0.008, 0.045, 1, 0, 0, 6.93889e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
cube_1(table): { pose: [-0.08, 0.1, 0.0665, 1, -1.25179e-09, -5.58995e-10, 5.3355e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [2.50209e-11, 0.1, 0.0665, 1, -8.69494e-11, 1.67942e-11, 1.9765e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [-0.25, 0.133, 0.065], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [0.08, 0.1, 0.0665, 1, -1.16827e-11, 4.38821e-12, -1.19968e-12], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
filler_1(table): { pose: [-0.2659, -0.2531, 0.065], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }