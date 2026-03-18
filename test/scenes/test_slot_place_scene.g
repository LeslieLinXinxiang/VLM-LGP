# test_slot_place_scene.g
# Test: place cube1 on Left_slot and cube2 on Right_slot
# Both slots are child frames on top of a RectPrism

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
# RectPrism (60x30x30mm) — placed in front of arm
# Top surface at Z_world = 0.65 + 0.03 = 0.68
# Top surface relative to table center: 0.065 + 0.015 = 0.08 above table center
#   => Q z = 0.065 from table (center of RectPrism = table_top + half_height = 0.05 + 0.015)
# -----------------------------------------------------------
rect_base (table) { Q:"t(0 0.15 .065)", joint:rigid, shape:ssBox, size:[.06 .03 .03 .001], color:[0 .7 .9], contact:1, mass:.2, logical:{ is_object, is_box, is_place } }

# -----------------------------------------------------------
# Slot markers on top surface of rect_base
# RectPrism half-height = 0.015 → top surface at +0.015 from RectPrism center
# Slot thickness = 0.002, so slot center Z = 0.015 + 0.001 = 0.016
# Left half: X = -0.015 (left 30mm), Right half: X = +0.015 (right 30mm)
# Each slot: 30x30mm
# -----------------------------------------------------------
Left_slot  (rect_base) { Q:"t(-0.015 0 0.016)", shape:ssBox, size:[.03 .03 .002 .001], color:[1 .2 .2], contact:0, logical:{ is_place } }
Right_slot (rect_base) { Q:"t( 0.015 0 0.016)", shape:ssBox, size:[.03 .03 .002 .001], color:[.2 .8 .2], contact:0, logical:{ is_place } }

# -----------------------------------------------------------
# Two cubes (30x30x30mm) — placed to either side, waiting to be picked
# -----------------------------------------------------------
cube1 (table) { Q:"t(-0.20 0.10 .065)", joint:rigid, shape:ssBox, size:[.03 .03 .03 .001], color:[1 .4 .1], contact:1, mass:.2, logical:{ is_object, is_box } }
cube2 (table) { Q:"t( 0.20 0.10 .065)", joint:rigid, shape:ssBox, size:[.03 .03 .03 .001], color:[.5 .1 .9], contact:1, mass:.2, logical:{ is_object, is_box } }
