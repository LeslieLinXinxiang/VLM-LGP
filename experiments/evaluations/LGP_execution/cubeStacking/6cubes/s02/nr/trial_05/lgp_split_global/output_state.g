world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, 1.42724e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 5.55112e-17, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, -3.81639e-17, -1.21431e-17, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-6.2797e-16, -0.316, -7.24408e-16, 0.707107, 0.707107, 1.249e-16, 0] }
l_panda_joint3(l_panda_joint3_origin): { pose: [2.98653e-25, 1.47912e-17, -4.21154e-24, 1, 0, -2.77556e-17, 2.7926e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -4.58843e-16, -1.04083e-17, 0.707107, 0.707107, -1.11022e-16, 5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-7.85323e-18, 1.10744e-16, 5.85388e-17, 0.315322, -8.32667e-17, 5.55112e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -1.79285e-16, 0.707107, -0.707107, -1.38778e-17, -1.11022e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.86844e-16, -1.76366e-16, -1.19972e-16, 1, 5.55112e-17, -2.77556e-17, 3.79092e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-2.15576e-25, -1.84151e-18, -5.03877e-25, 0.707107, 0.707107, -3.05311e-16, -1.38778e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, 0, -1.38778e-17, 0.681638], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -4.85723e-16, 6.40788e-16, 0.707107, 0.707107, -6.93889e-17, 1.80411e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-4.87156e-17, 2.95344e-17, -2.66135e-17, 1, 2.77556e-17, 2.77556e-17, 5.5795e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [0, -1.05017e-17, 0.107, 1, 0, -2.77556e-17, 1.49186e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-5.23176e-17, 3.24177e-18, -1.29367e-15, 1, 1.38778e-17, 0, -1.8735e-16] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 2.77556e-17, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, -4.16334e-17, 4.16334e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-1.38778e-17, -2.08167e-17, 0.0584, 1, -2.77556e-17, 1.38778e-17, 4.85723e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-1.38778e-17, -2.08167e-17, 0.0584, 1, -2.77556e-17, 1.38778e-17, 4.85723e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [4.25007e-17, 0.04, -8.03177e-16, 1, 0, 0, -1.04083e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-8.06646e-17, -0.04, 7.77156e-16, 1, 0, 0, -1.04083e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.71729e-17, 1.71729e-17, -2.36586e-24, -1.03337e-13, 1.38778e-17, -3.46945e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.06582e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.23165e-16, 3.45678e-18, -0.15, 1, 0, -5.55112e-17, 1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.52656e-16, 0.02, -0.2, 1, 2.77556e-17, -2.77556e-17, -1.11022e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -1.38778e-17, 1.37802e-16, -7.63278e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 0, 6.93889e-17, -5.55112e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.38519e-17, -3.0698e-16, -0.04, 1, -2.22045e-16, 1.11022e-16, -5.55112e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-3.90313e-17, 3.24575e-19, 0.01, 1, 0, -2.77556e-17, 1.49186e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [9.71445e-17, -4.31835e-18, 0.2105, 5.55112e-17, 0.92388, 0.382683, 6.93889e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 8.32667e-17, -1.38778e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [3.81639e-17, 0.008, 0.045, 1, 0, 0, -1.04083e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-3.64292e-17, -0.008, 0.045, 1, 0, 0, -1.04083e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
cube_2(table): { pose: [-0.054, 0.1, 0.0975, 1, 4.56268e-10, 6.98073e-10, -1.24635e-09], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [0.106, 0.1, 0.0975, 1, -2.44701e-09, 2.47118e-09, 1.26253e-09], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [-0.106, 0.1, 0.0975, 1, 1.59484e-09, 1.12362e-09, -6.9995e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [0.054, 0.1, 0.0975, 1, -4.88562e-09, -1.23548e-09, -1.25901e-09], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_2(table): { pose: [0.08, 0.1, 0.0665, 1, 1.71975e-09, -7.96027e-10, 2.36973e-10], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_2_Left(rectprism_2): { pose: [-0.026, -3.98228e-17, 0.016, 1, 0, 6.53314e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2_Right(rectprism_2): { pose: [0.026, -2.91351e-17, 0.016, 1, 0, 6.53314e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1(table): { pose: [-0.08, 0.1, 0.0665, 1, 1.67147e-09, 1.09822e-09, -7.37522e-10], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1_Left(rectprism_1): { pose: [-0.026, 3.58205e-18, 0.016, 1, 0, -7.80183e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1_Right(rectprism_1): { pose: [0.026, 6.34887e-17, 0.016, 1, 0, -7.80183e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }