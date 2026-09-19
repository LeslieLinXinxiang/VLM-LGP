world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, 4.87101e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 5.55112e-17, -2.22045e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731689, -1.73472e-18, -3.46945e-18, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-8.08381e-16, -0.316, -9.82669e-16, 0.707107, 0.707107, -2.68882e-16, 5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [1.06188e-22, 1.54092e-17, -1.49741e-21, 1, 5.55112e-17, 5.55112e-17, 4.41771e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -5.06973e-16, -3.55618e-17, 0.707107, 0.707107, 0, 1.66533e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-4.1248e-21, 4.20841e-21, 4.33071e-17, 0.315336, -8.41341e-17, 0, -0.94898], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 1.06012e-15, 0.707107, -0.707107, -2.22045e-16, 1.66533e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [3.73683e-16, -1.30685e-16, -2.39971e-16, 1, 8.32667e-17, 5.55112e-17, 1.46262e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [2.10843e-22, -1.38541e-17, -1.86828e-21, 0.707107, 0.707107, -2.498e-16, 1.52656e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731452, -5.55112e-17, 5.55112e-17, 0.681893], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -6.59195e-16, 5.77563e-16, 0.707107, 0.707107, 2.77556e-17, -1.11022e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.43507e-16, 1.91116e-16, -1.33239e-16, 1, -6.93889e-17, 4.16334e-17, -1.3848e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [3.46945e-17, -1.04382e-16, 0.107, 1, 0, 1.38778e-17, -1.66533e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [8.33785e-17, 1.05991e-16, -4.25738e-15, 1, 0, 0, 3.46945e-18] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 0, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -2.77556e-17, 1.38778e-17, 2.77556e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-3.46945e-18, -6.245e-17, 0.0584, 1, 0, 1.38778e-17, -1.73472e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-3.46945e-18, -6.245e-17, 0.0584, 1, 0, 1.38778e-17, -1.73472e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-6.67869e-17, 0.04, -2.18575e-15, 1, 0, 0, -1.73472e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [1.4138e-16, -0.04, 1.27155e-15, 1, 0, 0, -1.73472e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.12946e-16, 4.40535e-17, -2.6646e-17, -1.03358e-13, -1.38778e-17, -3.46945e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.24346e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, -1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-6.41848e-17, 4.37165e-17, -0.15, 1, 5.55112e-17, 0, 5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [2.91434e-16, 0.02, -0.2, 1, 0, 2.77556e-17, -1.66533e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 1.17961e-16, -2.14238e-16, -6.93889e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [2.443e-22, -1.81574e-21, 1.34644e-17, 1, 1.94289e-16, 1.04083e-16, 2.77556e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.86303e-16, -1.44074e-16, -0.04, 1, -1.38778e-16, 0, 5.55112e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [2.1684e-17, -1.00287e-17, 0.01, 1, 0, 1.38778e-17, -1.66533e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.66533e-16, -2.07398e-16, 0.2105, 1.38778e-17, 0.92388, 0.382683, 5.55112e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 2.77556e-17, 2.77556e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.21431e-17, 0.008, 0.045, 1, 0, 0, -1.73472e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.50921e-16, -0.008, 0.045, 1, 0, 0, -1.73472e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
cube_2(table): { pose: [0.08, 0.1, 0.0665, 1, -1.44277e-11, 2.11311e-11, 1.99591e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_5(table): { pose: [-0.08, 0.0999999, 0.1265, 1, -9.89819e-08, -2.27138e-08, -2.17766e-08], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [-0.08, 0.1, 0.0665, 1, -4.41053e-09, 3.08936e-09, -3.28277e-09], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [0.08, 0.1, 0.0965, 1, -1.67552e-11, 8.43203e-12, 1.22042e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [-0.08, 0.1, 0.0965, 1, -4.41534e-09, 3.1139e-09, -3.26826e-09], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_6(table): { pose: [0.08, 0.1, 0.1265, 1, -5.3922e-09, 3.1906e-09, 1.27652e-09], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1(table): { pose: [-0.0800001, 0.1, 0.066501, 1, -9.22795e-07, -1.80936e-07, -8.73496e-09], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1_Left(rectprism_1): { pose: [-0.026, -1.65144e-17, 0.016, 1, 0, -3.46476e-24, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1_Right(rectprism_1): { pose: [0.026, 2.12389e-17, 0.016, 1, 0, -3.46476e-24, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }