world: {  }
table_base(world): { pose: [0, 0, 0.6], shape: marker, size: [0.05] }
table(table_base): { pose: [0, 0, -0.05], shape: ssBox, size: [2, 1.5, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_box: True, is_place: True }, friction: 0.1 }
l_panda_base(table): { pose: [-0.4, -0.2, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.999992, -0, 0, 0.00388656], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 5.55112e-17, -5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.968027, 2.77556e-17, 2.77556e-17, -0.250846], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-5.55112e-17, -0.316, 4.16143e-17, 0.707107, 0.707107, -5.55112e-17, -5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [9.62931e-17, -1.11882e-16, -5.34974e-17, 1, -1.249e-16, 0, 0.000566175], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -5.86858e-17, 4.16334e-17, 0.707107, 0.707107, -8.32667e-17, -5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [0.540978, 8.1532e-17, 6.245e-17, -0.841037], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -8.02716e-17, 0.707107, -0.707107, 1.56125e-17, 5.55112e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-4.40096e-18, 5.59954e-17, -5.48463e-17, 0.99999, -5.55112e-17, 0, -0.0045007], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, 6.76542e-17, 5.89806e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.545927, -5.55112e-17, 5.20417e-18, 0.837833], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.46945e-17, 3.62666e-17, -0.707107, -0.707107, -2.77556e-17, -5.55112e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [4.94803e-17, -5.50601e-17, 2.61354e-17, 0.968287, 0, -2.77556e-17, -0.249842], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [4.16334e-17, 3.46945e-17, 0.107, 1, 2.77556e-17, 1.38778e-17, -2.77556e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [2.74202e-17, -4.82655e-17, -2.52728e-19, 1, 0, 0, -3.46945e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -2.77556e-17, 4.16334e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 2.77556e-17, -1.38778e-17, -5.0307e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [4.33681e-17, 6.93889e-17, 0.0584, 1, 0, -6.93889e-18, 1.12757e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [4.33681e-17, 6.93889e-17, 0.0584, 1, 0, -6.93889e-18, 1.12757e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-2.81893e-17, 0.04, 4.16334e-17, 1, 0, -6.93889e-18, 1.21431e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-7.93636e-17, -0.04, -4.16334e-17, 1, 0, -6.93889e-18, 1.21431e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.03418e-13, 3.46945e-18, -1.38778e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, -8.88178e-18, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.38778e-17, -1.75641e-17, -0.15, 1, 2.77556e-17, -2.77556e-17, -5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [4.85723e-17, 0.02, -0.2, 1, 0, 0, 0], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 2.77556e-17, -2.77556e-17, -2.77556e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -4.16334e-17, 4.66207e-18, -3.46945e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-5.47793e-17, -8.38088e-17, -0.04, 1, -2.77556e-17, 0, 2.77556e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [1.25767e-17, 1.86483e-17, 0.01, 1, 2.77556e-17, 1.38778e-17, -2.77556e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [2.77556e-17, 2.08167e-17, 0.2105, -2.77556e-17, 0.92388, 0.382683, 8.32667e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -1.38778e-17, 1.38778e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-2.94903e-17, 0.008, 0.045, 1, 0, 0, 1.30104e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [1.73472e-17, -0.008, 0.045, 1, 0, 0, 1.30104e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_base(table): { pose: [0.4, -0.2, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
r_panda_link0(r_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
r_panda_joint1_origin(r_panda_link0): { pose: [0, 0, 0.333] }
r_panda_joint1(r_panda_joint1_origin): { pose: [0.994329, -0, 0, -0.106351], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint2_origin(r_panda_joint1): { pose: [0.707107, -0.707107, 5.55112e-17, 5.55112e-17] }
r_panda_joint2(r_panda_joint2_origin): { pose: [0.998854, 0, 0, 0.0478609], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint3_origin(r_panda_joint2): { pose: [-2.42861e-17, -0.316, 2.12586e-17, 0.707107, 0.707107, -5.55112e-17, -5.55112e-17] }
r_panda_joint3(r_panda_joint3_origin): { pose: [5.40069e-17, 1.17404e-17, 5.18748e-18, 0.965779, 8.84709e-17, 3.64292e-17, -0.259365], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint4_origin(r_panda_joint3): { pose: [0.0825, -6.12574e-18, 1.04951e-16, 0.707107, 0.707107, 8.67362e-17, 2.77556e-17] }
r_panda_joint4(r_panda_joint4_origin): { pose: [0.264657, 0, 5.55112e-17, -0.964343], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint5_origin(r_panda_joint4): { pose: [-0.0825, 0.384, -1.23165e-16, 0.707107, -0.707107, 1.38778e-17, 6.59195e-17] }
r_panda_joint5(r_panda_joint5_origin): { pose: [-6.26792e-17, 8.63848e-18, -9.35734e-17, 0.999922, 2.08167e-17, -3.46945e-18, -0.012459], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
r_panda_joint6_origin(r_panda_joint5): { pose: [0.707107, 0.707107, 2.77556e-17, -2.77556e-17] }
r_panda_joint6(r_panda_joint6_origin): { pose: [0.42464, -1.38778e-17, 2.08167e-17, 0.905362], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
r_panda_joint7_origin(r_panda_joint6): { pose: [0.088, 1.38778e-17, -1.56125e-17, 0.707107, 0.707107, 6.93889e-17, -2.77556e-17] }
r_panda_joint7(r_panda_joint7_origin): { pose: [9.33723e-18, -9.06604e-18, -4.8183e-18, 0.845356, 0, 0, -0.534203], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
r_panda_joint8_origin(r_panda_joint7): { pose: [2.77556e-17, -2.77556e-17, 0.107, 1, 0, -1.38778e-17, -1.18608e-16] }
r_panda_joint8(r_panda_joint8_origin): { pose: [-2.6675e-17, -6.79655e-17, -2.11526e-16, 1, 0, -1.38778e-17, 1.06411e-16] }
r_panda_hand_joint_origin(r_panda_joint8): { pose: [-3.42139e-17, 1.02121e-16, -3.03189e-17, -0.92388, 0, 0, 0.382683] }
r_panda_hand_joint(r_panda_hand_joint_origin): { pose: [1, 0, -2.08167e-17, 1.38778e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
r_panda_finger_joint1_origin(r_panda_hand_joint): { pose: [3.46945e-17, 3.46945e-18, 0.0584, 1, 0, -6.93889e-18, 1.04083e-17] }
r_panda_finger_joint2_origin(r_panda_hand_joint): { pose: [3.46945e-17, 3.46945e-18, 0.0584, 1, 0, -6.93889e-18, 1.04083e-17] }
r_panda_finger_joint1(r_panda_finger_joint1_origin): { pose: [3.51282e-17, 0.04, -1.2837e-16, 1, 0, -6.93889e-18, 1.04083e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
r_panda_finger_joint2(r_panda_finger_joint2_origin): { pose: [-6.28837e-18, -0.04, -8.32667e-17, 1, 0, -6.93889e-18, 1.04083e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "r_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
r_panda_rightfinger_0(r_panda_finger_joint2): { pose: [-2.70636e-18, -5.91776e-18, 2.40915e-18, 1.0339e-13, 0, 5.20417e-18, -1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
r_panda_coll0(r_panda_link0): { pose: [-0.04, -8.88178e-18, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll1(r_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll3(r_panda_joint3): { pose: [2.94903e-17, -1.04083e-17, -0.15, 1, 5.20417e-18, -3.46945e-18, 5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll5(r_panda_joint5): { pose: [9.71445e-17, 0.02, -0.2, 1, -6.93889e-18, -3.46945e-17, 0], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll2(r_panda_joint2): { pose: [1, 0, 0, 0], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll4(r_panda_joint4): { pose: [1, -1.11022e-16, 0, 5.55112e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll6(r_panda_joint6): { pose: [-2.17925e-17, 4.77049e-18, -0.04, 1, 5.55112e-17, -2.77556e-17, 1.38778e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll7(r_panda_joint7): { pose: [6.50521e-18, 6.50521e-18, 0.01, 1, 0, -1.38778e-17, -1.18608e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
r_gripper(r_panda_joint7): { pose: [-6.93889e-18, 1.38778e-17, 0.2105, -4.16334e-17, -0.92388, -0.382683, -4.41745e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
r_palm(r_panda_hand_joint): { pose: [0.707107, 0.707107, -2.77556e-17, 0], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
r_finger1(r_panda_finger_joint1): { pose: [-5.29091e-17, 0.008, 0.045, 1, 0, -6.93889e-18, 1.04083e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
r_finger2(r_panda_finger_joint2): { pose: [1.82146e-17, -0.008, 0.045, 1, 0, -6.93889e-18, 1.04083e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
trayR(table_base): { pose: [0.1, 0.4, 0], shape: ssBox, size: [0.15, 0.07, 0.01, 0.005], color: [0.6, 0, 0], logical: { is_box: True, is_place: True } }
trayG(table_base): { pose: [0.7, 0.1, 0], shape: ssBox, size: [0.07, 0.07, 0.01, 0.005], color: [0, 0.6, 0], logical: { is_box: True, is_place: True } }
trayB(table_base): { pose: [-0.6, 0.3, 0], shape: ssBox, size: [0.07, 0.07, 0.01, 0.005], color: [0, 0, 0.6], logical: { is_box: True, is_place: True } }
objR(table): { pose: [-0.8, 0.1, 0.1], joint: rigid, shape: ssBox, size: [0.06, 0.06, 0.1, 0.005], color: [0.7, 0, 0], contact: 1, logical: { is_object: True } }
objG(table): { pose: [0.665, 0.065, 0.105, 0.968544, 0, 0, -0.248844], joint: rigid, shape: ssBox, size: [0.06, 0.06, 0.1, 0.005], color: [0, 0.7, 0], contact: 1, logical: { is_object: True } }
objB(trayG): { pose: [-0.29185, 0.0414654, 0.05, 0.997711, 0, 0, 0.0676168], joint: rigid, shape: ssBox, size: [0.06, 0.06, 0.1, 0.005], color: [0, 0, 0.7], contact: 1, logical: { is_object: True } }