world {}

# --- 1. 环境设置 ---
# 桌子 (保持不变)
table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

# 机器人 (位置微调，确保能覆盖左右供料区和前方施工区)
Prefix: "l_"
Include: </home/leslie/Projects/VLM_LGP/rai/test/LGP/newLGP/problems/rai-robotModels/panda/panda.g>
Prefix: False
# 机器人后退一点点 (y=-0.4)，给前方留出更多操作空间
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" }


# ==============================================================================
# 2. 供料区 (Storage Area) - 严格与施工区分离
# ==============================================================================

# --- [右侧供料区]：放置大型 Base 组件 ---
# 统一放在 X > 0.5 的区域，Y轴方向排开，间距 0.5m (base宽0.4m，留0.1m缝隙)

# Base 1 (地基)
base1 (table) { 
    Q:"t(0.6 -0.5 .07)", 
    joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], contact:1, mass:.5, 
    logical:{ is_object, is_place } 
}
base1_handle (base1) { Q:"t(0 0 .05)", shape:ssBox, size:[.04 .04 .06 .002], color:[.8 .8 .8], logical:{ is_object, is_place } }

# Base 2 (中间层) - 放在 Base 1 后面
base2 (table) { 
    Q:"t(0.6 0 .07)", 
    joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[1 0 0], contact:1, mass:.5, 
    logical:{ is_object } 
}
base2_handle (base2) { Q:"t(0 0 .05)", shape:ssBox, size:[.04 .04 .06 .002], color:[1 0 0], logical:{ is_object } }

# Base 3 (顶层) - 放在 Base 1 前面
base3 (table) { 
    Q:"t(0.6 -1 .07)", 
    joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[1 0 0], contact:1, mass:.5, 
    logical:{ is_object, is_box } 
}
base3_handle (base3) { Q:"t(0 0 .05)", shape:ssBox, size:[.04 .04 .06 .002], color:[1 0 0], logical:{ is_object } }


# --- [左侧供料区]：放置 Cylinders ---
# 统一放在 X < -0.4 的区域，2x4 网格排列，间距 0.2m (抓取安全距离)

# Row 1 (Inner)
cyl1 (table) { Q:"t(-0.4 -0.2 .1)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} }
cyl2 (table) { Q:"t(-0.6 -0.2 .1)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} }

# Row 2
cyl3 (table) { Q:"t(-0.4 -0.4 .1)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} }
cyl4 (table) { Q:"t(-0.6 -0.4 .1)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} }

# Row 3
cyl5 (table) { Q:"t(-0.4 -0.6 .1)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} }
cyl6 (table) { Q:"t(-0.6 -0.6 .1)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} }

# Row 4
cyl7 (table) { Q:"t(-0.4 -0.8 .1)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} }
cyl8 (table) { Q:"t(-0.6 -0.8 .1)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object, is_cylinder, is_place} }


# ==============================================================================
# 3. 施工区 (Construction Zone) - 仅包含逻辑标记
# ==============================================================================
# 位于桌子正中央前方 (X=0, Y=0.5)，远离两侧供料区

# 【重要修复】: 将 shape:quad 改为极薄的 shape:ssBox 以解决 QHull 报错
# 厚度设为 0.001 (1mm)，视觉上看不出来，但数学上是合法的凸体

# --- Base 1 Targets ---
place_base1 (table) { Q: [0 0.3 .05], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:1, logical:{ is_place } }

frontleft_base1 (base1) { Q: [0.2 0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:1, logical:{ is_place } }
frontright_base1 (base1) { Q: [-0.2 0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:1, logical:{ is_place } }
backleft_base1 (base1) { Q: [-0.2 -0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:1, logical:{ is_place } }
backright_base1 (base1) { Q: [0.2 -0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:1, logical:{ is_place } }

back_base1 (base1) { Q: [0 -0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:1, logical:{ is_place } }
front_base1 (base1) { Q: [0 0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:1, logical:{ is_place } }
left_base1 (base1) { Q: [-0.2 0 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:1, logical:{ is_place } }
right_base1 (base1) { Q: [0.2 0 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.8 .5 .5], contact:1, logical:{ is_place } }

# --- Base 2 Targets ---
frontleft_base2 (base2) { Q: [0.2 0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:1, logical:{ is_place } }
frontright_base2 (base2) { Q: [-0.2 0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:1, logical:{ is_place } }
backleft_base2 (base2) { Q: [-0.2 -0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:1, logical:{ is_place } }
backright_base2 (base2) { Q: [0.2 -0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:1, logical:{ is_place } }

back_base2 (base2) { Q: [0 -0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:1, logical:{ is_place } }
front_base2 (base2) { Q: [0 0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:1, logical:{ is_place } }
left_base2 (base2) { Q: [-0.2 0 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:1, logical:{ is_place } }
right_base2 (base2) { Q: [0.2 0 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:1, logical:{ is_place } }

# --- Base 3 Targets ---
frontleft_base3 (base3) { Q: [0.2 0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:1, logical:{ is_place } }
frontright_base3 (base3) { Q: [-0.2 0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:1, logical:{ is_place } }
backleft_base3 (base3) { Q: [-0.2 -0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:1, logical:{ is_place } }
backright_base3 (base3) { Q: [0.2 -0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:1, logical:{ is_place } }

back_base3 (base3) { Q: [0 -0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:1, logical:{ is_place } }
front_base3 (base3) { Q: [0 0.15 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:1, logical:{ is_place } }
left_base3 (base3) { Q: [-0.2 0 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:1, logical:{ is_place } }
right_base3 (base3) { Q: [0.2 0 .02], shape:ssBox, size: [.05 .05 .001 .001], color:[.5 .5 .8], contact:1, logical:{ is_place } }
