world: {  }
table_base(world): { pose: [0, 0, 0.6], shape: marker, size: [0.05] }
table(table_base): { pose: [0, 0, -0.05], shape: ssBox, size: [2, 1.5, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_box: True, is_place: True }, friction: 0.1 }
l_panda_base(table): { pose: [-0.4, -0.2, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.969494, -0, 0, -0.245115], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 5.55112e-17, -5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.952247, 2.77556e-17, 0, 0.30533], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-5.55112e-17, -0.316, -6.08927e-17, 0.707107, 0.707107, -1.11022e-16, 1.94289e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [9.42103e-17, -4.09903e-17, 3.40272e-16, 0.997153, -2.77556e-17, 0, -0.075407], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -1.61329e-16, -1.17961e-16, 0.707107, 0.707107, 4.85723e-17, -1.52656e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [4.07041e-17, 2.51045e-17, 3.40374e-17, 0.590558, -5.55112e-17, -1.38778e-16, -0.806995], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -2.08167e-17, 0.707107, -0.707107, -5.89806e-17, 1.66533e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-7.26475e-17, -3.55279e-17, 5.89486e-17, 0.923606, -7.97973e-17, -6.85216e-17, -0.383343], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, -1.11022e-16, -1.94289e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.220215, 0, 8.32667e-17, 0.975451], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -1.58077e-16, 1.30863e-16, 0.707107, 0.707107, 1.80411e-16, 1.38778e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-5.49113e-17, -4.61714e-17, 1.0224e-16, 0.983508, -8.32667e-17, -2.77556e-17, -0.180866], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-4.85723e-17, 8.32667e-17, 0.107, 1, -1.38778e-17, 5.55112e-17, 7.63278e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-3.45032e-17, 1.08629e-16, -5.72456e-16, 1, -1.38778e-17, 0, -1.59595e-16] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -7.63278e-17, -3.46945e-18, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 2.08167e-17, -3.64292e-17, -9.54098e-17], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-1.38778e-16, 1.73472e-17, 0.0584, 1, -6.93889e-18, 1.38778e-17, -3.81639e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-1.38778e-16, 1.73472e-17, 0.0584, 1, -6.93889e-18, 1.38778e-17, -3.81639e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [6.07153e-18, 0.04, -4.0766e-16, 1, 0, 1.21431e-17, -1.04083e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [8.10983e-17, -0.04, 1.29237e-16, 1, 0, 1.21431e-17, -1.04083e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.1452e-17, 3.96569e-18, 6.76143e-18, 1.03414e-13, 5.55112e-17, 2.08167e-17, -1], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 8.88178e-18, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, -5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [8.32667e-17, -1.73472e-18, -0.15, 1, 2.77556e-17, 1.38778e-17, -5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [6.93889e-18, 0.02, -0.2, 1, -6.245e-17, 2.60209e-17, -2.48065e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 4.16334e-17, 0, 5.55112e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-2.56229e-17, 2.41528e-17, 4.30539e-17, 1, 5.55112e-17, 4.85723e-17, 1.11022e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [7.45931e-17, -4.16334e-17, -0.04, 1, 2.77556e-17, 0, 0], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-3.90313e-17, 2.08167e-17, 0.01, 1, -1.38778e-17, 5.55112e-17, 7.63278e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-1.31839e-16, 1.80411e-16, 0.2105, 6.93889e-17, -0.92388, -0.382683, 1.38778e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -1.38778e-17, 0], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-1.21431e-16, 0.008, 0.045, 1, 0, -1.38778e-17, 1.9082e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-2.42861e-17, -0.008, 0.045, 1, 0, 1.21431e-17, -1.04083e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_base(table): { pose: [0.4, -0.2, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
r_panda_link0(r_panda_base): { shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
r_panda_joint1_origin(r_panda_link0): { pose: [0, 0, 0.333] }
r_panda_joint1(r_panda_joint1_origin): { pose: [0.995448, -0, 0, -0.0953077], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint2_origin(r_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
r_panda_joint2(r_panda_joint2_origin): { pose: [0.998691, -2.77556e-17, 5.55112e-17, 0.0511511], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint3_origin(r_panda_joint2): { pose: [-3.19189e-16, -0.316, 8.96457e-17, 0.707107, 0.707107, 5.55112e-17, -2.22045e-16] }
r_panda_joint3(r_panda_joint3_origin): { pose: [3.75867e-17, -4.92361e-17, 3.86037e-18, 0.964106, -3.46945e-17, 1.38778e-17, -0.265517], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint4_origin(r_panda_joint3): { pose: [0.0825, -4.73254e-17, 4.59702e-17, 0.707107, 0.707107, -5.20417e-18, 2.77556e-17] }
r_panda_joint4(r_panda_joint4_origin): { pose: [-4.71996e-17, -2.46826e-18, -3.2252e-17, 0.257823, -1.11022e-16, -1.11022e-16, -0.966192], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint5_origin(r_panda_joint4): { pose: [-0.0825, 0.384, -3.1572e-16, 0.707107, -0.707107, -8.67362e-17, 1.249e-16] }
r_panda_joint5(r_panda_joint5_origin): { pose: [-2.27086e-18, 1.47317e-16, -7.45178e-18, 0.999793, -9.02056e-17, 0, -0.0203458], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
r_panda_joint6_origin(r_panda_joint5): { pose: [5.66488e-17, 8.98867e-17, -3.29454e-17, 0.707107, 0.707107, -1.38778e-16, -4.16334e-17] }
r_panda_joint6(r_panda_joint6_origin): { pose: [0.429302, 2.77556e-17, -1.21431e-16, 0.903161], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
r_panda_joint7_origin(r_panda_joint6): { pose: [0.088, -3.46945e-17, 2.14672e-16, 0.707107, 0.707107, -1.38778e-17, 0] }
r_panda_joint7(r_panda_joint7_origin): { pose: [-1.86935e-17, 1.76049e-17, 1.05352e-17, 0.847064, -6.93889e-17, -2.77556e-17, -0.531491], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
r_panda_joint8_origin(r_panda_joint7): { pose: [3.1225e-17, -6.93889e-17, 0.107, 1, 5.55112e-17, -1.38778e-17, -3.16587e-16] }
r_panda_joint8(r_panda_joint8_origin): { pose: [-5.31804e-17, -2.29023e-16, -7.59227e-16, 1, 2.77556e-17, -5.55112e-17, 2.03613e-16] }
r_panda_hand_joint_origin(r_panda_joint8): { pose: [-6.02567e-17, 9.20201e-17, -2.04933e-17, -0.92388, 8.32667e-17, -6.93889e-17, 0.382683] }
r_panda_hand_joint(r_panda_hand_joint_origin): { pose: [1, -2.77556e-17, -2.08167e-17, 2.08167e-17], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
r_panda_finger_joint1_origin(r_panda_hand_joint): { pose: [-3.64292e-17, 0, 0.0584, 1, 0, -4.16334e-17, -1.04083e-17] }
r_panda_finger_joint2_origin(r_panda_hand_joint): { pose: [-3.64292e-17, 0, 0.0584, 1, 0, -4.16334e-17, -1.04083e-17] }
r_panda_finger_joint1(r_panda_finger_joint1_origin): { pose: [2.77556e-17, 0.04, -5.06539e-16, 1, 0, 0, -2.08167e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
r_panda_finger_joint2(r_panda_finger_joint2_origin): { pose: [-1.99276e-16, -0.04, 2.42861e-16, 1, 0, 0, -2.08167e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "r_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
r_panda_rightfinger_0(r_panda_finger_joint2): { pose: [-1.15153e-16, 7.39941e-17, 7.76206e-17, 1.03379e-13, 1.38778e-17, 2.25514e-17, -1], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
r_panda_coll0(r_panda_link0): { pose: [-0.04, 8.88178e-18, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll1(r_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll3(r_panda_joint3): { pose: [0, 3.81639e-17, -0.15, 1, -1.73472e-18, 0, 5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll5(r_panda_joint5): { pose: [2.498e-16, 0.02, -0.2, 1, 1.38778e-17, -2.42861e-17, -3.46945e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll2(r_panda_joint2): { pose: [1, -8.32667e-17, 1.11022e-16, 0], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll4(r_panda_joint4): { pose: [1, -1.11022e-16, 1.38778e-17, 1.66533e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll6(r_panda_joint6): { pose: [8.91214e-17, -1.03216e-16, -0.04, 1, 2.77556e-17, -6.93889e-17, -4.16334e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
r_panda_coll7(r_panda_joint7): { pose: [-6.50521e-18, -1.47451e-17, 0.01, 1, 5.55112e-17, -1.38778e-17, -3.16587e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
r_gripper(r_panda_joint7): { pose: [-9.02056e-17, -4.16334e-17, 0.2105, 8.32667e-17, -0.92388, -0.382683, -8.2833e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
r_palm(r_panda_hand_joint): { pose: [0.707107, 0.707107, -2.77556e-17, 1.38778e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
r_finger1(r_panda_finger_joint1): { pose: [4.51028e-17, 0.008, 0.045, 1, 0, 6.93889e-18, 6.93889e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
r_finger2(r_panda_finger_joint2): { pose: [6.1149e-17, -0.008, 0.045, 1, 0, 6.93889e-18, 6.93889e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
trayR(table_base): { pose: [0.1, 0.4, 0], shape: ssBox, size: [0.15, 0.07, 0.01, 0.005], color: [0.6, 0, 0], logical: { is_box: True, is_place: True } }
trayG(table_base): { pose: [0.7, 0.1, 0], shape: ssBox, size: [0.07, 0.07, 0.01, 0.005], color: [0, 0.6, 0], logical: { is_box: True, is_place: True } }
trayB(table_base): { pose: [-0.6, 0.3, 0], shape: ssBox, size: [0.07, 0.07, 0.01, 0.005], color: [0, 0, 0.6], logical: { is_box: True, is_place: True } }
objR(table): { pose: [0.0256745, 0.365444, 0.105, 0.98034, 0, 0, -0.197316], joint: rigid, shape: ssBox, size: [0.06, 0.06, 0.1, 0.005], color: [0.7, 0, 0], contact: 1, logical: { is_object: True } }
objG(table): { pose: [0.665, 0.065, 0.105, 0.968544, 0, 0, -0.248844], joint: rigid, shape: ssBox, size: [0.06, 0.06, 0.1, 0.005], color: [0, 0.7, 0], contact: 1, logical: { is_object: True } }
objB(trayG): { pose: [-1.26528, 0.165254, 0.055, 0.93762, 0, 0, 0.347663], joint: rigid, shape: ssBox, size: [0.06, 0.06, 0.1, 0.005], color: [0, 0, 0.7], contact: 1, logical: { is_object: True } }