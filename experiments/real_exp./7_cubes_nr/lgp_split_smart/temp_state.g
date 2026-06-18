world: {  }
base(world): { pose: [0, 0, 0.545], shape: ssBox, size: [1.3, 1, 0.11, 0.02], color: [0.45, 0.45, 0.45], contact: 1 }
table(base): { pose: [0, 0.25, 0.11], shape: ssBox, size: [1, 0.8, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(base): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.993377, -0, 0, 0.114905], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.959203, 0, 0, 0.282718], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [8.32667e-17, -0.316, -3.53546e-17, 0.707107, 0.707107, -5.55112e-17, -1.11022e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-1.09522e-16, 5.19482e-17, -7.07036e-17, 0.992126, -8.32667e-17, 1.11022e-16, -0.125243], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -7.80626e-18, -4.16334e-17, 0.707107, 0.707107, 2.77556e-17, 5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-5.85234e-17, -3.74996e-17, 5.63565e-18, 0.614293, 0, 5.55112e-17, -0.789078], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 2.22045e-16, 0.707107, -0.707107, 6.93889e-18, 2.77556e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-1.82281e-16, 2.50206e-16, -1.82832e-16, 0.995294, 8.32667e-17, -2.77556e-17, 0.0969055], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, 5.55112e-17, 1.38778e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.37724, 5.55112e-17, 1.38778e-17, 0.926116], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -5.74949e-17, -2.02289e-17, 0.707107, 0.707107, 4.82386e-17, 6.74975e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.10594e-16, 1.07154e-16, -1.11022e-16, 0.898673, 5.81613e-18, -1.03193e-18, -0.43862], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [8.65954e-18, 8.67728e-18, 0.107, 1, -3.30872e-24, -1.65436e-24, 1.0449e-18] }
l_panda_joint8(l_panda_joint8_origin): { pose: [2.19081e-23, 3.22636e-23, -7.77156e-16, 1, 0, 0, 1.0449e-18] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 3.30872e-24, -1.65436e-24, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, -1.6786e-24, -5.597e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-2.15083e-20, 2.10096e-17, 0.0584, 1, 0, -8.07794e-27, -2.51708e-20] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-2.15083e-20, 2.10096e-17, 0.0584, 1, 0, -8.07794e-27, -2.51708e-20] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [1.12569e-19, 0.04, -4.81559e-16, 1, 0, -8.07794e-27, -2.51708e-20], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-1.12569e-19, -0.04, -4.06619e-16, 1, 0, -8.07794e-27, -2.51708e-20], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [1.55854e-19, 1.59554e-22, 1.15306e-28, -1.03412e-13, 5.16988e-26, 1.85767e-24, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 4.62223e-33, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [2.77556e-17, 4.85723e-17, -0.15, 1, -1.38778e-17, 0, -5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [6.93889e-17, 0.02, -0.2, 1, 8.32667e-17, -2.77556e-17, 0], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 0, 0, -2.77556e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-7.37287e-19, -5.88613e-19, -6.87446e-18, 1, 2.77556e-17, 1.38778e-17, 5.55112e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [6.9516e-17, 3.85466e-17, -0.04, 1, 2.77556e-17, 0, 1.11022e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-1.75598e-18, -1.75958e-18, 0.01, 1, -3.30872e-24, -1.65436e-24, 1.0449e-18], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-2.83124e-17, -2.53882e-18, 0.2105, 2.34326e-17, 0.92388, 0.382683, 5.65713e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, 2.54001e-21], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-1.71241e-19, 0.008, 0.045, 1, 0, -8.07794e-27, -2.51708e-20], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [1.33726e-19, -0.008, 0.045, 1, 0, -8.07794e-27, -2.51708e-20], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
cube_2(table): { pose: [-0.202, 0.0488, 0.065, 0.0381262, 0, 0, 0.999273], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [0.2325, -0.0445, 0.065, 0.731175, -0, -0, -0.68219], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [-0.2691, 0.1565, 0.065, 0.652892, -0, -0, -0.757451], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
longrect_1(table): { pose: [1.30407e-12, 0.1, 0.0665, 1, 9.32431e-14, 1.38071e-12, 1.49486e-12], joint: rigid, shape: ssBox, size: [0.095, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.6, inertia: [0.00108, 0.005955, 0.005955], logical: { is_object: True, is_box: True, is_place: True } }
longrect_1_Left(longrect_1): { pose: [-0.038, -3.59966e-17, 0.016, 1, 0, 4.08045e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_1_Right(longrect_1): { pose: [0.038, 8.35365e-18, 0.016, 1, 0, 4.08045e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_1_Center(longrect_1): { pose: [-3.78653e-29, -1.38215e-17, 0.016, 1, 0, 4.08045e-29, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_2(table): { pose: [-0.423, 0.1103, 0.065, 0.432479, -0, -0, -0.901644], joint: rigid, shape: ssBox, size: [0.095, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.6, inertia: [0.00108, 0.005955, 0.005955], logical: { is_object: True, is_box: True, is_place: True } }
longrect_2_Left(longrect_2): { pose: [-0.038, -3.46945e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_2_Right(longrect_2): { pose: [0.038, 3.46945e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_2_Center(longrect_2): { pose: [0, 0, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
rect_1(table): { pose: [0.366, -0.0512, 0.065, 0.960488, -0, -0, -0.278321], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
cube_3_Left(rect_1): { pose: [-0.026, 1.73472e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
cube_3_Right(rect_1): { pose: [0.026, -1.73472e-18, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
tri_1(table): { pose: [-0.4362, -0.0975, 0.065, 0.93185, -0, -0, -0.362845], joint: rigid, shape: mesh, color: [0.9, 0.6, 0.1], mesh: "/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", contact: 1, mass: 0.2, inertia: [3.61846e-05, 3.20675e-05, 5.23466e-05], logical: { is_object: True, is_box: True } }