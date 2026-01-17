world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 2, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.993391, -0, 0, -0.11478], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -5.55112e-17, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.984134, -5.55112e-17, 5.55112e-17, 0.177427], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-6.93889e-17, -0.316, -3.77159e-17, 0.707107, 0.707107, -1.11022e-16, -5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-5.73179e-17, 1.77433e-17, -2.13617e-17, 0.993313, 6.93889e-17, 5.55112e-17, -0.115455], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.90566e-17, -7.97973e-17, 0.707107, 0.707107, -3.46945e-17, 2.77556e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-1.45908e-17, -5.27135e-18, -2.51401e-19, 0.512317, -1.11022e-16, 5.55112e-17, -0.858796], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 6.93889e-17, 0.707107, -0.707107, 1.8735e-16, -8.32667e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [6.5117e-17, 1.37692e-16, -7.28323e-17, 0.997909, -8.32667e-17, 5.55112e-17, 0.06463], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-1.76188e-17, 1.43615e-17, 1.59279e-17, 0.707107, 0.707107, -2.77556e-17, 5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [-1.76188e-17, 1.59279e-17, -1.43615e-17, 0.457832, -5.55112e-17, -6.93889e-17, 0.889039], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 4.51028e-17, 1.07743e-17, 0.707107, 0.707107, -7.63278e-17, -1.66533e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.31989e-17, 1.43615e-17, 5.09214e-18, 0.93424, 8.32667e-17, 9.71445e-17, -0.356646], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [3.46945e-18, 1.04083e-17, 0.107, 1, 0, 0, -7.37257e-18] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-1.37202e-17, -1.48609e-18, -2.25065e-16, 1, 0, 0, -7.37257e-18] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-0.92388, 1.38778e-17, 1.38778e-17, 0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -1.38778e-17, 6.93889e-18, -4.72712e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-6.61363e-18, -3.46945e-18, 0.0584, 1, 0, 0, 9.1073e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-6.61363e-18, -3.46945e-18, 0.0584, 1, 0, 0, 9.1073e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-5.19062e-17, 0.04, -1.5786e-16, 1, 0, 0, 9.1073e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-1.88448e-17, -0.04, -6.93889e-17, 1, 0, 0, 9.1073e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.22502e-17, 3.94952e-17, 1.05078e-16, 1.03397e-13, 0, -3.46945e-18, -1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 4.62223e-33, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [0, 6.93889e-18, -0.15, 1, -1.38778e-17, -1.38778e-17, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [8.32667e-17, 0.02, -0.2, 1, -2.77556e-17, 0, -2.08167e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 2.77556e-17, -5.55112e-17, -5.55112e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -5.55112e-17, 3.46945e-17, -1.66533e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [3.49113e-17, 2.89211e-17, -0.04, 1, 0, 0, -1.11022e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-1.21431e-17, 1.95156e-17, 0.01, 1, 0, 0, -7.37257e-18], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-3.46945e-17, -6.93889e-18, 0.2105, -1.38778e-17, -0.92388, -0.382683, -5.37764e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, 3.1225e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.19804e-17, 0.008, 0.045, 1, 0, 0, 9.1073e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-2.17383e-17, -0.008, 0.045, 1, 0, 0, 9.1073e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
trayR(table): { pose: [0.1, 0.4, 0.05], shape: ssBox, size: [0.15, 0.07, 0.01, 0.005], color: [0.6, 0, 0], logical: { is_box: True, is_place: True } }
trayG(table): { pose: [0.4, 0.1, 0], shape: ssBox, size: [0.07, 0.07, 0.01, 0.005], color: [0, 0.6, 0], logical: { is_box: True, is_place: True } }
trayB(table): { pose: [-0.3, 0.3, 0], shape: ssBox, size: [0.07, 0.07, 0.01, 0.005], color: [0, 0, 0.6], logical: { is_box: True, is_place: True } }
objR(table): { pose: [0.225, 0.225, 0.15, 0.948193, 0, 0, -0.317696], joint: rigid, shape: ssBox, size: [0.06, 0.06, 0.1, 0.005], color: [0.7, 0, 0], contact: 1, logical: { is_object: True } }
placeR(table): { pose: [0.3, 0.3, 0.1], shape: quad, size: [0.15, 0.15], color: [0.5, 0.5, 0.5], logical: { is_place: True } }