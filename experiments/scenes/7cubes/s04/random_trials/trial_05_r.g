# Auto-generated | 7cubes_s04 | mode=r
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


obj_01 (table) { Q:"t(0.3253 0.1455 0.065) d(57.83 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_01_Left(obj_01) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_01_Right(obj_01) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_02 (table) { Q:"t(0.3796 -0.0134 0.065) d(-0.87 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_02_Left(obj_02) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_02_Right(obj_02) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_03 (table) { Q:"t(-0.3628 0.0435 0.065) d(60.82 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_03_Left(obj_03) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_03_Right(obj_03) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_04 (table) { Q:"t(0.4272 0.1702 0.065) d(-161.90 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_04_Left(obj_04) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_04_Right(obj_04) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_05 (table) { Q:"t(-0.4383 0.1429 0.065) d(127.42 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_05_Left(obj_05) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_05_Right(obj_05) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_06 (table) { Q:"t(0.4195 -0.0922 0.065) d(-140.42 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_06_Left(obj_06) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_06_Right(obj_06) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_07 (table) { Q:"t(0.4295 0.0838 0.065) d(172.35 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_07_Left(obj_07) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_07_Right(obj_07) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_08 (table) { Q:"t(-0.3679 -0.0959 0.065) d(45.60 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_08_Left(obj_08) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_08_Right(obj_08) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_09 (table) { Q:"t(-0.3602 0.1880 0.065) d(-36.58 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_09_Left(obj_09) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_09_Right(obj_09) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_10 (table) { Q:"t(-0.3094 0.1112 0.065) d(-149.79 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_10_Left(obj_10) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_10_Right(obj_10) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_11 (table) { Q:"t(-0.4354 -0.0335 0.065) d(17.21 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_11_Left(obj_11) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_11_Right(obj_11) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_12 (table) { Q:"t(0.3017 0.0315 0.065) d(-2.99 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_12_Left(obj_12) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_12_Right(obj_12) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_13 (table) { Q:"t(0.3341 -0.0903 0.065) d(-123.12 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_14 (table) { Q:"t(-0.3123 -0.0270 0.065) d(-62.83 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
