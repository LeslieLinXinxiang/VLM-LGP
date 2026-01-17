# --- START OF FILE world.g ---

# 固定抬头 (保持不变)
world {}

table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

Prefix: "l_"
Include: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/problems/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" }

# --- RETRACT POSE (HOMING FIX) ---
Edit l_panda_joint2 { q: -1.5 }
Edit l_panda_joint4 { q: -2.5 }
Edit l_panda_joint6 { q: 1.5 }
Edit l_panda_joint1 { q: 0.0 }
Edit l_panda_joint3 { q: 0.0 }
Edit l_panda_joint5 { q: 0.0 }
Edit l_panda_joint7 { q: 0.0 }
Edit l_panda_finger_joint1 { q: 0.04 }
Edit l_panda_finger_joint2 { q: 0.04 }

# ---
# 匿名圆柱体群 (Cylinders -> obj_01~08)
# -----------------------------------------------------------
# Green
obj_01 (table) { Q:"t(-0.4 0.2 .085)", joint:rigid, shape:cylinder, size:[.07 .03], color:[0 .8 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 
# Yellow
obj_02 (table) { Q:"t(-0.4 .1 .085)", joint:rigid, shape:cylinder, size:[.07 .03], color:[1 .9 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 
# Cyan
obj_03 (table) { Q:"t(-0.55 0.15 .085)", joint:rigid, shape:cylinder, size:[.07 .03], color:[0 .9 .9], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 
# Magenta
obj_04 (table) { Q:"t(-0.55 0 .085)", joint:rigid, shape:cylinder, size:[.07 .03], color:[.9 0 .9], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 
# Orange
obj_05 (table) { Q:"t(-0.65 0. .085)", joint:rigid, shape:cylinder, size:[.07 .03], color:[1 .5 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 
# Purple
obj_06 (table) { Q:"t(-0.65 -0.15 .085)", joint:rigid, shape:cylinder, size:[.07 .03], color:[.5 0 .8], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 
# Pink
obj_07 (table) { Q:"t(-0.8 0. .085)", joint:rigid, shape:cylinder, size:[.07 .03], color:[1 .4 .7], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 
# Chocolate
obj_08 (table) { Q:"t(-0.8 -0.15 .085)", joint:rigid, shape:cylinder, size:[.07 .03], color:[.6 .3 .1], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 

# ---
# 视觉标记 (Target Marker -> obj_marker_01)
# -----------------------------------------------------------
place_obj_09 (table) { Q: [0 0.35 .05], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }


# ---
# 匿名底座群 (Bases -> obj_09~11)
# [CRITICAL UPDATE]: Renamed all frames to match VLM's 2D Native Vocabulary
# -----------------------------------------------------------

# --- Grey Base Group (obj_09) ---
obj_09 (table) { Q:"t(0.45 0.15 .065)", joint:rigid, shape:ssBox, size:[.45 .35 .03 .002], color:[.8 .8 .8], contact:1, mass:.5, logical:{ is_object, is_place } } 
obj_09_handle (obj_09) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } } 

bottom_left_obj_09 (obj_09)   { Q: [0.15 0.1 .015],   shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
bottom_right_obj_09 (obj_09)  { Q: [-0.15 0.1 .015],  shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
top_left_obj_09 (obj_09)      { Q: [0.15 -0.1 .015],  shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
top_right_obj_09 (obj_09)     { Q: [-0.15 -0.1 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }

top_center_obj_09 (obj_09)    { Q: [0 -0.1 .015],     shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
bottom_center_obj_09 (obj_09) { Q: [0 0.1 .015],      shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
mid_left_obj_09 (obj_09)      { Q: [0.15 0 .015],     shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
mid_right_obj_09 (obj_09)     { Q: [-0.15 0 .015],    shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }


# --- Red Base Group (obj_10) ---
obj_10 (table) { Q:"t(0.45 -0.23 .065)", joint:rigid, shape:ssBox, size:[.45 .35 .03 .002], color:[.9 .1 .1], contact:1, mass:.5, logical:{ is_object, is_place } } 
obj_10_handle (obj_10) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } }

bottom_left_obj_10 (obj_10)   { Q: [0.15 0.1 .015],   shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
bottom_right_obj_10 (obj_10)  { Q: [-0.15 0.1 .015],  shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
top_left_obj_10 (obj_10)      { Q: [0.15 -0.1 .015],  shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
top_right_obj_10 (obj_10)     { Q: [-0.15 -0.1 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }

top_center_obj_10 (obj_10)    { Q: [0 -0.1 .015],     shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
bottom_center_obj_10 (obj_10) { Q: [0 0.1 .015],      shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
mid_left_obj_10 (obj_10)      { Q: [0.15 0 .015],     shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
mid_right_obj_10 (obj_10)     { Q: [-0.15 0 .015],    shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }


# --- Blue Base Group (obj_11) ---
obj_11 (table) { Q:"t(0.45 -0.61 .065)", joint:rigid, shape:ssBox, size:[.45 .35 .03 .002], color:[.1 .1 .9], contact:1, mass:.5, logical:{ is_object, is_place } } 
obj_11_handle (obj_11) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } }

bottom_left_obj_11 (obj_11)   { Q: [0.15 0.1 .015],   shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
bottom_right_obj_11 (obj_11)  { Q: [-0.15 0.1 .015],  shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
top_left_obj_11 (obj_11)      { Q: [0.15 -0.1 .015],  shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
top_right_obj_11 (obj_11)     { Q: [-0.15 -0.1 .015], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }

top_center_obj_11 (obj_11)    { Q: [0 -0.1 .015],     shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
bottom_center_obj_11 (obj_11) { Q: [0 0.1 .015],      shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
mid_left_obj_11 (obj_11)      { Q: [0.15 0 .015],     shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
mid_right_obj_11 (obj_11)     { Q: [-0.15 0 .015],    shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
