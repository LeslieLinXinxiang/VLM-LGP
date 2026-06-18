# FMB Random Scene | trial_05 | mode=r
world {}

table (world) { shape:ssBox, size:[2.0 4.0 0.1 0.02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

Prefix: "l_"
Include: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 0 0.05)" }
Edit l_panda_joint1 { q: 0.0 }
Edit l_panda_joint2 { q: -1.5 }
Edit l_panda_joint3 { q: 0.0 }
Edit l_panda_joint4 { q: -2.5 }
Edit l_panda_joint5 { q: 0.0 }
Edit l_panda_joint6 { q: 1.5 }
Edit l_panda_joint7 { q: 0.0 }
Edit l_panda_finger_joint1 { q: 0.04 }
Edit l_panda_finger_joint2 { q: 0.04 }

base_board (table) { Q:"t(0.45 0.00 0.075) d(90 1 0 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj", color:[0.75 0.75 0.75 1], contact:0, mass:0.5, logical:{ is_object, is_place } }
Table_Left (base_board) { Q:"t(0.000 0.000 0.080) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Right (base_board) { Q:"t(0.000 0.000 -0.080) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Front (base_board) { Q:"t(0.059 0.000 0.000) d(-90 1 0 0) d(-90 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Back (base_board) { Q:"t(-0.061 0.000 0.000) d(-90 1 0 0) d(-90 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Center (base_board) { Q:"t(0.000 0.000 0.000) d(-90 1 0 0) d(-90 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }

shape_3_1 (table) { Q:"t(-0.2620 -0.2046 0.0625) d(-131.69 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.005], color:[0.2 0.2 0.9], contact:0, logical:{ is_object, is_box } }
shape_3_1_mesh (shape_3_1) { Q:"t(0 0.001 0.0325) d(90 1 0 0) d(90 0 1 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_1.obj", color:[0.2 0.8 1.0 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_3_1_handle (shape_3_1) { Q:"t(0 0 0.065) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
shape_3_2 (table) { Q:"t(0.2330 0.4417 0.0625) d(153.90 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.005], color:[0.2 0.2 0.9], contact:0, logical:{ is_object, is_box } }
shape_3_2_mesh (shape_3_2) { Q:"t(0 0.001 0.0325) d(90 1 0 0) d(90 0 1 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_2.obj", color:[0.2 0.8 1.0 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_3_2_handle (shape_3_2) { Q:"t(0 0 0.065) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
shape_3_3 (table) { Q:"t(-0.3142 0.1802 0.0625) d(6.15 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.005], color:[0.2 0.2 0.9], contact:0, logical:{ is_object, is_box } }
shape_3_3_mesh (shape_3_3) { Q:"t(0 0.001 0.0325) d(90 1 0 0) d(90 0 1 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_3.obj", color:[0.2 0.8 1.0 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_3_3_handle (shape_3_3) { Q:"t(0 0 0.065) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
shape_3_4 (table) { Q:"t(0.0981 -0.3803 0.0625) d(-1.66 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.005], color:[0.2 0.2 0.9], contact:0, logical:{ is_object, is_box } }
shape_3_4_mesh (shape_3_4) { Q:"t(0 0.001 0.0325) d(90 1 0 0) d(90 0 1 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_4.obj", color:[0.2 0.8 1.0 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_3_4_handle (shape_3_4) { Q:"t(0 0 0.065) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
shape_3_5 (table) { Q:"t(-0.2654 0.3245 0.0625) d(42.98 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.005], color:[0.2 0.2 0.9], contact:0, logical:{ is_object, is_box } }
shape_3_5_mesh (shape_3_5) { Q:"t(0 0.001 0.0325) d(90 1 0 0) d(90 0 1 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_5.obj", color:[0.2 0.8 1.0 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_3_5_handle (shape_3_5) { Q:"t(0 0 0.065) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
shape_3_6 (table) { Q:"t(-0.4446 -0.2480 0.0625) d(30.75 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.005], color:[0.2 0.2 0.9], contact:0, logical:{ is_object, is_box } }
shape_3_6_mesh (shape_3_6) { Q:"t(0 0.001 0.0325) d(90 1 0 0) d(90 0 1 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_6.obj", color:[0.2 0.8 1.0 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_3_6_handle (shape_3_6) { Q:"t(0 0 0.065) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
