world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.96, 0.89, 0.72], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, 1.1783e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -5.55112e-17, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731664, -1.73472e-18, -2.60209e-17, -0.681665], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-2.498e-16, -0.316, -2.62763e-16, 0.707107, 0.707107, -1.73472e-17, 0] }
l_panda_joint3(l_panda_joint3_origin): { pose: [7.84538e-18, 1.49645e-17, -1.10745e-16, 1, 2.77556e-17, 0, 1.93862e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.32179e-16, -3.29597e-17, 0.707107, 0.707107, 5.55112e-17, 1.66533e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.29339e-16, 9.50562e-17, 9.01111e-17, 0.315348, -9.62772e-17, 0, -0.948976], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 4.13327e-16, 0.707107, -0.707107, -4.16334e-17, -1.66533e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [4.33659e-16, -1.9985e-16, -1.46584e-16, 1, 8.32667e-17, -2.77556e-17, -1.36903e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [7.83276e-22, -1.71372e-17, -7.37488e-22, 0.707107, 0.707107, -2.35922e-16, -1.38778e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731976, -5.55112e-17, 2.77556e-17, 0.68133], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -4.44089e-16, 1.48304e-16, 0.707107, 0.707107, 1.94289e-16, -5.55112e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.92416e-16, 1.99276e-16, -1.59461e-16, 1, 0, 5.55112e-17, 3.09035e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [4.16334e-17, -8.12491e-17, 0.107, 1, -1.38778e-17, 2.77556e-17, -2.77556e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [3.97143e-17, 8.68048e-17, -2.50753e-15, 1, -1.38778e-17, -1.38778e-17, -3.1225e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-3.75314e-26, -1.69407e-21, -8.24491e-26, 0.92388, 0, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -5.55112e-17, -4.16334e-17, -2.63678e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [5.89806e-17, 6.93889e-18, 0.0584, 1, 0, 0, 3.81639e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [5.89806e-17, 6.93889e-18, 0.0584, 1, 0, 0, 3.81639e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-1.82146e-17, 0.04, -1.38084e-15, 1, 0, 0, -1.73472e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [1.30104e-16, -0.04, 4.94396e-16, 1, 0, 0, -1.73472e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.15418e-16, 4.65009e-17, -2.65729e-17, -1.03383e-13, 0, 0, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 5.32908e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-3.1225e-17, -4.16121e-17, -0.15, 1, 1.38778e-16, -5.55112e-17, 3.88578e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.52656e-16, 0.02, -0.2, 1, 0, 5.55112e-17, 0], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 0, -3.92481e-17, 6.59195e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-4.16467e-23, 9.77996e-23, -2.27259e-18, 1, 1.38778e-16, -6.93889e-17, -2.498e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.07619e-16, -4.40863e-16, -0.04, 1, -2.77556e-17, 5.55112e-17, -5.55112e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-1.99493e-17, -5.03365e-18, 0.01, 1, -1.38778e-17, 2.77556e-17, -2.77556e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.52656e-16, -1.61722e-16, 0.2105, 5.55112e-17, 0.92388, 0.382683, 2.77556e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 1.11022e-16, 1.38778e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [7.63278e-17, 0.008, 0.045, 1, 0, 0, -1.73472e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-6.93889e-17, -0.008, 0.045, 1, 0, 0, -1.73472e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
cube_1(table): { pose: [-0.08, 0.1, 0.0665, 1, -1.25179e-09, -5.58995e-10, 5.3355e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [2.50209e-11, 0.1, 0.0665, 1, -8.69494e-11, 1.67942e-11, 1.9765e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [0.08, 0.1, 0.0665, 1, -9.03537e-11, -7.09725e-11, -2.36972e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [-0.3031, -0.475, 0.065], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 1, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
obstacle_1(table): { pose: [-0.2944, -0.47, 0.125, 0.5, 0, 0, 0.866025], joint: rigid, shape: ssBox, size: [0.2, 0.02, 0.15, 0.002], color: [0.55, 0.55, 0.55, 0.85], contact: 1, mass: 1, inertia: [0.0229, 0.0625, 0.0404], logical: { is_place: True } }