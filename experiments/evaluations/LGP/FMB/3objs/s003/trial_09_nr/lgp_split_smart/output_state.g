world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, 0, 0.05], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [1, 0, 0, 9.97265e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 1.38786e-17, -1.38786e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.731786, 8.15218e-17, 0, -0.681535], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [1.35308e-16, -0.316, -2.70549e-16, 0.707107, 0.707107, -6.1249e-17, 8.93184e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-1.97829e-16, -1.43451e-16, -3.47993e-16, 1, -4.34087e-17, -2.3772e-17, -1.95891e-05], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, 1.12528e-17, -1.04083e-17, 0.707107, 0.707107, -8.44322e-18, -1.11022e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-6.39709e-26, -3.37033e-26, -1.69407e-21, 0.31535, 2.77556e-17, 5.55112e-17, -0.948975], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, -3.78378e-16, 0.707107, -0.707107, 8.08679e-17, -1.37158e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [3.5074e-16, 6.93933e-17, -6.86812e-16, 1, 2.66206e-17, -1.06837e-16, -2.17289e-06], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-3.7471e-18, 1.82113e-17, -5.83984e-18, 0.707107, 0.707107, -9.13068e-17, -5.55112e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.731588, -1.249e-16, 5.55112e-17, 0.681747], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, 6.93889e-18, -4.15055e-17, 0.707107, 0.707107, -8.32667e-17, -8.32667e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.82675e-17, 3.80992e-17, -9.98278e-18, 1, -5.37797e-17, 0, -0.000248914], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [9.71445e-17, -5.64802e-18, 0.107, 1, 2.38524e-18, 0, 7.63177e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [2.67492e-17, -9.73885e-18, -1.75658e-15, 1, 6.77626e-21, 0, 2.08743e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, -8.38901e-18, 0, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -1.38778e-17, 0, 2.77556e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [6.93889e-18, 3.46945e-18, 0.0584, 1, 0, 0, -7.97973e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [6.93889e-18, 3.46945e-18, 0.0584, 1, 0, 0, -7.97973e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [7.1991e-17, 0.04, -9.93997e-16, 1, 1.38778e-17, 0, -1.35308e-16], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [6.15827e-17, -0.04, 5.77663e-16, 1, 0, 0, 3.1225e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-1.64417e-16, 1.98684e-16, 1.32986e-17, -1.03351e-13, 4.16334e-17, 0, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 0, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-1.26635e-16, -8.71226e-19, -0.15, 1, -2.60209e-18, -4.7594e-18, 1.38812e-17], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [3.60822e-16, 0.02, -0.2, 1, -1.04083e-17, 8.11482e-18, -6.93872e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -1.11022e-16, -1.11022e-16, 1.38778e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [1, -2.08167e-16, -2.77556e-17, -1.94289e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [-4.03786e-17, -3.94903e-16, -0.04, 1, 0, -1.38778e-17, -5.55112e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [5.0307e-17, 9.95348e-18, 0.01, 1, 2.38524e-18, 0, 7.63177e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [1.38778e-17, -3.30004e-18, 0.2105, 1.38778e-17, 0.92388, 0.382683, 5.18215e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -2.77556e-17, -8.32667e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [1.85615e-16, 0.008, 0.045, 1, 1.38778e-17, 0, -7.63278e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.83881e-16, -0.008, 0.045, 1, 0, 0, -7.97973e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base_board(table): { pose: [0.45, 0, 0.075, 0.707107, 0.707107, 0, 0], joint: rigid, shape: mesh, color: [0.75, 0.75, 0.75, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", mass: 0.5, inertia: [0.00281664, 0.00530266, 0.00273272], logical: { is_object: True, is_place: True } }
Table_Left(base_board): { pose: [0, 1.77636e-17, 0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(base_board): { pose: [0, -1.77636e-17, -0.08, 0.707107, -0.707107, -0, -0], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Front(base_board): { pose: [0.059, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Back(base_board): { pose: [-0.061, 0, 0, 0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Center(base_board): { pose: [0.5, -0.5, -0.5, -0.5], shape: ssBox, size: [0.02, 0.02, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
shape_3_1(table): { pose: [0.45, -0.08, 0.088, 1, -4.83416e-09, 4.3245e-09, -4.6644e-10], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0.005], color: [0.2, 0.2, 0.9], logical: { is_object: True, is_box: True } }
shape_3_1_mesh(shape_3_1): { pose: [-1.43607e-16, 0.001, 0.0325, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [0.2, 0.8, 1, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_1.obj", contact: 1, mass: 0.1, inertia: [0.000230943, -2.88191e-22, 5.73441e-22, 0.00016058, -2.55738e-12, 9.9969e-05], logical: { is_object: True, is_box: True } }
shape_3_1_handle(shape_3_1): { pose: [2.04651e-17, -3.38275e-19, 0.065, 1, 0, 4.42366e-26, 0], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_3_2(table): { pose: [0.450155, -1.81696e-06, 0.0878878, 0.707022, -5.85225e-06, 5.69259e-05, -0.707192], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0.005], color: [0.2, 0.2, 0.9], logical: { is_object: True, is_box: True } }
shape_3_2_mesh(shape_3_2): { pose: [-9.89334e-18, 0.001, 0.0325, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [0.2, 0.8, 1, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_2.obj", contact: 1, mass: 0.1, inertia: [0.000230943, -2.88191e-22, 5.73441e-22, 0.00016058, -2.55738e-12, 9.9969e-05], logical: { is_object: True, is_box: True } }
shape_3_2_handle(shape_3_2): { pose: [-1.01644e-20, 1.5488e-17, 0.065], shape: marker, size: [0.03], color: [1, 1, 0] }
shape_3_3(table): { pose: [0.45, 0.08, 0.088, 1, -1.16176e-08, 2.17092e-09, -4.27825e-10], joint: rigid, shape: ssBox, size: [0.025, 0.025, 0.025, 0.005], color: [0.2, 0.2, 0.9], logical: { is_object: True, is_box: True } }
shape_3_3_mesh(shape_3_3): { pose: [-1.08685e-17, 0.001, 0.0325, 0.5, 0.5, 0.5, 0.5], joint: rigid, shape: mesh, color: [0.2, 0.8, 1, 1], mesh: "/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_3.obj", contact: 1, mass: 0.1, inertia: [0.000230943, -2.88191e-22, 5.73441e-22, 0.00016058, -2.55738e-12, 9.9969e-05], logical: { is_object: True, is_box: True } }
shape_3_3_handle(shape_3_3): { pose: [-1.9608e-17, 5.88899e-18, 0.065, 1, 0, 1.34608e-25, 0], shape: marker, size: [0.03], color: [1, 1, 0] }