world {}



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
  Q:"t(0.45 0.00 0.075) d(90 1 0 0 )",
  joint:rigid,
  shape:mesh,
  mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/base_board.obj",
  color:[0.75 0.75 0.75 1],
  contact:1,
  mass:0.5,
  logical:{ is_object, is_place }
}

# Place patches on base_board (kept as explicit entities for place-frame debugging).
Table_Left (base_board) { Q:"t( 0.000 0.000  0.080) d(-90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1], contact:0, logical:{ is_place } }
Table_Right (base_board) { Q:"t(0.000 0.000 -0.080) d(90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1], contact:0, logical:{ is_place } }
Table_Front (base_board) { Q:"t(0.060 0.000 0.000) d(90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1], contact:0, logical:{ is_place } }
Table_Back (base_board) { Q:"t(-0.060 0.000 0.000) d(90 1 0 0)", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1], contact:0, logical:{ is_place } }
Table_Center (base_board) { Q:"t(00 0.000 0.000) d(-90 1 0 0) ", shape:ssBox, size:[.02 .02 .001 .0005], color:[0 1 1], contact:0, logical:{ is_place } }

# Four parts are laid out in a plus-shape around the board for visual inspection.
# Use proxy + mesh + grasp frame for all except shape_2_1 (kept direct mesh by request).
shape_1_1 (table) {
  Q:"t(0.40 -0.3 0.0625)",
  joint:rigid,
  shape:ssBox,
  size:[.025 .025 .025 .00],
  color:[0.2 0.2 1.0],
  contact:0,
  logical:{ is_object, is_box }
}

shape_1_1_mesh (shape_1_1) {
  Q:"t(0 0.001 00.0275 ) d(90 1 0 0)",
  joint:rigid,
  shape:mesh,
  mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_1_1.obj",
  color:[1.0 0.2 0.2 0.5],
  contact:1,
  mass:0.1,
  logical:{ is_object, is_box }
}

shape_1_1_handle (shape_1_1) { Q:"t(-0.045 0 0.045) d(0 0 0 0)", shape:marker, size:[.03], color:[1 1 0] }

shape_1_2 (table) {
  Q:"t(0.60 -0.20 0.0625) d(0 0 0 0)",
  joint:rigid,
  shape:ssBox,
  size:[.025 .025 .025 .0],
  color:[0.2 0.2 1.0],
  contact:0,
  logical:{ is_object, is_box }
}

shape_1_2_mesh (shape_1_2) {
  Q:"t(0 0.001 0.0275) d(90 1 0 0)",
  joint:rigid,
  shape:mesh,
  mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_1_2.obj",
  color:[0.2 0.2 1.0 1],
  contact:1,
  mass:0.1,
  logical:{ is_object, is_box }
}

shape_1_2_handle (shape_1_2) { Q:"t( -0.045 0 0.045) d(0 0 0 0)", shape:marker, size:[.03], color:[1 1 0] }

shape_2_1 (table) {
  Q:"t(0.30 0.20 0.063) d(-90 0 0 1)",
  joint:rigid,
  shape:mesh,
  mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_2_1.obj",
  color:[0.2 1.0 0.2 1],
  contact:1,
  mass:0.1,
  logical:{ is_object, is_box }
}

shape_3_1 (table) {
  Q:"t(0.4 0.30 0.0625) d(0 0 0 0)",
  joint:rigid,
  shape:ssBox,
  size:[.025 .025 .025 .005],
  color:[0.2 0.2 0.9],
  contact:0,
  logical:{ is_object, is_box }
}

shape_3_1_mesh (shape_3_1) {
  Q:"t(0 0.001 0.0325) d(90 1 0 0) d(90 0 1 0)",
  joint:rigid,
  shape:mesh,
  mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_3_1.obj",
  color:[0.2 0.8 1.0 1],
  contact:1,
  mass:0.1,
  logical:{ is_object, is_box }
}

shape_3_1_handle (shape_3_1) { Q:"t(0 0 0.065) d(0 0 0 0)", shape:marker, size:[.03], color:[1 1 0] }

shape_4_1 (table) {
  Q:"t(0.50 0.4 0.0625) d(0 0 0 0)",
  joint:rigid,
  shape:ssBox,
  size:[.025 .025 .025 .0],
  color:[1.0 0.5 0.2],
  contact:0,
  logical:{ is_object }
}

shape_4_1_mesh (shape_4_1) {
  Q:"t(0 0 0.0275) d(90 1 0 0) d(90 0 1 0)",
  joint:rigid,
  shape:mesh,
  mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/new_fmb/shape_4_1.obj",
  color:[1.0 0.5 0.2 1],
  contact:1,
  mass:0.1,
  logical:{ is_object, is_box }
}

shape_4_1_handle (shape_4_1) { Q:"t(0 0 0.05) d(0 0 0 0)", shape:marker, size:[.03], color:[1 1 0] }

# Camera for quick static screenshots if needed.
cam_overview (table) { Q:"t(0.45 0.0 0.85) d(180 1 0 0)", shape:camera }
