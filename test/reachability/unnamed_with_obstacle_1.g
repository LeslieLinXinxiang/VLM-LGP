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
obj_02   (table) { Q:"t(0.30  -0.10 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[0 .9 .9] , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
obj_04   (table) { Q:"t(0.30   0.00 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[0 .7 .9] , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
obj_06   (table) { Q:"t(0.45  -0.10 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[0 .5 1.0], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
obj_08   (table) { Q:"t(0.30   0.10 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[.2 .3 .9], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
obj_10   (table) { Q:"t(0.45   0.00 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[.9 0 .9] , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
obj_12   (table) { Q:"t(0.30   0.20 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[.7 0 .9] , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
obj_14   (table) { Q:"t(0.45   0.10 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[.5 0 .8] , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
obj_15   (table) { Q:"t(0.45   0.20 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[.3 0 .7] , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }

# === LEFT SIDE: 2 Cylinders, 4 Cubes, 1 TriPrism (symmetric to right) ===
obj_01    (table) { Q:"t(-0.30  -0.10 .065)", joint:rigid, shape:cylinder, size:[.03 .015]        , color:[0 .8 0]  , contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place } }
obj_03    (table) { Q:"t(-0.30   0.00 .065)", joint:rigid, shape:cylinder, size:[.03 .015]        , color:[.4 1 .2] , contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place } }
obj_05   (table) { Q:"t(-0.45  -0.10 .065)", joint:rigid, shape:ssBox, size:[.03 .03 .03 .001], color:[1 .5 0]  , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
obj_07   (table) { Q:"t(-0.30   0.10 .065)", joint:rigid, shape:ssBox, size:[.03 .03 .03 .001], color:[1 .8 0]  , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
obj_09   (table) { Q:"t(-0.45   0.00 .065)", joint:rigid, shape:ssBox, size:[.03 .03 .03 .001], color:[.9 .3 .1], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
obj_11   (table) { Q:"t(-0.30   0.20 .065)", joint:rigid, shape:ssBox, size:[.03 .03 .03 .001], color:[.8 .1 .1], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
obj_13    (table) { Q:"t(-0.45   0.10 .05)",  joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", color:[1 .4 .7], contact:1, mass:.2, logical:{ is_object, is_place } }

# -----------------------------------------------------------
# Overhead obstacle above right-half object region for ESDF test
# Name intentionally follows obstacle_x convention.
# -----------------------------------------------------------
obstacle_1 (world) { Q:"t(0.38 0.05 0.80)", joint:rigid, shape:ssBox, size:[.50 .34 .02 .001], color:[.2 .2 .2], contact:1, logical:{ is_place } }

# -----------------------------------------------------------
# 5 Placement Bases — Cross Pattern (top-down view)
# Arm at (0, -0.3), bases centered in front work zone
#
#      Base_Top    (Y=-0.03, closer to arm)
#          |
# Base_Left - Base_Center - Base_Right  (Y=0.05, 8cm apart)
#          |
#      Base_Bottom (Y=0.13, farther from arm)
#
# Colored yellow to confirm placement, then set transparent.
# Size: 25x25mm (matches Cube footprint), thin (2mm)
# -----------------------------------------------------------
Base_Center (table) { Q:"t( 0.00  0.10 .051)", shape:ssBox, size:[.025 .025 .002 .001], color:[1 1 0 0], contact:0, logical:{ is_place } }
Base_Left   (table) { Q:"t(-0.08  0.10 .051)", shape:ssBox, size:[.025 .025 .002 .001], color:[1 1 0 0], contact:0, logical:{ is_place } }
Base_Right  (table) { Q:"t( 0.08  0.10 .051)", shape:ssBox, size:[.025 .025 .002 .001], color:[1 1 0 0], contact:0, logical:{ is_place } }
Base_Top    (table) { Q:"t( 0.00  0.02 .051)", shape:ssBox, size:[.025 .025 .002 .001], color:[1 1 0 0], contact:0, logical:{ is_place } }
Base_Bottom (table) { Q:"t( 0.00  0.18 .051)", shape:ssBox, size:[.025 .025 .002 .001], color:[1 1 0 0], contact:0, logical:{ is_place } }

# -----------------------------------------------------------
# Placement Patch Slots — Left / Right on the Table (for layer-1 objects)
# -----------------------------------------------------------
Table_Left  (table) { Q:"t(-0.05  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Right (table) { Q:"t( 0.05  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }

# -----------------------------------------------------------
# Placement Patch Slots — Left / Right on each Rect
# -----------------------------------------------------------
Rect_1_Left  (obj_02) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_1_Right (obj_02) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_2_Left  (obj_04) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_2_Right (obj_04) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_3_Left  (obj_06) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_3_Right (obj_06) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_4_Left  (obj_08) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_4_Right (obj_08) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_5_Left  (obj_10) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_5_Right (obj_10) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_6_Left  (obj_12) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_6_Right (obj_12) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_7_Left  (obj_14) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_7_Right (obj_14) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_8_Left  (obj_15) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_8_Right (obj_15) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
