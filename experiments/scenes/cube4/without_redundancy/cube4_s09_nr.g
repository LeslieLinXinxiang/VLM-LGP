# Auto-generated anonymous scene | cube4_s09 | mode=nr
world {}

table (world) { shape:ssBox, size:[2.0 4.0 0.1 0.02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

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

# work_region x=[-0.1, 0.1], y=[0.08, 0.28]
# left_init x=[-0.52, -0.2], y=[-0.24, 0.24]
# right_init x=[0.2, 0.52], y=[-0.24, 0.24]
Work_Center (table) { Q:"t(0.40 0.00 .051)", shape:ssBox, size:[.04 .04 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Init_Center (table) { Q:"t(-0.36 0.00 .051)", shape:ssBox, size:[.04 .04 .001 .0005], color:[1 1 0 0], contact:0, logical:{ is_place } }

obj_01 (table) { Q:"t(0.4521 0.2052 0.065) d(63.0656 0 0 1)", joint:rigid, shape:ssBox, size:[0.03 0.03 0.03 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_02 (table) { Q:"t(0.3758 0.1561 0.065) d(-158.1022 0 0 1)", joint:rigid, shape:ssBox, size:[0.03 0.03 0.03 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_03 (table) { Q:"t(-0.4875 -0.2264 0.065) d(166.4734 0 0 1)", joint:rigid, shape:ssBox, size:[0.03 0.03 0.03 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
obj_04 (table) { Q:"t(-0.2856 0.029 0.065) d(81.4342 0 0 1)", joint:rigid, shape:ssBox, size:[0.03 0.03 0.03 0.001], color:[.9 .6 .1], contact:1, mass:0.2, logical:{ is_object, is_box, is_place } }
