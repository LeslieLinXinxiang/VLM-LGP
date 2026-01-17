# final_scene.g (v3 - Color & Name Updated)
# 描述所有房屋组件都已处于其最终目标位置的静态场景。
# 采用 VLM 训练集的标准颜色和命名 (base1/2/3, cyl1-8)。

world {}

# --- 桌子和机器人 ---
table (world) { shape:ssBox, size:[2. 2. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1 }

#Prefix: "l_"
#Include: <../LGP/newLGP/problems/rai-robotModels/panda/panda.g>
#Prefix: False

# 让机器人不可见，以便清晰观察场景
#Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" } 

# ==========================================================
# ============== 所有组件均已放置在目标位置 ==================
# ==========================================================

# ----------------------------------------------------------
# 1. 第一层结构 (Foundation Layer)
# ----------------------------------------------------------

# 底座 (base1 - Grey)
base1 (table) { 
  Q:"t(0 .3 .07)",
  shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], 
  contact:1
}
base1_handle (base1) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } } 

# 第一层支撑 (Layer 1 Supports)
# 左前
cyl1 (table) { Q:"t(-0.15 0.2 0.14)", shape:cylinder, size:[.1 .04], color:[.9 0 .9] } # Magenta
# 右前
cyl2 (table) { Q:"t(0.15 0.2 0.14)", shape:cylinder, size:[.1 .04], color:[.6 .3 .1] } # Chocolate
# 后中
cyl3 (table) { Q:"t(0 0.4 0.14)", shape:cylinder, size:[.1 .04], color:[1 .4 .7] } # Pink


# ----------------------------------------------------------
# 2. 第二层结构 (Middle Layer)
# ----------------------------------------------------------

# 中层板 (base2 - Red)
# 高度计算: 0.07(base1) + 0.1(cyl) + 0.02(half_base2) + margin ~= 0.20
base2 (table) { 
  Q:"t(0 0.3 0.20)",
  shape:ssBox, size:[.5 .4 .04 .002], color:[.9 .1 .1] 
}
base2_handle (base2) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } } 

# 第二层支撑 (Layer 2 Supports)
# 左前
cyl4 (table) { Q:"t(-0.15 0.2 0.27)", shape:cylinder, size:[.1 .04], color:[0 .9 .9] } # Cyan
# 右前
cyl5 (table) { Q:"t(0.15 0.2 0.27)", shape:cylinder, size:[.1 .04], color:[.5 0 .8] } # Purple
# 后中
cyl6 (table) { Q:"t(0.15 0.4 0.27)", shape:cylinder, size:[.1 .04], color:[0 .8 0] } # Green

cyl7 (table) { Q:"t(-0.15 0.4 0.27)", shape:cylinder, size:[.1 .04], color:[1 .9 0] } # Yellow

# ----------------------------------------------------------
# 3. 第三层结构 (Top Layer)
# ----------------------------------------------------------

# 顶层板 (base3 - Blue)
# 高度计算: 0.20(base2) + 0.1(cyl) + 0.02(half_base3) + margin ~= 0.34
base3 (table) { 
  Q:"t(0 0.3 0.34)",
  shape:ssBox, size:[.5 .4 .04 .002], color:[.1 .1 .9] 
}
base3_handle (base3) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } }

# 第三层支撑 (Layer 3 Supports / Optional Decoration)
# 左后

# 右后
# cyl8 (table) { Q:"t(0.15 0.3 0.41)", shape:cylinder, size:[.1 .04], color:[1 .5 0] } # Orange
