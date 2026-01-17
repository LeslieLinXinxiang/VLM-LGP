world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.995615, -0, 0, -0.0935427], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -1.11022e-16, -5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.989617, 8.32667e-17, 0, 0.14373], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-6.38378e-16, -0.316, -6.7789e-16, 0.707107, 0.707107, -1.11022e-16, 5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-3.19909e-17, 7.6526e-17, -2.41107e-16, 0.999527, 1.249e-16, 4.16334e-17, -0.030749], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -4.07877e-16, -6.245e-17, 0.707107, 0.707107, -2.08167e-16, 1.11022e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-3.23991e-17, -9.22828e-18, -2.01465e-17, 0.589184, -5.55112e-17, -1.38778e-16, -0.807999], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 6.60062e-16, 0.707107, -0.707107, -2.08167e-17, -2.77556e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [3.76767e-17, 2.9605e-16, -6.44206e-17, 0.972246, 1.66533e-16, -5.55112e-17, -0.23396], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-1.71363e-18, 5.19699e-17, -3.38829e-17, 0.707107, 0.707107, 0, -5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.511809, 0, -5.55112e-17, 0.859099], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.76435e-16, 7.069e-16, 0.707107, 0.707107, -3.1225e-17, -1.38778e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.50258e-16, 1.56119e-16, -1.36158e-16, 0.978169, -3.46945e-17, -6.93889e-17, -0.207809], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-3.43475e-16, 1.249e-16, 0.107, 1, 4.16334e-17, 2.08167e-17, 1.70003e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [4.11292e-17, 1.70591e-16, -3.38083e-15, 1, 1.38778e-17, 1.04083e-17, 1.71738e-16] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [4.93829e-17, 2.3986e-17, -8.21498e-18, 0.92388, -1.38778e-17, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [-5.59261e-18, 6.17537e-17, 2.65812e-18, 1, 0, -3.55618e-17, -2.77556e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-9.36751e-17, 4.75016e-17, 0.0584, 1, 0, -6.93889e-18, 2.60209e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-9.36751e-17, 4.75016e-17, 0.0584, 1, 0, -6.93889e-18, 2.60209e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [6.24839e-17, 0.04, -1.75298e-15, 1, 0, -7.80626e-18, -1.73472e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-1.35729e-17, -0.04, 9.9628e-16, 1, 0, -7.80626e-18, -1.73472e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-7.96323e-17, 3.68229e-18, 3.67268e-17, -1.03431e-13, 2.77556e-17, 0, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.06582e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.17961e-16, 1.78243e-16, -0.15, 1, 9.71445e-17, -4.16334e-17, -2.22045e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [7.77156e-16, 0.02, -0.2, 1, -2.498e-16, -1.11022e-16, -1.11022e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -2.77556e-17, -1.66533e-16, -5.55112e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 2.77556e-17, 9.02056e-17, -1.11022e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.16407e-16, -3.1225e-17, -0.04, 1, 2.22045e-16, -1.66533e-16, 0], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [2.90566e-17, -9.54098e-18, 0.01, 1, 4.16334e-17, 2.08167e-17, 1.70003e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-5.96745e-16, 2.84495e-16, 0.2105, -3.1225e-17, 0.92388, 0.382683, 9.71445e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -1.38778e-17, 2.77556e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-9.02056e-17, 0.008, 0.045, 1, 6.93889e-18, -7.80626e-18, 2.60209e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-2.60209e-16, -0.008, 0.045, 1, 6.93889e-18, -7.80626e-18, 2.60209e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-0.0137686, 0.28, 0.07, 1, 0, 0, -0.000233485], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [0, 0, 0.05, 1, 0, -0, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True, is_place: True } }
base2(table): { pose: [-0.00742163, 0.280014, 0.210038, 1, -1.96489e-05, -3.20198e-05, -3.39258e-05], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base2_handle(base2): { pose: [2.96038e-19, 5.74204e-18, 0.05, 1, 0, 7.89172e-21, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
base3(table): { pose: [0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
base3_handle(base3): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [0.166303, 0.409916, 0.14, 0.837607, 0, 0, 0.546273], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [-0.193708, 0.410084, 0.14, 0.949474, 0, 0, 0.313846], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.208193, 0.150091, 0.14, 0.886195, 0, 0, 0.463313], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [0.206158, 0.149895, 0.14, 0.995592, 0, 0, 0.093793], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [0.212573, 0.27304, 0.280052, 0.971719, -2.66553e-05, -2.64735e-05, 0.23614], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
place_base1(table): { pose: [0, 0.3, 0.05], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base1(base1): { pose: [0.2, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base1(base1): { pose: [-0.2, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base1(base1): { pose: [-0.2, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base1(base1): { pose: [0.2, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base2(base2): { pose: [0.2, 1.13165e-17, 0.02, 1, 0, 7.89172e-21, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }