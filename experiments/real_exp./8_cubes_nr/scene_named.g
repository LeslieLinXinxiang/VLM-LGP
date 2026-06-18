# Auto-generated | 8cubes_s02 | mode=nr
world {}
base (world) { shape:ssBox, size:[1.3 1.0 .11 .02], Q:"t(0 0 .545)", color:[.45 .45 .45], contact:1 }
table (base) { shape:ssBox, size:[1.0 0.8 .1 .02], Q:"t(0 0.25 .11)", color:[.3 .3 .3], contact:1, logical:{ is_place } }


Prefix: "l_"
Include: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (base): { Q: "t(0 -.3 .05) d(90 0 0 1)" }
Edit l_panda_joint1 { q: 0.0 }
Edit l_panda_joint2 { q: -1.5 }
Edit l_panda_joint3 { q: 0.0 }
Edit l_panda_joint4 { q: -2.5 }
Edit l_panda_joint5 { q: 0.0 }
Edit l_panda_joint6 { q: 1.5 }
Edit l_panda_joint7 { q: 0.0 }
Edit l_panda_finger_joint1 { q: 0.04 }
Edit l_panda_finger_joint2 { q: 0.04 }

# Fixed placement slots on table
Table_Left  (table) { Q:"t(-0.08  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Center  (table) { Q:"t(0.00  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Right (table) { Q:"t( 0.08  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Back (table) { Q:"t( 0.00  0.02 .051)", shape:ssBox, size:[.025 .025 .002 .001], color:[1 1 0 0], contact:0, logical:{ is_place } }
Base_Front (table) { Q:"t( 0.00  0.18 .051)", shape:ssBox, size:[.025 .025 .002 .001], color:[1 1 0 0], contact:0, logical:{ is_place } }


cube_1 (table) { Q:"t(-0.2373 -0.0012 0.065) d(127.62 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
cube_2 (table) { Q:"t(-0.3046 0.1276 0.065) d(-93.66 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
rect_2 (table) { Q:"t(-0.3124 -0.0142 0.065) d(78.48 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
rect_2_Left(rect_2) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_2_Right(rect_2) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_3 (table) { Q:"t(0.1374 0.0548 0.065) d(065.82 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
rect_3_Left(rect_3) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_3_Right(rect_3) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_5 (table) { Q:"t(0.3352 0.0560 0.065) d(-138.38 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
rect_5_Left(rect_5) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_5_Right(rect_5) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_1 (table) { Q:"t(-0.2961 -0.2318 0.065) d(149.51 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
cube_1_Left(rect_1) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
cube_1_Right(rect_1) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_4 (table) { Q:"t(0.4359 -0.0449 0.065) d(-87.87 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
rect_4_Left(rect_4) { Q:"t(-0.022 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_4_Right(rect_4) { Q:"t(0.022 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
tri_1 (table) { Q:"t(-0.4323 0.1299 0.065) d(-47.32 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box } }
