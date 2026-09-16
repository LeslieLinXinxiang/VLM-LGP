# full_assembly_scene.g
# Full initial assembly scene for VLM-LGP
# Objects: 8 RectPrism, 2 Cylinder, 4 Cube, 1 TriPrism
# Layout: start zone on table left side (X negative), arm front-center

world {}

table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.96 .89 .72], contact:1, logical:{ is_place } }

# -----------------------------------------------------------
# Robot (Panda Arm)
# -----------------------------------------------------------
Prefix: "l_"
Include: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" }

# --- Retract Pose ---
Edit l_panda_joint2 { q: -1.5 }
Edit l_panda_joint4 { q: -2.5 }
Edit l_panda_joint6 { q: 1.5 }
Edit l_panda_joint1 { q: 0.0 }
Edit l_panda_joint3 { q: 0.0 }
Edit l_panda_joint5 { q: 0.0 }
Edit l_panda_joint7 { q: 0.0 }
Edit l_panda_finger_joint1 { q: 0.04 }
Edit l_panda_finger_joint2 { q: 0.04 }


Table_Left   (table) { Q:"t(-0.08  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Center (table) { Q:"t( 0.00  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Right  (table) { Q:"t( 0.08  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }

# === Type A ablation scene 5 (crowding, 0cm gap, inward face) ===
cube_1 (table) { Q:"t(0.0000 0.1000 .065)", joint:rigid, shape:ssBox, size:[.03 .03 .03 .001], color:[1 1 1], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
cube_2 (table) { Q:"t(0.2250 0.0897 .065)", joint:rigid, shape:ssBox, size:[.03 .03 .03 .001], color:[1 1 1], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
cube_3 (table) { Q:"t(-0.2500 0.1330 .065)", joint:rigid, shape:ssBox, size:[.03 .03 .03 .001], color:[1 1 1], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
cube_4 (table) { Q:"t(-0.1928 -0.5298 .065)", joint:rigid, shape:ssBox, size:[.03 .03 .03 .001], color:[1 1 1], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
filler_1 (table) { Q:"t(-0.1736 -0.5068 .065)", joint:rigid, shape:ssBox, size:[.03 .03 .03 .001], color:[1 1 1], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
