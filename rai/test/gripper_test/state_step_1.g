world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 2, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.997652, -0, 0, -0.0684879], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.929214, -5.55112e-17, 5.55112e-17, 0.369541], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-1.11022e-16, -0.316, -6.96721e-17, 0.707107, 0.707107, -5.55112e-17, 0] }
l_panda_joint3(l_panda_joint3_origin): { pose: [3.70575e-17, 3.41294e-17, -2.70464e-16, 0.997564, 0, 0, -0.0697567], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, 8.67362e-19, -2.08167e-17, 0.707107, 0.707107, -2.77556e-17, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-1.60867e-17, -1.48133e-17, -1.80787e-18, 0.645429, 2.77556e-17, 2.77556e-17, -0.763821], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 7.63278e-17, 0.707107, -0.707107, 1.66533e-16, 4.16334e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-4.49975e-17, 1.50452e-16, -1.24092e-16, 0.980061, 0, 0, -0.198696], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [4.53087e-17, 4.96325e-18, -3.16856e-17, 0.707107, 0.707107, -5.55112e-17, 5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.547573, -2.77556e-17, -2.77556e-17, 0.836758], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -1.17961e-16, 3.98986e-17, 0.707107, 0.707107, 2.08167e-17, 1.38778e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.49177e-16, 5.20809e-17, -2.13569e-17, 0.881448, 0, -5.55112e-17, -0.472281], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-4.85723e-17, 7.28584e-17, 0.107, 1, 0, 6.93889e-18, -5.55112e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-1.86064e-17, -1.1984e-16, -5.09455e-16, 1, 2.77556e-17, 1.38778e-17, -2.77556e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-2.02821e-17, 1.67253e-17, 8.9036e-18, 0.92388, 0, -1.38778e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 5.55112e-17, 6.93889e-18, -7.63278e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-1.21431e-17, 5.89806e-17, 0.0584, 1, 0, -3.46945e-18, 0] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-1.21431e-17, 5.89806e-17, 0.0584, 1, 0, -3.46945e-18, 0] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [3.29597e-17, 0.04, -2.08167e-16, 1, 0, -3.46945e-18, 0], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [9.54098e-18, -0.04, -2.39392e-16, 1, 0, -3.46945e-18, 0], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [2.38191e-17, 6.34575e-17, 8.79304e-17, -1.03396e-13, -2.77556e-17, 6.93889e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 4.62223e-33, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-4.16334e-17, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.38778e-16, 0.02, -0.2, 1, 2.08167e-17, -2.77556e-17, 8.32667e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 5.55112e-17, -1.11022e-16, -2.77556e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -5.55112e-17, 8.32667e-17, -1.11022e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.64799e-17, 2.08167e-17, -0.04, 1, -8.32667e-17, -6.93889e-17, 1.11022e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-4.16334e-17, -1.04083e-17, 0.01, 1, 0, 6.93889e-18, -5.55112e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-1.249e-16, 1.45717e-16, 0.2105, 0, -0.92388, -0.382683, -1.11022e-16], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 4.16334e-17, -1.38778e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-6.245e-17, 0.008, 0.045, 1, 0, -3.46945e-18, 0], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [1.99493e-17, -0.008, 0.045, 1, 0, -3.46945e-18, 0], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base(table): { pose: [2.0844e-05, 0.200055, 0.0699924, 1, -2.93134e-05, 1.34981e-05, 1.72529e-05], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 1, inertia: [0.1616, 0.2516, 0.41], logical: { is_object: True, is_place: True } }
base_handle(base): { pose: [-4.23516e-22, 3.2092e-18, 0.02, 1, 0, -9.13104e-22, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.5, 0.5, 0.5], logical: { is_object: True } }
cyl1(table): { pose: [0.2, -0.1, 0.15], joint: rigid, shape: cylinder, size: [0.2, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.00102847, 5.94184e-12, 1.27055e-21, 0.00102847, -2.0117e-21, 0.000286308], logical: { is_object: True }, { is_place: True } }
cyl2(table): { pose: [0.3, -0.1, 0.15], joint: rigid, shape: cylinder, size: [0.2, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.00102847, 5.94184e-12, 1.27055e-21, 0.00102847, -2.0117e-21, 0.000286308], logical: { is_object: True }, { is_place: True } }
cyl3(table): { pose: [0.4, -0.1, 0.15], joint: rigid, shape: cylinder, size: [0.2, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.00102847, 5.94184e-12, 1.27055e-21, 0.00102847, -2.0117e-21, 0.000286308], logical: { is_object: True } }
cyl4(table): { pose: [0.5, -0.1, 0.15], joint: rigid, shape: cylinder, size: [0.2, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.00102847, 5.94184e-12, 1.27055e-21, 0.00102847, -2.0117e-21, 0.000286308], logical: { is_object: True } }
roof(table): { pose: [0.4, -0.5, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_place: True } }
roof_handle(roof): { pose: [0, 0, 0.02], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0.5, 0], logical: { is_object: True } }
base_target(table): { pose: [0, 0.2, 0.07], logical: { is_pose: True }, { is_place: True } }
cyl1_target(table): { pose: [-0.15, 0.1, 0.19], logical: { is_pose: True } }
cyl2_target(table): { pose: [0.15, 0.1, 0.19], logical: { is_pose: True } }
cyl3_target(table): { pose: [-0.15, 0.3, 0.19], logical: { is_pose: True } }
cyl4_target(table): { pose: [0.15, 0.3, 0.19], logical: { is_pose: True } }
roof_target(base_target): { pose: [-0.025, -0.025, 0.24], logical: { is_pose: True } }