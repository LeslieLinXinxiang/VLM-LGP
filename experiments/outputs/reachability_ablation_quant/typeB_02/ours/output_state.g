world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.96, 0.89, 0.72], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, 1.1783e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -1.66533e-16, 5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731664, 5.20417e-17, 2.08167e-17, -0.681665], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-3.1225e-16, -0.316, -2.82764e-16, 0.707107, 0.707107, 3.1225e-17, -2.22045e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [1.07682e-23, 6.46625e-18, -1.52003e-22, 1, -5.55112e-17, 2.77556e-17, 1.93862e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.58221e-16, -6.245e-17, 0.707107, 0.707107, 5.55112e-17, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-7.84683e-18, 1.10746e-16, 3.65999e-17, 0.315348, 8.93383e-17, -8.32667e-17, -0.948976], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 4.83988e-16, 0.707107, -0.707107, 5.55112e-17, -1.66533e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [4.03659e-16, -1.52789e-16, -1.93289e-16, 1, 2.77556e-17, -5.55112e-17, -1.36903e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [7.83353e-22, -1.71389e-17, -7.3756e-22, 0.707107, 0.707107, -3.05311e-16, -2.35922e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731976, -5.55112e-17, 0, 0.68133], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -2.91434e-16, 2.05505e-16, 0.707107, 0.707107, 1.249e-16, -1.249e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.94945e-16, 1.51854e-16, -1.06307e-16, 1, 6.93889e-17, 1.38778e-17, 3.09035e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [1.11022e-16, -4.64136e-17, 0.107, 1, 1.38778e-17, 0, -5.20417e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [6.50137e-18, 4.90029e-17, -2.27273e-15, 1, 1.38778e-17, 0, -5.20417e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 0, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 2.77556e-17, 0, -1.56125e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-1.04083e-17, -4.85723e-17, 0.0584, 1, 0, -1.38778e-17, 1.73472e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-1.04083e-17, -4.85723e-17, 0.0584, 1, 0, -1.38778e-17, 1.73472e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-2.60209e-17, 0.04, -1.22818e-15, 1, 0, 0, 2.08167e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [3.55618e-17, -0.04, 7.58074e-16, 1, 0, 0, 2.08167e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-8.8433e-17, 1.95143e-17, -2.65748e-17, -1.03455e-13, 0, 0, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 5.32908e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-7.97973e-17, -1.20218e-17, -0.15, 1, -2.77556e-17, 8.32667e-17, 1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [2.91434e-16, 0.02, -0.2, 1, -2.77556e-17, 2.77556e-17, 0], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 4.16334e-17, 7.95804e-17, -5.89806e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-4.16467e-23, 9.77994e-23, -2.27259e-18, 1, 1.66533e-16, -4.16334e-17, -2.22045e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [8.83665e-17, -4.49003e-16, -0.04, 1, -5.55112e-17, 5.55112e-17, -1.11022e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-2.94903e-17, -1.77549e-18, 0.01, 1, 1.38778e-17, 0, -5.20417e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.52656e-16, -9.32041e-17, 0.2105, 2.77556e-17, 0.92388, 0.382683, 4.16334e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, 2.08167e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.33574e-16, 0.008, 0.045, 1, 0, 0, 2.08167e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-8.67362e-17, -0.008, 0.045, 1, 0, 0, 2.08167e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
cube_1(table): { pose: [-0.08, 0.1, 0.0665, 1, -1.25179e-09, -5.58995e-10, 5.3355e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [2.50209e-11, 0.1, 0.0665, 1, -8.69494e-11, 1.67942e-11, 1.9765e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [0.08, 0.1, 0.0665, 1, -9.03537e-11, -7.09725e-11, -2.36972e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [-0.3447, -0.2392, 0.065], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
obstacle_1(table): { pose: [-0.3348, -0.241, 0.125, 0.766044, 0, 0, 0.642788], joint: rigid, shape: ssBox, size: [0.2, 0.02, 0.15, 0.002], color: [0.55, 0.55, 0.55, 0.85], contact: 1, mass: 1, inertia: [0.0229, 0.0625, 0.0404], logical: { is_place: True } }