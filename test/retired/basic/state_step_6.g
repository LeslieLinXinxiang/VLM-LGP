world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.996254, -0, 0, -0.0864752], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 1.66533e-16, -1.66533e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.996678, 5.55112e-17, 0, -0.0814423], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-3.81639e-16, -0.316, -2.07821e-16, 0.707107, 0.707107, -2.22045e-16, -5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-1.16252e-16, 1.42517e-16, -2.05903e-16, 0.995903, 4.16334e-17, 3.46945e-17, 0.0904238], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.18159e-16, -9.19403e-17, 0.707107, 0.707107, 4.51028e-17, 1.11022e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-5.47782e-17, 8.92562e-18, -2.04341e-18, 0.211541, -5.55112e-17, -2.77556e-17, -0.977369], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 2.60209e-16, 0.707107, -0.707107, 2.77556e-17, -1.249e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-1.0393e-16, 2.62435e-16, -2.06875e-16, 0.999647, 1.38778e-16, 0, 0.0265548], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-1.93032e-17, -1.60296e-17, 1.28482e-17, 0.707107, 0.707107, 5.55112e-17, 1.11022e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.289518, 5.55112e-17, 1.11022e-16, 0.957173], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 2.30684e-16, 4.54756e-16, 0.707107, 0.707107, -1.50968e-16, 2.06066e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.77016e-16, 9.12859e-17, -6.83382e-21, 0.932512, 3.35561e-17, -2.02339e-17, 0.361139], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [2.01055e-16, -1.59334e-16, 0.107, 1, -1.38981e-17, 5.55383e-17, 1.19177e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-1.99763e-17, -7.953e-17, -1.44328e-15, 1, 0, -6.59195e-17, -4.73551e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -4.85723e-17, -7.80761e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -5.55247e-17, 2.08235e-17, 1.21203e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [9.82143e-17, -6.23416e-18, 0.0584, 1, 0, -6.07153e-18, 1.21185e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [9.82143e-17, -6.23416e-18, 0.0584, 1, 0, -6.07153e-18, 1.21185e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-3.02334e-18, 0.04, -8.37941e-16, 1, -6.93889e-18, -9.54098e-18, 1.21183e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [2.99172e-18, -0.04, 1.71807e-16, 1, 6.91857e-18, 9.52743e-18, 1.21181e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.67553e-16, 1.30541e-16, -1.63187e-20, -1.03405e-13, 1.35525e-20, 1.38642e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 8.8818e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, -1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.70003e-16, 4.59702e-17, -0.15, 1, -2.77556e-17, -6.245e-17, 2.22045e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [3.46945e-16, 0.02, -0.2, 1, 5.55112e-17, 5.55112e-17, 6.245e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -2.22045e-16, -1.11022e-16, -2.77556e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-7.22772e-20, -7.37626e-20, -3.46791e-18, 1, 0, 0, -3.33067e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.26963e-16, -3.00415e-16, -0.04, 1, -2.77556e-17, -5.55112e-17, 0], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [3.85881e-17, -2.159e-17, 0.01, 1, -1.38981e-17, 5.55383e-17, 1.19177e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [4.53481e-16, -2.79839e-16, 0.2105, 6.9406e-17, 0.92388, 0.382683, -3.80768e-20], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -5.55112e-17, 4.6292e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.8873e-16, 0.008, 0.045, 1, -6.93889e-18, -9.54776e-18, 1.21174e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-6.58132e-17, -0.008, 0.045, 1, 0, -6.07831e-18, 1.21192e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [8.09915e-05, 0.100085, 0.0757355, 1, -2.84522e-05, 0.000148234, 3.5776e-05], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [-7.11508e-20, -1.44589e-18, 0.035, 1, 0, -1.57628e-19, -4.06576e-20], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True } }
base2(table): { pose: [0.000126888, 0.100172, 0.186518, 1, -2.33315e-05, 9.32736e-05, 4.81036e-05], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base2_handle(base2): { pose: [1.69407e-21, -4.05517e-19, 0.035, 1, 0, -2.04231e-21, 0], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [1, 0, 0], ical: { is_object: True, %log: True } }
base3(table): { pose: [0.6, -0.6, 0.065], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base3_handle(base3): { pose: [0, 0, 0.035], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [-0.149998, 0.0001778, 0.136495, 1, -7.72832e-05, 9.59315e-05, -2.48164e-05], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [0.150092, 0.000209771, 0.136253, 1, -0.000123612, -1.15661e-05, -1.52172e-05], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.149949, 0.200052, 0.129232, 1, -3.06381e-05, 9.41194e-05, -2.36613e-05], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [0.150017, 0.200104, 0.129147, 1, -4.95881e-05, 6.07653e-05, -3.30286e-05], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [-0.5, -0.2, 0.09], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl6(table): { pose: [-0.65, -0.2, 0.09], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl7(table): { pose: [-0.5, -0.4, 0.09], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl8(table): { pose: [-0.65, -0.4, 0.09], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
place_base1(table): { pose: [0, 0.1, 0.05], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base1(base1): { pose: [0.15, 0.1, 0.015, 1, 0, -1.57628e-19, -4.06576e-20], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base1(base1): { pose: [-0.15, 0.1, 0.015, 1, 0, -1.57628e-19, -4.06576e-20], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base1(base1): { pose: [-0.15, -0.1, 0.015, 1, 0, -1.57628e-19, -4.06576e-20], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base1(base1): { pose: [0.15, -0.1, 0.015, 1, 0, -1.57628e-19, -4.06576e-20], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
back_base1(base1): { pose: [2.4564e-20, -0.1, 0.015, 1, 0, -1.57628e-19, -4.06576e-20], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
front_base1(base1): { pose: [-6.35275e-20, 0.1, 0.015, 1, 0, -1.57628e-19, -4.06576e-20], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
left_base1(base1): { pose: [-0.15, 1.88782e-18, 0.015, 1, 0, -1.57628e-19, -4.06576e-20], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base1(base1): { pose: [0.15, 7.81601e-17, 0.015, 1, 0, -1.57628e-19, -4.06576e-20], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base2(base2): { pose: [0.15, 0.1, 0.015, 1, 0, -2.04231e-21, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontright_base2(base2): { pose: [-0.15, 0.1, 0.015, 1, 0, -2.04231e-21, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backleft_base2(base2): { pose: [-0.15, -0.1, 0.015, 1, 0, -2.04231e-21, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backright_base2(base2): { pose: [0.15, -0.1, 0.015, 1, 0, -2.04231e-21, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
back_base2(base2): { pose: [-1.90582e-20, -0.11, 0.015, 1, 0, -2.04231e-21, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
front_base2(base2): { pose: [4.23516e-21, 0.11, 0.015, 1, 0, -2.04231e-21, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
left_base2(base2): { pose: [-0.15, 6.02886e-18, 0.015, 1, 0, -2.04231e-21, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
right_base2(base2): { pose: [0.15, 1.55123e-18, 0.015, 1, 0, -2.04231e-21, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontleft_base3(base3): { pose: [0.15, 0.11, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontright_base3(base3): { pose: [-0.15, 0.11, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backleft_base3(base3): { pose: [-0.15, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backright_base3(base3): { pose: [0.15, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
back_base3(base3): { pose: [0, -0.11, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
front_base3(base3): { pose: [0, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
left_base3(base3): { pose: [-0.15, 0, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
right_base3(base3): { pose: [0.15, 0, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.5, 0.5, 0.8], logical: { is_place: True } }