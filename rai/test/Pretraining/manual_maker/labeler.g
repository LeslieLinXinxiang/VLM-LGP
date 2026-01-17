
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
base1_handle (base1) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[0.0 0.5 0.5], contact:1, mass:.2, logical:{ is_object } } 

# 第一层支撑 (Layer 1 Supports)
# 左前
cyl1 (table) { Q:"t(-0.15 0.2 0.14)", shape:cylinder, size:[.1 .04], color:[1 0 0] } # Magenta
# 右前
cyl2 (table) { Q:"t(0.15 0.2 0.14)", shape:cylinder, size:[.1 .04], color:[1 0 0] } # Chocolate
# 后中
cyl3 (table) { Q:"t(0 0.4 0.14)", shape:cylinder, size:[.1 .04], color:[1 0 0] } # Pink

cyl4 (table) { Q:"t(0 0.2 0.14)", shape:cylinder, size:[.1 .04], color:[1 0 0] } # Cyan

cyl5 (table) { Q:"t(0.15 0.4 0.14)", shape:cylinder, size:[.1 .04], color:[1 0 0] } # Purple

cyl6 (table) { Q:"t(-0.15 0.4 0.14)", shape:cylinder, size:[.1 .04], color:[1 0 0] } # Green

cyl7 (table) { Q:"t(0.15 0.3 0.14)", shape:cylinder, size:[.1 .04], color:[1 0 0] } # Yellow

cyl8 (table) { Q:"t(-0.15 0.3 0.14)", shape:cylinder, size:[.1 .04], color:[1 0 0] }  # Chocolate (Right)

