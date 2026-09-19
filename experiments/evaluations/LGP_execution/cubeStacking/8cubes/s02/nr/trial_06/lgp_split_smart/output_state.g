world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, -9.3405e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -5.55112e-17, 5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731676, -6.59195e-17, -6.93889e-18, -0.681652], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [5.55112e-16, -0.316, -5.42312e-16, 0.707107, 0.707107, 1.78677e-16, 0] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-7.8494e-18, 5.00725e-18, 1.10745e-16, 1, 8.32667e-17, 1.38778e-16, -9.28478e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -4.92319e-16, -1.38778e-16, 0.707107, 0.707107, 1.11022e-16, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [5.25922e-22, -6.50546e-21, 3.49113e-17, 0.3153, -1.1189e-16, -5.55112e-17, -0.948992], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 6.00209e-16, 0.707107, -0.707107, -3.05311e-16, 1.66533e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.56862e-16, -8.52147e-17, -1.66667e-16, 1, 8.32667e-17, 2.77556e-17, 4.48455e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-2.99923e-17, 3.84208e-18, -4.6712e-17, 0.707107, 0.707107, -1.11022e-16, 3.33067e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731675, -5.55112e-17, 4.16334e-17, 0.681654], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -4.30211e-16, 2.88529e-16, 0.707107, 0.707107, -1.66533e-16, 4.16334e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.94841e-16, 1.17506e-16, -1.0646e-16, 1, 4.16334e-17, 2.77556e-17, -5.11153e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [3.46945e-17, -5.73772e-17, 0.107, 1, -2.77556e-17, -1.38778e-17, 2.60209e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-4.39003e-18, 7.53543e-17, -3.2917e-15, 1, 1.38778e-17, 0, -7.63278e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-1.84497e-22, -3.27294e-18, 4.78704e-24, 0.92388, 5.55112e-17, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -2.77556e-17, 1.38778e-17, -8.67362e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [7.97973e-17, 2.08167e-17, 0.0584, 1, 0, 0, -8.32667e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [7.97973e-17, 2.08167e-17, 0.0584, 1, 0, 0, -8.32667e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [3.46945e-18, 0.04, -1.66533e-15, 1, 0, 0, -2.42861e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [6.93889e-18, -0.04, 1.19696e-15, 1, 0, 0, -2.42861e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.25214e-16, 5.63316e-17, -2.66151e-17, -1.03289e-13, -1.38778e-17, 6.93889e-18, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.4211e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-4.7011e-16, 6.03229e-16, -0.15, 1, -1.11022e-16, -1.66533e-16, 1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [2.23432e-15, 0.02, -0.2, 1, 8.32667e-17, -2.77556e-17, 1.11022e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -2.42861e-16, 4.71411e-16, 1.04083e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-5.99731e-17, -9.34045e-17, 1.14967e-16, 1, 0, -1.38778e-17, 3.60822e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.06861e-16, -2.57186e-16, -0.04, 1, -8.32667e-17, -1.66533e-16, -8.32667e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [1.73472e-17, 9.29973e-18, 0.01, 1, -2.77556e-17, -1.38778e-17, 2.60209e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [8.32667e-17, -1.26005e-16, 0.2105, 0, 0.92388, 0.382683, 1.38778e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, 6.93889e-18], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [9.54098e-17, 0.008, 0.045, 1, 0, 0, -2.42861e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.14492e-16, -0.008, 0.045, 1, 0, 0, -2.42861e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
cube_1(table): { pose: [-0.0259466, 0.100077, 0.12756, 1, -5.16699e-05, 6.8117e-06, 4.17183e-05], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [0.0260534, 0.100082, 0.127559, 1, -5.16387e-05, 6.82034e-06, 4.17191e-05], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_5(table): { pose: [5.29703e-05, 0.10008, 0.157561, 1, -5.21357e-05, 6.67339e-06, 4.11335e-05], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_5_Left(rectprism_5): { pose: [-0.026, 1.20829e-18, 0.016, 1, -5.16988e-26, -1.0468e-21, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_5_Right(rectprism_5): { pose: [0.026, 1.02982e-17, 0.016, 1, -5.16988e-26, -1.0468e-21, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1(table): { pose: [-0.08, 0.1, 0.0665, 1, -3.93433e-12, 1.46459e-14, 4.48945e-13], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_1_Left(rectprism_1): { pose: [-0.026, 3.4319e-18, 0.016, 1, 0, -3.49737e-31, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_1_Right(rectprism_1): { pose: [0.026, -1.96991e-18, 0.016, 1, 0, -3.49737e-31, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4(table): { pose: [5.31824e-05, 0.100078, 0.0965592, 1, -5.16386e-05, 6.82032e-06, 4.17191e-05], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_4_Left(rectprism_4): { pose: [-0.026, 2.66417e-17, 0.016, 1, 0, -2.52704e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_4_Right(rectprism_4): { pose: [0.026, -9.20655e-17, 0.016, 1, 0, -2.52704e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3(table): { pose: [0.0800004, 0.0999997, 0.0664997, 1, -3.82163e-07, 4.19086e-07, -4.2175e-07], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_3_Left(rectprism_3): { pose: [-0.026, -4.6299e-18, 0.016, 1, 1.26218e-28, -3.66452e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_3_Right(rectprism_3): { pose: [0.026, -1.9602e-17, 0.016, 1, 1.26218e-28, -3.66452e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2(table): { pose: [5.31822e-05, 0.100078, 0.0665592, 1, -5.16384e-05, 6.82025e-06, 4.1719e-05], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
rectprism_2_Left(rectprism_2): { pose: [-0.026, -2.78147e-17, 0.016, 1, 0, -1.98937e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rectprism_2_Right(rectprism_2): { pose: [0.026, -6.8061e-17, 0.016, 1, 0, -1.98937e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
triprism_1(table): { pose: [5.29718e-05, 0.10008, 0.182561, 1, -5.21428e-05, 6.67354e-06, 4.11334e-05], joint: rigid, shape: mesh, color: [0.9, 0.6, 0.1], mesh: "/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", contact: 1, mass: 0.2, inertia: [3.61846e-05, 3.20675e-05, 5.23466e-05], logical: { is_object: True, is_box: True } }