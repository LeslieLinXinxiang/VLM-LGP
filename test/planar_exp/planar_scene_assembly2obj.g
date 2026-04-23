world {}

table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

# Robot (Panda Arm)
Prefix: "l_"
Include: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/panda.g>
Prefix: False
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
# Assembly 2 Objects (FMB)
# Meshes are loaded directly from assets/fmb/assembly2obj
# -----------------------------------------------------------

fmb_board (table) {
    Q:"t(0.40 0.00 .075) d(-90 0 0 1)",
    shape:mesh,
    mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/assembly2obj/assembly2_part_1.obj",
    color:[0.8 0.8 0.8 1],
    contact:1, mass: 0.5,
    logical:{ is_object, is_box }
}

fmb_slot2 (fmb_board) { Q:"t( 0.06725  0.0  -0.0195) d(0 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1], contact:0, logical:{ is_place } }
fmb_slot3 (fmb_board) { Q:"t(0  0  0.018) d(0 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1], contact:0, logical:{ is_place } }
fmb_slot4 (fmb_board) { Q:"t(0 0 -0.0135) d(0 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1], contact:0, logical:{ is_place } }
fmb_slot5 (fmb_board) { Q:"t( -0.06725 0  -0.0195) d(0 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1], contact:0, logical:{ is_place } }

fmb_part2 (table) {
    Q:"t(0.40 -0.30 .10) d(-90 0 0 1)", joint:rigid,
    shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/assembly2obj/assembly2_part_2.obj",
    color:[0.9 0.2 0.2], contact:1, mass: 0.1,
    logical:{ is_object, is_box }
}
fmb_part2_handle (fmb_part2) { Q:"t(0 -0.033 0.035) d(-90 0 0 1)", shape:marker, size:[.03], color:[1 1 0] }

fmb_part3 (table) {
    Q:"t(0.60 -0.30 .0685) d(-90 0 0 1)", joint:rigid,
    shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/assembly2obj/assembly2_part_3.obj",
    color:[0.2 0.9 0.2], contact:1, mass: 0.1,
    logical:{ is_object, is_box }
}

fmb_part4 (table) {
    Q:"t(0.40 0.30 .10) d(-90 0 0 1)", joint:rigid,
    shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/assembly2obj/assembly2_part_4.obj",
    color:[0.2 0.2 0.9], contact:1, mass: 0.1,
    logical:{ is_object, is_box }
}
fmb_part4_handle (fmb_part4) { Q:"t(0 0 0.04) d(-90 0 0 1)", shape:marker, size:[.03], color:[1 1 0] }

fmb_part5 (table) {
    Q:"t(0.60 0.30 .10) d(-90 0 0 1)", joint:rigid,
    shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/assembly2obj/assembly2_part_5.obj",
    color:[0.9 0.9 0.2], contact:1, mass: 0.1,
    logical:{ is_object, is_box }
}
fmb_part5_handle (fmb_part5) { Q:"t(0 -0.033 0.035) d(-90 0 0 1)", shape:marker, size:[.03], color:[1 1 0] }
