world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.99939, -0, 0, 0.0349161], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, -5.55112e-17, -1.11022e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.913678, 1.11022e-16, -5.55112e-17, 0.406439], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-4.996e-16, -0.316, -3.47739e-16, 0.707107, 0.707107, 5.55112e-17, 0] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-8.10675e-19, -1.73049e-17, -8.99166e-19, 0.991342, -8.32667e-17, 5.55112e-17, 0.131303], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -2.04697e-16, 1.04083e-16, 0.707107, 0.707107, 2.77556e-17, 2.22045e-16] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-2.59165e-17, -2.42135e-17, 1.22627e-17, 0.785015, 0, 0, -0.619477], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 4.78784e-16, 0.707107, -0.707107, 2.77556e-17, -5.55112e-17] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-9.0815e-17, 2.14662e-17, -6.01481e-17, 0.993891, -2.77556e-17, -5.55112e-17, -0.110366], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-5.23682e-18, 2.58771e-17, 8.56304e-18, 0.707107, 0.707107, -6.245e-17, -4.85723e-17] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.491006, -5.55112e-17, -1.11022e-16, 0.871156], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -3.11817e-16, 4.6185e-16, 0.707107, 0.707107, -2.37657e-16, 1.50921e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-2.18552e-16, 9.40373e-17, -1.05759e-16, 0.9714, 8.67362e-18, 4.42354e-17, -0.237451], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-1.84314e-16, 4.0766e-17, 0.107, 1, 2.77556e-17, -8.67362e-19, 1.18761e-16] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-4.20436e-17, 4.06978e-17, -1.77713e-15, 1, 0, 5.20417e-18, 1.18856e-16] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [4.16861e-17, -3.66572e-17, -9.17279e-20, 0.92388, -2.25514e-17, 2.08167e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [2.41415e-17, 5.71505e-17, -1.69238e-18, 1, 0, -4.44523e-18, -1.0842e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-5.90738e-17, -4.77049e-18, 0.0584, 1, 6.93889e-18, -5.04154e-18, 2.37864e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-5.90738e-17, -4.77049e-18, 0.0584, 1, 6.93889e-18, -5.04154e-18, 2.37864e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [4.05432e-17, 0.04, -9.62988e-16, 1, 1.73472e-18, -4.87891e-18, 9.82389e-18], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [-4.04314e-17, -0.04, 5.19116e-16, 1, -1.73472e-18, 4.98733e-18, -4.05221e-18], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.76985e-17, -1.77793e-18, 4.5864e-20, -1.03423e-13, 0, -2.18704e-18, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 7.10544e-17, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [1.52656e-16, 1.21431e-16, -0.15, 1, 5.55112e-17, -5.55112e-17, 0], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [7.35523e-16, 0.02, -0.2, 1, -1.11022e-16, -1.66533e-16, -6.93889e-17], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -5.55112e-17, -5.55112e-17, -2.77556e-17], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-9.97241e-19, 1.35631e-18, 4.18554e-19, 1, 1.38778e-17, 1.59595e-16, -1.52656e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [1.50457e-16, -5.47522e-17, -0.04, 1, 1.66533e-16, -2.498e-16, 1.11022e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-9.6765e-18, -9.08019e-18, 0.01, 1, 2.77556e-17, -8.67362e-19, 1.18761e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-2.77556e-16, 9.02056e-17, 0.2105, -1.38778e-17, 0.92388, 0.382683, 5.37764e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, -3.1225e-17, 2.70508e-17], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-1.70406e-17, 0.008, 0.045, 1, 6.93889e-18, -4.66207e-18, 3.05626e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-1.00004e-16, -0.008, 0.045, 1, 5.20417e-18, -4.8247e-18, 2.37771e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-0.0137686, 0.28, 0.07, 1, 0, 0, -0.000233485], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [0, 0, 0.05, 1, 0, -0, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True, is_place: True } }
base2(table): { pose: [-0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base2_handle(base2): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
base3(table): { pose: [0.5, -0.4, 0.07], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
base3_handle(base3): { pose: [0, 0, 0.05], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [0.166303, 0.409916, 0.14, 0.837607, 0, 0, 0.546273], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [-0.193708, 0.410084, 0.14, 0.949474, 0, 0, 0.313846], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.208193, 0.150091, 0.14, 0.886195, 0, 0, 0.463313], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [0.206158, 0.149895, 0.14, 0.995592, 0, 0, 0.093793], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [0.6, 0, 0.1], joint: rigid, shape: cylinder, size: [0.1, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000394561, 5.79243e-12, 9.52912e-22, 0.000394561, -1.37643e-21, 0.000267941], logical: { is_object: True, is_cylinder: True, is_place: True } }
place_base1(table): { pose: [0, 0.3, 0.05], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base1(base1): { pose: [0.2, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base1(base1): { pose: [-0.2, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base1(base1): { pose: [-0.2, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base1(base1): { pose: [0.2, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base2(base2): { pose: [0.2, 0, 0.02], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }