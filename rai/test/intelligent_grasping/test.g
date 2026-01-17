

world {}

# --- 桌子和机器人 ---
table (world) { shape:ssBox, size:[2. 4. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1, logical:{ is_place } }

Prefix: "l_"
Include: <../LGP/newLGP/problems/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" } # ## CORRECTED ## 机器人向前移动，离工作区更近

# --- 房屋组件定义 (初始位置，全部在机器人可达范围内) ---

# ## CORRECTED Z-COORDINATES AND POSITIONS ##
# Z-offset for objects on table = 0.05 (table half-height) + object_half_height

# 1. 底座 (带把手) 
base1 (table) { Q:"t(0 0 .07)", joint:rigid, shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], contact:1, mass:.5, logical:{ is_object, is_place } }
base1_handle (base1) { Q:"t(0 0 .05)", shape:ssBox, size:[.04 .04 .06 .002], color:[.8 .8 .8], logical:{ is_object , is_handle } }



place_base1 (table) { Q: [0 0.3 .05], shape:quad, size: [.05 .05], color:[.8 .5 .5] logical:{ is_place } }


