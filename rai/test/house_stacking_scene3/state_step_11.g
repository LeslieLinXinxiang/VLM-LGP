world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 2, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.999706, -0, 0, -0.0242394], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.961563, -5.55112e-17, 0, 0.274583], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-8.32667e-16, -0.316, -1.1704e-15, 0.707107, 0.707107, -2.22045e-16, 2.77556e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-2.218e-16, 1.9276e-16, -6.60865e-16, 0.994689, -1.38778e-17, -2.77556e-17, -0.102923], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -7.15573e-16, -6.245e-17, 0.707107, 0.707107, -7.63278e-17, -1.66533e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-6.91544e-17, -4.40067e-17, 1.50484e-17, 0.797089, 1.38778e-17, -1.38778e-17, -0.603862], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -1.47451e-17, 0.707107, -0.707107, -2.72352e-16, 3.60822e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [2.09701e-16, 9.1262e-17, 4.26066e-17, 0.984989, 0, 1.11022e-16, 0.17262], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [3.8955e-17, 7.29846e-17, -7.5328e-17, 0.707107, 0.707107, 4.57967e-16, 4.30211e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.755292, -2.77556e-17, -1.35308e-16, 0.655388], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -9.4022e-16, 1.11716e-15, 0.707107, 0.707107, -2.77556e-17, 8.32667e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-4.42024e-17, 4.26269e-17, 8.99747e-18, 0.846608, 5.55112e-17, -2.77556e-17, 0.532216], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-2.56739e-16, 2.87964e-16, 0.107, 1, 5.20417e-18, -1.11022e-16, -2.04697e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-2.06281e-16, 4.01445e-17, -4.14265e-15, 1, 6.76542e-17, -5.55112e-17, -1.56125e-16] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-6.29695e-18, 5.21579e-17, 1.79274e-17, 0.92388, -6.245e-17, 8.32667e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [-5.48582e-17, -8.96695e-17, 3.57199e-17, 1, 8.32667e-17, 0, 1.04083e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-3.81639e-16, -1.12757e-17, 0.0584, 1, 1.38778e-17, 0, 0] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-3.81639e-16, -1.12757e-17, 0.0584, 1, 1.38778e-17, 0, 0] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-8.47846e-17, 0.04, -2.50841e-15, 1, 0, 0, 6.93889e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [4.90059e-17, -0.04, 2.40086e-15, 1, 0, -2.77556e-17, 3.46945e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-4.82291e-16, 4.11561e-16, 2.06199e-16, -1.03542e-13, -2.08167e-17, -4.16334e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.77638e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.11022e-16, 3.72966e-16, -0.15, 1, -1.38778e-16, 5.55112e-17, -2.77556e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.57513e-15, 0.02, -0.2, 1, -1.11022e-16, 1.38778e-16, 6.10623e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 4.996e-16, 1.11022e-16, 1.38778e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -1.249e-16, -3.26128e-16, 2.77556e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [4.25875e-16, -5.55112e-16, -0.04, 1, 2.22045e-16, 5.55112e-17, 8.32667e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [4.33681e-19, -3.20924e-17, 0.01, 1, 5.20417e-18, -1.11022e-16, -2.04697e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-1.08247e-15, 9.57567e-16, 0.2105, -2.77556e-17, -0.92388, -0.382683, -7.63278e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [-6.87628e-17, -1.24061e-17, 3.57874e-17, -0.707107, -0.707107, -1.11022e-16, -2.08167e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [3.57353e-16, 0.008, 0.045, 1, -1.38778e-17, 8.32667e-17, 1.76942e-16], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-7.80626e-16, -0.008, 0.045, 1, 4.16334e-17, 5.55112e-17, 1.70003e-16], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [0.0013581, 0.298731, 0.0708115, 0.999998, 0.000723808, 0.001068, 0.00145147], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base1_handle(base1): { pose: [-2.1684e-19, -1.58836e-17, 0.05, 1, -1.08844e-19, -2.60886e-19, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True } }
roof1(table): { pose: [-0.000350725, 0.299542, 0.203474, 1, -9.68868e-05, -0.000553402, -0.000243471], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
roof1_handle(roof1): { pose: [-2.37169e-19, 1.03457e-17, 0.05, 1, 0, 4.02175e-20, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
roof2(table): { pose: [-0.000707517, 0.300661, 0.342191, 1, -0.000292606, -1.11471e-05, -6.22239e-05], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
roof2_handle(roof2): { pose: [-1.75759e-20, -1.92175e-17, 0.05, 1, 0, -1.77017e-21, 1.35525e-20], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [-0.15, 0.2, 0.140023, 1, 1.15843e-06, 1.17944e-06, -1.37744e-07], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl2(table): { pose: [0.150011, 0.200018, 0.140043, 1, -1.2394e-05, 7.06248e-06, -3.18578e-06], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl3(table): { pose: [-0.149998, 0.4, 0.140067, 1, 1.9603e-06, 5.49871e-06, -1.01273e-06], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl4(table): { pose: [0.150003, 0.39999, 0.140098, 1, 5.59128e-06, -1.84016e-06, -4.67801e-06], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl5(table): { pose: [-0.150121, 0.20001, 0.271105, 1, -0.000104611, -7.79162e-06, -5.59418e-06], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl6(table): { pose: [0.150027, 0.200035, 0.271039, 1, -6.47275e-05, 4.05895e-05, -2.89611e-07], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl7(table): { pose: [-0.14993, 0.399177, 0.271042, 1, 0.000223529, -4.52546e-06, -1.06453e-05], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl8(table): { pose: [0.149991, 0.399906, 0.271077, 1, 1.27061e-06, -3.94216e-05, -6.65772e-06], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
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