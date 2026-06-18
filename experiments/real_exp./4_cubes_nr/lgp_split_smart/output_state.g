world: {  }
base(world): { pose: [0, 0, 0.545], shape: ssBox, size: [1.3, 1, 0.11, 0.02], color: [0.45, 0.45, 0.45], contact: 1 }
table(base): { pose: [0, 0.25, 0.11], shape: ssBox, size: [1, 0.8, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(base): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, 3.19029e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -5.55112e-17, -5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, 5.89806e-17, -5.37764e-17, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-3.05311e-16, -0.316, -3.0616e-16, 0.707107, 0.707107, -4.30211e-16, 2.22045e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-7.85324e-18, 9.07638e-18, 1.10744e-16, 1, 5.55112e-17, -2.77556e-17, -3.4196e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.30715e-16, -1.0842e-16, 0.707107, 0.707107, -2.22045e-16, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [2.75303e-25, 2.743e-25, 4.30978e-17, 0.315322, -1.56992e-16, 0, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 1.59874e-16, 0.707107, -0.707107, 5.55112e-17, 1.11022e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [2.16837e-16, -1.11995e-16, -7.32604e-17, 1, -8.32667e-17, -5.55112e-17, 1.88874e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-4.47646e-26, -3.52363e-18, -4.49614e-27, 0.707107, 0.707107, -1.80411e-16, -6.93889e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, -5.55112e-17, -9.71445e-17, 0.681639], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -6.10623e-16, 3.87582e-16, 0.707107, 0.707107, 6.93889e-17, 2.22045e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.52601e-16, 1.16485e-16, 1.15022e-16, 1, 1.38778e-17, -6.93889e-17, 3.14137e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [1.17961e-16, -5.65132e-17, 0.107, 1, 0, 1.38778e-17, 2.63678e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [5.68466e-17, 5.77672e-17, -2.24611e-15, 1, 1.38778e-17, -1.38778e-17, -1.35308e-16] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-2.33055e-29, -3.72231e-23, 4.68342e-31, 0.92388, 2.77556e-17, 2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 5.55112e-17, -2.77556e-17, -4.85723e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [3.81639e-17, -3.46945e-18, 0.0584, 1, 0, 0, -4.16334e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [3.81639e-17, -3.46945e-18, 0.0584, 1, 0, 0, -4.16334e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-1.9082e-17, 0.04, -1.164e-15, 1, 0, 0, 1.73472e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [7.63278e-17, -0.04, 7.1991e-16, 1, 0, 0, 1.73472e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-5.15693e-17, 1.71223e-17, -1.33067e-17, -1.03417e-13, -2.77556e-17, -2.08167e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 7.10544e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-6.59195e-17, 1.06847e-16, -0.15, 1, 2.77556e-17, -2.77556e-17, -1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [3.46945e-16, 0.02, -0.2, 1, 2.77556e-17, 0, -5.55112e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 3.46945e-17, -6.23416e-17, -1.56125e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-1.5665e-29, -2.2392e-30, 1.75486e-21, 1, -1.38778e-16, 2.08167e-16, -1.11022e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.308e-16, -4.24683e-16, -0.04, 1, -2.22045e-16, 1.11022e-16, 1.11022e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [3.64292e-17, -6.88856e-18, 0.01, 1, 0, 1.38778e-17, 2.63678e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [2.08167e-16, -8.93502e-17, 0.2105, 1.38778e-17, 0.92388, 0.382683, 4.16334e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 5.55112e-17, -3.46945e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [5.37764e-17, 0.008, 0.045, 1, 0, 0, 1.73472e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-2.25514e-17, -0.008, 0.045, 1, 0, 0, 1.73472e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.02, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.02, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
cube_2(table): { pose: [0.02, 0.1, 0.0665, 1, -6.60823e-11, -2.82073e-11, -2.04438e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [-0.02, 0.1, 0.0665, 1, -1.04956e-12, 1.67402e-11, 1.36352e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
rect_1(table): { pose: [4.42163e-07, 0.0999996, 0.0965002, 1, 8.95839e-08, 3.6854e-07, 5.78379e-07], joint: rigid, shape: ssBox, size: [0.065, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.4, inertia: [0.00072, 0.00205, 0.00205], logical: { is_object: True, is_box: True, is_place: True } }
cube_2_Left(rect_1): { pose: [-0.026, -6.62887e-17, 0.016, 1, 0, 2.21224e-23, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
cube_2_Right(rect_1): { pose: [0.026, -4.33682e-17, 0.016, 1, 0, 2.21224e-23, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
tri_1(table): { pose: [4.41482e-07, 0.0999996, 0.1215, 1, 8.9964e-08, 3.6868e-07, 5.78498e-07], joint: rigid, shape: mesh, color: [0.9, 0.6, 0.1], mesh: "/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", contact: 1, mass: 0.2, inertia: [3.61846e-05, 3.20675e-05, 5.23466e-05], logical: { is_object: True, is_box: True } }