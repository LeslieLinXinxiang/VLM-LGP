world: {  }
table_base(world): { pose: [0, 0, 0.6], shape: marker, size: [0.05] }
table(table_base): { pose: [0, 0, -0.05], shape: ssBox, size: [2, 1.5, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_box: True, is_place: True }, friction: 0.1 }
l_panda_base(table): { pose: [-0.4, -0.2, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.997422, -0, 0, 0.0717659], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.990973, 5.55112e-17, -1.11022e-16, 0.134058], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-4.16334e-17, -0.316, -5.50648e-17, 0.707107, 0.707107, -1.66533e-16, 5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-9.2236e-17, 7.87806e-17, -2.55744e-16, 0.985174, 0, 5.55112e-17, 0.171559], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -1.60896e-16, -7.97973e-17, 0.707107, 0.707107, -2.08167e-17, -1.66533e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-7.07408e-17, -2.18958e-17, -3.80744e-17, 0.368058, -2.77556e-17, -4.85723e-17, -0.929803], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 1.21431e-16, 0.707107, -0.707107, 5.55112e-17, 0] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-2.75749e-16, 1.65639e-16, -8.63703e-17, 0.927001, -9.71445e-17, -2.77556e-17, -0.37506], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, 3.46945e-18, -5.9848e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.397991, 0, 0, 0.91739], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -1.04083e-16, 8.50015e-17, 0.707107, 0.707107, 1.13082e-16, 3.81639e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-3.74111e-16, 3.42882e-17, 3.72065e-17, 0.994567, 8.32667e-17, 6.245e-17, 0.104102], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-1.04083e-17, 4.85723e-17, 0.107, 1, 0, -1.38778e-17, 4.16334e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-1.98844e-17, 5.18979e-17, -3.46657e-16, 1, 1.38778e-17, -1.38778e-17, -7.28584e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -3.1225e-17, 5.37764e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 2.42861e-17, -2.36356e-17, -9.19403e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-9.71445e-17, 5.1608e-17, 0.0584, 1, -3.46945e-18, 1.51788e-18, 1.38778e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-9.71445e-17, 5.1608e-17, 0.0584, 1, -3.46945e-18, 1.51788e-18, 1.38778e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-4.64039e-17, 0.04, -2.64328e-16, 1, 0, 1.73472e-18, 7.80626e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [4.15249e-17, -0.04, -2.28658e-16, 1, 0, 2.1684e-18, -1.47451e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [1.03411e-13, 2.77556e-17, 1.56125e-17, -1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 8.88178e-18, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [8.32667e-17, 0, -0.15, 1, 4.16334e-17, -2.77556e-17, -5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [-2.77556e-17, 0.02, -0.2, 1, 1.04083e-17, 0, -1.45717e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 5.55112e-17, 0, 0], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-5.54677e-18, 2.70454e-18, 3.17286e-18, 1, 0, 8.32667e-17, -2.77556e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [4.59702e-17, -3.29597e-17, -0.04, 1, 0, 2.25514e-17, 2.77556e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [1.47451e-17, 2.60209e-17, 0.01, 1, 0, -1.38778e-17, 4.16334e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-9.02056e-17, 9.71445e-17, 0.2105, 2.77556e-17, -0.92388, -0.382683, -8.32667e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -6.93889e-18, 0], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-1.07553e-16, 0.008, 0.045, 1, 3.46945e-18, 1.73472e-18, 1.56125e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [3.46945e-17, -0.008, 0.045, 1, 0, 1.51788e-18, 1.38778e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_base(table): { pose: [0.4, -0.2, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
r_panda_link0(r_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
r_panda_joint1_origin(r_panda_link0): { pose: [0, 0, 0.333] }
r_panda_joint1(r_panda_joint1_origin): { pose: [0.994903, -0, 0, -0.100834], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint2_origin(r_panda_joint1): { pose: [0.707107, -0.707107, 5.55112e-17, 0] }
r_panda_joint2(r_panda_joint2_origin): { pose: [0.998774, -2.77556e-17, 1.11022e-16, 0.0495047], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint3_origin(r_panda_joint2): { pose: [-1.52656e-16, -0.316, 7.96881e-17, 0.707107, 0.707107, 0, -2.22045e-16] }
r_panda_joint3(r_panda_joint3_origin): { pose: [3.8141e-17, -4.88135e-17, 3.79026e-18, 0.964948, -3.98986e-17, 2.77556e-17, -0.262443], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint4_origin(r_panda_joint3): { pose: [0.0825, 3.79471e-19, 8.67362e-17, 0.707107, 0.707107, 3.98986e-17, 2.77556e-17] }
r_panda_joint4(r_panda_joint4_origin): { pose: [-1.0255e-17, -1.34444e-18, 9.25311e-18, 0.261243, -8.32667e-17, 5.55112e-17, -0.965273], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint5_origin(r_panda_joint4): { pose: [-0.0825, 0.384, -1.26635e-16, 0.707107, -0.707107, 1.21431e-17, 1.11022e-16] }
r_panda_joint5(r_panda_joint5_origin): { pose: [4.9456e-17, 1.91936e-16, -1.57175e-16, 0.999865, -1.04083e-16, -2.77556e-17, -0.0164032], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
r_panda_joint6_origin(r_panda_joint5): { pose: [5.75247e-17, 8.91166e-17, -3.35149e-17, 0.707107, 0.707107, -1.38778e-16, -2.77556e-17] }
r_panda_joint6(r_panda_joint6_origin): { pose: [0.426972, 0, -1.49186e-16, 0.904265], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
r_panda_joint7_origin(r_panda_joint6): { pose: [0.088, 2.08167e-17, 8.67362e-17, 0.707107, 0.707107, 4.16334e-17, 5.55112e-17] }
r_panda_joint7(r_panda_joint7_origin): { pose: [-7.53082e-17, 3.39234e-17, -8.50716e-17, 0.846211, -4.16334e-17, 2.77556e-17, -0.532848], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
r_panda_joint8_origin(r_panda_joint7): { pose: [5.55112e-17, -6.93889e-18, 0.107, 1, 5.55112e-17, -1.38778e-17, -2.11311e-16] }
r_panda_joint8(r_panda_joint8_origin): { pose: [9.86685e-18, -2.58358e-16, -5.15708e-16, 1, 0, -1.38778e-17, 1.91687e-16] }
r_panda_hand_joint_origin(r_panda_joint8): { pose: [-4.73385e-17, 9.70941e-17, -2.56467e-17, -0.92388, 2.77556e-17, -4.16334e-17, 0.382683] }
r_panda_hand_joint(r_panda_hand_joint_origin): { pose: [1, 0, -4.85723e-17, -3.81639e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
r_panda_finger_joint1_origin(r_panda_hand_joint): { pose: [4.94396e-17, -2.08167e-17, 0.0584, 1, 0, -1.38778e-17, -1.73472e-17] }
r_panda_finger_joint2_origin(r_panda_hand_joint): { pose: [4.94396e-17, -2.08167e-17, 0.0584, 1, 0, -1.38778e-17, -1.73472e-17] }
r_panda_finger_joint1(r_panda_finger_joint1_origin): { pose: [1.04734e-16, 0.04, -3.41741e-16, 1, 0, 0, 6.93889e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
r_panda_finger_joint2(r_panda_finger_joint2_origin): { pose: [-4.6187e-17, -0.04, -7.80626e-17, 1, 0, 0, 6.93889e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "r_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
r_panda_rightfinger_0(r_panda_finger_joint2): { pose: [-1.13779e-16, 7.62477e-17, 7.70765e-17, 1.03407e-13, 1.38778e-17, -8.67362e-18, -1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
r_panda_coll0(r_panda_link0): { pose: [-0.04, 8.88178e-18, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll1(r_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, -5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll3(r_panda_joint3): { pose: [1.38778e-17, 1.9082e-17, -0.15, 1, 8.67362e-18, 0, 5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll5(r_panda_joint5): { pose: [1.38778e-16, 0.02, -0.2, 1, -1.38778e-17, -2.42861e-17, -8.84709e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll2(r_panda_joint2): { pose: [1, -5.55112e-17, 1.11022e-16, -5.55112e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll4(r_panda_joint4): { pose: [1, -1.11022e-16, 2.77556e-17, 5.55112e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll6(r_panda_joint6): { pose: [3.96818e-17, -8.67362e-17, -0.04, 1, 6.93889e-17, -4.16334e-17, 1.38778e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll7(r_panda_joint7): { pose: [1.12757e-17, 1.30104e-17, 0.01, 1, 5.55112e-17, -1.38778e-17, -2.11311e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
r_gripper(r_panda_joint7): { pose: [0, -2.77556e-17, 0.2105, 4.16334e-17, -0.92388, -0.382683, -7.89299e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
r_palm(r_panda_hand_joint): { pose: [0.707107, 0.707107, 0, 0], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
r_finger1(r_panda_finger_joint1): { pose: [-9.54098e-18, 0.008, 0.045, 1, 0, 0, 6.93889e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
r_finger2(r_panda_finger_joint2): { pose: [-4.51028e-17, -0.008, 0.045, 1, 0, 0, 6.93889e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
trayR(table_base): { pose: [0.1, 0.4, 0], shape: ssBox, size: [0.15, 0.07, 0.01, 0.005], color: [0.6, 0, 0], logical: { is_box: True, is_place: True } }
trayG(table_base): { pose: [0.7, 0.1, 0], shape: ssBox, size: [0.07, 0.07, 0.01, 0.005], color: [0, 0.6, 0], logical: { is_box: True, is_place: True } }
trayB(table_base): { pose: [-0.6, 0.3, 0], shape: ssBox, size: [0.07, 0.07, 0.01, 0.005], color: [0, 0, 0.6], logical: { is_box: True, is_place: True } }
objR(table): { pose: [-0.8, 0.1, 0.1], joint: rigid, shape: ssBox, size: [0.06, 0.06, 0.1, 0.005], color: [0.7, 0, 0], contact: 1, logical: { is_object: True } }
objG(table): { pose: [0.665, 0.065, 0.105, 0.968544, 0, 0, -0.248844], joint: rigid, shape: ssBox, size: [0.06, 0.06, 0.1, 0.005], color: [0, 0.7, 0], contact: 1, logical: { is_object: True } }
objB(trayG): { pose: [-1.26528, 0.165254, 0.055, 0.93762, 0, 0, 0.347663], joint: rigid, shape: ssBox, size: [0.06, 0.06, 0.1, 0.005], color: [0, 0, 0.7], contact: 1, logical: { is_object: True } }