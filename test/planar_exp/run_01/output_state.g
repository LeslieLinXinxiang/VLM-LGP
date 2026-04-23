world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, 0, 0, -1.87119e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.732172, -4.31892e-17, 0, -0.681119], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [1.8735e-16, -0.316, -4.69042e-16, 0.707107, 0.707107, 1.59673e-17, -5.51477e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-2.0945e-16, -9.59269e-17, -1.82121e-16, 1, 7.84522e-17, 1.03518e-16, -1.23093e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -5.98217e-18, -1.63064e-16, 0.707107, 0.707107, -1.14197e-16, 5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.8987e-26, 4.34728e-27, -1.16467e-21, 0.315307, -5.55112e-17, -2.77556e-17, -0.94899], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -5.6066e-17, 0.707107, -0.707107, 3.85489e-17, -2.23765e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.94488e-16, 7.75721e-17, -5.19928e-16, 1, -6.2013e-17, 2.97924e-17, 1.73267e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [3.56309e-22, 6.80506e-18, -1.21708e-22, 0.707107, 0.707107, -9.20344e-17, -5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731204, -2.08167e-17, 4.16334e-17, 0.682159], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -2.77556e-17, -4.24355e-17, 0.707107, 0.707107, 1.11022e-16, 5.55112e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-6.08877e-18, 5.47691e-17, -3.32943e-18, 1, 1.21307e-16, 0, 0.000439447], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [1.38778e-17, 1.30782e-18, 0.107, 1, 2.71051e-20, -2.77556e-17, -8.00209e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.17674e-16, 1.60282e-19, -2.21285e-15, 1, -1.35525e-20, 0, -2.44962e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -3.08998e-18, -2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, 2.77556e-17, 6.59195e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [6.93889e-18, 1.38778e-17, 0.0584, 1, -1.38778e-17, 0, 5.89806e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [6.93889e-18, 1.38778e-17, 0.0584, 1, -1.38778e-17, 0, 5.89806e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [5.9848e-17, 0.04, -1.16226e-15, 1, 0, 0, 5.89806e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [2.51535e-17, -0.04, 6.93889e-16, 1, 0, 0, -5.20417e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-3.20039e-17, 8.16111e-16, -2.03479e-16, -1.03438e-13, 6.93889e-18, -1.38778e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-8.50015e-17, 2.68933e-19, -0.15, 1, -6.64921e-19, -1.76282e-16, -1.44995e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [5.96745e-16, 0.02, -0.2, 1, -1.70254e-18, 3.40343e-18, -9.45289e-19], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 0, 2.77556e-17, 2.77556e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -1.94289e-16, 8.32667e-17, 1.11022e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.91989e-17, -2.50542e-16, -0.04, 1, 1.04083e-17, 4.16334e-17, 6.93889e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [8.67362e-18, -1.28165e-17, 0.01, 1, 2.71051e-20, -2.77556e-17, -8.00209e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-2.77556e-17, -2.16027e-17, 0.2105, 5.55112e-17, 0.92388, 0.382683, 7.14964e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 1.38778e-17, 3.1225e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-2.08167e-17, 0.008, 0.045, 1, 0, 0, 5.55112e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-6.93889e-18, -0.008, 0.045, 1, 0, 0, 6.245e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
fmb_board(table): { pose: [0.4, 0, 0.075, 0.707107, -0, -0, -0.707107], shape: mesh, color: [0.8, 0.8, 0.8, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/assembly1_parts/assembly1_part_1.obj", contact: 1, mass: 0.5, inertia: [0.00266659, 0.0027789, 0.00504737], logical: { is_object: True, is_box: True } }
fmb_slot2(fmb_board): { pose: [0.06725, 1.49325e-17, -0.0195], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1], logical: { is_place: True } }
fmb_slot3(fmb_board): { pose: [0, 0, 0.018], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1], logical: { is_place: True } }
fmb_slot4(fmb_board): { pose: [0, 0, -0.0135], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1], logical: { is_place: True } }
fmb_slot5(fmb_board): { pose: [-0.06725, -1.49325e-17, -0.0195], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1], logical: { is_place: True } }
fmb_part2(table): { pose: [0.4, -0.0672501, 0.106, 0.707107, 6.07716e-09, 1.18435e-08, -0.707107], joint: rigid, shape: mesh, color: [0.9, 0.2, 0.2], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/assembly1_parts/assembly1_part_2.obj", contact: 1, mass: 0.1, inertia: [0.000228937, 0.000121409, 0.00013699], logical: { is_object: True, is_box: True } }
fmb_part2_handle(fmb_part2): { pose: [1.67364e-17, -0.033, 0.035, 0.707107, -3.30872e-24, 3.30872e-24, -0.707107], shape: marker, size: [0.03], color: [1, 1, 0] }
fmb_part3(table): { pose: [0.4, -2.04971e-09, 0.112, 0.707107, 7.51087e-10, 7.36299e-09, -0.707107], joint: rigid, shape: mesh, color: [0.2, 0.9, 0.2], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/assembly1_parts/assembly1_part_3.obj", contact: 1, mass: 0.1, inertia: [4.37015e-05, 0.00041163, 0.00041163], logical: { is_object: True, is_box: True } }
fmb_part4(table): { pose: [0.4, -6.28385e-10, 0.112, 0.707107, -8.59929e-08, 9.02944e-08, -0.707107], joint: rigid, shape: mesh, color: [0.2, 0.2, 0.9], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/assembly1_parts/assembly1_part_4.obj", contact: 1, mass: 0.1, inertia: [0.00031172, 0.000110843, 0.000228886], logical: { is_object: True, is_box: True } }
fmb_part4_handle(fmb_part4): { pose: [1.55096e-24, -4.14017e-18, 0.04, 0.707107, 3.97047e-23, 3.97047e-23, -0.707107], shape: marker, size: [0.03], color: [1, 1, 0] }
fmb_part5(table): { pose: [0.4, 0.0672501, 0.106, 0.707107, -1.14776e-09, 4.54902e-09, -0.707107], joint: rigid, shape: mesh, color: [0.9, 0.9, 0.2], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/assembly1_parts/assembly1_part_5.obj", contact: 1, mass: 0.1, inertia: [0.000228937, 0.000121409, 0.00013699], logical: { is_object: True, is_box: True } }
fmb_part5_handle(fmb_part5): { pose: [8.05256e-17, -0.033, 0.035, 0.707107, 0, 8.27181e-25, -0.707107], shape: marker, size: [0.03], color: [1, 1, 0] }