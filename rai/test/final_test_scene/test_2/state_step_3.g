world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.999581, -0, 0, 0.0289475], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 0, 0] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.809832, 0, -5.55112e-17, 0.586662], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-2.08167e-16, -0.316, -1.38252e-16, 0.707107, 0.707107, -5.55112e-17, -2.35922e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [3.78938e-17, 4.95714e-17, -5.96936e-16, 0.998918, 2.77556e-17, 1.11022e-16, -0.0465012], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -1.7434e-16, 6.93889e-17, 0.707107, 0.707107, 9.02056e-17, -8.32667e-17] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.4182e-16, -3.84995e-17, 5.95937e-17, 0.933213, 1.38778e-17, 7.45931e-17, -0.359324], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 9.88792e-17, 0.707107, -0.707107, 1.52656e-16, 0] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-7.3585e-17, 1.78202e-16, -1.48103e-16, 0.999025, -2.77556e-17, 2.77556e-17, 0.044147], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [1.2398e-16, 4.60299e-19, -6.01627e-18, 0.707107, 0.707107, 2.77556e-17, 0] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.42777, 0, 1.11022e-16, 0.903888], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.57353e-16, 1.12676e-16, 0.707107, 0.707107, -1.11022e-16, -1.11022e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-3.96898e-16, 2.48486e-16, -2.2382e-16, 0.933287, 4.85723e-17, 0, 0.359131], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [1.38778e-17, -7.63278e-17, 0.107, 1, -1.38778e-17, -1.38778e-17, 6.93889e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [5.96439e-17, 3.74101e-17, -1.72288e-15, 1, 3.46945e-18, -6.93889e-18, 7.28584e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 0, -2.77556e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -2.77556e-17, 4.16334e-17, -2.60209e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [4.16334e-17, -3.49113e-17, 0.0584, 1, -1.38778e-17, 0, -2.77556e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [4.16334e-17, -3.49113e-17, 0.0584, 1, -1.38778e-17, 0, -2.77556e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [3.06558e-17, 0.04, -9.62338e-16, 1, 1.38778e-17, 0, 8.67362e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [1.08718e-16, -0.04, -3.79904e-16, 1, 2.77556e-17, 0, -2.498e-16], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.29701e-16, 3.37244e-16, -5.63768e-17, -1.03723e-13, 0, 0, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 3.55272e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.94289e-16, 2.11636e-16, -0.15, 1, -8.32667e-17, 0, -1.11022e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.80411e-16, 0.02, -0.2, 1, 5.55112e-17, 2.77556e-17, -2.77556e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 5.55112e-17, 1.11022e-16, -2.498e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-1.39611e-18, 3.17459e-18, 9.96271e-20, 1, -5.55112e-17, 1.17961e-16, 0], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [9.35124e-17, -1.06848e-16, -0.04, 1, 1.38778e-16, 0, -8.32667e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [3.03577e-18, 1.17094e-17, 0.01, 1, -1.38778e-17, -1.38778e-17, 6.93889e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [6.245e-17, -2.08167e-16, 0.2105, 2.53703e-17, 0.92388, 0.382683, 6.76542e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -1.11022e-16, -9.71445e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [2.91434e-16, 0.008, 0.045, 1, 1.38778e-17, 1.38778e-17, 8.67362e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.83881e-16, -0.008, 0.045, 1, -2.77556e-17, 0, 8.50015e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [0.0147682, 0.435, 0.07, 0.999847, 0, 0, 0.0174991], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [0, 0, 0.05, 1, -0, 0, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True, is_place: True } }
base2(table): { pose: [-0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base2_handle(base2): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
base3(table): { pose: [0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
base3_handle(base3): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [0.204379, 0.306556, 0.13, 0.987328, 0, 0, -0.158696], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [-0.195376, 0.292559, 0.13, 0.998069, 0, 0, -0.0621097], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.00494665, 0.569392, 0.13, 0.957888, 0, 0, -0.287141], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [-0.4, 0, 0.1], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [0.5, 0, 0.1], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl6(table): { pose: [0.4, 0, 0.1], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl7(table): { pose: [0.5, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], cont act: 1, logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl8(table): { pose: [0.4, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
place_base1(table): { pose: [0, 0.45, 0.05], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base1(base1): { pose: [0.2, 0.15, 0.02, 1, -0, 0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base1(base1): { pose: [-0.2, 0.15, 0.02, 1, -0, 0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base1(base1): { pose: [-0.2, -0.15, 0.02, 1, -0, 0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base1(base1): { pose: [0.2, -0.15, 0.02, 1, -0, 0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
back_base1(base1): { pose: [1.73472e-18, -0.15, 0.02, 1, -0, 0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
front_base1(base1): { pose: [0, 0.15, 0.02, 1, -0, 0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
left_base1(base1): { pose: [-0.2, 6.07153e-18, 0.02, 1, -0, 0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base1(base1): { pose: [0.2, -6.07153e-18, 0.02, 1, -0, 0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
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