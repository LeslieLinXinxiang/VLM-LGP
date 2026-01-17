# /home/leslie/Projects/VLM_LGP/rai/test/house_stacking/house.g (Version 2.1)

world {}

# --- 桌子和机器人 ---
table (world) { shape:ssBox, size:[2. 2. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

Prefix: "l_"
Include: <../../LGP/newLGP/problems/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" } # ## CORRECTED ## 机器人向前移动，离工作区更近

# --- 房屋组件定义 (初始位置，全部在机器人可达范围内) ---

# ## CORRECTED Z-COORDINATES AND POSITIONS ##
# Z-offset for objects on table = 0.05 (table half-height) + object_half_height

# 1. 底座 (带把手) 
base1 (table) { Q:"t(0 0 .07)", joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], contact:1, mass:.5, logical:{ is_object } }
base1_handle (base1) { Q:"t(0 0 .05)", shape:ssBox, size:[.04 .04 .06 .002], color:[.8 .8 .8], logical:{ is_object } }

# 2. 屋顶 (平面，带把手) - 放在右前方
roof1 (table) { Q:"t(-0.5 -0.4 .07)", joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[1 0 0], contact:1, mass:.5, logical:{ is_object, is_box } }
roof1_handle (roof1) { Q:"t(0 0 .05)", shape:ssBox, size:[.04 .04 .06 .002], color:[1 0 0], logical:{ is_object} }

base2 (table) { Q:"t(0.5 -0.4 .07)", joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[1 0 0], contact:1, mass:.5, logical:{ is_object, is_box } }
base2_handle (base2) { Q:"t(0 0 .05)", shape:ssBox, size:[.04 .04 .06 .002], color:[1 0 0], logical:{ is_object} }

# 3. 四根圆柱 (加粗加高)
cyl1 (table) { Q:"t(-0.4 0 .1)", joint:rigid, shape:cylinder, size:[.1 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder } }
cyl2 (table) { Q:"t(0.4 0 .1)", joint:rigid, shape:cylinder, size:[.1 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder } }
cyl3 (table) { Q:"t(-0.4 0.2 .1)", joint:rigid, shape:cylinder, size:[.1 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder} }
cyl4 (table) { Q:"t(0.4 0.2 .1)", joint:rigid, shape:cylinder, size:[.1 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder} }
cyl5 (table) { Q:"t(-0.5 0 .1)", joint:rigid, shape:cylinder, size:[.1 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder } }
cyl6 (table) { Q:"t(0.5 0 .1)", joint:rigid, shape:cylinder, size:[.1 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder } }
cyl7 (table) { Q:"t(-0.5 0.2 .1)", joint:rigid, shape:cylinder, size:[.1 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder} }
cyl8 (table) { Q:"t(0.5 0.2 .1)", joint:rigid, shape:cylinder, size:[.1 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object  , is_cylinder} }



 
# 1. 底座的最终放置位置
base1_target (table) { Q:"t(0 .3 .07) d(0 0 0 1)", logical:{ is_pose } }  


# 2. 在“底座最终位置”上定义屋顶的目标 
roof1_target (base1_target) { Q:"t(0 0 0.13) d(0 0 0 1)", logical:{ is_pose } }
roof2_target (base1_target) { Q:"t(0 0 0.27) d(0 0 0 1)", logical:{ is_pose } }


# 3. 在“底座最终位置”上定义四个柱子的目标 (来自你调试好的 final_scene.g)
cyl1_target (table) { Q:"t(-0.15 0.2 0.14) d(0 0 0 1)", logical:{ is_pose } }
cyl2_target (table) { Q:"t(0.15 0.2 0.14) d(0 0 0 1)", logical:{ is_pose } }
cyl3_target (table) { Q:"t(-0.15 0.4 0.14) d(0 0 0 1)", logical:{ is_pose } }
cyl4_target (table) { Q:"t(0.15 0.4 0.14) d(0 0 0 1)", logical:{ is_pose } }
cyl5_target (table) { Q:"t(-0.15 0.2 0.27) d(0 0 0 1)", logical:{ is_pose } }
cyl6_target (table) { Q:"t(0.15 0.2 0.27) d(0 0 0 1)", logical:{ is_pose } }
cyl7_target (table) { Q:"t(-0.15 0.4 0.27) d(0 0 0 1)", logical:{ is_pose } }
cyl8_target (table) { Q:"t(0.15 0.4 0.27) d(0 0 0 1)", logical:{ is_pose } }





