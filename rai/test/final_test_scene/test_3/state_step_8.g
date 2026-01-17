world: {  }
table(world): { pose: [0, 0, 0.6], shape: ssBox, size: [2, 4, 0.1, 0.02], color: [0.3, 0.3, 0.3], contact: 1, logical: { is_place: True } }
l_panda_base(table): { pose: [0, -0.3, 0.05, 0.707107, 0, 0, 0.707107], multibody: True, multibody_gravity: False }
l_panda_link0(l_panda_base): { shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link0.h5> }
l_panda_joint1_origin(l_panda_link0): { pose: [0, 0, 0.333] }
l_panda_joint1(l_panda_joint1_origin): { pose: [0.995511, -0, 0, 0.0946496], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link1.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint2_origin(l_panda_joint1): { pose: [0.707107, -0.707107, 5.55112e-17, -1.66533e-16] }
l_panda_joint2(l_panda_joint2_origin): { pose: [0.986347, -1.11022e-16, -5.55112e-17, 0.164679], joint: hingeZ, limits: [-1.7628, 1.7628], shape: mesh, color: [1, 1, 1, 1], mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link2.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint3_origin(l_panda_joint2): { pose: [-4.44089e-16, -0.316, -6.16613e-16, 0.707107, 0.707107, 5.55112e-17, 3.88578e-16] }
l_panda_joint3(l_panda_joint3_origin): { pose: [-1.18646e-16, 1.27026e-16, -2.75533e-16, 0.993998, -4.16334e-17, 5.55112e-17, 0.109402], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link3.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint4_origin(l_panda_joint3): { pose: [0.0825, -6.72639e-16, 4.51028e-17, 0.707107, 0.707107, -1.249e-16, 0] }
l_panda_joint4(l_panda_joint4_origin): { pose: [-1.41639e-16, -4.76742e-17, -2.50121e-18, 0.723389, 6.93889e-18, -5.55112e-17, -0.690441], joint: hingeZ, limits: [-3.0718, -0.0698], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link4.h5>, mj_actuator_kp: "870.", mj_joint_damping: "100." }
l_panda_joint5_origin(l_panda_joint4): { pose: [-0.0825, 0.384, 3.88361e-16, 0.707107, -0.707107, -1.94289e-16, 4.44089e-16] }
l_panda_joint5(l_panda_joint5_origin): { pose: [-2.1066e-16, -3.53713e-17, -8.21968e-17, 0.999905, -1.66533e-16, -5.55112e-17, -0.013778], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link5.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint6_origin(l_panda_joint5): { pose: [-7.42831e-18, -1.0921e-17, 2.44115e-17, 0.707107, 0.707107, 1.04083e-16, 5.20417e-18] }
l_panda_joint6(l_panda_joint6_origin): { pose: [0.587994, 5.55112e-17, 2.77556e-17, 0.808865], joint: hingeZ, limits: [0.5, 3], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link6.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint7_origin(l_panda_joint6): { pose: [0.088, -9.49327e-16, 5.09738e-16, 0.707107, 0.707107, 3.25694e-16, -4.76615e-16] }
l_panda_joint7(l_panda_joint7_origin): { pose: [-1.45579e-16, 5.82649e-17, -7.99454e-18, 0.975493, 7.15573e-18, 4.38018e-17, -0.220031], joint: hingeZ, limits: [-2.8973, 2.8973], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/link7.h5>, mj_actuator_kp: "120.", mj_joint_damping: "10." }
l_panda_joint8_origin(l_panda_joint7): { pose: [-2.90566e-16, 1.43982e-16, 0.107, 1, -2.60209e-17, -9.09646e-17, 5.54298e-18] }
l_panda_joint8(l_panda_joint8_origin): { pose: [-7.43363e-17, 1.40342e-16, -3.34351e-15, 1, -1.12757e-17, -4.29344e-17, -5.01105e-17] }
l_panda_hand_joint_origin(l_panda_joint8): { pose: [-3.1877e-17, -1.19958e-16, 1.20336e-18, 0.92388, 8.67362e-18, -5.89806e-17, -0.382683] }
l_panda_hand_joint(l_panda_hand_joint_origin): { pose: [1, 3.64292e-17, -1.53957e-17, -2.12504e-17], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/hand.h5> }
l_panda_finger_joint1_origin(l_panda_hand_joint): { pose: [-1.60462e-17, -1.01698e-16, 0.0584, 1, -8.67362e-18, 1.51788e-18, -3.52366e-17] }
l_panda_finger_joint2_origin(l_panda_hand_joint): { pose: [-1.60462e-17, -1.01698e-16, 0.0584, 1, -8.67362e-18, 1.51788e-18, -3.52366e-17] }
l_panda_finger_joint1(l_panda_finger_joint1_origin): { pose: [-2.43268e-18, 0.04, -2.10639e-15, 1, -5.20417e-18, 1.14383e-17, -3.19298e-17], joint: transY, limits: [0, 0.04], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5>, mj_actuator_kp: "500.", mj_joint_damping: "100.", joint_active: False }
l_panda_finger_joint2(l_panda_finger_joint2_origin): { pose: [2.64478e-17, -0.04, 1.66306e-15, 1, 5.20417e-18, -9.05309e-18, 3.08456e-17], joint: transY, joint_scale: -1, limits: [0, 0.04], mimic: "l_panda_finger_joint1", mj_actuator_kp: "500.", mj_joint_damping: "100." }
l_panda_rightfinger_0(l_panda_finger_joint2): { pose: [-2.17801e-16, -6.90931e-17, -1.31952e-17, -1.03437e-13, -1.38778e-17, 1.46367e-17, 1], shape: mesh, mesh: </home/leslie/Projects/VLM_LGP/rai-robotModels/panda/meshes/finger.h5> }
l_panda_coll0(l_panda_link0): { pose: [-0.04, 1.24346e-16, 0.03, 0.707107, 0, 0.707107, 0], shape: capsule, size: [0.1, 0.11], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll1(l_panda_joint1): { pose: [0, 0, -0.15, 1, -0, 0, 1.66533e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll3(l_panda_joint3): { pose: [3.81639e-16, 4.66641e-16, -0.15, 1, 6.93889e-17, -9.71445e-17, 4.996e-16], shape: capsule, size: [0.2, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll5(l_panda_joint5): { pose: [1.17961e-15, 0.02, -0.2, 1, -2.498e-16, 1.66533e-16, -2.22045e-16], shape: capsule, size: [0.22, 0.09], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll2(l_panda_joint2): { pose: [1, -1.11022e-16, -2.22045e-16, 2.498e-16], shape: capsule, size: [0.12, 0.12], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll4(l_panda_joint4): { pose: [-8.02547e-18, 2.71176e-17, 4.32972e-18, 1, -1.49186e-16, -2.34188e-16, 3.46945e-16], shape: capsule, size: [0.12, 0.08], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll6(l_panda_joint6): { pose: [9.01379e-17, -8.6953e-17, -0.04, 1, 0, 5.55112e-17, 2.22045e-16], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_panda_coll7(l_panda_joint7): { pose: [-1.10589e-16, 1.76589e-16, 0.01, 1, -2.60209e-17, -9.09646e-17, 5.54298e-18], shape: capsule, size: [0.1, 0.07], color: [1, 1, 1, 0.1], contact: -2 }
l_gripper(l_panda_joint7): { pose: [-3.81639e-16, 1.50054e-16, 0.2105, 7.71952e-17, 0.92388, 0.382683, 4.16334e-17], shape: marker, size: [0.03], color: [0.9, 0.9, 0.9], logical: { is_gripper: True } }
l_palm(l_panda_hand_joint): { pose: [0.707107, 0.707107, 7.97973e-17, -1.07553e-16], shape: capsule, size: [0.14, 0.07], color: [1, 1, 1, 0.1], contact: -3 }
l_finger1(l_panda_finger_joint1): { pose: [-7.41594e-17, 0.008, 0.045, 1, 1.73472e-18, 4.11997e-18, -6.32632e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
l_finger2(l_panda_finger_joint2): { pose: [-2.84495e-16, -0.008, 0.045, 1, -1.38778e-17, -2.33103e-18, -3.54534e-17], shape: ssBox, size: [0.02, 0.016, 0.02, 0.005], color: [1, 1, 1, 0.1], contact: -2 }
base1(table): { pose: [-0.00416016, 0.43, 0.07, 1, 0, 0, -0.000122148], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [0.8, 0.8, 0.8], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_place: True } }
base1_handle(base1): { pose: [0, 0, 0.05, 1, 0, -0, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [0.8, 0.8, 0.8], logical: { is_object: True, is_place: True } }
base2(table): { pose: [-0.0132477, 0.386589, 0.190051, 1, 2.85736e-05, 1.06539e-05, 1.72392e-06], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True } }
base2_handle(base2): { pose: [7.47507e-19, -3.3894e-18, 0.05, 1, 0, 4.0643e-22, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
base3(table): { pose: [-0.0198123, 0.330053, 0.310063, 1, 9.40139e-06, 2.35354e-05, 4.26648e-05], joint: rigid, shape: ssBox, size: [0.5, 0.4, 0.04, 0.002], color: [1, 0, 0], contact: 1, mass: 0.5, inertia: [0.0808, 0.1258, 0.205], logical: { is_object: True, is_box: True } }
base3_handle(base3): { pose: [8.97855e-19, 8.92476e-18, 0.05, 1, -1.69407e-21, -3.02976e-21, 0], shape: ssBox, size: [0.04, 0.04, 0.06, 0.002], color: [1, 0, 0], logical: { is_object: True } }
cyl1(table): { pose: [0.208641, 0.299948, 0.13, 0.955089, 0, 0, -0.296319], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl2(table): { pose: [-0.224192, 0.300054, 0.13, 0.999107, 0, 0, -0.0422406], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl3(table): { pose: [-0.0241284, 0.560005, 0.13, 0.715468, 0, 0, -0.698646], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl4(table): { pose: [-0.233246, 0.234924, 0.250047, 0.999717, 2.83119e-05, 1.13311e-05, -0.0238042], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl5(table): { pose: [0.166754, 0.238515, 0.250039, 0.980697, 3.01052e-05, 4.86115e-06, 0.195535], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl6(table): { pose: [0.00675313, 0.516586, 0.250058, 0.767586, 2.87613e-05, -1.01363e-05, 0.640946], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl7(table): { pose: [0.200192, 0.310093, 0.370052, 0.989574, 1.26921e-05, 2.19365e-05, 0.144026], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], cont act: 1, logical: { is_object: True, is_cylinder: True, is_place: True } }
cyl8(table): { pose: [-0.23801, 0.311443, 0.370073, 0.946012, 1.65216e-05, 1.92182e-05, 0.324133], joint: rigid, shape: cylinder, size: [0.08, 0.04], color: [1, 1, 0], contact: 1, mass: 0.2, inertia: [0.000307146, 5.73247e-12, -8.47033e-22, 0.000307146, -7.41154e-22, 0.000260571], logical: { is_object: True, is_cylinder: True, is_place: True } }
place_base1(table): { pose: [0, 0.45, 0.05], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base1(base1): { pose: [0.2, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontright_base1(base1): { pose: [-0.2, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backleft_base1(base1): { pose: [-0.2, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
backright_base1(base1): { pose: [0.2, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
back_base1(base1): { pose: [-3.65918e-19, -0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
front_base1(base1): { pose: [3.65918e-19, 0.15, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
left_base1(base1): { pose: [-0.2, -1.34034e-17, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
right_base1(base1): { pose: [0.2, 1.34034e-17, 0.02, 1, 0, -0, 0], shape: quad, size: [0.05, 0.05], color: [0.8, 0.5, 0.5], logical: { is_place: True } }
frontleft_base2(base2): { pose: [0.2, 0.15, 0.02, 1, 0, 4.0643e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontright_base2(base2): { pose: [-0.2, 0.15, 0.02, 1, 0, 4.0643e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backleft_base2(base2): { pose: [-0.2, -0.15, 0.02, 1, 0, 4.0643e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backright_base2(base2): { pose: [0.2, -0.15, 0.02, 1, 0, 4.0643e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
back_base2(base2): { pose: [-7.13625e-20, -0.15, 0.02, 1, 0, 4.0643e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
front_base2(base2): { pose: [-8.35275e-18, 0.15, 0.02, 1, 0, 4.0643e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
left_base2(base2): { pose: [-0.2, 2.47031e-17, 0.02, 1, 0, 4.0643e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
right_base2(base2): { pose: [0.2, 7.25103e-17, 0.02, 1, 0, 4.0643e-22, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontleft_base3(base3): { pose: [0.2, 0.15, 0.02, 1, -1.69407e-21, -3.02976e-21, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
frontright_base3(base3): { pose: [-0.2, 0.15, 0.02, 1, -1.69407e-21, -3.02976e-21, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backleft_base3(base3): { pose: [-0.2, -0.15, 0.02, 1, -1.69407e-21, -3.02976e-21, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
backright_base3(base3): { pose: [0.2, -0.15, 0.02, 1, -1.69407e-21, -3.02976e-21, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
back_base3(base3): { pose: [-4.88611e-18, -0.15, 0.02, 1, -1.69407e-21, -3.02976e-21, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
front_base3(base3): { pose: [-6.35804e-19, 0.15, 0.02, 1, -1.69407e-21, -3.02976e-21, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
left_base3(base3): { pose: [-0.2, -6.14955e-17, 0.02, 1, -1.69407e-21, -3.02976e-21, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }
right_base3(base3): { pose: [0.2, 3.5331e-17, 0.02, 1, -1.69407e-21, -3.02976e-21, 0], shape: quad, size: [0.05, 0.05], color: [0.5, 0.5, 0.8], logical: { is_place: True } }