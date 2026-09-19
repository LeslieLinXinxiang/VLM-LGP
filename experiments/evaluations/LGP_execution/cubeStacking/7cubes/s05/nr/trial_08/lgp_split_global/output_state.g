world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, -0.000166364], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -5.55112e-17, 5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.732773, 6.93889e-17, -2.77556e-17, -0.680473], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-3.7817e-16, -0.316, -8.40609e-16, 0.707107, 0.707107, 2.13371e-16, -2.77556e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-4.2195e-22, 1.71575e-17, 5.69315e-21, 1, -1.11022e-16, 5.55112e-17, -4.19754e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -5.63285e-16, -9.97466e-17, 0.707107, 0.707107, -2.22045e-16, -2.77556e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.29634e-16, 9.42781e-17, 8.61961e-17, 0.315283, 6.07153e-18, -1.11022e-16, -0.948998], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 1.56077e-15, 0.707107, -0.707107, -1.38778e-17, -1.11022e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [4.34173e-16, -2.01858e-16, -1.45036e-16, 1, 2.77556e-17, 5.55112e-17, -0.000260349], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-1.67699e-20, 2.65223e-17, -8.77365e-21, 0.707107, 0.707107, 1.38778e-17, 1.38778e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.727212, 0, -2.77556e-17, 0.686413], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -8.60423e-16, 5.10002e-16, 0.707107, 0.707107, 6.93889e-17, 9.71445e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.42188e-16, 1.94407e-16, -1.35334e-16, 1, 8.32667e-17, 2.77556e-17, -0.000232301], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [0, -9.85608e-17, 0.107, 1, 0, -2.77556e-17, 4.16334e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [3.79772e-17, 9.66454e-17, -4.04903e-15, 1, -1.38778e-17, 1.38778e-17, 4.85723e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-1.92084e-21, 1.96241e-17, 1.20131e-20, 0.92388, 0, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, 1.38778e-17, 2.42861e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [5.20417e-17, 6.93889e-18, 0.0584, 1, 0, 0, 2.08167e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [5.20417e-17, 6.93889e-18, 0.0584, 1, 0, 0, 2.08167e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-7.80626e-18, 0.04, -2.20657e-15, 1, 0, 0, 2.08167e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [1.2837e-16, -0.04, 1.32359e-15, 1, 0, 0, 2.08167e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.22595e-16, 5.40569e-17, -2.70142e-17, -1.0341e-13, 2.77556e-17, 2.08167e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.24346e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-2.25514e-17, 2.36957e-17, -0.15, 1, -5.55112e-17, -1.11022e-16, -3.88578e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [4.02456e-16, 0.02, -0.2, 1, 0, -5.55112e-17, 0], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 1.11022e-16, 2.57498e-16, -2.42861e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [9.67948e-23, 2.86926e-22, 8.67362e-19, 1, 1.38778e-16, -1.38778e-16, 0], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.23257e-16, -3.16928e-16, -0.04, 1, 3.05311e-16, -1.11022e-16, -2.77556e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-1.47451e-17, -7.50048e-18, 0.01, 1, 0, -2.77556e-17, 4.16334e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [5.55112e-17, -1.89966e-16, 0.2105, 4.16334e-17, 0.92388, 0.382683, 6.93889e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, -4.16334e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.73472e-17, 0.008, 0.045, 1, 0, 0, 2.08167e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-7.97973e-17, -0.008, 0.045, 1, 0, 0, 2.08167e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
Table_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Front(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
cube_4(table): { pose: [-0.08, 0.1, 0.0965, 1, -2.3789e-09, -1.93362e-09, -6.09273e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_5(table): { pose: [-2.79483e-08, 0.100001, 0.0965026, 1, -2.57949e-06, -1.35182e-08, -2.16747e-08], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [0.08, 0.1, 0.0665, 1, 8.34059e-10, -4.19826e-10, 1.12525e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_6(table): { pose: [0.08, 0.1, 0.0965, 1, 8.62286e-10, -4.00898e-10, 1.53348e-10], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_1(table): { pose: [-0.08, 0.1, 0.0665, 1, 9.5066e-11, -2.18533e-11, -1.89365e-11], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [-2.79039e-08, 0.100001, 0.0665026, 1, -2.57798e-06, -1.33596e-08, -2.16409e-08], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
longrect_1(table): { pose: [-0.08, 0.1, 0.0665, 1, 7.63929e-09, 9.89257e-10, 5.20082e-10], joint: rigid, shape: ssBox, size: [0.095, 0.03, 0.03, 0.001], color: [0.9, 0.6, 0.1], contact: 1, mass: 0.6, inertia: [0.00108, 0.005955, 0.005955], logical: { is_object: True, is_box: True, is_place: True } }
longrect_1_Left(longrect_1): { pose: [-0.038, -4.69956e-18, 0.016, 1, 0, -3.45627e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_1_Right(longrect_1): { pose: [0.038, -1.0825e-17, 0.016, 1, 0, -3.45627e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }
longrect_1_Center(longrect_1): { pose: [-4.81458e-18, 6.11552e-18, 0.016, 1, 0, -3.45627e-26, 0], shape: marker, size: [0.01], color: [0, 1, 1, 0], logical: { is_place: True } }