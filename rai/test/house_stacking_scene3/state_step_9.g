world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 2, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.995942, -0, 0, 0.0899932], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.954763, 5.55112e-17, -5.55112e-17, 0.297369], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-6.66134e-16, -0.316, -7.46953e-16, 0.707107, 0.707107, -3.88578e-16, 0] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-8.74208e-17, 1.24845e-16, -3.30058e-16, 0.999758, -8.32667e-17, 2.77556e-17, 0.0220126], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -5.58581e-16, 6.93889e-18, 0.707107, 0.707107, -2.08167e-16, -1.11022e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-8.86783e-17, -6.09699e-17, 4.74988e-18, 0.767625, -4.16334e-17, 8.67362e-17, -0.640899], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 1.43548e-16, 0.707107, -0.707107, -3.60822e-16, 3.33067e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.70695e-17, 9.32175e-17, -3.21553e-17, 0.999825, -1.11022e-16, -5.55112e-17, -0.0187055], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [1.35708e-17, 9.37908e-17, -3.21553e-17, 0.707107, 0.707107, 3.33067e-16, 4.12864e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.551281, 5.55112e-17, 2.77556e-17, 0.83432], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -8.34402e-16, 9.04411e-16, 0.707107, 0.707107, -1.1666e-16, -3.88144e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.5255e-16, 8.60577e-17, -2.16055e-16, 0.995106, 2.88398e-17, 1.30104e-17, 0.0988106], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-2.38524e-16, 2.30285e-16, 0.107, 1, -4.87891e-17, -1.1666e-16, -2.46229e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-2.30357e-16, 9.32088e-17, -3.32602e-15, 1, 6.31006e-17, -4.22839e-17, -1.3626e-16] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-2.80571e-18, 8.32117e-17, 1.13654e-18, 0.92388, -5.37764e-17, 5.81132e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [-1.16331e-16, -4.32071e-17, 2.77681e-18, 1, 8.41341e-17, 3.33934e-17, 5.99632e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-3.1984e-16, 2.35814e-18, 0.0584, 1, 0, -4.29344e-17, 4.67562e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-3.1984e-16, 2.35814e-18, 0.0584, 1, 0, -4.29344e-17, 4.67562e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-4.60464e-17, 0.04, -2.08411e-15, 1, -8.67362e-19, 1.38778e-17, 4.48589e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [3.61035e-17, -0.04, 1.64013e-15, 1, 0, -1.25767e-17, 4.38424e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-3.59797e-16, 2.63115e-16, 1.18065e-16, -1.03528e-13, -2.94903e-17, -4.16334e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.4211e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [6.93889e-17, 2.60209e-16, -0.15, 1, -8.32667e-17, 5.55112e-17, -1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.27676e-15, 0.02, -0.2, 1, -8.32667e-17, -5.55112e-17, 3.60822e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 4.44089e-16, 0, -2.77556e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-4.5874e-19, 1.42815e-18, -6.77482e-18, 1, -1.45717e-16, -2.35922e-16, 3.26128e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.63912e-16, -3.47433e-16, -0.04, 1, 0, -2.77556e-17, -5.55112e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-3.63208e-18, -3.71339e-18, 0.01, 1, -4.87891e-17, -1.1666e-16, -2.46229e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-9.28944e-16, 7.87564e-16, 0.2105, -2.30935e-17, -0.92388, -0.382683, -5.55112e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [-3.7891e-17, -4.05554e-17, 1.00956e-18, -0.707107, -0.707107, 2.77556e-17, -7.97973e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.84278e-16, 0.008, 0.045, 1, 8.67362e-19, 4.33681e-17, 1.15739e-16], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-5.69423e-16, -0.008, 0.045, 1, 4.42354e-17, 5.63785e-17, 1.15163e-16], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [0.0013581, 0.298731, 0.0708115, 0.999998, 0.000723808, 0.001068, 0.00145147], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base1_handle(base1): { pose: [-2.1684e-19, -1.58836e-17, 0.05, 1, -1.08844e-19, -2.60886e-19, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True } }
roof1(table): { pose: [-0.000350725, 0.299542, 0.203474, 1, -9.68868e-05, -0.000553402, -0.000243471], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
roof1_handle(roof1): { pose: [-1.28749e-19, 1.03457e-17, 0.05, 1, 0, 4.02175e-20, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
roof2(table): { pose: [0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
roof2_handle(roof2): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [-0.15, 0.2, 0.140023, 1, 1.15843e-06, 1.17944e-06, -1.37744e-07], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl2(table): { pose: [0.150011, 0.200018, 0.140043, 1, -1.2394e-05, 7.06248e-06, -3.18578e-06], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl3(table): { pose: [-0.149998, 0.4, 0.140067, 1, 1.9603e-06, 5.49871e-06, -1.01273e-06], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl4(table): { pose: [0.150003, 0.39999, 0.140098, 1, 5.59128e-06, -1.84016e-06, -4.67801e-06], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl5(table): { pose: [-0.150121, 0.20001, 0.271105, 1, -0.000104611, -7.79162e-06, -5.59418e-06], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl6(table): { pose: [0.150027, 0.200035, 0.271039, 1, -6.47275e-05, 4.05895e-05, -2.89611e-07], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
cyl7(table): { pose: [-0.14993, 0.399177, 0.271042, 1, 0.000223529, -4.52546e-06, -1.06453e-05], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True } }
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