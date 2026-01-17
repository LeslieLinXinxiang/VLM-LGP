world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.970419, -0, 0, 0.241428], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, -5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.999548, -5.55112e-17, -2.77556e-17, -0.0300632], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-2.5327e-16, -0.316, -2.46113e-17, 0.707107, 0.707107, -2.22045e-16, 1.11022e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-1.42617e-16, 2.29709e-16, -2.1386e-16, 0.858195, 1.99493e-17, 3.1225e-17, -0.513324], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -1.03189e-16, -7.58942e-17, 0.707107, 0.707107, -3.1225e-17, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-3.84988e-17, 6.92008e-19, -7.62278e-18, 0.163909, -8.32667e-17, -1.11022e-16, -0.986475], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 1.45717e-16, 0.707107, -0.707107, -6.59195e-17, -1.52656e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [7.78459e-17, 4.28482e-16, -1.23542e-16, 0.932246, 2.77556e-17, -1.38778e-17, 0.361824], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-2.65281e-17, -6.96249e-18, 4.26095e-18, 0.707107, 0.707107, -6.93889e-17, 1.17961e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.291369, -4.51028e-17, 4.14707e-17, 0.956611], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 8.32667e-17, 1.2837e-16, 0.707107, 0.707107, -8.32667e-17, 0] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-7.02293e-18, 1.93209e-17, -3.27375e-18, 0.730178, -7.63278e-17, -5.55112e-17, -0.683257], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [9.02056e-17, -6.245e-17, 0.107, 1, 0, 4.16334e-17, 1.11022e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [3.02523e-18, -5.71497e-17, -4.69811e-16, 1, -6.93889e-18, -2.08167e-17, -5.37764e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 6.93889e-18, -1.56125e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -2.08167e-17, 5.20417e-18, 8.32667e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [4.16334e-17, -1.56125e-17, 0.0584, 1, -3.46945e-18, 6.07153e-18, 2.77556e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [4.16334e-17, -1.56125e-17, 0.0584, 1, -3.46945e-18, 6.07153e-18, 2.77556e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [2.25514e-17, 0.04, -2.25948e-16, 1, -6.93889e-18, 6.07153e-18, 2.77556e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-4.03323e-17, -0.04, -2.7452e-16, 1, -6.93889e-18, 6.07153e-18, 2.77556e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-7.38406e-17, 2.33094e-17, -3.70258e-17, -1.03385e-13, 0, 6.93889e-18, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 3.55272e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [2.08167e-17, -8.67362e-18, -0.15, 1, -1.56938e-17, 1.73472e-18, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [7.63278e-17, 0.02, -0.2, 1, 2.77556e-17, 1.04083e-17, 7.97973e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -2.22045e-16, -2.77556e-17, -1.11022e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -5.55112e-17, 1.38778e-17, -8.32667e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.12757e-17, -1.19696e-16, -0.04, 1, -5.81132e-17, -2.77556e-17, 3.81639e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [1.25767e-17, 0, 0.01, 1, 0, 4.16334e-17, 1.11022e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.59595e-16, -9.71445e-17, 0.2105, 7.63278e-17, 0.92388, 0.382683, 2.77556e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 2.77556e-17, 0], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.17961e-16, 0.008, 0.045, 1, -6.93889e-18, 6.07153e-18, 2.77556e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.38778e-17, -0.008, 0.045, 1, -6.93889e-18, 6.07153e-18, 2.77556e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [8.09915e-05, 0.100085, 0.0757355, 1, -2.84522e-05, 0.000148234, 3.5776e-05], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [-3.04932e-20, -1.44589e-18, 0.035, 1, 0, -7.63138e-20, -2.03288e-20], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True } }
base2(table): { pose: [0.6, -0.25, 0.065], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base2_handle(base2): { pose: [0, 0, 0.035], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [1, 0, 0], ical: { is_object: True, %log: True } }
base3(table): { pose: [0.6, -0.6, 0.065], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base3_handle(base3): { pose: [0, 0, 0.035], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [-0.149998, 0.0001778, 0.136495, 1, -7.72832e-05, 9.59315e-05, -2.48164e-05], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [0.150092, 0.000209771, 0.136253, 1, -0.000123612, -1.15661e-05, -1.52172e-05], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.5, 0, 0.09], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [-0.65, 0, 0.09], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [-0.5, -0.2, 0.09], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl6(table): { pose: [-0.65, -0.2, 0.09], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl7(table): { pose: [-0.5, -0.4, 0.09], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl8(table): { pose: [-0.65, -0.4, 0.09], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
place_base1(table): { pose: [0, 0.1, 0.05], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base1(base1): { pose: [0.15, 0.1, 0.015, 1, 0, -7.63138e-20, -2.03288e-20], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base1(base1): { pose: [-0.15, 0.1, 0.015, 1, 0, -7.63138e-20, -2.03288e-20], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base1(base1): { pose: [-0.15, -0.1, 0.015, 1, 0, -7.63138e-20, -2.03288e-20], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base1(base1): { pose: [0.15, -0.1, 0.015, 1, 0, -7.63138e-20, -2.03288e-20], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
back_base1(base1): { pose: [2.4564e-20, -0.1, 0.015, 1, 0, -7.63138e-20, -2.03288e-20], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
front_base1(base1): { pose: [-2.28699e-20, 0.1, 0.015, 1, 0, -7.63138e-20, -2.03288e-20], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
left_base1(base1): { pose: [-0.15, 1.88782e-18, 0.015, 1, 0, -7.63138e-20, -2.03288e-20], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base1(base1): { pose: [0.15, 3.65267e-17, 0.015, 1, 0, -7.63138e-20, -2.03288e-20], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base2(base2): { pose: [0.15, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontright_base2(base2): { pose: [-0.15, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backleft_base2(base2): { pose: [-0.15, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backright_base2(base2): { pose: [0.15, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
back_base2(base2): { pose: [0, -0.11, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
front_base2(base2): { pose: [0, 0.11, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
left_base2(base2): { pose: [-0.15, 0, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
right_base2(base2): { pose: [0.15, 0, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontleft_base3(base3): { pose: [0.15, 0.11, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontright_base3(base3): { pose: [-0.15, 0.11, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backleft_base3(base3): { pose: [-0.15, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backright_base3(base3): { pose: [0.15, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
back_base3(base3): { pose: [0, -0.11, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
front_base3(base3): { pose: [0, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
left_base3(base3): { pose: [-0.15, 0, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
right_base3(base3): { pose: [0.15, 0, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }