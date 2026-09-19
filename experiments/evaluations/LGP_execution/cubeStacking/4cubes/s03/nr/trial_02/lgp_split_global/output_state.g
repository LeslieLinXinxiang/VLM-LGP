world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, 6.07218e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -1.11022e-16, 1.11022e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, -3.1225e-17, 6.93889e-18, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-2.32453e-16, -0.316, -2.87599e-16, 0.707107, 0.707107, 9.19403e-17, -1.11022e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [1.91237e-25, 2.22617e-17, -2.69677e-24, 1, -2.77556e-17, -1.11022e-16, 1.5831e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.56105e-16, -1.68268e-16, 0.707107, 0.707107, -2.77556e-16, -5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.37195e-16, 2.05782e-16, 1.05993e-16, 0.315322, 1.10155e-16, 2.77556e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -9.27962e-17, 0.707107, -0.707107, -2.35922e-16, 3.88578e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [5.60532e-16, -3.17172e-16, -3.59915e-16, 1, 8.32667e-17, -8.32667e-17, -1.56302e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [6.07366e-26, 6.75589e-18, 8.18408e-25, 0.707107, 0.707107, 2.498e-16, 2.22045e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, 5.55112e-17, 8.32667e-17, 0.681638], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.53884e-16, 3.09647e-16, 0.707107, 0.707107, -5.55112e-17, -1.38778e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-4.96179e-16, 2.7274e-16, -1.80455e-17, 1, -4.16334e-17, 8.32667e-17, 4.33501e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [6.93889e-17, -1.41818e-16, 0.107, 1, 0, -2.77556e-17, -1.73472e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.38943e-16, 1.44518e-16, -2.45428e-15, 1, 0, 2.77556e-17, 0] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [2.46675e-30, 3.30872e-24, -1.31819e-33, 0.92388, 2.77556e-17, -2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, -4.16334e-17, -5.55112e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [2.77556e-17, -3.81639e-17, 0.0584, 1, -2.77556e-17, 1.38778e-17, 1.38778e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [2.77556e-17, -3.81639e-17, 0.0584, 1, -2.77556e-17, 1.38778e-17, 1.38778e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [4.0766e-17, 0.04, -1.29237e-15, 1, 0, 0, 1.38778e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-1.21431e-17, -0.04, 3.52149e-16, 1, 0, 0, 1.38778e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.59614e-16, 5.62735e-17, -3.99202e-17, -1.03428e-13, -1.38778e-17, -2.77556e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 7.10544e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-1.38778e-17, -2.0784e-16, -0.15, 1, -1.11022e-16, -8.32667e-17, -1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [2.63678e-16, 0.02, -0.2, 1, 5.55112e-17, 2.77556e-17, 1.66533e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 4.16334e-17, -5.09575e-18, 3.1225e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-2.74452e-25, -8.26004e-25, 6.81859e-18, 1, 2.77556e-17, 2.77556e-17, 1.94289e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.20651e-16, -3.97013e-16, -0.04, 1, -2.22045e-16, 0, 5.55112e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-2.68882e-17, -9.44164e-18, 0.01, 1, 0, -2.77556e-17, -1.73472e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.66533e-16, -2.74574e-16, 0.2105, 5.55112e-17, 0.92388, 0.382683, 6.93889e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 2.77556e-17, -2.08167e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.61329e-16, 0.008, 0.045, 1, 0, 0, 1.38778e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.02349e-16, -0.008, 0.045, 1, 0, 0, 1.38778e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
cube_3(table): { pose: [-0.08, 0.1, 0.0965, 1, -5.45456e-09, -1.46292e-09, -6.53015e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [0.08, 0.1, 0.0965, 1, -2.64196e-09, 3.52859e-10, -2.74922e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [0.08, 0.1, 0.0665, 1, 3.21642e-10, 4.9003e-10, -7.11283e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [-0.08, 0.1, 0.0665, 1, 5.71011e-11, 2.02738e-11, -3.86274e-12], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }