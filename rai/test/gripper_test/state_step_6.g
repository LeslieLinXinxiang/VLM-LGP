world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 2, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.989462, -0, 0, -0.144795], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 1.11022e-16, -1.11022e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.900226, 0, -5.55112e-17, 0.435423], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-4.16334e-16, -0.316, -5.32075e-16, 0.707107, 0.707107, 0, -2.77556e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-1.21382e-16, 1.24496e-16, -1.22628e-15, 0.999133, -2.77556e-17, 2.77556e-17, -0.041627], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.71231e-16, 1.80411e-16, 0.707107, 0.707107, 4.85723e-17, -5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-9.39758e-17, -1.20892e-16, 2.5054e-17, 0.863094, -1.38778e-16, -4.16334e-17, -0.505044], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -7.89299e-17, 0.707107, -0.707107, -4.0766e-17, 5.55112e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [2.87688e-16, 5.25152e-16, -2.06919e-16, 0.881605, 5.55112e-17, -2.77556e-17, 0.471989], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [9.11527e-17, 5.13964e-17, -3.70883e-17, 0.707107, 0.707107, -1.17961e-16, 5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [3.90063e-18, 4.79551e-17, -2.76872e-17, 0.868683, -1.38778e-17, 3.46945e-18, 0.495368], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -2.46331e-16, 7.14706e-16, -0.707107, -0.707107, 1.66533e-16, -1.38778e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-4.92346e-16, -4.76184e-17, -3.63372e-16, -0.93021, 0, 0, -0.367029], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-1.73472e-16, -5.29091e-17, 0.107, 1, 4.16334e-17, 2.22045e-16, 2.22045e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-8.36197e-16, -5.50676e-16, -1.98272e-15, 1, 1.66533e-16, 1.11022e-16, -9.02056e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-1.88238e-17, 3.79034e-17, 4.53966e-17, -0.92388, -4.16334e-17, 5.55112e-17, 0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 5.55112e-17, -1.11022e-16, -1.38778e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [8.50015e-17, 4.68375e-17, 0.0584, 1, 0, 5.55112e-17, 1.249e-16] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [8.50015e-17, 4.68375e-17, 0.0584, 1, 0, 5.55112e-17, 1.249e-16] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-1.97758e-16, 0.04, -9.78384e-16, 1, 1.11022e-16, 1.11022e-16, -8.32667e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-1.9082e-16, -0.04, 1.97758e-16, 1, -1.11022e-16, -5.55112e-17, -2.77556e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.35752e-16, 4.81117e-16, 3.69925e-16, 1.03376e-13, 4.16334e-17, -4.16334e-17, -1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 8.8818e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [2.08167e-16, 2.73219e-16, -0.15, 1, -1.66533e-16, 2.22045e-16, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.04777e-15, 0.02, -0.2, 1, 1.11022e-16, -1.11022e-16, 8.32667e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 6.93889e-17, 5.55112e-17, 0], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [2.60987e-18, -5.99439e-18, 2.32468e-18, 1, 8.32667e-17, -4.16334e-17, 1.38778e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.01228e-16, -1.75207e-16, -0.04, 1, -6.245e-17, -7.63278e-17, 1.2837e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-9.2374e-17, -1.08529e-16, 0.01, 1, 4.16334e-17, 2.22045e-16, 2.22045e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-4.02456e-16, 1.26635e-16, 0.2105, 9.71445e-17, -0.92388, -0.382683, 6.93889e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 5.55112e-17, -4.16334e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.18575e-16, 0.008, 0.045, 1, 1.66533e-16, -1.11022e-16, -2.77556e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-2.80158e-16, -0.008, 0.045, 1, 0, 5.55112e-17, 4.16334e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base(table): { pose: [2.0844e-05, 0.200055, 0.0699924, 1, -2.93134e-05, 1.34981e-05, 1.72529e-05], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 1, inertia: [0.1616, 0.2516, 0.41], logical: { is_object: True, is_place: True } }
base_handle(base): { pose: [1.55642e-20, -7.74866e-18, 0.02, 1, 0, -2.08884e-21, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.5, 0.5, 0.5], logical: { is_object: True } }
cyl1(table): { pose: [-0.14999, 0.100002, 0.190019, 1, -7.3733e-06, -1.28847e-05, 3.43614e-06], joint: rigid, shape: cylinder, size: [0.2, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.00102847, 5.94184e-12, 1.27055e-21, 0.00102847, -2.0117e-21, 0.000286308], logical: { is_object: True }, { is_place: True } }
cyl2(table): { pose: [0.150005, 0.100099, 0.190005, 1, -9.5136e-06, -1.50073e-05, -2.26628e-05], joint: rigid, shape: cylinder, size: [0.2, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.00102847, 5.94184e-12, 1.27055e-21, 0.00102847, -2.0117e-21, 0.000286308], logical: { is_object: True }, { is_place: True } }
cyl3(table): { pose: [-0.150039, 0.300175, 0.18997, 1, -4.05643e-05, -2.82477e-05, 2.84979e-05], joint: rigid, shape: cylinder, size: [0.2, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.00102847, 5.94184e-12, 1.27055e-21, 0.00102847, -2.0117e-21, 0.000286308], logical: { is_object: True } }
cyl4(table): { pose: [0.149984, 0.30004, 0.190005, 1, -1.99294e-05, -1.12113e-05, -2.205e-05], joint: rigid, shape: cylinder, size: [0.2, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.00102847, 5.94184e-12, 1.27055e-21, 0.00102847, -2.0117e-21, 0.000286308], logical: { is_object: True } }
roof(table): { pose: [-0.0249847, 0.175039, 0.31003, 1, -1.97431e-05, 3.02666e-06, -4.38987e-06], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_place: True } }
roof_handle(roof): { pose: [-1.26065e-18, -1.26638e-17, 0.02, 1, -3.38813e-21, 5.44931e-22, 8.47033e-22], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0.5, 0], logical: { is_object: True } }
base_target(table): { pose: [0, 0.2, 0.07], logical: { is_pose: True }, { is_place: True } }
cyl1_target(table): { pose: [-0.15, 0.1, 0.19], logical: { is_pose: True } }
cyl2_target(table): { pose: [0.15, 0.1, 0.19], logical: { is_pose: True } }
cyl3_target(table): { pose: [-0.15, 0.3, 0.19], logical: { is_pose: True } }
cyl4_target(table): { pose: [0.15, 0.3, 0.19], logical: { is_pose: True } }
roof_target(base_target): { pose: [-0.025, -0.025, 0.24], logical: { is_pose: True } }