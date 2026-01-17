world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.998633, -0, 0, 0.0522743], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, -5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.994909, 1.11022e-16, 0, 0.100774], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-4.16334e-17, -0.316, 1.14941e-16, 0.707107, 0.707107, -1.11022e-16, 1.11022e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [5.64618e-17, -8.14637e-17, 2.38205e-16, 0.99919, -1.66533e-16, -2.08167e-17, -0.0402322], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, 5.07949e-17, 5.20417e-17, 0.707107, 0.707107, 6.93889e-18, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [1.08831e-16, 2.22134e-17, -6.11036e-19, 0.214493, 2.77556e-17, 1.38778e-16, -0.976726], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -1.18829e-16, 0.707107, -0.707107, -9.02056e-17, -1.38778e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [6.51907e-17, -1.42669e-16, 2.15162e-16, 0.999359, 1.04083e-16, -1.38778e-17, 0.0357875], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-1.7239e-18, -7.90315e-19, 4.06382e-19, 0.707107, 0.707107, -5.55112e-17, 1.38778e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.115596, 0, 5.55112e-17, 0.993296], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 5.89349e-17, 2.68497e-18, 0.707107, 0.707107, 2.29715e-17, -3.10759e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [4.07053e-17, -2.2159e-17, 1.11026e-16, 0.933571, 5.32208e-17, 2.68205e-17, 0.358393], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-4.57737e-18, 4.25888e-18, 0.107, 1, 0, 0, 1.96986e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [2.79584e-20, 1.96792e-20, 1.11022e-16, 1, 0, 0, 1.96986e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -6.77626e-21, 1.35525e-20, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, 1.35525e-20, -1.9306e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-3.1823e-18, -2.37169e-20, 0.0584, 1, -1.35525e-20, -5.42101e-20, -2.6527e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-3.1823e-18, -2.37169e-20, 0.0584, 1, -1.35525e-20, -5.42101e-20, -2.6527e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [5.75937e-18, 0.04, 1.08712e-16, 1, 1.35525e-20, 4.06576e-20, -2.6527e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-5.74766e-18, -0.04, 1.13333e-16, 1, 1.35525e-20, 4.06576e-20, -2.6527e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [1.40513e-17, -2.06999e-17, 5.53954e-21, -1.03444e-13, -4.06576e-20, 0, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 4.62223e-33, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.04083e-17, -2.12504e-17, -0.15, 1, -6.93889e-18, 0, 5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [0, 0.02, -0.2, 1, 6.93889e-18, -6.93889e-18, 1.69136e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -1.11022e-16, -5.55112e-17, 0], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-4.98601e-20, -1.69894e-20, -1.73392e-18, 1, 2.77556e-17, -8.32667e-17, -5.55112e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-1.59107e-17, -2.98952e-17, -0.04, 1, -5.55112e-17, 8.32667e-17, 5.55112e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-4.1242e-18, 4.03844e-18, 0.01, 1, 0, 0, 1.96986e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-2.01458e-17, -5.54976e-18, 0.2105, 2.3417e-17, 0.92388, 0.382683, 5.65941e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 0, 3.91194e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-1.11292e-17, 0.008, 0.045, 1, -1.35525e-20, -4.06576e-20, -2.6527e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [1.4688e-17, -0.008, 0.045, 1, -1.35525e-20, -4.06576e-20, -2.6527e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [8.09915e-05, 0.100085, 0.0757355, 1, -2.84522e-05, 0.000148234, 3.5776e-05], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [-5.0822e-21, 6.32437e-18, 0.035, 1, 0, -2.18572e-20, -6.77626e-21], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True } }
base2(table): { pose: [0.6, -0.25, 0.065], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base2_handle(base2): { pose: [0, 0, 0.035], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [1, 0, 0], ical: { is_object: True, %log: True } }
base3(table): { pose: [0.6, -0.6, 0.065], joint: rigid, shape: ssBox, size: [0.45, 0.35, 0.03, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0617, 0.1017, 0.1625], logical: { is_object: True, is_place: True } }
base3_handle(base3): { pose: [0, 0, 0.035], shape: ssBox, size: [0.04, 0.04, 0.04, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [-0.5, 0.2, 0.09], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [-0.65, 0.2, 0.09], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.5, 0, 0.09], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [-0.65, 0, 0.09], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [-0.5, -0.2, 0.09], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl6(table): { pose: [-0.65, -0.2, 0.09], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl7(table): { pose: [-0.5, -0.4, 0.09], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl8(table): { pose: [-0.65, -0.4, 0.09], joint: rigid, shape: cylinder, size: [0.07, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000268266, 5.69425e-12, 1.05879e-22, 0.000268266, -1.05879e-21, 0.000255873], logical: { is_object: True, is_cylinder: True, is_place: True } }
place_base1(table): { pose: [0, 0.1, 0.05], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base1(base1): { pose: [0.15, 0.1, 0.015, 1, 0, -2.18572e-20, -6.77626e-21], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base1(base1): { pose: [-0.15, 0.1, 0.015, 1, 0, -2.18572e-20, -6.77626e-21], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base1(base1): { pose: [-0.15, -0.1, 0.015, 1, 0, -2.18572e-20, -6.77626e-21], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base1(base1): { pose: [0.15, -0.1, 0.015, 1, 0, -2.18572e-20, -6.77626e-21], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
back_base1(base1): { pose: [2.03288e-20, -0.1, 0.015, 1, 0, -2.18572e-20, -6.77626e-21], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
front_base1(base1): { pose: [8.47033e-22, 0.1, 0.015, 1, 0, -2.18572e-20, -6.77626e-21], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
left_base1(base1): { pose: [-0.15, 8.87161e-19, 0.015, 1, 0, -2.18572e-20, -6.77626e-21], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base1(base1): { pose: [0.15, 8.5023e-18, 0.015, 1, 0, -2.18572e-20, -6.77626e-21], shape: ssBox, size: [0.05, 0.05, 0.002, 0.001], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
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