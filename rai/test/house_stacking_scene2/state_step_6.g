world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 2, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], shape: pointCloud, size: [], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.944363, -0, 0, 0.328904], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 5.55112e-17, -1.11022e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.999954, 0, -5.55112e-17, 0.00961896], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-3.13118e-16, -0.316, -6.18605e-16, 0.707107, 0.707107, 0, -5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-1.60025e-16, 3.23474e-16, -4.4725e-16, 0.982276, -3.03577e-18, 2.1684e-17, -0.187438], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.8239e-16, -1.05384e-16, 0.707107, 0.707107, -3.18322e-16, -1.66533e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.6216e-16, -4.71933e-18, 4.18371e-18, 0.427208, 0, 2.77556e-17, -0.904154], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 1.1499e-15, 0.707107, -0.707107, -4.16334e-17, -1.11022e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-1.70879e-16, 2.88196e-16, -1.44975e-16, 0.999999, 8.32667e-17, -1.11022e-16, -0.00140479], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [3.75042e-17, 4.67326e-17, -4.4662e-17, 0.707107, 0.707107, -6.93889e-17, 5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [5.42241e-18, -5.98374e-18, 2.65549e-17, 0.419216, 0, 1.11022e-16, 0.907887], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -4.6392e-16, 2.89622e-16, 0.707107, 0.707107, -8.41341e-17, -1.23382e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-6.86877e-16, 2.57434e-16, -2.19501e-16, 0.950583, 4.81386e-17, 7.84962e-17, -0.310471], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [1.15142e-16, -4.83554e-17, 0.107, 1, -7.37257e-18, -4.58618e-17, -7.07103e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-2.57217e-17, -7.40114e-17, -3.55326e-15, 1, 2.0383e-17, 9.6494e-18, 4.03662e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 5.52943e-18, -2.59124e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 1.95156e-18, 7.52843e-17, -5.38408e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [6.75458e-17, -6.50386e-17, 0.0584, 1, -3.36103e-18, 4.65936e-17, 1.60259e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [6.75458e-17, -6.50386e-17, 0.0584, 1, -3.36103e-18, 4.65936e-17, 1.60259e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [9.06264e-17, 0.04, -2.48719e-15, 1, -5.20417e-18, 1.94479e-17, 1.57802e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-9.70459e-17, -0.04, 9.32807e-16, 1, 5.20417e-18, -1.90549e-17, 1.54329e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.74788e-17, -3.90193e-18, 2.46992e-19, 1.03402e-13, 5.63785e-17, -3.52366e-18, -1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 8.8818e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, -5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.05384e-16, 1.32923e-16, -0.15, 1, 6.93889e-18, -6.93889e-17, -2.22045e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [4.02456e-16, 0.02, -0.2, 1, -2.77556e-17, -5.55112e-17, 2.77556e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 1.66533e-16, 5.55112e-17, 0], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 4.30211e-16, -4.85723e-17, 1.11022e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [3.12937e-16, -1.1498e-16, -0.04, 1, 5.55112e-17, -2.77556e-17, -1.11022e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-1.98273e-17, -1.85534e-17, 0.01, 1, -7.37257e-18, -4.58618e-17, -7.07103e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [2.37657e-16, -6.28837e-17, 0.2105, -1.45283e-17, -0.92388, -0.382683, -1.1189e-16], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -3.46945e-17, 5.59448e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [8.52725e-17, 0.008, 0.045, 1, -1.0842e-19, -6.61363e-18, 1.56278e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [2.77014e-17, -0.008, 0.045, 1, -3.46945e-18, 1.896e-17, 1.56955e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-1.44032e-06, 0.300001, 0.0700024, 1, 1.49471e-06, -3.89582e-06, -1.27597e-06], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base1_handle(base1): { pose: [1.32349e-21, -1.7037e-17, 0.05, 1, 0, -7.09017e-23, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8, 0], logical: { is_object: True } }
roof1(table): { pose: [-4.10176e-07, 0.3, 0.201552, 1, -0.000164889, 2.47609e-05, 5.94741e-07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
roof1_handle(roof1): { pose: [-4.23516e-22, -2.16027e-17, 0.05, 1, 0, -1.24333e-21, -1.05879e-22], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0, 0], logical: { is_object: True } }
roof2(table): { pose: [0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
roof2_handle(roof2): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [-0.15, 0.199999, 0.14, 1, 1.70208e-07, 8.05815e-07, 3.21882e-07], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl2(table): { pose: [0.150003, 0.199989, 0.14002, 1, -9.26176e-07, 1.78103e-05, 6.76733e-07], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl3(table): { pose: [-0.000236248, 0.399548, 0.139981, 1, 0.00037582, -5.6728e-05, -0.000231478], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl4(table): { pose: [-0.150008, 0.200028, 0.270624, 1, -7.14754e-05, 7.75388e-06, 6.56714e-07], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
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