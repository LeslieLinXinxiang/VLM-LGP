world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.969573, -0, 0, 0.244803], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 5.55112e-17, -1.11022e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.938074, 1.11022e-16, -1.66533e-16, 0.346434], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-2.22045e-16, -0.316, -2.88153e-16, 0.707107, 0.707107, 1.11022e-16, 1.249e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-2.79132e-16, 2.53225e-16, -5.30905e-16, 0.982569, 9.71445e-17, -5.55112e-17, -0.185897], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.24393e-16, -6.93889e-18, 0.707107, 0.707107, -1.38778e-16, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-7.22067e-17, -6.01667e-17, 8.57829e-18, 0.728673, 0, 8.32667e-17, -0.684861], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 2.42861e-16, 0.707107, -0.707107, -3.05311e-16, 4.16334e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-2.02311e-16, 2.64731e-17, -1.20858e-16, 0.956686, -1.38778e-17, 2.77556e-17, -0.291122], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-2.17827e-17, 1.71764e-17, 9.26551e-19, 0.707107, 0.707107, 1.11022e-16, -2.77556e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.564382, 5.55112e-17, -8.32667e-17, 0.825514], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -4.3715e-16, 2.15106e-16, 0.707107, 0.707107, 1.35308e-16, -2.77556e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.52719e-16, 5.49951e-17, -3.72281e-17, 0.987754, -5.55112e-17, -2.77556e-17, -0.156019], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-1.8735e-16, 9.02056e-17, 0.107, 1, -2.77556e-17, -1.45717e-16, -7.63278e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.91941e-17, -1.8939e-17, -2.42465e-15, 1, 0, 0, -4.85723e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-6.81823e-18, 6.81865e-18, 9.98052e-18, 0.92388, -7.12185e-18, -5.13878e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 1.38304e-17, 1.38362e-17, -1.38202e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [7.97973e-17, -6.32979e-17, 0.0584, 1, 6.77626e-21, 1.38356e-17, -1.38676e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [7.97973e-17, -6.32979e-17, 0.0584, 1, 6.77626e-21, 1.38356e-17, -1.38676e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-2.15913e-17, 0.04, -1.10426e-15, 1, -6.77626e-21, 1.38346e-17, -1.73506e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [6.54418e-18, -0.04, 8.00264e-16, 1, 0, 1.38351e-17, 1.73506e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.73569e-16, 5.47691e-21, 1.79649e-16, -1.03445e-13, 0, -1.69407e-21, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 5.32908e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 5.55112e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [2.22045e-16, 2.63678e-16, -0.15, 1, 9.71445e-17, -8.32667e-17, 2.22045e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [4.23273e-16, 0.02, -0.2, 1, -2.15106e-16, 8.32667e-17, 1.11022e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -1.11022e-16, -5.55112e-17, 1.11022e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [3.61975e-18, -5.75905e-18, -1.37078e-18, 1, -2.77556e-17, -4.85723e-17, 3.05311e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [4.16334e-17, -4.85723e-17, -0.04, 1, 5.55112e-17, 8.32667e-17, 5.55112e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-1.02782e-16, 2.25514e-17, 0.01, 1, -2.77556e-17, -1.45717e-16, -7.63278e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-9.71445e-17, -2.77556e-17, 0.2105, 5.55112e-17, 0.92388, 0.382683, 8.32667e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 3.12047e-17, -1.11022e-16], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [5.20417e-17, 0.008, 0.045, 1, 6.77626e-21, 1.38335e-17, -1.73574e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.9082e-16, -0.008, 0.045, 1, 0, 1.38358e-17, -1.7354e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-0.00416016, 0.43, 0.07, 1, 0, 0, -0.000122148], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [0, 0, 0.05, 1, 0, -0, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True, is_place: True } }
base2(table): { pose: [-0.0132477, 0.386589, 0.190051, 1, 2.85736e-05, 1.06539e-05, 1.72392e-06], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base2_handle(base2): { pose: [-2.61521e-19, -7.97905e-19, 0.05, 1, 0, 4.0864e-22, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
base3(table): { pose: [0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
base3_handle(base3): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [0.208641, 0.299948, 0.13, 0.955089, 0, 0, -0.296319], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [-0.224192, 0.300054, 0.13, 0.999107, 0, 0, -0.0422406], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.0241284, 0.560005, 0.13, 0.715468, 0, 0, -0.698646], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [-0.4, 0, 0.1], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [0.5, 0, 0.1], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl6(table): { pose: [0.4, 0, 0.1], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl7(table): { pose: [0.5, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], cont act: 1, logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl8(table): { pose: [0.4, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
place_base1(table): { pose: [0, 0.45, 0.05], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base1(base1): { pose: [0.2, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base1(base1): { pose: [-0.2, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base1(base1): { pose: [-0.2, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base1(base1): { pose: [0.2, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
back_base1(base1): { pose: [-3.65918e-19, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
front_base1(base1): { pose: [3.65918e-19, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
left_base1(base1): { pose: [-0.2, -1.34034e-17, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base1(base1): { pose: [0.2, 1.34034e-17, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base2(base2): { pose: [0.2, 0.15, 0.02, 1, 0, 4.0864e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontright_base2(base2): { pose: [-0.2, 0.15, 0.02, 1, 0, 4.0864e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backleft_base2(base2): { pose: [-0.2, -0.15, 0.02, 1, 0, 4.0864e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backright_base2(base2): { pose: [0.2, -0.15, 0.02, 1, 0, 4.0864e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
back_base2(base2): { pose: [-5.66718e-19, -0.15, 0.02, 1, 0, 4.0864e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
front_base2(base2): { pose: [-1.03195e-18, 0.15, 0.02, 1, 0, 4.0864e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
left_base2(base2): { pose: [-0.2, 3.11136e-18, 0.02, 1, 0, 4.0864e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
right_base2(base2): { pose: [0.2, 4.06641e-17, 0.02, 1, 0, 4.0864e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontleft_base3(base3): { pose: [0.2, 0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontright_base3(base3): { pose: [-0.2, 0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backleft_base3(base3): { pose: [-0.2, -0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backright_base3(base3): { pose: [0.2, -0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
back_base3(base3): { pose: [0, -0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
front_base3(base3): { pose: [0, 0.15, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
left_base3(base3): { pose: [-0.2, 0, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
right_base3(base3): { pose: [0.2, 0, 0.02], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }