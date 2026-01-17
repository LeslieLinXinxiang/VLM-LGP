world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.992769, -0, 0, 0.120039], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 5.55112e-17, -5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.903238, 0, 0, 0.429141], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-4.996e-16, -0.316, -2.59266e-16, 0.707107, 0.707107, 2.77556e-16, -1.38778e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-2.09933e-16, 1.55584e-16, -6.09159e-16, 0.997694, -1.11022e-16, 2.77556e-17, -0.0678749], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.72098e-16, 1.45717e-16, 0.707107, 0.707107, 1.80411e-16, 1.66533e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.38896e-16, 5.41804e-17, 4.12087e-17, 0.807733, -2.77556e-17, 1.00614e-16, -0.589549], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 2.51535e-16, 0.707107, -0.707107, 1.52656e-16, -1.11022e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.23989e-17, 1.03953e-16, -3.94789e-17, 0.980144, 0, 0, 0.198285], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, 5.55112e-17, -1.80411e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.569088, 5.55112e-17, 2.77556e-17, 0.822277], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.95517e-16, 5.39499e-16, 0.707107, 0.707107, -1.80411e-16, -1.38778e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.61745e-16, 7.77213e-17, 1.86059e-17, 0.71297, 1.38778e-17, -1.38778e-17, 0.701195], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-1.42247e-16, 3.46945e-17, 0.107, 1, -5.29091e-17, 1.38778e-17, 2.61943e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-2.35091e-17, 3.47547e-17, -1.7417e-15, 1, 3.16587e-17, -1.38778e-17, 2.94903e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 3.31766e-17, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 1.38778e-17, -5.55112e-17, 1.38778e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-9.02056e-17, -2.5804e-17, 0.0584, 1, 6.93889e-18, 0, 2.42861e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-9.02056e-17, -2.5804e-17, 0.0584, 1, 6.93889e-18, 0, 2.42861e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [9.53827e-17, 0.04, -1.04555e-15, 1, 6.93889e-18, 0, 2.42861e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-1.24629e-16, -0.04, 5.88668e-16, 1, 6.93889e-18, 0, 2.42861e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.86634e-16, 3.95061e-16, -1.43571e-16, -1.03473e-13, -6.93889e-18, 4.16334e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 7.10544e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [4.16334e-17, 2.28983e-16, -0.15, 1, -5.55112e-17, 2.77556e-17, 4.44089e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [8.32667e-16, 0.02, -0.2, 1, 0, 8.32667e-17, -2.08167e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -5.55112e-17, 1.66533e-16, 1.38778e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-9.05364e-19, 1.45571e-18, 2.65516e-19, 1, -2.77556e-17, -2.01228e-16, -2.22045e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.16407e-16, -1.78677e-16, -0.04, 1, -2.77556e-17, 2.77556e-17, 5.55112e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [6.93889e-18, -2.1684e-18, 0.01, 1, -5.29091e-17, 1.38778e-17, 2.61943e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-1.52656e-16, 2.08167e-16, 0.2105, 4.85723e-17, 0.92388, 0.382683, 4.16334e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 5.55112e-17, 1.04083e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [3.53884e-16, 0.008, 0.045, 1, 6.93889e-18, 0, 2.42861e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-4.35416e-16, -0.008, 0.045, 1, 6.93889e-18, 0, 2.42861e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [0.025, 0.275, 0.07, 0.999989, 0, 0, 0.00473251], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True } }
base2(table): { pose: [-0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base2_handle(base2): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
base3(table): { pose: [0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
base3_handle(base3): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [0.19982, 0.40166, 0.14, 0.999969, 0, 0, 0.00787269], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [-0.151175, 0.398338, 0.14, 0.999982, 0, 0, 0.00596458], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.148809, 0.148349, 0.14, 0.99996, 0, 0, 0.00894999], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [0.251173, 0.152135, 0.14, 0.999991, 0, 0, 0.00429853], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [-0.5, 0, 0.2], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
place_base1(table): { pose: [0, 0.3, 0.05], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base1(base1): { pose: [0.2, 0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base1(base1): { pose: [-0.2, -0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base1(base1): { pose: [-0.2, 0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base1(base1): { pose: [0.2, -0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base2(base2): { pose: [0.2, 0, 0.02], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }