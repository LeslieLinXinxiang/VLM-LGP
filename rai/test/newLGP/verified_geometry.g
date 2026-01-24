world: {  }
table_base(world): { pose: [0, 0, 0.6], shape: marker, size: [0.05] }
table(table_base): { pose: [0, 0, -0.05], shape: ssBox, size: [2, 1.5, 0.1, 0.02], color: [0.3, 0.3, 0.3], logical: { is_box: True, is_place: True }, friction: 0.1 }
l_panda_base(table): { pose: [-0.4, -0.2, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.984329, -0, 0, -0.176344], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -5.55112e-17, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.93715, -1.11022e-16, 5.55112e-17, 0.348926], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-1.38778e-16, -0.316, -9.93235e-17, 0.707107, 0.707107, 0, -8.32667e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [2.4614e-17, 1.20445e-17, 2.12787e-17, 0.990444, -1.38778e-17, 6.93889e-17, -0.137912], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -1.9082e-17, -6.93889e-18, 0.707107, 0.707107, -1.249e-16, -1.38778e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [8.15492e-18, 8.5115e-18, -7.32425e-18, 0.680351, 0, 5.55112e-17, -0.732886], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -6.245e-17, 0.707107, -0.707107, -6.50521e-17, -6.93889e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.36943e-16, 5.9682e-17, 5.03843e-18, 0.99989, -8.32667e-17, 2.77556e-17, 0.0148468], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-4.00694e-18, -1.141e-17, 6.80807e-18, 0.707107, 0.707107, -2.77556e-17, 5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.424683, -2.77556e-17, -7.28584e-17, 0.905342], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -1.43982e-16, 1.96241e-17, 0.707107, 0.707107, 9.54098e-18, -4.85723e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.50892e-16, 1.00029e-16, -8.59854e-17, 0.836309, -5.89806e-17, -3.46945e-17, -0.548259], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-3.1225e-17, 1.28478e-17, 0.107, 1, -6.93889e-18, 0, -9.49761e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-3.19903e-17, -2.95515e-17, -6.70622e-16, 1, 0, 0, -3.9465e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-4.60939e-17, -2.9851e-17, 8.10917e-18, 0.92388, 6.93889e-18, -6.93889e-18, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, -3.46945e-18, 1.82146e-17], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-1.21431e-17, -1.73472e-18, 0.0584, 1, 0, -4.33681e-18, 4.33681e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-1.21431e-17, -1.73472e-18, 0.0584, 1, 0, -4.33681e-18, 4.33681e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-2.51535e-17, 0.04, -3.00975e-16, 1, 0, 2.60209e-18, 3.90313e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [2.51535e-17, -0.04, 3.00975e-16, 1, -0, -2.60209e-18, -3.90313e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.35783e-17, 5.37877e-18, 2.22448e-18, -1.03432e-13, 0, -3.46945e-18, 1], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, -8.88178e-18, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1] }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1] }
l_panda_coll3(l_panda_joint3): { pose: [4.16334e-17, 1.04083e-17, -0.15, 1, -4.16334e-17, -2.77556e-17, -1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1] }
l_panda_coll5(l_panda_joint5): { pose: [1.80411e-16, 0.02, -0.2, 1, 2.77556e-17, -7.63278e-17, -2.08167e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1] }
l_panda_coll2(l_panda_joint2): { pose: [1, 1.249e-16, 5.55112e-17, -5.55112e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1] }
l_panda_coll4(l_panda_joint4): { pose: [4.54673e-18, -3.75024e-18, 3.66213e-18, 1, 5.55112e-17, -6.245e-17, 0], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1] }
l_panda_coll6(l_panda_joint6): { pose: [3.24176e-17, 1.21431e-17, -0.04, 1, 2.77556e-17, 2.77556e-17, -2.77556e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1] }
l_panda_coll7(l_panda_joint7): { pose: [-2.01662e-17, -1.56616e-17, 0.01, 1, -6.93889e-18, 0, -9.49761e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1] }
l_gripper(l_panda_joint7): { pose: [-6.93889e-18, 7.77915e-17, 0.2105, 3.1225e-17, 0.92388, 0.382683, 4.85723e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, 0], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1] }
l_finger1(l_panda_finger_joint1): { pose: [2.34188e-17, 0.008, 0.045, 1, 0, 2.60209e-18, 3.90313e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1] }
l_finger2(l_panda_finger_joint2): { pose: [-1.56125e-17, -0.008, 0.045, 1, 0, 2.60209e-18, 3.90313e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1] }
r_panda_base(table): { pose: [0.4, -0.2, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
r_panda_link0(r_panda_base): { shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
r_panda_joint1_origin(r_panda_link0): { pose: [0, 0, 0.333] }
r_panda_joint1(r_panda_joint1_origin): { pose: [0.999985, -0, 0, 0.00555204], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint2_origin(r_panda_joint1): { pose: [0.707107, -0.707107, -5.55112e-17, 0] }
r_panda_joint2(r_panda_joint2_origin): { pose: [0.969319, -2.77556e-17, -2.77556e-17, -0.245807], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint3_origin(r_panda_joint2): { pose: [-1.38778e-16, -0.316, 5.16747e-17, 0.707107, 0.707107, -1.11022e-16, 5.55112e-17] }
r_panda_joint3(r_panda_joint3_origin): { pose: [-4.88001e-17, 6.16391e-19, 2.64511e-17, 0.999995, -6.93889e-17, -2.77556e-17, -0.00318722], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint4_origin(r_panda_joint3): { pose: [0.0825, -6.55807e-17, -8.32667e-17, 0.707107, 0.707107, -2.77556e-17, 0] }
r_panda_joint4(r_panda_joint4_origin): { pose: [-4.8803e-17, 2.64511e-17, -3.05307e-19, 0.537319, 9.88792e-17, 9.71445e-17, -0.843379], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
r_panda_joint5_origin(r_panda_joint4): { pose: [-0.0825, 0.384, -1.51843e-16, 0.707107, -0.707107, 1.73472e-17, -1.66533e-16] }
r_panda_joint5(r_panda_joint5_origin): { pose: [2.24802e-16, -5.64898e-17, 4.17091e-17, 0.999992, -5.55112e-17, 5.55112e-17, -0.00394348], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
r_panda_joint6_origin(r_panda_joint5): { pose: [0.707107, 0.707107, 5.20417e-17, 5.20417e-18] }
r_panda_joint6(r_panda_joint6_origin): { pose: [0.54247, 1.66533e-16, -4.68375e-17, 0.840075], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
r_panda_joint7_origin(r_panda_joint6): { pose: [0.088, -2.77556e-17, -2.27682e-17, 0.707107, 0.707107, 1.38778e-17, -3.46945e-17] }
r_panda_joint7(r_panda_joint7_origin): { pose: [-4.91221e-17, -2.78873e-19, -2.5854e-17, 0.969308, -8.32667e-17, 5.55112e-17, -0.24585], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
r_panda_joint8_origin(r_panda_joint7): { pose: [3.46945e-17, 1.73472e-17, 0.107, 1, -5.55112e-17, 2.77556e-17, 1.07553e-16] }
r_panda_joint8(r_panda_joint8_origin): { pose: [-9.61353e-19, 6.3367e-17, -2.35165e-16, 1, 0, 0, 4.85723e-17] }
r_panda_hand_joint_origin(r_panda_joint8): { pose: [0.92388, 0, -1.38778e-17, -0.382683] }
r_panda_hand_joint(r_panda_hand_joint_origin): { pose: [1, 0, -6.93889e-18, 1.43982e-16], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
r_panda_finger_joint1_origin(r_panda_hand_joint): { pose: [-1.64799e-17, -6.93889e-18, 0.0584, 1, 0, 0, -1.73472e-18] }
r_panda_finger_joint2_origin(r_panda_hand_joint): { pose: [-1.64799e-17, -6.93889e-18, 0.0584, 1, 0, 0, -1.73472e-18] }
r_panda_finger_joint1(r_panda_finger_joint1_origin): { pose: [1.64799e-17, 0.04, -3.26128e-16, 1, 0, 0, -1.73472e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
r_panda_finger_joint2(r_panda_finger_joint2_origin): { pose: [-1.64799e-17, -0.04, 3.26128e-16, 1, -0, -0, 1.73472e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "r_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
r_panda_rightfinger_0(r_panda_finger_joint2): { pose: [2.84031e-17, 9.94398e-17, -1.96491e-16, -1.03403e-13, 0, 1.04083e-17, 1], shape: mesh, mesh: <../../../rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
r_panda_coll0(r_panda_link0): { pose: [-0.04, -8.88178e-18, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1] }
r_panda_coll1(r_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1] }
r_panda_coll3(r_panda_joint3): { pose: [5.55112e-17, -3.04661e-17, -0.15, 1, 1.38778e-17, -2.77556e-17, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1] }
r_panda_coll5(r_panda_joint5): { pose: [1.64799e-16, 0.02, -0.2, 1, 0, 0, 1.66533e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1] }
r_panda_coll2(r_panda_joint2): { pose: [1, -8.32667e-17, -2.77556e-17, -5.55112e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1] }
r_panda_coll4(r_panda_joint4): { pose: [1, -4.16334e-17, -7.36173e-17, -1.00614e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1] }
r_panda_coll6(r_panda_joint6): { pose: [5.55654e-17, 7.65176e-17, -0.04, 1, 2.77556e-17, 5.55112e-17, 2.77556e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1] }
r_panda_coll7(r_panda_joint7): { pose: [5.1608e-17, 2.1684e-18, 0.01, 1, -5.55112e-17, 2.77556e-17, 1.07553e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1] }
r_gripper(r_panda_joint7): { pose: [0, -4.85723e-17, 0.2105, 8.32667e-17, 0.92388, 0.382683, 4.16334e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
r_palm(r_panda_hand_joint): { pose: [0.707107, 0.707107, 0, -1.38778e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1] }
r_finger1(r_panda_finger_joint1): { pose: [1.17094e-16, 0.008, 0.045, 1, 0, 0, -1.73472e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1] }
r_finger2(r_panda_finger_joint2): { pose: [9.54098e-18, -0.008, 0.045, 1, 0, 0, -1.73472e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1] }
trayR(table_base): { pose: [0.1, 0.4, 0], shape: ssBox, size: [0.15, 0.07, 0.01, 0.005], color: [0.6, 0, 0], logical: { is_box: True, is_place: True } }
trayG(table_base): { pose: [0.7, 0.1, 0], shape: ssBox, size: [0.07, 0.07, 0.01, 0.005], color: [0, 0.6, 0], logical: { is_box: True, is_place: True } }
trayB(table_base): { pose: [-0.6, 0.3, 0], shape: ssBox, size: [0.07, 0.07, 0.01, 0.005], color: [0, 0, 0.6], logical: { is_box: True, is_place: True } }
objR(placePose_trayR_objR_2): { pose: [0.0250595, 0.365063, 0.655, 0.984996, 0, 0, -0.172578], joint: rigid, shape: ssBox, size: [0.06, 0.06, 0.1, 0.005], color: [0.7, 0, 0], logical: { is_object: True } }
objG(table): { pose: [-0.6, 0.2, 0.1], joint: rigid, shape: ssBox, size: [0.06, 0.06, 0.1, 0.005], color: [0, 0.7, 0], logical: { is_object: True } }
objB(trayG): { pose: [0, 0, 0.055], joint: rigid, shape: ssBox, size: [0.06, 0.06, 0.1, 0.005], color: [0, 0, 0.7], logical: { is_object: True } }
pickPose_l_gripper_objR_1(l_gripper): { pose: [0.0317176, -0.0216898, -0.0469782, -0.657443, -0.0863954, -0.0049217, 0.748519], joint: rigid, shape: marker, size: [0.01] }
placePose_trayR_objR_2(placePose_trayR_objR_2_origin): { pose: [0.0250595, 0.365063, 0.655, 0.984996, 0, 0, -0.172578], joint: transXYPhi, shape: marker, size: [0.01] }
placePose_trayR_objR_2_origin(trayR): { pose: [0, 0, 0.055] }