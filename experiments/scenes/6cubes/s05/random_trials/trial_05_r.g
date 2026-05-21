# Auto-generated | 6cubes_s05 | mode=r
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


obj_01 (table) { Q:"t(-0.3847 -0.0493 0.065) d(-178.86 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_01_Left(obj_01) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_01_Right(obj_01) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_02 (table) { Q:"t(-0.4295 0.1566 0.065) d(155.91 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_02_Left(obj_02) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_02_Right(obj_02) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_03 (table) { Q:"t(0.3231 -0.0815 0.065) d(-146.44 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_03_Left(obj_03) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_03_Right(obj_03) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_04 (table) { Q:"t(-0.4331 0.0632 0.065) d(-76.47 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_04_Left(obj_04) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_04_Right(obj_04) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_05 (table) { Q:"t(-0.3021 0.1077 0.065) d(-12.86 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_05_Left(obj_05) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_05_Right(obj_05) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_06 (table) { Q:"t(0.4470 0.1604 0.065) d(-12.44 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_06_Left(obj_06) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_06_Right(obj_06) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_07 (table) { Q:"t(0.4413 -0.0077 0.065) d(129.78 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_07_Left(obj_07) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_07_Right(obj_07) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_08 (table) { Q:"t(0.3511 0.1542 0.065) d(-159.11 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_08_Left(obj_08) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_08_Right(obj_08) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_09 (table) { Q:"t(0.3307 0.0248 0.065) d(159.66 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_09_Left(obj_09) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_09_Right(obj_09) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_10 (table) { Q:"t(-0.3258 0.0128 0.065) d(-42.10 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_10_Left(obj_10) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_10_Right(obj_10) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_11 (table) { Q:"t(-0.3004 -0.0817 0.065) d(-40.40 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_11_Left(obj_11) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_11_Right(obj_11) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_12 (table) { Q:"t(0.4241 0.0758 0.065) d(-176.74 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
obj_12_Left(obj_12) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
obj_12_Right(obj_12) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
