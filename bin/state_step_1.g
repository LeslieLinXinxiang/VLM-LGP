world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.996668, -0, 0, -0.081567], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -5.55112e-17, -5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.955182, 5.55112e-17, -5.55112e-17, 0.29602], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-8.32667e-17, -0.316, -1.04471e-16, 0.707107, 0.707107, 5.55112e-17, 5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-8.37057e-17, 1.84381e-17, -5.73947e-17, 0.996071, 2.77556e-17, -5.55112e-17, 0.0885606], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.98986e-17, 4.16334e-17, 0.707107, 0.707107, 5.55112e-17, -8.32667e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.92237e-17, -1.84018e-17, 1.09264e-17, 0.52916, -5.55112e-17, 9.71445e-17, -0.848522], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 1.11022e-16, 0.707107, -0.707107, -4.16334e-17, -4.16334e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-1.49074e-16, 1.64046e-16, -1.52746e-16, 0.995073, 1.66533e-16, 0, -0.0991426], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, 0, 7.63278e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.261979, -5.55112e-17, -8.32667e-17, 0.965074], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -7.35867e-17, 3.35456e-17, 0.707107, 0.707107, -4.27428e-17, 8.04832e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.82781e-16, 9.07701e-17, -1.11022e-16, 0.887123, -8.45622e-17, 7.04488e-18, 0.461534], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [6.52459e-18, -6.41718e-18, 0.107, 1, -5.29396e-23, -2.11758e-22, -2.94601e-18] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.23395e-21, 1.59576e-23, -7.77156e-16, 1, -5.29396e-23, 0, -2.94601e-18] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 5.29396e-23, 1.05879e-22, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 2.11758e-22, -2.11758e-22, -6.57747e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-1.40992e-17, 1.09558e-19, 0.0584, 1, 0, 0, -6.57747e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-1.40992e-17, 1.09558e-19, 0.0584, 1, 0, 0, -6.57747e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-5.271e-17, 0.04, -3.17044e-16, 1, 0, 0, -6.57747e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [5.27107e-17, -0.04, -3.4909e-16, 1, 0, 0, -6.57747e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.0867e-16, 1.26952e-16, 2.39466e-23, -1.03372e-13, 2.26647e-22, -1.0257e-22, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 4.62223e-33, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [0, 1.21431e-17, -0.15, 1, -5.55112e-17, 1.38778e-17, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [-4.16334e-17, 0.02, -0.2, 1, -1.38778e-17, 0, 4.16334e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 8.32667e-17, 0, 5.55112e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [6.0099e-18, -3.46645e-18, 1.14286e-19, 1, 2.77556e-17, -5.55112e-17, 2.77556e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [4.32595e-17, 2.30855e-17, -0.04, 1, 0, -8.32667e-17, 2.77556e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [1.71219e-17, -1.71095e-17, 0.01, 1, -5.29396e-23, -2.11758e-22, -2.94601e-18], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [2.75466e-18, -3.02599e-17, 0.2105, 2.34328e-17, 0.92388, 0.382683, 5.65715e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, 5.31536e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.01493e-16, 0.008, 0.045, 1, 1.05879e-22, 1.05879e-22, -6.57747e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-5.0272e-17, -0.008, 0.045, 1, 1.05879e-22, 1.05879e-22, -6.57747e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-0.00499691, 0.295, 0.066, 1, -6.85895e-10, 9.40445e-09, 2.63682e-06], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [2.62003e-19, 8.81092e-18, 0.035, 1, 0, 5.36475e-25, 0], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.2, inertia: [0.00064, 0.00064, 0.00064], logical: { is_object: True } }
base2(table): { pose: [0.5, -0.32, 0.065], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [0.9, 0.1, 0.1], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base2_handle(base2): { pose: [0, 0, 0.035], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [0.9, 0.1, 0.1], contact: 1, mass: 0.2, inertia: [0.00064, 0.00064, 0.00064], logical: { is_object: True } }
base3(table): { pose: [0.5, -0.7, 0.065], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [0.1, 0.1, 0.9], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base3_handle(base3): { pose: [0, 0, 0.035], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [0.1, 0.1, 0.9], contact: 1, mass: 0.2, inertia: [0.00064, 0.00064, 0.00064], logical: { is_object: True } }
cyl1(table): { pose: [-0.4, 0.15, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0, 0.8, 0], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [-0.4, 0, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [1, 0.9, 0], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.55, 0.15, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0, 0.9, 0.9], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [-0.55, 0, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0.9, 0, 0.9], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [-0.65, 0, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [1, 0.5, 0], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl6(table): { pose: [-0.65, -0.15, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0.5, 0, 0.8], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl7(table): { pose: [-0.8, 0, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [1, 0.4, 0.7], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl8(table): { pose: [-0.8, -0.15, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0.6, 0.3, 0.1], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
place_base1(table): { pose: [0, 0.3, 0.05], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base1(base1): { pose: [0.15, 0.1, 0.015, 1, 0, 5.36475e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base1(base1): { pose: [-0.15, 0.1, 0.015, 1, 0, 5.36475e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base1(base1): { pose: [0.15, -0.1, 0.015, 1, 0, 5.36475e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base1(base1): { pose: [-0.15, -0.1, 0.015, 1, 0, 5.36475e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
back_base1(base1): { pose: [7.82147e-20, -0.1, 0.015, 1, 0, 5.36475e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
front_base1(base1): { pose: [6.42078e-19, 0.1, 0.015, 1, 0, 5.36475e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
left_base1(base1): { pose: [0.15, 3.55367e-17, 0.015, 1, 0, 5.36475e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base1(base1): { pose: [-0.15, -1.21243e-17, 0.015, 1, 0, 5.36475e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base2(base2): { pose: [0.15, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base2(base2): { pose: [-0.15, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base2(base2): { pose: [0.15, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base2(base2): { pose: [-0.15, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
back_base2(base2): { pose: [0, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
front_base2(base2): { pose: [0, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
left_base2(base2): { pose: [0.15, 0, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base2(base2): { pose: [-0.15, 0, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base3(base3): { pose: [0.15, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base3(base3): { pose: [-0.15, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base3(base3): { pose: [0.15, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base3(base3): { pose: [-0.15, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
back_base3(base3): { pose: [0, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
front_base3(base3): { pose: [0, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
left_base3(base3): { pose: [0.15, 0, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base3(base3): { pose: [-0.15, 0, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }