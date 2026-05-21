# full_assembly_scene.g
# Full initial assembly scene for VLM-LGP
# Objects: 8 RectPrism, 2 Cylinder, 4 Cube, 1 TriPrism
# Layout: start zone on table left side (X negative), arm front-center

world {}

# Dedicated support base for both the robot and the table.
# The table sits 11cm above the base, is moved forward in front of the arm,
# and is reduced in footprint to avoid interference with the robot.
base (world) { shape:ssBox, size:[1.3 1.0 .11 .02], Q:"t(0 0 .545)", color:[.45 .45 .45], contact:1 }

table (base) { shape:ssBox, size:[1.0 0.8 .1 .02], Q:"t(0 0.25 .11)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

# -----------------------------------------------------------
# Robot (Panda Arm)
# -----------------------------------------------------------
Prefix: "l_"
Include: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (base): { Q: "t(0 -.3 .05) d(90 0 0 1)" }

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
rectprism_1   (table) { Q:"t(0.196 -0.086 0.066) d(3.0 0 0 1)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[0 .9 .9] , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
rectprism_2   (table) { Q:"t(0.290 -0.010 0.063) d(11.0 0 0 1)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[0 .7 .9] , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
rectprism_3   (table) { Q:"t(0.453 -0.094 0.063) d(14.1 0 0 1)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[0 .5 1.0], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
rectprism_4   (table) { Q:"t(0.310 0.091 0.064) d(-9.5 0 0 1)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[.2 .3 .9], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
rectprism_5   (table) { Q:"t(0.444 0.001 0.065) d(-6.3 0 0 1)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[.9 0 .9] , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
# === LEFT SIDE: 2 Cylinders, 4 Cubes, 1 TriPrism (symmetric to right) ===
triprism_1    (table) { Q:"t(-0.347 0.089 0.061) d(-4.0 0 0 1)",  joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", color:[1 .4 .7], contact:1, mass:.2, logical:{ is_object, is_place } }

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
#
# Table is mounted on the support base and moved forward of the arm.
# Ghost slots remain attached to the table frame so all objects preserve
# their relative layout while the entire assembly is lifted and shifted.
# Naming: Table_Left, Table_Center, Table_Right  (consistent with RectPrism_* slots)
# -----------------------------------------------------------
Table_Left  (table) { Q:"t(-0.08  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Center  (table) { Q:"t(0.00  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Right (table) { Q:"t( 0.08  0.10 .051)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Back (table) { Q:"t( 0.00  0.02 .051)", shape:ssBox, size:[.025 .025 .002 .001], color:[1 1 0 0], contact:0, logical:{ is_place } }
Base_Front (table) { Q:"t( 0.00  0.18 .051)", shape:ssBox, size:[.025 .025 .002 .001], color:[1 1 0 0], contact:0, logical:{ is_place } }


# -----------------------------------------------------------
# Placement Patch Slots — Left / Right on each Rect
#
# Each rect (60x30x30mm) gets two ghost patches on its top surface:
#   Left  patch: x = -0.015 (toward −X, i.e. robot-left)
#   Right patch: x = +0.015 (toward +X, i.e. robot-right)
#   z offset: rect half-height (0.015) + patch half-height (0.0005) = 0.0155
#
# Patch size: 25x25x1mm — non-contact kinematic frames only (is_place).
# Used as terminal targets in LGP step files when position="left"/"right".
# Naming: Rect_N_Left, Rect_N_Right  (capital R to distinguish from parent)
# -----------------------------------------------------------
RectPrism_1_Left  (rectprism_1) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
RectPrism_1_Right (rectprism_1) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
RectPrism_2_Left  (rectprism_2) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
RectPrism_2_Right (rectprism_2) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
RectPrism_3_Left  (rectprism_3) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
RectPrism_3_Right (rectprism_3) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
RectPrism_4_Left  (rectprism_4) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
RectPrism_4_Right (rectprism_4) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
RectPrism_5_Left  (rectprism_5) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
RectPrism_5_Right (rectprism_5) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }

