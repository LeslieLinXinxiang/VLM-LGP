world {}






table (world) {
  shape:ssBox,
  size:[2.0 4.0 0.1 0.02],
  Q:"t(0 0 0.6)",
  color:[0.3 0.3 0.3],
  contact:1,
  logical:{ is_place }
}

# Preview board from new_fmb asset set.
base_board (table) {
  Q:"t(0.4 0.00 0.075) d(90 1 0 0 )",
  joint:rigid,
  shape:mesh,
  mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj",
  color:[0.75 0.75 0.75 1],
  contact:1,
  mass:0.5,
  logical:{ is_object, is_place }
}

# Place patches on base_board (kept as explicit entities for place-frame debugging).
Table_Left (base_board) { Q:"t( 0.000 0.000  0.080) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Right (base_board) { Q:"t(0.000 0.000 -0.080) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Front (base_board) { Q:"t(0.059 0.000 0.000) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Back (base_board) { Q:"t(-0.061 0.000 0.000) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }
Table_Center (base_board) { Q:"t(00 0.000 0.000) d(-90 1 0 0) ", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1 0], contact:0, logical:{ is_place } }

# Four parts are laid out in a plus-shape around the board for visual inspection.
# Use proxy + mesh + grasp frame for all except shape_2_1 (kept direct mesh by request).
shape_2_1 (Table_Front) {
  Q:"t(00 0.0 0.014) d(-90 0 0 1)",
  joint:rigid,
  shape:mesh,
  mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj",
  color:[0.2 1.0 0.2 1],
  contact:1,
  mass:0.1,
  logical:{ is_object, is_box }
}

shape_2_2 (Table_Back) {
  Q:"t(00 0.0 0.014) d(-90 0 0 1)",
  joint:rigid,
  shape:mesh,
  mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_2.obj",
  color:[1 0.2 0.2 1],
  contact:1,
  mass:0.1,
  logical:{ is_object, is_box }
}


shape_4_1 (Table_Left) {
  Q:"t(0.0 0.0 0.0125) d(0 0 0 0)",
  joint:rigid,
  shape:ssBox,
  size:[.025 .025 .025 .0],
  color:[1.0 0.5 0.2 0],
  contact:0,
  logical:{ is_object }
}

shape_4_1_mesh (shape_4_1) {
  Q:"t(0 0 0.0275) d(90 1 0 0) d(90 0 1 0)",
  joint:rigid,
  shape:mesh,
  mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj",
  color:[.2 0.2 1 1],
  contact:1,
  mass:0.1,
  logical:{ is_object, is_box }
}

shape_4_2 (Table_Right) {
  Q:"t(0.0 0.0 0.0125) d(0 0 0 0)",
  joint:rigid,
  shape:ssBox,
  size:[.025 .025 .025 .0],
  color:[1.0 0.5 0.2 0],
  contact:0,
  logical:{ is_object }
}
shape_4_1_handle (shape_4_1) { Q:"t(0 0 0.05) d(0 0 0 0)", shape:marker, size:[.03], color:[1 1 0] }


shape_4_2_mesh (shape_4_2) {
  Q:"t(0 0 0.0275) d(90 1 0 0) d(90 0 1 0)",
  joint:rigid,
  shape:mesh,
  mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_2.obj",
  color:[1.0 1.0 0.2 1],
  contact:1,
  mass:0.1,
  logical:{ is_object, is_box }
}

shape_4_2_handle (shape_4_2) { Q:"t(0 0 0.05) d(0 0 0 0)", shape:marker, size:[.03], color:[1 1 0] }


