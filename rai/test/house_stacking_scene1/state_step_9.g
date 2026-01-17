world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 2, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.994679, -0, 0, 0.103027], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -3.33067e-16, 3.33067e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.965672, 5.55112e-17, 1.11022e-16, 0.259765], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-3.60822e-16, -0.316, -1.00134e-15, 0.707107, 0.707107, 4.44089e-16, -1.38778e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-4.56714e-17, 1.42972e-16, -5.39859e-16, 0.999754, 0, 0, -0.0221911], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -7.81385e-16, 2.77556e-17, 0.707107, 0.707107, 4.16334e-17, 1.11022e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-1.22358e-16, -7.10001e-17, 4.15613e-18, 0.70567, 8.32667e-17, 6.93889e-18, -0.708541], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 7.52436e-16, 0.707107, -0.707107, 2.77556e-17, -3.88578e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.59748e-17, 1.18713e-16, -3.25513e-17, 0.990319, 2.77556e-17, -5.55112e-17, 0.138807], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, -2.77556e-17, 1.31839e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.451956, 5.55112e-17, -8.32667e-17, 0.89204], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -6.42715e-16, 7.27716e-16, -0.707107, -0.707107, 1.83881e-16, 7.97973e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.02687e-16, 9.55737e-17, -2.67759e-16, 0.979, 5.89806e-17, -7.97973e-17, -0.203859], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [5.55112e-17, -5.20417e-17, 0.107, 1, -2.77556e-17, 3.46945e-18, -5.11743e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-6.19516e-17, -1.26441e-16, -3.98505e-15, 1, 1.73472e-17, -5.20417e-18, -4.98733e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-5.01521e-17, -2.3334e-17, -4.66606e-18, 0.92388, 1.38778e-17, -6.07153e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 1.04083e-17, -8.67362e-19, 3.20924e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [2.25514e-17, 4.53468e-17, 0.0584, 1, -6.93889e-18, -1.21431e-17, 3.03577e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [2.25514e-17, 4.53468e-17, 0.0584, 1, -6.93889e-18, -1.21431e-17, 3.03577e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [2.4835e-18, 0.04, -2.32979e-15, 1, -6.93889e-18, 3.46945e-18, -2.55872e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-3.81741e-17, -0.04, 1.63599e-15, 1, 6.93889e-18, 0, 4.77049e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.3376e-16, 1.49605e-16, -5.56182e-17, -1.03435e-13, -1.38778e-17, 1.38778e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.4211e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 3.33067e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.80411e-16, 2.6151e-16, -0.15, 1, -1.38778e-17, -5.55112e-17, 5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.15186e-15, 0.02, -0.2, 1, 0, 2.77556e-17, -1.52656e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -5.55112e-17, 5.55112e-17, 1.11022e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-8.29724e-18, 1.36865e-17, -1.13588e-17, 1, 1.66533e-16, -1.14492e-16, -5.41234e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [3.1843e-16, -7.47666e-16, -0.04, 1, 1.66533e-16, 0, 0], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [1.01915e-17, -1.92988e-17, 0.01, 1, -2.77556e-17, 3.46945e-18, -5.11743e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.8735e-16, -9.71445e-17, 0.2105, 8.67362e-17, 0.92388, 0.382683, 9.71445e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -2.77556e-17, 1.11022e-16], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.55004e-16, 0.008, 0.045, 1, 3.46945e-18, 3.46945e-18, -2.60209e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.31839e-16, -0.008, 0.045, 1, -3.46945e-18, -1.30104e-17, 4.33681e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-1.44032e-06, 0.300001, 0.0700024, 1, 1.49471e-06, -3.89583e-06, -1.27597e-06], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base1_handle(base1): { pose: [1.85288e-21, -1.8313e-17, 0.05, 1, 1.90582e-21, -7.09008e-23, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True } }
roof1(table): { pose: [1.98894e-06, 0.299999, 0.202432, 1, -4.52583e-06, -2.20277e-07, -1.55697e-06], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
roof1_handle(roof1): { pose: [-6.61744e-24, -1.44309e-17, 0.05, 1, -8.47033e-22, 5.39848e-24, -2.11758e-22], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
roof2(table): { pose: [0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
roof2_handle(roof2): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [-0.15, 0.2, 0.140001, 1, 5.31901e-08, -9.99643e-08, -2.12811e-08], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl2(table): { pose: [0.150036, 0.200054, 0.139996, 1, -2.10832e-05, 4.83345e-05, 7.88967e-06], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl3(table): { pose: [-0.149996, 0.399984, 0.139996, 1, 1.13782e-05, 7.09569e-06, -2.80662e-07], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl4(table): { pose: [0.150034, 0.399358, 0.139994, 1, 0.000408802, 0.000157656, 0.000113662], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl5(table): { pose: [-0.150056, 0.200077, 0.270909, 1, -5.21469e-05, -3.35455e-05, -1.64098e-05], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl6(table): { pose: [0.15016, 0.200211, 0.270932, 1, -0.000103784, 0.000100994, 3.45876e-05], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl7(table): { pose: [-0.149997, 0.399579, 0.270864, 1, 9.03823e-05, -6.77553e-05, -4.43478e-05], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl8(table): { pose: [0.5, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
base1_target(table): { pose: [0, 0.3, 0.07], logical: { is_pose: True } }
roof1_target(base1_target): { pose: [0, 0, 0.13], logical: { is_pose: True } }
roof2_target(base1_target): { pose: [0, 0, 0.27], logical: { is_pose: True } }
cyl1_target(table): { pose: [-0.15, 0.2, 0.14], logical: { is_pose: True } }
cyl2_target(table): { pose: [0.15, 0.2, 0.14], logical: { is_pose: True } }
cyl3_target(table): { pose: [-0.15, 0.4, 0.14], logical: { is_pose: True } }
cyl4_target(table): { pose: [0.15, 0.4, 0.14], logical: { is_pose: True } }
cyl5_target(table): { pose: [-0.15, 0.2, 0.27], logical: { is_pose: True } }
cyl6_target(table): { pose: [0.15, 0.2, 0.27], logical: { is_pose: True } }
cyl7_target(table): { pose: [-0.15, 0.4, 0.27], logical: { is_pose: True } }
cyl8_target(table): { pose: [0.15, 0.4, 0.27], logical: { is_pose: True } }