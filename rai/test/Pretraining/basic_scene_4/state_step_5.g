world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 2, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.964703, -0, 0, 0.263339], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 5.55112e-17, -1.11022e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.984515, 5.55112e-17, -8.32667e-17, 0.175301], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-3.19189e-16, -0.316, -4.19737e-16, 0.707107, 0.707107, 5.55112e-17, -8.32667e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-1.56925e-16, 1.79031e-16, -2.94299e-16, 0.967994, 4.16334e-17, 0, -0.250973], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.04444e-16, -4.51028e-17, 0.707107, 0.707107, -2.498e-16, -1.11022e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-7.93869e-17, -2.47551e-17, -4.27245e-18, 0.539309, -5.55112e-17, 1.52656e-16, -0.842108], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 7.49401e-16, 0.707107, -0.707107, 3.46945e-17, -1.94289e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.40197e-17, 1.46306e-16, -5.2084e-17, 0.999009, -2.77556e-17, 0, -0.0445039], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [5.16848e-17, 2.26205e-17, -6.27928e-17, 0.707107, 0.707107, 0, 5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.408852, 0, -2.77556e-17, 0.912601], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -2.25948e-16, 2.5186e-16, 0.707107, 0.707107, -2.77556e-17, -1.11022e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.14072e-16, 2.12553e-17, 8.09088e-18, 0.943757, -6.93889e-18, 1.04083e-17, -0.330641], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [9.02056e-17, -3.81639e-17, 0.107, 1, -6.93889e-18, -4.51028e-17, 7.71952e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-2.35758e-17, -5.509e-17, -2.28867e-15, 1, 2.08167e-17, 1.04083e-17, 7.89299e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 5.91229e-18, -2.61411e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 2.08878e-18, 7.51667e-17, -2.5731e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [5.55112e-17, -7.69682e-17, 0.0584, 1, -3.47622e-18, 4.74119e-17, 2.13389e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [5.55112e-17, -7.69682e-17, 0.0584, 1, -3.47622e-18, 4.74119e-17, 2.13389e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [6.22222e-17, 0.04, -1.64528e-15, 1, -5.19231e-18, 1.96581e-17, 9.0929e-19], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-4.98693e-17, -0.04, 1.41398e-15, 1, 5.21095e-18, -8.10083e-18, -8.70962e-19], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-6.41041e-17, 4.08305e-20, 1.53635e-17, 1.03402e-13, 5.55112e-17, -3.46267e-18, -1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 7.10544e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, -1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.38778e-16, 1.21431e-16, -0.15, 1, 6.93889e-18, -6.93889e-17, -1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [4.02456e-16, 0.02, -0.2, 1, 2.77556e-17, 2.77556e-17, -1.38778e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 1.66533e-16, -5.55112e-17, 0], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 3.60822e-16, -1.249e-16, -5.55112e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.96403e-16, -3.26128e-16, -0.04, 1, 5.55112e-17, 2.77556e-17, -1.11022e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [2.1684e-19, -2.12504e-17, 0.01, 1, -6.93889e-18, -4.51028e-17, 7.71952e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [2.28983e-16, -3.46945e-17, 0.2105, -1.38778e-17, -0.92388, -0.382683, -1.11022e-16], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -3.70797e-17, 4.16334e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.17961e-16, 0.008, 0.045, 1, -1.69407e-21, -8.0975e-18, 4.26481e-19], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [1.21431e-17, -0.008, 0.045, 1, -3.46945e-18, 1.96559e-17, 1.72646e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-1.44032e-06, 0.300001, 0.0700024, 1, 1.49471e-06, -3.89582e-06, -1.27597e-06], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base1_handle(base1): { pose: [1.11173e-21, -1.7037e-17, 0.05, 1, 0, -7.09017e-23, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8, 0], logical: { is_object: True } }
roof1(table): { pose: [-4.10176e-07, 0.3, 0.201552, 1, -0.000164889, 2.47609e-05, 5.94741e-07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
roof1_handle(roof1): { pose: [-2.11758e-21, 9.79848e-18, 0.05, 1, 3.23117e-27, 2.9816e-22, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0, 0], logical: { is_object: True } }
roof2(table): { pose: [0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
roof2_handle(roof2): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [-0.15, 0.199999, 0.14, 1, 1.70208e-07, 8.05815e-07, 3.21882e-07], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl2(table): { pose: [0.150003, 0.199989, 0.14002, 1, -9.26176e-07, 1.78103e-05, 6.76733e-07], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl3(table): { pose: [-0.000236248, 0.399548, 0.139981, 1, 0.00037582, -5.6728e-05, -0.000231478], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl4(table): { pose: [-0.4, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl5(table): { pose: [0.4, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl6(table): { pose: [0.5, 0.1, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl7(table): { pose: [-0.5, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl8(table): { pose: [0.5, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
base1_target(table): { pose: [0, 0.3, 0.07], logical: { is_pose: True } }
roof1_target(base1_target): { pose: [0, 0, 0.13], logical: { is_pose: True } }
roof2_target(base1_target): { pose: [0, 0, 0.27], logical: { is_pose: True } }
cyl1_target(table): { pose: [-0.15, 0.2, 0.14], logical: { is_pose: True } }
cyl2_target(table): { pose: [0.15, 0.2, 0.14], logical: { is_pose: True } }
cyl3_target(table): { pose: [0, 0.4, 0.14], logical: { is_pose: True } }
cyl4_target(table): { pose: [-0.15, 0.2, 0.27], logical: { is_pose: True } }
cyl5_target(table): { pose: [0.15, 0.2, 0.27], logical: { is_pose: True } }
cyl6_target(table): { pose: [0, 0.4, 0.27], logical: { is_pose: True } }
cyl7_target(table): { pose: [-0.15, 0.3, 0.41], logical: { is_pose: True } }
cyl8_target(table): { pose: [0.15, 0.3, 0.41], logical: { is_pose: True } }