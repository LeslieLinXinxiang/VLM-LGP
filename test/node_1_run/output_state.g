world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, -1.66394e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -1.11022e-16, 1.11022e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, 2.42861e-17, 2.60209e-17, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [9.71445e-17, -0.316, -2.99164e-16, 0.707107, 0.707107, 1.05818e-16, 5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-7.85324e-18, 3.66806e-18, 1.10744e-16, 1, -8.32667e-17, 0, 1.89532e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.56193e-16, 1.65666e-16, 0.707107, 0.707107, -3.33067e-16, -3.88578e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-7.85324e-18, 1.10744e-16, 2.56897e-17, 0.315322, 8.67362e-19, -2.77556e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 1.11412e-16, 0.707107, -0.707107, 4.16334e-17, 0] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.86844e-16, -1.33059e-16, -1.19971e-16, 1, 2.77556e-17, 2.77556e-17, -6.81486e-09], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, -1.38778e-17, -1.11022e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731689, 0, 9.71445e-17, 0.681639], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.60822e-16, 3.10307e-16, 0.707107, 0.707107, 6.93889e-17, -1.11022e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-3.01316e-16, 1.37265e-16, 8.84083e-17, 1, 0, 1.38778e-17, -2.46126e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [3.46945e-17, 2.52797e-17, 0.107, 1, -1.38778e-17, 1.38778e-17, -1.80411e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-1.38014e-16, 4.94215e-17, -2.35257e-15, 1, -8.32667e-17, 2.77556e-17, -2.08167e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -2.77556e-17, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 2.77556e-17, 4.16334e-17, 2.63678e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [4.16334e-17, 5.89806e-17, 0.0584, 1, 0, -4.16334e-17, -1.52656e-16] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [4.16334e-17, 5.89806e-17, 0.0584, 1, 0, -4.16334e-17, -1.52656e-16] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-1.5439e-16, 0.04, -1.69309e-15, 1, 0, 2.77556e-17, 2.60209e-16], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [3.1225e-16, -0.04, 8.32667e-16, 1, 0, 1.38778e-17, -1.9082e-16], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.72887e-16, 5.61225e-16, -1.41635e-16, -1.034e-13, 1.38778e-17, 0, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 5.32908e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-1.89085e-16, 3.09539e-16, -0.15, 1, 2.77556e-17, 2.77556e-17, -4.44089e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [4.71845e-16, 0.02, -0.2, 1, -8.32667e-17, -2.77556e-17, -2.22045e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -6.93889e-17, -1.78893e-17, 2.08167e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 5.55112e-17, 3.46945e-17, -8.32667e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.60636e-16, -1.27401e-16, -0.04, 1, 2.22045e-16, 1.66533e-16, 2.77556e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [4.59702e-17, 3.65423e-17, 0.01, 1, -1.38778e-17, 1.38778e-17, -1.80411e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [6.93889e-17, 1.08307e-16, 0.2105, 4.16334e-17, 0.92388, 0.382683, 8.32667e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, -2.08167e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.55004e-16, 0.008, 0.045, 1, -2.77556e-17, -4.16334e-17, -2.04697e-16], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-2.72352e-16, -0.008, 0.045, 1, -2.77556e-17, 0, -1.8735e-16], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
cyl1(table): { pose: [0.00137779, 0.266943, 0.122, 0.815936, -5.02424e-08, -5.53132e-08, -0.578142], joint: rigid, shape: cylinder, size: [0.1, 0.03], color: [0, 0.8, 0], contact: 1, mass: 0.2, inertia: [0.000320193, 3.29708e-12, 5.29396e-23, 0.000320193, -6.35275e-22, 0.000155491], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [0.0748522, 0.414839, 0.122, 0.696875, 2.33933e-08, 2.07624e-08, -0.717192], joint: rigid, shape: cylinder, size: [0.1, 0.03], color: [1, 0.9, 0], contact: 1, mass: 0.2, inertia: [0.000320193, 3.29708e-12, 5.29396e-23, 0.000320193, -6.35275e-22, 0.000155491], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.074573, 0.413036, 0.122015, 0.718437, 4.68914e-07, 6.09103e-07, -0.695592], joint: rigid, shape: cylinder, size: [0.1, 0.03], color: [0, 0.9, 0.9], contact: 1, mass: 0.2, inertia: [0.000320193, 3.29708e-12, 5.29396e-23, 0.000320193, -6.35275e-22, 0.000155491], logical: { is_object: True, is_cylinder: True, is_place: True } }
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