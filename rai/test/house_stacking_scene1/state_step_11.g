world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 2, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.968201, -0, 0, -0.250173], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -3.33067e-16, 3.33067e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.996176, 8.32667e-17, 5.55112e-17, 0.087364], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-6.245e-16, -0.316, -1.19164e-15, 0.707107, 0.707107, 3.88578e-16, -5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-4.55838e-17, 3.9882e-17, -2.33544e-16, 0.97579, 2.08167e-17, -2.08167e-17, 0.218711], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -9.01514e-16, 1.21431e-17, 0.707107, 0.707107, -2.01228e-16, 1.66533e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [0.604789, -9.71445e-17, 0, -0.796386], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 4.93529e-16, 0.707107, -0.707107, 2.01228e-16, -4.44089e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-1.81323e-17, 5.22245e-17, 4.88321e-17, 0.990821, -5.55112e-17, 2.77556e-17, 0.135184], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, -2.22045e-16, 0] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.553343, 1.11022e-16, -3.46945e-17, 0.832953], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -6.54858e-16, 9.74915e-16, -0.707107, -0.707107, 4.30211e-16, -6.245e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-4.99035e-17, 3.57623e-17, -9.08618e-18, 0.886175, 4.16334e-17, 1.38778e-17, -0.46335], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [6.93889e-18, -7.97973e-17, 0.107, 1, -2.77556e-17, 1.73472e-17, 6.93889e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-1.1826e-17, -1.18251e-16, -4.4261e-15, 1, 6.93889e-18, -4.51028e-17, -3.98986e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [9.28016e-18, -9.32236e-18, 4.42328e-18, 0.92388, 7.15573e-18, -7.9472e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 6.07153e-18, 3.80635e-17, 2.44813e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [1.04083e-17, 3.57787e-17, 0.0584, 1, -7.37257e-18, 1.08071e-17, 2.21177e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [1.04083e-17, 3.57787e-17, 0.0584, 1, -7.37257e-18, 1.08071e-17, 2.21177e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [6.43745e-18, 0.04, -2.57005e-15, 1, -7.37257e-18, 1.08573e-17, 2.19551e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-6.56349e-17, -0.04, 2.55015e-15, 1, 8.23994e-18, 1.08516e-17, -2.21177e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-4.29083e-16, 1.66495e-16, 9.06464e-17, -1.03396e-13, -2.77556e-17, 1.38642e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.77638e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 3.88578e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.76942e-16, 2.32453e-16, -0.15, 1, 1.38778e-17, -6.245e-17, 1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.8735e-15, 0.02, -0.2, 1, 5.55112e-17, -2.77556e-17, -3.05311e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 2.77556e-17, -5.55112e-17, 2.77556e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-1.00736e-17, 2.4762e-17, -1.57586e-17, 1, 8.32667e-17, 7.63278e-17, -6.245e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [3.45535e-16, -8.32667e-16, -0.04, 1, 5.55112e-17, -1.11022e-16, 5.55112e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [7.80626e-18, -4.33681e-18, 0.01, 1, -2.77556e-17, 1.73472e-17, 6.93889e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [2.77556e-16, -1.17961e-16, 0.2105, 9.71445e-17, 0.92388, 0.382683, 9.71445e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -1.40946e-17, 9.71445e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [3.05311e-16, 0.008, 0.045, 1, 4.33681e-18, 1.0899e-17, 2.18467e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.52656e-16, -0.008, 0.045, 1, -4.33681e-18, 1.08041e-17, 2.21719e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-1.44032e-06, 0.300001, 0.0700024, 1, 1.49471e-06, -3.89583e-06, -1.27597e-06], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base1_handle(base1): { pose: [2.2764e-21, -1.8313e-17, 0.05, 1, 2.32934e-21, -7.09008e-23, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True } }
roof1(table): { pose: [1.98894e-06, 0.299999, 0.202432, 1, -4.52583e-06, -2.20277e-07, -1.55697e-06], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
roof1_handle(roof1): { pose: [-6.61744e-24, -1.44309e-17, 0.05, 1, -8.47033e-22, 5.39848e-24, -2.11758e-22], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
roof2(table): { pose: [-3.22809e-05, 0.299938, 0.340932, 1, -2.58219e-05, -5.21292e-06, 5.55796e-06], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
roof2_handle(roof2): { pose: [1.48231e-21, 2.74202e-17, 0.05, 1, 3.38813e-21, 1.32116e-22, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [-0.15, 0.2, 0.140001, 1, 5.31901e-08, -9.99643e-08, -2.12811e-08], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl2(table): { pose: [0.150036, 0.200054, 0.139996, 1, -2.10832e-05, 4.83345e-05, 7.88967e-06], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl3(table): { pose: [-0.149996, 0.399984, 0.139996, 1, 1.13782e-05, 7.09569e-06, -2.80662e-07], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl4(table): { pose: [0.150034, 0.399358, 0.139994, 1, 0.000408802, 0.000157656, 0.000113662], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl5(table): { pose: [-0.150056, 0.200077, 0.270909, 1, -5.21469e-05, -3.35455e-05, -1.64098e-05], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl6(table): { pose: [0.15016, 0.200211, 0.270932, 1, -0.000103784, 0.000100994, 3.45876e-05], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl7(table): { pose: [-0.149997, 0.399579, 0.270864, 1, 9.03823e-05, -6.77553e-05, -4.43478e-05], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl8(table): { pose: [0.150004, 0.400011, 0.27085, 1, -3.1376e-05, 2.35707e-05, 2.66575e-07], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
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