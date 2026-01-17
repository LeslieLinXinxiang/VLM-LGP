# test_scene_2.g
# 描述: 双层菱形结构 (Double Diamond Structure)
# 考察: "4-Point Stability" 和 "Cardinal Directions" (前后左右) 的识别
# 布局: 每层4个圆柱，呈菱形分布 (北/南/西/东)

world {}

table (world) { shape:ssBox, size:[2. 2. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1 }

Prefix: "l_"
Include: </home/leslie/Projects/VLM_LGP/rai/test/newLGP/problems/rai-robotModels/panda/panda.g>
Prefix: False
Edit l_panda_base (table): { Q: "t(0 -.3 .05) d(90 0 0 1)" }
Edit l_panda_joint2 { q: -1.5 }

# 2. Elbow (Joint 4): Fold TIGHT (-2.5 rad)
Edit l_panda_joint4 { q: -2.5 }

# 3. Wrist (Joint 6): Tuck IN (1.5 rad)
Edit l_panda_joint6 { q: 1.5 }

# 4. Neutralize others to prevent "Corkscrew" twisting
Edit l_panda_joint1 { q: 0.0 }
Edit l_panda_joint3 { q: 0.0 }
Edit l_panda_joint5 { q: 0.0 }
Edit l_panda_joint7 { q: 0.0 }

# 5. Gripper: OPEN State (0.04m)
Edit l_panda_finger_joint1 { q: 0.04 }
Edit l_panda_finger_joint2 { q: 0.04 }

# --- 1. 地基 (Base1 - Grey) ---
base1 (table) { Q:"t(0 .3 .07)", shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], contact:1 }
base1_handle (base1) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } } 

# --- 2. 第一层支撑 (菱形: Back, Front, Left, Right) ---
# Base Center y=0.3. 
# Back: y=0.42, Front: y=0.18, Left: x=-0.15, Right: x=0.15

cyl1 (table) { Q:"t(0 0.42 0.14)", shape:cylinder, size:[.1 .04], color:[0 .8 0] }      # Green (Back)
cyl2 (table) { Q:"t(0 0.18 0.14)", shape:cylinder, size:[.1 .04], color:[1 .9 0] }      # Yellow (Front)
cyl3 (table) { Q:"t(-0.15 0.3 0.14)", shape:cylinder, size:[.1 .04], color:[0 .9 .9] }  # Cyan (Left)
cyl4 (table) { Q:"t(0.15 0.3 0.14)", shape:cylinder, size:[.1 .04], color:[.9 0 .9] }   # Magenta (Right)

# --- 3. 中层板 (Base2 - Red) ---
base2 (table) { Q:"t(0 0.3 0.20)", shape:ssBox, size:[.5 .4 .04 .002], color:[.9 .1 .1] }
base2_handle (base2) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } } 
# --- 4. 第二层支撑 (菱形: Back, Front, Left, Right) ---
# 坐标逻辑同第一层，Z轴提升至 0.27

cyl5 (table) { Q:"t(0 0.42 0.27)", shape:cylinder, size:[.1 .04], color:[1 .5 0] }      # Orange (Back)
cyl6 (table) { Q:"t(0 0.18 0.27)", shape:cylinder, size:[.1 .04], color:[.5 0 .8] }     # Purple (Front)
cyl7 (table) { Q:"t(-0.15 0.3 0.27)", shape:cylinder, size:[.1 .04], color:[1 .4 .7] }  # Pink (Left)
cyl8 (table) { Q:"t(0.15 0.3 0.27)", shape:cylinder, size:[.1 .04], color:[.6 .3 .1] }  # Chocolate (Right)

# --- 5. 顶层板 (Base3 - Blue) ---
base3 (table) { Q:"t(0 0.3 0.34)", shape:ssBox, size:[.5 .4 .04 .002], color:[.1 .1 .9] }
base3_handle (base3) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } } 
