# FMB Random Scene | trial_08 | mode=r
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

shape_2_1 (table) { Q:"t(-0.4058 -0.3675 0.063) d(-90 0 0 1) d(-155.45 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_2_2 (table) { Q:"t(-0.2366 0.3013 0.063) d(-90 0 0 1) d(-94.86 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_2.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_2_3 (table) { Q:"t(-0.1108 0.2175 0.063) d(-90 0 0 1) d(-120.17 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_3.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_2_4 (table) { Q:"t(0.2082 -0.3185 0.063) d(-90 0 0 1) d(-11.49 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_4.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_4_1 (table) { Q:"t(0.2542 0.2964 0.0625) d(2.05 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.0], color:[1.0 0.5 0.2], contact:0, logical:{ is_object } }
shape_4_1_mesh (shape_4_1) { Q:"t(0 0 0.0275) d(90 1 0 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", color:[1.0 0.5 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_4_1_handle (shape_4_1) { Q:"t(0 0 0.05) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
shape_4_2 (table) { Q:"t(0.0950 -0.4416 0.0625) d(-148.68 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.0], color:[1.0 0.5 0.2], contact:0, logical:{ is_object } }
shape_4_2_mesh (shape_4_2) { Q:"t(0 0 0.0275) d(90 1 0 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj", color:[1.0 0.5 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_4_2_handle (shape_4_2) { Q:"t(0 0 0.05) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
shape_4_3 (table) { Q:"t(-0.3566 -0.1649 0.0625) d(-136.33 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.0], color:[1.0 0.5 0.2], contact:0, logical:{ is_object } }
shape_4_3_mesh (shape_4_3) { Q:"t(0 0 0.0275) d(90 1 0 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_3.obj", color:[1.0 0.5 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_4_3_handle (shape_4_3) { Q:"t(0 0 0.05) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
shape_4_4 (table) { Q:"t(0.1047 0.4431 0.0625) d(-177.24 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.0], color:[1.0 0.5 0.2], contact:0, logical:{ is_object } }
shape_4_4_mesh (shape_4_4) { Q:"t(0 0 0.0275) d(90 1 0 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_4.obj", color:[1.0 0.5 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_4_4_handle (shape_4_4) { Q:"t(0 0 0.05) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
shape_4_5 (table) { Q:"t(-0.3572 0.1562 0.0625) d(66.23 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.0], color:[1.0 0.5 0.2], contact:0, logical:{ is_object } }
shape_4_5_mesh (shape_4_5) { Q:"t(0 0 0.0275) d(90 1 0 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_5.obj", color:[1.0 0.5 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_4_5_handle (shape_4_5) { Q:"t(0 0 0.05) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
shape_4_6 (table) { Q:"t(0.3047 -0.2251 0.0625) d(-160.30 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.0], color:[1.0 0.5 0.2], contact:0, logical:{ is_object } }
shape_4_6_mesh (shape_4_6) { Q:"t(0 0 0.0275) d(90 1 0 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_6.obj", color:[1.0 0.5 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_4_6_handle (shape_4_6) { Q:"t(0 0 0.05) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
