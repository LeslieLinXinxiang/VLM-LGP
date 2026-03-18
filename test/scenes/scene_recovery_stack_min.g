# Minimal stacked-block recovery test scene
world {}

table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

# Robot
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

# Bottom block (target to pick)
block_bottom (table) {
    Q:"t(0.00 0.15 .065)",
    joint:rigid,
    shape:ssBox,
    size:[.03 .03 .03 .001],
    color:[0.1 0.6 1.0],
    contact:1,
    mass:.2,
    logical:{ is_object, is_box, is_place }
}

# Top block stacked on bottom block
block_top (block_bottom) {
    Q:"t(0 0 .03)",
    joint:rigid,
    shape:ssBox,
    size:[.03 .03 .03 .001],
    color:[1.0 0.3 0.2],
    contact:1,
    mass:.2,
    logical:{ is_object, is_box, is_place }
}
