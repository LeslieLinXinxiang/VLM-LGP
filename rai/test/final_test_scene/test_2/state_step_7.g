world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.991041, -0, 0, -0.133562], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 5.55112e-17, -5.55112e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.874706, 0, 5.55112e-17, 0.484654], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-2.77556e-16, -0.316, -3.63148e-16, 0.707107, 0.707107, -3.33067e-16, 5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [6.61579e-17, -8.92012e-18, 1.05791e-16, 0.995177, 2.77556e-17, 0, 0.0980915], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.76435e-16, 9.02056e-17, 0.707107, 0.707107, -3.60822e-16, -2.08167e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-1.8197e-17, -1.85909e-17, 3.18623e-17, 0.955407, -8.32667e-17, -9.36751e-17, -0.295293], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -1.42247e-16, 0.707107, -0.707107, -2.08167e-17, -6.10623e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [2.23287e-16, -8.73676e-19, 5.74283e-17, 0.945747, 0, 1.11022e-16, 0.324903], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [1.50394e-17, 1.12783e-17, -5.91479e-17, 0.707107, 0.707107, 2.02963e-16, 7.80626e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [2.02875e-17, -4.35083e-18, -1.84353e-17, 0.739448, 2.77556e-17, -7.97973e-17, 0.673213], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -2.70617e-16, 2.06432e-16, 0.707107, 0.707107, 2.77556e-16, -1.249e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.23788e-16, -9.38829e-17, -2.10774e-16, 0.897109, -4.16334e-17, -1.38778e-17, -0.44181], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-2.98372e-16, -4.85723e-17, 0.107, 1, -2.77556e-17, 7.63278e-17, 2.91434e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [3.71531e-17, 2.82167e-16, -2.18002e-15, 1, -2.77556e-17, 4.16334e-17, 6.93889e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [6.56512e-18, -6.58367e-18, 1.03028e-17, 0.92388, 5.13912e-17, -5.96311e-18, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 4.0766e-17, -6.18181e-17, 3.44234e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [9.02056e-17, 2.15756e-17, 0.0584, 1, -4.17418e-17, -6.28517e-18, -8.67362e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [9.02056e-17, 2.15756e-17, 0.0584, 1, -4.17418e-17, -6.28517e-18, -8.67362e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-3.69984e-17, 0.04, -1.2076e-15, 1, 1.39862e-17, -6.34454e-18, 2.08709e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [2.27222e-16, -0.04, 7.55533e-16, 1, -1.37694e-17, -6.33984e-18, -2.07625e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-8.58452e-17, 5.50481e-17, 2.36433e-16, -1.03376e-13, 5.55112e-17, 4.15859e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.06582e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [2.08167e-16, 2.5327e-16, -0.15, 1, -8.32667e-17, 0, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.10675e-15, 0.02, -0.2, 1, 1.66533e-16, -5.55112e-17, -1.11022e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 9.71445e-17, 0, -1.11022e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-2.28093e-18, -9.81145e-18, 1.5446e-17, 1, 7.63278e-17, -7.71952e-17, -2.70617e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [5.11743e-17, -6.245e-17, -0.04, 1, 1.11022e-16, 8.32667e-17, 8.32667e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [1.43115e-17, 9.58435e-17, 0.01, 1, -2.77556e-17, 7.63278e-17, 2.91434e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-2.35922e-16, -1.52656e-16, 0.2105, -1.38778e-17, 0.92388, 0.382683, -1.11022e-16], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 5.65411e-17, -2.22045e-16], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-3.81639e-17, 0.008, 0.045, 1, 0, -6.33323e-18, 2.07625e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.00614e-16, -0.008, 0.045, 1, -2.77556e-17, -6.34786e-18, -3.1225e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-0.00416016, 0.43, 0.07, 1, 0, 0, -0.000122148], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [0, 0, 0.05, 1, 0, -0, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True, is_place: True } }
base2(table): { pose: [-0.0141408, 0.4298, 0.210044, 1, 9.88547e-05, 2.59465e-05, 4.05521e-05], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base2_handle(base2): { pose: [-2.51145e-19, 2.56549e-17, 0.05, 1, 0, -1.75362e-22, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
base3(table): { pose: [-0.00771705, 0.471162, 0.349975, 1, 0.000799601, 4.58341e-06, -0.000482534], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
base3_handle(base3): { pose: [-2.24464e-20, 8.68717e-18, 0.05, 1, 4.1359e-25, -5.29396e-22, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [0.175808, 0.299956, 0.14, 0.944409, 0, 0, -0.328773], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [-0.224192, 0.300054, 0.14, 0.99641, 0, 0, -0.0846606], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.184128, 0.560044, 0.14, 0.794671, 0, 0, -0.607041], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [0.175872, 0.559956, 0.14, 0.650244, 0, 0, -0.759726], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [-0.194148, 0.559772, 0.280079, 0.891343, 9.98766e-05, -2.16826e-05, 0.45333], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl6(table): { pose: [0.165852, 0.559801, 0.28006, 0.698719, 8.76358e-05, -5.25874e-05, 0.715396], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl7(table): { pose: [0.00587338, 0.299788, 0.280017, 0.92328, 0.000101238, -1.40127e-05, 0.384127], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], cont act: 1, logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl8(table): { pose: [0.4, 0.2, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
place_base1(table): { pose: [0, 0.45, 0.05], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base1(base1): { pose: [0.2, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base1(base1): { pose: [-0.2, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base1(base1): { pose: [-0.2, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base1(base1): { pose: [0.2, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
back_base1(base1): { pose: [-3.65918e-19, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
front_base1(base1): { pose: [3.65918e-19, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
left_base1(base1): { pose: [-0.2, -1.34034e-17, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base1(base1): { pose: [0.2, 1.34034e-17, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base2(base2): { pose: [0.2, 0.15, 0.02, 1, 0, -1.75362e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontright_base2(base2): { pose: [-0.2, 0.15, 0.02, 1, 0, -1.75362e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backleft_base2(base2): { pose: [-0.2, -0.15, 0.02, 1, 0, -1.75362e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backright_base2(base2): { pose: [0.2, -0.15, 0.02, 1, 0, -1.75362e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
back_base2(base2): { pose: [-1.82959e-19, -0.15, 0.02, 1, 0, -1.75362e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
front_base2(base2): { pose: [-6.61046e-18, 0.15, 0.02, 1, 0, -1.75362e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
left_base2(base2): { pose: [-0.2, 5.64971e-17, 0.02, 1, 0, -1.75362e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
right_base2(base2): { pose: [0.2, -2.64782e-18, 0.02, 1, 0, -1.75362e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontleft_base3(base3): { pose: [0.2, 0.15, 0.02, 1, 4.1359e-25, -5.29396e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontright_base3(base3): { pose: [-0.2, 0.15, 0.02, 1, 4.1359e-25, -5.29396e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backleft_base3(base3): { pose: [-0.2, -0.15, 0.02, 1, 4.1359e-25, -5.29396e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backright_base3(base3): { pose: [0.2, -0.15, 0.02, 1, 4.1359e-25, -5.29396e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
back_base3(base3): { pose: [6.46471e-19, -0.15, 0.02, 1, 4.1359e-25, -5.29396e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
front_base3(base3): { pose: [-1.32799e-19, 0.15, 0.02, 1, 4.1359e-25, -5.29396e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
left_base3(base3): { pose: [-0.2, 2.57498e-18, 0.02, 1, 4.1359e-25, -5.29396e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
right_base3(base3): { pose: [0.2, 4.33681e-18, 0.02, 1, 4.1359e-25, -5.29396e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }