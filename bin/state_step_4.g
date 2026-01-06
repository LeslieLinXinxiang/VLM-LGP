world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/git/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.969026, -0, 0, -0.246961], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/git/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -1.11022e-16, -5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.961094, 5.55112e-17, 0, 0.276223], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/git/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-1.38778e-16, -0.316, -1.38254e-16, 0.707107, 0.707107, 1.11022e-16, 3.05311e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-3.03897e-17, 3.10577e-17, -2.81071e-16, 0.959519, -2.77556e-17, -5.55112e-17, 0.281644], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/git/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -1.33574e-16, 1.00614e-16, 0.707107, 0.707107, -2.08167e-17, -2.22045e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.64051e-17, -9.4126e-18, 1.33093e-17, 0.584163, 0, -1.38778e-17, -0.811637], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/git/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 9.02056e-17, 0.707107, -0.707107, -5.55112e-17, 1.38778e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.37839e-17, 6.64704e-17, 1.43709e-17, 0.979216, 0, 0, -0.20282], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/git/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-1.71909e-19, 8.3096e-19, 1.79636e-19, 0.707107, 0.707107, 1.38778e-17, -6.245e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.391983, 1.11022e-16, 5.55112e-17, 0.919973], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/git/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.38039e-16, 3.17326e-16, 0.707107, 0.707107, 3.03414e-16, 3.13605e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.5548e-16, 7.91572e-17, -2.221e-16, 0.846275, 2.84061e-17, 4.45065e-17, 0.532746], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/git/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [7.59958e-17, -7.21841e-17, 0.107, 1, -1.91091e-17, -1.73472e-17, 6.7857e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.22383e-17, 1.13032e-17, -1.33228e-15, 1, 1.76183e-18, -6.966e-18, -4.31712e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [2.05368e-17, 1.86712e-17, -1.43387e-20, 0.92388, -1.35525e-20, 1.3932e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 6.88468e-18, -1.38507e-17, 2.28025e-16], shape: mesh, mesh: </home/leslie/git/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-4.34867e-18, -1.91429e-17, 0.0584, 1, -2.07625e-17, 7.02021e-18, 2.28021e-16] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-4.34867e-18, -1.91429e-17, 0.0584, 1, -2.07625e-17, 7.02021e-18, 2.28021e-16] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-9.63454e-17, 0.04, -5.41434e-16, 1, -6.966e-18, 2.07896e-17, 5.9716e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/git/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [9.63182e-17, -0.04, 3.19389e-16, 1, 6.91179e-18, -2.08709e-17, 5.97727e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.09605e-16, 2.66946e-16, -1.11133e-16, -1.03467e-13, -2.77827e-17, 1.38778e-17, 1], shape: mesh, mesh: </home/leslie/git/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 5.32908e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.66533e-16, -2.08167e-17, -0.15, 1, -5.55112e-17, -2.08167e-17, -5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [3.60822e-16, 0.02, -0.2, 1, -2.77556e-17, 0, 6.93889e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 2.77556e-17, -1.66533e-16, 2.22045e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -5.55112e-17, -1.38778e-17, -5.55112e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.30695e-16, 3.51959e-17, -0.04, 1, -5.55112e-17, 8.32667e-17, 2.22045e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [3.14588e-18, 8.76256e-19, 0.01, 1, -1.91091e-17, -1.73472e-17, 6.7857e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.27326e-16, -1.81116e-16, 0.2105, 3.25278e-17, 0.92388, 0.382683, 4.51049e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -5.55112e-17, -2.62241e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.85153e-16, 0.008, 0.045, 1, -6.91179e-18, -1.38778e-17, 5.97441e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.56367e-16, -0.008, 0.045, 1, -2.77556e-17, -1.39049e-17, 2.28019e-16], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-0.00499691, 0.295, 0.066, 1, -6.85895e-10, 9.40445e-09, 2.63682e-06], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [-9.89845e-20, -1.55911e-17, 0.035, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.2, inertia: [0.00064, 0.00064, 0.00064], logical: { is_object: True } }
base2(table): { pose: [-0.0125826, 0.329534, 0.167134, 1, -3.0624e-05, 0.000271629, 0.00024121], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [0.9, 0.1, 0.1], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base2_handle(base2): { pose: [-8.1654e-19, -2.58387e-18, 0.035, 1, 0, -1.72302e-21, 0], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [0.9, 0.1, 0.1], contact: 1, mass: 0.2, inertia: [0.00064, 0.00064, 0.00064], logical: { is_object: True } }
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
frontleft_base2(base2): { pose: [0.15, 0.1, 0.015, 1, 0, -1.72302e-21, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base2(base2): { pose: [-0.15, 0.1, 0.015, 1, 0, -1.72302e-21, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base2(base2): { pose: [0.15, -0.1, 0.015, 1, 0, -1.72302e-21, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base2(base2): { pose: [-0.15, -0.1, 0.015, 1, 0, -1.72302e-21, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
back_base2(base2): { pose: [-6.14946e-19, -0.1, 0.015, 1, 0, -1.72302e-21, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
front_base2(base2): { pose: [-6.21722e-19, 0.1, 0.015, 1, 0, -1.72302e-21, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
left_base2(base2): { pose: [0.15, 2.40765e-17, 0.015, 1, 0, -1.72302e-21, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base2(base2): { pose: [-0.15, -1.0455e-17, 0.015, 1, 0, -1.72302e-21, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base3(base3): { pose: [0.15, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base3(base3): { pose: [-0.15, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base3(base3): { pose: [0.15, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base3(base3): { pose: [-0.15, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
back_base3(base3): { pose: [0, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
front_base3(base3): { pose: [0, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
left_base3(base3): { pose: [0.15, 0, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base3(base3): { pose: [-0.15, 0, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }