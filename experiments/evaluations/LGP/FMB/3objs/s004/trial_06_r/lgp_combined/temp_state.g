# FMB Random Scene | trial_06 | mode=r
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

shape_2_1 (table) { Q:"t(0.1002 0.2157 0.063) d(-90 0 0 1) d(-45.63 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_2_2 (table) { Q:"t(-0.1692 -0.1801 0.063) d(-90 0 0 1) d(-101.08 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_2.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_2_3 (table) { Q:"t(0.1043 -0.2845 0.063) d(-90 0 0 1) d(73.88 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_3.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_2_4 (table) { Q:"t(0.3642 0.2090 0.063) d(-90 0 0 1) d(98.10 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_4.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_2_4 (table) { Q:"t(-0.3424 0.4085 0.063) d(-90 0 0 1) d(-171.56 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_5.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_2_4 (table) { Q:"t(-0.1079 0.2989 0.063) d(-90 0 0 1) d(1.17 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_6.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
