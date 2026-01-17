# test_scene_2.g
# 描述: 交错三角结构 (3+3结构)
# 考察: "Tripod Stability Rule" 和 "Center" 方位的识别

world {}

table (world) { shape:ssBox, size:[2. 2. .1 .02], Q:"t(0 0 .6)", color:[.3 .3 .3], contact:1 }

# --- 1. 地基 (Base1 - Grey) ---
base1 (table) { Q:"t(0 .3 .07)", shape:ssBox, size:[.5 .4 .04 .002], color:[.8 .8 .8], contact:1 }
base1_handle (base1) { Q:"t(0 0 .035)", shape:ssBox, size:[.04 .04 .04 .002], color:[.5 .5 .5], contact:1, mass:.2, logical:{ is_object } } 


