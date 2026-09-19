world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, 7.50005e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, -9.36751e-17, -8.1532e-17, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-5.86337e-16, -0.316, -3.96002e-16, 0.707107, 0.707107, 2.7929e-16, -5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [6.55192e-26, 6.17498e-18, -9.23932e-25, 1, -1.11022e-16, -5.55112e-17, 1.37843e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.54952e-16, -1.9082e-16, 0.707107, 0.707107, 0, 1.11022e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-1.07127e-24, 4.19836e-24, 2.80592e-17, 0.315322, -8.93383e-17, -2.77556e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -1.34316e-16, 0.707107, -0.707107, 4.16334e-17, -2.77556e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.86844e-16, -7.06566e-17, -1.19972e-16, 1, -2.77556e-17, -2.77556e-17, -4.52255e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-1.52652e-25, -3.05826e-18, -4.36476e-25, 0.707107, 0.707107, 1.94289e-16, -1.66533e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, 1.11022e-16, -8.32667e-17, 0.681638], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 1.38778e-17, 5.19894e-16, 0.707107, 0.707107, -2.22045e-16, -2.63678e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-4.87156e-17, 4.23772e-17, -2.66135e-17, 1, 9.71445e-17, 1.38778e-17, 4.26341e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [5.55112e-17, -3.90351e-17, 0.107, 1, 2.77556e-17, 1.38778e-17, 2.46331e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-2.79598e-17, 3.01344e-17, -1.28037e-15, 1, -2.77556e-17, 2.77556e-17, 6.93889e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-2.43578e-17, -1.97948e-17, -1.33067e-17, 0.92388, 2.77556e-17, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, 1.38778e-17, 3.46945e-18], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [1.73472e-17, 1.38778e-17, 0.0584, 1, 0, 0, 0] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [1.73472e-17, 1.38778e-17, 0.0584, 1, 0, 0, 0] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [9.19403e-17, 0.04, -8.36137e-16, 1, 0, 0, 0], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [6.93889e-18, -0.04, 4.19803e-16, 1, 0, 0, 0], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-3.43457e-17, 3.43458e-17, -1.92801e-24, -1.03438e-13, 0, 2.77556e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.06582e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [7.80626e-17, -7.22473e-17, -0.15, 1, -1.66533e-16, 8.32667e-17, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.94289e-16, 0.02, -0.2, 1, 0, -5.55112e-17, 0], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -1.80411e-16, -1.50704e-17, -3.1225e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-2.00834e-25, -4.86147e-25, 3.40629e-18, 1, 2.77556e-17, -1.38778e-16, -4.996e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [7.59879e-17, -2.33589e-16, -0.04, 1, -2.498e-16, -1.11022e-16, -1.66533e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [2.60209e-18, -8.32811e-18, 0.01, 1, 2.77556e-17, 1.38778e-17, 2.46331e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.66533e-16, -8.54948e-17, 0.2105, -1.38778e-17, 0.92388, 0.382683, 2.77556e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -2.77556e-17, 2.08167e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [9.71445e-17, 0.008, 0.045, 1, 0, 0, 0], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [1.38778e-17, -0.008, 0.045, 1, 0, 0, 0], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
rectprism_9(table): { pose: [0.4209, -0.0708, 0.065, 0.82085, -0, -0, -0.571143], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_9_Left(rectprism_9): { pose: [-0.026, -8.67362e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_9_Right(rectprism_9): { pose: [0.026, 8.67362e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3(table): { pose: [0.08, 0.1, 0.0665, 1, -6.26017e-12, -7.28965e-12, -1.19034e-12], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_3_Left(rectprism_3): { pose: [-0.026, -2.31937e-18, 0.016, 1, 0, 6.42896e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3_Right(rectprism_3): { pose: [0.026, 3.17338e-18, 0.016, 1, 0, 6.42896e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_7(table): { pose: [-0.4122, -0.0187, 0.065, 0.664448, 0, 0, 0.747334], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_7_Left(rectprism_7): { pose: [-0.026, -1.38778e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_7_Right(rectprism_7): { pose: [0.026, 1.38778e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2(table): { pose: [2.74669e-09, 0.1, 0.0665, 1, -7.67543e-09, -7.05899e-10, 2.5943e-09], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_2_Left(rectprism_2): { pose: [-0.026, 1.74773e-17, 0.016, 1, 0, 9.01173e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2_Right(rectprism_2): { pose: [0.026, 4.90255e-17, 0.016, 1, 0, 9.01173e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_8(table): { pose: [0.3332, -0.0489, 0.065, 0.420007, 0, 0, 0.907521], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_8_Left(rectprism_8): { pose: [-0.026, 1.12757e-16, 0.016, 1, -0, 0, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_8_Right(rectprism_8): { pose: [0.026, -1.05818e-16, 0.016, 1, -0, 0, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_11(table): { pose: [-0.305, 0.0247, 0.065, 0.715388, -0, -0, -0.698727], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_11_Left(rectprism_11): { pose: [-0.026, 1.35525e-17, 0.016, 1, 0, 0, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_11_Right(rectprism_11): { pose: [0.026, -1.35525e-17, 0.016, 1, 0, 0, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4(table): { pose: [-0.0799994, 0.1, 0.0965001, 1, -4.63994e-06, -1.94153e-06, -1.29563e-06], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_4_Left(rectprism_4): { pose: [-0.026, -1.79201e-17, 0.016, 1, 0, 1.74237e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4_Right(rectprism_4): { pose: [0.026, 2.5113e-17, 0.016, 1, 0, 1.74237e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_5(table): { pose: [-0.000379765, 0.100262, 0.0967819, 1, -0.00043674, -0.000700405, 0.000354932], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_5_Left(rectprism_5): { pose: [-0.026, 6.4732e-17, 0.016, 1, 0, 1.73562e-19, -1.0842e-19], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_5_Right(rectprism_5): { pose: [0.026, -6.33242e-17, 0.016, 1, 0, 1.73562e-19, -1.0842e-19], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1(table): { pose: [-0.08, 0.1, 0.0665, 1, -1.11633e-10, -4.24208e-11, -2.20674e-11], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1_Left(rectprism_1): { pose: [-0.026, -7.7822e-17, 0.016, 1, 0, 2.80244e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1_Right(rectprism_1): { pose: [0.026, 3.64108e-18, 0.016, 1, 0, 2.80244e-27, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_12(table): { pose: [-0.3367, -0.096, 0.065, 0.014573, 0, 0, 0.999894], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_12_Left(rectprism_12): { pose: [-0.026, -3.79471e-18, 0.016, 1, -0, 0, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_12_Right(rectprism_12): { pose: [0.026, 3.79471e-18, 0.016, 1, -0, 0, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_10(table): { pose: [0.3125, 0.036, 0.065, 0.563166, -0, -0, -0.826344], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_10_Left(rectprism_10): { pose: [-0.026, -2.06432e-16, 0.016, 1, 0, 0, -5.55112e-17], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_10_Right(rectprism_10): { pose: [0.026, 2.06432e-16, 0.016, 1, 0, 0, -5.55112e-17], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_6(table): { pose: [0.08, 0.1, 0.0965, 1, -6.45304e-12, -8.23472e-12, -1.74313e-12], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_6_Left(rectprism_6): { pose: [-0.026, 1.11525e-17, 0.016, 1, 0, 7.69989e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_6_Right(rectprism_6): { pose: [0.026, 1.11304e-17, 0.016, 1, 0, 7.69989e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }