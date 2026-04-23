# test_2supports_scene.g
# Isolated test for place_on_2_supports predicate.
# Setup: Panda arm + 2 cubes side by side (supports) + 1 RectPrism to be placed on top.

world {}

table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

# -----------------------------------------------------------
# Robot (Panda Arm)
# -----------------------------------------------------------
Prefix: "l_"
Include: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" }

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
# Two cubes side by side — act as the two supports
# Cubes: 30x30x30mm, gap between them = 30mm (RectPrism is 60mm wide, will span both)
# Place them at Y=0.10 in front of the arm (centered on X)
# -----------------------------------------------------------
cube_L (table) { Q:"t(-0.02 0.10 .065)", joint:rigid, shape:ssBox, size:[.03 .03 .03 .001], color:[1 .5 0], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
cube_R (table) { Q:"t( 0.02 0.10 .065)", joint:rigid, shape:ssBox, size:[.03 .03 .03 .001], color:[1 .8 0], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }

# -----------------------------------------------------------
# RectPrism — to be picked and placed across the two cubes
# 60x30x30mm, placed to the side initially
# -----------------------------------------------------------
RectPrism (table) { Q:"t(0.30 0.10 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[0 .7 .9], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }
