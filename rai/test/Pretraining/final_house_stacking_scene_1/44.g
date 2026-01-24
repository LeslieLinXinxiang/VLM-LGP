world {}

# --- 1. 环境设置 ---
table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

Prefix: "l_"
Include: <../../../rai/test/newLGP/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" }


# ==============================================================================
# 2. 供料区 (Storage Area)
# ==============================================================================

base1 (table) { 
    Q:"t(0.6 0 .07)", 
    joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], contact:1, mass:.5, 
    logical:{ is_object, is_place } 
}
base1_handle (base1) { Q:"t(0 0 .05)", shape:ssBox, size:[.04 .04 .06 .002], color:[.8 .8 .8], logical:{ is_object, is_place } }

base2 (table) { 
    Q:"t(0.6 -0.45 .07)", 
    joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[1 0 0], contact:1, mass:.5, 
    logical:{ is_object } 
}
base2_handle (base2) { Q:"t(0 0 .05)", shape:ssBox, size:[.04 .04 .06 .002], color:[1 0 0], logical:{ is_object } }

base3 (table) { 
    Q:"t(0.6 -0.9 .07)", 
    joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[1 0 0], contact:1, mass:.5, 
    logical:{ is_object, is_box } 
}
base3_handle (base3) { Q:"t(0 0 .05)", shape:ssBox, size:[.04 .04 .06 .002], color:[1 0 0], logical:{ is_object } }


cyl1 (table) { Q:"t(-0.45 0.25 .09)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} }
cyl2 (table) { Q:"t(-0.6 0.25 .09)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} }
cyl3 (table) { Q:"t(-0.45 .05 .09)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} }
cyl4 (table) { Q:"t(-0.6 0.05 .09)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} }
cyl5 (table) { Q:"t(-0.45 -0.15 .09)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} }
cyl6 (table) { Q:"t(-0.6 -0.15 .09)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} }
cyl7 (table) { Q:"t(-0.45 -0.35 .09)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} }
cyl8 (table) { Q:"t(-0.6 -0.35 .09)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} }


# ==============================================================================
# 3. 施工区 (Construction Zone)
# ==============================================================================
# 【修复】将所有 shape:quad 替换为 shape:ssBox，并增加微小厚度 size:[.05 .05 .001 .001]
# 这解决了 QHull 崩溃 (exitcode 2) 和求解器无法计算接触梯度的问题。
	
# --- Base 1 Targets ---
place_base1 (table) { Q: [0 0.2 .05], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }

frontleft_base1 (base1) { Q: [0.2 0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }
frontright_base1 (base1) { Q: [-0.2 0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }
backleft_base1 (base1) { Q: [-0.2 -0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }
backright_base1 (base1) { Q: [0.2 -0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }

back_base1 (base1) { Q: [0 -0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }
front_base1 (base1) { Q: [0 0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }
left_base1 (base1) { Q: [-0.2 0 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }
right_base1 (base1) { Q: [0.2 0 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:0, logical:{ is_place } }

# --- Base 2 Targets ---
frontleft_base2 (base2) { Q: [0.2 0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:0, logical:{ is_place } }
frontright_base2 (base2) { Q: [-0.2 0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:0, logical:{ is_place } }
backleft_base2 (base2) { Q: [-0.2 -0.15 .020], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:0, logical:{ is_place } }
backright_base2 (base2) { Q: [0.2 -0.15 .020], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:0, logical:{ is_place } }

back_base2 (base2) { Q: [0 -0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:0, logical:{ is_place } }
front_base2 (base2) { Q: [0 0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:0, logical:{ is_place } }
left_base2 (base2) { Q: [-0.2 0 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:0, logical:{ is_place } }
right_base2 (base2) { Q: [0.2 0 .021], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:0, logical:{ is_place } }

# --- Base 3 Targets ---
frontleft_base3 (base3) { Q: [0.2 0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:0, logical:{ is_place } }
frontright_base3 (base3) { Q: [-0.2 0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:0, logical:{ is_place } }
backleft_base3 (base3) { Q: [-0.2 -0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:0, logical:{ is_place } }
backright_base3 (base3) { Q: [0.2 -0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:0, logical:{ is_place } }

back_base3 (base3) { Q: [0 -0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:0, logical:{ is_place } }
front_base3 (base3) { Q: [0 0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:0, logical:{ is_place } }
left_base3 (base3) { Q: [-0.2 0 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:0, logical:{ is_place } }
right_base3 (base3) { Q: [0.2 0 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:0, logical:{ is_place } }
