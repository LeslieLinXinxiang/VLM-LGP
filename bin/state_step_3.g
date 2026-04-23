world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.999972, -0, 0, -0.00753682], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -1.11022e-16, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.931469, 1.11022e-16, -5.55112e-17, 0.363821], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-1.94289e-16, -0.316, -1.99886e-17, 0.707107, 0.707107, 1.11022e-16, 1.38778e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-5.44863e-17, 7.95072e-17, -3.52217e-16, 0.992458, 0, -5.55112e-17, 0.122582], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -1.26635e-16, -1.17961e-16, 0.707107, 0.707107, 4.16334e-17, -1.38778e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [1.67998e-18, 2.38668e-18, 3.94405e-18, 0.633603, 8.32667e-17, -7.63278e-17, -0.773658], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 7.63278e-17, 0.707107, -0.707107, -1.249e-16, 1.66533e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-2.98229e-18, 8.09797e-17, 1.91506e-17, 0.991995, -8.32667e-17, 2.77556e-17, -0.126278], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, -2.77556e-17, -9.71445e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.178311, -1.11022e-16, -5.55112e-17, 0.983974], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -1.56125e-16, 2.18955e-16, 0.707107, 0.707107, 2.91434e-16, 1.17961e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.36878e-16, 6.34683e-17, -4.34515e-17, 0.908781, -1.11022e-16, 2.94903e-17, 0.417274], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [5.20417e-17, -4.85723e-17, 0.107, 1, -1.9082e-17, -1.73472e-17, 1.24466e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.51701e-17, 9.57282e-18, -1.04612e-15, 1, 1.73472e-18, -6.93889e-18, -4.0766e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [1.34557e-17, 2.4055e-17, -3.26678e-18, 0.92388, 0, 1.38778e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 6.93889e-18, -1.38778e-17, 9.36751e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [1.04083e-17, -2.05998e-17, 0.0584, 1, -2.08167e-17, 6.93889e-18, 9.36751e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [1.04083e-17, -2.05998e-17, 0.0584, 1, -2.08167e-17, 6.93889e-18, 9.36751e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-1.1189e-16, 0.04, -4.4062e-16, 1, -6.93889e-18, 2.08167e-17, 3.81639e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [5.78964e-17, -0.04, 1.90386e-16, 1, -6.93889e-18, 0, -1.2837e-16], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.69176e-16, 2.06231e-16, -5.97854e-17, -1.03468e-13, -2.77556e-17, 1.38778e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 3.55272e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.249e-16, -2.42861e-17, -0.15, 1, -8.32667e-17, 2.77556e-17, 5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.11022e-16, 0.02, -0.2, 1, 0, 0, 2.08167e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -5.55112e-17, 0, 1.38778e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-2.79524e-18, 1.97456e-18, 5.69898e-19, 1, -8.32667e-17, 0, 8.32667e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [7.85776e-17, -4.26634e-17, -0.04, 1, 0, 5.55112e-17, 1.66533e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [2.12504e-17, -1.99493e-17, 0.01, 1, -1.9082e-17, -1.73472e-17, 1.24466e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.31839e-16, -1.8735e-16, 0.2105, 3.25261e-17, 0.92388, 0.382683, 4.51028e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -5.55112e-17, 0], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.23779e-16, 0.008, 0.045, 1, -6.93889e-18, -1.38778e-17, 3.64292e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.35308e-16, -0.008, 0.045, 1, -2.77556e-17, -1.38778e-17, 1.49186e-16], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-0.00499691, 0.295, 0.066, 1, -6.85895e-10, 9.40445e-09, 2.63682e-06], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [-9.89845e-20, -1.55911e-17, 0.035, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.2, inertia: [0.00064, 0.00064, 0.00064], logical: { is_object: True } }
base2(table): { pose: [0.5, -0.32, 0.065], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [0.9, 0.1, 0.1], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base2_handle(base2): { pose: [0, 0, 0.035], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [0.9, 0.1, 0.1], contact: 1, mass: 0.2, inertia: [0.00064, 0.00064, 0.00064], logical: { is_object: True } }
base3(table): { pose: [0.5, -0.7, 0.065], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [0.1, 0.1, 0.9], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base3_handle(base3): { pose: [0, 0, 0.035], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [0.1, 0.1, 0.9], contact: 1, mass: 0.2, inertia: [0.00064, 0.00064, 0.00064], logical: { is_object: True } }
cyl1(table): { pose: [-0.16204, 0.394365, 0.117, 0.940133, 8.0151e-10, 1.76997e-10, -0.340809], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0, 0.8, 0], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [0.135745, 0.395645, 0.116992, 0.923465, 2.51526e-06, -1.98379e-06, -0.383682], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [1, 0.9, 0], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.55, 0.15, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0, 0.9, 0.9], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [-0.55, 0, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0.9, 0, 0.9], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [-0.65, 0, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [1, 0.5, 0], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl6(table): { pose: [-0.65, -0.15, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0.5, 0, 0.8], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl7(table): { pose: [-0.8, 0, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [1, 0.4, 0.7], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl8(table): { pose: [-0.0122555, 0.198753, 0.116987, 0.917836, -3.34163e-06, -4.49142e-06, -0.39696], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0.6, 0.3, 0.1], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
place_base1(table): { pose: [0, 0.3, 0.05], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base1(base1): { pose: [0.15, 0.1, 0.015, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base1(base1): { pose: [-0.15, 0.1, 0.015, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base1(base1): { pose: [0.15, -0.1, 0.015, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base1(base1): { pose: [-0.15, -0.1, 0.015, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
back_base1(base1): { pose: [4.26344e-19, -0.1, 0.015, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
front_base1(base1): { pose: [8.51828e-19, 0.1, 0.015, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
left_base1(base1): { pose: [0.15, 4.57823e-17, 0.015, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base1(base1): { pose: [-0.15, 1.22253e-17, 0.015, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
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