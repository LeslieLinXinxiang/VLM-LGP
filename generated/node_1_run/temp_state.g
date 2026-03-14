world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.910688, -0, 0, -0.413096], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -2.77556e-17, 8.32667e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.997661, -4.16334e-17, 0, 0.0683593], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-2.01228e-16, -0.316, -5.78765e-16, 0.707107, 0.707107, 5.55112e-17, 2.77556e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-8.86898e-17, 3.1364e-17, -2.36351e-16, 0.999093, 4.51028e-17, -6.93889e-18, -0.042579], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -1.4672e-16, -9.19403e-17, 0.707107, 0.707107, 1.38778e-16, -5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.73537e-17, -3.91797e-18, 1.41205e-17, 0.13828, 0, 1.11022e-16, -0.990393], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 4.39752e-16, 0.707107, -0.707107, -1.22298e-16, -1.35308e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.09873e-16, 6.71791e-16, -8.08495e-16, 0.999153, -4.16334e-17, 4.85723e-17, 0.0411568], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [7.71283e-18, 1.45829e-17, -1.13244e-16, 0.707107, 0.707107, -2.22045e-16, -2.08167e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [2.33796e-17, -3.33253e-18, -1.45828e-17, 0.0707372, 0, -1.73472e-17, 0.997495], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -2.1267e-16, 4.32567e-17, 0.707107, 0.707107, 6.70126e-17, -7.00666e-18] }
l_panda_joint7(l_panda_joint7_origin): { pose: [1.80657e-17, 7.63974e-17, -1.11022e-16, 0.616716, 7.40587e-17, 9.81796e-18, -0.787186], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [1.43966e-17, -1.71969e-17, 0.107, 1, -1.27055e-21, 8.47033e-22, -5.62257e-18] }
l_panda_joint8(l_panda_joint8_origin): { pose: [4.96819e-21, -1.236e-20, -2.22045e-15, 1, 4.23516e-22, 0, 4.98886e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -2.11758e-22, -2.11758e-22, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 6.35275e-22, 2.81241e-22, 3.65583e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-2.68944e-17, 6.59087e-18, 0.0584, 1, 0, -1.86116e-22, 1.29065e-19] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-2.68944e-17, 6.59087e-18, 0.0584, 1, 0, -1.86116e-22, 1.29065e-19] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-1.69811e-17, 0.04, -1.25727e-15, 1, 0, -1.86116e-22, 1.29065e-19], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [1.70403e-17, -0.04, 3.69094e-16, 1, 0, -1.86116e-22, 1.29065e-19], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.03412e-13, 4.23516e-22, 1.96869e-22, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 3.55272e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-3.46945e-18, 5.89806e-17, -0.15, 1, 5.55112e-17, 5.89806e-17, 5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [5.20417e-17, 0.02, -0.2, 1, 1.38778e-17, -2.25514e-17, -1.2837e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 0, 8.32667e-17, 0], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 0, -5.55112e-17, 2.77556e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.05553e-16, 4.32363e-17, -0.04, 1, 6.93889e-17, -8.32667e-17, -5.55112e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-6.03208e-18, 1.23555e-17, 0.01, 1, -1.27055e-21, 8.47033e-22, -5.62257e-18], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-8.19414e-18, -3.26828e-18, 0.2105, 2.34315e-17, 0.92388, 0.382683, 5.65704e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 1.73472e-18, -6.11981e-19], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-6.56186e-19, 0.008, 0.045, 1, 0, -1.86116e-22, 1.29065e-19], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [5.04205e-17, -0.008, 0.045, 1, 0, -1.86116e-22, 1.29065e-19], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
rect_7(table): { pose: [0.3, -0.1, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0, 0.9, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_5(table): { pose: [0.3, 0, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0, 0.7, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_8(table): { pose: [0.45, -0.1, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0, 0.5, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_3(table): { pose: [0.3, 0.1, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.2, 0.3, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_6(table): { pose: [0.45, 0, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.9, 0, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_1(table): { pose: [-0.0500064, 0.0499946, 0.0665057, 1, -1.67538e-06, 1.16073e-07, 0.000103329], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.7, 0, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_4(table): { pose: [0.45, 0.1, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.5, 0, 0.8], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_2(table): { pose: [0.0499946, 0.049996, 0.0665104, 1, -3.05868e-06, 7.40879e-07, 0.0001822], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.3, 0, 0.7], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
cyl_2(table): { pose: [-0.3, -0.1, 0.065], joint: rigid, shape: cylinder, size: [0.03, 0.015], color: [0, 0.8, 0], contact: 1, mass: 0.2, inertia: [4.31924e-05, 4.31924e-05, 3.66427e-05], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl_1(table): { pose: [-0.3, 0, 0.065], joint: rigid, shape: cylinder, size: [0.03, 0.015], color: [0.4, 1, 0.2], contact: 1, mass: 0.2, inertia: [4.31924e-05, 4.31924e-05, 3.66427e-05], logical: { is_object: True, is_cylinder: True, is_place: True } }
cube_4(table): { pose: [-0.45, -0.1, 0.065], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 0.5, 0], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [-0.3, 0.1, 0.065], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 0.8, 0], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [-0.45, 0, 0.065], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.3, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [0.284994, -0.100006, 0.0960073, 1, -5.69761e-07, 1.77229e-06, 5.25031e-07], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.8, 0.1, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
tri_1(table): { pose: [-0.45, 0.1, 0.05], joint: rigid, shape: mesh, color: [1, 0.4, 0.7], mesh: "/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", contact: 1, mass: 0.2, inertia: [3.61846e-05, 3.20675e-05, 5.23466e-05], logical: { is_object: True, is_place: True } }
Base_Center(table): { pose: [0, 0.05, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Left(table): { pose: [-0.08, 0.05, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Right(table): { pose: [0.08, 0.05, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Top(table): { pose: [0, -0.03, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Bottom(table): { pose: [0, 0.13, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Table_Left(table): { pose: [-0.05, 0.05, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.05, 0.05, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Rect_1_Left(rect_7): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_1_Right(rect_7): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_2_Left(rect_5): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_2_Right(rect_5): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_3_Left(rect_8): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_3_Right(rect_8): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_4_Left(rect_3): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_4_Right(rect_3): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_5_Left(rect_6): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_5_Right(rect_6): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_6_Left(rect_1): { pose: [-0.015, 2.43374e-18, 0.0155, 1, 2.1176e-22, 5.73857e-24, -1.35525e-20], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_6_Right(rect_1): { pose: [0.015, 1.07078e-17, 0.0155, 1, 2.1176e-22, 5.73857e-24, -1.35525e-20], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_7_Left(rect_4): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_7_Right(rect_4): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_8_Left(rect_2): { pose: [-0.015, 9.67572e-18, 0.0155, 1, 0, 3.2777e-23, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_8_Right(rect_2): { pose: [0.015, 9.81301e-19, 0.0155, 1, 0, 3.2777e-23, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }