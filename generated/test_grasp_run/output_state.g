world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, -0, 0, 5.58809e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 5.55112e-17, -5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731842, -4.16334e-17, 8.84709e-17, -0.681474], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [4.51028e-17, -0.316, 5.85657e-17, 0.707107, 0.707107, -2.60209e-17, 1.11022e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [8.80915e-23, 1.10724e-17, -1.23433e-21, 1, -8.32667e-17, -5.55112e-17, -0.000248625], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -1.16586e-16, -1.38778e-16, 0.707107, 0.707107, 5.55112e-17, -1.11022e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.29344e-16, 9.49433e-17, 8.35988e-17, 0.315362, 3.38271e-17, -8.32667e-17, -0.948972], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -2.22261e-16, 0.707107, -0.707107, 0, 5.55112e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [4.03676e-16, -1.66975e-16, -1.93049e-16, 1, 0, 1.66533e-16, 0.000139858], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, 0, -2.77556e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.73164, -1.11022e-16, 9.71445e-17, 0.681691], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -1.31839e-16, 6.14743e-17, 0.707107, 0.707107, 1.38778e-17, 1.66533e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.94865e-16, 1.42929e-16, -1.06517e-16, 1, -5.55112e-17, -4.16334e-17, -0.000141725], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [7.63278e-17, -5.96989e-17, 0.107, 1, -1.38778e-17, 0, 1.42247e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [8.45804e-17, 5.97302e-17, -9.65808e-16, 1, -1.38778e-17, -2.77556e-17, -2.77556e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [3.59224e-24, -2.7105e-20, 2.03543e-23, 0.92388, -5.55112e-17, 2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, -1.38778e-17, -2.42861e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [3.81639e-17, 1.38778e-17, 0.0584, 1, 0, 0, -2.08167e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [3.81639e-17, 1.38778e-17, 0.0584, 1, 0, 0, -2.08167e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [3.29597e-17, 0.04, -5.11743e-16, 1, 0, 0, -2.08167e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-2.86229e-17, -0.04, 4.33681e-17, 1, 0, 0, -2.08167e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-6.87418e-17, 3.42769e-17, -1.33559e-17, -1.03386e-13, 0, 2.08167e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.77636e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, -1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-4.85723e-17, -1.56564e-16, -0.15, 1, -5.55112e-17, 2.77556e-17, 1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [8.32667e-17, 0.02, -0.2, 1, 0, 5.55112e-17, 0], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 5.55112e-17, -1.98409e-17, -4.16334e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 2.77556e-17, -3.46945e-17, -5.55112e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [8.18234e-17, 3.93599e-17, -0.04, 1, -2.77556e-17, -5.55112e-17, 8.32667e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-2.51535e-17, -1.02254e-17, 0.01, 1, -1.38778e-17, 0, 1.42247e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.94289e-16, -1.08068e-16, 0.2105, 8.32667e-17, 0.92388, 0.382683, 1.38778e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 5.55112e-17, -6.93889e-18], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.49186e-16, 0.008, 0.045, 1, 0, 0, -2.08167e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-5.55112e-17, -0.008, 0.045, 1, 0, 0, -2.08167e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
cube(table): { pose: [0, 0.15, 0.065], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 0.5, 0], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
TriPrism(table): { pose: [-0.00149506, 0.148497, 0.08, 1, 9.29257e-09, 1.54319e-08, 9.0098e-06], joint: rigid, shape: mesh, color: [1, 0.4, 0.7], mesh: "/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", contact: 1, mass: 0.2, inertia: [3.61846e-05, 3.20675e-05, 5.23466e-05], logical: { is_object: True, is_place: True } }
grasp_handle(TriPrism): { pose: [-3.26231e-20, 7.41363e-18, 0.015, 1, -1.65436e-24, -2.94024e-24, -1.69407e-21], shape: marker, size: [], logical: { is_place: True } }