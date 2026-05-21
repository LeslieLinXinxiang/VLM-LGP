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
Table_Left (base_board) { Q:"t(0.000 0.000 0.080) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Right (base_board) { Q:"t(0.000 0.000 -0.080) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Front (base_board) { Q:"t(0.059 0.000 0.000) d(-90 1 0 0) d(-90 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Back (base_board) { Q:"t(-0.061 0.000 0.000) d(-90 1 0 0) d(-90 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Center (base_board) { Q:"t(0.000 0.000 0.000) d(-90 1 0 0) d(-90 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }

shape_2_1 (table) { Q:"t(0.3523 0.3318 0.063) d(-90 0 0 1) d(150.09 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_2_2 (table) { Q:"t(-0.3169 -0.2027 0.063) d(-90 0 0 1) d(-154.73 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_2.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_2_3 (table) { Q:"t(0.1240 -0.2796 0.063) d(-90 0 0 1) d(27.89 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_3.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_2_4 (table) { Q:"t(0.0719 0.2702 0.063) d(-90 0 0 1) d(-79.86 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_4.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_2_5 (table) { Q:"t(0.2139 0.3985 0.063) d(-90 0 0 1) d(164.05 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_5.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_2_6 (table) { Q:"t(-0.4477 0.3459 0.063) d(-90 0 0 1) d(-106.11 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_6.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_4_1 (table) { Q:"t(-0.0915 -0.3636 0.0625) d(168.22 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.0], color:[1.0 0.5 0.2], contact:0, logical:{ is_object } }
shape_4_1_mesh (shape_4_1) { Q:"t(0 0 0.0275) d(90 1 0 0) d(90 0 1 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj", color:[1.0 0.5 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_4_1_handle (shape_4_1) { Q:"t(0 0 0.05) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
shape_4_2 (table) { Q:"t(0.3519 -0.3820 0.0625) d(21.40 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.0], color:[1.0 0.5 0.2], contact:0, logical:{ is_object } }
shape_4_2_mesh (shape_4_2) { Q:"t(0 0 0.0275) d(90 1 0 0) d(90 0 1 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj", color:[1.0 0.5 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_4_2_handle (shape_4_2) { Q:"t(0 0 0.05) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
shape_4_3 (table) { Q:"t(-0.2429 0.2841 0.0625) d(-53.32 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.0], color:[1.0 0.5 0.2], contact:0, logical:{ is_object } }
shape_4_3_mesh (shape_4_3) { Q:"t(0 0 0.0275) d(90 1 0 0) d(90 0 1 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_3.obj", color:[1.0 0.5 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_4_3_handle (shape_4_3) { Q:"t(0 0 0.05) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
shape_4_4 (table) { Q:"t(-0.0619 0.1683 0.0625) d(-128.18 0 0 1)", joint:rigid, shape:ssBox, size:[0.025 0.025 0.025 0.0], color:[1.0 0.5 0.2], contact:0, logical:{ is_object } }
shape_4_4_mesh (shape_4_4) { Q:"t(0 0 0.0275) d(90 1 0 0) d(90 0 1 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_4.obj", color:[1.0 0.5 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_4_4_handle (shape_4_4) { Q:"t(0 0 0.05) d(0 0 0 0)", shape:marker, size:[0.03], color:[1 1 0] }
