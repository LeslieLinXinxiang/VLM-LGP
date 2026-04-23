# full_assembly_scene.g
# Full initial assembly scene for VLM-LGP
# =============================================================
# 1:1 DIGITAL TWIN COORDINATE SYSTEM (Unified with MuJoCo):
#   Origin:  Robot base (panda_link0) = world (0, 0, 0)
#   +X:      Robot forward direction
#   +Y:      Robot left
#   +Z:      Up
#   z=0:     Table surface / robot base plane
# =============================================================

world {}

# Table surface at z=0. To cover the workspace, centered at X=0.35.
table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0.35 0 -.05)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

# -----------------------------------------------------------
# Robot (Panda Arm)
# Base at origin, facing +X. Exactly matches MuJoCo panda.xml.
# -----------------------------------------------------------
Prefix: "l_"
Include: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (world): { Q: "t(0 0 0)" }

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
# Workpieces (1:1 Coords from scene_block.xml)
# Note: d(-90 1 0 0) applies same orientation logic as quat in MJ.
# -----------------------------------------------------------

# === RIGHT SIDE (negative Y) ===
rect_1   (world) { Q:"t(0.20 -0.30 0.015) d(-90 1 0 0)", joint:rigid, shape:ssBox, size:[.03 .015 .015 .001], color:[0 .9 .9] , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
rect_2   (world) { Q:"t(0.30 -0.30 0.015) d(-90 1 0 0)", joint:rigid, shape:ssBox, size:[.03 .015 .015 .001], color:[0 .7 .9] , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
rect_3   (world) { Q:"t(0.20 -0.45 0.015) d(-90 1 0 0)", joint:rigid, shape:ssBox, size:[.03 .015 .015 .001], color:[0 .5 1.0], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
rect_4   (world) { Q:"t(0.40 -0.30 0.015) d(-90 1 0 0)", joint:rigid, shape:ssBox, size:[.03 .015 .015 .001], color:[.2 .3 .9], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
rect_5   (world) { Q:"t(0.30 -0.45 0.015) d(-90 1 0 0)", joint:rigid, shape:ssBox, size:[.03 .015 .015 .001], color:[.9 0 .9] , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
rect_6   (world) { Q:"t(0.50 -0.30 0.015) d(-90 1 0 0)", joint:rigid, shape:ssBox, size:[.03 .015 .015 .001], color:[.7 0 .9] , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
rect_7   (world) { Q:"t(0.40 -0.45 0.015) d(-90 1 0 0)", joint:rigid, shape:ssBox, size:[.03 .015 .015 .001], color:[.5 0 .8] , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
rect_8   (world) { Q:"t(0.50 -0.45 0.015) d(-90 1 0 0)", joint:rigid, shape:ssBox, size:[.03 .015 .015 .001], color:[.3 0 .7] , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }

# === LEFT SIDE (positive Y) ===
cyl_1    (world) { Q:"t(0.20  0.30 0.015) d(-90 1 0 0)", joint:rigid, shape:cylinder, size:[.03 .015]         , color:[0 .8 0]  , contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place } }
cyl_2    (world) { Q:"t(0.30  0.30 0.015) d(-90 1 0 0)", joint:rigid, shape:cylinder, size:[.03 .015]         , color:[.4 1 .2] , contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place } }
cube_1   (world) { Q:"t(0.20  0.45 0.015) d(-90 1 0 0)", joint:rigid, shape:ssBox, size:[.015 .015 .015 .001], color:[1 .5 0]  , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
cube_2   (world) { Q:"t(0.40  0.30 0.015) d(-90 1 0 0)", joint:rigid, shape:ssBox, size:[.015 .015 .015 .001], color:[1 .8 0]  , contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
cube_3   (world) { Q:"t(0.30  0.45 0.015) d(-90 1 0 0)", joint:rigid, shape:ssBox, size:[.015 .015 .015 .001], color:[.9 .3 .1], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
cube_4   (world) { Q:"t(0.50  0.30 0.015) d(-90 1 0 0)", joint:rigid, shape:ssBox, size:[.015 .015 .015 .001], color:[.8 .1 .1], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
tri_1    (world) { Q:"t(0.40  0.45 0.020) d(-90 1 0 0)", joint:rigid, shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", color:[1 .4 .7], contact:1, mass:.2, logical:{ is_object, is_place } }

# -----------------------------------------------------------
# 5 Placement Bases — Cross Pattern (1:1 with MJ)
# -----------------------------------------------------------
Base_Center (world) { Q:"t( 0.30  0.00 0.001)", shape:ssBox, size:[.025 .025 .002 .001], color:[1 1 0 0], contact:0, logical:{ is_place } }
Base_Left   (world) { Q:"t( 0.30  0.08 0.001)", shape:ssBox, size:[.025 .025 .002 .001], color:[1 1 0 0], contact:0, logical:{ is_place } }
Base_Right  (world) { Q:"t( 0.30 -0.08 0.001)", shape:ssBox, size:[.025 .025 .002 .001], color:[1 1 0 0], contact:0, logical:{ is_place } }
Base_Top    (world) { Q:"t( 0.22  0.00 0.001)", shape:ssBox, size:[.025 .025 .002 .001], color:[1 1 0 0], contact:0, logical:{ is_place } }
Base_Bottom (world) { Q:"t( 0.38  0.00 0.001)", shape:ssBox, size:[.025 .025 .002 .001], color:[1 1 0 0], contact:0, logical:{ is_place } }

# -----------------------------------------------------------
# Placement Patch Slots
# -----------------------------------------------------------
Table_Left  (world) { Q:"t( 0.30  0.05 0.001)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Right (world) { Q:"t( 0.30 -0.05 0.001)", shape:ssBox, size:[.025 .025 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }

# -----------------------------------------------------------
# Placement Patch Slots — Object Relative (Unchanged)
# -----------------------------------------------------------
Rect_1_Left  (rect_1) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_1_Right (rect_1) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_2_Left  (rect_2) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_2_Right (rect_2) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_3_Left  (rect_3) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_3_Right (rect_3) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_4_Left  (rect_4) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_4_Right (rect_4) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_5_Left  (rect_5) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_5_Right (rect_5) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_6_Left  (rect_6) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_6_Right (rect_6) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_7_Left  (rect_7) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_7_Right (rect_7) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_8_Left  (rect_8) { Q:"t(-0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
Rect_8_Right (rect_8) { Q:"t( 0.015 0 0.0155)", shape:ssBox, size:[.025 .025 .001 .0005], color:[1 .8 0 0], contact:0, logical:{ is_place } }
