world {}

table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

# Robot (Panda Arm)
Prefix: "l_"
Include: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/panda.g>
Prefix: False
# Align arm base at table origin, remove previous (0,-0.3) + 90deg yaw transform
Edit l_panda_base (table): { Q: "t(0 0 0.05)" }

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
# Assembly 1 Objects (FMB)
# Files have been post-processed to be in meters and centered.
# -----------------------------------------------------------

# Main Board (part 1: 0.23 x 0.23 x 0.05)
# half-height = 0.025. Table surface = 0.05. Q_z = 0.075
# transformed from (0,0.10) in old frame to (0.40,0.00) in aligned frame
fmb_board (table) { 
    Q:"t(0.40 0.00 .075) d(-90 0 0 1)", 
    shape:mesh, 
    mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/assembly1_parts/assembly1_part_1.obj", 
    color:[0.8 0.8 0.8 1], 
    contact:1, mass: 0.5,
    logical:{ is_object, is_box }
}

# 4 target patch slots on the board (relative to fmb_board center)
# Board top surface is at local Z = 0.025. Patches at 0.0255 to avoid z-fighting.
Table_Left (fmb_board) { Q:"t( 0.06725  0.0  -0.0195) d(0 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1], contact:0, logical:{ is_place } }
#fmb_slot3 (fmb_board) { Q:"t(0  0  0.018) d(0 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1], contact:0, logical:{ is_place } }
#fmb_slot4 (fmb_board) { Q:"t(0 0 -0.0135) d(0 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1], contact:0, logical:{ is_place } }
Table_Right (fmb_board) { Q:"t( -0.06725 0  -0.0195) d(0 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1], contact:0, logical:{ is_place } }


# Sub-parts (placed in start zone: X=0.30/etc.)

# part 2: 0.03 x 0.10 x 0.10 (half-height 0.05) -> Q_z = 0.10
# transformed from (0.30,0.10) -> (0.40,-0.30)
shape_1_1 (table) {
    Q:"t(0.40 -0.30 .0675) d(-90 0 0 1)", joint:rigid, shape: ssBox, size: [.03 .03 .035 .005], color:[0 0 1], contact:0, logical:{is_object, is_box} }

shape_1_1_mesh (shape_1_1) { 
    Q:"t(0 0 0.0325) d(0 0 0 1)", joint:rigid,
    shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/assembly1_parts/assembly1_part_2.obj", 
    color:[0.9 0.2 0.2], contact:1, mass: 0.1,
    logical:{ is_object, is_box }
}
# Added handle (marker) offset by Y=0.03, Z=0.01 relative to part 2's center
shape_1_1_handle (shape_1_1) { Q:"t(0 -0.035 0.0675) d(-90 0 0 1)", shape:marker, size:[.03], color:[1 1 0] }

# part 3: 0.20 x 0.037 x 0.037 (half-height 0.0185) -> Q_z = 0.0685
# transformed from (0.30,0.30) -> (0.60,-0.30)
shape_2_1 (table) { 
    Q:"t(0.60 -0.30 .0685) d(-90 0 0 1)", joint:rigid,
    shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/assembly1_parts/assembly1_part_3.obj", 
    color:[0.2 0.9 0.2], contact:1, mass: 0.1,
    logical:{ is_object, is_place }
}
# fmb_part3_handle (fmb_part3) { Q:"t(0.04 0 0.015)", shape:marker, size:[.03], color:[1 1 0] }

# part 4: 0.03 x 0.161 x 0.10 (half-height 0.05) -> Q_z = 0.10
# transformed from (-0.30,0.10) -> (0.40,0.30)
shape_3_1 (table) { 
    Q:"t(0.40 0.30 .136) d(0 0 0 1)", joint:rigid, shape: ssBox, size:[.028 .028 .028 .005], color:[0.2 0.2 0.9], contact:0, logical:{is_object, is_box} }

shape_3_1_mesh (shape_3_1) { 
    Q:"t(0 0 0) d(0 0 0 1)", joint:rigid,
    shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/assembly1_parts/assembly1_part_4.obj", 
    color:[0.2 0.2 0.9], contact:1, mass: 0.1,
    logical:{ is_object, is_box }
}
#fmb_part4_handle (shape_3_1) { Q:"t(0 0 0.04) d(-90 0 0 1)", shape:marker, size:[.03], color:[1 1 0] }

# part 5: 0.03 x 0.10 x 0.10 (half-height 0.05) -> Q_z = 0.10
# transformed from (-0.30,0.30) -> (0.60,0.30)
shape_1_2 (table) { 
    Q:"t(0.60 0.30 .0675) d(-90 0 0 1)", joint:rigid, shape: ssBox, size: [.03 .03 .035 .005], color:[0.9 0.9 0.2], contact:0, logical:{is_object, is_box} }

shape_1_2_mesh (shape_1_2) { 
    Q:"t(0 0 0.0325) d(0 0 0 1)", joint:rigid,
    shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/assembly1_parts/assembly1_part_5.obj", 
    color:[0.9 0.9 0.2], contact:1, mass: 0.1,
    logical:{ is_object, is_box }
}
shape_1_2_handle (shape_1_2) { Q:"t(0 -0.035 0.0675) d(-90 0 0 1)", shape:marker, size:[.03], color:[1 1 0] }

