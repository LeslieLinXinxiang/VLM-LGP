world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.999943, -0, 0, -0.0106909], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -5.55112e-17, -1.66533e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.991704, 5.55112e-17, -5.55112e-17, 0.128544], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-5.41234e-16, -0.316, -5.56992e-16, 0.707107, 0.707107, 0, 5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-2.39927e-16, 2.01705e-16, -5.22528e-16, 0.998681, 6.93889e-17, 5.55112e-17, 0.0513351], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.06396e-16, 1.73472e-17, 0.707107, 0.707107, -1.38778e-16, 1.11022e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-1.3518e-16, -3.52794e-17, 6.48398e-18, 0.521621, 0, -1.66533e-16, -0.853178], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 6.4098e-16, 0.707107, -0.707107, -2.77556e-17, 2.77556e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.2853e-17, 1.75047e-16, -7.50222e-18, 0.982258, 1.38778e-16, -8.32667e-17, -0.187532], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [8.12222e-18, 2.78591e-17, -1.90159e-17, 0.707107, 0.707107, -2.77556e-17, 4.85723e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [2.75739e-18, -5.2335e-19, 6.34596e-18, 0.438764, 0, 8.32667e-17, 0.898603], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.22659e-16, 5.63785e-16, 0.707107, 0.707107, -2.15106e-16, 1.17961e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.56906e-16, 6.9041e-17, 4.28983e-17, 0.972326, -6.93889e-18, -4.85723e-17, -0.233627], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-2.04697e-16, 5.55112e-17, 0.107, 1, 2.77556e-17, 1.04083e-17, 5.37764e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-2.83445e-17, 7.15461e-17, -2.51542e-15, 1, 6.93889e-18, 1.73472e-17, 1.11022e-16] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [7.69604e-17, 2.06525e-18, -1.53558e-17, 0.92388, -3.03577e-17, -4.77049e-18, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1.28377e-17, 5.55994e-17, -4.24087e-18, 1, 6.93889e-18, -1.47113e-17, 3.85976e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-7.80626e-17, -2.25514e-17, 0.0584, 1, 6.93889e-18, 1.28478e-17, 2.4503e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-7.80626e-17, -2.25514e-17, 0.0584, 1, 6.93889e-18, 1.28478e-17, 2.4503e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [5.14725e-17, 0.04, -1.35645e-15, 1, 8.67362e-19, 1.27089e-17, 8.45678e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-6.11761e-17, -0.04, 4.3753e-16, 1, -1.73472e-18, 1.27089e-17, -9.75782e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.34041e-17, -1.63436e-19, 6.4837e-18, -1.03423e-13, 0, -3.14419e-18, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 8.8818e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.38778e-16, 1.58294e-16, -0.15, 1, 6.93889e-17, -4.85723e-17, -1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [7.35523e-16, 0.02, -0.2, 1, -1.94289e-16, -1.66533e-16, -2.77556e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -8.32667e-17, -5.55112e-17, 5.55112e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, 2.77556e-17, 1.94289e-16, -1.38778e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.07299e-16, -1.04083e-16, -0.04, 1, 1.66533e-16, -2.77556e-16, 0], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-2.73219e-17, 6.07153e-18, 0.01, 1, 2.77556e-17, 1.04083e-17, 5.37764e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-3.81639e-16, 9.02056e-17, 0.2105, -6.93889e-18, 0.92388, 0.382683, 6.93889e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -1.25767e-17, 1.38778e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-5.89806e-17, 0.008, 0.045, 1, 6.93889e-18, 1.2675e-17, 3.06829e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.26635e-16, -0.008, 0.045, 1, 5.20417e-18, 1.27699e-17, 2.29851e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-0.0137686, 0.28, 0.07, 1, 0, 0, -0.000233485], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [0, 0, 0.05, 1, 0, -0, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True, is_place: True } }
base2(table): { pose: [-0.00742163, 0.280014, 0.210038, 1, -1.96489e-05, -3.20198e-05, -3.39258e-05], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base2_handle(base2): { pose: [2.27428e-19, -8.91841e-18, 0.05, 1, 0, 3.29218e-21, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
base3(table): { pose: [0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
base3_handle(base3): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [0.166303, 0.409916, 0.14, 0.837607, 0, 0, 0.546273], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [-0.193708, 0.410084, 0.14, 0.949474, 0, 0, 0.313846], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.208193, 0.150091, 0.14, 0.886195, 0, 0, 0.463313], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [0.206158, 0.149895, 0.14, 0.995592, 0, 0, 0.093793], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [0.6, 0, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
place_base1(table): { pose: [0, 0.3, 0.05], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base1(base1): { pose: [0.2, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base1(base1): { pose: [-0.2, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base1(base1): { pose: [-0.2, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base1(base1): { pose: [0.2, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base2(base2): { pose: [0.2, 4.51164e-17, 0.02, 1, 0, 3.29218e-21, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }