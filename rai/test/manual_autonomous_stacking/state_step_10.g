world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 2, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { pose: [1, -0, 0, 0], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333, 1, -0, 0, 0] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.976763, 0, 0, -0.214322], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.981143, 0, 0, 0.193282], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-5.13478e-16, -0.316, -8.8136e-16, 0.707107, 0.707107, 5.55112e-17, 5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [0.997526, 0, 0, 0.0702942], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.24213e-16, 5.55112e-17, 0.707107, 0.707107, -2.5327e-16, 1.94289e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [0.604333, 0, 0, -0.796732], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -8.69096e-16, 0.707107, -0.707107, -2.77556e-17, 8.32667e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [0.99411, 0, 0, 0.108377], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, 5.55112e-17, -1.38778e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.485725, 0, 0, 0.874112], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 1.35308e-16, 6.2797e-16, -0.707107, -0.707107, 1.11022e-16, 8.32667e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [0.59412, 0, 0, 0.804377], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-3.1225e-17, -3.46945e-17, 0.107, 1, 6.93889e-18, -2.77556e-17, -2.08167e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1, 0, -1.38778e-17, -2.08167e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 0, 1.38778e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, 0, -9.97466e-18], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-3.98986e-17, -9.89758e-19, 0.0584, 1, 0, 0, -9.86624e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-3.98986e-17, -9.89758e-19, 0.0584, 1, 0, 0, -9.86624e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [1.6243e-16, 0.04, 2.45788e-18, 1, 0, 0, -9.75782e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-1.6243e-16, -0.04, -2.45788e-18, 1, 0, 0, 4.11997e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.03664e-13, -4.42354e-17, 4.33681e-18, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.59874e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-2.77556e-17, 7.63278e-17, -0.15, 1, 0, 0, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [4.71845e-16, 0.02, -0.2, 1, 0, 0, 2.77556e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 0, 1.11022e-16, 0], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 0, 1.38778e-17, 0], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-4.77049e-17, -1.00614e-16, -0.04, 1, -2.77556e-17, 0, -1.94289e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-4.70544e-17, 9.67108e-17, 0.01, 1, 6.93889e-18, -2.77556e-17, -2.08167e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-1.59595e-16, 1.249e-16, 0.2105, -5.55112e-17, -0.92388, -0.382683, -9.71445e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [-0.707107, -0.707107, 3.05311e-16, 7.60568e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-2.77556e-17, 0.008, 0.045, 1, 0, 0, -9.6494e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-2.60209e-17, -0.008, 0.045, 1, 0, 0, -9.86624e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base(table): { pose: [-4.75286e-09, 0.2, 0.0700025, 1, -3.1074e-06, -2.5705e-06, -0.000900285], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 1, inertia: [0.1616, 0.2516, 0.41], logical: { is_object: True, is_place: True } }
base_handle(base): { pose: [1.94156e-20, -1.17497e-17, 0.02, 1, 0, -1.29454e-22, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.5, 0.5, 0.5], logical: { is_object: True } }
cyl1(base): { pose: [-0.149819, -0.100271, 0.120008, 1, 3.36096e-06, 2.09722e-06, 0.000900279], joint: rigid, shape: cylinder, size: [0.2, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.00102847, 5.94184e-12, 1.27055e-21, 0.00102847, -2.0117e-21, 0.000286308], logical: { is_object: True }, { is_place: True } }
cyl2(base): { pose: [0.15018, -0.0997286, 0.120006, 1, 3.00713e-06, 2.6484e-06, 0.000900322], joint: rigid, shape: cylinder, size: [0.2, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.00102847, 5.94184e-12, 1.27055e-21, 0.00102847, -2.0117e-21, 0.000286308], logical: { is_object: True }, { is_place: True } }
cyl3(base): { pose: [-0.150179, 0.099729, 0.120009, 1, 2.99468e-06, 2.18643e-06, 0.00090027], joint: rigid, shape: cylinder, size: [0.2, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.00102847, 5.94184e-12, 1.27055e-21, 0.00102847, -2.0117e-21, 0.000286308], logical: { is_object: True } }
cyl4(base): { pose: [0.14982, 0.100269, 0.120007, -1, -2.83188e-06, -2.81339e-06, -0.000900282], joint: rigid, shape: cylinder, size: [0.2, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.00102847, 5.94184e-12, 1.27055e-21, 0.00102847, -2.0117e-21, 0.000286308], logical: { is_object: True } }
roof(table): { pose: [0.5, -0.5, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_place: True } }
roof_handle(roof): { pose: [0, 0, 0.02], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0.5, 0], logical: { is_object: True } }
base_target(table): { pose: [0, 0.2, 0.07], logical: { is_pose: True }, { is_place: True } }
cyl1_target(table): { pose: [-0.15, 0.1, 0.19], logical: { is_pose: True } }
cyl2_target(table): { pose: [0.15, 0.1, 0.19], logical: { is_pose: True } }
cyl3_target(table): { pose: [-0.15, 0.3, 0.19], logical: { is_pose: True } }
cyl4_target(table): { pose: [0.15, 0.3, 0.19], logical: { is_pose: True } }
roof_target(base_target): { pose: [0, 0, 0.24], logical: { is_pose: True } }