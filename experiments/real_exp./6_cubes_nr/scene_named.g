# Auto-generated | 6cubes_s05 | mode=nr
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


rect_2 (table) { Q:"t(0.1340 0.0274 0.065) d(-110.41 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
rect_1_Left(rect_2) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_1_Right(rect_2) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_3 (table) { Q:"t(-0.2891 -0.0592 0.065) d(-119.04 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
rect_2_Left(rect_3) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_2_Right(rect_3) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_6 (table) { Q:"t(-0.1466 0.2190 0.065) d(37.31 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
rect_3_Left(rect_6) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_3_Right(rect_6) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_5 (table) { Q:"t(-0.2704 0.1574 0.065) d(161.40 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
rect_4_Left(rect_5) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_4_Right(rect_5) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_1 (table) { Q:"t(0.1283 -0.0882 0.065) d(35.29 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
rect_5_Left(rect_1) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_5_Right(rect_1) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_4 (table) { Q:"t(0.2247 0.1552 0.065) d(137.86 0 0 1)", joint:rigid, shape:ssBox, size:[0.065, 0.03, 0.03, 0.001], color:[.9 .6 .1], contact:1, mass:0.4, logical:{ is_object, is_box, is_place } }
rect_6_Left(rect_4) { Q:"t(-0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
rect_6_Right(rect_4) { Q:"t(0.026 0 0.016)", shape:marker, size:[.01], color:[0 1 1 0], logical:{ is_place:True } }
