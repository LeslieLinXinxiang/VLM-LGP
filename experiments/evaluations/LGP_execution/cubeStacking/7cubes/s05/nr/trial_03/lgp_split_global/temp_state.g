world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.995712, -0, 0, -0.0925028], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -1.66533e-16, 1.66533e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.991367, 8.32667e-17, 5.55112e-17, 0.131113], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-8.46545e-16, -0.316, -6.08987e-16, 0.707107, 0.707107, -2.77556e-16, -3.88578e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-8.72583e-17, 4.77519e-17, -2.53442e-16, 0.999989, -1.38778e-17, 6.245e-17, -0.00472041], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -5.10198e-16, -1.38778e-17, 0.707107, 0.707107, -1.94289e-16, -5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [2.75918e-17, 7.42423e-18, 1.4468e-18, 0.230767, 5.55112e-17, -1.11022e-16, -0.973009], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 3.24176e-16, 0.707107, -0.707107, 7.28584e-17, -1.59595e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [7.69945e-17, -8.37275e-17, 2.1107e-16, 0.99998, -2.08167e-17, -1.38778e-17, 0.00625936], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [3.32605e-18, -7.11866e-19, -6.83881e-19, 0.707107, 0.707107, -1.11022e-16, 2.08167e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.101218, 5.55112e-17, -1.66533e-16, 0.994864], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.34437e-16, 5.51634e-16, 0.707107, 0.707107, -7.56197e-17, 9.20013e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [5.14826e-17, -2.49724e-17, 1.1074e-21, 0.882901, 3.91744e-17, 7.54689e-17, -0.469559], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [4.06237e-18, 1.78385e-18, 0.107, 1, 0, -2.5411e-21, 3.90749e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [8.75896e-20, -8.2409e-20, -1.77636e-15, 1, -1.69407e-21, 8.47033e-22, -5.33407e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -2.75286e-21, -4.44692e-21, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -2.11758e-21, 9.77066e-21, 1.88135e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-4.4105e-18, -4.64526e-18, 0.0584, 1, 0, 3.01921e-21, -2.68433e-19] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-4.4105e-18, -4.64526e-18, 0.0584, 1, 0, 3.01921e-21, -2.68433e-19] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [5.42612e-18, 0.04, -1.03312e-15, 1, 0, 3.01921e-21, -2.68433e-19], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-5.33273e-18, -0.04, 1.25517e-15, 1, 0, 3.01921e-21, -2.68433e-19], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [1.00369e-19, 6.93817e-18, 2.10995e-23, -1.03412e-13, 0, -1.16467e-21, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 8.8818e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.17961e-16, 1.31405e-16, -0.15, 1, 1.38778e-17, -5.55112e-17, -1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.38778e-16, 0.02, -0.2, 1, -1.38778e-17, 3.46945e-17, -3.46945e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 2.77556e-17, 2.22045e-16, -1.94289e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-1.96429e-18, 4.29414e-19, 1.02123e-17, 1, -1.66533e-16, 2.77556e-17, -1.66533e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.09147e-16, -2.70126e-16, -0.04, 1, -2.498e-16, 2.77556e-17, -1.38778e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-4.19175e-19, -4.40891e-18, 0.01, 1, 0, -2.5411e-21, 3.90749e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-1.53499e-17, 5.47183e-19, 0.2105, 2.34374e-17, 0.92388, 0.382683, 5.65818e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 8.67362e-19, -1.98206e-18], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [9.97678e-18, 0.008, 0.045, 1, 0, 3.01921e-21, -2.68433e-19], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [1.6089e-17, -0.008, 0.045, 1, 0, 3.01921e-21, -2.68433e-19], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
cube_1(table): { pose: [-0.08, 0.1, 0.0665, 1, 3.01125e-09, 6.65591e-10, 1.00009e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [1.8572e-10, 0.1, 0.0665, 1, 8.51224e-10, 2.48389e-10, 1.01676e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_5(table): { pose: [-2.9981e-10, 0.1, 0.0965, 1, -1.58263e-09, -4.51512e-10, -3.38113e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [0.08, 0.1, 0.0665, 1, -3.27195e-12, 5.23415e-13, -3.04984e-13], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [-0.08, 0.1, 0.0965, 1, 3.01087e-09, 6.68747e-10, 1.08255e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_6(table): { pose: [0.08, 0.1, 0.0965, 1, -6.13479e-09, 6.01399e-11, 1.0742e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
longrect_1(table): { pose: [0.3075, 0.1925, 0.065, 0.106524, 0, 0, 0.99431], joint: rigid, shape: ssBox, size: [0.095, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.6, inertia: [0.00108, 0.005955, 0.005955], logical: { is_object: True, is_box: True, is_place: True } }
longrect_1_Left(longrect_1): { pose: [-0.038, -1.21431e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_1_Right(longrect_1): { pose: [0.038, 1.21431e-17, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_1_Center(longrect_1): { pose: [0, 0, 0.016], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }