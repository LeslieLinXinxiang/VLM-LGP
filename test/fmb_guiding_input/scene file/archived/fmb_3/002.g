world {}

table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }


# -----------------------------------------------------------
# Assembly 3 Objects (FMB)
# Meshes are loaded directly from assets/fmb/assembly3obj
# -----------------------------------------------------------

fmb_board (table) {
    Q:"t(0.40 0.00 .075) d(0 0 0 1)",
    shape:mesh,
    mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/assembly3obj/assembly3_part_1.obj",
    color:[0.8 0.8 0.8 1],
    contact:1, mass: 0.5,
    logical:{ is_object, is_box }
}

fmb_slot2 (fmb_board) { Q:"t(-0.0365  0.0  0.015) d(0 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1], contact:0, logical:{ is_place } }
fmb_slot3 (fmb_board) { Q:"t(0.0365  0  0.015) d(0 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1], contact:0, logical:{ is_place } }
fmb_slot4 (fmb_board) { Q:"t(0 -0.0515 0) d(0 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1], contact:0, logical:{ is_place } }
fmb_slot5 (fmb_board) { Q:"t( 0 0.0515  0.0) d(0 0 0 1)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1], contact:0, logical:{ is_place } }

fmb_part2 (fmb_slot2) {
    Q:"t(00 0 .0185) d(0 0 0 1)", joint:rigid,
    shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/assembly3obj/assembly3_part_2.obj",
    color:[0.9 0.2 0.2], contact:1, mass: 0.1,
    logical:{ is_object, is_box }
}
fmb_part2_handle (fmb_part2) { Q:"t(0 0 0.035) d(-90 0 0 1)", shape:marker, size:[.03], color:[1 1 0] }

fmb_part3 (fmb_slot3) {
    Q:"t(0.0 0.0 .0185) d(0 0 0 1)", joint:rigid,
    shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/assembly3obj/assembly3_part_3.obj",
    color:[0.2 0.9 0.2], contact:1, mass: 0.1,
    logical:{ is_object, is_box }
}

fmb_part4 (fmb_slot4) {
    Q:"t(0.0 0.0 .05) d(0 0 0 1)", joint:rigid,
    shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/assembly3obj/assembly3_part_4.obj",
    color:[0.2 0.2 0.9], contact:1, mass: 0.1,
    logical:{ is_object, is_box }
}
fmb_part4_handle (fmb_part4) { Q:"t(0 0 0.04) d(-90 0 0 1)", shape:marker, size:[.03], color:[1 1 0] }

fmb_part5 (fmb_slot5) {
    Q:"t(0.0 0.0 .05) d(0 0 0 1)", joint:rigid,
    shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/assembly3obj/assembly3_part_5.obj",
    color:[0.9 0.9 0.2], contact:1, mass: 0.1,
    logical:{ is_object, is_box }
}
fmb_part5_handle (fmb_part5) { Q:"t(0 -0.033 0.035) d(-90 0 0 1)", shape:marker, size:[.03], color:[1 1 0] }
