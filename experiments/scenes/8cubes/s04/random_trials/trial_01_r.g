# Auto-generated | 8cubes_s04 | mode=r
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

obj_01 (table) { Q:"t(-0.2386 -0.0912 0.065) d(168.82 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_02 (table) { Q:"t(0.3340 -0.1448 0.065) d(-40.33 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_03 (table) { Q:"t(0.4993 0.0226 0.065) d(170.18 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_04 (table) { Q:"t(0.2871 0.2230 0.065) d(-74.38 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_05 (table) { Q:"t(-0.4069 -0.1392 0.065) d(104.43 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_06 (table) { Q:"t(0.2073 -0.1995 0.065) d(-76.76 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_07 (table) { Q:"t(-0.3729 0.1944 0.065) d(76.47 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_08 (table) { Q:"t(-0.4473 0.0182 0.065) d(-94.42 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_09 (table) { Q:"t(-0.4985 0.1602 0.065) d(-69.62 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_10 (table) { Q:"t(0.2169 0.0396 0.065) d(-100.97 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_11 (table) { Q:"t(-0.3212 -0.1405 0.065) d(-136.33 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_12 (table) { Q:"t(-0.4964 -0.1218 0.065) d(-56.16 0 0 1)", joint:rigid, shape:ssBox, size:[0.03, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_13 (table) { Q:"t(0.4085 0.1301 0.065) d(154.04 0 0 1)", joint:rigid, shape:ssBox, size:[0.095, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.6, logical:{ is_object, is_box, is_place } }
obj_13_Left(obj_13) { Q:"t(-0.038 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_13_Right(obj_13) { Q:"t(0.038 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_13_Center(obj_13) { Q:"t(0 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_14 (table) { Q:"t(-0.2838 -0.0144 0.065) d(17.00 0 0 1)", joint:rigid, shape:ssBox, size:[0.095, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.6, logical:{ is_object, is_box, is_place } }
obj_14_Left(obj_14) { Q:"t(-0.038 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_14_Right(obj_14) { Q:"t(0.038 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_14_Center(obj_14) { Q:"t(0 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_15 (table) { Q:"t(0.3736 -0.0266 0.065) d(-153.53 0 0 1)", joint:rigid, shape:ssBox, size:[0.095, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.6, logical:{ is_object, is_box, is_place } }
obj_15_Left(obj_15) { Q:"t(-0.038 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_15_Right(obj_15) { Q:"t(0.038 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_15_Center(obj_15) { Q:"t(0 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_16 (table) { Q:"t(-0.2491 0.0878 0.065) d(123.70 0 0 1)", joint:rigid, shape:ssBox, size:[0.095, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.6, logical:{ is_object, is_box, is_place } }
obj_16_Left(obj_16) { Q:"t(-0.038 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_16_Right(obj_16) { Q:"t(0.038 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_16_Center(obj_16) { Q:"t(0 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
