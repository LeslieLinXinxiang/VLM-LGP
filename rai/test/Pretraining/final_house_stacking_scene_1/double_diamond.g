# test_scene_2.g
# 描述: 双层菱形结构 (Double Diamond Structure)
# 考察: "4-Point Stability" 和 "Cardinal Directions" (前后左右) 的识别
# 布局: 每层4个圆柱，呈菱形分布 (北/南/西/东)

world {}

table (world) { shape:ssBox, size:[2. 2. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1 }

# --- 1. 地基 (Base1 - Grey) ---
base1 (table) { Q:"t(0 .3 .07)", shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], contact:1 }
base1_handle (base1) { Q:"t(0 0 .05)", color:[0 0 0 0] }

# --- 2. 第一层支撑 (菱形: Back, Front, Left, Right) ---
# Base Center y=0.3. 
# Back: y=0.42, Front: y=0.18, Left: x=-0.15, Right: x=0.15

cyl1 (table) { Q:"t(0 0.42 0.14)", shape:cylinder, size:[.1 .04], color:[0 .8 0] }      # Green (Back)
cyl2 (table) { Q:"t(0 0.18 0.14)", shape:cylinder, size:[.1 .04], color:[1 .9 0] }      # Yellow (Front)
cyl3 (table) { Q:"t(-0.15 0.3 0.14)", shape:cylinder, size:[.1 .04], color:[0 .9 .9] }  # Cyan (Left)
cyl4 (table) { Q:"t(0.15 0.3 0.14)", shape:cylinder, size:[.1 .04], color:[.9 0 .9] }   # Magenta (Right)

# --- 3. 中层板 (Base2 - Red) ---
base2 (table) { Q:"t(0 0.3 0.20)", shape:ssBox, size:[.5 .4 .04 .002], color:[.9 .1 .1] }
base2_handle (base2) { Q:"t(0 0 .05)", color:[0 0 0 0] }

# --- 4. 第二层支撑 (菱形: Back, Front, Left, Right) ---
# 坐标逻辑同第一层，Z轴提升至 0.27

cyl5 (table) { Q:"t(0 0.42 0.27)", shape:cylinder, size:[.1 .04], color:[1 .5 0] }      # Orange (Back)
cyl6 (table) { Q:"t(0 0.18 0.27)", shape:cylinder, size:[.1 .04], color:[.5 0 .8] }     # Purple (Front)
cyl7 (table) { Q:"t(-0.15 0.3 0.27)", shape:cylinder, size:[.1 .04], color:[1 .4 .7] }  # Pink (Left)
cyl8 (table) { Q:"t(0.15 0.3 0.27)", shape:cylinder, size:[.1 .04], color:[.6 .3 .1] }  # Chocolate (Right)

# --- 5. 顶层板 (Base3 - Blue) ---
base3 (table) { Q:"t(0 0.3 0.34)", shape:ssBox, size:[.5 .4 .04 .002], color:[.1 .1 .9] }
base3_handle (base3) { Q:"t(0 0 .05)", color:[0 0 0 0] }
