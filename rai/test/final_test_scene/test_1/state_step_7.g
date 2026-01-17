world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.990843, -0, 0, -0.135017], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 2.22045e-16, -2.22045e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.955562, 0, 5.55112e-17, 0.294792], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-2.77556e-16, -0.316, -2.81794e-16, 0.707107, 0.707107, -1.11022e-16, 1.94289e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-4.87926e-17, 5.20511e-18, -3.32717e-17, 0.993587, 5.55112e-17, 0, 0.11307], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -4.51895e-16, 2.08167e-17, 0.707107, 0.707107, -1.52656e-16, 2.498e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-4.0606e-17, -2.53211e-17, 1.08353e-17, 0.796989, -1.38778e-17, 5.55112e-17, -0.603993], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -4.77049e-17, 0.707107, -0.707107, -3.26128e-16, 3.88578e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [2.45385e-17, 5.03332e-17, -5.50219e-17, 0.988996, 1.11022e-16, 5.55112e-17, 0.147945], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [1.18889e-17, 2.50562e-17, -1.10207e-18, 0.707107, 0.707107, 2.77556e-17, 2.77556e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.601511, 5.55112e-17, 8.32667e-17, 0.798865], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -1.36176e-16, 4.68809e-16, 0.707107, 0.707107, 2.77556e-17, 1.38778e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.17245e-18, -1.25281e-17, 5.56064e-18, 0.888667, -1.38778e-17, -4.16334e-17, -0.458554], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [6.93889e-18, 1.63064e-16, 0.107, 1, -1.38778e-17, -6.93889e-18, -1.21431e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-1.51918e-16, 3.70405e-17, -2.24096e-15, 1, -4.16334e-17, -2.42861e-17, -1.73472e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-3.24224e-17, 1.11548e-16, -4.37421e-17, 0.92388, -1.9082e-17, 6.07153e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 1.12757e-17, 5.58195e-19, -1.48753e-16], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [5.89806e-17, -4.68375e-17, 0.0584, 1, -1.47451e-17, -4.20128e-19, -2.77556e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [5.89806e-17, -4.68375e-17, 0.0584, 1, -1.47451e-17, -4.20128e-19, -2.77556e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [1.43847e-16, 0.04, -1.02468e-15, 1, -1.38778e-17, -2.83248e-17, -2.77556e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-1.24765e-16, -0.04, 1.03303e-15, 1, 1.47451e-17, 2.7161e-17, 2.75387e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.93955e-16, 5.31081e-17, 1.58287e-16, -1.03394e-13, -2.77556e-17, -4.1796e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.06582e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [4.57967e-16, 3.01842e-16, -0.15, 1, 1.11022e-16, -2.08167e-16, 1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [9.50628e-16, 0.02, -0.2, 1, 1.11022e-16, 0, 1.94289e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -1.94289e-16, -2.77556e-16, 1.66533e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -6.93889e-17, 2.08167e-17, 1.66533e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.47198e-17, -6.8695e-16, -0.04, 1, 2.77556e-17, 5.55112e-17, 5.55112e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-1.73472e-18, -6.02816e-17, 0.01, 1, -1.38778e-17, -6.93889e-18, -1.21431e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [0, 1.38778e-17, 0.2105, -8.32667e-17, 0.92388, 0.382683, 2.77556e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -1.09504e-17, 1.11022e-16], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.249e-16, 0.008, 0.045, 1, -2.68882e-17, -5.62227e-17, -2.08167e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.38778e-17, -0.008, 0.045, 1, 0, -4.31987e-19, -2.73219e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-0.00416016, 0.43, 0.07, 1, 0, 0, -0.000122148], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [0, 0, 0.05, 1, 0, -0, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True, is_place: True } }
base2(table): { pose: [-0.00593524, 0.429807, 0.190044, 1, 9.42959e-05, 2.72777e-05, 3.84034e-05], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base2_handle(base2): { pose: [3.36272e-19, -1.01559e-17, 0.05, 1, 0, -1.06458e-21, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
base3(table): { pose: [0.00411386, 0.419696, 0.310032, 1, 6.26232e-05, 1.44245e-05, 1.3272e-05], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
base3_handle(base3): { pose: [2.40346e-19, 8.88876e-18, 0.05, 1, 0, -5.67653e-23, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [0.208641, 0.299948, 0.13, 0.955089, 0, 0, -0.296319], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [-0.224192, 0.300054, 0.13, 0.999107, 0, 0, -0.0422406], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.184128, 0.560044, 0.13, 0.79097, 0, 0, -0.611854], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [0.175872, 0.559956, 0.13, 0.641183, 0, 0, -0.767388], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [0.214078, 0.299813, 0.250007, 0.96324, 9.81575e-05, 9.46777e-07, 0.268643], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl6(table): { pose: [-0.185919, 0.259782, 0.250022, 0.85046, 9.4545e-05, -2.64012e-05, 0.52604], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl7(table): { pose: [-0.185942, 0.559782, 0.250078, 0.995478, 9.646e-05, 1.82007e-05, 0.0949925], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], cont act: 1, logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl8(table): { pose: [0.174058, 0.55981, 0.250059, 0.976588, 9.79559e-05, 6.35788e-06, 0.21512], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
place_base1(table): { pose: [0, 0.45, 0.05], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base1(base1): { pose: [0.2, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base1(base1): { pose: [-0.2, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base1(base1): { pose: [-0.2, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base1(base1): { pose: [0.2, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
back_base1(base1): { pose: [-3.65918e-19, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
front_base1(base1): { pose: [3.65918e-19, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
left_base1(base1): { pose: [-0.2, -1.34034e-17, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base1(base1): { pose: [0.2, 1.34034e-17, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base2(base2): { pose: [0.2, 0.15, 0.02, 1, 0, -1.06458e-21, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontright_base2(base2): { pose: [-0.2, 0.15, 0.02, 1, 0, -1.06458e-21, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backleft_base2(base2): { pose: [-0.2, -0.15, 0.02, 1, 0, -1.06458e-21, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backright_base2(base2): { pose: [0.2, -0.15, 0.02, 1, 0, -1.06458e-21, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
back_base2(base2): { pose: [-2.85027e-19, -0.15, 0.02, 1, 0, -1.06458e-21, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
front_base2(base2): { pose: [-2.22748e-18, 0.15, 0.02, 1, 0, -1.06458e-21, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
left_base2(base2): { pose: [-0.2, -1.38977e-16, 0.02, 1, 0, -1.06458e-21, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
right_base2(base2): { pose: [0.2, -8.00823e-17, 0.02, 1, 0, -1.06458e-21, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontleft_base3(base3): { pose: [0.2, 0.15, 0.02, 1, 0, -5.67653e-23, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontright_base3(base3): { pose: [-0.2, 0.15, 0.02, 1, 0, -5.67653e-23, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backleft_base3(base3): { pose: [-0.2, -0.15, 0.02, 1, 0, -5.67653e-23, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backright_base3(base3): { pose: [0.2, -0.15, 0.02, 1, 0, -5.67653e-23, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
back_base3(base3): { pose: [3.31402e-20, -0.15, 0.02, 1, 0, -5.67653e-23, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
front_base3(base3): { pose: [-5.35219e-19, 0.15, 0.02, 1, 0, -5.67653e-23, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
left_base3(base3): { pose: [-0.2, -1.51373e-17, 0.02, 1, 0, -5.67653e-23, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
right_base3(base3): { pose: [0.2, -2.21597e-17, 0.02, 1, 0, -5.67653e-23, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }