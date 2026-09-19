world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.999998, -0, 0, -0.00181302], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 1.11022e-16, -1.11022e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.726817, -5.20417e-18, -1.14492e-16, -0.686832], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-1.21431e-16, -0.316, -5.19928e-16, 0.707107, 0.707107, 3.95517e-16, 0] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-6.27963e-18, 1.99803e-17, 1.10918e-16, 0.999961, -5.55112e-17, 0, 0.00878663], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -4.21971e-16, -1.00614e-16, 0.707107, 0.707107, 5.55112e-17, 5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.30084e-16, 9.78456e-17, 1.19976e-16, 0.322909, 1.96024e-16, 0, -0.94643], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -1.73472e-17, 0.707107, -0.707107, -2.77556e-17, 5.55112e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [4.03215e-16, -3.44156e-16, -2.08039e-16, 0.999836, -2.77556e-17, -2.77556e-17, 0.0181074], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [2.10823e-19, 1.04059e-17, 8.0666e-20, 0.707107, 0.707107, 2.77556e-17, -2.77556e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.73048, -5.55112e-17, -2.77556e-17, 0.682934], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -1.8735e-16, 2.97613e-16, 0.707107, 0.707107, -1.66533e-16, 2.15106e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.88934e-16, 2.35994e-16, -1.74123e-16, 0.999996, -6.93889e-17, 8.32667e-17, 0.00277519], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [8.32667e-17, -1.43332e-16, 0.107, 1, 0, 2.77556e-17, 4.85723e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.07623e-16, 1.69274e-16, -2.26082e-15, 1, 1.38778e-17, -2.77556e-17, 4.16334e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-6.14891e-21, 1.73438e-18, -3.41542e-20, 0.92388, 2.77556e-17, 5.55112e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -1.11022e-16, 0, 4.85723e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [2.08167e-17, -8.32667e-17, 0.0584, 1, 2.77556e-17, 0, 0] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [2.08167e-17, -8.32667e-17, 0.0584, 1, 2.77556e-17, 0, 0] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [1.38778e-17, 0.04, -1.43635e-15, 1, 0, 0, -3.46945e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [3.03577e-17, -0.04, 4.996e-16, 1, 0, 0, -3.46945e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.63151e-16, 6.09659e-17, -4.54817e-17, -1.03376e-13, -2.77556e-17, 2.77556e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 8.8818e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, -1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.38778e-16, -7.45118e-17, -0.15, 1, -5.55112e-17, 1.11022e-16, 5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.66533e-16, 0.02, -0.2, 1, 0, -2.77556e-17, -2.77556e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 1.12757e-16, 3.44288e-16, 1.52656e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1.73022e-19, -8.40271e-20, 1.08403e-17, 1, -5.55112e-17, 3.46945e-17, 1.38778e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.05384e-16, -3.70526e-16, -0.04, 1, 0, -1.66533e-16, 1.11022e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-3.38271e-17, 1.53415e-17, 0.01, 1, 0, 2.77556e-17, 4.85723e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.52656e-16, -2.65413e-16, 0.2105, 0, 0.92388, 0.382683, 1.38778e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -2.77556e-17, -6.93889e-18], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [8.84709e-17, 0.008, 0.045, 1, 0, 0, -3.46945e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.64799e-16, -0.008, 0.045, 1, 0, 0, -3.46945e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
cube_4(table): { pose: [0.08, 0.1, 0.0965, 1, -2.21798e-09, 5.19606e-10, 8.5591e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [0.08, 0.1, 0.0665, 1, 1.94754e-09, -4.98634e-10, -6.17717e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [-0.08, 0.1, 0.0665, 1, -6.69531e-11, -6.4409e-12, -3.24057e-12], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [-0.08, 0.1, 0.0965, 1, -9.69171e-11, -4.02348e-10, -6.30921e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
triprism_1(table): { pose: [-0.0799841, 0.0999623, 0.061461, 1, 5.26005e-05, 1.57501e-05, 6.86829e-06], joint: rigid, shape: mesh, color: [0.9, 0.6, 0.1], mesh: "/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", contact: 1, mass: 0.2, inertia: [3.61846e-05, 3.20675e-05, 5.23466e-05], logical: { is_object: True, is_box: True } }