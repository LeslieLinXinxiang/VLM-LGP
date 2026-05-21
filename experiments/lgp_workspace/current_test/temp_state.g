world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.997116, -0, 0, 0.0758958], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -5.55112e-17, 1.66533e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.982374, 0, -1.11022e-16, 0.186925], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-3.33067e-16, -0.316, -3.31097e-16, 0.707107, 0.707107, -5.55112e-17, 5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-1.95749e-16, 2.31058e-16, -5.54747e-16, 0.996226, -4.16334e-17, -6.93889e-17, -0.0868004], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -4.01588e-16, 5.89806e-17, 0.707107, 0.707107, -8.32667e-17, -2.22045e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-1.16485e-16, -4.51496e-17, -2.22158e-18, 0.246188, 5.55112e-17, 2.77556e-17, -0.969222], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 8.70831e-16, 0.707107, -0.707107, 2.98372e-16, -5.55112e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-1.72598e-16, 2.86035e-16, -5.57107e-16, 0.972875, -6.93889e-18, -3.46945e-18, 0.231332], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-1.6447e-17, -1.54517e-18, -1.098e-16, 0.707107, 0.707107, 5.55112e-17, -1.8735e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.0707372, -2.77556e-17, 0, 0.997495], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -5.12586e-16, 2.25547e-16, 0.707107, 0.707107, -7.90053e-17, 3.07702e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-8.01693e-17, 5.65952e-17, -1.1102e-16, 0.809448, -2.48452e-17, 2.92565e-18, -0.587192], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [5.99403e-18, -5.12201e-18, 0.107, 1, -1.69407e-21, 2.5411e-21, 4.595e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-4.92641e-18, 4.87173e-18, -2.55351e-15, 1, 1.69407e-21, -8.47033e-22, -9.56117e-18] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -1.69407e-21, 8.47033e-22, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 1.69407e-21, 1.15144e-21, 6.03546e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-6.75138e-19, -3.43578e-18, 0.0584, 1, 0, 2.31611e-23, 7.29344e-20] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-6.75138e-19, -3.43578e-18, 0.0584, 1, 0, 2.31611e-23, 7.29344e-20] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [4.06073e-19, 0.04, -1.54505e-15, 1, 0, 2.31611e-23, 7.29344e-20], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-4.04241e-19, -0.04, 1.10096e-15, 1, 0, 2.31611e-23, 7.29344e-20], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.1131e-20, -6.93886e-18, 1.62364e-22, -1.03411e-13, 0, 4.17726e-23, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 5.32908e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.04083e-16, 9.88792e-17, -0.15, 1, 1.38778e-17, -2.77556e-17, -3.33067e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [7.63278e-17, 0.02, -0.2, 1, 6.93889e-18, 6.93889e-18, -1.63498e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 1.11022e-16, 0, -5.55112e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -5.55112e-17, -1.38778e-16, -5.55112e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.00267e-16, -5.44175e-17, -0.04, 1, -3.05311e-16, -1.66533e-16, 0], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-1.63763e-18, 8.11008e-19, 0.01, 1, -1.69407e-21, 2.5411e-21, 4.595e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-2.12343e-17, 8.71258e-18, 0.2105, 2.34323e-17, 0.92388, 0.382683, 5.65689e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 2.1684e-19, -3.8053e-19], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-7.23419e-19, 0.008, 0.045, 1, 0, 2.31611e-23, 7.29344e-20], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-9.37321e-19, -0.008, 0.045, 1, 0, 2.31611e-23, 7.29344e-20], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Work_Center(table): { pose: [0.4, 0, 0.051], shape: ssBox, size: [0.04, 0.04, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Init_Center(table): { pose: [-0.36, 0, 0.051], shape: ssBox, size: [0.04, 0.04, 0.001, 0.0005], color: [1, 1, 0, 0], logical: { is_place: True } }
cube_3(table): { pose: [0.05, 0.1, 0.0665, 1, -7.18959e-10, -1.38766e-10, -2.42483e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [9.79467e-11, 0.1, 0.0965, 1, -6.1898e-11, -6.77127e-11, 9.28723e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [-0.05, 0.1, 0.0665, 1, -1.58563e-10, -3.25815e-11, 5.46026e-12], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [4.07982e-13, 0.1, 0.0665, 1, -7.29981e-13, 3.34559e-13, 3.11284e-13], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
Table_Left(table): { pose: [-0.05, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.05, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }