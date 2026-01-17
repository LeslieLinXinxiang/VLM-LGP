world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 2, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.99953, -0, 0, -0.030654], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.990057, 5.55112e-17, -5.55112e-17, 0.140665], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-4.16334e-17, -0.316, -1.31809e-16, 0.707107, 0.707107, 1.66533e-16, -5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-1.05044e-16, 1.12729e-16, -2.61658e-16, 0.994106, -2.77556e-17, 2.77556e-17, -0.108408], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.21177e-17, 0, 0.707107, 0.707107, 4.16334e-17, -5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-5.50134e-17, -1.56695e-17, 1.44135e-18, 0.40481, 0, -1.11022e-16, -0.914401], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 5.55112e-17, 0.707107, -0.707107, -1.17961e-16, 6.93889e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-7.10621e-17, 2.13621e-16, -2.32979e-16, 0.999804, 2.77556e-17, 6.93889e-17, 0.0198069], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-1.4556e-17, -9.08285e-18, 9.52946e-18, 0.707107, 0.707107, -1.66533e-16, -9.71445e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.286091, 5.55112e-17, -9.71445e-17, 0.958202], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -7.52436e-17, 3.32579e-17, 0.707107, 0.707107, -2.38524e-17, 1.47451e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.70986e-16, 1.15352e-16, -1.03021e-16, 0.982082, 3.8706e-17, 3.14419e-18, -0.188452], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [4.77049e-18, 4.33681e-19, 0.107, 1, -6.72205e-18, -3.57787e-18, -2.15756e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.08525e-17, -9.75e-18, -5.56306e-16, 1, 9.75782e-19, -8.67362e-19, -2.16671e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 1.73472e-18, -8.67362e-18, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -1.73472e-18, 1.21431e-17, 1.26039e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [2.60209e-18, 7.15573e-18, 0.0584, 1, 1.73472e-18, 3.46945e-18, 1.27123e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [2.60209e-18, 7.15573e-18, 0.0584, 1, 1.73472e-18, 3.46945e-18, 1.27123e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-2.77115e-17, 0.04, -5.00386e-16, 1, 1.73472e-18, 3.46945e-18, 1.27394e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [3.29631e-17, -0.04, -1.66832e-16, 1, 0, -3.46945e-18, 1.27394e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-6.57278e-17, 2.46531e-17, 1.13944e-16, -1.03469e-13, -3.46945e-18, 0, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.77636e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-2.08167e-17, 5.20417e-18, -0.15, 1, -6.93889e-18, 2.77556e-17, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [5.55112e-17, 0.02, -0.2, 1, -1.38778e-17, 0, -1.8735e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 1.38778e-16, 1.11022e-16, 2.77556e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 0, 4.16334e-17, 0], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [6.10677e-17, -7.30752e-17, -0.04, 1, 1.11022e-16, 0, 1.11022e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [6.61363e-18, -1.29562e-17, 0.01, 1, -6.72205e-18, -3.57787e-18, -2.15756e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-3.55618e-17, 1.73472e-18, 0.2105, -3.57787e-17, -0.92388, -0.382683, -5.89806e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [-0.707107, -0.707107, -2.77556e-17, -2.25514e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [3.90313e-18, 0.008, 0.045, 1, 0, 0, 1.27665e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-6.07153e-17, -0.008, 0.045, 1, 0, 5.20417e-18, 1.27123e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [0, 0, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base1_handle(base1): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True } }
base2(table): { pose: [-0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
base2_handle(base2): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
base3(table): { pose: [0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
base3_handle(base3): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [-0.149998, 0.2, 0.140015, 1, 1.21068e-06, 2.26752e-07, 1.66959e-06], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl2(table): { pose: [0.150141, 0.200036, 0.14003, 1, 5.21524e-05, 0.000358374, 8.30057e-05], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl3(table): { pose: [-0.4, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl4(table): { pose: [0.4, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl5(table): { pose: [-0.5, 0, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl6(table): { pose: [0.5, 0, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl7(table): { pose: [-0.5, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl8(table): { pose: [0.5, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
base1_target(table): { pose: [0, 0.3, 0.07], logical: { is_pose: True } }
base2_target(base1_target): { pose: [0, 0, 0.13], logical: { is_pose: True } }
base3_target(base1_target): { pose: [0, 0, 0.27], logical: { is_pose: True } }
cyl1_target(table): { pose: [-0.15, 0.2, 0.14], logical: { is_pose: True } }
cyl2_target(table): { pose: [0.15, 0.2, 0.14], logical: { is_pose: True } }
cyl3_target(table): { pose: [-0.15, 0.4, 0.14], logical: { is_pose: True } }
cyl4_target(table): { pose: [0.15, 0.4, 0.14], logical: { is_pose: True } }
cyl5_target(table): { pose: [-0.15, 0.2, 0.27], logical: { is_pose: True } }
cyl6_target(table): { pose: [0.15, 0.2, 0.27], logical: { is_pose: True } }
cyl7_target(table): { pose: [-0.15, 0.4, 0.27], logical: { is_pose: True } }
cyl8_target(table): { pose: [0.15, 0.4, 0.27], logical: { is_pose: True } }