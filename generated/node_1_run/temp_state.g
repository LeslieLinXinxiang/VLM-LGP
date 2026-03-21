world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.683626, 0, 0, 0.729833], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 7.28584e-17, -7.28584e-17] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.853038, 0, 1.38778e-17, 0.521849], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [5.55112e-16, -0.316, 1.2692e-16, 0.707107, 0.707107, -1.66533e-16, -4.44089e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [5.13051e-17, 1.87931e-16, -3.87325e-16, 0.77139, -1.21431e-16, 0, -0.636363], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -3.29597e-16, -1.0842e-16, 0.707107, 0.707107, 3.88578e-16, 2.22045e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.24629e-16, -3.64054e-17, -2.45264e-17, 0.272631, -5.55112e-17, -2.08167e-17, -0.962119], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 8.60423e-16, 0.707107, -0.707107, -2.77556e-17, 0] }
l_panda_joint5(l_panda_joint5_origin): { pose: [1.05563e-17, 1.15688e-16, -4.47369e-16, 0.744268, -1.38778e-17, 0, 0.667881], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-1.76605e-16, -3.69867e-18, -1.40149e-16, 0.707107, 0.707107, 2.77556e-17, 8.32667e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [2.10773e-18, -3.88912e-18, 5.34607e-18, 0.511137, 0, 6.245e-17, 0.859499], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -2.80524e-16, 2.41914e-16, 0.707107, 0.707107, 3.67599e-16, 7.52436e-17] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-4.35956e-17, 7.18983e-17, -1.11071e-16, 0.682757, 2.81622e-17, 3.2255e-17, -0.730645], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [1.90921e-18, -3.57787e-18, 0.107, 1, 0, 2.71051e-20, -3.81202e-17] }
l_panda_joint8(l_panda_joint8_origin): { pose: [1.97895e-18, 1.53563e-18, -3.44169e-15, 1, -1.0842e-19, 5.42101e-20, 1.7391e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [0.92388, 0, 5.42101e-20, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, -5.42101e-20, 2.20229e-20, 7.73802e-18], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-3.09675e-18, -3.65918e-18, 0.0584, 1, 0, 2.4564e-20, -2.67032e-18] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-3.09675e-18, -3.65918e-18, 0.0584, 1, 0, 2.4564e-20, -2.67032e-18] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [5.20498e-18, 0.04, -1.94126e-15, 1, 0, 2.28699e-20, -2.67032e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-5.81558e-18, -0.04, 1.27512e-15, 1, 0, 2.28699e-20, 4.26857e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [1.15891e-17, -2.11301e-17, -2.64431e-20, -1.03423e-13, 0, 1.10961e-19, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.06582e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, 0, 0, -1.04083e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [-2.87964e-16, 5.20417e-16, -0.15, 1, 2.22045e-16, -1.11022e-16, 2.22045e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.60982e-15, 0.02, -0.2, 1, 2.77556e-17, 6.93889e-18, 2.91434e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, 5.55112e-17, 8.32667e-17, -2.77556e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-3.2984e-17, -3.76031e-17, -2.40738e-17, 1, -2.77556e-17, 2.77556e-17, -2.22045e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.40589e-16, -4.18486e-16, -0.04, 1, -2.70617e-16, 1.38778e-16, 2.22045e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-4.23305e-19, 6.08339e-18, 0.01, 1, 0, 2.71051e-20, -3.81202e-17], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-9.92723e-19, 6.88468e-18, 0.2105, 2.3473e-17, 0.92388, 0.382683, 5.65411e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 6.93889e-18, 5.96311e-19], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-1.48265e-17, 0.008, 0.045, 1, 0, 2.20229e-20, -2.67032e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [1.70016e-17, -0.008, 0.045, 1, 0, 2.4564e-20, -2.67032e-18], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
rect_1(table): { pose: [-0.049984, 0.0999928, 0.0664092, 0.999942, 6.71508e-06, 4.89651e-06, 0.0107608], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0, 0.9, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_2(table): { pose: [0.05, 0.0999982, 0.0665051, 0.999981, 8.89189e-08, 2.00815e-07, 0.00613535], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0, 0.7, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_3(table): { pose: [-0.0133936, 0.0994832, 0.12741, 1, 0.000101404, -0.000266073, 0.000156248], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0, 0.5, 1], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_4(table): { pose: [0.3, 0.1, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.2, 0.3, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_5(table): { pose: [0.45, 0, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.9, 0, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_6(table): { pose: [0.3, 0.2, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.7, 0, 0.9], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_7(table): { pose: [0.45, 0.1, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.5, 0, 0.8], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
rect_8(table): { pose: [0.45, 0.2, 0.065], joint: rigid, shape: ssBox, size: [0.06, 0.03, 0.03, 0.001], color: [0.3, 0, 0.7], contact: 1, mass: 0.2, inertia: [0.00036, 0.0009, 0.0009], logical: { is_object: True, is_box: True, is_place: True } }
cyl_1(table): { pose: [-0.3, -0.1, 0.065], joint: rigid, shape: cylinder, size: [0.03, 0.015], color: [0, 0.8, 0], contact: 1, mass: 0.2, inertia: [4.31924e-05, 4.31924e-05, 3.66427e-05], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl_2(table): { pose: [-0.3, 0, 0.065], joint: rigid, shape: cylinder, size: [0.03, 0.015], color: [0.4, 1, 0.2], contact: 1, mass: 0.2, inertia: [4.31924e-05, 4.31924e-05, 3.66427e-05], logical: { is_object: True, is_cylinder: True, is_place: True } }
cube_1(table): { pose: [-0.0649698, 0.0996691, 0.0974044, 0.999781, 7.30397e-06, 6.25101e-06, 0.0209398], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 0.5, 0], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_2(table): { pose: [-0.0349797, 0.100314, 0.0974059, 0.999795, 7.22734e-06, 5.83625e-06, 0.0202671], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [1, 0.8, 0], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_3(table): { pose: [0.0350062, 0.0998125, 0.0975037, 0.999897, 4.64604e-07, 8.50784e-07, 0.0143697], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.9, 0.3, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
cube_4(table): { pose: [0.0650017, 0.100181, 0.0975061, 0.999912, 2.5752e-07, 5.696e-07, 0.0132802], joint: rigid, shape: ssBox, size: [0.03, 0.03, 0.03, 0.001], color: [0.8, 0.1, 0.1], contact: 1, mass: 0.2, inertia: [0.00036, 0.00036, 0.00036], logical: { is_object: True, is_box: True, is_place: True } }
tri_1(table): { pose: [-0.45, 0.1, 0.05], joint: rigid, shape: mesh, color: [1, 0.4, 0.7], mesh: "/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", contact: 1, mass: 0.2, inertia: [3.61846e-05, 3.20675e-05, 5.23466e-05], logical: { is_object: True, is_place: True } }
Base_Center(table): { pose: [0, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Left(table): { pose: [-0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Right(table): { pose: [0.08, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Top(table): { pose: [0, 0.02, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Base_Bottom(table): { pose: [0, 0.18, 0.051], shape: ssBox, size: [0.025, 0.025, 0.002, 0.001], color: [1, 1, 0, 0], logical: { is_place: True } }
Table_Left(table): { pose: [-0.05, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Table_Right(table): { pose: [0.05, 0.1, 0.051], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [0, 1, 1, 0], logical: { is_place: True } }
Rect_1_Left(rect_1): { pose: [-0.015, -2.89076e-18, 0.0155, 1, 0, -3.30872e-22, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_1_Right(rect_1): { pose: [0.015, -3.98953e-19, 0.0155, 1, 0, -3.30872e-22, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_2_Left(rect_2): { pose: [-0.015, -9.11768e-19, 0.0155, 1, 0, -9.20238e-24, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_2_Right(rect_2): { pose: [0.015, 7.94496e-17, 0.0155, 1, 0, -9.20238e-24, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_3_Left(rect_3): { pose: [-0.015, 8.71385e-18, 0.0155, 1, 0, 2.12354e-20, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
Rect_3_Right(rect_3): { pose: [0.015, 4.59515e-19, 0.0155, 1, 0, 2.12354e-20, 0], shape: ssBox, size: [0.025, 0.025, 0.001, 0.0005], color: [1, 0.8, 0, 0], logical: { is_place: True } }
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