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

# 1. 底座 (base1)
# 目标: base1_target (table) { Q:"t(0 .3 .07)" }
base1 (table) { 
  Q:"t(0 .3 .07)",
  shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], 
  contact:1
}
base1_handle (base1) { Q:"t(0 0 .05)", color:[0 0 0 0] } # 把手设为不可见


# 2. 所有圆柱 (cyl1-8)
# 第一层
# 目标: cyl1_target(table){Q:"t(-0.15 0.2 0.14)"}, cyl2_target(table){Q:"t(0.15 0.2 0.14)"}, cyl3_target(table){Q:"t(0 0.4 0.14)"}
cyl1 (table) { Q:"t(-0.15 0.2 0.14)", shape:cylinder, size:[.1 .04], color:[1 1 0] }
cyl2 (table) { Q:"t(0.15 0.2 0.14)", shape:cylinder, size:[.1 .04], color:[0 1 1] }
cyl3 (table) { Q:"t(0 0.4 0.14)", shape:cylinder, size:[.1 .04], color:[1 0 1] }

# 第二层
# 目标: cyl4_target(table){Q:"t(-0.15 0.2 0.27)"}, cyl5_target(table){Q:"t(0.15 0.2 0.27)"}, cyl6_target(table){Q:"t(0 0.4 0.27)"}
cyl4 (table) { Q:"t(-0.15 0.2 0.27)", shape:cylinder, size:[.1 .04], color:[1 0 0] }
cyl5 (table) { Q:"t(0.15 0.2 0.27)", shape:cylinder, size:[.1 .04], color:[0 1 0] }
cyl6 (table) { Q:"t(0.15 0.4 0.27)", shape:cylinder, size:[.1 .04], color:[1 1 1] }
cyl7 (table) { Q:"t(-0.15 0.4 0.27) ", shape:cylinder, size:[.1 .04], color:[0 0 0] }
# 第三层
# 目标: cyl7_target(table){Q:"t(-0.15 0.3 0.41)"}, cyl8_target(table){Q:"t(0.15 0.3 0.41)"}

#cyl8 (table) { Q:"t(0.15 0.3 0.41)", shape:cylinder, size:[.1 .04], color:[0 0 1] }


# 3. 屋顶 (roof1 & roof2)
# 目标: roof1_target(base1_target){Q:"t(0 0 0.13)"} -> P_abs = [0, 0.3, 0.07] + [0, 0, 0.13] = [0, 0.3, 0.20]
roof1 (table) { 
  Q:"t(0 0.3 0.20)",
  shape:ssBox, size:[.5 .4 .04 .002], color:[0 0 0.5] 
}
roof1_handle (roof1) { Q:"t(0 0 .05)", color:[0 0 0 0] }

# 目标: roof2_target(base1_target){Q:"t(0 0 0.27)"} -> P_abs = [0, 0.3, 0.07] + [0, 0, 0.27] = [0, 0.3, 0.34]
roof2 (table) { 
  Q:"t(0 0.3 0.34)",
  shape:ssBox, size:[.5 .4 .04 .002], color:[1 .5 0] 
}
roof2_handle (roof2) { Q:"t(0 0 .05)", color:[0 0 0 0] }
