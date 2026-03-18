world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.982448, -0, 0, 0.186538], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -1.66533e-16, 1.66533e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.995305, 0, 8.32667e-17, 0.0967855], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-1.17961e-16, -0.316, -6.57314e-16, 0.707107, 0.707107, 1.66533e-16, -5.55112e-17] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-2.61649e-16, 3.54201e-16, -7.30224e-16, 0.984382, 2.08167e-17, -1.38778e-17, -0.176046], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.98336e-16, 1.21431e-17, 0.707107, 0.707107, 2.42861e-16, 1.11022e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-1.09182e-16, -1.99012e-17, -3.03966e-18, 0.15613, 0, -1.66533e-16, -0.987737], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 1.69309e-15, 0.707107, -0.707107, 9.88792e-17, 4.68375e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-1.71008e-16, 4.02719e-16, -5.65775e-16, 0.9723, -1.21431e-16, -3.46945e-17, 0.233738], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-2.32398e-17, 1.38019e-18, -1.08789e-16, 0.707107, 0.707107, -5.55112e-17, 1.52656e-16] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.0736714, 2.77556e-17, 0, 0.997283], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -4.808e-16, 3.38721e-16, 0.707107, 0.707107, -2.08102e-16, 1.94835e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.10782e-16, 9.05012e-17, 1.98763e-20, 0.821749, 7.21672e-18, -1.04761e-17, -0.569849], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-1.24006e-18, 1.10792e-18, 0.107, 1, -1.0842e-19, 1.21973e-19, -2.88164e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-3.02582e-19, -3.38638e-19, -3.10862e-15, 1, -4.06576e-20, -5.42101e-20, 1.00414e-16] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 1.49078e-19, 6.77626e-21, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 0, 4.50516e-20, 1.63368e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [8.60395e-18, -9.41901e-19, 0.0584, 1, 0, 4.87044e-21, -1.43065e-19] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [8.60395e-18, -9.41901e-19, 0.0584, 1, 0, 4.87044e-21, -1.43065e-19] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-1.56161e-17, 0.04, -1.84183e-15, 1, 0, -4.44692e-21, -1.43065e-19], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [1.573e-17, -0.04, 1.1757e-15, 1, 0, 4.02341e-21, -1.43065e-19], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.75541e-17, 1.59653e-17, -2.55462e-21, -1.03419e-13, -3.72694e-20, -2.15927e-20, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 7.10544e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 2.22045e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-4.85723e-17, 1.76942e-16, -0.15, 1, -6.93889e-18, 0, 2.77556e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [2.28983e-16, 0.02, -0.2, 1, 6.93889e-18, -3.1225e-17, 1.7434e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -1.11022e-16, 1.11022e-16, -2.77556e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [6.23634e-19, 1.08557e-18, 1.7302e-17, 1, -2.77556e-16, 0, 0], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [2.40017e-16, -3.47461e-16, -0.04, 1, 2.498e-16, -1.11022e-16, -5.55112e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-3.33307e-19, -2.91506e-18, 0.01, 1, -1.0842e-19, 1.21973e-19, -2.88164e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-3.76591e-17, 7.1083e-18, 0.2105, 2.34052e-17, 0.92388, 0.382683, 5.65682e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 3.46945e-18, 1.07573e-18], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [7.35653e-18, 0.008, 0.045, 1, 0, -5.29396e-21, -1.43065e-19], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.8254e-17, -0.008, 0.045, 1, 0, -4.44692e-21, -1.43064e-19], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
rect_1(table): { pose: [-0.0500831, 0.0502108, 0.0682783, 0.999968, -0.000322171, -7.07762e-05, -0.00802086], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0, 0.9, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_2(table): { pose: [0.0500052, 0.0499991, 0.0666875, 1, -2.28637e-05, 1.51571e-05, -0.000187691], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0, 0.7, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_3(table): { pose: [0.45, -0.1, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0, 0.5, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_4(table): { pose: [0.3, 0.1, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.2, 0.3, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_5(table): { pose: [0.45, 0, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.9, 0, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_6(table): { pose: [0.3, 0.2, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.7, 0, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_7(table): { pose: [0.45, 0.1, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.5, 0, 0.8], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_8(table): { pose: [0.45, 0.2, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.3, 0, 0.7], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
cyl_1(table): { pose: [-0.3, -0.1, 0.065], joint: rigid, shape: cylinder, size: [0.03, 0.015], color: [0, 0.8, 0], contact: 1, mass: 0.2, inertia: [4.31924e-05, 4.31924e-05, 3.66427e-05], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl_2(table): { pose: [-0.3, 0, 0.065], joint: rigid, shape: cylinder, size: [0.03, 0.015], color: [0.4, 1, 0.2], contact: 1, mass: 0.2, inertia: [4.31924e-05, 4.31924e-05, 3.66427e-05], logical: { is_object: True, is_cylinder: True, is_place: True } }
cube_1(table): { pose: [-0.0650934, 0.0504895, 0.0994109, 0.999964, -3.26992e-05, -6.64873e-06, -0.00843022], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 0.5, 0], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [-0.0350915, 0.0500007, 0.0993898, 0.999967, -2.75022e-05, 2.25003e-06, -0.00811501], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 0.8, 0], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [0.0350037, 0.0500204, 0.0978004, 1, -2.42508e-05, 5.06364e-06, -0.000469502], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.3, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [-0.3, 0.2, 0.065], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.8, 0.1, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
tri_1(table): { pose: [-0.45, 0.1, 0.05], joint: rigid, shape: mesh, color: [1, 0.4, 0.7], mesh: "/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", contact: 1, mass: 0.2, inertia: [3.61846e-05, 3.20675e-05, 5.23466e-05], logical: { is_object: True, is_place: True } }
Base_Center(table): { pose: [0, 0.05, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Left(table): { pose: [-0.08, 0.05, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Right(table): { pose: [0.08, 0.05, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Top(table): { pose: [0, -0.03, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Bottom(table): { pose: [0, 0.13, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Table_Left(table): { pose: [-0.05, 0.05, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.05, 0.05, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Rect_1_Left(rect_1): { pose: [-0.015, 1.59242e-19, 0.0155, 1, 0, 2.96462e-21, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_1_Right(rect_1): { pose: [0.015, 1.8589e-17, 0.0155, 1, 0, 2.96462e-21, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_2_Left(rect_2): { pose: [-0.015, -7.44891e-18, 0.0155, 1, -4.1359e-25, -9.5953e-23, 2.71051e-20], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_2_Right(rect_2): { pose: [0.015, 1.92084e-17, 0.0155, 1, -4.1359e-25, -9.5953e-23, 2.71051e-20], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_3_Left(rect_3): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_3_Right(rect_3): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_4_Left(rect_4): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_4_Right(rect_4): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_5_Left(rect_5): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_5_Right(rect_5): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_6_Left(rect_6): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_6_Right(rect_6): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_7_Left(rect_7): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_7_Right(rect_7): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_8_Left(rect_8): { pose: [-0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_8_Right(rect_8): { pose: [0.015, 0, 0.0155], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }