# FMB Random Scene | trial_01 | mode=nr
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

 }
# Fixed placement slots on base_board
Table_Left (base_board) { Q:"t( 0.000 0.000  0.080) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Right (base_board) { Q:"t(0.000 0.000 -0.080) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Front (base_board) { Q:"t(0.059 0.000 0.000) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Back (base_board) { Q:"t(-0.061 0.000 0.000) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Center (base_board) { Q:"t(00 0.000 0.000) d(-90 1 0 0) ", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }

shape_2_1 (table) { Q:"t(-0.2037 -0.3450 0.0625) d(101.99 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
shape_2_2 (table) { Q:"t(-0.0786 0.2868 0.0625) d(-152.52 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_2.obj", color:[0.2 1.0 0.2 1], contact:1, mass:0.1, logical:{ is_object, is_box } }
