# full_assembly_scene.g
# Full initial assembly scene for VLM-LGP
# Objects: 8 RectPrism, 2 Cylinder, 4 Cube, 1 TriPrism
# Layout: start zone on table left side (X negative), arm front-center

world {}

table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

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


# -----------------------------------------------------------
# Start Zone Layout (symmetric left/right, both in front of arm)
#
# Arm at (0, -0.3), facing +Y. Panda reach ~0.85m.
#
# RIGHT SIDE (+X): 8 RectPrisms, 2 columns × 4 rows
#           X=+0.30   X=+0.45
# Y=-0.10:  [rect1]   [rect5]
# Y= 0.00:  [rect2]   [rect6]
# Y=+0.10:  [rect3]   [rect7]
# Y=+0.20:  [rect4]   [rect8]
#
# LEFT SIDE (-X): 2 Cylinders + 4 Cubes + 1 TriPrism (symmetric)
#           X=-0.30   X=-0.45
# Y=-0.10:  [cyl1]    [cube3]
# Y= 0.00:  [cyl2]    [cube4]
# Y=+0.10:  [cube1]   [TriPrism]
# Y=+0.20:  [cube2]   (empty)
# -----------------------------------------------------------

# === RIGHT SIDE: 8 RectPrisms (60x30x30mm), 2 columns × 4 rows ===
rect1 (table) { Q:"t(0.30 -0.10 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[0 .9 .9],  contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
rect2 (table) { Q:"t(0.30  0.00 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[0 .7 .9],  contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
rect3 (table) { Q:"t(0.30  0.10 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[0 .5 1.0], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
rect4 (table) { Q:"t(0.30  0.20 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[.2 .3 .9], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
rect5 (table) { Q:"t(0.45 -0.10 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[.9 0 .9],  contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
rect6 (table) { Q:"t(0.45  0.00 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[.7 0 .9],  contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
rect7 (table) { Q:"t(0.45  0.10 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[.5 0 .8],  contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
rect8 (table) { Q:"t(0.45  0.20 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[.3 0 .7],  contact:1, mass:.2, logical:{ is_object, is_box, is_place } }

# === LEFT SIDE: 2 Cylinders, 4 Cubes, 1 TriPrism (symmetric to right) ===
cyl1     (table) { Q:"t(-0.30 -0.10 .065)", joint:rigid, shape:cylinder, size:[.03 .015],         color:[0 .8 0],   contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place } }
cyl2     (table) { Q:"t(-0.30  0.00 .065)", joint:rigid, shape:cylinder, size:[.03 .015],         color:[.4 1 .2],  contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place } }
cube1    (table) { Q:"t(-0.30  0.10 .065)", joint:rigid, shape:ssBox,    size:[.03 .03 .03 .001], color:[1 .5 0],   contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
cube2    (table) { Q:"t(-0.30  0.20 .065)", joint:rigid, shape:ssBox,    size:[.03 .03 .03 .001], color:[1 .8 0],   contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
cube3    (table) { Q:"t(-0.45 -0.10 .065)", joint:rigid, shape:ssBox,    size:[.03 .03 .03 .001], color:[.9 .3 .1], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
cube4    (table) { Q:"t(-0.45  0.00 .065)", joint:rigid, shape:ssBox,    size:[.03 .03 .03 .001], color:[.8 .1 .1], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
TriPrism (table) { Q:"t(-0.45  0.10 .05)",  joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", color:[1 .4 .7], contact:1, mass:.2, logical:{ is_object, is_place } }

# -----------------------------------------------------------
# 5 Fixed placement slots on base_board
# -----------------------------------------------------------
Table_Left   (base_board) { Q:"t( 0.000 0.000  0.080) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Right  (base_board) { Q:"t(0.000 0.000 -0.080) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Front  (base_board) { Q:"t(0.059 0.000 0.000) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Back   (base_board) { Q:"t(-0.061 0.000 0.000) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Center (base_board) { Q:"t(00 0.000 0.000) d(-90 1 0 0) ", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }

# -----------------------------------------------------------
# Top-surface slots on cube1 and cube2
# Cube: 30x30x30mm  → half-height = 0.015 → slot at +0.016
# These slots are targeted by place_straightOn when stacking.
# -----------------------------------------------------------
top_slot_cube1 (cube1) { Q:"t(0 0 0.016)", shape:ssBox, size:[.025 .025 .002 .001], color:[.9 .9 0], contact:0, logical:{ is_place } }
top_slot_cube2 (cube2) { Q:"t(0 0 0.016)", shape:ssBox, size:[.025 .025 .002 .001], color:[.9 .9 0], contact:0, logical:{ is_place } }

