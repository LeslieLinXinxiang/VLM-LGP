# final_scene.g (v2.1 - Gold Anchor)
# 描述所有房屋组件都已处于其最终目标位置的静态场景。
# 所有坐标均经过第一性原理计算，以确保精确性。

world {}

# --- 桌子和机器人 ---
table (world) { shape:ssBox, size:[2. 2. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1 }

# ==========================================================
# ============== 所有组件均已放置在目标位置 ==================
# ==========================================================

# 1. 底座 (base1 - Grey)
base1 (table) { 
  Q:"t(0 .3 .07)",
  shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], 
  contact:1
}
# [UPDATE] Changed color to Metallic Brass/Gold
base1_handle (base1) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[0 0.5 0.5], contact:1, mass:.2, logical:{ is_object } } 

# 3. 中层 (base2 - Red)
base2 (table) { 
  Q:"t(0 0.3 0.20)",
  shape:ssBox, size:[.5 .4 .04 .002], color:[.9 .1 .1] 
}
# [UPDATE] Changed color to Metallic Brass/Gold
base2_handle (base2) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[0 0.5 0.5], contact:1, mass:.2, logical:{ is_object } } 

# 5. 顶层 (base3 - Blue)
base3 (table) { 
  Q:"t(0 0.3 0.34)",
  shape:ssBox, size:[.5 .4 .04 .002], color:[.1 .1 .9] 
}
# [UPDATE] Changed color to Metallic Brass/Gold
base3_handle (base3) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[0 0.5 0.5], contact:1, mass:.2, logical:{ is_object } } 


# 2. 所有圆柱 (cyl1-8)
# 第一层
cyl1 (table) { Q:"t(-0.20 0.15 0.14)", shape:cylinder, size:[.1 .04], color:[.9 0 .9] } # Magenta (Randomized)
cyl2 (table) { Q:"t(0.20 0.15 0.14)", shape:cylinder, size:[.1 .04], color:[.6 .3 .1] } # Chocolate (Randomized)
cyl3 (table) { Q:"t(0 0.45 0.14)", shape:cylinder, size:[.1 .04], color:[1 .4 .7] } # Pink (Randomized)

# 第二层
cyl4 (table) { Q:"t(-0.2 0.15 0.27)", shape:cylinder, size:[.1 .04], color:[0 .9 .9] } # Cyan (Randomized)
cyl5 (table) { Q:"t(0.2 0.15 0.27)", shape:cylinder, size:[.1 .04], color:[.5 0 .8] } # Purple (Randomized)
cyl6 (table) { Q:"t(0 0.45 0.27)", shape:cylinder, size:[.1 .04], color:[0 .8 0] } # Green (Randomized)

# 第三层
cyl7 (table) { Q:"t(-0.2 0.3 0.41)", shape:cylinder, size:[.1 .04], color:[1 .9 0] } # Yellow (Randomized)
cyl8 (table) { Q:"t(0.2 0.3 0.41)", shape:cylinder, size:[.1 .04], color:[1 .5 0] } # Orange (Randomized)
