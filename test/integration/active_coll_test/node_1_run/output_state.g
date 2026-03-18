world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, -0.000309353], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 1.11022e-16, -1.11022e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.732122, -2.60209e-17, -6.41848e-17, -0.681173], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-2.67147e-16, -0.316, -1.27032e-15, 0.707107, 0.707107, 0, 0] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-7.99545e-18, 2.59251e-17, 1.1075e-16, 1, -5.55112e-17, -8.32667e-17, 0.00035952], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -7.18636e-16, 1.60462e-16, 0.707107, 0.707107, 2.22045e-16, -1.11022e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.37538e-16, 2.05405e-16, 1.20638e-16, 0.315245, -6.93889e-18, -2.77556e-17, -0.94901], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 9.0726e-16, 0.707107, -0.707107, 1.11022e-16, -1.66533e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [6.51117e-16, -3.20514e-16, -2.18817e-16, 1, 2.77556e-17, -5.55112e-17, 0.000202892], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [5.98458e-17, 1.12601e-17, 9.3507e-17, 0.707107, 0.707107, 4.16334e-17, -3.46945e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.73131, 0, 0, 0.682045], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -9.22873e-16, 5.59574e-16, 0.707107, 0.707107, -2.77556e-17, 1.80411e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-4.38476e-16, 3.33783e-16, -2.39213e-16, 1, 6.93889e-17, 6.93889e-17, -0.00058212], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [5.55112e-17, -1.54296e-16, 0.107, 1, 0, -1.38778e-17, -1.94289e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.05584e-16, 1.63949e-16, -5.00166e-15, 1, 0, -2.77556e-17, -2.42861e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 0, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, -1.38778e-17, 2.42861e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [4.85723e-17, -3.46945e-17, 0.0584, 1, 0, 0, 2.77556e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [4.85723e-17, -3.46945e-17, 0.0584, 1, 0, 0, 2.77556e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [3.90313e-17, 0.04, -2.77729e-15, 1, 0, 0, 2.77556e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [1.18829e-16, -0.04, 1.44849e-15, 1, 0, 0, 2.77556e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.04282e-16, 1.16699e-16, -2.48015e-16, -1.0341e-13, 0, -2.77556e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.59874e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, -1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.09288e-16, -2.12793e-16, -0.15, 1, 0, 0, -2.22045e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [6.245e-16, 0.02, -0.2, 1, 5.55112e-17, 5.55112e-17, -3.33067e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -1.66533e-16, -1.86591e-16, 7.97973e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [6.26276e-21, 6.25611e-22, 6.88468e-18, 1, -2.77556e-17, -1.11022e-16, -2.77556e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [3.82053e-16, -2.65968e-17, -0.04, 1, 5.55112e-17, -1.66533e-16, 1.11022e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [1.38778e-17, -1.33154e-17, 0.01, 1, 0, -1.38778e-17, -1.94289e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.249e-16, -3.04119e-16, 0.2105, 1.38778e-17, 0.92388, 0.382683, 9.71445e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, -6.93889e-18], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.01228e-16, 0.008, 0.045, 1, 0, 0, 2.77556e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-9.36751e-17, -0.008, 0.045, 1, 0, 0, 2.77556e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
rect_1(table): { pose: [-0.0500586, 0.0500582, 0.067876, 0.999983, -0.000187479, -5.6405e-05, -0.00578487], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0, 0.9, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_2(table): { pose: [0.0499934, 0.0499932, 0.0664998, 1, -6.28531e-08, 1.34337e-07, 8.27147e-06], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0, 0.7, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_3(table): { pose: [-4.00502e-05, 0.0499337, 0.128879, 1, -2.33536e-08, -3.9118e-07, 3.5486e-07], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0, 0.5, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_4(table): { pose: [-4.63186e-05, 0.0499262, 0.158882, 1, -1.80914e-07, 6.39452e-07, 6.05833e-05], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.2, 0.3, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_5(table): { pose: [0.45, 0, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.9, 0, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_6(table): { pose: [0.3, 0.2, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.7, 0, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_7(table): { pose: [0.45, 0.1, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.5, 0, 0.8], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_8(table): { pose: [0.45, 0.2, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.3, 0, 0.7], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
cyl_1(table): { pose: [-0.3, -0.1, 0.065], joint: rigid, shape: cylinder, size: [0.03, 0.015], color: [0, 0.8, 0], contact: 1, mass: 0.2, inertia: [4.31924e-05, 4.31924e-05, 3.66427e-05], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl_2(table): { pose: [-0.3, 0, 0.065], joint: rigid, shape: cylinder, size: [0.03, 0.015], color: [0.4, 1, 0.2], contact: 1, mass: 0.2, inertia: [4.31924e-05, 4.31924e-05, 3.66427e-05], logical: { is_object: True, is_cylinder: True, is_place: True } }
cube_1(table): { pose: [-0.0650664, 0.0502307, 0.0988741, 0.999983, -5.57345e-07, -4.99414e-08, -0.00579673], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 0.5, 0], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [-0.0350682, 0.0498829, 0.098879, 0.999983, -3.74447e-07, -1.51152e-07, -0.00576702], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 0.8, 0], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [0.0349862, 0.0499861, 0.097499, 1, -3.91857e-08, 3.17938e-09, -2.15312e-05], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.3, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [0.0649862, 0.0499857, 0.0975026, 1, 1.00031e-09, -1.78274e-08, 3.06759e-05], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.8, 0.1, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
tri_1(table): { pose: [-9.45117e-05, 0.0495874, 0.175188, 0.999995, -2.12221e-05, 2.32847e-05, 0.00310828], joint: rigid, shape: mesh, color: [1, 0.4, 0.7], mesh: "/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", contact: 1, mass: 0.2, inertia: [3.61846e-05, 3.20675e-05, 5.23466e-05], logical: { is_object: True, is_place: True } }
Base_Center(table): { pose: [0, 0.05, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Left(table): { pose: [-0.08, 0.05, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Right(table): { pose: [0.08, 0.05, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Top(table): { pose: [0, -0.03, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Bottom(table): { pose: [0, 0.13, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Table_Left(table): { pose: [-0.05, 0.05, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.05, 0.05, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Rect_1_Left(rect_1): { pose: [-0.015, -6.0817e-17, 0.0155, 1, 0, -1.05879e-21, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_1_Right(rect_1): { pose: [0.015, -1.24683e-18, 0.0155, 1, 0, -1.05879e-21, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_2_Left(rect_2): { pose: [-0.015, 8.15499e-19, 0.0155, 1, 0, 3.72615e-24, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_2_Right(rect_2): { pose: [0.015, -5.41603e-17, 0.0155, 1, 0, 3.72615e-24, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_3_Left(rect_3): { pose: [-0.015, -8.79442e-18, 0.0155, 1, 0, -1.35021e-24, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_3_Right(rect_3): { pose: [0.015, 2.10965e-18, 0.0155, 1, 0, -1.35021e-24, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_4_Left(rect_4): { pose: [-0.015, -2.75508e-18, 0.0155, 1, 0, 1.23835e-23, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_4_Right(rect_4): { pose: [0.015, -3.22077e-18, 0.0155, 1, 0, 1.23835e-23, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_5_Left(rect_5): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_5_Right(rect_5): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_6_Left(rect_6): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_6_Right(rect_6): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_7_Left(rect_7): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_7_Right(rect_7): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_8_Left(rect_8): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_8_Right(rect_8): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }