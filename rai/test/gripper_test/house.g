# /home/leslie/Projects/VLM_LGP/rai/test/house_stacking/house.g (Version 2.1)

world {}

# --- 桌子和机器人 ---
table (world) { shape:ssBox, size:[2. 2. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

Prefix: "l_"
Include: <../LGP/newLGP/problems/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" } # ## CORRECTED ## 机器人向前移动，离工作区更近

# --- 房屋组件定义 (初始位置，全部在机器人可达范围内) ---

# ## CORRECTED Z-COORDINATES AND POSITIONS ##
# Z-offset for objects on table = 0.05 (table half-height) + object_half_height

# 1. 底座 (带把手) - 放在左前方
# z_rel = 0.05 + (0.04/2) = 0.07
base (table) { Q:"t(-.5 -0.6 .07)", joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], contact:1, mass:1, logical:{ is_object, is_place } }
base_handle (base) { Q:"t(0 0 .02)", shape:ssBox, size:[.04 .04 .06 .002], color:[.5 .5 .5], logical:{ is_object } }

# 2. 四根圆柱 (加粗加高) - 放在正前方
# z_rel = 0.05 + (0.2/2) = 0.15
cyl1 (table) { Q:"t(0.2 -0.1 .15)", joint:rigid, shape:cylinder, size:[.2 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object } , { is_place } }
cyl2 (table) { Q:"t(0.3 -0.1 .15)", joint:rigid, shape:cylinder, size:[.2 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object } , { is_place } }
cyl3 (table) { Q:"t(0.4 -0.1 .15)", joint:rigid, shape:cylinder, size:[.2 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object } }
cyl4 (table) { Q:"t(0.5 -0.1 .15)", joint:rigid, shape:cylinder, size:[.2 .04], color:[1 1 0], contact:1, mass:.2, logical:{ is_object } }

# 3. 屋顶 (平面，带把手) - 放在右前方
# z_rel = 0.05 + (0.04/2) = 0.07
roof (table) { Q:"t(+.4 -0.5 .07)", joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[1 0 0], contact:1, mass:.5, logical:{ is_object, is_place } }
roof_handle (roof) { Q:"t(0 0 .02)", shape:ssBox, size:[.04 .04 .06 .002], color:[1 .5 0], logical:{ is_object } }


# --- 【【【【【【【【【【 核心：虚拟目标框架定义 (最终整合版) 】】】】】】】】】】 ---

# 1. 底座的最终放置位置 (来自你调试好的 final_scene.g)
base_target (table) { Q:"t(0 .2 .071) d(0 0 0 1)", logical:{ is_pose }, { is_place } }

# 2. 在“底座最终位置”上定义四个柱子的目标 (来自你调试好的 final_scene.g)
cyl1_target (table) { Q:"t(-0.15 0.1 0.19) d(0 0 0 1)", logical:{ is_pose } }
cyl2_target (table) { Q:"t(0.15 0.1 0.19) d(0 0 0 1)", logical:{ is_pose } }
cyl3_target (table) { Q:"t(-0.15 0.3 0.19) d(0 0 0 1)", logical:{ is_pose } }
cyl4_target (table) { Q:"t(0.15 0.3 0.19) d(0 0 0 1)", logical:{ is_pose } }







# 3. 在“底座最终位置”上定义屋顶的目标 (来自你调试好的 final_scene.g)
roof_target (base_target) { Q:"t(-.025 -.025 .24) d(0 0 0 1)", logical:{ is_pose } }
