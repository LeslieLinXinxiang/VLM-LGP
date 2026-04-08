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
# Single-object COM sink test for fmb_part2
# Requirement:
# 1) Keep legacy XYZ anchor the same as planar_scene.g: t(0.40 -0.30 .10)
# 2) Sink effective mesh COM by 0.0325 m along world Z
# -----------------------------------------------------------

# Keep original XYZ/orientation in .g; COM sink is handled only in OBJ vertices
fmb_part2 (table) {
  Q:"t(0.40 -0.30 0.1325) d(-90 0 0 1)",
  joint:rigid,
  shape:mesh,
  mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/assembly1_parts/assembly1_part_2.obj",
  color:[0.9 0.2 0.2],
  contact:1,
  mass:0.1,
  logical:{ is_object, is_box }
}

# Keep the same local handle definition relative to object frame for quick debugging
fmb_part2_handle (fmb_part2) { Q:"t(0 -0.033 0.0675) d(-90 0 0 1)", shape:marker, size:[.03], color:[1 1 0] }

# part 5: 0.03 x 0.10 x 0.10 (half-height 0.05) -> Q_z = 0.10
# transformed from (-0.30,0.30) -> (0.60,0.30)
fmb_part5 (table) { 
    Q:"t(0.60 0.30 .0675) d(-90 0 0 1)", joint:rigid,
    shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/assembly1_parts/assembly1_part_5.obj", 
    color:[0.9 0.9 0.2], contact:1, mass: 0.1,
    logical:{ is_object, is_box }
}
fmb_part5_handle (fmb_part5) { Q:"t(0 -0.033 0.035) d(-90 0 0 1)", shape:marker, size:[.03], color:[1 1 0] }

# part 4: 0.03 x 0.161 x 0.10 (half-height 0.05) -> Q_z = 0.10
# transformed from (-0.30,0.10) -> (0.40,0.30)
fmb_part4 (table) { 
    Q:"t(0.40 0.30 .136) d(-90 0 0 1)", joint:rigid,
    shape:mesh, mesh:"/home/leslie/Projects/VLM_LGP/assets/fmb/assembly1_parts/assembly1_part_4.obj", 
    color:[0.2 0.2 0.9], contact:1, mass: 0.1,
    logical:{ is_object, is_box }
}
fmb_part4_handle (fmb_part4) { Q:"t(0 0 0.04) d(-90 0 0 1)", shape:marker, size:[.03], color:[1 1 0] }
