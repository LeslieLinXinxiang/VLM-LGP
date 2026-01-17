world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.999963, -0, 0, -0.00861313], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, -5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.89815, 0, 0, 0.43969], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [5.55112e-17, -0.316, -8.19633e-17, 0.707107, 0.707107, 5.55112e-17, 0] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-7.8066e-18, 9.48949e-17, -7.34097e-16, 0.999751, -5.55112e-17, 1.38778e-16, 0.0223009], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.29851e-17, 1.249e-16, 0.707107, 0.707107, 2.77556e-17, 8.32667e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.75563e-16, 9.34928e-18, 3.17165e-17, 0.792374, 5.55112e-17, 1.38778e-16, -0.610036], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 1.83013e-16, 0.707107, -0.707107, -8.32667e-17, 5.55112e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-1.90981e-16, 3.04093e-16, -2.81508e-16, 0.998823, -1.11022e-16, 5.55112e-17, -0.0485069], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [0.707107, 0.707107, -5.55112e-17, -4.16334e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.465235, -5.55112e-17, 0, 0.885187], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -2.38524e-16, 1.5992e-18, 0.707107, 0.707107, -6.08237e-17, -2.05998e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-4.11134e-16, 1.77941e-16, -1.95008e-16, 0.936814, -4.51028e-17, -2.77556e-17, -0.349829], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-8.67362e-18, 2.03627e-17, 0.107, 1, -1.73472e-18, 0, 2.74303e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [7.07741e-18, -3.82617e-19, -1.11297e-15, 1, 0, 0, 2.74303e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 3.46945e-18, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, -2.55465e-18, 1.73472e-18], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-5.20417e-18, -1.56125e-17, 0.0584, 1, 0, 8.74138e-19, 0] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-5.20417e-18, -1.56125e-17, 0.0584, 1, 0, 8.74138e-19, 0] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [3.94379e-18, 0.04, -4.97432e-16, 1, 0, 8.74138e-19, 0], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-4.87891e-19, -0.04, -6.13008e-16, 1, 0, 8.74138e-19, 0], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [4.16047e-18, 5.05466e-18, 1.10833e-16, -1.03411e-13, 3.46945e-18, 3.38813e-20, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 4.62223e-33, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.38778e-17, 1.17528e-16, -0.15, 1, 2.77556e-17, -5.55112e-17, 1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [0, 0.02, -0.2, 1, -5.55112e-17, -2.77556e-17, -1.38778e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -5.55112e-17, 0, 0], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -2.77556e-17, -1.38778e-17, 8.32667e-17], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [6.46727e-17, -1.51788e-18, -0.04, 1, -5.55112e-17, -8.32667e-17, 0], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-1.92988e-17, -1.53163e-17, 0.01, 1, -1.73472e-18, 0, 2.74303e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-2.94903e-17, 4.47979e-17, 0.2105, 2.42861e-17, 0.92388, 0.382683, 5.89806e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 2.27682e-18, -3.46945e-18], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-6.50521e-18, 0.008, 0.045, 1, 0, 8.74138e-19, 0], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-3.46945e-18, -0.008, 0.045, 1, 0, 8.74138e-19, 0], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-0.00416016, 0.43, 0.07, 1, 0, 0, -0.000122148], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True, is_place: True } }
base2(table): { pose: [-0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base2_handle(base2): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
base3(table): { pose: [0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
base3_handle(base3): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [-0.4, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [-0.5, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.5, 0, 0.1], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [-0.4, 0, 0.1], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [0.5, 0, 0.1], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl6(table): { pose: [0.4, 0, 0.1], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl7(table): { pose: [0.5, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], cont act: 1, logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl8(table): { pose: [0.4, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
place_base1(table): { pose: [0, 0.45, 0.05], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base1(base1): { pose: [0.2, 0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base1(base1): { pose: [-0.2, 0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base1(base1): { pose: [-0.2, -0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base1(base1): { pose: [0.2, -0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
back_base1(base1): { pose: [-1.49078e-19, -0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
front_base1(base1): { pose: [1.35525e-19, 0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
left_base1(base1): { pose: [-0.2, 8.29415e-18, 0.02], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base1(base1): { pose: [0.2, -8.29415e-18, 0.02], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base2(base2): { pose: [0.2, 0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontright_base2(base2): { pose: [-0.2, 0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backleft_base2(base2): { pose: [-0.2, -0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backright_base2(base2): { pose: [0.2, -0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
back_base2(base2): { pose: [0, -0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
front_base2(base2): { pose: [0, 0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
left_base2(base2): { pose: [-0.2, 0, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
right_base2(base2): { pose: [0.2, 0, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontleft_base3(base3): { pose: [0.2, 0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontright_base3(base3): { pose: [-0.2, 0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backleft_base3(base3): { pose: [-0.2, -0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backright_base3(base3): { pose: [0.2, -0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
back_base3(base3): { pose: [0, -0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
front_base3(base3): { pose: [0, 0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
left_base3(base3): { pose: [-0.2, 0, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
right_base3(base3): { pose: [0.2, 0, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }