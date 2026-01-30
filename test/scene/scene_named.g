# --- START OF FILE world.g ---

world {}

# Table Surface: z=0.6 + 0.05 + margin = 0.65 (approx)
table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

Prefix: "l_"
Include: <../../rai/test/newLGP/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 0 .05) d(90 0 0 1)" }

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

desk (table) { shape:ssBox, size:[2. 1.8 .11 .02], Q:"t(0 0 0.105)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

cyl1 (desk) { Q:"t(-0.4 0.35 .1)", joint:rigid, shape:cylinder, size:[.1 .03], color:[0 .8 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 
cyl2 (desk) { Q:"t(-0.4 0.2 .1)", joint:rigid, shape:cylinder, size:[.1 .03], color:[1 .9 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 
cyl3 (desk) { Q:"t(-0.5 0.35 .1)", joint:rigid, shape:cylinder, size:[.1 .03], color:[0 .9 .9], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 
cyl4 (desk) { Q:"t(-0.5 0.2 .1)", joint:rigid, shape:cylinder, size:[.1 .03], color:[.9 0 .9], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} } 


# base1 

base1 (desk) { Q:"t(0.2 0.25 .0825)", joint:rigid, shape:ssBox, size:[.238 .245 .055 .002], color:[.8 .8 .8], contact:1, mass:.5, logical:{ is_object, is_place } } 
base1_handle (base1) { Q:"t(0 0 .05)", shape:ssBox, size:[.045 .045 .045 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } } 

bottom_left_base1 (base1)   { Q: [0.075 0.075 .0275],   shape:ssBox, size: [.03 .03 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
bottom_right_base1 (base1)  { Q: [-0.075 0.075 .0275],  shape:ssBox, size: [.03 .03 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
top_left_base1 (base1)      { Q: [0.075 -0.075 .0275],  shape:ssBox, size: [.03 .03 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
top_right_base1 (base1)     { Q: [-0.075 -0.075 .0275], shape:ssBox, size: [.03 .03 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }

top_center_base1 (base1)    { Q: [0 -0.075 .0275],      shape:ssBox, size: [.03 .03 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
bottom_center_base1 (base1) { Q: [0 0.075 .0275],       shape:ssBox, size: [.03 .03 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
mid_left_base1 (base1)      { Q: [0.075 0 .0275],       shape:ssBox, size: [.03 .03 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
mid_right_base1 (base1)     { Q: [-0.075 0 .0275],      shape:ssBox, size: [.03 .03 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }


# base2

# --- Red Base (base2) ---
base2 (desk) { Q:"t(0.45 0.25 .0825)", joint:rigid, shape:ssBox, size:[.238 .245 .055 .002], color:[.9 .1 .1], contact:1, mass:.5, logical:{ is_object, is_place } } 
base2_handle (base2) { Q:"t(0 0 .05)", shape:ssBox, size:[.045 .045 .045 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } }

bottom_left_base2 (base2)   { Q: [0.075 0.075 .0275],   shape:ssBox, size: [.03 .03 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
bottom_right_base2 (base2)  { Q: [-0.075 0.075 .0275],  shape:ssBox, size: [.03 .03 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
top_left_base2 (base2)      { Q: [0.075 -0.075 .0275],  shape:ssBox, size: [.03 .03 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
top_right_base2 (base2)     { Q: [-0.075 -0.075 .0275], shape:ssBox, size: [.03 .03 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }

top_center_base2 (base2)    { Q: [0 -0.075 .0275],      shape:ssBox, size: [.03 .03 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
bottom_center_base2 (base2) { Q: [0 0.075 .0275],       shape:ssBox, size: [.03 .03 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
mid_left_base2 (base2)      { Q: [0.075 0 .0275],       shape:ssBox, size: [.03 .03 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }
mid_right_base2 (base2)     { Q: [-0.075 0 .0275],      shape:ssBox, size: [.03 .03 .001 .001], color:[.8 .5 .5 0], contact:0, logical:{ is_place } }



# --- Markers ---
place_base1 (desk) { Q: [0 0.5 .055], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }