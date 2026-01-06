world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/git/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.962627, -0, 0, -0.27083], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/git/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -5.55112e-17, 5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.963686, 0, -1.11022e-16, 0.267037], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/git/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-1.13798e-15, -0.316, -1.59817e-15, 0.707107, 0.707107, 0, 0] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-3.31509e-17, 7.36936e-17, -5.3786e-16, 0.984718, 5.55112e-17, -1.38778e-17, 0.174159], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/git/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -7.79758e-16, 4.85723e-17, 0.707107, 0.707107, 1.66533e-16, 5.55112e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-1.8123e-16, 1.50084e-16, -3.25615e-17, 0.55684, 5.55112e-17, 0, -0.83062], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/git/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 9.99201e-16, 0.707107, -0.707107, 2.77556e-17, -2.498e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-1.26752e-16, 2.11476e-16, -1.39035e-16, 0.991041, 8.32667e-17, 2.77556e-17, -0.133559], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/git/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-9.22223e-19, -2.77368e-17, 4.37897e-19, 0.707107, 0.707107, 0, 2.63678e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.0707372, 0, 1.11022e-16, 0.997495], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/git/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -7.00828e-16, 6.04009e-16, 0.707107, 0.707107, -2.63678e-16, 1.66533e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.31192e-16, 1.76327e-16, -1.42231e-16, 0.920981, -1.249e-16, 2.77556e-17, 0.389608], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/git/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [8.32667e-17, -2.15106e-16, 0.107, 1, 6.93889e-18, 0, -2.498e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.4387e-16, -2.57163e-17, -5.64424e-15, 1, -3.46945e-17, 0, -2.77556e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-1.74592e-18, -7.92749e-17, -9.54981e-17, 0.92388, 0, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -2.77556e-17, 5.55112e-17, -5.55112e-17], shape: mesh, mesh: </home/leslie/git/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [1.49186e-16, -1.35092e-16, 0.0584, 1, 2.77556e-17, 0, -4.85723e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [1.49186e-16, -1.35092e-16, 0.0584, 1, 2.77556e-17, 0, -4.85723e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-4.54281e-17, 0.04, -3.21314e-15, 1, 0, 0, -5.55112e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/git/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [2.07571e-16, -0.04, 2.52988e-15, 1, 0, 0, -5.55112e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.11012e-15, 1.00539e-15, -4.33728e-16, -1.03514e-13, -2.77556e-17, 2.77556e-17, 1], shape: mesh, mesh: </home/leslie/git/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.4211e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 3.33067e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [6.10623e-16, 1.76942e-16, -0.15, 1, -1.11022e-16, -5.55112e-17, -1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.01308e-15, 0.02, -0.2, 1, 5.55112e-17, -4.16334e-16, 4.3715e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 6.93889e-17, -5.55112e-17, -1.11022e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [6.08758e-18, -8.58409e-18, 1.65663e-17, 1, 0, 2.08167e-16, -5.55112e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [4.61816e-16, -2.99619e-16, -0.04, 1, -2.498e-16, 0, -8.32667e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-2.73219e-17, -1.22732e-16, 0.01, 1, 6.93889e-18, 0, -2.498e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.94289e-16, -5.41234e-16, 0.2105, 1.02782e-16, 0.92388, 0.382683, 9.45424e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -2.77556e-17, 9.71445e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.07206e-15, 0.008, 0.045, 1, 0, 0, -5.55112e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.01655e-15, -0.008, 0.045, 1, 0, 0, -5.55112e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-0.00499691, 0.295, 0.066, 1, -6.85895e-10, 9.40445e-09, 2.63682e-06], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [-9.89845e-20, -1.55911e-17, 0.035, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.2, inertia: [0.00064, 0.00064, 0.00064], logical: { is_object: True } }
base2(table): { pose: [-0.012707, 0.295206, 0.167118, 1, -1.73903e-05, 0.000149381, 0.000118386], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [0.9, 0.1, 0.1], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base2_handle(base2): { pose: [-4.52316e-19, -5.34372e-18, 0.035, 1, 0, 1.28114e-20, 0], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [0.9, 0.1, 0.1], contact: 1, mass: 0.2, inertia: [0.00064, 0.00064, 0.00064], logical: { is_object: True } }
base3(table): { pose: [0.5, -0.7, 0.065], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [0.1, 0.1, 0.9], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base3_handle(base3): { pose: [0, 0, 0.035], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [0.1, 0.1, 0.9], contact: 1, mass: 0.2, inertia: [0.00064, 0.00064, 0.00064], logical: { is_object: True } }
cyl1(table): { pose: [-0.16173, 0.192836, 0.117, 0.971982, 2.91152e-10, -1.94647e-10, -0.235055], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0, 0.8, 0], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [0.135523, 0.393975, 0.116996, 0.796056, 8.05773e-06, -6.15325e-08, -0.605223], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [1, 0.9, 0], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.162068, 0.39488, 0.117, 0.927084, 4.22989e-10, 3.19351e-10, -0.374855], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0, 0.9, 0.9], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [0.131022, 0.198959, 0.218076, 0.797988, -5.53048e-07, -8.9403e-07, -0.602674], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0.9, 0, 0.9], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [-0.65, 0, 0.085], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [1, 0.5, 0], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl6(table): { pose: [0.136767, 0.199308, 0.116987, 0.903853, -2.52008e-06, -1.04617e-05, -0.427843], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0.5, 0, 0.8], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl7(table): { pose: [0.131213, 0.398882, 0.218074, 0.787666, -7.73734e-07, -4.48058e-07, -0.616102], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [1, 0.4, 0.7], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl8(table): { pose: [-0.170142, 0.194967, 0.218173, 0.970386, -1.84331e-06, -2.15156e-06, -0.241558], joint: rigid, shape: cylinder, size: [0.07, 0.03], color: [0.6, 0.3, 0.1], contact: 1, mass: 0.2, inertia: [0.000204741, 3.24813e-12, 2.64698e-22, 0.000204741, -5.29396e-22, 0.000149474], logical: { is_object: True, is_cylinder: True, is_place: True } }
place_base1(table): { pose: [0, 0.3, 0.05], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base1(base1): { pose: [0.15, 0.1, 0.015, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base1(base1): { pose: [-0.15, 0.1, 0.015, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base1(base1): { pose: [0.15, -0.1, 0.015, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base1(base1): { pose: [-0.15, -0.1, 0.015, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
back_base1(base1): { pose: [4.26344e-19, -0.1, 0.015, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
front_base1(base1): { pose: [8.51828e-19, 0.1, 0.015, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
left_base1(base1): { pose: [0.15, 4.57823e-17, 0.015, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base1(base1): { pose: [-0.15, 1.22253e-17, 0.015, 1, 0, -2.19896e-25, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base2(base2): { pose: [0.15, 0.1, 0.015, 1, 0, 1.28114e-20, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base2(base2): { pose: [-0.15, 0.1, 0.015, 1, 0, 1.28114e-20, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base2(base2): { pose: [0.15, -0.1, 0.015, 1, 0, 1.28114e-20, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base2(base2): { pose: [-0.15, -0.1, 0.015, 1, 0, 1.28114e-20, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
back_base2(base2): { pose: [1.28749e-19, -0.1, 0.015, 1, 0, 1.28114e-20, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
front_base2(base2): { pose: [-5.22619e-19, 0.1, 0.015, 1, 0, 1.28114e-20, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
left_base2(base2): { pose: [0.15, 2.59692e-17, 0.015, 1, 0, 1.28114e-20, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base2(base2): { pose: [-0.15, 1.70307e-17, 0.015, 1, 0, 1.28114e-20, 0], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base3(base3): { pose: [0.15, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base3(base3): { pose: [-0.15, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base3(base3): { pose: [0.15, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base3(base3): { pose: [-0.15, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
back_base3(base3): { pose: [0, -0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
front_base3(base3): { pose: [0, 0.1, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
left_base3(base3): { pose: [0.15, 0, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base3(base3): { pose: [-0.15, 0, 0.015], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }