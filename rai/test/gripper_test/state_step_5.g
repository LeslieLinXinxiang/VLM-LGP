world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 2, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.990266, -0, 0, -0.13919], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 1.11022e-16, -1.11022e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.86951, 0, -5.55112e-17, 0.493916], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-3.60822e-16, -0.316, -3.09382e-16, 0.707107, 0.707107, 0, -2.498e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-1.58846e-17, 3.73587e-17, -8.93846e-16, 0.99646, -2.77556e-17, -1.66533e-16, -0.084072], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.32453e-16, 1.249e-16, 0.707107, 0.707107, -2.08167e-17, -9.71445e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.28015e-16, 3.85134e-17, 6.42176e-17, 0.871287, -8.32667e-17, -5.55112e-17, -0.490773], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -4.16334e-17, 0.707107, -0.707107, 6.245e-17, 5.55112e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.36926e-16, 2.52777e-16, -9.89931e-17, 0.959861, 8.32667e-17, 0, 0.280478], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [1.35351e-16, 2.378e-17, 1.93358e-17, 0.707107, 0.707107, -1.11022e-16, 5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [-2.67015e-17, 5.51328e-17, -9.96302e-18, 0.860048, -6.93889e-18, 1.72822e-16, 0.510213], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -1.31839e-16, 5.68989e-16, 0.707107, 0.707107, -1.66533e-16, 1.66533e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.72097e-16, -3.60822e-17, -1.46512e-16, 0.999481, 1.38778e-16, -1.11022e-16, 0.0322043], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-3.26128e-16, -6.245e-17, 0.107, 1, 2.77556e-17, 2.22045e-16, 1.66533e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-4.0621e-16, -4.41032e-16, -1.30372e-15, 1, 1.38778e-16, 0, -1.04083e-16] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-3.44006e-18, -2.07321e-17, 1.81306e-17, -0.92388, -2.77556e-17, 5.55112e-17, 0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, 0, -1.17961e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-4.68375e-17, -6.93889e-18, 0.0584, 1, 5.55112e-17, -5.55112e-17, 2.77556e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-4.68375e-17, -6.93889e-18, 0.0584, 1, 5.55112e-17, -5.55112e-17, 2.77556e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-5.20417e-17, 0.04, -6.59195e-16, 1, 1.11022e-16, 5.55112e-17, -3.46945e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-8.67362e-17, -0.04, 2.77556e-16, 1, -5.55112e-17, 5.55112e-17, 6.93889e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-8.89115e-17, 1.62142e-16, 2.55309e-16, 1.03362e-13, 4.16334e-17, -4.85723e-17, -1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 7.10544e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, -5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.11022e-16, 1.26635e-16, -0.15, 1, -1.11022e-16, 1.94289e-16, 5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [8.46545e-16, 0.02, -0.2, 1, 1.11022e-16, -5.55112e-17, 8.32667e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 4.16334e-17, 5.55112e-17, -2.77556e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1.66021e-18, -2.78751e-18, 1.22905e-18, 1, 5.55112e-17, -4.33681e-17, 1.11022e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.37043e-16, -9.97466e-17, -0.04, 1, -5.89806e-17, -6.59195e-17, 1.31839e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-5.89806e-17, -3.85976e-17, 0.01, 1, 2.77556e-17, 2.22045e-16, 1.66533e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-6.38378e-16, -2.77556e-17, 0.2105, 4.85723e-17, -0.92388, -0.382683, 4.51028e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 5.55112e-17, -6.93889e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-2.08167e-17, 0.008, 0.045, 1, 5.55112e-17, 0, 2.08167e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.07553e-16, -0.008, 0.045, 1, 5.55112e-17, -5.55112e-17, -3.46945e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base(table): { pose: [2.0844e-05, 0.200055, 0.0699924, 1, -2.93134e-05, 1.34981e-05, 1.72529e-05], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 1, inertia: [0.1616, 0.2516, 0.41], logical: { is_object: True, is_place: True } }
base_handle(base): { pose: [1.21761e-20, -7.74866e-18, 0.02, 1, 0, -2.08884e-21, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.5, 0.5, 0.5], logical: { is_object: True } }
cyl1(table): { pose: [-0.14999, 0.100002, 0.190019, 1, -7.3733e-06, -1.28847e-05, 3.43614e-06], joint: rigid, shape: cylinder, size: [0.2, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.00102847, 5.94184e-12, 1.27055e-21, 0.00102847, -2.0117e-21, 0.000286308], logical: { is_object: True }, { is_place: True } }
cyl2(table): { pose: [0.150005, 0.100099, 0.190005, 1, -9.5136e-06, -1.50073e-05, -2.26628e-05], joint: rigid, shape: cylinder, size: [0.2, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.00102847, 5.94184e-12, 1.27055e-21, 0.00102847, -2.0117e-21, 0.000286308], logical: { is_object: True }, { is_place: True } }
cyl3(table): { pose: [-0.150039, 0.300175, 0.18997, 1, -4.05643e-05, -2.82477e-05, 2.84979e-05], joint: rigid, shape: cylinder, size: [0.2, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.00102847, 5.94184e-12, 1.27055e-21, 0.00102847, -2.0117e-21, 0.000286308], logical: { is_object: True } }
cyl4(table): { pose: [0.149984, 0.30004, 0.190005, 1, -1.99294e-05, -1.12113e-05, -2.205e-05], joint: rigid, shape: cylinder, size: [0.2, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.00102847, 5.94184e-12, 1.27055e-21, 0.00102847, -2.0117e-21, 0.000286308], logical: { is_object: True } }
roof(table): { pose: [0.4, -0.5, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_place: True } }
roof_handle(roof): { pose: [0, 0, 0.02], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0.5, 0], logical: { is_object: True } }
base_target(table): { pose: [0, 0.2, 0.07], logical: { is_pose: True }, { is_place: True } }
cyl1_target(table): { pose: [-0.15, 0.1, 0.19], logical: { is_pose: True } }
cyl2_target(table): { pose: [0.15, 0.1, 0.19], logical: { is_pose: True } }
cyl3_target(table): { pose: [-0.15, 0.3, 0.19], logical: { is_pose: True } }
cyl4_target(table): { pose: [0.15, 0.3, 0.19], logical: { is_pose: True } }
roof_target(base_target): { pose: [-0.025, -0.025, 0.24], logical: { is_pose: True } }