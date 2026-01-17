world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 2, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.973031, -0, 0, -0.230672], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.987931, 8.32667e-17, -5.55112e-17, 0.154896], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-5.55112e-17, -0.316, -1.78042e-16, 0.707107, 0.707107, 0, -1.11022e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-1.12375e-16, 6.79119e-17, -2.69363e-16, 0.968401, 4.16334e-17, -2.77556e-17, 0.249398], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -6.93889e-17, -6.59195e-17, 0.707107, 0.707107, 1.73472e-17, 5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-8.00785e-17, -2.2772e-17, -1.48706e-18, 0.5438, 2.77556e-17, 1.94289e-16, -0.839215], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 2.04697e-16, 0.707107, -0.707107, 9.71445e-17, 1.11022e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-1.46616e-16, 2.46391e-16, -1.17232e-16, 0.991821, -2.77556e-17, 5.55112e-17, -0.127634], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, 8.32667e-17, 4.85723e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.430845, -5.55112e-17, 0, 0.902426], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -1.83013e-16, 3.85231e-17, 0.707107, 0.707107, 6.07153e-18, 1.22298e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.913e-16, 1.22423e-16, -2.14907e-16, 0.954619, 3.1225e-17, -4.94396e-17, -0.297829], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-9.1073e-18, 1.73472e-18, 0.107, 1, 0, -3.46945e-18, 1.72388e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-5.31764e-19, 2.22913e-18, -6.66861e-16, 1, -1.73472e-18, 0, 1.72659e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 1.19262e-18, 4.55365e-18, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -4.33681e-19, 1.81032e-18, -5.57144e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-4.33681e-18, 4.20128e-19, 0.0584, 1, 0, -1.70902e-18, 3.72694e-20] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-4.33681e-18, 4.20128e-19, 0.0584, 1, 0, -1.70902e-18, 3.72694e-20] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [1.98714e-18, 0.04, -3.42012e-16, 1, 0, -1.70899e-18, 1.01644e-20], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [2.99087e-18, -0.04, -3.25193e-16, 1, 0, -1.70899e-18, 1.01644e-20], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [1.03412e-13, 0, -6.60686e-20, -1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 4.62223e-33, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [2.08167e-17, 1.04083e-17, -0.15, 1, -1.38778e-17, -6.93889e-18, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [4.16334e-17, 0.02, -0.2, 1, 0, 0, 5.55112e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 1.11022e-16, 5.55112e-17, -1.11022e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [7.07306e-19, 7.53227e-19, -6.86153e-18, 1, 2.77556e-17, 1.31839e-16, -5.55112e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [6.06476e-17, -9.54098e-18, -0.04, 1, 0, -1.11022e-16, 0], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-1.68051e-18, 3.30682e-18, 0.01, 1, 0, -3.46945e-18, 1.72388e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-4.59702e-17, 3.46945e-18, 0.2105, -2.34188e-17, -0.92388, -0.382683, -5.89806e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 9.21572e-19, 3.46945e-18], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-2.1684e-18, 0.008, 0.045, 1, 0, -1.70899e-18, 1.01644e-20], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-6.07153e-18, -0.008, 0.045, 1, 0, -1.70899e-18, 1.01644e-20], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_handle(table): { pose: [0, 0.3, 0.12], joint: rigid, shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.5, 0.5, 0.5], contact: 1, mass: 0.5, inertia: [0.0026, 0.0026, 0.0016], logical: { is_object: True } }
base(base_handle): { pose: [0, 0, -0.05], shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True } }
cyl1(table): { pose: [-0.15, 0.2, 0.14], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl2(table): { pose: [0.15, 0.2, 0.14], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl3(table): { pose: [-0.15, 0.4, 0.14], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl4(table): { pose: [0.15, 0.4, 0.14], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
roof_handle(table): { pose: [4.17769e-07, 0.299949, 0.260109, 1, 6.37856e-06, 6.36168e-05, -2.91804e-06], joint: rigid, shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0.5, 0], contact: 1, mass: 0.5, inertia: [0.0026, 0.0026, 0.0016], logical: { is_object: True, is_box: True } }
roof(roof_handle): { pose: [-8.47033e-22, 2.6384e-18, -0.05, 1, 0, -2.38041e-21, 0], shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], logical: { is_place: True } }
base_target(table): { pose: [0, 0.3, 0.12], logical: { is_pose: True } }
roof_target(base_target): { pose: [0, 0, 0.14], logical: { is_pose: True } }