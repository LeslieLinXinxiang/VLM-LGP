world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.96, 0.89, 0.72], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, 2.10946e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -5.55112e-17, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731689, 6.76542e-17, 6.76542e-17, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-2.84495e-16, -0.316, -1.91397e-16, 0.707107, 0.707107, 1.9082e-17, -1.11022e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [3.3967e-26, 1.13818e-17, -4.78983e-25, 1, -2.77556e-17, 0, 1.97521e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -1.28565e-16, -1.21431e-17, 0.707107, 0.707107, 2.77556e-16, 2.22045e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-1.60114e-24, 1.58588e-24, 3.76842e-17, 0.315322, 1.15359e-16, 0, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 1.86802e-16, 0.707107, -0.707107, -1.38778e-17, -1.11022e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.86844e-16, -1.53845e-16, -1.19971e-16, 1, 8.32667e-17, 0, -4.49106e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [1.41334e-25, -7.9242e-18, -4.68661e-25, 0.707107, 0.707107, 0, 5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.73169, 0, 2.77556e-17, 0.681638], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.33067e-16, 1.58877e-16, 0.707107, 0.707107, 1.249e-16, -6.93889e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.46147e-16, 9.55963e-17, -7.98402e-17, 1, 2.77556e-17, -1.11022e-16, 2.72815e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [6.93889e-17, -3.75892e-17, 0.107, 1, 0, 1.38778e-17, -1.73472e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-2.79624e-17, 4.19528e-17, -1.28037e-15, 1, 0, 1.38778e-17, -1.73472e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-1.04894e-32, 3.30872e-24, 7.27085e-32, 0.92388, -2.77556e-17, 5.55112e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 2.77556e-17, 0, -5.55112e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [1.38778e-17, -1.73472e-17, 0.0584] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [1.38778e-17, -1.73472e-17, 0.0584] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [2.34188e-17, 0.04, -9.28077e-16], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [3.55618e-17, -0.04, 4.83988e-16], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-5.15693e-17, 1.71222e-17, -1.33067e-17, -1.03435e-13, -2.77556e-17, -2.08167e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 5.32908e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-6.07153e-17, -7.08498e-17, -0.15, 1, -2.77556e-17, -2.77556e-17, 2.77556e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.38778e-16, 0.02, -0.2, 1, -5.55112e-17, 0, -5.55112e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 6.93889e-18, -1.37911e-16, 0], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-2.27002e-26, 1.51639e-25, -2.56394e-18, 1, 2.22045e-16, -7.63278e-17, -1.94289e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [5.5288e-17, -3.04035e-16, -0.04, 1, 5.55112e-17, 2.22045e-16, 0], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [2.94903e-17, -5.49004e-18, 0.01, 1, 0, 1.38778e-17, -1.73472e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [8.32667e-17, -8.49208e-17, 0.2105, 4.16334e-17, 0.92388, 0.382683, 4.16334e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, 4.85723e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.04083e-17, 0.008, 0.045], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-8.67362e-18, -0.008, 0.045], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
cube_1(table): { pose: [-0.08, 0.1, 0.0665, 1, -1.25179e-09, -5.58995e-10, 5.3355e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [2.50209e-11, 0.1, 0.0665, 1, -8.69494e-11, 1.67942e-11, 1.9765e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [-0.25, 0.133, 0.065], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [0.08, 0.0999999, 0.0665004, 1, -8.49836e-08, -1.03869e-08, 2.1377e-08], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
obstacle_1(table): { pose: [-0.3348, -0.241, 0.125, 0.766044, 0, 0, 0.642788], joint: rigid, shape: ssBox, size: [0.2, 0.02, 0.15, 0.002], color: [0.55, 0.55, 0.55, 0.85], contact: 1, mass: 1, inertia: [0.0229, 0.0625, 0.0404], logical: { is_place: True } }