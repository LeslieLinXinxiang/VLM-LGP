# test_grasp_scene.g
world {}

table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

# -----------------------------------------------------------
# Robot
# -----------------------------------------------------------
Prefix: "l_"
Include: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" }

# Retract Pose
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
# Objects
# -----------------------------------------------------------

# 1. Cube (Placed in the front work area)
cube (table) { 
    Q:"t(0.0 0.15 .065)", 
    joint:rigid, 
    shape:ssBox, 
    size:[.03 .03 .03 .001], 
    color:[1 .5 0], 
    contact:1, 
    mass:.2, 
    logical:{ is_object, is_box, is_place} 
} 

# 2. Triangular Prism (Placed to the side)
TriPrism (table) { 
    Q:"t(0.2 0.15 .05)", 
    joint:rigid, 
    shape:mesh, 
    mesh:"/home/leslie/Projects/VLM_LGP/generated/triangular_prism.obj", 
    color:[1 .4 .7], 
    contact:1, 
    mass:.2, 
    logical:{ is_object, is_place} 
}
# Optional Grasp Frame for the highest ridge of TriPrism
grasp_handle (TriPrism) { Q:"t(0 0 0.015) d(0 0 0 1)", shape:marker, logical:{ is_place } }
