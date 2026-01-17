world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 2, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], shape: pointCloud, size: [], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.922871, -0, 0, -0.385108], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 2.77556e-17, -2.498e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.998094, -1.66533e-16, 1.38778e-16, 0.0617045], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-6.59195e-16, -0.316, -1.06083e-15, 0.707107, 0.707107, -1.11022e-16, 2.77556e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [4.16048e-17, -4.1486e-17, 5.16394e-18, 0.969909, -6.93889e-18, -1.04083e-17, 0.243469], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -5.52835e-16, 6.07153e-17, 0.707107, 0.707107, -3.44343e-16, -5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.00932e-18, -6.07522e-19, -6.61376e-18, 0.616475, -6.93889e-17, -1.52656e-16, -0.787374], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 9.68843e-16, 0.707107, -0.707107, -1.12757e-16, -4.16334e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [4.47195e-18, -9.58449e-17, -2.84357e-17, 0.99157, 0, 1.11022e-16, 0.129569], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [2.34587e-17, 4.08459e-18, -5.73137e-17, 0.707107, 0.707107, 2.77556e-17, 1.38778e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.526914, 5.55112e-17, -6.15827e-17, 0.849919], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -6.12357e-16, 6.79578e-16, -0.707107, -0.707107, -6.93889e-18, 3.01842e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [2.77705e-17, -6.93108e-17, 2.42444e-17, 0.969829, 5.76796e-17, 6.76542e-17, -0.243785], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [1.70003e-16, -4.51028e-17, 0.107, 1, 2.51535e-17, -1.17961e-16, 1.27502e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.1335e-16, 1.35443e-17, -4.18098e-15, 1, -6.93889e-18, -8.67362e-17, -3.05745e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-5.24935e-17, -3.28061e-17, -4.47752e-18, 0.92388, 6.93889e-18, -1.38778e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 6.93889e-18, 3.1225e-17, 1.21431e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [1.17961e-16, -1.56403e-16, 0.0584, 1, 2.77556e-17, 5.55112e-17, 1.04083e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [1.17961e-16, -1.56403e-16, 0.0584, 1, 2.77556e-17, 5.55112e-17, 1.04083e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [1.05349e-16, 0.04, -2.90919e-15, 1, 0, 3.1225e-17, 5.20417e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-1.05349e-16, -0.04, 2.90919e-15, 1, 6.93889e-18, -3.1225e-17, 1.04083e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-7.50635e-17, 7.8444e-17, 2.08995e-16, -1.03417e-13, -8.32667e-17, 2.08167e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.77638e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, -2.22045e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.07553e-16, 1.2837e-16, -0.15, 1, -6.93889e-18, -6.07153e-18, -3.88578e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.51268e-15, 0.02, -0.2, 1, 1.66533e-16, 5.55112e-17, 1.66533e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 2.77556e-16, -1.38778e-16, 5.55112e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-9.73891e-18, 2.6852e-17, -1.62613e-18, 1, 5.55112e-16, -3.31332e-16, -8.32667e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.89916e-16, 2.77556e-17, -0.04, 1, 1.38778e-16, 5.55112e-17, -1.11022e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [7.32921e-17, 4.33681e-19, 0.01, 1, 2.51535e-17, -1.17961e-16, 1.27502e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [2.35922e-16, -9.71445e-17, 0.2105, -6.93889e-18, 0.92388, 0.382683, 1.11022e-16], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -2.77556e-17, -1.38778e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.35308e-16, 0.008, 0.045, 1, 0, 3.46945e-18, 5.20417e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-6.93889e-18, -0.008, 0.045, 1, -6.93889e-18, 1.04083e-17, 1.21431e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-1.44032e-06, 0.300001, 0.0700024, 1, 1.49471e-06, -3.89582e-06, -1.27597e-06], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base1_handle(base1): { pose: [2.38228e-21, -1.7037e-17, 0.05, 1, 0, -7.09017e-23, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8, 0], logical: { is_object: True } }
roof1(table): { pose: [-4.10176e-07, 0.3, 0.201552, 1, -0.000164889, 2.47609e-05, 5.94741e-07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
roof1_handle(roof1): { pose: [8.04681e-21, -2.16027e-17, 0.05, 1, 1.29247e-26, -1.24324e-21, -6.35275e-22], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0, 0], logical: { is_object: True } }
roof2(table): { pose: [-6.3364e-05, 0.299877, 0.340682, 1, -2.70552e-05, -2.97091e-06, 6.04203e-06], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
roof2_handle(roof2): { pose: [5.66453e-21, -2.97647e-18, 0.05, 1, 3.23117e-27, 1.9643e-22, 8.47033e-22], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [-0.15, 0.199999, 0.14, 1, 1.70208e-07, 8.05815e-07, 3.21882e-07], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl2(table): { pose: [0.150003, 0.199989, 0.14002, 1, -9.26176e-07, 1.78103e-05, 6.76733e-07], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl3(table): { pose: [-0.000236248, 0.399548, 0.139981, 1, 0.00037582, -5.6728e-05, -0.000231478], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl4(table): { pose: [-0.150008, 0.200028, 0.270624, 1, -7.14754e-05, 7.75388e-06, 6.56714e-07], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl5(table): { pose: [0.150014, 0.200065, 0.270713, 1, -8.79645e-05, 2.25058e-05, -6.01769e-06], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl6(table): { pose: [0.000222406, 0.398351, 0.270705, 1, 0.000639812, 0.000131443, 9.69912e-05], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl7(table): { pose: [-0.149973, 0.300035, 0.410636, 1, -1.76692e-05, -5.36635e-06, 1.82221e-05], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl8(table): { pose: [0.150083, 0.300039, 0.410602, 1, -4.00914e-05, 3.57041e-05, 2.31406e-05], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
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