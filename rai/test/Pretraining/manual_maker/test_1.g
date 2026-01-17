# test_scene_2.g
# 描述: 交错三角结构 (3+3结构)
# 考察: "Tripod Stability Rule" 和 "Center" 方位的识别

world {}

table (world) { shape:ssBox, size:[2. 2. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1 }

# --- 1. 地基 (Base1 - Grey) ---
base1 (table) { Q:"t(0 .3 .07)", shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], contact:1 }
base1_handle (base1) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } } 

# --- 2. 第一层支撑 (倒三角: 2 Back + 1 FrontCenter) ---
# FrontCenter: x=0, y=0.2 (相对于base中心 y=0.3, 前移0.1)
cyl1 (table) { Q:"t(-0.15 0.4 0.14)", shape:cylinder, size:[.1 .04], color:[0 .8 0] }   # Green (BackLeft)
cyl2 (table) { Q:"t(0.15 0.4 0.14)", shape:cylinder, size:[.1 .04], color:[1 .9 0] }    # Yellow (BackRight)
cyl3 (table) { Q:"t(0 0.2 0.14)", shape:cylinder, size:[.1 .04], color:[.6 .3 .1] }     # Chocolate (FrontCenter)

# --- 3. 中层板 (Base2 - Red) ---
base2 (table) { Q:"t(0 0.3 0.20)", shape:ssBox, size:[.5 .4 .04 .002], color:[.9 .1 .1] }
base2_handle (base2) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } } 

# --- 4. 第二层支撑 (正三角: 2 Front + 1 BackCenter) ---
# BackCenter: x=0, y=0.4 (相对于base中心 y=0.3, 后移0.1)
cyl4 (table) { Q:"t(-0.15 0.2 0.27)", shape:cylinder, size:[.1 .04], color:[0 .9 .9] }  # Cyan (FrontLeft)
cyl5 (table) { Q:"t(0.15 0.2 0.27)", shape:cylinder, size:[.1 .04], color:[.9 0 .9] }   # Magenta (FrontRight)
cyl6 (table) { Q:"t(0 0.4 0.27)", shape:cylinder, size:[.1 .04], color:[1 .5 0] }       # Orange (BackCenter)

# --- 5. 顶层板 (Base3 - Blue) ---
base3 (table) { Q:"t(0 0.3 0.34)", shape:ssBox, size:[.5 .4 .04 .002], color:[.1 .1 .9] }
base3_handle (base3) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } } 

# 剩余未使用的圆柱 (放在旁边作为干扰项)
#cyl7 (table) { Q:"t(-0.5 0 0.085)", shape:cylinder, size:[.07 .03], color:[.5 0 .8] }   # Purple
#cyl8 (table) { Q:"t(-0.6 0 0.085)", shape:cylinder, size:[.07 .03], color:[1 .4 .7] }   # Pink
