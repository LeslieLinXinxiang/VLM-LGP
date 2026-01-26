# --- START OF FILE world.g ---

world {}

table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

Prefix: "l_"
Include: <../../rai/test/newLGP/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" }

# --- RETRACT POSE ---
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
# Cylinders (obj_01 ~ obj_08)
# height = 0.1m, radius = 0.03m
# z = 0.05 (table half) + 0.05 (half height)
# -----------------------------------------------------------

obj_01 (table) { Q:"t(-0.5 0 .1)", joint:rigid, shape:cylinder, size:[.1 .03], color:[0 .8 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 
obj_02 (table) { Q:"t(-0.5 -0.15 .1)", joint:rigid, shape:cylinder, size:[.1 .03], color:[1 .9 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 
obj_03 (table) { Q:"t(-0.6 0 .1)", joint:rigid, shape:cylinder, size:[.1 .03], color:[0 .9 .9], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 
obj_04 (table) { Q:"t(-0.6 -0.15 .1)", joint:rigid, shape:cylinder, size:[.1 .03], color:[.9 0 .9], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 
obj_05 (table) { Q:"t(-0.7 0 .1)", joint:rigid, shape:cylinder, size:[.1 .03], color:[1 .5 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 
obj_06 (table) { Q:"t(-0.7 -0.15 .1)", joint:rigid, shape:cylinder, size:[.1 .03], color:[.5 0 .8], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 
obj_07 (table) { Q:"t(-0.8 0 .1)", joint:rigid, shape:cylinder, size:[.1 .03], color:[1 .4 .7], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 
obj_08 (table) { Q:"t(-0.8 -0.15 .1)", joint:rigid, shape:cylinder, size:[.1 .03], color:[.6 .3 .1], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 

# -----------------------------------------------------------
# Marker
# -----------------------------------------------------------
place_obj_09 (table) { Q:[0 0.35 .05], shape:ssBox, size:[.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }

# -----------------------------------------------------------
# Base obj_09 (Grey)
# -----------------------------------------------------------

obj_09 (table) { Q:"t(0.45 0.15 .06)", joint:rigid, shape:ssBox, size:[.25 .25 .02 .002], color:[.8 .8 .8], contact:1, mass:.5, logical:{ is_object, is_place } } 
obj_09_handle (obj_09) { Q:"t(0 0 .03)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } }

bottom_left_obj_09   (obj_09) { Q:[0.075 0.075 .01],   shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
bottom_right_obj_09  (obj_09) { Q:[-0.075 0.075 .01],  shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
top_left_obj_09      (obj_09) { Q:[0.075 -0.075 .01],  shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
top_right_obj_09     (obj_09) { Q:[-0.075 -0.075 .01], shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
top_center_obj_09    (obj_09) { Q:[0 -0.075 .01],      shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
bottom_center_obj_09 (obj_09) { Q:[0 0.075 .01],       shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
mid_left_obj_09      (obj_09) { Q:[0.075 0 .01],       shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
mid_right_obj_09     (obj_09) { Q:[-0.075 0 .01],      shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }

# -----------------------------------------------------------
# Base obj_10 (Red)
# -----------------------------------------------------------

obj_10 (table) { Q:"t(0.45 -0.23 .06)", joint:rigid, shape:ssBox, size:[.25 .25 .02 .002], color:[.9 .1 .1], contact:1, mass:.5, logical:{ is_object, is_place } } 
obj_10_handle (obj_10) { Q:"t(0 0 .03)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } }

bottom_left_obj_10   (obj_10) { Q:[0.075 0.075 .01],   shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
bottom_right_obj_10  (obj_10) { Q:[-0.075 0.075 .01],  shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
top_left_obj_10      (obj_10) { Q:[0.075 -0.075 .01],  shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
top_right_obj_10     (obj_10) { Q:[-0.075 -0.075 .01], shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
top_center_obj_10    (obj_10) { Q:[0 -0.075 .01],      shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
bottom_center_obj_10 (obj_10) { Q:[0 0.075 .01],       shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
mid_left_obj_10      (obj_10) { Q:[0.075 0 .01],       shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
mid_right_obj_10     (obj_10) { Q:[-0.075 0 .01],      shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }

# -----------------------------------------------------------
# Base obj_11 (Blue)
# -----------------------------------------------------------

obj_11 (table) { Q:"t(0.45 -0.61 .06)", joint:rigid, shape:ssBox, size:[.25 .25 .02 .002], color:[.1 .1 .9], contact:1, mass:.5, logical:{ is_object, is_place } } 
obj_11_handle (obj_11) { Q:"t(0 0 .03)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } }

bottom_left_obj_11   (obj_11) { Q:[0.075 0.075 .01],   shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
bottom_right_obj_11  (obj_11) { Q:[-0.075 0.075 .01],  shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
top_left_obj_11      (obj_11) { Q:[0.075 -0.075 .01],  shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
top_right_obj_11     (obj_11) { Q:[-0.075 -0.075 .01], shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
top_center_obj_11    (obj_11) { Q:[0 -0.075 .01],      shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
bottom_center_obj_11 (obj_11) { Q:[0 0.075 .01],       shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
mid_left_obj_11      (obj_11) { Q:[0.075 0 .01],       shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }
mid_right_obj_11     (obj_11) { Q:[-0.075 0 .01],      shape:ssBox, size:[.03 .03 .001 .001], contact:0, logical:{ is_place } }

