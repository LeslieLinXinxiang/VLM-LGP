# Auto-generated | 8cubes_s01 | mode=r
world {}
table (world) { shape:ssBox, size:[2.0, 4.0, 0.1, 0.02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

Prefix: "l_"
Include: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" }
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

cube_2 (table) { Q:"t(-0.3998 -0.0654 0.065) d(-82.19 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
cube_3 (table) { Q:"t(0.3086 0.1614 0.065) d(-101.82 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
cube_1 (table) { Q:"t(-0.2365 -0.0467 0.065) d(-152.20 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
cube_4 (table) { Q:"t(0.4482 0.0699 0.065) d(75.42 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
rectprism_6 (table) { Q:"t(-0.4305 0.1051 0.065) d(17.72 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
rectprism_6_Left(rectprism_6) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rectprism_6_Right(rectprism_6) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rectprism_7 (table) { Q:"t(-0.4969 0.0281 0.065) d(-160.70 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
rectprism_7_Left(rectprism_7) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rectprism_7_Right(rectprism_7) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rectprism_8 (table) { Q:"t(0.4384 0.2257 0.065) d(105.79 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
rectprism_8_Left(rectprism_8) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rectprism_8_Right(rectprism_8) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rectprism_3 (table) { Q:"t(-0.2643 0.0393 0.065) d(61.01 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
rectprism_3_Left(rectprism_3) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rectprism_3_Right(rectprism_3) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rectprism_2 (table) { Q:"t(-0.3241 -0.1131 0.065) d(23.76 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
rectprism_2_Left(rectprism_2) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rectprism_2_Right(rectprism_2) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rectprism_1 (table) { Q:"t(0.2357 -0.0245 0.065) d(139.61 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
rectprism_1_Left(rectprism_1) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rectprism_1_Right(rectprism_1) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rectprism_5 (table) { Q:"t(-0.2013 0.1899 0.065) d(53.52 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
rectprism_5_Left(rectprism_5) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rectprism_5_Right(rectprism_5) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rectprism_4 (table) { Q:"t(0.4325 -0.1235 0.065) d(-150.22 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
rectprism_4_Left(rectprism_4) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rectprism_4_Right(rectprism_4) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
longrect_2 (table) { Q:"t(0.4546 -0.2205 0.065) d(10.32 0 0 1)", joint:rigid, shape:ssBox, size:[0.095, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.6, logical:{ is_object, is_box, is_place } }
longrect_2_Left(longrect_2) { Q:"t(-0.038 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
longrect_2_Right(longrect_2) { Q:"t(0.038 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
longrect_2_Center(longrect_2) { Q:"t(0 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
longrect_1 (table) { Q:"t(-0.2314 -0.2259 0.065) d(-31.33 0 0 1)", joint:rigid, shape:ssBox, size:[0.095, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.6, logical:{ is_object, is_box, is_place } }
longrect_1_Left(longrect_1) { Q:"t(-0.038 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
longrect_1_Right(longrect_1) { Q:"t(0.038 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
longrect_1_Center(longrect_1) { Q:"t(0 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
triprism_1 (table) { Q:"t(-0.4541 -0.2129 0.065) d(56.01 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box } }
triprism_2 (table) { Q:"t(-0.3378 0.1601 0.065) d(25.28 0 0 1)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box } }
