world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, 4.33196e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 5.55112e-17, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, 5.72459e-17, 2.08167e-17, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-7.25114e-16, -0.316, -5.54102e-16, 0.707107, 0.707107, 2.51535e-16, 1.66533e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [7.85324e-18, 6.94531e-18, -1.10744e-16, 1, -8.32667e-17, 2.77556e-17, 6.70561e-10], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -6.14402e-16, -1.14492e-16, 0.707107, 0.707107, -3.33067e-16, -4.996e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-1.99487e-25, 2.30803e-24, 2.67065e-17, 0.315322, -4.85723e-17, -5.55112e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 9.38295e-16, 0.707107, -0.707107, -2.22045e-16, -1.66533e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [2.4683e-16, -1.7378e-16, -2.65496e-17, 1, 2.77556e-17, 0, 3.60223e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [5.48574e-25, 1.03619e-17, 7.63743e-25, 0.707107, 0.707107, 8.32667e-17, 1.38778e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, 1.11022e-16, -4.16334e-17, 0.681638], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -1.05471e-15, 6.04975e-16, 0.707107, 0.707107, 1.52656e-16, -5.55112e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.92294e-16, 2.25537e-16, -1.59681e-16, 1, 1.38778e-17, 0, 4.72141e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [1.04083e-16, -1.17218e-16, 0.107, 1, 1.38778e-17, 2.77556e-17, -1.249e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.38051e-16, 1.18551e-16, -4.47892e-15, 1, 1.38778e-17, 0, 9.71445e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 2.77556e-17, -5.55112e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 2.77556e-17, 2.77556e-17, -1.07553e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [6.93889e-18, -5.20417e-17, 0.0584, 1, 0, 0, -5.55112e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [6.93889e-18, -5.20417e-17, 0.0584, 1, 0, 0, -5.55112e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [7.80626e-18, 0.04, -2.64545e-15, 1, 0, 0, 3.46945e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [5.89806e-17, -0.04, 1.73299e-15, 1, 0, 0, 3.46945e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.25218e-16, 5.63241e-17, -2.66135e-17, -1.03424e-13, -2.77556e-17, -1.38778e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.4211e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [5.20417e-18, -1.60468e-17, -0.15, 1, 8.32667e-17, 2.77556e-17, -5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [3.19189e-16, 0.02, -0.2, 1, -2.77556e-17, 2.77556e-17, 5.55112e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -7.28584e-17, 7.70868e-17, 4.85723e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 1.38778e-16, 3.60822e-16, -2.77556e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [3.39635e-16, -1.95941e-16, -0.04, 1, 8.32667e-17, 1.66533e-16, -8.32667e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [8.67362e-19, -1.15718e-17, 0.01, 1, 1.38778e-17, 2.77556e-17, -1.249e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.249e-16, -2.14015e-16, 0.2105, 0, 0.92388, 0.382683, 2.77556e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, 6.93889e-18], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.63064e-16, 0.008, 0.045, 1, 0, 0, 3.46945e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.40513e-16, -0.008, 0.045, 1, 0, 0, 3.46945e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
cube_6(table): { pose: [0.0379981, 0.0999996, 0.158501, 1, -2.04701e-07, -4.01512e-06, -1.37403e-06], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [0.038, 0.1, 0.0975, 1, 6.17174e-11, 6.07087e-11, -1.04386e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [-0.038, 0.1, 0.0975, 1, 1.15536e-10, 4.49112e-12, 1.58839e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [8.39598e-11, 0.1, 0.0975, 1, 5.36114e-11, -1.78933e-11, 8.00565e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_5(table): { pose: [-1.91252e-06, 0.0999997, 0.158501, 1, -2.04765e-07, -4.01516e-06, -1.37394e-06], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [-0.0380019, 0.0999998, 0.158501, 1, -2.04783e-07, -4.01512e-06, -1.37396e-06], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
longrect_2(table): { pose: [-1.78416e-06, 0.0999997, 0.127501, 1, -2.04689e-07, -4.0152e-06, -1.37406e-06], joint: rigid, shape: ssBox, size: [0.095, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.6, inertia: [0.00108, 0.005955, 0.005955], logical: { is_object: True, is_box: True, is_place: True } }
longrect_2_Left(longrect_2): { pose: [-0.038, -5.25217e-17, 0.016, 1, 0, -2.36526e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_2_Right(longrect_2): { pose: [0.038, -1.21537e-17, 0.016, 1, 0, -2.36526e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_2_Center(longrect_2): { pose: [-3.44107e-22, -4.5821e-18, 0.016, 1, 0, -2.36526e-22, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_1(table): { pose: [4.46e-12, 0.1, 0.0665, 1, 1.16201e-10, -2.35603e-12, 1.13681e-11], joint: rigid, shape: ssBox, size: [0.095, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.6, inertia: [0.00108, 0.005955, 0.005955], logical: { is_object: True, is_box: True, is_place: True } }
longrect_1_Left(longrect_1): { pose: [-0.038, 3.6992e-18, 0.016, 1, 0, 1.71969e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_1_Right(longrect_1): { pose: [0.038, 3.61477e-18, 0.016, 1, 0, 1.71969e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_1_Center(longrect_1): { pose: [-2.52435e-28, 3.65699e-18, 0.016, 1, 0, 1.71969e-28, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }