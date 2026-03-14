world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, 1.55996e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731688, 2.08167e-17, 7.63278e-17, -0.681639], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-2.39392e-16, -0.316, -3.8279e-16, 0.707107, 0.707107, -7.28584e-17, 0] }
l_panda_joint3(l_panda_joint3_origin): { pose: [2.36934e-26, 1.07361e-17, -3.34118e-25, 1, 2.77556e-17, -2.77556e-17, -3.59114e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.12649e-16, -1.09288e-16, 0.707107, 0.707107, 1.11022e-16, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.29342e-16, 9.50378e-17, 6.36923e-17, 0.315322, -5.20417e-18, -5.55112e-17, -0.948985], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 2.01258e-16, 0.707107, -0.707107, 2.91434e-16, -1.66533e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [2.4683e-16, -1.42905e-16, -2.65494e-17, 1, 5.55112e-17, -1.11022e-16, 3.95005e-08], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-5.99857e-17, 3.8359e-18, -9.3422e-17, 0.707107, 0.707107, -9.71445e-17, 0] }
l_panda_joint6(l_panda_joint6_origin): { pose: [5.07553e-31, -5.53574e-32, -3.30872e-24, 0.731689, 5.55112e-17, 4.16334e-17, 0.681639], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.33067e-16, 1.65845e-16, 0.707107, 0.707107, -5.55112e-17, -3.19189e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.94862e-16, 1.32789e-16, -1.06454e-16, 1, -5.55112e-17, -2.77556e-17, -2.50451e-07], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [3.46945e-17, -8.89376e-17, 0.107, 1, 1.38778e-17, -4.16334e-17, 1.42247e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.11875e-16, 8.27195e-17, -1.71001e-15, 1, 0, 1.38778e-17, -2.42861e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [2.43578e-17, 1.9616e-17, 1.33067e-17, 0.92388, -2.77556e-17, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1.16981e-24, -1.16981e-24, 2.55099e-31, 1, 0, 0, -6.93889e-18], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-3.46945e-18, -4.16334e-17, 0.0584, 1, 0, 2.77556e-17, -1.17961e-16] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-3.46945e-18, -4.16334e-17, 0.0584, 1, 0, 2.77556e-17, -1.17961e-16] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-1.09288e-16, 0.04, -7.04298e-16, 1, 0, -1.38778e-17, 2.15106e-16], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [7.71952e-17, -0.04, 2.08167e-16, 1, 2.77556e-17, 0, -1.76942e-16], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.74918e-16, 1.71577e-16, -3.99203e-17, -1.03435e-13, 0, 6.93889e-18, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 5.32908e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-1.02349e-16, 5.00032e-17, -0.15, 1, 1.94289e-16, 5.55112e-17, 1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [4.71845e-16, 0.02, -0.2, 1, 5.55112e-17, -8.32667e-17, -5.55112e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 1.21431e-16, -8.94467e-17, 1.73472e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-2.51715e-25, 5.66065e-26, 3.38338e-18, 1, 1.11022e-16, 1.94289e-16, -2.22045e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.11041e-16, 3.79847e-17, -0.04, 1, -8.32667e-17, 0, -2.22045e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-3.46945e-17, 6.26704e-18, 0.01, 1, 1.38778e-17, -4.16334e-17, 1.42247e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [0, -8.16882e-17, 0.2105, 1.38778e-17, 0.92388, 0.382683, 5.55112e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 2.77556e-17, -2.08167e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.04697e-16, 0.008, 0.045, 1, 0, 4.16334e-17, -6.93889e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.73472e-16, -0.008, 0.045, 1, -2.77556e-17, 1.38778e-17, -6.245e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
cyl1(table): { pose: [0.138216, 0.246972, 0.117, 0.860665, -1.48516e-08, 2.62255e-09, -0.509172], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0, 0.8, 0], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [-0.16191, 0.243535, 0.117, 0.95867, 6.28918e-09, 5.2732e-09, -0.284522], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [1, 0.9, 0], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.0118885, 0.446568, 0.117, 0.875386, 2.03118e-09, 4.38139e-09, -0.483424], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0, 0.9, 0.9], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [-0.55, 0, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0.9, 0, 0.9], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [-0.65, 0, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [1, 0.5, 0], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl6(table): { pose: [-0.65, -0.15, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0.5, 0, 0.8], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl7(table): { pose: [-0.8, 0, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [1, 0.4, 0.7], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl8(table): { pose: [-0.8, -0.15, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0.6, 0.3, 0.1], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
place_base1(table): { pose: [0, 0.35, 0.05], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
base1(table): { pose: [-0.00499319, 0.345, 0.066, 1, -4.61528e-10, 1.54157e-08, 5.03949e-06], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [3.41969e-20, -2.31099e-17, 0.035, 1, 0, 9.5779e-25, 0], shape: ssBox, size: [0.04, 0.04, 0.05, 0.002], color: [0.5, 0.5, 0.5], contact: 1, mass: 0.2, inertia: [0.00082, 0.00082, 0.00064], logical: { is_object: True } }
bottom_left_base1(base1): { pose: [0.15, 0.1, 0.015, 1, 0, 9.5779e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
bottom_right_base1(base1): { pose: [-0.15, 0.1, 0.015, 1, 0, 9.5779e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
top_left_base1(base1): { pose: [0.15, -0.1, 0.015, 1, 0, 9.5779e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
top_right_base1(base1): { pose: [-0.15, -0.1, 0.015, 1, 0, 9.5779e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
top_center_base1(base1): { pose: [-5.05322e-20, -0.1, 0.015, 1, 0, 9.5779e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
bottom_center_base1(base1): { pose: [2.31001e-18, 0.1, 0.015, 1, 0, 9.5779e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
mid_left_base1(base1): { pose: [0.15, -6.09966e-17, 0.015, 1, 0, 9.5779e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
mid_right_base1(base1): { pose: [-0.15, -1.57066e-16, 0.015, 1, 0, 9.5779e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
base2(table): { pose: [0.45, -0.23, 0.065], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [0.9, 0.1, 0.1], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base2_handle(base2): { pose: [0, 0, 0.035], shape: ssBox, size: [0.04, 0.04, 0.05, 0.002], color: [0.5, 0.5, 0.5], contact: 1, mass: 0.2, inertia: [0.00082, 0.00082, 0.00064], logical: { is_object: True } }
bottom_left_base2(base2): { pose: [0.15, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
bottom_right_base2(base2): { pose: [-0.15, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
top_left_base2(base2): { pose: [0.15, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
top_right_base2(base2): { pose: [-0.15, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
top_center_base2(base2): { pose: [0, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
bottom_center_base2(base2): { pose: [0, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
mid_left_base2(base2): { pose: [0.15, 0, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
mid_right_base2(base2): { pose: [-0.15, 0, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
base3(table): { pose: [0.45, -0.61, 0.065], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [0.1, 0.1, 0.9], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base3_handle(base3): { pose: [0, 0, 0.035], shape: ssBox, size: [0.04, 0.04, 0.05, 0.002], color: [0.5, 0.5, 0.5], contact: 1, mass: 0.2, inertia: [0.00082, 0.00082, 0.00064], logical: { is_object: True } }
bottom_left_base3(base3): { pose: [0.15, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
bottom_right_base3(base3): { pose: [-0.15, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
top_left_base3(base3): { pose: [0.15, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
top_right_base3(base3): { pose: [-0.15, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
top_center_base3(base3): { pose: [0, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
bottom_center_base3(base3): { pose: [0, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
mid_left_base3(base3): { pose: [0.15, 0, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }
mid_right_base3(base3): { pose: [-0.15, 0, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5, 0], logical: { is_place: True } }