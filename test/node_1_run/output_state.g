world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, -1.65735e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -1.11022e-16, 1.11022e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, 6.59195e-17, -3.98986e-17, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-2.91434e-16, -0.316, -2.94388e-16, 0.707107, 0.707107, -1.07553e-16, 2.22045e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [2.07014e-27, -8.82909e-19, -2.91926e-26, 1, 5.55112e-17, -1.11022e-16, 1.28855e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.00473e-16, 3.1225e-17, 0.707107, 0.707107, -1.11022e-16, -2.22045e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-7.75801e-26, -1.09497e-25, 3.31167e-18, 0.315322, 2.42861e-17, -8.32667e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -8.92408e-18, 0.707107, -0.707107, -1.66533e-16, -5.55112e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [2.16837e-16, -7.10825e-17, -7.32604e-17, 1, 5.55112e-17, 8.32667e-17, -1.21358e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-2.99929e-17, -1.60082e-18, -4.6711e-17, 0.707107, 0.707107, -8.32667e-17, 9.71445e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, -5.55112e-17, -9.71445e-17, 0.681639], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.40006e-16, 4.32641e-16, 0.707107, 0.707107, 2.22045e-16, -2.22045e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-9.74312e-17, 9.25841e-17, -5.3227e-17, 1, -1.38778e-17, -1.38778e-17, -2.37371e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [0, 3.5482e-17, 0.107, 1, -2.77556e-17, -1.38778e-17, 1.04083e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-1.89362e-17, 2.31259e-17, -1.52846e-15, 1, 1.38778e-17, 0, 1.38778e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [2.38405e-23, -5.20694e-17, -3.21726e-24, 0.92388, 0, -5.55112e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 2.77556e-17, 1.38778e-17, -1.70003e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-3.46945e-18, 3.46945e-17, 0.0584, 1, 0, 0, 5.55112e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-3.46945e-18, 3.46945e-17, 0.0584, 1, 0, 0, 5.55112e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [1.04083e-17, 0.04, -9.71445e-16, 1, 0, 2.77556e-17, -3.46945e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [1.21431e-17, -0.04, 5.01335e-16, 1, 0, -1.38778e-17, -3.46945e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.68183e-16, 4.18732e-16, -1.94862e-16, -1.03487e-13, -1.38778e-17, 4.85723e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 5.32908e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-2.94903e-17, 2.62103e-16, -0.15, 1, 2.77556e-17, 2.77556e-17, 5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [5.96745e-16, 0.02, -0.2, 1, 2.77556e-17, 0, 0], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -3.81639e-17, -1.73147e-16, 1.73472e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 0, -2.77556e-17, 2.77556e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [7.08611e-17, -1.39596e-16, -0.04, 1, 1.66533e-16, 2.77556e-16, 8.32667e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-8.67362e-18, 1.14669e-17, 0.01, 1, -2.77556e-17, -1.38778e-17, 1.04083e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [5.55112e-17, 1.13593e-16, 0.2105, 4.16334e-17, 0.92388, 0.382683, 8.32667e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -1.11022e-16, -6.245e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.93168e-16, 0.008, 0.045, 1, 0, -2.77556e-17, -1.04083e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-2.75821e-16, -0.008, 0.045, 1, -2.77556e-17, -1.38778e-17, -3.46945e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
cyl1(table): { pose: [0.001381, 0.266951, 0.122, 0.816178, -3.25583e-08, -5.39731e-08, -0.5778], joint: rigid, shape: cylinder, size: [0.1, 0.03], color: [0, 0.8, 0], contact: 1, mass: 0.2, inertia: [0.000320193, 3.29708e-12, 5.29396e-23, 0.000320193, -6.35275e-22, 0.000155491], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [0.0749138, 0.414899, 0.122, 0.701243, 2.12084e-08, 1.92009e-08, -0.712922], joint: rigid, shape: cylinder, size: [0.1, 0.03], color: [1, 0.9, 0], contact: 1, mass: 0.2, inertia: [0.000320193, 3.29708e-12, 5.29396e-23, 0.000320193, -6.35275e-22, 0.000155491], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.0744809, 0.413247, 0.122014, 0.724239, 4.3918e-07, 5.59803e-07, -0.689549], joint: rigid, shape: cylinder, size: [0.1, 0.03], color: [0, 0.9, 0.9], contact: 1, mass: 0.2, inertia: [0.000320193, 3.29708e-12, 5.29396e-23, 0.000320193, -6.35275e-22, 0.000155491], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [-0.6, -0.15, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.03], color: [0.9, 0, 0.9], contact: 1, mass: 0.2, inertia: [0.000320193, 3.29708e-12, 5.29396e-23, 0.000320193, -6.35275e-22, 0.000155491], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [-0.7, 0, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.03], color: [1, 0.5, 0], contact: 1, mass: 0.2, inertia: [0.000320193, 3.29708e-12, 5.29396e-23, 0.000320193, -6.35275e-22, 0.000155491], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl6(table): { pose: [-0.7, -0.15, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.03], color: [0.5, 0, 0.8], contact: 1, mass: 0.2, inertia: [0.000320193, 3.29708e-12, 5.29396e-23, 0.000320193, -6.35275e-22, 0.000155491], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl7(table): { pose: [-0.8, 0, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.03], color: [1, 0.4, 0.7], contact: 1, mass: 0.2, inertia: [0.000320193, 3.29708e-12, 5.29396e-23, 0.000320193, -6.35275e-22, 0.000155491], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl8(table): { pose: [-0.8, -0.15, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.03], color: [0.6, 0.3, 0.1], contact: 1, mass: 0.2, inertia: [0.000320193, 3.29708e-12, 5.29396e-23, 0.000320193, -6.35275e-22, 0.000155491], logical: { is_object: True, is_cylinder: True, is_place: True } }
base1(table): { pose: [-0.00499887, 0.345, 0.061, 1, -4.14112e-10, 3.66168e-09, 1.16344e-06], joint: rigid, shape: ssBox, size: [0.25, 0.25, 0.02, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.03145, 0.03145, 0.0625], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [3.72305e-19, -1.77841e-17, 0.03, 1, 0, 1.45892e-25, 0], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [0.5, 0.5, 0.5], contact: 1, mass: 0.2, inertia: [0.00064, 0.00064, 0.00064], logical: { is_object: True } }
bottom_left_base1(base1): { pose: [0.075, 0.075, 0.01, 1, 0, 1.45892e-25, 0], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
bottom_right_base1(base1): { pose: [-0.075, 0.075, 0.01, 1, 0, 1.45892e-25, 0], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
top_left_base1(base1): { pose: [0.075, -0.075, 0.01, 1, 0, 1.45892e-25, 0], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
top_right_base1(base1): { pose: [-0.075, -0.075, 0.01, 1, 0, 1.45892e-25, 0], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
top_center_base1(base1): { pose: [-1.28922e-19, -0.075, 0.01, 1, 0, 1.45892e-25, 0], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
bottom_center_base1(base1): { pose: [-1.06849e-18, 0.075, 0.01, 1, 0, 1.45892e-25, 0], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
mid_left_base1(base1): { pose: [0.075, -2.10496e-17, 0.01, 1, 0, 1.45892e-25, 0], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
mid_right_base1(base1): { pose: [-0.075, 6.47047e-17, 0.01, 1, 0, 1.45892e-25, 0], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
base2(table): { pose: [0.45, -0.23, 0.06], joint: rigid, shape: ssBox, size: [0.25, 0.25, 0.02, 0.002], color: [0.9, 0.1, 0.1], contact: 1, mass: 0.5, inertia: [0.03145, 0.03145, 0.0625], logical: { is_object: True, is_place: True } }
base2_handle(base2): { pose: [0, 0, 0.03], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [0.5, 0.5, 0.5], contact: 1, mass: 0.2, inertia: [0.00064, 0.00064, 0.00064], logical: { is_object: True } }
bottom_left_base2(base2): { pose: [0.075, 0.075, 0.01], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
bottom_right_base2(base2): { pose: [-0.075, 0.075, 0.01], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
top_left_base2(base2): { pose: [0.075, -0.075, 0.01], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
top_right_base2(base2): { pose: [-0.075, -0.075, 0.01], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
top_center_base2(base2): { pose: [0, -0.075, 0.01], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
bottom_center_base2(base2): { pose: [0, 0.075, 0.01], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
mid_left_base2(base2): { pose: [0.075, 0, 0.01], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
mid_right_base2(base2): { pose: [-0.075, 0, 0.01], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
base3(table): { pose: [0.45, -0.61, 0.06], joint: rigid, shape: ssBox, size: [0.25, 0.25, 0.02, 0.002], color: [0.1, 0.1, 0.9], contact: 1, mass: 0.5, inertia: [0.03145, 0.03145, 0.0625], logical: { is_object: True, is_place: True } }
base3_handle(base3): { pose: [0, 0, 0.03], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [0.5, 0.5, 0.5], contact: 1, mass: 0.2, inertia: [0.00064, 0.00064, 0.00064], logical: { is_object: True } }
bottom_left_base3(base3): { pose: [0.075, 0.075, 0.01], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
bottom_right_base3(base3): { pose: [-0.075, 0.075, 0.01], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
top_left_base3(base3): { pose: [0.075, -0.075, 0.01], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
top_right_base3(base3): { pose: [-0.075, -0.075, 0.01], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
top_center_base3(base3): { pose: [0, -0.075, 0.01], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
bottom_center_base3(base3): { pose: [0, 0.075, 0.01], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
mid_left_base3(base3): { pose: [0.075, 0, 0.01], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
mid_right_base3(base3): { pose: [-0.075, 0, 0.01], shape: ssBox, size: [0.03, 0.03, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
place_base1(table): { pose: [0, 0.35, 0.05], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }