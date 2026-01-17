world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 2, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.986823, -0, 0, -0.161802], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -1.11022e-16, 1.11022e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.990389, 0, 0, 0.138307], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-1.66533e-16, -0.316, -5.58236e-16, 0.707107, 0.707107, 1.11022e-16, -1.66533e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-1.41027e-16, 1.01345e-16, -2.71049e-16, 0.999918, -5.55112e-17, 5.55112e-17, 0.0128287], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.35317e-16, 4.85723e-17, 0.707107, 0.707107, 1.2837e-16, 2.22045e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-5.8877e-17, -1.68395e-17, -1.00892e-17, 0.392059, 2.77556e-17, 1.38778e-16, -0.91994], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 4.87891e-16, 0.707107, -0.707107, 8.32667e-17, -2.77556e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-1.122e-17, 3.04733e-16, -1.19524e-16, 0.998316, 2.77556e-17, 0, 0.0580085], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, -1.11022e-16, 2.77556e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.253603, -1.11022e-16, 6.93889e-17, 0.967308], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -2.09902e-16, 2.28726e-16, -0.707107, -0.707107, 2.1684e-16, 8.06646e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.55812e-16, 1.19382e-16, -1.20939e-16, 0.961331, -8.50015e-17, -1.69136e-17, -0.275397], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [1.62197e-16, -3.46945e-17, 0.107, 1, -6.93889e-18, -1.17094e-17, 7.29939e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [8.38899e-18, -6.75174e-17, -2.22166e-15, 1, -1.04083e-17, -1.51788e-17, 7.31023e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-5.47845e-17, -8.72088e-18, -2.02237e-18, 0.92388, 9.54098e-18, -6.93889e-18, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 1.56125e-17, -3.16587e-17, 7.48099e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [5.20417e-18, 4.03865e-18, 0.0584, 1, -5.20417e-18, -1.77809e-17, 1.95156e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [5.20417e-18, 4.03865e-18, 0.0584, 1, -5.20417e-18, -1.77809e-17, 1.95156e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [3.47656e-17, 0.04, -1.14706e-15, 1, -1.73472e-18, -3.90313e-18, 1.96241e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-3.56686e-17, -0.04, 4.79353e-16, 1, -1.73472e-18, -3.90313e-18, 1.96241e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.34398e-16, 9.79026e-17, -9.25051e-18, -1.03461e-13, -1.04083e-17, 1.04083e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 7.10544e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 2.22045e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.31839e-16, 1.62197e-16, -0.15, 1, 0, -6.245e-17, 2.22045e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.52656e-16, 0.02, -0.2, 1, 1.66533e-16, 1.11022e-16, -5.55112e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 0, 1.11022e-16, 0], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [3.59303e-18, -1.98925e-18, -1.32562e-17, 1, 1.11022e-16, -1.38778e-17, -3.33067e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.64189e-16, -1.89519e-16, -0.04, 1, 1.11022e-16, 2.77556e-17, -5.55112e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [4.77049e-17, 2.88398e-17, 0.01, 1, -6.93889e-18, -1.17094e-17, 7.29939e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [2.41127e-16, -9.36751e-17, 0.2105, 7.28584e-17, 0.92388, 0.382683, 7.45931e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -5.55112e-17, -2.77556e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.9082e-16, 0.008, 0.045, 1, 3.46945e-18, -5.63785e-18, 1.98951e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-4.59702e-17, -0.008, 0.045, 1, 1.73472e-18, -1.25767e-17, 1.98951e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-1.44032e-06, 0.300001, 0.0700024, 1, 1.49471e-06, -3.89583e-06, -1.27597e-06], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base1_handle(base1): { pose: [1.00585e-21, -1.8313e-17, 0.05, 1, 1.05879e-21, -7.09008e-23, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True } }
roof1(table): { pose: [-0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
roof1_handle(roof1): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
roof2(table): { pose: [0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
roof2_handle(roof2): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [-0.15, 0.2, 0.140001, 1, 5.31901e-08, -9.99643e-08, -2.12811e-08], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl2(table): { pose: [0.150036, 0.200054, 0.139996, 1, -2.10832e-05, 4.83345e-05, 7.88967e-06], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl3(table): { pose: [-0.149996, 0.399984, 0.139996, 1, 1.13782e-05, 7.09569e-06, -2.80662e-07], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl4(table): { pose: [0.150034, 0.399358, 0.139994, 1, 0.000408802, 0.000157656, 0.000113662], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl5(table): { pose: [-0.5, 0, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl6(table): { pose: [0.5, 0, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl7(table): { pose: [-0.5, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl8(table): { pose: [0.5, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
base1_target(table): { pose: [0, 0.3, 0.07], logical: { is_pose: True } }
roof1_target(base1_target): { pose: [0, 0, 0.13], logical: { is_pose: True } }
roof2_target(base1_target): { pose: [0, 0, 0.27], logical: { is_pose: True } }
cyl1_target(table): { pose: [-0.15, 0.2, 0.14], logical: { is_pose: True } }
cyl2_target(table): { pose: [0.15, 0.2, 0.14], logical: { is_pose: True } }
cyl3_target(table): { pose: [-0.15, 0.4, 0.14], logical: { is_pose: True } }
cyl4_target(table): { pose: [0.15, 0.4, 0.14], logical: { is_pose: True } }
cyl5_target(table): { pose: [-0.15, 0.2, 0.27], logical: { is_pose: True } }
cyl6_target(table): { pose: [0.15, 0.2, 0.27], logical: { is_pose: True } }
cyl7_target(table): { pose: [-0.15, 0.4, 0.27], logical: { is_pose: True } }
cyl8_target(table): { pose: [0.15, 0.4, 0.27], logical: { is_pose: True } }