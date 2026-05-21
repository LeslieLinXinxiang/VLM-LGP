# Auto-generated | 8cubes_s03 | mode=r
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

obj_01 (table) { Q:"t(0.4360 0.0669 0.065) d(-153.05 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_02 (table) { Q:"t(-0.2577 0.1776 0.065) d(178.78 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_03 (table) { Q:"t(-0.2140 -0.1188 0.065) d(74.91 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_04 (table) { Q:"t(-0.4761 -0.0416 0.065) d(-86.30 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_05 (table) { Q:"t(-0.2746 0.0866 0.065) d(-56.03 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_06 (table) { Q:"t(0.2338 -0.1869 0.065) d(71.69 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_07 (table) { Q:"t(0.3504 0.1427 0.065) d(-75.20 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_08 (table) { Q:"t(0.3338 -0.0251 0.065) d(38.55 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_09 (table) { Q:"t(-0.3882 0.2225 0.065) d(-48.67 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_09_Left(obj_09) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_09_Right(obj_09) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_10 (table) { Q:"t(-0.3212 -0.0147 0.065) d(-157.55 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_10_Left(obj_10) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_10_Right(obj_10) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_11 (table) { Q:"t(0.2054 0.0465 0.065) d(109.23 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_11_Left(obj_11) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_11_Right(obj_11) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_12 (table) { Q:"t(0.3283 -0.1360 0.065) d(-9.81 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_12_Left(obj_12) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_12_Right(obj_12) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_13 (table) { Q:"t(0.3102 0.2380 0.065) d(-16.82 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_13_Left(obj_13) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_13_Right(obj_13) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_14 (table) { Q:"t(-0.2370 -0.2091 0.065) d(115.78 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_14_Left(obj_14) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_14_Right(obj_14) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_15 (table) { Q:"t(0.5045 -0.2357 0.065) d(39.92 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_15_Left(obj_15) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_15_Right(obj_15) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_16 (table) { Q:"t(0.5022 0.2304 0.065) d(-5.41 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_16_Left(obj_16) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_16_Right(obj_16) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
