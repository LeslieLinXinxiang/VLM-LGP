

world {}

# --- 桌子和机器人 ---
table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

Prefix: "l_"
Include: <../../LGP/newLGP/rai-robotModels/panda/panda.g>
Prefix: False`
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" } # ## CORRECTED ## 机器人向前移动，离工作区更近

# --- 房屋组件定义 (初始位置，全部在机器人可达范围内) ---

# ## CORRECTED Z-COORDINATES AND POSITIONS ##
# Z-offset for objects on table = 0.05 (table half-height) + object_half_height

# 1. 底座 (带把手) 
base1 (table) { Q:"t(0 0 .07)", joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], contact:1, mass:.5, logical:{ is_object, is_place } }
base1_handle (base1) { Q:"t(0 0 .05)", shape:ssBox, size:[.04 .04 .06 .002], color:[.8 .8 .8], logical:{ is_object , is_place } }

# 2. 屋顶 (平面，带把手) - 放在右前方
base2 (table) { Q:"t(-0.5 -0.4 .07)", joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[1 0 0], contact:1, mass:.5, logical:{ is_object } }
base2_handle (base2) { Q:"t(0 0 .05)", shape:ssBox, size:[.04 .04 .06 .002], color:[1 0 0], logical:{ is_object} }

base3 (table) { Q:"t(0.5 -0.4 .07)", joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[1 0 0], contact:1, mass:.5, logical:{ is_object, is_box } }
base3_handle (base3) { Q:"t(0 0 .05)", shape:ssBox, size:[.04 .04 .06 .002], color:[1 0 0], logical:{ is_object} }

# 3. 四根圆柱 (加粗加高)
cyl1 (table) { Q:"t(-0.4 0.2 .1)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder , is_place} }
cyl2 (table) { Q:"t(-0.5 0.2 .1)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder , is_place} }
cyl3 (table) { Q:"t(-0.5 0 .1)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder , is_place} }
cyl4 (table) { Q:"t(-0.4 0 .1)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder , is_place} }
cyl5 (table) { Q:"t(0.5 0 .1)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder , is_place} }
cyl6 (table) { Q:"t(0.4 0 .1)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder , is_place} }
cyl7 (table) { Q:"t(0.5 0.2 .1)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], cont act:1, mass:.2, logical:{ is_object  , is_cylinder , is_place} }
cyl8 (table) { Q:"t(0.4 0.2 .1)", joint:rigid, shape:cylinder, size:[.08 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder , is_place} }


# --- 房屋组件的放置位置定义 (目标位置)
# --- 第一层 ---
place_base1 (table) { Q: [0 0.45 .05], shape:quad, size: [.05 .05], color:[.8 .5 .5] logical:{ is_place } }

frontleft_base1 (base1) { Q: [0.2 0.15 .02], shape:quad, size: [.05 .05], color:[.8 .5 .5] logical:{ is_place } }

frontright_base1 (base1) { Q: [-0.2 0.15 .02], shape:quad, size: [.05 .05], color:[.8 .5 .5] logical:{ is_place } }

backleft_base1 (base1) { Q: [-0.2 -0.15 .02], shape:quad, size: [.05 .05], color:[.8 .5 .5] logical:{ is_place } }

backright_base1 (base1) { Q: [0.2 -0.15 .02], shape:quad, size: [.05 .05], color:[.8 .5 .5] logical:{ is_place } }

back_base1 (base1) { Q: [0 -0.15 .02], shape:quad, size: [.05 .05], color:[.8 .5 .5] logical:{ is_place } }

front_base1 (base1) { Q: [0 0.15 .02], shape:quad, size: [.05 .05], color:[.8 .5 .5] logical:{ is_place } }

left_base1 (base1) { Q: [-0.2 0 .02], shape:quad, size: [.05 .05], color:[.8 .5 .5] logical:{ is_place } }

right_base1 (base1) { Q: [0.2 0 .02], shape:quad, size: [.05 .05], color:[.8 .5 .5] logical:{ is_place } }

# --- 第二层 ---
frontleft_base2 (base2) { Q: [0.2 0.15 .02], shape:quad, size: [.05 .05], color:[.5 .5 .8] logical:{ is_place } }

frontright_base2 (base2) { Q: [-0.2 0.15 .02], shape:quad, size: [.05 .05], color:[.5 .5 .8] logical:{ is_place } }

backleft_base2 (base2) { Q: [-0.2 -0.15 .02], shape:quad, size: [.05 .05], color:[.5 .5 .8] logical:{ is_place } }

backright_base2 (base2) { Q: [0.2 -0.15 .02], shape:quad, size: [.05 .05], color:[.5 .5 .8] logical:{ is_place } }

back_base2 (base2) { Q: [0 -0.15 .02], shape:quad, size: [.05 .05], color:[.5 .5 .8] logical:{ is_place } }

front_base2 (base2) { Q: [0 0.15 .02], shape:quad, size: [.05 .05], color:[.5 .5 .8] logical:{ is_place } }

left_base2 (base2) { Q: [-0.2 0 .02], shape:quad, size: [.05 .05], color:[.5 .5 .8] logical:{ is_place } }

right_base2 (base2) { Q: [0.2 0 .02], shape:quad, size: [.05 .05], color:[.5 .5 .8] logical:{ is_place } }

# --- 第三层 ---
frontleft_base3 (base3) { Q: [0.2 0.15 .02], shape:quad, size: [.05 .05], color:[.5 .5 .8] logical:{ is_place } }

frontright_base3 (base3) { Q: [-0.2 0.15 .02], shape:quad, size: [.05 .05], color:[.5 .5 .8] logical:{ is_place } }

backleft_base3 (base3) { Q: [-0.2 -0.15 .02], shape:quad, size: [.05 .05], color:[.5 .5 .8] logical:{ is_place } }

backright_base3 (base3) { Q: [0.2 -0.15 .02], shape:quad, size: [.05 .05], color:[.5 .5 .8] logical:{ is_place } }

back_base3 (base3) { Q: [0 -0.15 .02], shape:quad, size: [.05 .05], color:[.5 .5 .8] logical:{ is_place } }

front_base3 (base3) { Q: [0 0.15 .02], shape:quad, size: [.05 .05], color:[.5 .5 .8] logical:{ is_place } }

left_base3 (base3) { Q: [-0.2 0 .02], shape:quad, size: [.05 .05], color:[.5 .5 .8] logical:{ is_place } }

right_base3 (base3) { Q: [0.2 0 .02], shape:quad, size: [.05 .05], color:[.5 .5 .8] logical:{ is_place } }





# 1. 底座的最终放置位置
#base1_target (table) { Q:"t(0 .3 .04) d(0 0 0 1)", shape:ssBox, size:[.01 .01 .01 .001], color:[1 1 1 1], contact: 0, logical:{ is_pose, is_place } }  


# 2. 在“底座最终位置”上定义屋顶的目标 
#base2_target (base1_target) { Q:"t(0 0 0.13) d(0 0 0 1)", logical:{ is_pose } }
#base3_target (base1_target) { Q:"t(0 0 0.27) d(0 0 0 1)", logical:{ is_pose } }


# 3. 在“底座最终位置”上定义四个柱子的目标 (来自你调试好的 final_scene.g)
#cyl1_target (table) { Q:"t(-0.15 0.2 0.14) d(0 0 0 1)", logical:{ is_pose } }
#cyl2_target (table) { Q:"t(0.15 0.2 0.14) d(0 0 0 1)", logical:{ is_pose } }
#cyl3_target (table) { Q:"t(-0.15 0.4 0.14) d(0 0 0 1)", logical:{ is_pose } }
#cyl4_target (table) { Q:"t(0.15 0.4 0.14) d(0 0 0 1)", logical:{ is_pose } }
#cyl5_target (table) { Q:"t(-0.15 0.2 0.27) d(0 0 0 1)", logical:{ is_pose } }
#cyl6_target (table) { Q:"t(0.15 0.2 0.27) d(0 0 0 1)", logical:{ is_pose } }
#cyl7_target (table) { Q:"t(-0.15 0.4 0.27) d(0 0 0 1)", logical:{ is_pose } }
#cyl8_target (table) { Q:"t(0.15 0.4 0.27) d(0 0 0 1)", logical:{ is_pose } }

