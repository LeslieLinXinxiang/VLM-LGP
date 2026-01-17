world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.996702, -0, 0, -0.0811503], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 5.55112e-17, -1.11022e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.993573, -2.77556e-17, 0, 0.113191], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-2.35922e-16, -0.316, -8.89296e-17, 0.707107, 0.707107, 5.55112e-17, -5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-4.3245e-17, 6.87004e-17, -2.37867e-16, 0.992985, -4.85723e-17, -4.85723e-17, -0.118244], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -5.50775e-17, -5.20417e-17, 0.707107, 0.707107, 2.77556e-17, 5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.75586e-17, -6.41324e-18, 4.23232e-18, 0.364643, -8.32667e-17, 1.11022e-16, -0.931147], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -1.21431e-17, 0.707107, -0.707107, -2.08167e-17, -6.93889e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [3.99474e-17, 1.58896e-16, -3.28963e-17, 0.996161, 2.77556e-17, 0, -0.0875431], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [3.93381e-18, 2.6692e-17, -6.51421e-18, 0.707107, 0.707107, 0, -1.38778e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.277376, 0, -1.38778e-17, 0.960761], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -4.0766e-17, 1.45608e-16, 0.707107, 0.707107, -1.23165e-16, -1.09288e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.00724e-17, 3.32445e-17, 5.71374e-18, 0.975353, 9.54098e-18, -1.9082e-17, -0.22065], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-3.64292e-17, 3.81639e-17, 0.107, 1, 3.46945e-18, -4.33681e-18, 4.11997e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.89555e-17, 4.59668e-17, -3.3398e-16, 1, 3.46945e-18, -5.20417e-18, 4.10913e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [2.70766e-17, 5.65229e-18, -2.29857e-18, 0.92388, -6.93889e-18, -3.46945e-18, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [7.40912e-18, 6.16082e-17, -1.18196e-18, 1, -1.04083e-17, 4.33681e-18, 2.5804e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-2.42861e-17, -8.98533e-18, 0.0584, 1, 3.46945e-18, -2.60209e-18, 2.5804e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-2.42861e-17, -8.98533e-18, 0.0584, 1, 3.46945e-18, -2.60209e-18, 2.5804e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [2.73033e-17, 0.04, -2.04562e-16, 1, 3.46945e-18, -2.60209e-18, 2.5804e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-4.28887e-17, -0.04, -1.76251e-17, 1, 3.46945e-18, -2.60209e-18, 2.5804e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.53148e-17, 2.6894e-17, 2.26589e-18, -1.03441e-13, 0, -3.46945e-18, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.77636e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [2.77556e-17, 1.38778e-17, -0.15, 1, 2.77556e-17, -4.85723e-17, 5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.94289e-16, 0.02, -0.2, 1, -1.38778e-17, 4.16334e-17, -3.46945e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -5.55112e-17, 5.55112e-17, -8.32667e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 5.55112e-17, -1.38778e-17, -5.55112e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.40151e-17, 1.73472e-18, -0.04, 1, 2.22045e-16, -2.77556e-17, -1.66533e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [1.34441e-17, -2.21177e-17, 0.01, 1, 3.46945e-18, -4.33681e-18, 4.11997e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-4.16334e-17, 6.245e-17, 0.2105, 1.73472e-17, 0.92388, 0.382683, 4.16334e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -2.77556e-17, 1.38778e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-6.07153e-18, 0.008, 0.045, 1, 3.46945e-18, -2.60209e-18, 2.5804e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-4.85723e-17, -0.008, 0.045, 1, 3.46945e-18, -2.60209e-18, 2.5804e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-0.0137686, 0.28, 0.07, 1, 0, 0, -0.000233485], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [0, 0, 0.05, 1, 0, -0, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True, is_place: True } }
base2(table): { pose: [-0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base2_handle(base2): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
base3(table): { pose: [0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
base3_handle(base3): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [0.5, 0, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [0.4, 0, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [0.5, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [0.206158, 0.149895, 0.14, 0.995592, 0, 0, 0.093793], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [0.6, 0, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
place_base1(table): { pose: [0, 0.3, 0.05], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base1(base1): { pose: [0.2, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base1(base1): { pose: [-0.2, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base1(base1): { pose: [-0.2, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base1(base1): { pose: [0.2, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base2(base2): { pose: [0.2, 0, 0.02], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }