# test_scene_3.g
# 描述: 菱形布局与非对称支撑 (5+3结构)
# 考察: "Left/Right Center" 识别以及对不同密度支撑的处理

world {}

table (world) { shape:ssBox, size:[2. 2. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1 }

# --- 1. 地基 (Base1 - Grey) ---
base1 (table) { Q:"t(0 .3 .07)", shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], contact:1 }
base1_handle (base1) { Q:"t(0 0 .05)", color:[0 0 0 0] }

# --- 2. 第一层支撑 (菱形布局 4个 + 1个中心) ---
# Front(0, 0.2), Back(0, 0.4), Left(-0.15, 0.3), Right(0.15, 0.3)
# 注意：Handle通常在(0,0.3,Z)，如果Center放圆柱会穿模Handle。
# 但我们在Base定义里把Handle设为不可见且接触可能被忽略，或者我们假设这是一个空心圆柱套在Handle外。
# 这里为了物理安全，我们微调Center位置或者去掉Center，改成纯菱形。
# 采用纯菱形布局 (4个):
cyl1 (table) { Q:"t(0 0.2 0.14)", shape:cylinder, size:[.1 .04], color:[0 .8 0] }       # Green (Front-Center)
cyl2 (table) { Q:"t(0 0.4 0.14)", shape:cylinder, size:[.1 .04], color:[1 .9 0] }       # Yellow (Back-Center)
cyl3 (table) { Q:"t(-0.15 0.3 0.14)", shape:cylinder, size:[.1 .04], color:[0 .9 .9] }  # Cyan (Left-Center)
cyl4 (table) { Q:"t(0.15 0.3 0.14)", shape:cylinder, size:[.1 .04], color:[.9 0 .9] }   # Magenta (Right-Center)

# --- 3. 中层板 (Base2 - Red) ---
base2 (table) { Q:"t(0 0.3 0.20)", shape:ssBox, size:[.5 .4 .04 .002], color:[.9 .1 .1] }
base2_handle (base2) { Q:"t(0 0 .05)", color:[0 0 0 0] }

# --- 4. 第二层支撑 (U型/三点支撑: Left, Right, Back) ---
# 这种结构也是稳定的
cyl5 (table) { Q:"t(-0.15 0.3 0.27)", shape:cylinder, size:[.1 .04], color:[1 .5 0] }   # Orange (Left-Center)
cyl6 (table) { Q:"t(0.15 0.3 0.27)", shape:cylinder, size:[.1 .04], color:[.5 0 .8] }   # Purple (Right-Center)
cyl7 (table) { Q:"t(0 0.4 0.27)", shape:cylinder, size:[.1 .04], color:[1 .4 .7] }      # Pink (Back-Center)

# --- 5. 顶层板 (Base3 - Blue) ---
base3 (table) { Q:"t(0 0.3 0.34)", shape:ssBox, size:[.5 .4 .04 .002], color:[.1 .1 .9] }
base3_handle (base3) { Q:"t(0 0 .05)", color:[0 0 0 0] }

# 剩余干扰项
cyl8 (table) { Q:"t(-0.5 0 0.085)", shape:cylinder, size:[.07 .03], color:[.6 .3 .1] }  # Chocolate
