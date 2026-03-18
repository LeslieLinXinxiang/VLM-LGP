world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.801317, -0, 0, -0.598239], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.870617, 9.02056e-17, 0, 0.491961], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-2.77556e-17, -0.316, 4.21506e-17, 0.707107, 0.707107, -2.77556e-17, -5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [6.40882e-17, -4.33343e-17, -3.23957e-16, 0.846892, 0, -2.77556e-17, 0.531765], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, 0, 6.59195e-17, 0.707107, 0.707107, 1.21431e-16, 2.77556e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-7.72098e-17, -2.02728e-17, 2.36857e-17, 0.308432, 1.11022e-16, 8.32667e-17, -0.951246], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 2.22045e-16, 0.707107, -0.707107, 8.32667e-17, -1.80411e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-3.48271e-16, 3.05112e-16, -3.27261e-16, 0.707729, 0, -1.11022e-16, -0.706484], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [1.98472e-18, 6.19782e-18, -2.40752e-18, 0.707107, 0.707107, 2.77556e-17, -5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [1.97147e-18, -2.39094e-18, 1.56007e-18, 0.426525, 5.55112e-17, -5.55112e-17, 0.904476], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -4.15167e-17, -1.87074e-19, 0.707107, 0.707107, -2.29055e-17, 3.03793e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-3.53658e-16, 3.82059e-17, 6.58995e-21, 0.983986, 5.54637e-17, -1.47358e-17, 0.178247], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-5.37175e-18, -3.66172e-18, 0.107, 1, 0, -1.69407e-21, -6.74822e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [4.71022e-18, -5.07164e-18, -5.55112e-16, 1, 0, 0, -1.19711e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 3.38813e-21, 8.47033e-22, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, -4.02341e-21, 8.09943e-18], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-1.99286e-18, -4.08249e-18, 0.0584, 1, 0, -5.29396e-22, 1.16054e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-1.99286e-18, -4.08249e-18, 0.0584, 1, 0, -5.29396e-22, 1.16054e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-2.71089e-18, 0.04, -1.39909e-16, 1, 0, -5.29396e-22, 1.16054e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [2.05369e-18, -0.04, -8.21361e-17, 1, 0, -5.29396e-22, 1.16054e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [2.73283e-19, 6.93351e-18, 2.1313e-22, -1.03409e-13, 0, 8.99973e-22, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 4.62223e-33, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.31839e-16, -6.245e-17, -0.15, 1, -5.55112e-17, -9.71445e-17, 5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [-1.249e-16, 0.02, -0.2, 1, -2.77556e-17, 5.55112e-17, 6.93889e-18], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -1.11022e-16, 5.55112e-17, -2.77556e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 0, -2.77556e-17, -9.71445e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.77485e-17, 1.93134e-17, -0.04, 1, 0, 0, 1.38778e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [1.41808e-18, 6.35804e-19, 0.01, 1, 0, -1.69407e-21, -6.74822e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-2.25468e-17, 1.08217e-17, 0.2105, 2.34357e-17, 0.92388, 0.382683, 5.65733e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, 1.57548e-19], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-2.12965e-18, 0.008, 0.045, 1, 0, -5.29396e-22, 1.16054e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-6.11558e-19, -0.008, 0.045, 1, 0, -5.29396e-22, 1.16054e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
rect_1(table): { pose: [-0.0500214, 0.0999846, 0.066484, 0.999996, 6.04822e-06, -4.4204e-06, -0.00269848], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0, 0.9, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_2(table): { pose: [0.3, 0, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0, 0.7, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_3(table): { pose: [0.45, -0.1, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0, 0.5, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_4(table): { pose: [0.3, 0.1, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.2, 0.3, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_5(table): { pose: [0.45, 0, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.9, 0, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_6(table): { pose: [0.3, 0.2, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.7, 0, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_7(table): { pose: [0.45, 0.1, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.5, 0, 0.8], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_8(table): { pose: [0.45, 0.2, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.3, 0, 0.7], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
cyl_1(table): { pose: [-0.3, -0.1, 0.065], joint: rigid, shape: cylinder, size: [0.03, 0.015], color: [0, 0.8, 0], contact: 1, mass: 0.2, inertia: [4.31924e-05, 4.31924e-05, 3.66427e-05], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl_2(table): { pose: [-0.3, 0, 0.065], joint: rigid, shape: cylinder, size: [0.03, 0.015], color: [0.4, 1, 0.2], contact: 1, mass: 0.2, inertia: [4.31924e-05, 4.31924e-05, 3.66427e-05], logical: { is_object: True, is_cylinder: True, is_place: True } }
cube_1(table): { pose: [-0.45, -0.1, 0.065], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 0.5, 0], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [-0.3, 0.1, 0.065], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 0.8, 0], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [-0.45, 0, 0.065], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.3, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [-0.3, 0.2, 0.065], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.8, 0.1, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
tri_1(table): { pose: [-0.45, 0.1, 0.05], joint: rigid, shape: mesh, color: [1, 0.4, 0.7], mesh: "/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", contact: 1, mass: 0.2, inertia: [3.61846e-05, 3.20675e-05, 5.23466e-05], logical: { is_object: True, is_place: True } }
Base_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Top(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Bottom(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Table_Left(table): { pose: [-0.05, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.05, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Rect_1_Left(rect_1): { pose: [-0.015, 9.9303e-18, 0.0155, 1, 0, 9.92617e-24, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_1_Right(rect_1): { pose: [0.015, 7.35807e-19, 0.0155, 1, 0, 9.92617e-24, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_2_Left(rect_2): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_2_Right(rect_2): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_3_Left(rect_3): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_3_Right(rect_3): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_4_Left(rect_4): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_4_Right(rect_4): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_5_Left(rect_5): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_5_Right(rect_5): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_6_Left(rect_6): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_6_Right(rect_6): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_7_Left(rect_7): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_7_Right(rect_7): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_8_Left(rect_8): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_8_Right(rect_8): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }