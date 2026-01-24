# final_scene.g (v2 - Precisely Calculated)
# 描述所有房屋组件都已处于其最终目标位置的静态场景。
# 所有坐标均经过第一性原理计算，以确保精确性。

world {}

# --- 桌子和机器人 ---
table (world) { shape:ssBox, size:[2. 2. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1 }

#Prefix: "l_"
#Include: <../LGP/newLGP/rai-robotModels/panda/panda.g>
#Prefix: False

# 让机器人不可见，以便清晰观察场景
#Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" } 

# ==========================================================
# ============== 所有组件均已放置在目标位置 ==================
# ==========================================================

# 1. 底座 (base1 - Grey)
# 目标: base1_target (table) { Q:"t(0 .3 .07)" }
base1 (table) { 
  Q:"t(0 .3 .07)",
  shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], 
  contact:1
}
base1_handle (base1) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } } 

# 3. 中层 (base2 - Red)
# 目标: base2_target(base1_target){Q:"t(0 0 0.13)"} -> P_abs = [0, 0.3, 0.07] + [0, 0, 0.13] = [0, 0.3, 0.20]
base2 (table) { 
  Q:"t(0 0.3 0.20)",
  shape:ssBox, size:[.5 .4 .04 .002], color:[.9 .1 .1] 
}
base2_handle (base2) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } } 

# 目标: base3_target(base1_target){Q:"t(0 0 0.27)"} -> P_abs = [0, 0.3, 0.07] + [0, 0, 0.27] = [0, 0.3, 0.34]
base3 (table) { 
  Q:"t(0 0.3 0.34)",
  shape:ssBox, size:[.5 .4 .04 .002], color:[.1 .1 .9] 
}
base3_handle (base3) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } } 


# 2. 所有圆柱 (cyl1-8)
# 第一层
cyl1 (table) { Q:"t(-0.15 0.2 0.14)", shape:cylinder, size:[.1 .04], color:[.9 0 .9] } # Magenta (Randomized)
cyl2 (table) { Q:"t(0.15 0.2 0.14)", shape:cylinder, size:[.1 .04], color:[.6 .3 .1] } # Chocolate (Randomized)
cyl3 (table) { Q:"t(-0.15 0.4 0.14)", shape:cylinder, size:[.1 .04], color:[1 .4 .7] } # Pink (Randomized)
cyl4 (table) { Q:"t(0.15 0.4 0.14)", shape:cylinder, size:[.1 .04], color:[0 .9 .9] } # Cyan (Randomized)
# 第二层
# 目标: cyl4_target(table){Q:"t(-0.15 0.2 0.27)"}, cyl5_target(table){Q:"t(0.15 0.2 0.27)"}, cyl6_target(table){Q:"t(0 0.4 0.27)"}

cyl5 (table) { Q:"t(-0.15 0.2 0.27)", shape:cylinder, size:[.1 .04], color:[.5 0 .8] } # Purple (Randomized)
cyl6 (table) { Q:"t(0.15 0.2 0.27)", shape:cylinder, size:[.1 .04], color:[0 .8 0] } # Green (Randomized)
cyl7 (table) { Q:"t(-0.15 0.4 0.27)", shape:cylinder, size:[.1 .04], color:[1 .9 0] } # Yellow (Randomized)
cyl8 (table) { Q:"t(0.15 0.4 0.27)", shape:cylinder, size:[.1 .04], color:[1 .5 0] } # Orange (Randomized)





