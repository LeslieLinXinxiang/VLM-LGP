# FMB Random Scene | trial_07 | mode=r
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
Table_Left (base_board) { Q:"t(0.000 0.000 0.080) d(-90 1 0 0) d(-90 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Right (base_board) { Q:"t(0.000 0.000 -0.080) d(-90 1 0 0) d(-90 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Front (base_board) { Q:"t(0.059 0.000 0.000) d(-90 1 0 0) d(-90 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Back (base_board) { Q:"t(-0.061 0.000 0.000) d(-90 1 0 0) d(-90 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Center (base_board) { Q:"t(0.000 0.000 0.000) d(-90 1 0 0) d(-90 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }

shape_2_1 (table) { Q:"t(0.0787 0.3845 0.0625) d(170.29 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_2_2 (table) { Q:"t(0.1764 0.2429 0.0625) d(45.75 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_2.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_3_1 (table) { Q:"t(-0.1755 -0.3512 0.0625) d(-68.97 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.005], color:[0.2 0.2 0.9], contact:0, logical:{ is_object, is_box } }
shape_3_1_mesh (shape_3_1) { Q:"t(0 0.001 0.0325) d(90 1 0 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_1.obj", color:[0.2 0.8 1.0 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_3_1_handle (shape_3_1) { Q:"t(0 0 0.065) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
shape_3_2 (table) { Q:"t(-0.2975 0.2711 0.0625) d(164.43 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.005], color:[0.2 0.2 0.9], contact:0, logical:{ is_object, is_box } }
shape_3_2_mesh (shape_3_2) { Q:"t(0 0.001 0.0325) d(90 1 0 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_2.obj", color:[0.2 0.8 1.0 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_3_2_handle (shape_3_2) { Q:"t(0 0 0.065) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
shape_3_3 (table) { Q:"t(0.1558 -0.3510 0.0625) d(-141.71 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.005], color:[0.2 0.2 0.9], contact:0, logical:{ is_object, is_box } }
shape_3_3_mesh (shape_3_3) { Q:"t(0 0.001 0.0325) d(90 1 0 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_3.obj", color:[0.2 0.8 1.0 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_3_3_handle (shape_3_3) { Q:"t(0 0 0.065) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
shape_3_4 (table) { Q:"t(-0.0866 -0.1985 0.0625) d(-116.87 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.005], color:[0.2 0.2 0.9], contact:0, logical:{ is_object, is_box } }
shape_3_4_mesh (shape_3_4) { Q:"t(0 0.001 0.0325) d(90 1 0 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_4.obj", color:[0.2 0.8 1.0 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_3_4_handle (shape_3_4) { Q:"t(0 0 0.065) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
